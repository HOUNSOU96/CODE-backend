#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *
#import "../../../code/icons.typ": *
#import "attente.typ": attente

#let domaine-c() = [
 
  #domaine(
  "ORGANISATION ET TRAITEMENT DES DONNÉES",
  icon-donnees,
  rgb("#B06A00"),
  "C",
)<domaine-donnees>

  #v(0.25cm)

  #align(center)[
    #text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#B06A00"),
    )[
      « Organiser les données, c'est transformer
      l'information en connaissance. »
    ]
  ]

  #v(0.55cm)

  #box(
    width: 100%,
    fill: rgb(250, 247, 240),
    stroke: 1pt + rgb(230, 215, 190),
    radius: 10pt,
    inset: 0.45cm,
  )[
    #text(
      size: 11.5pt,
    )[
      #strong[Ce domaine] regroupe toutes les notions qui
      permettent de #strong[collecter, organiser, représenter,
      lire et interpréter des données] provenant de situations
      mathématiques ou de la vie quotidienne.

      #v(0.25cm)

      Les tableaux, les graphiques et les outils statistiques
      permettent de #strong[transformer des informations
      nombreuses en données lisibles], afin de comparer,
      analyser, prendre des décisions et mieux comprendre
      les phénomènes qui nous entourent.
    ]
  ]

  #v(0.55cm)

  #align(center)[
    #box(
      fill: rgb("#B06A00"),
      radius: 20pt,
      inset: (x: 0.45cm, y: 0.12cm),
    )[
      #text(
        size: 10pt,
        weight: "bold",
        fill: white,
      )[
        🧭 TA MISSION : COMPRENDRE LES DONNÉES
      ]
    ]
  ]

  #v(0.65cm)

 #attente()

]

