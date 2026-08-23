#import "@preview/cetz:0.5.2"
#set page(width:auto,height:auto,margin:24pt,fill:none)
#set text(font:"Avenir Next",fill:rgb("#dcebf5"))
#cetz.canvas(length:1.1cm,{ import cetz.draw: *
  content((0,8.5),text(size:22pt,weight:"bold")[LUNAR INSTRUMENT ROADMAP])
  content((0,8.0),text(size:9pt,fill:rgb("#7f9db2"))[WORKSTREAMS · DEPENDENCIES · DECISION GATES · SLACK])
  for m in range(0,19) { line((2+m*.65,1.0),(2+m*.65,7.25),stroke:(paint:rgb("#5e789033"),thickness:.5pt)); if calc.rem(m,3) == 0 { content((2+m*.65,.55),anchor:"center",text(size:7pt,fill:rgb("#8ba6b9"))[M#(m)]) } }
  let rows=([SCIENCE],[OPTICS],[THERMAL],[FLIGHT SW],[GROUND],[REVIEW])
  let starts=(0,2,4,6,3,13); let lens=(6,7,5,8,9,4)
  for i in range(0,6) {
    let y = 6.65 - i * .95
    let x0 = 2 + starts.at(i) * .65
    let x1 = 2 + (starts.at(i) + lens.at(i)) * .65
    content((0,y+.22),text(size:8pt)[#rows.at(i)])
    rect((x0,y),(x1,y+.52),radius:.1,fill:rgb(("#173f3e","#29345c","#48263b","#4b3e1b","#34264c","#173f3e").at(i)),stroke:(paint:rgb(("#54d6c6","#7b9cff","#ff6f91","#ffd166","#b889ff","#54d6c6").at(i)),thickness:1pt))
    if i < 5 {
      let nextx = 2 + starts.at(i + 1) * .65
      line((x1, y + .25), (nextx, y - .7), mark: (end: ">"), stroke: (paint: rgb("#8fa9bc"), thickness: .8pt))
    }
  }
  for gate in (6,12,18) { line((2+gate*.65,.9),(2+gate*.65,7.3),stroke:(paint:rgb("#ff6f91"),dash:"dashed",thickness:1.1pt)) }
})
