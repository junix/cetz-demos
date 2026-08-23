# CeTZ Demos

Document-native vector drawing with Typst and CeTZ 0.5.2. Every source is typography-aware, reproducible, and compiled directly to a transparent PNG.

| Scene | Preview |
|---|---|
| Nine-point circle | ![geometry](out/geometric_proof-transparent.png) |
| Dynamical phase field | ![phase](out/phase_field-transparent.png) |
| Semantic visual compiler | ![system](out/system_map-transparent.png) |

```bash
uv sync
uv run python scripts/render.py
```

The renderer invokes the installed Typst compiler and rejects outputs that lack transparent, visible, or chromatic pixels.
