#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.15cm,{ import cetz.draw: *
  content((-1,7.2),text(size:22pt,weight:"bold")[CHAINED LINEAR TRANSFORMS])
  content((-1,6.7),text(size:9pt,fill:rgb("#7f9db2"))[BASIS · SHEAR · ROTATION · EIGENDIRECTIONS])
  for panel in range(0,3) {
    let ox = panel * 5
    for i in range(-2,3) {
      line((ox + i,-2),(ox + i,3),stroke:(paint:rgb("#5e789033"),thickness:.5pt))
      line((ox - 2,i + .5),(ox + 2,i + .5),stroke:(paint:rgb("#5e789033"),thickness:.5pt))
    }
    line((ox - 2,.5),(ox + 2.3,.5),mark:(end:">"),stroke:(paint:rgb("#8fa9bc"),thickness:1pt))
    line((ox,-2),(ox,3.2),mark:(end:">"),stroke:(paint:rgb("#8fa9bc"),thickness:1pt))
  }
  line((0,.5),(1.5,.5),mark:(end:">"),stroke:(paint:rgb("#54d6c6"),thickness:2pt)); line((0,.5),(0,2.1),mark:(end:">"),stroke:(paint:rgb("#7b9cff"),thickness:2pt))
  line((5,.5),(6.7,.5),mark:(end:">"),stroke:(paint:rgb("#54d6c6"),thickness:2pt)); line((5,.5),(6.1,2.1),mark:(end:">"),stroke:(paint:rgb("#7b9cff"),thickness:2pt))
  line((10,.5),(11.25,1.7),mark:(end:">"),stroke:(paint:rgb("#54d6c6"),thickness:2pt)); line((10,.5),(9.15,2.0),mark:(end:">"),stroke:(paint:rgb("#7b9cff"),thickness:2pt))
  content((-1,-2.7),text(size:8pt)[I]); content((4,-2.7),text(size:8pt)[S = (1  .7; 0  1)]); content((9,-2.7),text(size:8pt)[R(38°) · S])
  line((2.2,.5),(2.8,.5),mark:(end:">"),stroke:(paint:rgb("#ffd166"),thickness:1.5pt)); line((7.2,.5),(7.8,.5),mark:(end:">"),stroke:(paint:rgb("#ffd166"),thickness:1.5pt))
})
