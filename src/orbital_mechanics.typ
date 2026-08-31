#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.22cm,{ import cetz.draw: *
  content((-6,6.8),text(size:22pt,weight:"bold")[HOHMANN TRANSFER GEOMETRY])
  content((-6,6.3),text(size:9pt,fill:rgb("#7f9db2"))[TWO IMPULSES · ENERGY CHANGE · RENDEZVOUS PHASE])
  for r in (1.8,3.9,5.3) { circle((0,0),radius:r,stroke:(paint:rgb("#5e7890").transparentize(35%),thickness:1pt)) }
  circle((0,0),radius:.55,fill:rgb("#ffd166"),stroke:(paint:rgb("#fff0bd"),thickness:1pt))
  circle((1.8,0),radius:.13,fill:rgb("#54d6c6"),stroke:none)
  circle((-3.9,0),radius:.16,fill:rgb("#7b9cff"),stroke:none)
  circle((-1.05,0),radius:2.85,stroke:(paint:rgb("#ff6f91"),thickness:2pt))
  line((1.8,0),(2.55,.55),mark:(end:">"),stroke:(paint:rgb("#54d6c6"),thickness:2pt))
  line((-3.9,0),(-3.9,1.0),mark:(end:">"),stroke:(paint:rgb("#7b9cff"),thickness:2pt))
  line((0,-5.6),(0,5.6),stroke:(paint:rgb("#5e789044"),dash:"dashed",thickness:.7pt))
  content((2.7,.55),text(size:8pt,fill:rgb("#54d6c6"))[Δv₁ injection])
  content((-5.8,.85),text(size:8pt,fill:rgb("#7b9cff"))[Δv₂ circularize])
  content((4.2,-3.9),text(size:8pt,fill:rgb("#8ba6b9"))[r₂ / r₁ = 2.17])
})
