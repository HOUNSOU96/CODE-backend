#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *
#import "../../../code/icons.typ": *
#import "algebre.typ": algebre

#let domaine-b() = [
   
  #domaine(
  "ALGÈBRE",
  icon-algebre,
  rgb("#8B1E2D"),
  "B",
)<domaine-algebre>

  #v(0.25cm)

  #align(center)[
    #text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#8B1E2D"),
    )[
      « Passer des nombres aux lettres, c'est apprendre
      à généraliser et à raisonner autrement. »
    ]
  ]

  #v(0.55cm)

  #box(
    width: 100%,
    fill: rgb(250, 242, 244),
    stroke: 1pt + rgb(230, 205, 210),
    radius: 10pt,
    inset: 0.45cm,
  )[
    #text(
      size: 11.5pt,
    )[
      #strong[Ce domaine] regroupe toutes les notions qui
      permettent de #strong[traduire, généraliser et résoudre
      des situations mathématiques] à l'aide de nombres,
      de lettres, d'expressions et de relations.

      #v(0.25cm)

      L'algèbre apprend à #strong[raisonner avec l'inconnu],
      à reconnaître des régularités, à exprimer des relations
      et à construire des méthodes permettant de résoudre
      des problèmes de manière générale.
    ]
  ]

  #v(0.55cm)

  #align(center)[
    #box(
      fill: rgb("#8B1E2D"),
      radius: 20pt,
      inset: (x: 0.45cm, y: 0.12cm),
    )[
      #text(
        size: 10pt,
        weight: "bold",
        fill: white,
      )[
        🧭 TA MISSION : APPRENDRE À RAISONNER
      ]
    ]
  ]

  #v(0.65cm)

  #algebre()

]