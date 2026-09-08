// ==========================================================
// CODE Framework
// helpers.typ
// Fonctions utilitaires
// ==========================================================


#import "colors.typ": *


#let separator() = {
  line(
    length: 100%,
    stroke: 1pt + code-gray,
  )

  v(1em)
}


#let space-small() = {
  v(0.5em)
}


#let space-medium() = {
  v(1em)
}


#let space-large() = {
  v(2em)
}


#let info(text) = {
  block(
    fill: code-gray-light,
    inset: 10pt,
    radius: 6pt,
  )[
    #text(fill: code-gray)[
      #text
    ]
  ]
}