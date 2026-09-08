// ==========================================================
// CODE Framework
// boxes.typ
// Blocs pédagogiques officiels
// ==========================================================


#import "colors.typ": *


#let box_style(title, icon, color, body) = {

  block(
    fill: color.lighten(80%),
    stroke: color,
    radius: 8pt,
    inset: 12pt,
  )[

    #text(
      weight: "bold",
      fill: color,
    )[
      #icon #h(0.3em) #underline[#title]
    ]

    #v(0.2cm)

     #body
  ]
}



// ==========================================================
// TITRE PRINCIPAL D'UNE NOTION
// ==========================================================

#let title(titre, id) = {
  metadata((
    type: "notion",
    id: id,
    titre: titre,
  ))

  align(center)[
    #text(
      size: 24pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      #titre
    ]

    #v(0.2cm)

    #line(
      length: 5cm,
      stroke: 1.2pt + rgb("#0B2F55"),
    )
  ]

  v(0.5cm)
}


#let image_notion(path, width: 12cm) = {
  align(center)[
    #image(
      "../assets/images/" + path,
      width: width,
    )
  ]
}




// ==========================================================
// TITRE D'UN PARCOURS
// ==========================================================

#let parcours(titre, id) = {
  metadata((
    type: "parcours",
    id: id,
    titre: titre,
  ))

  align(center)[
    #text(
      size: 16pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      📘 #titre
    ]

    #v(0.1cm)

    #line(
      length: 3.5cm,
      stroke: 1pt + rgb("#0B2F55"),
    )
  ]

  v(0.5cm)
}


#let image_full(path) = {
  align(center)[
    #image(
      "../assets/images/" + path,
      width: 100%,
      
      fit: "contain",
    )
  ]

  v(0.1cm)
}


#let image_division(path, width: 4cm) = {
  align(center)[
    #image(
      "../assets/images/" + str(path),
      width: width,
    )
  ]

  v(0.1cm)
}


#let titre-notion(id) = context {
  let resultats = query(
    selector(metadata).filter(
      it =>
        it.value.type == "notion" and
        it.value.id == id
    )
  )

  if resultats.len() > 0 {
    resultats.first().value.titre
  } else {
    "Titre introuvable"
  }
}



#let deux-colonnes(contenu) = {
  columns(
    2,
    gutter: 0.5cm,
    contenu,
  )
}


// ==========================================================
// SÉPARATION VERTICALE DES DEUX COLONNES
// ==========================================================

#let ligne-colonnes() = {
  place(
    center + horizon,
    dx: 0pt,
    dy: 0pt,
    line(
      length: 100%,
      stroke: 0.5pt + black,
    ),
  )
}

// ==========================================================
// Activité de découverte
// ==========================================================


#let activite(body) = {
  align(center)[
    #box(
      width: 90%,
      inset: 0pt,
      fill: rgb("#F2F7FC"),
      stroke: 1pt + rgb("#0B2F55"),
      radius: 10pt,
    )[
      // ─────────────────────────────
      // EN-TÊTE
      // ─────────────────────────────

      #box(
        width: 100%,
        fill: rgb("#0B2F55"),
        inset: (x: 0.45cm, y: 0.18cm),
        radius: (top-left: 10pt, top-right: 10pt),
      )[
        #text(
          size: 12pt,
          weight: "bold",
          fill: white,
        )[
          🔎 Découverte
        ]
      ]

      // ─────────────────────────────
      // CONTENU
      // ─────────────────────────────

      #box(
        width: 100%,
        inset: 0.45cm,
      )[
        #align(left)[
          #body
        ]
      ]
    ]
  ]

  v(0.2cm)
}



#let suite_activite(body) = {
  align(center)[
    #box(
      width: 90%,
      inset: 0pt,
      fill: rgb("#F2F7FC"),
      stroke: 1pt + rgb("#0B2F55"),
      radius: 10pt,
    )[
      

      // ─────────────────────────────
      // CONTENU
      // ─────────────────────────────

      #box(
        width: 100%,
        inset: 0.45cm,
      )[
        #align(left)[
          #body
        ]
      ]
    ]
  ]

  v(0.2cm)
}



