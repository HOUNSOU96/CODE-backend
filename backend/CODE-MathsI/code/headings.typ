// ==========================================================
// CODE Framework
// headings.typ
// Système officiel des titres
// ==========================================================


#import "colors.typ": *


#let title-main(body) = {
  set align(center)

  text(
    size: 24pt,
    weight: "bold",
    fill: code-blue,
  )[
    #body
  ]

  v(1em)
}


#let domaine(titre, icone, couleur, lettre) = {

  box(
    width: 100%,
    fill: couleur,
    radius: 14pt,
    inset: 0pt,
  )[
    #grid(
      columns: (1.8cm, 1fr),
      gutter: 0pt,

      [
        #align(center + horizon)[
          #text(
            size: 10pt,
            weight: "bold",
            fill: white,
            tracking: 1.5pt,
          )[
            DOMAINE
          ]

          #v(0.05cm)

          #text(
            size: 32pt,
            weight: "bold",
            fill: white,
          )[
            #lettre
          ]
        ]
      ],

      [
        #box(
          width: 100%,
          fill: white,
          radius: (left: 12pt, right: 12pt),
          inset: (x: 0.45cm, y: 0.35cm),
        )[
          #text(
            size: 12pt,
            weight: "bold",
            fill: couleur,
          )[
            #icone
          ]

          #h(0.12cm)

          #text(
            size: 19pt,
            weight: "bold",
            fill: couleur,
          )[
            #titre
          ]
        ]
      ],
    )
  ]

  v(0.65cm)
}



#let title-chapter(body) = {
  text(
    size: 20pt,
    weight: "bold",
    fill: code-red,
  )[
    #body
  ]

  v(0.8em)
}


#let title-notion(body) = {
  text(
    size: 16pt,
    weight: "bold",
    fill: code-green,
  )[
    #body
  ]

  v(0.6em)
}


#let title-section(body) = {
  text(
    size: 13pt,
    weight: "bold",
    fill: code-orange,
  )[
    #body
  ]

  v(0.4em)
}


#let title-mission(body) = {
  text(
    size: 14pt,
    weight: "bold",
    fill: code-blue,
  )[
    🚀 Mission CODE — #body
  ]

  v(0.5em)
}