#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.05cm,{ import cetz.draw: *
  content((0,9),text(size:22pt,weight:"bold")[EDITORIAL TYPE SYSTEM])
  content((0,8.5),text(size:9pt,fill:rgb("#7f9db2"))[A MODULAR SCALE WITH ROLES, MEASURES, AND BASELINE RHYTHM])
  for y in range(0,17) { line((0,.7+y*.42),(14,.7+y*.42),stroke:(paint:rgb("#5e789022"),thickness:.45pt)) }
  content((0,6.9),text(size:32pt,weight:"bold")[The shape of evidence])
  content((0,5.85),text(size:18pt,weight:"semibold",fill:rgb("#54d6c6"))[Display / 42 · 48])
  content((0,4.85),text(size:14pt,weight:"semibold")[A field guide to visual reasoning])
  content((0,4.2),text(size:9pt,fill:rgb("#7b9cff"))[HEADING 02 / 18 · 24 / +1%])
  content((0,3.25),text(size:10pt)[A clear hierarchy lets readers scan the claim, inspect the evidence,])
  content((0,2.75),text(size:10pt)[and recover the method without losing the thread of the argument.])
  content((0,2.05),text(size:8pt,fill:rgb("#8ba6b9"))[BODY / 13 · 19 / 68 CH  ·  MUTED / 11 · 16])
  let sizes=(8,10,12,14,18,24,32); for i in range(0,7) { circle((8.3+i*.78,6.2),radius:sizes.at(i)/80,fill:rgb(("#54d6c6","#7b9cff","#b889ff","#ff6f91","#ffd166","#54d6c6","#7b9cff").at(i)),stroke:none); content((8.15+i*.78,5.3),text(size:6pt)[#sizes.at(i)]) }
  rect((8.1,1.45),(13.8,3.75),radius:.12,fill:rgb("#172a43"),stroke:(paint:rgb("#52758c"),thickness:1pt)); content((8.5,3.25),text(size:8pt,fill:rgb("#ff6f91"))[TOKEN CONTRACT]); content((8.5,2.7),text(size:7pt)[display-xl  42/48  700]); content((8.5,2.2),text(size:7pt)[body-md     13/19  400]); content((8.5,1.7),text(size:7pt)[label-sm    11/16  600])
})
