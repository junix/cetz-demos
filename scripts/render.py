from __future__ import annotations

import json
import shutil
import subprocess
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "out"
SCENES = ("geometric_proof", "phase_field", "system_map")


def main() -> None:
    typst = shutil.which("typst")
    if not typst:
        raise SystemExit("typst is required")
    OUT.mkdir(exist_ok=True)
    for scene in SCENES:
        source = ROOT / "sources" / f"{scene}.typ"
        output = OUT / f"{scene}-transparent.png"
        subprocess.run([typst, "compile", "--ppi", "190", str(source), str(output)], check=True, cwd=ROOT)
        image = Image.open(output).convert("RGBA")
        alpha = image.getchannel("A").histogram()
        pixels = image.width * image.height
        transparent = alpha[0]
        visible = pixels - sum(alpha[:16])
        colors = image.getcolors(maxcolors=pixels) or []
        colorful = sum(count for count, rgba in colors if rgba[3] > 16 and max(rgba[:3]) - min(rgba[:3]) > 24)
        if transparent < pixels * 0.05 or visible < pixels * 0.025 or colorful < 1000:
            raise SystemExit(f"{scene}: weak RGBA output t={transparent} v={visible} c={colorful}")
        print(json.dumps({"scene": scene, "size": image.size, "transparent_pct": round(100*transparent/pixels, 1), "visible_pct": round(100*visible/pixels, 1), "colorful": colorful}))


if __name__ == "__main__":
    main()
