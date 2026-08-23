#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 24pt, fill: none)
#set text(font: "Avenir Next", fill: rgb("#dcebf5"))

#cetz.canvas(length: 1.25cm, {
  import cetz.draw: *
  content((0, 7.5), text(size: 22pt, weight: "bold")[PHASE FIELD / LIMIT CYCLE])
  content((0, 6.98), text(size: 9pt, fill: rgb("#7f9db2"))[A DYNAMICAL SYSTEM PORTRAIT])
  for i in range(-6, 7) {
    line((i, -3.7), (i, 5.8), stroke: (paint: rgb("#5e789033"), thickness: 0.45pt))
  }
  for j in range(-4, 7) {
    line((-6.4, j), (6.4, j), stroke: (paint: rgb("#5e789033"), thickness: 0.45pt))
  }
  line((-6.4, 0), (6.5, 0), mark: (end: ">"), stroke: (paint: rgb("#a8bdcc"), thickness: 1pt))
  line((0, -3.8), (0, 5.9), mark: (end: ">"), stroke: (paint: rgb("#a8bdcc"), thickness: 1pt))
  for ring in range(1, 7) {
    let rr = 0.55 + ring * 0.45
    circle((0, 1.0), radius: rr, stroke: (paint: rgb("#54d6c6").transparentize(48%), thickness: 0.7pt + ring * 0.08pt))
  }
  circle((0, 1.0), radius: 2.75, stroke: (paint: rgb("#ffd166"), thickness: 2pt))
  for k in range(0, 28) {
    let angle = k * 360deg / 28
    let rr = 3.25 + calc.sin(angle * 3) * 0.6
    let x = calc.cos(angle) * rr
    let y = 1.0 + calc.sin(angle) * rr
    let tx = calc.cos(angle + 16deg) * (rr - 0.28)
    let ty = 1.0 + calc.sin(angle + 16deg) * (rr - 0.28)
    line((x, y), (tx, ty), mark: (end: ">"), stroke: (paint: rgb("#7b9cff").transparentize(45%), thickness: 0.8pt))
  }
  circle((0, 1.0), radius: 0.12, fill: rgb("#ff6f91"), stroke: none)
  content((3.7, 4.9), text(size: 9pt, fill: rgb("#ffd166"))[stable limit cycle])
  line((3.5, 4.55), (2.1, 3.2), stroke: (paint: rgb("#ffd166"), thickness: 0.8pt))
})
