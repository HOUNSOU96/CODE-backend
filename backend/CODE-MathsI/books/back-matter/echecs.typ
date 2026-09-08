
// ==========================================================
// CODE — APPRENDRE À JOUER AUX ÉCHECS
// ==========================================================

#import "../../code/code.typ": *

// ==========================================================
// FONCTION PRINCIPALE
// ==========================================================

#let echecs() = [

  // ========================================================
  // TITRE
  // ========================================================

  #align(center)[

    #text(
      size: 26pt,
      weight: "bold",
      fill: code-blue,
    )[
      APPRENDRE À JOUER AUX ÉCHECS
    ]

    #v(0.1cm)

    #line(
      length: 5cm,
      stroke: 1.3pt + code-blue,
    )

  ]

  #text(
    size: 17pt,
    weight: "bold",
    fill: code-blue,
  )[
    Comprendre l'échiquier, les pièces, les règles
    et les premiers principes du jeu
  ]

  // ========================================================
  // INTRODUCTION
  // ========================================================

  #box(
    width: 100%,
    fill: rgb("#F8FAFC"),
    radius: 12pt,
    inset: 0.3cm,
    stroke: 0.5pt + rgb("#D5E2EF"),
  )[

    #text(
      size: 11.5pt,
    )[

      Les échecs sont un jeu de réflexion qui oppose
      #strong[deux joueurs] sur un échiquier.

      Chaque joueur dispose de seize pièces et joue à tour
      de rôle. Le but n'est pas de capturer toutes les pièces
      adverses : il consiste à mettre le #strong[roi adverse
      échec et mat].

      Pour jouer correctement, il faut apprendre à reconnaître
      l'échiquier, connaître le nom et le déplacement des pièces,
      comprendre les captures, savoir ce qu'est un échec,
      connaître les principales règles spéciales et reconnaître
      les différentes façons dont une partie peut se terminer.

      Cette partie du manuel est conçue pour permettre à une
      personne qui #strong[n'a jamais joué aux échecs] de
      comprendre progressivement les règles fondamentales du jeu.

      Les échecs développent également plusieurs capacités
      utiles en mathématiques :
      #strong[observer], #strong[raisonner],
      #strong[anticiper], #strong[calculer],
      #strong[comparer] et #strong[prendre une décision].
    ]

  ]

  // ========================================================
  // 1. L'ÉCHIQUIER
  // ========================================================

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    1. Découvrir l'échiquier
  ]

  L'#strong[échiquier] est le plateau sur lequel se déroule
  une partie d'échecs.

  Il comporte exactement :

  #strong[8 colonnes] - #strong[8 rangées] : donc #strong[64 cases] au total.

  Les cases sont alternativement claires et foncées.

 
  #image_full(
    "../../assets/images/echequier.png",
  )

  #v(0.2cm)

  #remarque[

    Lorsque l'échiquier est correctement placé devant toi,
    la case située dans le coin inférieur droit doit être
    une #strong[case claire].

    C'est une règle importante pour orienter correctement
    l'échiquier avant de commencer une partie.

  ]


  // ========================================================
  // 2. COLONNES, RANGÉES ET CASES
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    2. Les coordonnées de l'échiquier
  ]

  #v(0.15cm)

  Pour pouvoir désigner précisément une case, l'échiquier
  utilise un système de coordonnées.

  Les #strong[colonnes] sont repérées par les lettres :

  #align(center)[
   #strong[
  a #h(0.5em) b #h(0.5em) c #h(0.5em) d
  #h(0.5em) e #h(0.5em) f #h(0.5em) g #h(0.5em) h
]
  ]

  #v(0.1cm)

  Les #strong[rangées] sont repérées par les nombres :

  #align(center)[
    #strong[
  1 #h(1em) 2 #h(1em) 3 #h(1em) 4
  #h(1em) 5 #h(1em) 6 #h(1em) 7 #h(1em) 8
]
  ]

  #v(0.15cm)

  Une case est donc désignée par :

  #align(center)[
    #strong[lettre de la colonne + numéro de la rangée]
  ]

  #v(0.1cm)

  Par exemple :

  #align(center)[
  $a 1$ #h(1.5em) $c 5$ #h(1.5em) $e 4$ #h(1.5em) $h 8$
]

  #v(0.15cm)

  #exemple[

    La case $e 4$ correspond à la case située dans la
    colonne $e$ et dans la rangée $4$.

    De même, $b 7$ désigne la case située dans la colonne
    $b$ et dans la rangée $7$.

  ]

  #v(0.15cm)

  #retenir[

    Pour nommer une case, retiens toujours :

    #align(center)[
  #strong[COLONNE → LETTRE]
  #h(1.5em)
  #strong[RANGÉE → NOMBRE]
]

    Ainsi, on écrit $e 4$ et non $4 e$.

  ]


  // ========================================================
  // 3. ORIENTATION ET CAMP DES JOUEURS
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    3. Les deux camps
  ]

  #v(0.15cm)

  Les échecs opposent deux joueurs :

  #v(0.08cm)

  • les #strong[Blancs] ;

  • les #strong[Noirs].

  #v(0.12cm)

  Les Blancs jouent toujours #strong[en premier].

  Les joueurs jouent ensuite alternativement :

  #align(center)[
    #strong[Blancs → Noirs → Blancs → Noirs → ...]
  ]

  #v(0.15cm)

  Chaque joueur possède son propre camp.

  Pour les Blancs, les pièces commencent du côté des rangées
  $1$ et $2$.

  Pour les Noirs, elles commencent du côté des rangées
  $7$ et $8$.


  // ========================================================
  // 4. LES 16 PIÈCES
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    4. Les pièces du jeu
  ]

  #v(0.15cm)

  Au début de la partie, chaque joueur possède
  #strong[16 pièces].
  Il existe six types de pièces.

  #table(
    columns: (3cm, 2cm, 5cm),
    align: center + horizon,
    stroke: 0.5pt + rgb("#C9D7E5"),
    inset: 0.15cm,

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Pièce]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Nombre]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Caractéristique]
    ],

    [Roi], [1], [Pièce la plus importante],

    [Dame], [1], [Pièce la plus puissante],

    [Tour], [2], [Se déplace horizontalement ou verticalement],

    [Fou], [2], [Se déplace en diagonale],

    [Cavalier], [2], [Se déplace en L et peut sauter],

    [Pion], [8], [Avance vers le camp adverse],
  )

  #retenir[

    Chaque joueur possède :

    #align(center)[
      #strong[
        1 roi + 1 dame + 2 tours + 2 fous + 2 cavaliers + 8 pions = 16 pièces.
      ]
    ]
    Les deux joueurs possèdent donc ensemble
    #strong[32 pièces] au début de la partie.

  ]


  // ========================================================
  // 5. INSTALLER LES PIÈCES
  // ========================================================

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    5. Comment placer les pièces ?
  ]

  Avant de commencer, il faut placer correctement les pièces.

  Pour les Blancs :

  • les huit pièces principales occupent la rangée $1$ ;

  • les huit pions occupent la rangée $2$.

  Pour les Noirs :

  • les huit pièces principales occupent la rangée $8$ ;

  • les huit pions occupent la rangée $7$.

  #v(0.15cm)

  Sur la première rangée, de gauche à droite du point de vue
  des Blancs, on place :

  #align(center)[
    #strong[
      Tour — Cavalier — Fou — Dame — Roi — Fou — Cavalier — Tour
    ]
  ]

  Les Noirs disposent exactement du même ordre.

  #remarque[

    La règle la plus simple pour placer les dames est :

    #align(center)[
      #strong[« La dame prend sa couleur. »]
    ]

    La dame blanche se trouve sur une case blanche et la dame
    noire sur une case noire.

  ]


  // ========================================================
  // 6. LE ROI
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    6. Le roi
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/roi.png",
  )

  #v(0.15cm)

  Chaque joueur possède un seul roi.

  Le roi peut se déplacer d'#strong[une seule case] dans
  n'importe quelle direction :

  • horizontalement • verticalement • en diagonale.

  #v(0.15cm)

  Si le roi se trouve en $e 4$, ses déplacements possibles
  correspondent aux cases voisines accessibles autour de lui.

  #v(0.15cm)

  Mais il existe une règle fondamentale :

  #retenir[

    Le roi #strong[ne peut jamais se déplacer sur une case
    contrôlée par une pièce adverse].

  ]

  Le roi ne peut donc pas se mettre volontairement en situation
  d'être capturé.

  #v(0.15cm)

  Le roi est la pièce la plus importante, mais ce n'est pas
  la pièce la plus puissante.


  // ========================================================
  // 7. LA DAME
  // ========================================================

  #pagebreak()

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    7. La dame
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/dame.png",
  )

  #v(0.15cm)

  Chaque joueur possède une dame.

  La dame peut se déplacer d'autant de cases qu'elle le souhaite
  dans trois types de directions :

  • horizontalement ;

  • verticalement ;

  • en diagonale.

  #v(0.15cm)

  Elle peut donc combiner les mouvements de la tour et du fou.

  #remarque[

    La dame est généralement considérée comme la pièce la plus
    puissante du jeu.

    Cependant, perdre la dame ne signifie pas automatiquement
    perdre la partie, tandis que perdre le roi signifie que
    la partie est terminée.

  ]

