import contextlib
import concurrent.futures
import io
import os
import subprocess
import tempfile
import threading
import unittest
from pathlib import Path
from unittest import mock

from PIL import Image, UnidentifiedImageError

from tools import render


def png_bytes(color, background=(0, 0, 0, 0)):
    with Image.new("RGBA", (80, 80), background) as image:
        image.paste(color, (20, 20, 60, 60))
        data = io.BytesIO()
        image.save(data, format="PNG")
        return data.getvalue()


class RenderTests(unittest.TestCase):
    def setUp(self):
        temp = self.enterContext(tempfile.TemporaryDirectory())
        self.root = Path(temp)
        self.out = self.root / "out"
        self.out.mkdir()
        (self.root / "src").mkdir()
        self.scenes = tuple(f"scene-{index}" for index in range(12))
        self.old = png_bytes((0, 0, 255, 255))
        self.new = png_bytes((255, 0, 0, 255))
        for scene in self.scenes:
            (self.root / "src" / f"{scene}.typ").write_text("fixture")
            self.output(scene).write_bytes(self.old)
        self.unrelated = self.out / ".another-render.png"
        self.unrelated.write_bytes(b"another invocation owns this")
        self.original_names = set(self.out.iterdir())
        self.enterContext(
            mock.patch.multiple(
                render, ROOT=self.root, OUT=self.out, SCENES=self.scenes
            )
        )
        self.enterContext(
            mock.patch.object(render.shutil, "which", return_value="typst")
        )

    def output(self, scene="scene-0"):
        return self.out / f"{scene}-transparent.png"

    def run_renderer(self, compile):
        with mock.patch.object(render.subprocess, "run", side_effect=compile):
            with contextlib.redirect_stdout(io.StringIO()) as stdout:
                render.main()
        return stdout.getvalue()

    def assert_preserved(self):
        self.assertEqual(self.output().read_bytes(), self.old)
        self.assertEqual(set(self.out.iterdir()), self.original_names)
        self.assertEqual(self.unrelated.read_bytes(), b"another invocation owns this")

    def test_partial_compiler_failure_preserves_previous_image(self):
        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(b"partial compiler output")
            raise subprocess.CalledProcessError(7, args)

        with self.assertRaises(subprocess.CalledProcessError) as error:
            self.run_renderer(compile)
        self.assertEqual(error.exception.returncode, 7)
        self.assert_preserved()

    def test_failed_first_render_does_not_publish_a_new_file(self):
        self.output().unlink()
        names = set(self.out.iterdir())

        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(b"partial")
            raise subprocess.CalledProcessError(7, args)

        with self.assertRaises(subprocess.CalledProcessError):
            self.run_renderer(compile)
        self.assertFalse(self.output().exists())
        self.assertEqual(set(self.out.iterdir()), names)

    def test_later_failure_preserves_unpublished_neighbors(self):
        def compile(args, **kwargs):
            if Path(args[-2]).stem == self.scenes[1]:
                Path(args[-1]).write_bytes(b"partial")
                raise subprocess.CalledProcessError(7, args)
            Path(args[-1]).write_bytes(self.new)

        with self.assertRaises(subprocess.CalledProcessError):
            self.run_renderer(compile)
        self.assertEqual(self.output().read_bytes(), self.new)
        for scene in self.scenes[1:]:
            self.assertEqual(self.output(scene).read_bytes(), self.old)
        self.assertEqual(set(self.out.iterdir()), self.original_names)

    def test_corrupt_image_preserves_previous_image(self):
        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(b"not a PNG")

        with self.assertRaises(UnidentifiedImageError):
            self.run_renderer(compile)
        self.assert_preserved()

    def test_weak_rgba_preserves_previous_image(self):
        images = {
            "invisible": png_bytes((0, 0, 0, 0)),
            "achromatic": png_bytes((100, 100, 100, 255)),
            "opaque": png_bytes((255, 0, 0, 255), (255, 0, 0, 255)),
        }
        for name, data in images.items():
            with self.subTest(image=name):
                self.output().write_bytes(self.old)

                def compile(args, **kwargs):
                    Path(args[-1]).write_bytes(data)

                with self.assertRaisesRegex(SystemExit, "scene-0: weak RGBA output"):
                    self.run_renderer(compile)
                self.assert_preserved()

    def test_compilation_never_exposes_unvalidated_bytes(self):
        stages = []

        def compile(args, *, check, cwd):
            self.assertEqual(args[:4], ["typst", "compile", "--ppi", "190"])
            self.assertTrue(check)
            self.assertEqual(cwd, self.root)
            stage = Path(args[-1])
            target = self.output(Path(args[-2]).stem)
            stage.write_bytes(b"partial")
            self.assertEqual(target.read_bytes(), self.old)
            self.assertEqual(stage.parent, self.out)
            self.assertEqual(stage.suffix, ".png")
            stages.append(stage)
            stage.write_bytes(self.new)

        output = self.run_renderer(compile)
        self.assertEqual(len(output.splitlines()), 12)
        self.assertEqual(len(set(stages)), 12)
        self.assertEqual(set(self.out.iterdir()), self.original_names)
        for scene in self.scenes:
            self.assertEqual(self.output(scene).read_bytes(), self.new)

    def test_publication_failure_preserves_previous_image(self):
        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(self.new)

        with mock.patch.object(
            render.os, "replace", side_effect=PermissionError("fixture")
        ):
            with self.assertRaisesRegex(PermissionError, "fixture"):
                self.run_renderer(compile)
        self.assert_preserved()

    def test_success_replaces_inode_without_changing_open_readers(self):
        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(self.new)

        replace = os.replace
        published = []

        def publish(source, destination):
            self.assertEqual(source.read_bytes(), self.new)
            self.assertEqual(destination.read_bytes(), self.old)
            published.append(source)
            replace(source, destination)

        inode = self.output().stat().st_ino
        with self.output().open("rb") as reader:
            with mock.patch.object(render.os, "replace", side_effect=publish):
                self.run_renderer(compile)
            self.assertEqual(reader.read(), self.old)
        self.assertNotEqual(self.output().stat().st_ino, inode)
        self.assertEqual(self.output().read_bytes(), self.new)
        self.assertEqual(len(published), 12)
        self.assertTrue(all(not path.exists() for path in published))

    def test_temporary_creation_failure_does_not_change_outputs(self):
        with mock.patch.object(
            render.tempfile, "mkstemp", side_effect=OSError("no space")
        ):
            with self.assertRaisesRegex(OSError, "no space"):
                self.run_renderer(lambda *args, **kwargs: self.fail("compiler ran"))
        self.assert_preserved()

    def test_cleanup_failure_keeps_original_error_and_only_owned_leftover(self):
        stages = []

        def compile(args, **kwargs):
            stage = Path(args[-1])
            stages.append(stage)
            stage.write_bytes(b"partial")
            raise subprocess.CalledProcessError(7, args)

        with mock.patch.object(
            Path, "unlink", side_effect=PermissionError("cleanup denied")
        ):
            with self.assertRaises(subprocess.CalledProcessError) as error:
                self.run_renderer(compile)
        self.assertEqual(error.exception.returncode, 7)
        self.assertIn("cleanup denied", error.exception.__notes__[0])
        self.assertEqual(set(self.out.iterdir()), self.original_names | set(stages))
        self.assertEqual(stages[0].read_bytes(), b"partial")
        self.assertEqual(self.output().read_bytes(), self.old)

    def test_concurrent_failure_cleans_only_its_own_temporary_file(self):
        both_started = threading.Barrier(2)
        failure_cleaned = threading.Event()
        local = threading.local()
        stages = []
        stages_lock = threading.Lock()

        def compile(args, **kwargs):
            stage = Path(args[-1])
            with stages_lock:
                self.assertNotIn(stage, stages)
                stages.append(stage)
            self.assertTrue(stage.is_file())
            stage.write_bytes(b"partial")
            if Path(args[-2]).stem == self.scenes[0]:
                self.assertEqual(self.output().read_bytes(), self.old)
                both_started.wait(timeout=5)
                if local.fail:
                    raise subprocess.CalledProcessError(7, args)
                self.assertTrue(failure_cleaned.wait(timeout=5))
                self.assertEqual(stage.read_bytes(), b"partial")
            stage.write_bytes(self.new)

        def invoke(fail):
            local.fail = fail
            try:
                render.main()
            finally:
                if fail:
                    failure_cleaned.set()

        with mock.patch.object(render.subprocess, "run", side_effect=compile):
            with contextlib.redirect_stdout(io.StringIO()):
                with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
                    failed = pool.submit(invoke, True)
                    succeeded = pool.submit(invoke, False)
                    with self.assertRaises(subprocess.CalledProcessError):
                        failed.result(timeout=10)
                    succeeded.result(timeout=10)
        self.assertEqual(len(stages), 13)
        self.assertEqual(set(self.out.iterdir()), self.original_names)
        for scene in self.scenes:
            self.assertEqual(self.output(scene).read_bytes(), self.new)

    def test_replacing_final_symlink_preserves_its_target(self):
        target = self.root / "external.png"
        target.write_bytes(self.old)
        self.output().unlink()
        self.output().symlink_to(target)

        def compile(args, **kwargs):
            Path(args[-1]).write_bytes(self.new)

        self.run_renderer(compile)
        self.assertFalse(self.output().is_symlink())
        self.assertEqual(target.read_bytes(), self.old)
        self.assertEqual(self.output().read_bytes(), self.new)


if __name__ == "__main__":
    unittest.main()
