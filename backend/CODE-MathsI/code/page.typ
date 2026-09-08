// ==========================================================
// CODE Framework
// page.typ
// Gestion officielle des pages
// ==========================================================

#import "colors.typ": *


#let setup-page() = {

  // --------------------------------------------------------
  // PAGE A4
  // --------------------------------------------------------

  set page(
    paper: "a4",

    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 2cm,
      right: 2cm,
    ),

    header: context [
      #align(right)[
        #text(
          size: 9pt,
          fill: code-gray,
        )[
          CODE — L'Éveil de l'intelligence
        ]
      ]
    ],

    footer: context [
      #align(center)[
        #text(
          size: 9pt,
          fill: code-gray,
        )[
          Page #counter(page).display()
        ]
      ]
    ],
  )

  // --------------------------------------------------------
  // TEXTE
  // --------------------------------------------------------

  set text(
    font: "Liberation Serif",
    size: 12pt,
  )

  
}