#pagebreak()
  // ========================================================
  // 8. LA TOUR
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    8. La tour
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/tour.png",
  )

  #v(0.15cm)

  Chaque joueur possède deux tours.

  Une tour se déplace uniquement :

  • horizontalement ;

  • verticalement.

  Elle peut parcourir plusieurs cases en un seul coup.

  #v(0.15cm)

  Une tour ne peut cependant pas traverser une autre pièce.

  #exemple[

    Si une pièce se trouve entre la tour et la destination,
    la tour doit s'arrêter avant cette pièce.

    Si la pièce qui bloque le passage appartient à l'adversaire,
    la tour peut éventuellement la capturer, mais elle ne peut
    pas aller au-delà d'elle lors du même coup.

  ]

#pagebreak()
  // ========================================================
  // 9. LE FOU
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    9. Le fou
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/fou.png",
  )

  #v(0.15cm)

  Chaque joueur possède deux fous.

  Le fou se déplace uniquement en diagonale.

  Il peut parcourir plusieurs cases en un seul coup si son chemin
  est libre.

  #v(0.15cm)

  Un fou qui commence sur une case claire restera toujours sur
  des cases claires.

  De même, un fou qui commence sur une case sombre restera
  toujours sur des cases sombres.

  #remarque[

    Les deux fous d'un même joueur sont donc complémentaires :

    • l'un contrôle les cases claires ;

    • l'autre contrôle les cases sombres.

  ]

