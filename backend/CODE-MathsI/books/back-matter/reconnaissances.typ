// ==========================================================
// RECONNAISSANCES
// CODE-MATHS
// ==========================================================
#import "../../code/code.typ": *

#let reconnaissances() = [

  // ==========================================================
  // TITRE
  // ==========================================================

  #align(center)[

    #text(
      size: 24pt,
      weight: "bold",
      fill: code-blue,
    )[
      RECONNAISSANCES
    ]

    #v(0.15cm)

    #line(
      length: 4cm,
      stroke: 1.2pt + code-blue,
    )

  ]

  #v(0.6cm)

  // ==========================================================
  // CITATION
  // ==========================================================

  #align(center)[

    #box(
      width: 14cm,
      fill: rgb("#F2F6FA"),
      radius: 10pt,
      inset: 0.3cm,
    )[

      #text(
        size: 11pt,
        style: "italic",
        fill: code-gray,
      )[

        « Les grandes visions ne se construisent jamais seules.
        Elles grandissent grâce à celles et ceux qui choisissent
        d'y croire avant même qu'elles deviennent une réalité. »

      ]

    ]

  ]

  #v(0.8cm)

  // ==========================================================
  // À MES CAMARADES
  // ==========================================================

  == À mes camarades de la 9ᵉ promotion

  Mes sincères remerciements s'adressent également à tous les membres
  de la #strong[9ᵉ promotion du BAPES de l'EFES-SAPIENTIA de Porto-Novo].

  Ces trois années de formation resteront gravées dans ma mémoire
  comme une période d'apprentissage, de fraternité, de partage et
  de dépassement de soi.

  Les échanges, les travaux de groupe, les débats pédagogiques,
  les moments de joie comme les difficultés rencontrées ensemble
  ont contribué à construire la personne que je suis aujourd'hui.

  #v(0.5cm)

  // ==========================================================
  // MEMBRES DE LA FILIÈRE MATHÉMATIQUES
  // ==========================================================

 

    #box(
      fill: rgb("#F2F6FA"),
      radius: 8pt,
      inset: 0.2cm,
    )[

      #text(
        size: 13pt,
        weight: "bold",
        fill: code-blue,
      )[

        Membres de la 9ᵉ promotion — Filière Mathématiques

      ]

    ]

  

  #v(0.4cm)

  // ----------------------------------------------------------
  // Fonction pour les lignes du tableau
  // ----------------------------------------------------------

  #let row(
    n,
    nom,
    filiere,
    shade: false,
  ) = {

    if shade {

      (
        table.cell(
          fill: rgb(245,247,250),
        )[ #n ],

        table.cell(
          fill: rgb(245,247,250),
        )[ #nom ],

        table.cell(
          fill: rgb(245,247,250),
        )[ #filiere ],
      )

    } else {

      (
        [#n],
        [#nom],
        [#filiere],
      )

    }

  }

  // ----------------------------------------------------------
  // Tableau des membres de Mathématiques
  // ----------------------------------------------------------



    #table(
      columns: (1.5cm, 9cm, 4.5cm),
      inset: 0.1cm,
      stroke: 0.5pt + rgb(180,180,180),

      // ------------------------------------------------------
      // En-tête
      // ------------------------------------------------------

      table.cell(
        fill: rgb(220,230,240),
      )[
        
          #text(weight: "bold")[N°]
        
      ],

      table.cell(
        fill: rgb(220,230,240),
      )[
       
          #text(weight: "bold")[Nom et prénoms]
        
      ],

      table.cell(
        fill: rgb(220,230,240),
      )[
        
          #text(weight: "bold")[Filière]
        
      ],

      // ------------------------------------------------------
      // Membres — ordre alphabétique
      // ------------------------------------------------------

      ..row(
        1,
        [ADANDEDJAN Guigonou Gloria Jéraudia Concrète],
        [Mathématiques],
      ),

      ..row(
        2,
        [ADELOU Zinsou Cosme],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        3,
        [ADJANOHOUN Gbodja Jérôme],
        [Mathématiques],
      ),

      ..row(
        4,
        [ADJAO Andilath Agnikè Eyitayo],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        5,
        [ASSANI PADONOU Nabil Carmel],
        [Mathématiques],
      ),

      ..row(
        6,
        [AZON Edouard Roméo],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        7,
        [BOGNON Junior Noisel],
        [Mathématiques],
      ),

      ..row(
        8,
        [DAH-TOLIGBONON Ferdinand],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        9,
        [DJIVOEDO Akouèmaho Jacques],
        [Mathématiques],
      ),

      ..row(
        10,
        [DJOSSOU Kpokpogbé Ano],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        11,
        [GBADAMASSI Fouwad],
        [Mathématiques],
      ),

      ..row(
        12,
        [GBEBO Noukpo François Elvys],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        13,
        [HOUACHINOU Abel Camus Mahougnon],
        [Mathématiques],
      ),

      ..row(
        14,
        [HOUEDO Gnicowou Dieudonné],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        15,
        [HOUNSOU Déo-Gratias Sèmako],
        [Mathématiques],
      ),

      ..row(
        16,
        [HOUNSOU Philippe Jésuwamè],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        17,
        [OKE Bodounrin Basile],
        [Mathématiques],
      ),

      ..row(
        18,
        [SESSOU Mahukpégo Darius],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        19,
        [SOKENOU Miracle Pan-Basterne],
        [Mathématiques],
      ),

      ..row(
        20,
        [VIGAN Merveil Félix],
        [Mathématiques],
        shade: true,
      ),

      ..row(
        21,
        [ZOUNMENOU Odette],
        [Mathématiques],
      ),

    )

  

  // ==========================================================
  // MEMBRES DES AUTRES FILIÈRES
  // ==========================================================

  #pagebreak()

  

    #box(
      fill: rgb("#F2F6FA"),
      radius: 8pt,
      inset: 0.2cm,
    )[

      #text(
        size: 13pt,
        weight: "bold",
        fill: code-blue,
      )[

        Membres de la 9ᵉ promotion — Autres filières

      ]

    ]

  

  #v(0.4cm)

  // ----------------------------------------------------------
  // Tableau des autres filières
  // ----------------------------------------------------------


    #table(
      columns: (1.5cm, 9cm, 4.5cm),
      inset: 0.1cm,
      stroke: 0.5pt + rgb(180,180,180),

      // ------------------------------------------------------
      // En-tête
      // ------------------------------------------------------

      table.cell(
        fill: rgb(220,230,240),
      )[
       
          #text(weight: "bold")[N°]
        
      ],

      table.cell(
        fill: rgb(220,230,240),
      )[
       
          #text(weight: "bold")[Nom et prénoms]
        
      ],

      table.cell(
        fill: rgb(220,230,240),
      )[
       
          #text(weight: "bold")[Filière]
        
      ],

      // ------------------------------------------------------
      // Membres — ordre alphabétique
      // ------------------------------------------------------



     ..row(
        1,
        [CODJO Mathias],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),

     

     ..row(
        2,
        [DOVOEDO Opportune],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),



      ..row(
        3,
        [FAGBOHOUN Chimène],
        [LM — Lettres Modernes],
      ),



       ..row(
        4,
        [FASSINOU Pénielle],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),



     ..row(
        5,
        [GBAGUIDI Maurène],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),




    
      ..row(
        6,
        [HONFOGA Urbain],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),


        ..row(
        7,
        [HOUNSSA-GANSSI Mélaine],
        [PCT — Physique-Chimie et Technologie],
        shade: true,
      ),


       ..row(
        8,
        [MOULERO Cynthia],
        [LM — Lettres Modernes],
        shade: true,
      ),



      ..row(
        9,
        [TOVILEDO Maurice],
        [LM — Lettres Modernes],
        shade: true,
      ),



      ..row(
        10,
        [ZOUNON Judith],
        [PCT — Physique-Chimie et Technologie],
      ),

    )


  // ==========================================================
  // RECONNAISSANCE PARTICULIÈRE
  // ==========================================================

  == Une reconnaissance particulière

  Je souhaite exprimer une profonde gratitude à :

    #box(
      width: 14cm,
      fill: rgb("#F8FAFC"),
      radius: 12pt,
      inset: 0.35cm,
      stroke: 0.8pt + code-blue,
    )[

      #text(
        size: 13pt,
        weight: "bold",
        fill: code-blue,
      )[

        Roméo AZON

      ]

      #v(0.15cm)

      #text(
        size: 10pt,
        style: "italic",
      )[

        Professeur certifié de mathématiques  
        Cofondateur de CODE

      ]

    ]

  

  Dès les premières réflexions autour de cette initiative,
  il a été l'une des premières personnes à croire en cette vision.
  Par ses conseils, ses orientations, son regard critique,
  sa disponibilité constante et son accompagnement,
  il a contribué à faire mûrir cette ambition et à lui donner
  une direction plus solide.
  Son engagement ne s'est jamais limité à une simple relation
  professionnelle. Il a toujours répondu présent lorsqu'il
  s'agissait d'apporter un avis, d'encourager une décision,
  d'accompagner une rencontre importante ou de rechercher des
  opportunités susceptibles de soutenir le développement
  de CODE.

  Si aujourd'hui ce projet continue de grandir,
  c'est aussi grâce à sa confiance, à son amitié
  et à sa fidélité envers cette vision commune.
  Je lui adresse toute ma reconnaissance.

  // ==========================================================
  // À TOUTES CELLES ET CEUX QUI SOUTIENNENT CETTE VISION
  // ==========================================================

  == À toutes celles et ceux qui soutiennent cette vision

  J'adresse enfin mes remerciements à toutes les personnes qui,
  de près ou de loin, contribuent au développement de CODE par
  leurs conseils, leurs encouragements, leurs critiques
  constructives, leurs prières ou leur soutien.

  Chaque geste, chaque parole et chaque marque de confiance
  participent à faire grandir cette ambition.

  Puisse CODE continuer à évoluer au service de l'éducation,
  de la jeunesse et de tous ceux qui croient que le savoir
  est l'un des plus puissants leviers de transformation
  de notre société.

  #v(0.8cm)

  // ==========================================================
  // SIGNATURE CODE
  // ==========================================================

  #align(center)[

    #text(
      size: 11pt,
      weight: "bold",
      fill: code-blue,
    )[

      CODE — L'Éveil de l'Intelligence

    ]

    #v(0.2cm)

    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[

      Comprendre • Réfléchir • Créer • Transmettre

    ]

  ]

]