// ==========================================================
// Titre de sous-partie
// ==========================================================

#let compteur-sous-titre = counter("sous-titre")
#let compteur-sous-sous-titre = counter("sous-sous-titre")


#let debut_notion() = {
  compteur-sous-titre.update(0)
  compteur-sous-sous-titre.update(0)
}


// ----------------------------------------------------------
// Sous-titre principal : 1. 2. 3. ...
// ----------------------------------------------------------

#let sous_titre(body) = {
  compteur-sous-titre.step()

  // À chaque nouveau sous-titre principal,
  // on recommence les sous-sous-titres à 1.
  compteur-sous-sous-titre.update(0)

  context {
    text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      #compteur-sous-titre.display().
      #h(0.12em)
      #body
    ]
  }

  v(0.12cm)

  line(
    length: 100%,
    stroke: 1.2pt + rgb("#0B2F55"),
  )

  v(0.35cm)
}


// ----------------------------------------------------------
// Sous-sous-titre : 6.1. 6.2. 6.3. ...
// ----------------------------------------------------------

#let sous_sous_titre(body) = {
  compteur-sous-sous-titre.step()

  context {
    text(
      size: 12pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      #compteur-sous-titre.display().
      #compteur-sous-sous-titre.display().
      #h(0.12em)
      #body
    ]
  }

  v(0.1cm)

  line(
    length: 100%,
    stroke: 0.8pt + rgb("#0B2F55"),
  )

  v(0.25cm)
}
// ==========================================================
// Définition
// ==========================================================

#let definition(body) = {
  box_style(
    "Définition",
    "📖",
    rgb("#0B2F55"),
    body,
  )
}


#let propriete(body) = {
  box_style(
    "Propriété",
    "💡",
    rgb("#0B2F55"),
    body,
  )
}

// ==========================================================
// À retenir
// ==========================================================




#let retenir(body) = {
  block(
    stroke: 1pt + rgb("#0B2F55"),
    inset: 0.25cm,
    width: 100%,
    radius: 8pt,
  )[
    #text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
      #underline[À retenir]
    ]

    #v(0.2cm)

    #body
  ]

  v(0.5cm)
}


// ==========================================================
// Règle importante
// ==========================================================

#let regle(body) = {
   text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Règle importante]  
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
}


// ==========================================================
// Méthode
// ==========================================================

#let methode(body) = {
 
    
 text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Méthode] 
    
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
}


// ==========================================================
// Exemple
// ==========================================================

#let exemple(body) = {
 
  text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Exemple] 
    
    
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
    
}



// ==========================================================
// Exemple résolu
// ==========================================================

#let exemple_resolu(body) = {
 text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
     #underline[Exemple résolu] 
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
    
}

#let exercice_resolu(body) = {
text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
     #underline[Exemple résolu] 
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
    
}

// ==========================================================
// Erreurs fréquentes
// ==========================================================

#let erreur(body) = {
 text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[ Erreurs fréquentes]
    
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
}



// ==========================================================
// Exercice de compréhension
// ==========================================================

#let exercice(body) = { 
  text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Exercice de compréhension ]   
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
}



// ==========================================================
// Mission CODE
// ==========================================================

#let mission(body) = {
   text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Mission CODE]    
  ]

  v(0.2cm)

  body
  
  v(0.5cm)
}



// ==========================================================
// Problème ouvert
// ==========================================================

#let probleme(body) = {
  box_style(
    "Problème ouvert",
    "🔬",
    code-red,
    body,
  )
}



// ==========================================================
// Objectif
// ==========================================================

#let objectif(body) = {
  text(
    size: 14pt,
    weight: "bold",
    fill: rgb("#0B2F55"),
  )[
    🎯 Objectif
  ]

  v(0.1cm)

  text(
    size: 11.5pt,
  )[
    #body
  ]

  v(0.1cm)
}