#pagebreak()
  // ========================================================
  // 10. LE CAVALIER
  // ========================================================

  

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    10. Le cavalier
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/cavalier.png",
  )

  #v(0.15cm)

  Chaque joueur possède deux cavaliers.

  Le cavalier se déplace selon une forme ressemblant à la lettre
  #strong[L].

  Il se déplace :

  • de deux cases dans une direction ;

  • puis d'une case dans une direction perpendiculaire.

  Il peut également effectuer le mouvement inverse :

  • une case dans une direction ;

  • puis deux cases perpendiculairement.

  #v(0.15cm)

  #retenir[

    Le cavalier est la seule pièce qui peut
    #strong[sauter par-dessus les autres pièces].

  ]

  Il peut donc effectuer son déplacement même si une autre pièce
  se trouve entre sa case de départ et sa case d'arrivée.

#pagebreak()
  // ========================================================
  // 11. LE PION
  // ========================================================

  

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    11. Le pion
  ]

  #v(0.15cm)

  #image_full(
    "../../assets/images/pion.png",
  )

  #v(0.05cm)

  Chaque joueur possède huit pions. Le pion est particulier car son déplacement et sa capture
  ne se font pas de la même manière.

  #v(0.05cm)

  #strong[Pour avancer :]
Un pion avance normalement d'une case vers l'avant. Lors de son #strong[premier déplacement], il peut avancer
  de deux cases, à condition que les deux cases devant lui
  soient libres.

  #v(0.05cm)

  #strong[Pour capturer :]
