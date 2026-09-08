// ==========================================================
// SOMMAIRE DES NOTIONS
// CODE-MATHS
//
// Structure :
// Domaine → Page du domaine
// Notion → Page de la notion
// Parcours → Page du parcours
// ==========================================================


#import "../../code/code.typ": *


// ==========================================================
// FONCTION — NUMÉRO DE PAGE AUTOMATIQUE
// ==========================================================
//
// Le label est transmis sous forme de texte.
// Exemple :
// #page-ref("notion-entiers-naturels")
//
// Si le label n'existe pas encore, on affiche "—".
// ==========================================================


// ==========================================================
// NUMÉRO DE PAGE
// ==========================================================

#let page-ref(label-name) = context {
  let ref = label(label-name)
  let pages = counter(page).at(ref)

  if pages.len() > 0 {
    str(pages.first())
  } else {
    "—"
  }
}


// ==========================================================
// RÉCUPÉRER UN TITRE DEPUIS SON ID
// ==========================================================

#let titre-ref(id) = context {
  let resultats = query(metadata)
  let trouve = none

  for resultat in resultats {
    if resultat.value.id == id {
      trouve = resultat.value.titre
      break
    }
  }

  if trouve != none {
    trouve
  } else {
    "Titre introuvable"
  }
}

// ==========================================================
// FONCTION — LIGNE D'UN PARCOURS DANS LE SOMMAIRE
// ==========================================================

#let parcours-sommaire(titre, page, couleur: code-gray) = {
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 0.08cm,

    // ------------------------------------------------------
    // TITRE
    // ------------------------------------------------------

    text(
      size: 8pt,
      weight: "bold",
      fill: couleur,
    )[
      #titre
    ],

    // ------------------------------------------------------
    // POINTILLÉS
    // ------------------------------------------------------

    box(
      width: 100%,
      clip: true,
    )[
      #text(
        size: 7pt,
        fill: rgb("#999999"),
      )[
        . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      ]
    ],

    // ------------------------------------------------------
    // PAGE
    // ------------------------------------------------------

    text(
      size: 8pt,
      weight: "bold",
      fill: couleur,
    )[
      p. #page
    ],
  )
}
// ==========================================================
// FONCTION — PARCOURS
// ==========================================================
//
// Affiche le nom du parcours et sa page.
// Exemple :
//
// 📘 6ᵉ — p. 25
//
// Le label correspond à la page de début du parcours.
// ==========================================================


#let parcours-ref(
  titre,
  label-name,
) = [

  #text(
    size: 8.3pt,
    fill: rgb("#444444"),
  )[

    📘 #titre

    #h(0.12cm)

    #text(
      size: 8pt,
      weight: "bold",
      fill: code-blue,
    )[

      p. #page-ref(label-name)

    ]

  ]

  #v(0.04cm)

]




// ==========================================================
// FONCTION — LIGNE TITRE + POINTILLÉS + PAGE
// ==========================================================

#let ligne-sommaire(
  titre,
  page,
  couleur: code-gray,
  taille: 8pt,
) = {
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 0.08cm,

    // ------------------------------------------------------
    // TITRE
    // ------------------------------------------------------

    text(
      size: taille,
      weight: "bold",
      fill: couleur,
    )[
      #titre
    ],

    // ------------------------------------------------------
    // POINTILLÉS
    // ------------------------------------------------------

    box(
      width: 100%,
      clip: true,
    )[
      #text(
        size: 7pt,
        fill: rgb("#999999"),
      )[
        . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
      ]
    ],

    // ------------------------------------------------------
    // PAGE
    // ------------------------------------------------------

    text(
      size: taille,
      weight: "bold",
      fill: couleur,
    )[
      p. #page
    ],
  )
}

// ==========================================================
// FONCTION — NOTION
// ==========================================================
//
// Une notion possède :
//
// 1. son titre
// 2. sa propre page
// 3. ses différents parcours
//
// Exemple :
//
// 1. Nombres entiers naturels — p. 12
//
//    📘 6ᵉ   p. 15
//    📘 5ᵉ   p. —
//    📘 4ᵉ   p. —
//    📘 3ᵉ   p. —
// ==========================================================
// ==========================================================
// FONCTION — NOTION
// ==========================================================

