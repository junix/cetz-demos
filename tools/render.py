from __future__ import annotations

import json
import os
import shutil
import subprocess
import tempfile
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "out"
CATALOG = json.loads((ROOT / "catalog.json").read_text())
SCENES = tuple(item["id"] for item in CATALOG)


def main() -> None:
    if len(SCENES) < 12 or len(set(SCENES)) != len(SCENES):
        raise SystemExit("catalog must contain at least 12 unique scenes")
    typst = shutil.which("typst")
    if not typst:
        raise SystemExit("typst is required")
    OUT.mkdir(exist_ok=True)
    for scene in SCENES:
        source = ROOT / "src" / f"{scene}.typ"
        output = OUT / f"{scene}-transparent.png"
        # The exclusive, same-directory file belongs only to this invocation.
        fd, name = tempfile.mkstemp(prefix=f".{scene}-", suffix=".png", dir=OUT)
        temporary = Path(name)
        try:
            os.close(fd)
            subprocess.run(
                [typst, "compile", "--ppi", "190", str(source), str(temporary)],
                check=True,
                cwd=ROOT,
            )
            with (
                Image.open(temporary) as source_image,
                source_image.convert("RGBA") as image,
            ):
                alpha = image.getchannel("A").histogram()
                pixels = image.width * image.height
                transparent = alpha[0]
                visible = pixels - sum(alpha[:16])
                colors = image.getcolors(maxcolors=pixels) or []
                colorful = sum(
                    count
                    for count, rgba in colors
                    if rgba[3] > 16 and max(rgba[:3]) - min(rgba[:3]) > 24
                )
                if (
                    transparent < pixels * 0.05
                    or visible < pixels * 0.025
                    or colorful < 1000
                ):
                    raise SystemExit(
                        f"{scene}: weak RGBA output t={transparent} v={visible} c={colorful}"
                    )
                report = {
                    "scene": scene,
                    "size": image.size,
                    "transparent_pct": round(100 * transparent / pixels, 1),
                    "visible_pct": round(100 * visible / pixels, 1),
                    "colorful": colorful,
                }
            # Publish the original compiler bytes only after decoding and checks.
            os.replace(temporary, output)
        except BaseException as error:
            try:
                temporary.unlink(missing_ok=True)
            except OSError as cleanup_error:
                error.add_note(
                    f"could not remove temporary image {temporary}: {cleanup_error}"
                )
            raise
        print(json.dumps(report))


if __name__ == "__main__":
    main()
