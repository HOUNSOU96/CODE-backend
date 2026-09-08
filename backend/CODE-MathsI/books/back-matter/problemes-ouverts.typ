
#import "../../code/code.typ": *

#let problemes_ouverts() = [

  // ==========================================================
  // TITRE
  // ==========================================================

  #align(center)[

    
  #text(
      size: 24pt,
      weight: "bold",
      fill: code-blue,
    )[
      PROBLÈMES MATHÉMATIQUES OUVERTS
    ]

    #v(0.15cm)

    #line(
      length: 4cm,
      stroke: 1.2pt + code-blue,
    )
  ]

  #v(0.6cm)

  #align(center)[
    #text(
      size: 11pt,
      style: "italic",
      fill: code-gray,
    )[
      « Certaines questions peuvent être simples à poser,
      mais extraordinairement difficiles à résoudre. »
    ]
  ]

  #v(0.7cm)

  Certains problèmes mathématiques résistent encore aux efforts
  des chercheurs du monde entier.

  Un #strong[problème ouvert] est une question mathématique qui
  demeure activement étudiée et pour laquelle aucune résolution
  complète n'est actuellement établie.

  L'expression #strong[problème non résolu] insiste quant à elle
  sur l'absence actuelle d'une démonstration complète ou d'une
  réfutation définitive. Un problème ouvert est donc généralement
  un problème non résolu, mais les deux expressions mettent
  l'accent sur des aspects différents.

  À l'inverse, un #strong[problème résolu] est un problème pour
  lequel une démonstration complète a été établie, ou pour lequel
  la conjecture proposée a été définitivement réfutée. La
  résolution doit pouvoir être vérifiée et acceptée par la
  communauté mathématique.

  Cette page présente une sélection de problèmes mathématiques
  célèbres. Certains sont encore ouverts et non résolus, tandis
  que d'autres, autrefois ouverts, ont finalement été résolus.

  #v(0.55cm)

  // ==========================================================
  // LÉGENDE DES STATUTS
  // ==========================================================

 

    #text(
      size: 10pt,
      weight: "bold",
      fill: rgb(210,130,0),
    )[
      Ouvert
    ]
    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      : Le problème demeure une question mathématique activement
      étudiée et aucune résolution complète n'est actuellement établie.
    ]
  #v(0.1cm)

  
    #text(
      size: 10pt,
      weight: "bold",
      fill: rgb(190,40,40),
    )[
      Non résolu
    ]
    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      : Aucune démonstration complète ni réfutation définitive
      n'est actuellement connue.
    ]
  #v(0.1cm)

    #text(
      size: 10pt,
      weight: "bold",
      fill: green,
    )[
      Résolu
    ]
    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      : Une démonstration complète ou une réfutation définitive
      a été établie et validée par la communauté mathématique.
    ]

  

  #v(0.7cm)


  // ==========================================================
  // NOMBRES PREMIERS ET DIVISIBILITÉ
  // ==========================================================

  #sous_sous_titre[
    Nombres premiers et divisibilité
  ]

  #v(0.15cm)

  #table(
    columns: (3.4cm, 1fr, 3.5cm, 1.5cm, 3.1cm),
    inset: 0.11cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Question]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Notions concernées]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Récompense connue]
      
    ],

    [#strong[Conjecture de Goldbach]],
    [Tout entier pair supérieur à 2 est-il somme de deux nombres premiers ?],
    [Nombres premiers, divisibilité, addition],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],

    [#strong[Conjecture des nombres premiers jumeaux]],
    [Existe-t-il une infinité de paires de nombres premiers qui diffèrent de 2, comme $(11,13)$ ou $(17,19)$ ?],
    [Nombres premiers, divisibilité],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],

    [#strong[Conjecture de Legendre]],
    [Entre deux carrés consécutifs $n^2$ et $(n+1)^2$, existe-t-il toujours au moins un nombre premier ?],
    [Nombres premiers, carrés, intervalles],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],

    [#strong[Conjecture de Brocard]],
    [Pour deux nombres premiers consécutifs $p_n$ et $p_(n+1)$, y a-t-il toujours au moins quatre nombres premiers entre $p_n^2$ et $p_(n+1)^2$ ?],
    [Nombres premiers, carrés],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],
  )

  #v(0.55cm)

  // ==========================================================
  // ARITHMÉTIQUE
  // ==========================================================

  #sous_sous_titre[
    Arithmétique et nombres entiers
  ]

  #v(0.15cm)

  #table(
    columns: (3.4cm, 1fr, 3.5cm, 1.5cm, 3.1cm),
    inset: 0.11cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Question]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Notions concernées]
      
    ],

    table.cell(fill: rgb(220,230,240))[
    
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Récompense connue]
      
    ],

    [#strong[Conjecture de Collatz]],
    [En partant d'un entier positif, si on le divise par 2 lorsqu'il est pair et qu'on le remplace par $3n+1$ lorsqu'il est impair, atteint-on toujours $1$ ?],
    [Entiers, divisibilité, parité, suites],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [120 millions JPY + autres offres connues],

    [#strong[Conjecture d'Erdős–Straus]],
    [Pour tout entier $n >= 2$, peut-on écrire $4/n$ comme somme de trois fractions unitaires positives ?],
    [Fractions, divisibilité, nombres entiers],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],

    [#strong[Conjecture de Beal]],
    [Si $A^x+B^y=C^z$ avec $x,y,z>2$, les trois nombres $A,B,C$ doivent-ils avoir un facteur premier commun ?],
    [Puissances, facteurs premiers, divisibilité],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [1 000 000 USD],
  )

  #v(0.55cm)

  // ==========================================================
  // GÉOMÉTRIE ET COMBINATOIRE
  // ==========================================================

  #sous_sous_titre[
    Géométrie et combinatoire
  ]

  #v(0.15cm)

  #table(
    columns: (3.4cm, 1fr, 3.5cm, 1.5cm, 3.1cm),
    inset: 0.11cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Question]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Notions concernées]
      
    ],

    table.cell(fill: rgb(220,230,240))[
   
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Récompense connue]
      
    ],

    [#strong[Conjecture d'Erdős sur les distances distinctes]],
    [Comment un ensemble de points peut-il déterminer le moins possible de distances différentes ?],
    [Géométrie, distances, combinatoire],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],

    [#strong[Problèmes ouverts sur le cercle unitaire]],
    [Certaines configurations de points et questions de distances sur le cercle unitaire donnent encore lieu à des problèmes ouverts.],
    [Géométrie, distances, configurations],
    [
      #text(
        weight: "bold",
        fill: rgb(210,130,0),
      )[Ouvert]
    ],
    [Aucune récompense officielle connue],
  )

  #v(0.55cm)

  // ==========================================================
  // ANALYSE
  // ==========================================================

  #sous_sous_titre[
    Analyse, fonctions et nombres
  ]

  #v(0.15cm)

  #table(
    columns: (3.4cm, 1fr, 3.5cm, 1.5cm, 3.1cm),
    inset: 0.11cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Question]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Notions concernées]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Récompense connue]
      
    ],

    [#strong[Hypothèse de Riemann]],
    [Les zéros non triviaux de la fonction zêta de Riemann ont-ils tous une partie réelle égale à $1/2$ ?],
    [Nombres premiers, nombres complexes, analyse],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD — Clay Mathematics Institute],

    [#strong[Conjecture de Birch et Swinnerton-Dyer]],
    [Peut-on relier le nombre de solutions rationnelles d'une courbe elliptique au comportement d'une fonction associée ?],
    [Équations, nombres rationnels, analyse],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD — Clay Mathematics Institute],
  )

  #v(0.55cm)

  // ==========================================================
  // ÉQUATIONS DIFFÉRENTIELLES
  // ==========================================================

  #sous_sous_titre[
    Équations différentielles et physique mathématique
  ]

  #v(0.15cm)

  #table(
    columns: (3.4cm, 1fr, 3.5cm, 1.5cm, 3.1cm),
    inset: 0.11cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Question]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[Notions concernées]
      
    ],

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Récompense connue]
      
    ],

    [#strong[Équations de Navier–Stokes]],
    [Les équations décrivant notamment les mouvements des fluides possèdent-elles toujours des solutions suffisamment régulières en dimension 3 ?],
    [Fonctions, dérivées, équations différentielles],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD — Clay Mathematics Institute],

    [#strong[Yang–Mills et le gap de masse]],
    [Peut-on démontrer mathématiquement l'existence d'un « gap de masse » dans la théorie quantique de Yang–Mills ?],
    [Physique mathématique, analyse, équations],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD — Clay Mathematics Institute],
  )

  #v(0.65cm)

  // ==========================================================
  // LES PROBLÈMES DU MILLÉNAIRE
  // ==========================================================

  #sous_sous_titre[
    Les problèmes du millénaire
  ]

  #v(0.2cm)

  En l'an 2000, le #strong[Clay Mathematics Institute] a sélectionné
  sept problèmes considérés comme particulièrement importants pour
  les mathématiques contemporaines.

  Une récompense de #strong[1 million de dollars américains] est
  associée à la résolution de chacun de ces problèmes. Le fonds
  initial annoncé par le CMI était de 7 millions de dollars,
  répartis à parts égales entre les sept problèmes.

  #v(0.35cm)

  #table(
    columns: (0.7cm, 1fr, 2.6cm, 3.5cm),
    inset: 0.12cm,
    stroke: 0.5pt + rgb(180,180,180),

    table.cell(fill: rgb(220,230,240))[
     
        #text(weight: "bold")[N°]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Problème]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[État]
      
    ],

    table.cell(fill: rgb(220,230,240))[
      
        #text(weight: "bold")[Récompense]
      
    ],

    [1],
    [Hypothèse de Riemann],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [2],
    [$P = $NP$$ ?],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [3],
    [Conjecture de Birch et Swinnerton-Dyer],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [4],
    [Conjecture de Hodge],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [5],
    [Équations de Navier–Stokes],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [6],
    [Yang–Mills et le gap de masse],
    [
      #text(
        weight: "bold",
        fill: rgb(190,40,40),
      )[Non résolu]
    ],
    [1 000 000 USD],

    [7],
    [Conjecture de Poincaré],
    [
      #text(
        weight: "bold",
        fill: green,
      )[Résolu]
    ],
    [1 000 000 USD — prix attribué en 2010],
  )

  #v(0.45cm)

    #text(
      size: 11pt,
      weight: "bold",
      fill: code-blue,
    )[
      6 des 7 problèmes du millénaire restent ouverts.
    ]
  

  #v(0.25cm)

    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      La conjecture de Poincaré a été résolue par Grigori Perelman.
      Le prix d'un million de dollars lui a été attribué,
      mais il a refusé la récompense.
    ]
  

  #v(0.65cm)

  // ==========================================================
  // À PROPOS DES RÉCOMPENSES
  // ==========================================================

  #pagebreak()

  #align(center)[

    #text(
      size: 11pt,
      weight: "bold",
      fill: code-blue,
    )[
      À PROPOS DES RÉCOMPENSES
    ]
  ]
    #v(0.2cm)
