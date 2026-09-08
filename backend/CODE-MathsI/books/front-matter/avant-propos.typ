// ==========================================================
// AVANT-PROPOS
// CODE-MATHS
// ==========================================================

#import "../../code/code.typ": *

#let avant_propos() = [

  // --------------------------------------------------------
  // TITRE
  // --------------------------------------------------------

  #align(center)[

    #text(
      size: 24pt,
      weight: "bold",
      fill: code-blue,
    )[
      AVANT-PROPOS
    ]

    #v(0.15cm)

    #line(
      length: 4cm,
      stroke: 1.2pt + code-blue,
    )

  ]


  #v(0.2cm)


  #align(center)[

    #box(
      width:14cm,
      fill:rgb("#F2F6FA"),
      radius:12pt,
      inset:0.35cm,
    )[

      #text(
        size:12pt,
        style:"italic",
        fill:code-gray,
      )[

      « Comprendre les mathématiques,
      c'est apprendre à comprendre le monde. »

      ]

    ]

  ]


  #v(0.5cm)



  // --------------------------------------------------------
  // INTRODUCTION
  // --------------------------------------------------------


  #box(
    width:15cm,
    fill:rgb("#EAF5FF"),
    radius:12pt,
    inset:0.35cm,
    stroke:0.8pt + code-blue,
  )[

    #text(
      size:14pt,
      weight:"bold",
      fill:code-blue,
    )[
      🌍 Pourquoi CODE-MATHS ?
    ]


    #v(0.3cm)


    Les mathématiques ne sont pas uniquement des nombres,
    des calculs ou des formules.

    Elles sont présentes dans :

    • l'agriculture ;

    • la médecine ;

    • la mécanique ;

    • l'architecture ;

    • le commerce ;

    • la finance ;

    • l'informatique ;

    • l'intelligence artificielle ;

    • les technologies du futur.

  ]


  #v(0.2cm)



  Pourtant, beaucoup d'apprenants rencontrent encore les mathématiques
  comme une accumulation de règles à mémoriser plutôt qu'un langage
  permettant de réfléchir, de créer et de résoudre des problèmes.


  #v(0.2cm)



  C'est face à cette réalité qu'est née la vision de
  #strong[CODE-MATHS] : proposer une nouvelle manière d'apprendre
  les mathématiques, fondée sur la compréhension, le raisonnement
  et l'application.



 


  #v(0.3cm)



  


  Nous espérons que ce manuel donnera à chaque lecteur
  l'envie de comprendre, d'expérimenter, d'inventer et de découvrir
  que les mathématiques sont avant tout un outil puissant pour
  penser, résoudre les problèmes et construire l'avenir.



  #v(3.5cm)



  #align(center)[

    #text(
      size:11pt,
      weight:"bold",
      fill:code-blue,
    )[
      CODE-MATHS
    ]

    #v(0.4cm)

    #text(
      size:10pt,
      style:"italic",
      fill:code-gray,
    )[
      Comprendre • Réfléchir • Créer • Transmettre
    ]

  ]

]