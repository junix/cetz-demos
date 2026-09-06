# CeTZ Demos

Document-native vector drawing with Typst and CeTZ 0.5.2 across twelve reference scenarios. Every source is typography-aware, reproducible, and compiled directly to a transparent PNG.

Browse every demo with its source in **[gallery.html](gallery.html)** — searchable, follows your light/dark theme.

`catalog.json` records the educational/design use, question, visual family, complexity, and tags.

| Geometry proof | Phase field | System map | Neural architecture |
|---|---|---|---|
| ![geometry](out/geometric_proof-transparent.png) | ![phase](out/phase_field-transparent.png) | ![system](out/system_map-transparent.png) | ![neural architecture](out/neural_architecture-transparent.png) |
| Orbital mechanics | Circuit | Bézier anatomy | Roadmap |
| ![orbit](out/orbital_mechanics-transparent.png) | ![circuit](out/circuit_schematic-transparent.png) | ![bezier](out/bezier_anatomy-transparent.png) | ![timeline](out/timeline_roadmap-transparent.png) |
| Matrix transforms | Topography | Molecule | Type scale |
| ![matrix](out/matrix_transforms-transparent.png) | ![topography](out/topographic_map-transparent.png) | ![molecule](out/molecule-transparent.png) | ![type scale](out/type_scale-transparent.png) |

```bash
uv sync
uv run python tools/render.py
```

The renderer invokes the installed Typst compiler and rejects outputs that lack transparent, visible, or chromatic pixels.