// ==========================================================
// Correction
// ==========================================================

#let correction(body) = {
   text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Correction]
  ]

  v(0.2cm)

  text(
    size: 11.5pt,
  )[
    #body
  ]
  
  v(0.1cm)
}


// ==========================================================
// Ouverture mathématique
// ==========================================================

#let ouverture(body) = {
  box_style(
    "Ouverture mathématique",
    "🌍",
    code-green,
    body,
  )
}


// ==========================================================
// Ce que cette notion prépare
// ==========================================================

#let preparation(body) = {
  
    text(
    size: 14pt,
    weight: "bold",
    fill: rgb("#0B2F55"),
  )[
    🔗 Ce que cette notion prépare
    

  ]

  v(0.1cm)

  text(
    size: 11.5pt,
  )[
    #body
  ]

  v(0.1cm)
}


// ==========================================================
// Mission de synthèse
// ==========================================================

#let synthese(body) = {
  box_style(
    "Mission de synthèse",
    "🏆",
    rgb("#0B2F55"),
    body,
  )
}



// ==========================================================
// Remarque
// ==========================================================

#let remarque(body) = {
text(
      size: 13pt,
      weight: "bold",
      fill: rgb("#0B2F55"),
    )[
    #underline[Remarque]

  ]

  v(0.2cm)

  text(
    size: 11.5pt,
  )[
    #body
  ]
  
  v(0.1cm)
}


#let decomposition-premiers(lignes) = {
  align(center)[
    #table(
      columns: (1.4cm, 0.2cm, 1.4cm),
      align: center,
      stroke: none,
      inset: 0.08cm,

      ..lignes.map(ligne => (
        [#ligne.at(0)],
        [|],
        [#ligne.at(1)],
      )).flatten(),
    )
  ]
}






// ----------------------------------------------------------
// DÉDUCTOGRAMME À 1 HYPOTHÈSE
// ----------------------------------------------------------

#let deductogramme_1(
  hypothese-1: [],
  conclusion: [],
) = {
  let largeur = 90%

  align(center)[
    #box(
      width: largeur,
      inset: 0pt,
    )[
      // Hypothèse
      #align(center)[
        #box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-1
            ]
          ]
        ]
      ]

      // Trait vertical
      #align(center)[
        #line(
          length: 0.45cm,
          angle: 90deg,
          stroke: 1.2pt + code-blue,
        )
      ]

      // Flèche
      #align(center)[
        #text(
          size: 22pt,
          weight: "bold",
          fill: code-blue,
        )[↓]
      ]

      // Conclusion
      #align(center)[
        #box(
          width: 70%,
          fill: rgb("#EAF4EC"),
          stroke: 1.2pt + code-green,
          radius: 9pt,
          inset: 0.35cm,
        )[
          #align(center)[
            #text(
              size: 11pt,
              weight: "bold",
              fill: code-green,
            )[Conclusion]
          ]

          #v(0.12cm)

          #text(size: 11pt)[
            #conclusion
          ]
        ]
      ]
    ]
  ]

  v(0.5cm)
}

#let deductogramme_2(
  hypothese-1: [],
  hypothese-2: [],
  conclusion: [],
) = {
  let largeur = 90%
  let espace = 0.3cm

  let distance-centres = (
    largeur - espace
  ) / 2

  align(center)[
    #box(
      width: largeur,
      inset: 0pt,
    )[
      // Hypothèses
      #grid(
        columns: (1fr, 1fr),
        gutter: espace,

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-1
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-2
            ]
          ]
        ]],
      )

      // Traits verticaux
      #grid(
        columns: (1fr, 1fr),
        gutter: espace,

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],
      )

      // Ligne commune
      #align(center)[
        #line(
          length: distance-centres,
          stroke: 1.2pt + code-blue,
        )
      ]

      // Flèche
      #align(center)[
        #text(
          size: 22pt,
          weight: "bold",
          fill: code-blue,
        )[↓]
      ]

      // Conclusion
      #align(center)[
        #box(
          width: 70%,
          fill: rgb("#EAF4EC"),
          stroke: 1.2pt + code-green,
          radius: 9pt,
          inset: 0.35cm,
        )[
          #align(center)[
            #text(
              size: 11pt,
              weight: "bold",
              fill: code-green,
            )[Conclusion]
          ]

          #v(0.12cm)

          #text(size: 11pt)[
            #conclusion
          ]
        ]
      ]
    ]
  ]

  v(0.5cm)
}

