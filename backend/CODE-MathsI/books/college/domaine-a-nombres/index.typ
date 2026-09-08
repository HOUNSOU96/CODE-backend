
// ==========================================================
// CODE — Domaine A
// Nombres et calculs
// Collège
// ==========================================================

#import "../../../code/headings.typ": domaine
#import "entiers-naturels.typ": entiers_naturels
#import "entiers-relatifs.typ": entiers_relatifs
#import "decimaux.typ": decimaux
#import "nombres-reels.typ": nombres_reels
#import "fractions-rationnels.typ": fractions_rationnels
#import "../../../code/code.typ": *


#let domaine-a() = [

  #domaine(
  "NOMBRES ET CALCULS",
  icon-nombres,
  rgb("#0B2F55"),
  "A",
)<domaine-nombres-calculs>

  #v(0.25cm)

  #align(center)[
    #text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      « Comprendre les nombres, c'est apprendre
      à mesurer, à raisonner et à agir sur le monde. »
    ]
  ]

  #v(0.55cm)

  #box(
    width: 100%,
    fill: rgb(242, 247, 252),
    stroke: 1pt + rgb(205, 220, 235),
    radius: 10pt,
    inset: 0.45cm,
  )[
    #text(
      size: 11.5pt,
    )[
      #strong[Ce domaine] regroupe toutes les notions qui
      permettent de #strong[comprendre, représenter, comparer
      et utiliser les nombres], mais aussi d'effectuer des
      calculs et de résoudre des problèmes issus des
      situations mathématiques et de la vie quotidienne.

      #v(0.25cm)

      Les nombres constituent un véritable
      #strong[langage universel] : ils permettent de
      #strong[compter, mesurer, comparer, calculer et
      modéliser] le monde qui nous entoure.
    ]
  ]

  #v(0.55cm)

  #align(center)[
    #box(
      fill: rgb("#0B2F55"),
      radius: 20pt,
      inset: (x: 0.45cm, y: 0.12cm),
    )[
      #text(
        size: 10pt,
        weight: "bold",
        fill: white,
      )[
        🧭 TA MISSION : MAÎTRISER LES NOMBRES
      ]
    ]
  ]

  #v(0.65cm)

  #entiers_naturels()
  #entiers_relatifs()
  #decimaux()
  #fractions_rationnels()
  #nombres_reels()
]

