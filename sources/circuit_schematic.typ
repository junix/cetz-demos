#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.2cm,{ import cetz.draw: *
  content((0,7),text(size:22pt,weight:"bold")[LOW-NOISE SENSOR FRONT END])
  content((0,6.5),text(size:9pt,fill:rgb("#7f9db2"))[PROTECTION · INSTRUMENTATION AMPLIFIER · ACTIVE FILTER · ADC])
  line((0,3.4),(13.2,3.4),stroke:(paint:rgb("#8fa9bc"),thickness:1.4pt))
  circle((.5,3.4),radius:.36,stroke:(paint:rgb("#54d6c6"),thickness:1.4pt)); content((.05,2.7),text(size:7pt)[SENSOR])
  line((1.2,2.7),(1.2,4.1),(1.65,3.4),(1.2,2.7),stroke:(paint:rgb("#ff6f91"),thickness:1.2pt)); line((1.72,2.65),(1.72,4.15),stroke:(paint:rgb("#ff6f91"),thickness:1.2pt))
  rect((2.5,2.45),(5.0,4.35),radius:.12,fill:rgb("#29345c"),stroke:(paint:rgb("#7b9cff"),thickness:1.4pt)); content((3.75,3.4),anchor:"center",text(size:8pt,weight:"bold")[INA · G=48])
  for x in (5.6,6.7,7.8) { line((x,2.8),(x,4.0),stroke:(paint:rgb("#ffd166"),thickness:1.4pt)); line((x+.18,2.8),(x+.18,4.0),stroke:(paint:rgb("#ffd166"),thickness:1.4pt)) }
  rect((8.6,2.45),(10.8,4.35),radius:.12,fill:rgb("#173f3e"),stroke:(paint:rgb("#54d6c6"),thickness:1.4pt)); content((9.7,3.4),anchor:"center",text(size:8pt,weight:"bold")[4th ORDER LPF])
  rect((11.5,2.45),(13.2,4.35),radius:.12,fill:rgb("#48263b"),stroke:(paint:rgb("#ff6f91"),thickness:1.4pt)); content((12.35,3.4),anchor:"center",text(size:8pt,weight:"bold")[24-bit ADC])
  for x in (2.2,5.3,8.3,11.2,13.45) { circle((x,3.4),radius:.06,fill:rgb("#dcebf5"),stroke:none) }
  content((2.5,1.6),text(size:7pt,fill:rgb("#8ba6b9"))[noise budget  8.2 nV/√Hz]); content((8.6,1.6),text(size:7pt,fill:rgb("#8ba6b9"))[fc  42 Hz  ·  ENOB  20.1])
})
