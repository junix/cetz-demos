#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 24pt, fill: none)
#set text(font: "Avenir Next", fill: rgb("#dcebf5"))

#cetz.canvas(length: 1.25cm, {
  import cetz.draw: *
  content((0, 7.2), text(size: 22pt, weight: "bold")[SEMANTIC VISUAL COMPILER])
  content((0, 6.68), text(size: 9pt, fill: rgb("#7f9db2"))[INTENT → INTERMEDIATE REPRESENTATION → RENDERERS])
  line((0, 6.38), (5.1, 6.38), stroke: (paint: rgb("#52758c"), thickness: 0.8pt))
  let nodes = (
    ((0.2, 3.2), (2.6, 1.1), [Intent], rgb("#173f3e"), rgb("#54d6c6")),
    ((4.2, 3.2), (3.3, 1.1), [Visualization IR], rgb("#29345c"), rgb("#7b9cff")),
    ((9.2, 5.0), (2.5, 1.0), [SVG / D3], rgb("#48263b"), rgb("#ff6f91")),
    ((9.2, 3.2), (2.5, 1.0), [PNG / PDF], rgb("#4b3e1b"), rgb("#ffd166")),
    ((9.2, 1.4), (2.5, 1.0), [WebGL / Video], rgb("#34264c"), rgb("#b889ff")),
  )
  for n in nodes {
    rect(n.at(0), (n.at(0).at(0) + n.at(1).at(0), n.at(0).at(1) + n.at(1).at(1)), radius: 0.16, fill: n.at(3), stroke: (paint: n.at(4), thickness: 1.3pt))
    content((n.at(0).at(0) + n.at(1).at(0)/2, n.at(0).at(1) + n.at(1).at(1)/2), anchor: "center", text(size: 10pt, weight: "semibold")[#n.at(2)])
  }
  line((2.8, 3.75), (4.0, 3.75), mark: (end: ">"), stroke: (paint: rgb("#54d6c6"), thickness: 1.8pt))
  line((7.5, 3.75), (8.4, 3.75), (8.4, 5.5), (9.0, 5.5), mark: (end: ">"), stroke: (paint: rgb("#ff6f91"), thickness: 1.4pt))
  line((7.5, 3.75), (9.0, 3.75), mark: (end: ">"), stroke: (paint: rgb("#ffd166"), thickness: 1.4pt))
  line((7.5, 3.75), (8.4, 3.75), (8.4, 1.9), (9.0, 1.9), mark: (end: ">"), stroke: (paint: rgb("#b889ff"), thickness: 1.4pt))
  content((4.3, 1.55), text(size: 8pt, fill: rgb("#8ba6b9"))[MARKS  •  SCALES  •  LAYOUT  •  STYLE])
  for i in range(0, 12) {
    circle((4.45 + i * 0.24, 1.05), radius: 0.045 + calc.rem(i, 3) * 0.02, fill: rgb("#7b9cff").transparentize(28%), stroke: none)
  }
})
