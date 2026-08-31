#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.18cm,{ import cetz.draw: *
  content((-6,7),text(size:22pt,weight:"bold")[ALPINE CATCHMENT TOPOGRAPHY])
  content((-6,6.5),text(size:9pt,fill:rgb("#7f9db2"))[20 M CONTOURS · RIDGELINES · DRAINAGE · SURVEY CONTROL])
  for ring in range(1,13) { let rx=.55+ring*.42; let ry=.35+ring*.29; circle((0,0),radius:(rx,ry),stroke:(paint:rgb("#54d6c6").transparentize(18% + ring * 4%),thickness:.55pt+ring*.05pt)) }
  for ring in range(1,8) { circle((-2.5,1.5),radius:(.4+ring*.31,.25+ring*.23),stroke:(paint:rgb("#7b9cff").transparentize(35%),thickness:.7pt)) }
  line((-5,3.8),(-3.5,2.7),(-2.4,1.0),(-.9,.4),(.2,-.7),(2.1,-1.8),(4.8,-3.2),stroke:(paint:rgb("#7b9cff"),thickness:1.8pt))
  line((-1.2,4.0),(-.5,2.1),(.2,.8),stroke:(paint:rgb("#7b9cff"),thickness:1pt)); line((3.8,2.8),(2.3,1.4),(.4,-.5),stroke:(paint:rgb("#7b9cff"),thickness:1pt))
  for p in ((-4,2.8),(0,0),(3.2,1.8),(-1.5,-2.4)) { circle(p,radius:.1,fill:rgb("#ff6f91"),stroke:none); line((p.at(0) - .25,p.at(1)),(p.at(0) + .25,p.at(1)),stroke:(paint:rgb("#ff6f91"),thickness:.7pt)); line((p.at(0),p.at(1) - .25),(p.at(0),p.at(1) + .25),stroke:(paint:rgb("#ff6f91"),thickness:.7pt)) }
  content((3.7,4.5),text(size:8pt,fill:rgb("#ffd166"))[summit 2,418 m]); line((3.5,4.2),(2.1,2.4),stroke:(paint:rgb("#ffd166"),thickness:.8pt))
})