Un pion capture une pièce adverse en avançant
  #strong[d'une case en diagonale vers l'avant].
 Un pion ne capture donc pas une pièce située directement
  devant lui.

  #v(0.1cm)

  #remarque[

    Les Blancs avancent vers les rangées de plus grands nombres
    et les Noirs vers les rangées de plus petits nombres.

    Ainsi, les pions blancs avancent de la rangée $2$ vers la
    rangée $8$, tandis que les pions noirs avancent de la rangée
    $7$ vers la rangée $1$.

  ]


  // ========================================================
  // 12. RÉSUMÉ DES DÉPLACEMENTS
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    12. Résumé des déplacements
  ]

  #v(0.15cm)

  #table(
    columns: (3cm, 1fr),
    align: center + horizon,
    stroke: 0.5pt + rgb("#C9D7E5"),
    inset: 0.15cm,

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Pièce]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Déplacement]
    ],

    [Roi],
    [1 case dans toutes les directions],

    [Dame],
    [Horizontalement, verticalement et en diagonale],

    [Tour],
    [Horizontalement et verticalement],

    [Fou],
    [En diagonale],

    [Cavalier],
    [En L, avec possibilité de sauter],

    [Pion],
    [En avant pour avancer, en diagonale pour capturer],
  )


  // ========================================================
  // 13. LES OBSTACLES
  // ========================================================

  #v(1cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    13. Une pièce peut-elle traverser une autre pièce ?
  ]

  #v(0.15cm)

  En général, une pièce qui se déplace sur plusieurs cases
  ne peut pas traverser une autre pièce.

  C'est le cas notamment de :

  • la dame ;

  • la tour ;

  • le fou.

  #v(0.15cm)

  Le cavalier constitue l'exception : il peut sauter par-dessus
  les autres pièces.

  Le roi et le pion se déplacent sur un nombre limité de cases
  et ne traversent pas non plus les pièces.

  #retenir[

    #strong[Une pièce bloque généralement le chemin d'une autre.]

    Le cavalier est l'exception importante à retenir.

  ]


  // ========================================================
  // 14. LES CAPTURES
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    14. Capturer une pièce
  ]

  #v(0.15cm)

  Une #strong[capture] consiste à déplacer une pièce sur
  une case occupée par une pièce adverse, lorsque le déplacement
  de la pièce le permet.

  La pièce capturée est alors retirée de l'échiquier.

  #v(0.15cm)

  On ne peut jamais capturer sa propre pièce.

  #v(0.15cm)

  #exemple[

    Une tour blanche peut capturer une pièce noire située
    sur la même colonne ou sur la même rangée si aucune pièce
    ne bloque son chemin.

  ]

  #v(0.15cm)

  Une capture n'est pas obligatoire simplement parce qu'elle
  est possible.

  Le joueur choisit parmi les coups légaux disponibles.


  // ========================================================
  // 15. LES COUPS LÉGAUX
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    15. Qu'est-ce qu'un coup légal ?
  ]

  #v(0.15cm)

  Un #strong[coup légal] est un déplacement autorisé par
  les règles des échecs.

  Un coup n'est donc pas légal simplement parce que la pièce
  peut physiquement atteindre une case.

  Le coup doit également respecter la règle fondamentale
  concernant le roi.

  #retenir[

    Un joueur ne peut jamais jouer un coup qui laisse son propre
    roi en échec.

  ]


  // ========================================================
  // 16. L'ÉCHEC
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    16. L'échec
  ]

  #v(0.05cm)

  Un roi est en #strong[échec] lorsqu'une pièce adverse
  attaque la case où il se trouve.

  Le joueur dont le roi est en échec doit obligatoirement
  effectuer un coup qui supprime cette situation.

  #v(0.05cm)

  Il existe principalement trois façons de répondre à un échec :

  #strong[1. Déplacer le roi:]
Le roi peut se déplacer vers une case qui n'est pas contrôlée
  par une pièce adverse.

  #strong[2. Capturer la pièce qui donne l'échec:]
Cette possibilité n'existe que si la capture est légale
  et si le roi n'est pas encore en danger après la capture.

  #strong[3. Interposer une pièce:]
Une pièce peut parfois être placée entre l'attaquant et le roi.

  #v(0.05cm)

  #remarque[

    On ne peut pas interposer une pièce contre toutes les formes
    d'échec.

    Par exemple, contre un cavalier, il est impossible de bloquer
    l'attaque en plaçant une pièce entre le cavalier et le roi.

  ]


  // ========================================================
  // 17. L'ÉCHEC ET MAT
  // ========================================================

  #v(0.2cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    17. L'échec et mat
  ]

  #v(0.05cm)

  L'#strong[échec et mat] est la situation qui met fin
  à la partie par victoire d'un joueur.
