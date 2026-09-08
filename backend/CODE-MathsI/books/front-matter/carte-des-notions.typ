// ==========================================================
// CARTE DES NOTIONS
// CODE-MATHS
// Version carte d'apprentissage
// ==========================================================


#import "../../code/code.typ": *



#let carte_des_notions() = [



// ==========================================================
// TITRE
// ==========================================================


#align(center)[


#text(
size:24pt,
weight:"bold",
fill:code-blue,
)[

CARTE DES NOTIONS

]


#v(0.1cm)


#line(
length:4.5cm,
stroke:1.2pt + code-blue,
)


]


#v(0.2cm)




// ==========================================================
// INTRODUCTION
// ==========================================================


#align(center)[


#box(
width:15cm,
fill:rgb("#F2F6FA"),
radius:12pt,
inset:0.35cm,
stroke:0.6pt + rgb("#D0DCE8"),
)[


#text(
size:10.8pt,
style:"italic",
fill:code-gray,
)[


CODE-MATHS organise les apprentissages autour des grandes
idées mathématiques afin de permettre à chaque apprenant
de suivre l'évolution complète d'une notion.

Chaque domaine constitue un parcours progressif :


#text(
size:10pt,
weight:"bold",
fill:code-blue,
)[


Découvrir  →  Comprendre  →  Maîtriser  →  Réinvestir


]


]

]


]


#v(0.2cm)





// ==========================================================
// FONCTION CARTE DOMAINE
// ==========================================================



#let carte(
titre,
couleur,
sous_titre,
contenu,
) = [



#box(
width:7.1cm,
fill:white,
radius:12pt,
inset:0.25cm,
stroke:1pt + couleur,
)[



#box(
width:100%,
fill:couleur,
radius:8pt,
inset:0.15cm,
)[



#align(center)[


#text(
size:11pt,
weight:"bold",
fill:white,
)[

#titre

]


]


]




#v(0.1cm)



#align(center)[


#text(
size:9pt,
weight:"bold",
fill:couleur,
)[

#sous_titre

]


]



#v(0.1cm)



#contenu


]


]






// ==========================================================
// ORGANISATION DES CARTES
// ==========================================================


#align(center)[



#table(
columns:(7.1cm,7.1cm),
gutter:0.4cm,
stroke:none,





// ==========================================================
// DOMAINE A
// NOMBRES ET CALCULS
// ==========================================================


[


#carte(
" NOMBRES ET CALCULS",
rgb("#0B2F55"),
"Fondations du raisonnement numérique",
[



#text(
size:9.5pt,
)[


Les nombres constituent le langage
fondamental des mathématiques.


]


#v(0.15cm)



#text(
size:9pt,
fill:rgb("#444444"),
)[


● Nombres entiers naturels


● Nombres entiers relatifs


● Nombres décimaux


● Fractions


● Nombres rationnels


● Nombres réels

]


],


)

],






// ==========================================================
// DOMAINE B
// ALGÈBRE
// ==========================================================


[


#carte(
"📕 ALGÈBRE",
rgb("#8B1E2D"),
"Du calcul au raisonnement symbolique",
[



#text(
size:9.5pt,
)[


L'algèbre permet de représenter
des situations générales grâce
aux lettres et aux relations.


]



#v(0.15cm)



#text(
size:9pt,
fill:rgb("#444444"),
)[


● Calcul littéral


● Équations et systèmes d'équations


● Inéquations et systèmes d'inéquations


● Applications affines


● Applications linéaires


]


],


)

],


// ==========================================================
// DOMAINE C
// ORGANISATION ET TRAITEMENT DES DONNÉES
// ==========================================================


[


#carte(
"📙 DONNÉES",
rgb("#B06A00"),
"Organiser, analyser et interpréter",
[



#text(
size:9.5pt,
)[


Les données permettent de comprendre
et d'expliquer les phénomènes du monde.


]



#v(0.15cm)



#text(
size:9pt,
fill:rgb("#444444"),
)[


● Proportionnalité


● Statistiques


]


],


)

],








// ==========================================================
// DOMAINE D
// GÉOMÉTRIE
// ==========================================================


[


#carte(
"GÉOMÉTRIE",
rgb("#39704F"),
"Construire, représenter et démontrer",
[



#text(
size:9.5pt,
)[


La géométrie développe
l'observation, la construction
et le raisonnement logique.


]



#v(0.15cm)



#text(
size:9pt,
fill:rgb("#444444"),
)[

● Repérage


● Points, droites et segments


● Distances


● Projection


● Équations de droite 


● Glissement


● Translation


● Vecteurs


● Angles


● Cercle


● Triangles


● Quadrilatères


● Parallélogrammes


● Trapèze


● Solides


]


],


)

],


)

]



]