
// ==========================================================
// IDENTITÉ DE L'APPRENANT
// CODE-MATHS
// Version esthétique et personnalisée
// ==========================================================

#import "../../code/code.typ": *

#let identite(

  nom: "",
  prenom: "",
  pays: "",
  etablissement: "",
  ville: "",
  annee_scolaire: "",
  photo: none,
  code: "",

) = [

  // ==========================================================
  // TITRE
  // ==========================================================

  #align(center)[

    #text(
      size: 26pt,
      weight: "bold",
      fill: code-blue,
    )[
      👤 IDENTITÉ DE L'APPRENANT
    ]

    #v(0.1cm)

    #line(
      length: 5cm,
      stroke: 1.3pt + code-blue,
    )
  ]

  #v(0.3cm)

  // ==========================================================
  // CARTE PRINCIPALE DE L'APPRENANT
  // ==========================================================

  #align(center)[

    #box(
      width: 14cm,
      radius: 16pt,
      fill: white,
      stroke: 1pt + rgb("#D5E2EF"),
      inset: 0pt,
    )[

      // ------------------------------------------------------
      // BANDEAU SUPÉRIEUR
      // ------------------------------------------------------

      #box(
        width: 14cm,
        fill: code-blue,
        radius: (
          top-left: 16pt,
          top-right: 16pt,
          bottom-left: 0pt,
          bottom-right: 0pt,
        ),
        inset: 0.28cm,
      )[

        #align(center)[

          #text(
            size: 14pt,
            weight: "bold",
            fill: white,
          )[
            PROFIL PERSONNEL
          ]

          #v(0.05cm)

          #text(
            size: 9pt,
            fill: rgb("#DDEEFF"),
          )[
            Ce manuel appartient à son apprenant
          ]

        ]
      ]

      #v(0.25cm)

      // ------------------------------------------------------
      // PHOTO + IDENTITÉ PRINCIPALE
      // ------------------------------------------------------

      #table(
        columns: (4cm, 9cm),
        stroke: none,
        inset: 0.12cm,

        // ====================================================
        // PHOTO
        // ====================================================

        [

          #align(center)[

            #box(
              width: 3.3cm,
              height: 3.8cm,
              fill: rgb("#F4F8FC"),
              radius: 12pt,
              stroke: 1.2pt + rgb("#B8CCE0"),
              inset: 0.12cm,
            )[

              #if photo != none [

                #align(center)[
                  #photo
                ]

              ] else [

                #align(center)[

                  #v(0.65cm)

                  #text(
                    size: 30pt,
                  )[
                    📷
                  ]

                  #v(0.15cm)

                  #text(
                    size: 8pt,
                    weight: "bold",
                    fill: rgb("#60758A"),
                  )[
                    PHOTO
                  ]

                  #text(
                    size: 7pt,
                    fill: rgb("#8799AA"),
                  )[
                    de l'apprenant
                  ]
                ]
              ]
            ]

            #v(0.15cm)

            #text(
              size: 8pt,
              weight: "bold",
              fill: code-blue,
            )[
              APPRENANT CODE-MATHS
            ]
          ]

        ],

        // ====================================================
        // NOM ET PRÉNOM
        // ====================================================

        [

          #box(
            width: 8.5cm,
            fill: rgb("#F7FAFD"),
            radius: 10pt,
            stroke: 0.6pt + rgb("#DCE7F0"),
            inset: 0.22cm,
          )[

            #text(
              size: 8pt,
              weight: "bold",
              fill: rgb("#708398"),
            )[
              NOM
            ]

            #v(0.04cm)

            #text(
              size: 14pt,
              weight: "bold",
              fill: code-blue,
            )[
              #if nom != "" [#nom] else [—]
            ]

            #v(0.18cm)

            #line(
              length: 7.7cm,
              stroke: 0.5pt + rgb("#DCE7F0"),
            )

            #v(0.15cm)

            #text(
              size: 8pt,
              weight: "bold",
              fill: rgb("#708398"),
            )[
              PRÉNOM(S)
            ]

            #v(0.04cm)

            #text(
              size: 12pt,
              weight: "bold",
              fill: rgb("#26384A"),
            )[
              #if prenom != "" [#prenom] else [—]
            ]
          ]

        ],
      )

      #v(0.2cm)

      // ------------------------------------------------------
      // INFORMATIONS SCOLAIRES
      // ------------------------------------------------------

      #align(center)[

        #text(
          size: 9pt,
          weight: "bold",
          fill: code-blue,
        )[
          INFORMATIONS SCOLAIRES
        ]

        #v(0.08cm)

        #line(
          length: 8cm,
          stroke: 0.6pt + rgb("#D5E2EF"),
        )
      ]

      #v(0.12cm)

      #table(
        columns: (1fr, 1fr),
        gutter: 0.18cm,
        stroke: none,
        inset: 0.08cm,

        // ----------------------------------------------------
        // ÉTABLISSEMENT
        // ----------------------------------------------------

        [

          #box(
            fill: rgb("#EEF6FF"),
            radius: 9pt,
            inset: 0.2cm,
            stroke: 0.5pt + rgb("#D4E5F5"),
          )[

            #text(
              size: 8pt,
              weight: "bold",
              fill: code-blue,
            )[
              🏫 ÉTABLISSEMENT
            ]

            #v(0.06cm)

            #text(
              size: 10pt,
              weight: "bold",
              fill: rgb("#26384A"),
            )[
              #if etablissement != "" [#etablissement] else [—]
            ]
          ]

        ],

        // ----------------------------------------------------
        // VILLE
        // ----------------------------------------------------

        [

          #box(
            fill: rgb("#F5F8FB"),
            radius: 9pt,
            inset: 0.2cm,
            stroke: 0.5pt + rgb("#DCE5ED"),
          )[

            #text(
              size: 8pt,
              weight: "bold",
              fill: rgb("#60758A"),
            )[
              📍 VILLE / COMMUNE
            ]

            #v(0.06cm)

            #text(
              size: 10pt,
              weight: "bold",
              fill: rgb("#26384A"),
            )[
              #if ville != "" [#ville] else [—]
            ]
          ]

        ],

        // ----------------------------------------------------
        // PAYS
        // ----------------------------------------------------

        [

          #box(
            fill: rgb("#F5FAF7"),
            radius: 9pt,
            inset: 0.2cm,
            stroke: 0.5pt + rgb("#D8E9DE"),
          )[

            #text(
              size: 8pt,
              weight: "bold",
              fill: rgb("#39704F"),
            )[
              🌍 PAYS
            ]

            #v(0.06cm)

            #text(
              size: 10pt,
              weight: "bold",
              fill: rgb("#26384A"),
            )[
              #if pays != "" [#pays] else [—]
            ]
          ]

        ],

        // ----------------------------------------------------
        // ANNÉE SCOLAIRE
        // ----------------------------------------------------

        [

          #box(
            fill: rgb("#FFF8E7"),
            radius: 9pt,
            inset: 0.2cm,
            stroke: 0.5pt + rgb("#EBDDAE"),
          )[

            #text(
              size: 8pt,
              weight: "bold",
              fill: rgb("#8A6B16"),
            )[
              📅 ANNÉE SCOLAIRE
            ]

            #v(0.06cm)

            #text(
              size: 10pt,
              weight: "bold",
              fill: rgb("#26384A"),
            )[
              #if annee_scolaire != "" [#annee_scolaire] else [—]
            ]
          ]

        ],
      )

      #v(0.25cm)

      // ------------------------------------------------------
      // SIGNATURE VISUELLE CODE
      // ------------------------------------------------------

      #box(
        width: 13.2cm,
        fill: rgb("#F8FAFC"),
        radius: 9pt,
        inset: 0.16cm,
        stroke: 0.5pt + rgb("#E0E8EF"),
      )[

        #align(center)[

          #text(
            size: 8pt,
            fill: rgb("#708398"),
          )[
            Ce document est personnalisé pour
          ]

          #v(0.03cm)

          #text(
            size: 10pt,
            weight: "bold",
            fill: code-blue,
          )[
            #if prenom != "" [
              #prenom
            ] else [
              l'apprenant
            ]
          ]

        ]
      ]

      #v(0.18cm)
    ]
  ]

  #v(0.25cm)

  // ----------------------------------------------------------
  // PARTICULARITÉ DU MANUEL
  // ----------------------------------------------------------

  #align(center)[

    #box(
      width: 14cm,
      fill: code-blue,
      radius: 10pt,
      inset: 0.25cm,
    )[

      #text(
        size: 14pt,
        weight: "bold",
        fill: white,
      )[
        🔐 LES AVANTAGES DU MANUEL CODE
      ]

    ]

  ]

  #v(0.1cm)

  Ce manuel constitue une passerelle vers un environnement
  numérique d'apprentissage.

  #table(
    columns: (7cm, 7cm),
    stroke: none,
    inset: 0.15cm,

    table.cell(
      fill: rgb("#EEF6FF"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
          fill: code-blue,
        )[
          Plateforme CODE
        ]

      ]

    ],

    table.cell(
      fill: rgb("#F8FAFC"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
        )[
          Intelligence Artificielle CODE
        ]

      ]

    ],

    table.cell(
      fill: rgb("#F8FAFC"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
        )[
          Vidéos pédagogiques
        ]

      ]

    ],

    table.cell(
      fill: rgb("#EEF6FF"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
          fill: code-blue,
        )[
          Exercices interactifs
        ]

      ]

    ],

    table.cell(
      fill: rgb("#EEF8F2"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
          fill: rgb("#39704F"),
        )[
          Défis hebdomadaires nationaux et internationaux
        ]

      ]

    ],

    table.cell(
      fill: rgb("#F8FAFC"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
        )[
          Jeux de réflexion
        ]

      ]

    ],

    table.cell(
      fill: rgb("#EEF6FF"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
          fill: code-blue,
        )[
          Suivi personnalisé
        ]

      ]

    ],

    table.cell(
      fill: rgb("#F8FAFC"),
      inset: 0.25cm,
    )[

      #align(center)[

        #text(
          weight: "bold",
        )[
          Ressources complémentaires
        ]

      ]

    ],
  )

  #v(0.1cm)

  // ----------------------------------------------------------
  // CERTIFICAT
  // ----------------------------------------------------------

  #align(center)[

    #box(
      width: 14cm,
      fill: rgb("#FFF8E7"),
      radius: 12pt,
      inset: 0.35cm,
      stroke: 0.8pt + rgb("#D9B44A"),
    )[

      #text(
        size: 14pt,
        weight: "bold",
        fill: code-blue,
      )[
        🛡 CERTIFICAT D'AUTHENTICITÉ
      ]

      #v(0.1cm)

      Ce manuel constitue un exemplaire personnalisé de la collection officielle :

      #strong[CODE — Maths]

      #v(0.15cm)

      #strong[Code d'activation]

      #v(0.1cm)

      #if code != "" [#code] else [—]

      #v(0.2cm)

      Chaque exemplaire possède un numéro de série unique
      servant de code d'activation personnel.

      Après activation sur la plateforme CODE, ce code est
      associé définitivement à son propriétaire afin de
      garantir l'authenticité du manuel.

    ]

  ]

]