#let deductogramme_3(
  hypothese-1: [],
  hypothese-2: [],
  hypothese-3: [],
  conclusion: [],
) = {
  let largeur = 90%
  let espace = 0.3cm

  let distance-centres = (
    largeur - 2 * espace
  ) * 2 / 3

  align(center)[
    #box(
      width: largeur,
      inset: 0pt,
    )[
      // Hypothèses
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: espace,

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-1
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-2
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-3
            ]
          ]
        ]],
      )

      // Traits verticaux
      #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: espace,

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],
      )

      // Ligne commune
      #align(center)[
        #line(
          length: distance-centres,
          stroke: 1.2pt + code-blue,
        )
      ]

      // Flèche
      #align(center)[
        #text(
          size: 22pt,
          weight: "bold",
          fill: code-blue,
        )[↓]
      ]

      // Conclusion
      #align(center)[
        #box(
          width: 70%,
          fill: rgb("#EAF4EC"),
          stroke: 1.2pt + code-green,
          radius: 9pt,
          inset: 0.35cm,
        )[
          #align(center)[
            #text(
              size: 11pt,
              weight: "bold",
              fill: code-green,
            )[Conclusion]
          ]

          #v(0.12cm)

          #text(size: 11pt)[
            #conclusion
          ]
        ]
      ]
    ]
  ]

  v(0.5cm)
}

#let deductogramme_4(
  hypothese-1: [],
  hypothese-2: [],
  hypothese-3: [],
  hypothese-4: [],
  conclusion: [],
) = {
  let largeur = 90%
  let espace = 0.3cm

  let distance-centres = (
    largeur - 3 * espace
  ) * 3 / 4

  align(center)[
    #box(
      width: largeur,
      inset: 0pt,
    )[
      // Hypothèses
      #grid(
        columns: (1fr, 1fr, 1fr, 1fr),
        gutter: espace,

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-1
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-2
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-3
            ]
          ]
        ]],

        [#box(
          width: 100%,
          height: 1.8cm,
          fill: rgb("#F2F7FC"),
          stroke: 1.1pt + code-blue,
          radius: 8pt,
          inset: 0.25cm,
        )[
          #align(center + horizon)[
            #text(
              size: 10.5pt,
              weight: "bold",
              fill: code-blue,
            )[
              #hypothese-4
            ]
          ]
        ]],
      )

      // Traits verticaux
      #grid(
        columns: (1fr, 1fr, 1fr, 1fr),
        gutter: espace,

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],

        [#align(center)[
          #line(
            length: 0.45cm,
            angle: 90deg,
            stroke: 1.2pt + code-blue,
          )
        ]],
      )

      // Ligne commune
      #align(center)[
        #line(
          length: distance-centres,
          stroke: 1.2pt + code-blue,
        )
      ]

      // Flèche
      #align(center)[
        #text(
          size: 22pt,
          weight: "bold",
          fill: code-blue,
        )[↓]
      ]

      // Conclusion
      #align(center)[
        #box(
          width: 70%,
          fill: rgb("#EAF4EC"),
          stroke: 1.2pt + code-green,
          radius: 9pt,
          inset: 0.35cm,
        )[
          #align(center)[
            #text(
              size: 11pt,
              weight: "bold",
              fill: code-green,
            )[Conclusion]
          ]

          #v(0.12cm)

          #text(size: 11pt)[
            #conclusion
          ]
        ]
      ]
    ]
  ]

  v(0.5cm)
}