Il faut réunir deux conditions :
le roi est en échec et aucun coup légal ne permet de supprimer l'échec.

  #retenir[

    #strong[
      Échec + aucune défense légale = ÉCHEC ET MAT
    ]

  ]

  Le joueur dont le roi est échec et mat perd immédiatement
  la partie.

  #v(0.05cm)

  Le roi n'est pas capturé physiquement. La partie s'arrête dès qu'il est impossible d'échapper
  légalement à l'échec.


  // ========================================================
  // 18. LE MATÉRIEL ET LA VALEUR DES PIÈCES
  // ========================================================

  #v(0.2cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    18. La valeur approximative des pièces
  ]

  #v(0.05cm)

  Les joueurs utilisent souvent des valeurs approximatives
  pour comparer les pièces.

  #v(0.05cm)

  #table(
    columns: (4cm, 3cm),
    align: center + horizon,
    stroke: 0.5pt + rgb("#C9D7E5"),
    inset: 0.15cm,

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Pièce]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Valeur indicative]
    ],

    [Pion], [1],

    [Cavalier], [3],

    [Fou], [3],

    [Tour], [5],

    [Dame], [9],

    [Roi], [Inestimable],
  )

  #v(1cm)

  #remarque[

    Ces nombres ne sont pas des prix.

    Ils servent à évaluer approximativement les échanges.

    Par exemple, échanger une tour contre un pion représente
    généralement une perte importante de matériel.

    Cependant, la valeur réelle d'une pièce dépend aussi de sa
    position, de son activité et de la situation sur l'échiquier.

  ]


  // ========================================================
  // 19. LE ROQUE
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    19. Le roque
  ]

  #v(0.15cm)

  Le #strong[roque] est un coup spécial dans lequel
  #strong[le roi et une tour se déplacent simultanément].

  Il existe deux types de roque :

  • le #strong[petit roque] ;

  • le #strong[grand roque].

  #v(0.15cm)

  Lors d'un petit roque, le roi se déplace de deux cases
  vers la tour située de son côté roi, puis cette tour passe
  de l'autre côté du roi.

  Lors d'un grand roque, le roi se déplace de deux cases
  vers la tour située de son côté dame, puis cette tour passe
  également de l'autre côté du roi.

  #v(0.15cm)

  Pour que le roque soit légal :

  • le roi ne doit jamais avoir bougé auparavant ;

  • la tour utilisée ne doit jamais avoir bougé auparavant ;

  • les cases situées entre le roi et la tour doivent être libres ;

  • le roi ne doit pas être en échec au moment du roque ;

  • le roi ne doit pas traverser une case contrôlée par une
    pièce adverse ;

  • le roi ne doit pas arriver sur une case contrôlée par une
    pièce adverse.

  #retenir[

    Le roi ne peut donc pas roquer :

    • lorsqu'il est en échec ;

    • en traversant une case attaquée ;

    • en arrivant sur une case attaquée.

  ]


  // ========================================================
  // 20. LA PROMOTION
  // ========================================================

  #pagebreak()

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    20. La promotion d'un pion
  ]

  #v(0.15cm)

  Lorsqu'un pion atteint la dernière rangée du camp adverse,
  il doit être #strong[promu].
  Un pion blanc qui atteint la rangée $8$ doit être transformé.
  Un pion noir qui atteint la rangée $1$ doit également être
  transformé.

  Il peut devenir :

  • une dame ;

  • une tour ;

  • un fou ;

  • un cavalier.


  Le joueur n'est pas obligé de choisir une pièce qui a déjà
  été capturée.
  Il peut donc, par exemple, avoir plusieurs dames après
  plusieurs promotions.

  #retenir[

    Un pion arrivé au bout de l'échiquier
    #strong[ne reste pas un pion] : il est obligatoirement promu.

  ]


  // ========================================================
  // 21. LA PRISE EN PASSANT
  // ========================================================

 

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    21. La prise en passant
  ]

  #v(0.05cm)

  La #strong[prise en passant] est une capture particulière
  réservée aux pions.
  Elle peut se produire lorsqu'un pion avance de deux cases
  depuis sa position initiale et arrive à côté d'un pion adverse.
  Le pion adverse aurait pu capturer ce pion s'il n'avait
  avancé que d'une seule case.
  Dans cette situation, le pion adverse peut effectuer une
  capture spéciale en se déplaçant comme s'il avait capturé
  le pion après son déplacement d'une seule case.
  Cette capture doit être effectuée
  #strong[immédiatement au coup suivant].
  Si le joueur ne l'effectue pas immédiatement, la possibilité
  de prise en passant disparaît.

  #remarque[

    C'est une règle particulière qu'un débutant peut rarement
    rencontrer au début, mais elle fait partie intégrante
    des règles officielles des échecs.

  ]


  // ========================================================
  // 22. LE PAT
  // ========================================================

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    22. Le pat
  ]

  #v(0.15cm)

  Le #strong[pat] est une situation de partie nulle.
  Il se produit lorsque :

  • c'est au joueur de jouer ;

  • son roi n'est pas en échec ;

  • aucun de ses coups légaux n'est possible.

  #retenir[

    #strong[
      Roi pas en échec + aucun coup légal = PAT = partie nulle.
    ]

  ]

  Il ne faut surtout pas confondre le pat avec l'échec et mat.

  Dans l'échec et mat, le roi est en échec.

  Dans le pat, le roi #strong[n'est pas] en échec.


  // ========================================================
  // 23. LES AUTRES CAS DE NULLE
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    23. Comment une partie peut-elle être nulle ?
  ]

  #v(0.15cm)

  Une partie peut être déclarée nulle dans plusieurs situations.

  Parmi les cas importants :

  • le pat ;

  • l'accord entre les deux joueurs ;

  • certaines positions dans lesquelles aucun joueur ne peut
    légalement réaliser un échec et mat ;

  • la répétition d'une même position selon les règles
    applicables ;

  • la règle des cinquante coups, dans les conditions prévues
    par les règles officielles.

  #v(0.15cm)

  #remarque[

    Une partie nulle signifie qu'aucun des deux joueurs
    n'est déclaré vainqueur.

  ]


  // ========================================================
  // 24. COMMENT GAGNE-T-ON ?
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    24. Les différentes façons de gagner
  ]

  #v(0.15cm)

  La manière classique de gagner une partie est de mettre
  le roi adverse #strong[échec et mat].

  Une partie peut également être gagnée si l'adversaire
  abandonne.

  Dans une compétition, une victoire peut aussi être attribuée
  dans certaines situations prévues par le règlement, par exemple
  lorsqu'un joueur dépasse le temps qui lui est accordé.


  // ========================================================
  // 25. LE TEMPS AUX ÉCHECS
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    25. La pendule d'échecs
  ]

  #v(0.15cm)

  Dans de nombreuses parties, chaque joueur dispose d'un temps
  limité.

  Une #strong[pendule d'échecs] possède deux cadrans :
  un pour chaque joueur.

  Lorsqu'un joueur joue son coup, il appuie sur son côté
  de la pendule.

  Le temps du joueur s'arrête et celui de son adversaire
  commence à s'écouler.

  #v(0.15cm)

  Il existe plusieurs cadences de jeu :

  • parties lentes ;

  • parties rapides ;

  • blitz ;

  • autres cadences définies par les organisateurs.

  #v(0.15cm)

  La gestion du temps devient alors une partie de la stratégie.


  // ========================================================
  // 26. COMMENCER UNE PARTIE
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    26. Comment commencer une partie ?
  ]

  #v(0.15cm)

  Pour commencer :

  #strong[Étape 1.]
  Place correctement l'échiquier.

  La case claire doit se trouver dans le coin inférieur droit
  de chaque joueur.

  #strong[Étape 2.]
  Place les tours dans les coins.

  #strong[Étape 3.]
  Place les cavaliers à côté des tours.

  #strong[Étape 4.]
  Place les fous à côté des cavaliers.

  #strong[Étape 5.]
  Place la dame sur sa couleur.

  #strong[Étape 6.]
  Place le roi sur la dernière case disponible.

  #strong[Étape 7.]
  Place les huit pions devant les pièces principales.

  #strong[Étape 8.]
  Les Blancs jouent le premier coup.


  // ========================================================
  // 27. LES PREMIERS COUPS
  // ========================================================

  #v(0.05cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    27. Que faire au début de la partie ?
  ]

  #v(0.15cm)

  Un débutant peut retenir quelques principes simples.

  #v(0.1cm)

  #strong[1. Contrôler le centre.]

  Les quatre cases centrales $d 4$, $e 4$, $d 5$ et $e 5$
  jouent généralement un rôle important.

  #strong[2. Développer les pièces.]

  Il est généralement utile de sortir progressivement
  les cavaliers et les fous de leurs cases initiales.

  #strong[3. Mettre le roi en sécurité.]

  Le roque peut être un moyen important de mettre rapidement
  le roi à l'abri.

  #strong[4. Ne pas sortir la dame trop tôt sans raison.]

  Une dame sortie trop tôt peut être attaquée par des pièces
  moins précieuses et obliger le joueur à perdre plusieurs
  temps.

  #strong[5. Observer l'adversaire.]

  Il ne faut jamais réfléchir uniquement à son propre plan.

  #strong[6. Éviter les coups inutiles.]

  Chaque coup doit avoir une raison.


  // ========================================================
  // 28. LA MÉTHODE POUR CHOISIR UN COUP
  // ========================================================

  #v(0.05cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    28. Une méthode simple pour réfléchir
  ]

  #v(0.15cm)

  Avant chaque coup, prends l'habitude de te poser les questions
  suivantes.

  #v(0.1cm)

  #strong[Question 1 — Mon roi est-il en sécurité ?]

  Vérifie si ton roi est actuellement en échec ou s'il existe
  une menace directe contre lui.

  #strong[Question 2 — Que menace mon adversaire ?]

  Cherche les attaques contre tes pièces et ton roi.

  #strong[Question 3 — Quelles sont mes possibilités ?]

  Cherche plusieurs coups candidats.

  #strong[Question 4 — Que se passe-t-il après mon coup ?]

  Imagine la réponse la plus forte de ton adversaire.

  #strong[Question 5 — Est-ce que je laisse une pièce sans défense ?]

  Vérifie les pièces qui pourraient être capturées.

  #strong[Question 6 — Mon coup améliore-t-il ma position ?]

  Essaie de jouer un coup qui possède une véritable utilité.


  // ========================================================
  // 29. LA NOTATION DES COUPS
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    29. Comment noter une partie ?
  ]

  #v(0.15cm)

  Les joueurs peuvent noter leurs coups grâce à la
  #strong[notation algébrique].

  Cette notation permet de conserver la trace de la partie.

  #v(0.15cm)

  Les cases sont toujours désignées par une lettre et un nombre.

  Pour les pièces, on utilise généralement les lettres
  internationales suivantes :

  #table(
    columns: (3.5cm, 2.5cm, 2.5cm),
    align: center + horizon,
    stroke: 0.5pt + rgb("#C9D7E5"),
    inset: 0.13cm,

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Pièce]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Notation]
    ],

    table.cell(fill: rgb("#DCE6F0"))[
      #text(weight: "bold")[Anglais]
    ],

    [Roi], [K], [King],

    [Dame], [Q], [Queen],

    [Tour], [R], [Rook],

    [Fou], [B], [Bishop],

    [Cavalier], [N], [Knight],

    [Pion], [Aucune lettre], [Aucune lettre],
  )

  #v(0.15cm)

  #remarque[

    La notation internationale utilise les noms anglais
    des pièces.

    Le cavalier est représenté par #strong[N] et non par C,
    car la lettre K est déjà utilisée pour le roi.

  ]

  #v(0.15cm)

  #exemple[

    Si un cavalier se déplace vers $f 3$, on écrit :
      #strong[Nf3]
    

    Si une dame se déplace vers $h 5$, on écrit :
      #strong[Qh5]
    

  ]


  // ========================================================
  // 30. NOTER UNE CAPTURE
  // ========================================================

  #v(0.05cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    30. Comment noter une capture ?
  ]

  #v(0.15cm)

  Lorsqu'une pièce capture une autre pièce, on utilise
  généralement le symbole #strong[x].

  #exemple[

    Si une dame capture une pièce située en $d 5$ :
      #strong[Qxd5]
    

    Le symbole $x$ indique qu'il s'agit d'une capture.

  ]

  Pour un pion, on indique la colonne de départ suivie de
  $x$ puis de la case d'arrivée.

  #exemple[

    Un pion situé sur la colonne $e$ capture une pièce
    en $d 5$ :
      #strong[exd5]
    

  ]


  // ========================================================
  // 31. ÉCHEC ET MAT DANS LA NOTATION
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    31. Les symboles + et \#
  ]

  #v(0.15cm)

  Dans la notation des parties, certains symboles permettent
  de signaler une situation particulière.

  #v(0.1cm)

  #strong[+]:
