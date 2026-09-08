#let code-font = "Source Serif 4"
#let emoji-font = "Noto Color Emoji"


#let typography() = {
  set text(
    font: (
      code-font,
      emoji-font,
    ),
    size: 11pt,
  )

  set par(
    justify: true,
    leading: 0.65em,
  )
}