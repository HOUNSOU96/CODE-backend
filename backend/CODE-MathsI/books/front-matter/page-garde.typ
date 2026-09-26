
// ==========================================================
// CODE Framework
// Page de garde intérieure
// Compatible Typst 0.15.1
// ==========================================================

#let page_garde() = [

  #set page(
    paper: "a4",

    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 2cm,
      right: 2cm,
    ),

    background: image(
      "../../assets/backgrounds/page-bg.png",
      width: 21cm,
      height: 29.7cm,
    ),
  )




#place(
    dx: 13cm,
    dy: 0.4cm,
  )[
    #image(
      "../../assets/cachet/cachet.png",
      width: 5cm,
    )
  ]


  // ==========================================================
  // Identité CODE-MATHS
  // ==========================================================

  #align(center)[

    #text(
      size: 42pt,
      weight: "bold",
      fill: rgb(11,47,85),
    )[
      CODE-MATHS
    ]

    #v(0.15cm)

    #text(
      size: 11pt,
      fill: rgb(90,90,90),
    )[
      Apprendre • Comprendre • Transformer
    ]

    #v(0.25cm)

    #line(length: 11cm, stroke: 1pt + rgb(11,47,85))

    #v(0.40cm)

    #text(
      size: 22pt,
      weight: "bold",
      fill: rgb(11,47,85),
    )[
      MAÎTRISE DES MATHÉMATIQUES
    ]

    #v(0.25cm)

    

    #text(
      size: 15pt,
      weight: "bold",
    )[
      Classes de la 6ème à la 3ème
    ]

    #v(0.2cm)

    #line(length: 11cm, stroke: 0.8pt + rgb(11,47,85))

  ]

  #v(0.2cm)

  // ==========================================================
  // Citation
  // ==========================================================

  #align(center)[

    #box(
      width: 14cm,
      inset: 14pt,
      stroke: 1.2pt + rgb(11,47,85),
      radius: 8pt,
      fill: white,
    )[

      #align(center)[

        #text(
          size: 12pt,
          style: "italic",
        )[
          « Si les mathématiques étaient la monnaie du monde,
          même les soi-disant nuls chercheraient à décrypter le CODE. »
        ]

        #v(0.2cm)

        #align(right)[
          #text(
            size: 11pt,
          )[
            — Déo-Gratias HOUNSOU
          ]
        ]

      ]

    ]

  ]

  #v(0.3cm)

  // ==========================================================
  // Supervision pédagogique
  // ==========================================================

  #align(center)[

    #box(
      width: 14cm,
      inset: 12pt,
      stroke: 1pt + rgb(11,47,85),
      radius: 7pt,
      fill: rgb(248,250,252),
    )[

      #align(center)[

        #text(
          size: 10pt,
          fill: rgb(90,90,90),
        )[
          Sous la supervision du
        ]

        #v(0.1cm)

        #text(
          size: 12pt,
          weight: "bold",
          fill: rgb(11,47,85),
        )[
          Docteur Gervais AFFOGNON
        ]

        #v(0.1cm)

        #text(
          size: 10pt,
        )[
          Enseignant à l'IMSP de Dangbo
        ]

        #text(
          size: 10pt,
        )[
          Conseiller pédagogique des Mathématiques au Bénin
        ]

      ]

    ]

  ]

  #v(0.3cm)

    // ==========================================================
  // Présentation des auteurs
  // ==========================================================

  #grid(
    columns: (1fr, 1fr),
    gutter: 2cm,


    [

      #box(
        width: 7cm,
        inset: 12pt,
        stroke: 0.8pt + rgb(180,180,180),
        radius: 6pt,
      )[

        #align(left)[

          #text(
            size: 11pt,
            weight: "bold",
            fill: rgb(11,47,85),
          )[
            Déo-Gratias S. HOUNSOU
          ]

          #v(0.2cm)

          #text(
            size: 10pt,
          )[
            Fondateur de CODE
          ]

          #v(0.15cm)

          #text(
            size: 10pt,
          )[
            Chercheur Indépendant en Intelligence
          ]

          #text(
            size: 10pt,
          )[
            Artificielle et Technologies Éducatives
          ]

          #v(0.15cm)


          #text(
            size: 10pt,
          )[
            01 61 86 64 53
          ]

        ]

      ]

    ],



    [

      #box(
        width: 7cm,
        inset: 12pt,
        stroke: 0.8pt + rgb(180,180,180),
        radius: 6pt,
      )[

        #align(left)[

          #text(
            size: 11pt,
            weight: "bold",
            fill: rgb(11,47,85),
          )[
            Roméo E. AZON
          ]

          #v(0.2cm)

          #text(
            size: 10pt,
          )[
            Cofondateur de CODE
          ]

          #v(0.15cm)

          #text(
            size: 10pt,
          )[
            CAPES -- Professeur certifié de 
          ]
           #text(
            size: 10pt,
          )[
            Mathématiques
          ]


          #v(0.15cm)

          #text(
            size: 10pt,
          )[
            01 52 99 95 32
          ]

        ]

      ]

    ]

  )


  #v(0.5cm)


 

    // ==========================================================
  // Signature éditoriale
  // ==========================================================

  #align(center)[

    #line(
      length: 8cm,
      stroke: 0.8pt + rgb(11,47,85),
    )

    #v(0.2cm)

    #text(
      size: 12pt,
      weight: "bold",
      fill: rgb(11,47,85),
    )[
      ÉDITION 2026
    ]

    #v(0.1cm)

    #text(
      size: 11pt,
    )[
      CODE — L'Éveil de l'Intelligence
    ]

  ]


]

