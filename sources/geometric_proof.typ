#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 24pt, fill: none)
#set text(font: "Avenir Next", fill: rgb("#dcebf5"))

#cetz.canvas(length: 1.3cm, {
  import cetz.draw: *
  content((0, 7.3), text(size: 22pt, weight: "bold")[THE NINE-POINT CIRCLE])
  content((0, 6.75), text(size: 9pt, fill: rgb("#7f9db2"))[A CONSTRUCTIVE GEOMETRY STUDY])
  line((0, 6.45), (4.2, 6.45), stroke: (paint: rgb("#52758c"), thickness: 0.8pt))
  let a = (1.0, 0.5)
  let b = (9.6, 1.2)
  let c = (5.4, 6.0)
  line(a, b, c, close: true, stroke: (paint: rgb("#8fa9bc"), thickness: 1.5pt))
  line(a, (5.3, 0.85), stroke: (paint: rgb("#ff6f91"), dash: "dashed", thickness: 1pt))
  line(b, (7.5, 3.6), stroke: (paint: rgb("#54d6c6"), dash: "dashed", thickness: 1pt))
  line(c, (3.2, 3.25), stroke: (paint: rgb("#ffd166"), dash: "dashed", thickness: 1pt))
  circle((5.32, 3.03), radius: 2.25, fill: rgb("#7b9cff22"), stroke: (paint: rgb("#7b9cff"), thickness: 1.8pt))
  for item in ((a, [A], rgb("#ff6f91")), (b, [B], rgb("#54d6c6")), (c, [C], rgb("#ffd166")), ((5.3, 0.85), [Mₐ], rgb("#ff6f91")), ((7.5, 3.6), [M_b], rgb("#54d6c6")), ((3.2, 3.25), [M_c], rgb("#ffd166"))) {
    circle(item.at(0), radius: 0.10, fill: item.at(2), stroke: none)
    content((item.at(0).at(0) + 0.18, item.at(0).at(1) + 0.16), text(size: 8pt, fill: item.at(2))[#item.at(1)])
  }
  content((10.1, 5.75), text(size: 8pt, fill: rgb("#8ba6b9"))[CONSTRUCTION])
  content((10.1, 5.25), text(size: 9pt)[1  Bisect each side])
  content((10.1, 4.72), text(size: 9pt)[2  Drop three altitudes])
  content((10.1, 4.19), text(size: 9pt)[3  Observe one circle])
})