#let notion(
  notion-label,
  l6: none,
  l5: none,
  l4: none,
  l3: none,
) = [

  #box(
    width: 6.8cm,
    fill: white,
    radius: 8pt,
    inset: 0.16cm,
    stroke: 0.5pt + rgb("#D5E2EF"),
  )[

    // ------------------------------------------------------
    // TITRE DE LA NOTION + PAGE
    // ------------------------------------------------------

    #ligne-sommaire(
      titre-ref(notion-label),
      page-ref(notion-label),
      couleur: code-blue,
      taille: 8.5pt,
    )

    #v(0.12cm)

    // ------------------------------------------------------
    // PARCOURS 6e
    // ------------------------------------------------------

    #if l6 != none [
      #parcours-sommaire(
        titre-ref(l6),
        page-ref(l6),
      )

      #v(0.08cm)
    ]

    // ------------------------------------------------------
    // PARCOURS 5e
    // ------------------------------------------------------

    #if l5 != none [
      #parcours-sommaire(
        titre-ref(l5),
        page-ref(l5),
      )

      #v(0.08cm)
    ]

    // ------------------------------------------------------
    // PARCOURS 4e
    // ------------------------------------------------------

    #if l4 != none [
      #parcours-sommaire(
        titre-ref(l4),
        page-ref(l4),
      )

      #v(0.08cm)
    ]

    // ------------------------------------------------------
    // PARCOURS 3e
    // ------------------------------------------------------

    #if l3 != none [
      #parcours-sommaire(
        titre-ref(l3),
        page-ref(l3),
      )

      #v(0.08cm)
    ]

  ]

]

// ==========================================================
// FONCTION — DOMAINE
// ==========================================================
//
// Affiche :
//
// Icône + nom du domaine
// Page du domaine
// Puis toutes les notions du domaine
// ==========================================================


#let domaine(
  titre,
  icone,
  couleur,
  label-name,
  contenu,
) = [

  #box(
    width: 7.2cm,
    fill: rgb("#F8FAFC"),
    radius: 10pt,
    inset: 0.18cm,
    stroke: 0.8pt + couleur,
  )[


    // ------------------------------------------------------
    // TITRE DU DOMAINE
    // ------------------------------------------------------


    #align(center)[

      #text(
        size: 12pt,
        weight: "bold",
        fill: couleur,
      )[

        #icone  #titre

      ]


      #v(0.02cm)


      // --------------------------------------------------
      // PAGE DU DOMAINE
      // --------------------------------------------------


      #text(
        size: 8.5pt,
        fill: code-gray,
      )[

        #text(
          weight: "bold",
          fill: couleur,
        )[

          p. #page-ref(label-name)

        ]

      ]

    ]


    #v(0.15cm)


    // ------------------------------------------------------
    // CONTENU DU DOMAINE
    // ------------------------------------------------------


    #contenu

  ]

]



// ==========================================================
// FONCTION — SOMMAIRE
// ==========================================================


#let sommaire() = [


// ==========================================================
// TITRE
// ==========================================================


#align(center)[

  #text(
    size: 26pt,
    weight: "bold",
    fill: code-blue,
  )[

    SOMMAIRE DES NOTIONS

  ]


  #v(0.1cm)


  #line(
    length: 5cm,
    stroke: 1.3pt + code-blue,
  )

]


#v(0.15cm)



// ==========================================================
// INTRODUCTION
// ==========================================================


#align(center)[

  #box(
    width: 15cm,
    fill: rgb("#F2F6FA"),
    radius: 12pt,
    inset: 0.3cm,
    stroke: 0.5pt + rgb("#D5E2EF"),
  )[

    #text(
      size: 10pt,
      style: "italic",
      fill: code-gray,
    )[

      CODE-MATHS présente l'organisation complète du manuel
      à travers les grandes notions mathématiques du collège.


    ]


  ]

]


#v(0.25cm)






// ==========================================================
// PAGE 1
// DOMAINES A ET B
// ==========================================================


#grid(
  columns: 2,
  column-gutter: 0.4cm,
  row-gutter: 0.25cm,


// ==========================================================
// DOMAINE A
// NOMBRES ET CALCULS
// ==========================================================


[

  #domaine(
    "NOMBRES ET CALCULS",
    "🔢",
    code-blue,
    "domaine-nombres-calculs",

    [

    #notion(
  "notion-entiers-naturels",

   l6: "parcours-entiers-naturels-6e",
   l5: "parcours-entiers-naturels-5e",
   l4: "parcours-entiers-naturels-4e",
)


 
      #notion(
        "notion-entiers-relatifs",

        l5: "parcours-entiers-relatifs-5e",
        l4: "parcours-entiers-relatifs-4e",
      
      )


      #notion(
    
        "notion-nombres-decimaux",

        l6: "parcours-nombres-decimaux-6e",
        l5: "parcours-nombres-decimaux-5e",
        l4: "parcours-nombres-decimaux-4e",
        
      )




      #notion(
        "notion-fractions",

        l6: "parcours-fractions-6e",
        l5: "parcours-fractions-5e",
        l4: "parcours-rationnels-4e",
      )



      #notion(
        "notion-nombres-reels",

        l3: "parcours-nombres-reels-3e",
      )
       

    ]

  )

],


 
// ==========================================================
// DOMAINE B
// ALGÈBRE
// ==========================================================