indique généralement un #strong[échec].

  #strong[#sym.hash]:
indique généralement un #strong[échec et mat].

  #exemple[

      #strong[Qh5+]
    : signifie que la dame se déplace en $h 5$ et donne échec.

  ]

  #exemple[

    
      #strong[Qh7#sym.hash]
    : signifie que la dame se déplace en $h 7$ et donne échec
    et mat.

  ]


  // ========================================================
  // 32. LE PETIT ROQUE ET LE GRAND ROQUE DANS LA NOTATION
  // ========================================================


  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    32. Noter le roque
  ]

  #v(0.15cm)

  Le petit roque est noté :
    #strong[O-O]
  

  Le grand roque est noté :
    #strong[O-O-O]
  


  Ces symboles permettent d'identifier rapidement le type
  de roque joué.


  // ========================================================
  // 33. LE MATÉRIEL ET LA POSITION
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    33. Avoir plus de pièces ne suffit pas
  ]

  #v(0.15cm)

  Aux échecs, avoir davantage de matériel constitue souvent
  un avantage, mais ce n'est pas la seule chose qui compte.

  Une position peut être meilleure ou pire selon :

  • la sécurité du roi ;

  • l'activité des pièces ;

  • le contrôle du centre ;

  • la structure des pions ;

  • l'espace disponible ;

  • les menaces contre le roi adverse ;

  • les possibilités tactiques.

  #v(0.15cm)

  #remarque[

    Une pièce peut avoir une valeur théorique élevée mais être
    mal placée.

    À l'inverse, une pièce moins précieuse peut devenir
    extrêmement forte si elle occupe une excellente position.

  ]


  // ========================================================
  // 34. LES ERREURS DU DÉBUTANT
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    34. Les erreurs à éviter
  ]

  #v(0.15cm)

  Un débutant doit particulièrement éviter :

  #v(0.08cm)

  • de laisser son roi sans protection ;

  • de donner gratuitement des pièces ;

  • d'oublier les attaques de l'adversaire ;

  • de jouer trop rapidement ;

  • de déplacer inutilement la même pièce plusieurs fois ;

  • de sortir la dame sans raison ;

  • d'oublier qu'un pion capture différemment de son déplacement ;

  • de jouer un coup qui laisse son propre roi en échec ;

  • de chercher uniquement à capturer sans regarder la position
    générale.


  // ========================================================
  // 35. PETIT EXEMPLE DE RÉFLEXION
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    35. Comment réfléchir comme un joueur d'échecs ?
  ]

  #v(0.15cm)

  Imaginons que tu veuilles jouer un coup. Ne pense pas seulement :
