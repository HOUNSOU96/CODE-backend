#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *
#import "../../../code/icons.typ": *
#import "attente.typ": attente

#let domaine-d() = [
  
  #domaine(
  "GÉOMÉTRIE",
  icon-geometrie,
  rgb("#39704F"),
  "D",
)<domaine-geometrie>

  #v(0.25cm)

  #align(center)[
    #text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#39704F"),
    )[
      « Observer les formes, c'est apprendre
      à comprendre et à mesurer l'espace. »
    ]
  ]

  #v(0.55cm)

  #box(
    width: 100%,
    fill: rgb(243, 248, 245),
    stroke: 1pt + rgb(205, 225, 214),
    radius: 10pt,
    inset: 0.45cm,
  )[
    #text(
      size: 11.5pt,
    )[
      #strong[Ce domaine] regroupe toutes les notions qui
      permettent de #strong[représenter, construire, mesurer
      et raisonner sur les figures et les objets géométriques],
      dans le plan comme dans l'espace.

      #v(0.25cm)

      La géométrie permet de développer le
      #strong[sens de l'observation et de la précision] :
      elle aide à comprendre les formes, les distances,
      les positions, les transformations et les relations
      entre les objets qui nous entourent.
    ]
  ]

  #v(0.55cm)

  #align(center)[
    #box(
      fill: rgb("#39704F"),
      radius: 20pt,
      inset: (x: 0.45cm, y: 0.12cm),
    )[
      #text(
        size: 10pt,
        weight: "bold",
        fill: white,
      )[
        🧭 TA MISSION : MAÎTRISER L'ESPACE
      ]
    ]
  ]

  #v(0.65cm)
  #attente()
]





