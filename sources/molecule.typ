#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.25cm,{ import cetz.draw: *
  content((0,7),text(size:22pt,weight:"bold")[CAFFEINE · STRUCTURE MAP])
  content((0,6.5),text(size:9pt,fill:rgb("#7f9db2"))[RING GEOMETRY · FUNCTIONAL GROUPS · ELECTRON DENSITY CUES])
  let pts=((2,3.3),(3.5,5.3),(6,5.0),(7,2.8),(5.4,1.1),(3,1.3),(8.9,4.1),(10.6,2.6),(9.6,.6))
  for e in ((0,1),(1,2),(2,3),(3,4),(4,5),(5,0),(2,6),(6,7),(7,8),(8,4),(3,7)) { line(pts.at(e.at(0)),pts.at(e.at(1)),stroke:(paint:rgb("#8fa9bc"),thickness:2pt)) }
  for e in ((0,1),(3,4),(6,7)) { let a=pts.at(e.at(0)); let b=pts.at(e.at(1)); line((a.at(0)+.14,a.at(1)),(b.at(0)+.14,b.at(1)),stroke:(paint:rgb("#ffd166"),thickness:.8pt)) }
  let labels=([N],[C],[N],[C],[N],[C],[O],[C],[O]); let colors=("#7b9cff","#dcebf5","#7b9cff","#dcebf5","#7b9cff","#dcebf5","#ff6f91","#dcebf5","#ff6f91")
  for i in range(0,9) { circle(pts.at(i),radius:.34,fill:rgb("#172a43"),stroke:(paint:rgb(colors.at(i)),thickness:1.5pt)); content(pts.at(i),anchor:"center",text(size:9pt,weight:"bold",fill:rgb(colors.at(i)))[#labels.at(i)]) }
  content((11.4,5.2),text(size:8pt,fill:rgb("#8ba6b9"))[C₈H₁₀N₄O₂]); content((11.4,4.5),text(size:8pt,fill:rgb("#54d6c6"))[molar mass 194.19])
})