#align(center)[
    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      Une récompense ne constitue pas une preuve de difficulté
      mathématique et son absence ne diminue pas l'importance
      d'un problème.
    ]
]
  

  #v(0.35cm)

  Les montants indiqués correspondent à des récompenses ou offres
  de récompense publiquement associées aux problèmes au moment
  de la rédaction. Les conditions d'attribution peuvent être
  particulièrement strictes : publication dans une revue
  mathématique reconnue, vérification indépendante et acceptation
  de la démonstration par la communauté scientifique.

  Pour les problèmes du millénaire, le #strong[Clay Mathematics
  Institute] n'accepte pas simplement une solution envoyée
  directement par un chercheur. Ses règles prévoient notamment
  une publication dans une revue qualifiante, une période d'au
  moins deux ans et une acceptation générale par la communauté
  mathématique avant l'examen du prix.

  #v(0.65cm)

  // ==========================================================
  // MESSAGE FINAL
  // ==========================================================

  #align(center)[

    #text(
      size: 11pt,
      weight: "bold",
      fill: code-blue,
    )[
      UNE QUESTION PEUT TRAVERSER DES GÉNÉRATIONS
    ]

    #v(0.15cm)

    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[
      Peut-être qu'un jour, une solution commencera
      par une idée que personne n'avait encore imaginée.
    ]

  ]

]

