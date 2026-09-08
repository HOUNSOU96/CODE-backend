
// ==========================================================
// CODE-MATHS
// PAGE MÉTHODOLOGIQUE
// ==========================================================

#import "code.typ": *


#let methodologie() = [


// ==========================================================
// GRAND TITRE
// ==========================================================

#align(center)[

  #text(
    size: 25pt,
    weight: "bold",
    fill: code-blue,
  )[
    APPRENDRE À RAISONNER
  ]

  #v(0.05cm)

  #text(
    size: 30pt,
    weight: "bold",
    fill: code-blue,
  )[
    EN MATHÉMATIQUES
  ]

  #v(0.12cm)

  #line(
    length: 5cm,
    stroke: 1.3pt + code-blue,
  )

]


#v(0.35cm)


// ==========================================================
// MESSAGE D'OUVERTURE
// ==========================================================

#align(center)[

  #box(
    width: 14cm,
    fill: rgb("#F2F6FA"),
    radius: 12pt,
    inset: 0.3cm,
    stroke: 0.5pt + rgb("#D5E2EF"),
  )[

    #text(
      size: 11.5pt,
      style: "italic",
      fill: code-gray,
    )[

      « Comprendre un exercice, c'est découvrir
      les informations cachées derrière ses mots
      et savoir ce qu'elles permettent de conclure. »

    ]

  ]

]


#v(0.3cm)


// ==========================================================
// IDÉE CENTRALE
// ==========================================================

#align(center)[

  #box(
    width: 14cm,
    fill: code-blue,
    radius: 10pt,
    inset: 0.22cm,
  )[

    #text(
      size: 13pt,
      weight: "bold",
      fill: white,
    )[

      🧠 UNE MÊME IDÉE PEUT ÊTRE FORMULÉE
      DE PLUSIEURS MANIÈRES

    ]

  ]

]


#v(0.25cm)


#text(size: 11pt)[

Dans un exercice, une définition ou une propriété n'est pas
toujours écrite exactement comme dans le cours.

Les mots peuvent changer, les informations peuvent être données
sous forme de texte, de figure, de longueurs ou de relations
mathématiques.

#strong[Mais le raisonnement à construire reste le même.]

]


#v(0.25cm)


// ==========================================================
// STRUCTURE UNIVERSELLE
// ==========================================================

#align(center)[

  #box(
    width: 13.5cm,
    fill: rgb("#E8F1FA"),
    radius: 10pt,
    inset: 0.25cm,
  )[

    #text(
      size: 12pt,
      weight: "bold",
      fill: code-blue,
    )[

      🔎 HYPOTHÈSES
      #h(0.25cm)
      →
      #h(0.25cm)
      🧠 DÉFINITION / PROPRIÉTÉ
      #h(0.25cm)
      →
      #h(0.25cm)
      🎯 CONCLUSION

    ]

  ]

]


#v(0.25cm)


// ==========================================================
// EXEMPLE FIL CONDUCTEUR
// ==========================================================

#align(center)[

  #text(
    size: 14pt,
    weight: "bold",
    fill: code-blue,
  )[

    📐 EXEMPLE : LE PARALLÉLOGRAMME

  ]

]


#v(0.1cm)


#align(center)[

  #box(
    width: 13.5cm,
    fill: rgb("#F2F6FA"),
    radius: 9pt,
    inset: 0.25cm,
    stroke: 0.6pt + rgb("#D5E2EF"),
  )[

    #text(
      size: 11.5pt,
      style: "italic",
    )[

      « Un parallélogramme est un quadrilatère
      dont les diagonales se coupent en leur milieu. »

    ]

  ]

]


#v(0.2cm)


// ==========================================================
// LECTURE DE LA DÉFINITION
// ==========================================================

#table(
  columns: (6.5cm, 6.5cm),
  stroke: none,
  inset: 0.1cm,

  [

    #box(
      fill: rgb("#F2F7FC"),
      radius: 8pt,
      inset: 0.2cm,
      stroke: 0.7pt + code-blue,
    )[

      #text(
        size: 10.5pt,
        weight: "bold",
        fill: code-blue,
      )[

        🔎 CE QUE JE DOIS SAVOIR

      ]

      #v(0.08cm)

      $A B C D$ est un quadrilatère.

      Les diagonales de $A B C D$
      se coupent en leur milieu.

    ]

  ],

  [

    #box(
      fill: rgb("#EAF4EC"),
      radius: 8pt,
      inset: 0.2cm,
      stroke: 0.7pt + code-green,
    )[

      #text(
        size: 10.5pt,
        weight: "bold",
        fill: code-green,
      )[

        🎯 CE QUE JE PEUX CONCLURE

      ]

      #v(0.08cm)

      $A B C D$ est un parallélogramme.

    ]

  ],
)


#v(2cm)


// ==========================================================
// DÉDUCTOGRAMME
// ==========================================================
#pagebreak()

#align(center)[

  #text(
    size: 10pt,
    weight: "bold",
    fill: black,
  )[
    DÉDUCTOGRAMME
  ]

]

#deductogramme_2(
  hypothese-1: [
    $A B C D$ est un quadrilatère.
  ],

  hypothese-2: [
    Les diagonales de $A B C D$
    se coupent en leur milieu.
  ],

  conclusion: [
    $A B C D$ est un parallélogramme.
  ],
)


#v(0.25cm)