#strong[« Quel coup puis-je jouer ? »]
  

  Pose-toi plutôt cette série de questions :
    #strong[
      Que menace mon adversaire ?
    ]
    #strong[
      Quel est son meilleur coup ?
    ]
    #strong[
      Quelles sont mes possibilités ?
    ]
    #strong[
      Que répondra-t-il à mon coup ?
    ]
    #strong[
      Mon roi restera-t-il en sécurité ?
    
  ]

  #v(0.15cm)

  Cette manière de réfléchir est particulièrement intéressante
  pour les mathématiques : on observe une situation, on cherche
  plusieurs possibilités, on anticipe les conséquences et on
  choisit la solution la plus pertinente.


  // ========================================================
  // 36. CHECK-LIST AVANT CHAQUE COUP
  // ========================================================

  #v(0.4cm)

  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    36. La check-list du joueur
  ]

  #v(0.15cm)

  Avant de jouer, vérifie :

  #v(0.08cm)

  #strong[□] Mon roi est-il en échec ?

  #strong[□] Que menace mon adversaire ?

  #strong[□] Quelle pièce adverse attaque quelque chose ?

  #strong[□] Mes pièces sont-elles protégées ?

  #strong[□] Mon coup est-il légal ?

  #strong[□] Quelle sera la réponse de mon adversaire ?

  #strong[□] Est-ce que je donne gratuitement une pièce ?

  #strong[□] Mon roi restera-t-il en sécurité après mon coup ?

  #strong[□] Mon coup améliore-t-il réellement ma position ?


  // ========================================================
  // 37. SYNTHÈSE DES RÈGLES ESSENTIELLES
  // ========================================================

  #v(0.45cm)

  

    #box(
      width: 13.8cm,
      fill: rgb("#E8F1FA"),
      radius: 10pt,
      inset: 0.3cm,
    )[

      #text(
        size: 12pt,
        weight: "bold",
        fill: code-blue,
      )[
        LES 10 RÈGLES À CONNAÎTRE
      ]

      #v(0.15cm)

      #strong[1.] Les Blancs jouent toujours en premier.

      #v(0.06cm)

      #strong[2.] Chaque joueur possède 16 pièces.

      #v(0.06cm)

      #strong[3.] Chaque pièce possède son propre mode de déplacement.

      #v(0.06cm)

      #strong[4.] Une pièce ne peut généralement pas traverser
      une autre pièce.

      #v(0.06cm)

      #strong[5.] Le cavalier peut sauter par-dessus les pièces.

      #v(0.06cm)

      #strong[6.] Un joueur ne peut jamais laisser son propre roi
      en échec.

      #v(0.06cm)

      #strong[7.] Le but est de mettre le roi adverse échec et mat.

      #v(0.06cm)

      #strong[8.] Le pat entraîne une partie nulle.

      #v(0.06cm)

      #strong[9.] Un pion arrivé sur la dernière rangée doit être promu.

      #v(0.06cm)

      #strong[10.] Le roque et la prise en passant sont des coups
      soumis à des conditions particulières.

    

  ]


  // ========================================================
  // 38. À RETENIR
  // ========================================================

  #v(0.5cm)

 

    #box(
      width: 13.8cm,
      fill: rgb("#F8FAFC"),
      radius: 10pt,
      inset: 0.3cm,
      stroke: 0.5pt + rgb("#D5E2EF"),
    )[

      #text(
        size: 12pt,
        weight: "bold",
        fill: code-blue,
      )[
        À RETENIR
      ]

      #v(0.12cm)

      Pour commencer à jouer aux échecs, je dois savoir :

      #v(0.05cm)

      • orienter correctement l'échiquier ;

      #v(0.05cm)

      • repérer les cases grâce aux lettres et aux nombres ;

      #v(0.05cm)

      • reconnaître les six types de pièces ;

      #v(0.05cm)

      • connaître le déplacement de chaque pièce ;

      #v(0.05cm)

      • comprendre la différence entre déplacement et capture ;

      #v(0.05cm)

      • comprendre les notions d'échec et d'échec et mat ;

      #v(0.05cm)

      • connaître le roque ;

      #v(0.05cm)

      • connaître la promotion des pions ;

      #v(0.05cm)

      • comprendre la prise en passant ;

      #v(0.05cm)

      • reconnaître le pat et les principales situations de nulle ;

      #v(0.05cm)

      • savoir noter les coups d'une partie ;

      #v(0.05cm)

      • réfléchir aux menaces de l'adversaire avant de jouer.

    

  ]


  // ========================================================
  // CONCLUSION
  // ========================================================

  #v(2cm)

  #align(center)[

    #text(
      size: 13pt,
      weight: "bold",
      fill: code-blue,
    )[
      DES CASES, DES PIÈCES, DES CHOIX
    ]

    #v(0.15cm)

    #text(
      size: 11pt,
      style: "italic",
      fill: code-gray,
    )[
      Aux échecs comme en mathématiques,
      comprendre les règles est le début du raisonnement.
    ]

  ]

]

