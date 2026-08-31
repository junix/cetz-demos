#import "@preview/cetz:0.5.2"
#set page(width: auto, height: auto, margin: 24pt, fill: none)
#set text(font: "Avenir Next", fill: rgb("#dcebf5"))
#cetz.canvas(length: 1.2cm, { import cetz.draw: *
  content((0,7.2), text(size:22pt,weight:"bold")[RESIDUAL VISION ENCODER])
  content((0,6.7), text(size:9pt,fill:rgb("#7f9db2"))[FEATURE SHAPES · SKIP CONNECTIONS · ATTENTION BOTTLENECK])
  let xs=(0.3,2.5,4.7,6.9,9.1,11.3)
  let names=([INPUT],[STEM],[RES ×4],[ATTN],[POOL],[EMBED])
  let dims=([224²×3],[112²×64],[28²×256],[14²×512],[1×512],[1×768])
  for i in range(0,6) {
    let h=1.2+calc.rem(i,3)*0.35
    rect((xs.at(i),2.2),(xs.at(i)+1.55,2.2+h),radius:.12,fill:rgb(("#173f3e","#29345c","#48263b","#4b3e1b","#34264c","#173f3e").at(i)),stroke:(paint:rgb(("#54d6c6","#7b9cff","#ff6f91","#ffd166","#b889ff","#54d6c6").at(i)),thickness:1.3pt))
    content((xs.at(i)+.77,2.72),anchor:"center",text(size:8pt,weight:"bold")[#names.at(i)])
    content((xs.at(i)+.77,1.75),anchor:"center",text(size:7pt,fill:rgb("#8ba6b9"))[#dims.at(i)])
    if i < 5 { line((xs.at(i)+1.58,2.85),(xs.at(i+1)-.08,2.85),mark:(end:">"),stroke:(paint:rgb("#7b9cff"),thickness:1.2pt)) }
  }
  line((4.9,4.35),(4.9,5.2),(8.15,5.2),(8.15,4.0),mark:(end:">"),stroke:(paint:rgb("#ff6f91"),dash:"dashed",thickness:1.2pt))
  content((5.75,5.48),text(size:7pt,fill:rgb("#ff8ba5"))[residual highway])
})