// ==========================================================
// LES FORMULATIONS POSSIBLES
// ==========================================================

#align(center)[

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[

    🔄 LE MÊME RAISONNEMENT,
    DES FORMULATIONS DIFFÉRENTES

  ]

]


#v(0.15cm)


// ----------------------------------------------------------
// FORME 1
// ----------------------------------------------------------

#box(
  width: 100%,
  fill: rgb("#F7F9FB"),
  radius: 7pt,
  inset: 0.18cm,
  stroke: 0.5pt + rgb("#D5E2EF"),
)[

  #text(
    size: 10.5pt,
    weight: "bold",
    fill: code-blue,
  )[

    ① QUESTION DIRECTE

  ]

  #v(0.04cm)

  $A B C D$ est un quadrilatère dont les diagonales
  se coupent en leur milieu.

  Quelle est sa nature ?

  #v(0.04cm)

  → #strong[Conclusion :] $A B C D$ est un parallélogramme.

]


#v(0.12cm)


// ----------------------------------------------------------
// FORME 2
// ----------------------------------------------------------

#box(
  width: 100%,
  fill: rgb("#F7F9FB"),
  radius: 7pt,
  inset: 0.18cm,
  stroke: 0.5pt + rgb("#D5E2EF"),
)[

  #text(
    size: 10.5pt,
    weight: "bold",
    fill: code-blue,
  )[

    ② MILIEU NOMMÉ

  ]

  #v(0.04cm)

  Les diagonales $[A C]$ et $[B D]$ se coupent en $O$.
  On sait que $O$ est le milieu de $[A C]$ et de $[B D]$.

  Que peut-on conclure ?

  #v(0.04cm)

  → #strong[Conclusion :] $A B C D$ est un parallélogramme.

]


#v(0.12cm)


// ----------------------------------------------------------
// FORME 3
// ----------------------------------------------------------

#box(
  width: 100%,
  fill: rgb("#F7F9FB"),
  radius: 7pt,
  inset: 0.18cm,
  stroke: 0.5pt + rgb("#D5E2EF"),
)[

  #text(
    size: 10.5pt,
    weight: "bold",
    fill: code-blue,
  )[

    ③ ÉGALITÉS DE LONGUEURS

  ]

  #v(0.04cm)

  $O A = O C$ et $O B = O D$.

  Les diagonales se coupent en $O$.

  Quelle est la nature de $A B C D$ ?

  #v(0.04cm)

  → $O$ est le milieu des deux diagonales.

  → #strong[Conclusion :] $A B C D$ est un parallélogramme.

]


#v(0.12cm)


// ----------------------------------------------------------
// FORME 4
// ----------------------------------------------------------

#box(
  width: 100%,
  fill: rgb("#F7F9FB"),
  radius: 7pt,
  inset: 0.18cm,
  stroke: 0.5pt + rgb("#D5E2EF"),
)[

  #text(
    size: 10.5pt,
    weight: "bold",
    fill: code-blue,
  )[

    ④ LONGUEURS NUMÉRIQUES

  ]

  #v(0.04cm)

  $O A=4$ cm, $O C=4$ cm,
  $O B=6$ cm et $O D=6$ cm.

  Les diagonales se coupent en $O$.

  #v(0.04cm)

  → $O A=O C$ et $O B=O D$.

  → Les diagonales se coupent en leur milieu.

  → #strong[Conclusion :] $A B C D$ est un parallélogramme.

]


#v(0.25cm)


// ==========================================================
// MÉTHODE CODE
// ==========================================================

#align(center)[

  #box(
    width: 14cm,
    fill: code-blue,
    radius: 11pt,
    inset: 0.25cm,
  )[

    #text(
      size: 12.5pt,
      weight: "bold",
      fill: white,
    )[

      🚀 LA MÉTHODE CODE

    ]

    #v(0.12cm)

    #table(
      columns: (1fr, 1fr, 1fr),
      stroke: none,
      inset: 0.08cm,

      [

        #text(size: 17pt)[🔎]

        #v(0.03cm)

        #text(
          weight: "bold",
          size: 10pt,
          fill: white,
        )[

          OBSERVER

        ]

        #v(0.02cm)

        #text(
          size: 8.5pt,
          fill: white,
        )[

          Je cherche
          les informations.

        ]

      ],

      [

        #text(size: 17pt)[🧠]

        #v(0.03cm)

        #text(
          weight: "bold",
          size: 10pt,
          fill: white,
        )[

          RECONNAÎTRE

        ]

        #v(0.02cm)

        #text(
          size: 8.5pt,
          fill: white,
        )[

          Je trouve la
          définition adaptée.

        ]

      ],

      [

        #text(size: 17pt)[🎯]

        #v(0.03cm)

        #text(
          weight: "bold",
          size: 10pt,
          fill: white,
        )[

          DÉDUIRE

        ]

        #v(0.02cm)

        #text(
          size: 8.5pt,
          fill: white,
        )[

          Je construis
          ma conclusion.

        ]

      ],
    )

  ]

]


#v(0.25cm)


// ==========================================================
// PHRASE FINALE
// ==========================================================

#align(center)[

  #text(
    size: 10.5pt,
    style: "italic",
    fill: code-gray,
  )[

    « Ne cherche pas seulement la réponse.
    Cherche le raisonnement qui permet de l'obtenir. »

  ]

]

]