[

  #domaine(
    "ALGÈBRE",
    "🧮",
    rgb("#8B1E2D"),
    "domaine-algebre",

    [


      #notion(
        "notion-algebre",

        l6: "parcours-calcul-litteral-6e",
        l4: "parcours-calculs-expressions-algebriques-4e",
        l3: "parcours-oceanographie-technologies-marines-3e",
      )

/*
      #notion(
        "2. Équations et systèmes d'équations",

        "notion-equations",

        "notion-equations-6e",
        "notion-equations-5e",
        "notion-equations-4e",
        "notion-equations-3e",
      )


      #notion(
        "3. Inéquations et systèmes d'inéquations",

        "notion-inequations",

        "notion-inequations-6e",
        "notion-inequations-5e",
        "notion-inequations-4e",
        "notion-inequations-3e",
      )


      #notion(
        "4. Applications affines",

        "notion-applications-affines",

        "notion-applications-affines-6e",
        "notion-applications-affines-5e",
        "notion-applications-affines-4e",
        "notion-applications-affines-3e",
      )


      #notion(
        "5. Applications linéaires",

        "notion-applications-lineaires",

        "notion-applications-lineaires-6e",
        "notion-applications-lineaires-5e",
        "notion-applications-lineaires-4e",
        "notion-applications-lineaires-3e",
      )
*/
    ]

  )

]
  
)



// ==========================================================
// PAGE 2
// DOMAINES C ET D
// ==========================================================


#pagebreak()

/* 
#grid(
  columns: 2,
  column-gutter: 0.4cm,
  row-gutter: 0.25cm,


// ==========================================================
// DOMAINE C
// ORGANISATION ET TRAITEMENT DES DONNÉES
// ==========================================================


[

  #domaine(
    "ORGANISATION ET TRAITEMENT DES DONNÉES",
    "📊",
    rgb("#B06A00"),
    "domaine-donnees",

    [


      #notion(
        "1. Repérage",

        "notion-reperage",

        "notion-reperage-6e",
        "notion-reperage-5e",
        "notion-reperage-4e",
        "notion-reperage-3e",
      )


      #notion(
        "2. Tableaux et organisation des données",

        "notion-tableaux",

        "notion-tableaux-6e",
        "notion-tableaux-5e",
        "notion-tableaux-4e",
        "notion-tableaux-3e",
      )


      #notion(
        "3. Proportionnalité",

        "notion-proportionnalite",

        "notion-proportionnalite-6e",
        "notion-proportionnalite-5e",
        "notion-proportionnalite-4e",
        "notion-proportionnalite-3e",
      )


      #notion(
        "4. Graphiques",

        "notion-graphiques",

        "notion-graphiques-6e",
        "notion-graphiques-5e",
        "notion-graphiques-4e",
        "notion-graphiques-3e",
      )


      #notion(
        "5. Statistiques",

        "notion-statistiques",

        "notion-statistiques-6e",
        "notion-statistiques-5e",
        "notion-statistiques-4e",
        "notion-statistiques-3e",
      )

    ]

  )

],



// ==========================================================
// DOMAINE D
// GÉOMÉTRIE
// ==========================================================


[

  #domaine(
    "GÉOMÉTRIE",
    "📐",
    rgb("#39704F"),
    "domaine-geometrie",

    [


      #notion(
        "1. Configurations de l'espace",

        "notion-espace",

        "notion-espace-6e",
        "notion-espace-5e",
        "notion-espace-4e",
        "notion-espace-3e",
      )


      #notion(
        "2. Points, droites et distances",

        "notion-points-droites",

        "notion-points-droites-6e",
        "notion-points-droites-5e",
        "notion-points-droites-4e",
        "notion-points-droites-3e",
      )


      #notion(
        "3. Angles",

        "notion-angles",

        "notion-angles-6e",
        "notion-angles-5e",
        "notion-angles-4e",
        "notion-angles-3e",
      )


      #notion(
        "4. Triangles",

        "notion-triangles",

        "notion-triangles-6e",
        "notion-triangles-5e",
        "notion-triangles-4e",
        "notion-triangles-3e",
      )


      #notion(
        "5. Quadrilatères et polygones",

        "notion-quadrilateres",

        "notion-quadrilateres-6e",
        "notion-quadrilateres-5e",
        "notion-quadrilateres-4e",
        "notion-quadrilateres-3e",
      )


      #notion(
        "6. Cercle",

        "notion-cercle",

        "notion-cercle-6e",
        "notion-cercle-5e",
        "notion-cercle-4e",
        "notion-cercle-3e",
      )


      #notion(
        "7. Transformations du plan",

        "notion-transformations",

        "notion-transformations-6e",
        "notion-transformations-5e",
        "notion-transformations-4e",
        "notion-transformations-3e",
      )


      #notion(
        "8. Repérage et vecteurs",

        "notion-vecteurs",

        "notion-vecteurs-6e",
        "notion-vecteurs-5e",
        "notion-vecteurs-4e",
        "notion-vecteurs-3e",
      )

    ]

  )

]

)
*/


// ==========================================================
// TABLEAU DE REPÉRAGE
// ==========================================================














]