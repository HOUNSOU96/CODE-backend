// ==========================================================
// LE PARCOURS D'UNE NOTION DANS CODE-MATHS
// ==========================================================

#import "../../code/code.typ": *

#let usage_code() = [

  // ========================================================
  // TITRE
  // ========================================================

  #align(center)[

    #text(
      size:24pt,
      weight:"bold",
      fill:code-blue,
    )[
      LE PARCOURS D'UNE NOTION
    ]

    #v(0.15cm)

    #text(
      size:13pt,
      weight:"bold",
      fill:code-gray,
    )[
      Comment utiliser CODE-MATHS
    ]

    #v(0.15cm)

    #line(
      length:4cm,
      stroke:1.2pt + code-blue,
    )

  ]


  #v(0.6cm)


  // ========================================================
  // CITATION
  // ========================================================


  #align(center)[

    #box(
      width:14cm,
      fill:rgb("#F2F6FA"),
      radius:12pt,
      inset:0.35cm,
    )[

      #text(
        size:11pt,
        style:"italic",
        fill:code-gray,
      )[

        « Les mathématiques ne s'apprennent pas uniquement
        en mémorisant des formules.

        Elles se comprennent, se raisonnent,
        se vivent et s'appliquent. »

      ]

    ]

  ]


  #v(0.6cm)



  // ========================================================
  // INTRODUCTION
  // ========================================================


  #box(
    width:100%,
    fill:rgb("#EEF6FF"),
    radius:12pt,
    inset:0.3cm,
    stroke:0.8pt + code-blue,
  )[


    #text(
      weight:"bold",
      size:12pt,
      fill:code-blue,
    )[

      🎯 La philosophie CODE

    ]


    #v(0.15cm)


    Chaque notion de #strong[CODE-MATHS] suit une organisation
    identique afin de guider progressivement l'apprenant.

    Cette structure permet de comprendre :

    • pourquoi la notion existe ;

    • comment elle fonctionne ;

    • comment l'utiliser ;

    • où elle intervient dans le monde réel.

  ]



  #v(0.6cm)



  





  // ========================================================
  // ORGANISATION D'UNE NOTION
  // ========================================================



  #text(
    size:14pt,
    weight:"bold",
    fill:code-blue,
  )[

    📚 Organisation détaillée d'une notion

  ]


  #v(0.3cm)



  #table(

    columns:(7cm,7cm),

    inset:0.15cm,

    stroke:none,


    // Ligne 1

    table.cell(
  fill:rgb("#EEF6FF"),
)[

  #text(
    weight:"bold",
    fill:code-blue,
  )[
    🌍 Mise en situation
  ]



#v(0.15cm)

      Une histoire, une découverte,
      une civilisation ou un problème réel
      qui explique l'origine de la notion.

    ],


    table.cell(
      fill:rgb("#F8FAFC"),
    )[

      #text(
        weight:"bold",
      )[

        📷 Illustration

      ]

      Une image pour faciliter
      la compréhension.

    ],



    // Ligne 2


    table.cell(
      fill:rgb("#F8FAFC"),
    )[

      #text(
        weight:"bold",
      )[

        🎯 Objectif

      ]

      Ce que l'apprenant doit comprendre
      et maîtriser.

    ],


    table.cell(
      fill:rgb("#EEF6FF"),
    )[

      #text(
        weight:"bold",
      )[

        📘 Définitions

      ]

      Les notions fondamentales
      expliquées simplement.

    ],



    // Ligne 3


    table.cell(
      fill:rgb("#F8FAFC"),
    )[

      #text(
        weight:"bold",
      )[

        📌 À retenir

      ]

      Les idées essentielles
      à mémoriser.

    ],


    table.cell(
      fill:rgb("#EEF6FF"),
    )[

      #text(
        weight:"bold",
      )[

        💡 Remarques

      ]

      Les erreurs fréquentes,
      pièges et cas particuliers.

    ],



    // Ligne 4


    table.cell(
      fill:rgb("#EAF5FF"),
    )[

      #text(
        weight:"bold",
        fill:rgb("#0066CC"),
      )[

        🔵 Hypothèses

      ]

      Les informations connues
      avant d'appliquer une propriété.

    ],


    table.cell(
      fill:rgb("#EAF8EF"),
    )[

      #text(
        weight:"bold",
        fill:rgb("#008000"),
      )[

        🟢 Conclusions

      ]

      Ce que la propriété
      permet d'affirmer.

    ],


  )



  #v(0.7cm)



  // ========================================================
  // APPLICATIONS
  // ========================================================


  #box(
    width:100%,
    fill:rgb("#F8FAFC"),
    radius:10pt,
    inset:0.3cm,
  )[


    #text(
      weight:"bold",
      fill:code-blue,
    )[

      🌍 Les mathématiques dans le monde réel

    ]


    Les exercices CODE sont inspirés de situations concrètes :

    • agriculture ;

    • élevage ;

    • médecine ;

    • commerce et finance ;

    • politique ;

    • mécanique ;

    • couture ;

    • menuiserie ;

    • artisanat ;

    • architecture ;

    • intelligence artificielle ;

    • technologies ;

    • civilisations anciennes ;

    • mythologies du monde.

  ]



  #v(0.5cm)



  // ========================================================
  // OUVERTURE
  // ========================================================


  #box(
    width:100%,
    fill:rgb("#FFF8E8"),
    radius:10pt,
    inset:0.3cm,
  )[


    #text(
      weight:"bold",
    )[

      🚀 Au-delà de la leçon

    ]


    Chaque notion ouvre une porte vers :

    • les grands problèmes mathématiques encore non résolus ;

    • les découvertes scientifiques ;

    • les applications modernes ;

    • les liens avec l'intelligence artificielle.

  ]



  #v(0.5cm)



  // ========================================================
  // PROGRESSION
  // ========================================================


  #align(center)[


    #box(
      width:13cm,
      fill:rgb("#EEF6FF"),
      radius:12pt,
      inset:0.35cm,
      stroke:0.5pt + code-blue,
    )[


      #text(
        weight:"bold",
        size:12pt,
        fill:code-blue,
      )[

        🚀 Une progression continue

      ]


      #v(0.15cm)


      Une même notion est étudiée progressivement :

      
      6ᵉ  →  5ᵉ  →  4ᵉ  →  3ᵉ  →  2nde  →  1ʳᵉ  →  Terminale


      afin de construire une maîtrise solide,
      durable et transférable.

    ]

  ]



]