
#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let decimaux() = [

#debut_notion()
// ==========================================================
// TITRE DE LA NOTION
// ==========================================================

#pagebreak()

#title(
  [III — LES NOMBRES DÉCIMAUX],
  "notion-nombres-decimaux",
) <notion-nombres-decimaux>

#v(0.15cm)



// ==========================================================
// ORIGINE DE LA NOTION
// ==========================================================



#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[



#text(
  size: 11pt,
  weight: "bold",
  fill: code-blue,
)[
🌍 D'où vient le besoin de mesurer plus précisément ?
]
#v(0.55cm)


Lorsque l'être humain a commencé à mesurer des longueurs,
des masses, des distances ou des quantités, il s'est retrouvé
face à une nouvelle difficulté :

#align(center)[
#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
« Comment exprimer une quantité qui n'est pas exactement
un nombre entier d'unités ? »
]
]

Par exemple, un artisan peut avoir besoin de mesurer une
pièce de bois dont la longueur est supérieure à $2\,m$ mais
inférieure à $3\,m$.

Dire simplement $2\,m$ ou $3\,m$ ne permet pas de donner
une mesure suffisamment précise.

Il faut alors pouvoir partager l'unité de mesure en
plusieurs parties.

#v(0.05cm)



#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
📏 Partager l'unité pour mesurer plus précisément
]
#v(0.1cm)

Pour obtenir des mesures plus précises, les êtres humains
ont progressivement utilisé des subdivisions de l'unité.

Un mètre peut ainsi être partagé en dix parties égales :

$1m = 10d m$.

Une de ces parties représente alors :

$1d m = 1/10\,m$.

De la même manière, on peut partager une unité en
$100$, $1000$, voire davantage de parties égales.

On obtient alors des fractions telles que :

$1/10 ; 1/100 ; 1/1000$.

Les fractions permettent donc déjà d'exprimer des quantités
situées entre deux nombres entiers.



#v(0.05cm)



#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🔢 Pourquoi une nouvelle écriture ?
]
#v(0.1cm)

Les fractions étaient utiles, mais certaines fractions
décimales pouvaient être écrites d'une manière plus simple.

Par exemple :

$1/10 = 0,1$

$1/100 = 0,01$

$1/1000 = 0,001$.

Cette nouvelle écriture permet de lire rapidement la quantité
mesurée et de faciliter les calculs.

Ainsi, une longueur de $2\,m$ et $5\,d m$ peut être écrite :

$2\,m + 5\,d m = 2,5\,m$.
]

#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[
De même, une masse de $3\,k g$ et $25\,g$ peut être exprimée
avec une écriture décimale adaptée.

Peu à peu, les nombres décimaux sont devenus un outil
essentiel pour représenter les quantités qui se trouvent
entre deux nombres entiers.

Ils sont aujourd'hui indispensables dans la vie quotidienne :
pour mesurer une longueur, une masse ou une température,
pour lire un prix, calculer une distance, déterminer une
durée ou effectuer des mesures scientifiques.

#v(0.05cm)

Ainsi, le besoin de mesurer et de calculer avec davantage
de précision a conduit les êtres humains à utiliser
des nombres permettant d'exprimer les parties d'une unité.

#v(0.05cm)

#align(center)[
#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
Des entiers pour compter → des fractions pour partager
une unité → des nombres décimaux pour mesurer et calculer
avec précision.
]
]



#v(0.2cm)



// ==========================================================
// OBJECTIFS DE LA NOTION
// ==========================================================
#objectif[


À travers cette notion, l'apprenant doit être capable de :


• reconnaître et identifier un nombre décimal ;

• lire et écrire un nombre décimal ;

• comprendre la valeur de chaque chiffre dans un nombre décimal ;

• représenter une fraction décimale sous forme d'un nombre décimal ;

• décomposer un nombre décimal selon les unités, dixièmes,
  centièmes, millièmes, etc. ;

• comparer et ranger des nombres décimaux ;

• utiliser les nombres décimaux pour exprimer des mesures
  et résoudre des situations concrètes.


]
]


#v(0.2cm)


#align(center)[


#image_full("nombres-decimaux-origine.png")


]


#pagebreak()


// ==========================================================
// PARCOURS 6e
// ==========================================================

#parcours(
  [PARCOURS 6ᵉ — Découvrir les nombres décimaux avec le commerce],
  "parcours-nombres-decimaux-6e",
) <parcours-nombres-decimaux-6e>


// ----------------------------------------------------------
// ACTIVITÉ DE DÉCOUVERTE
// ----------------------------------------------------------

#activite[

Dans un marché, les commerçants vendent différents produits :
du riz, du maïs, des haricots, des fruits, des légumes ou encore
de la farine.

Pour vendre certains de ces produits, il ne suffit pas de compter
le nombre de sacs ou de récipients. Il faut également connaître
la #strong[quantité de produit] vendue.

C'est pourquoi les commerçants utilisent une #strong[balance].

La balance permet de mesurer la masse d'un produit.

L'unité de masse couramment utilisée dans le commerce est
le #strong[kilogramme], noté $k g$.

Par exemple, un commerçant peut vendre :

$1k g$ de riz, puis $2k g$, puis $5k g$.

Dans ces cas, la quantité vendue est exprimée par un nombre
entier de kilogrammes.

Mais les clients n'achètent pas toujours une quantité entière.

Un client peut demander une quantité plus petite qu'un
kilogramme, par exemple une demi-unité de kilogramme.

Le commerçant doit alors pouvoir mesurer précisément cette
quantité à l'aide de sa balance.

Pour cela, le kilogramme peut être partagé en parties égales.

Un kilogramme partagé en $10$ parties donne des quantités
de :

$1/10k g$.

Une quantité de $5/10k g$ correspond à une demi-unité de
kilogramme.

On peut donc avoir à mesurer une quantité située entre
$1k g$ et $2k g$, par exemple :

$1k g + 5/10k g$.

Cette quantité n'est ni $1k g$ ni $2k g$.

Elle est située entre les deux :

$1k g < 1k g + 5/10k g < 2k g$.

Le commerçant rencontre donc une difficulté : comment écrire
simplement une quantité qui n'est pas un nombre entier de
kilogrammes ?

Il pourrait utiliser une fraction :

$1 + 5/10k g$.

Mais dans les échanges commerciaux, les mesures doivent être
faciles à lire, à comparer, à enregistrer et à communiquer.
]

#activite[
Il devient alors utile de disposer d'une autre manière
d'écrire ces quantités.

On peut par exemple écrire :

$1,5k g$.

Cette écriture permet d'exprimer simplement une quantité
située entre deux nombres entiers.

Le même besoin apparaît lorsqu'un commerçant mesure d'autres
quantités : une masse, une longueur, un volume ou toute autre
grandeur pouvant être partagée en dixièmes, centièmes,
millièmes, etc.

Ainsi, le commerce montre qu'il ne suffit pas toujours de
compter avec des nombres entiers : il faut parfois pouvoir
#strong[mesurer et communiquer des quantités situées entre
deux nombres entiers].

Mais alors, #strong[comment appelle-t-on ces nombres comme
$1,5$ qui permettent d'exprimer de telles quantités ?]


Ainsi, dans le commerce, la mesure d'une quantité peut conduire
à utiliser des nombres qui ne sont pas entiers.

Par exemple :

$1,5k g ; 2,4k g ; 3,75k g$.

Ces nombres permettent d'exprimer des quantités situées entre
deux nombres entiers et d'effectuer des mesures avec davantage
de précision.

Les mathématiciens ont donné un nom à ces nombres :
ce sont les #strong[nombres décimaux].


Ainsi, les nombres décimaux permettent d'exprimer aussi bien
des nombres entiers que des nombres situés entre deux entiers.

Les mathématiciens ont regroupé tous ces nombres dans un même
ensemble appelé #strong[l'ensemble des nombres décimaux],
noté :
#text(
  size: 14pt,
  weight: "bold",
  fill: code-blue,
)[
$𝔻$
]


]

#v(0.3cm)

#align(center)[

#image_full("nombres-decimaux-6e.png")

]

#pagebreak()


// ==========================================================
// DEFINITION 1
// ==========================================================

#deux-colonnes[

#sous_titre[
  Connaître l'ensemble $𝔻$
]

#v(0.12cm)

#definition[
L'ensemble des nombres décimaux est l'ensemble des nombres
qui peuvent s'écrire sous la forme d'un entier naturel auquel
on ajoute une fraction décimale.

On le note : $𝔻$.

#image_full("grad-4e.jpeg")

]

#v(0.25cm)


// ==========================================================
// A RETENIR
// ==========================================================

#retenir[
• Tout entier naturel est un nombre décimal.

• Un nombre décimal peut avoir une partie entière et une
  partie décimale.

• La partie décimale permet notamment d'exprimer une quantité
  située entre deux nombres entiers.

• L'ensemble $𝔻$ possède une infinité d'éléments.

• L'ensemble $𝔻$ n'a pas de plus grand élément.
]

#v(0.25cm)


// ==========================================================
// REMARQUES
// ==========================================================

#remarque[
Un entier naturel peut être considéré comme un nombre décimal
dont la partie décimale est nulle.
]

#v(0.2cm)

#exemple[
Lors d'une activité de mesure, on obtient les longueurs :
$5c m$ ; $2,4c m$ ; $3,6c m$ ; $1,8c m$ ;
$4c m$ et $5,4c m$.

Les nombres obtenus sont :
$5$ ; $2,4$ ; $3,6$ ; $1,8$ ; $4$ et $5,4$.

Ils sont tous des nombres décimaux.
On peut donc écrire :

$5 ∈ 𝔻 ; 2,4 ∈ 𝔻 ; 3,6 ∈ 𝔻 ;
1,8 ∈ 𝔻 ; 4 ∈ 𝔻 ; 5,4 ∈ 𝔻$.

Ainsi, un nombre entier comme $5$ peut également être
considéré comme un nombre décimal.
]

#v(1.5cm)


// ==========================================================
// APPARTENANCE A L'ENSEMBLE 𝔻
// ==========================================================

#sous_titre[
Appartenance à l'ensemble $𝔻$
]

#v(0.12cm)

#definition[
Le symbole $∈$ signifie « appartient à ».

Le symbole $∉$ signifie « n'appartient pas à ».
]

#v(0.2cm)

#exemple[
Une balance utilisée dans un commerce indique une masse
de $2,4k g$.

Le nombre $2,4$ est un nombre décimal, donc :
$2,4 ∈ 𝔻$.

En revanche, le nombre $7/3$ ne peut pas s'écrire avec un
nombre fini de chiffres après la virgule.

Ainsi :
$7/3 ∉ 𝔻$.

On peut donc distinguer les nombres qui appartiennent à
l'ensemble des nombres décimaux de ceux qui n'y appartiennent
pas.
]


// ==========================================================
// ECRITURE DES NOMBRES DECIMAUX
// ==========================================================

#sous_titre[
Lire et écrire les nombres décimaux
]

#definition[
Un nombre décimal peut être écrit avec des chiffres.
Il comporte généralement une #strong[partie entière] et une
#strong[partie décimale], séparées par une virgule.
Par exemple :
$13,8$ ; $67,1115$ ; $220,007$ ; $0,352$.
]

#exemple[
Dans une activité de mesure, une longueur peut être de
$2,4c m$.

Le nombre $2,4$ se lit :
« deux virgule quatre ».

De même :

• $3,6$ se lit « trois virgule six » ;

• $1,8$ se lit « un virgule huit » ;

• $5,4$ se lit « cinq virgule quatre ».
]

// ==========================================================
// PARTIE ENTIERE ET PARTIE DECIMALE
// ==========================================================

#sous_titre[
Partie entière et partie décimale d'un nombre décimal
]

#v(0.05cm)

#definition[
La #strong[partie entière] d'un nombre décimal est le nombre
situé à gauche de la virgule.

La #strong[partie décimale] est le nombre situé à droite de
la virgule, interprété à partir des dixièmes, centièmes,
millièmes, etc.
Ainsi :
$13,8 = 13 + 0,8$.
La partie entière de $13,8$ est $13$ et sa partie décimale
est $0,8$.
]

#exemple[
Nous avons les égalités suivantes :

$13,8 = 13 + 0,8$

$220,007 = 220 + 0,007$

$67 + 0,1115 = 67,1115$

$0,352 = 0 + 0,352$.

On peut alors déterminer les parties entières et décimales :

• $67,1115$ : partie entière $67$ et partie décimale $0,1115$ ;

• $220,007$ : partie entière $220$ et partie décimale $0,007$ ;

• $0,352$ : partie entière $0$ et partie décimale $0,352$ ;

• $56$ : partie entière $56$ et partie décimale $0$.
]
#v(0.05cm)

// ==========================================================
// REGLES D'ECRITURE
// ==========================================================

#remarque[
Dans l'écriture d'un nombre décimal :

• les chiffres situés à gauche de la virgule correspondent
  à la partie entière ;

• le premier chiffre à droite de la virgule représente
  les dixièmes ;

• le deuxième représente les centièmes ;

• le troisième représente les millièmes ;

• le quatrième représente les dix-millièmes.
]

#v(0.2cm)

#exemple[
Dans le nombre $67,1115$ :

• $67$ représente la partie entière ;

• $1$ représente les dixièmes ;

• $1$ représente les centièmes ;

• $1$ représente les millièmes ;

• $5$ représente les dix-millièmes.

On peut écrire :

$67,1115
= 67 + 1/10 + 1/100 + 1/1000 + 5/10000$.
]

#v(0.25cm)

#retenir[
Pour bien lire et écrire un nombre décimal, je dois :

• repérer la virgule ;

• identifier la partie entière ;

• identifier la partie décimale ;

• connaître la valeur de position de chaque chiffre après
  la virgule ;

• ne pas confondre un chiffre de la partie décimale avec
  la partie décimale elle-même.
]

#v(0.05cm)


// ==========================================================
// DECOMPOSITION DES NOMBRES DECIMAUX
// ==========================================================

#sous_titre[
Décomposer un nombre décimal
]

#v(0.05cm)

#definition[
Décomposer un nombre décimal consiste à l'écrire comme la somme
de sa partie entière et de sa partie décimale.

On peut également décomposer sa partie décimale en dixièmes,
centièmes, millièmes, etc.
]

#v(3cm)

#exemple[
Décomposons $220,007$ :

$220,007 = 220 + 0,007$
et 
$220,007 = 220 + 7/1000$.

De même :

$0,352 = 0 + 0,3 + 0,05 + 0,002$.

Ainsi :

$0,352 = 3/10 + 5/100 + 2/1000$.
]

#v(0.25cm)


// ==========================================================
// OPERATIONS SUR LES NOMBRES DECIMAUX
// ==========================================================

#sous_titre[
Les opérations sur les nombres décimaux
]

#v(0.12cm)

#definition[
Les nombres décimaux peuvent être utilisés pour effectuer
les quatre opérations :

• l'addition ;

• la soustraction ;

• la multiplication ;

• la division.
]

#v(0.2cm)

#exemple[
Calculons :

$S = 7,54 + 2,5 + 1,46 + 31 + 7,5$.

On aligne les chiffres de même rang :

$S = 7,54 + 2,50 + 1,46 + 31,00 + 7,50$

Donc 
$S = 50,00$

et ainsi 
$S = 50$.
]

#v(0.05cm)

#exemple[
Calculons :
$P = 25 × 1,994 × 4$.

On peut regrouper les facteurs :

$P = 25 × 4 × 1,994$

$P = 100 × 1,994$

$P = 199,4$.
]

#v(0.05cm)

#exemple[
Calculons :
$A = (3 × 4,2) + 7,9$.

On effectue d'abord la multiplication :

$A = 12,6 + 7,9$

$A = 20,5$.
]

#v(0.05cm)

#exemple[
Calculons :
$B = (4,3 + 5,7) × 2$.

On effectue d'abord le calcul entre parenthèses :

$B = 10 × 2$

$B = 20$.
]

#v(0.05cm)

#exemple[
Calculons :
$C = 4 + 5,7 × 7$.

La multiplication est prioritaire :

$C = 4 + 39,9$

$C = 43,9$.
]

#v(0.05cm)

#retenir[
Pour effectuer des calculs avec les nombres décimaux :

• je respecte les priorités des opérations ;

• pour une addition ou une soustraction, j'aligne les chiffres
  de même rang ;

• je peux ajouter des zéros à droite de la partie décimale
  sans changer la valeur du nombre ;

• je conserve la virgule correctement placée dans le résultat.
]
]


#pagebreak()








































// ==========================================================
// PARCOURS 5e
// NOMBRES DÉCIMAUX ET PUISSANCES
// ==========================================================

#parcours(
  [PARCOURS 5ᵉ — Nombres décimaux et puissances dans la robotique],
  "parcours-nombres-decimaux-5e",
) <parcours-nombres-decimaux-5e>

// ----------------------------------------------------------
// MISE EN SITUATION
// ----------------------------------------------------------

#activite[
  🤖 À la découverte d'un robot autonome

  #v(0.05cm)

  Un robot autonome est une machine capable de se déplacer, de mesurer son environnement et d'effectuer certaines actions sans être constamment dirigé par un être humain.
  Pour se déplacer correctement, un robot doit pouvoir indiquer sa position, mesurer des distances, enregistrer des variations et corriger sa trajectoire.
  Pour cela, les nombres utilisés ne sont pas toujours positifs.
  Par exemple, sur une ligne de déplacement :

  • une position située à droite d'un point de référence peut être représentée par $+2,5$ m ;

  • une position située à gauche de ce même point peut être représentée par $-2,5$ m ;

  • une avance de $+1,2$ m indique un déplacement vers l'avant ;

  • un recul de $-0,8$ m indique un déplacement vers l'arrière.

  Le signe permet donc de distinguer deux directions opposées.

  Un robot peut également recevoir plusieurs indications successives.

  Par exemple, s'il avance de $+3m$  puis recule de $1,5m$ , son déplacement total peut être représenté par :
  $(+3)+(-1,5)$.

  Les nombres décimaux positifs et négatifs permettent ainsi au robot de représenter des positions, des déplacements et des variations.

  Observe le schéma d'un robot autonome se déplaçant sur une ligne.

  1. Quelles informations peut-on représenter avec des nombres positifs ou négatifs ?

  2. Comment représenterais-tu un déplacement de $2,5$ m vers l'avant ?

  3. Comment représenterais-tu un recul de $1,5$ m ?

  4. Un robot avance de $3$ m puis recule de $1$ m. Quel est son déplacement total ?

  5. Un robot situé à $-2,5$ m de son point de référence avance de $4$ m. Quelle sera sa nouvelle position ?

  6. Deux positions $-3,5$ m et $+3,5$ m sont-elles à la même distance du point de référence ?

  7. Comment comparer deux positions situées du même côté du point de référence ?

  8. Un système électronique répète plusieurs fois le même facteur dans un calcul. Quelle écriture mathématique pourrait permettre de simplifier ce calcul ?

  Dans ce parcours, nous allons utiliser la robotique pour comprendre comment les nombres décimaux positifs et négatifs permettent de #strong[représenter, comparer, calculer et interpréter des situations réelles].
]

#v(0.25cm)

#align(center)[
  #image_full("robot-autonome-5e.jpeg")
]

#v(0.3cm)

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
🎯 Ce que tu vas apprendre
]

#v(0.12cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

À la fin de ce parcours, tu seras capable de :

#v(0.08cm)

🤖 représenter une position ou un déplacement à l'aide d'un #strong[nombre décimal positif ou négatif] ;

#v(0.05cm)

📍 placer et lire des nombres décimaux sur une #strong[droite graduée] ;

#v(0.05cm)

⚖️ #strong[comparer et ranger] des nombres décimaux positifs et négatifs ;

#v(0.05cm)

📏 déterminer la #strong[distance à zéro] d'un nombre décimal ;

#v(0.05cm)

🔄 déterminer l'#strong[opposé] d'un nombre décimal ;

#v(0.05cm)

➕ effectuer des #strong[additions et soustractions] de nombres décimaux positifs et négatifs ;

#v(0.05cm)

✖️ effectuer des #strong[multiplications] de nombres décimaux positifs et négatifs ;

#v(0.05cm)

🔢 utiliser les #strong[puissances] pour représenter des produits de facteurs décimaux identiques ;

#v(0.05cm)

🤖 et utiliser ces outils pour #strong[programmer, positionner et corriger la trajectoire d'un robot].
]

#v(0.3cm)

#remarque[
Les nombres décimaux positifs et négatifs permettent de représenter des situations dans lesquelles deux directions ou deux positions opposées doivent être distinguées.

Dans ce parcours, nous utiliserons la #strong[robotique] comme fil conducteur pour donner du sens à ces nombres et aux calculs qui les utilisent.
]

#v(0.3cm)

#pagebreak()

#deux-colonnes[

// ==========================================================
// NOMBRES DÉCIMAUX POSITIFS ET NÉGATIFS
// ==========================================================

#sous_titre[
Les nombres décimaux positifs et négatifs
]

#v(0.05cm)

#definition[
Un nombre décimal positif ou négatif est un nombre décimal précédé d'un signe #strong[$+$] ou #strong[$-$].
Le signe #strong[$+$] indique une valeur positive ou une évolution dans le sens choisi comme positif.
Le signe #strong[$-$] indique une valeur négative ou une évolution dans le sens opposé.
]

#v(0.01cm)

#exemple_resolu[
Un robot se déplace sur une ligne.
On choisit le sens vers l'avant comme sens positif.
Ainsi :
$+2,5$ m signifie que le robot se trouve ou se déplace de $2,5$ m dans le sens positif.
$-1,5$ m signifie que le robot se trouve ou se déplace de $1,5$ m dans le sens opposé.
On peut donc utiliser les nombres :

$+2,5$ ; $+1,2$ ; $-0,8$ ; $-3,5$.

Le signe fournit une information sur le sens ou la position.
]

#v(0.01cm)

#remarque[
Le nombre $0$ ne possède ni signe positif ni signe négatif lorsqu'il est écrit simplement $0$.

Un nombre comme $+3,0$ représente la même valeur que $3$.

De même, $-4,0$ représente la même valeur que $-4$.
]

#v(0.01cm)

// ==========================================================
// ENSEMBLE DES NOMBRES DÉCIMAUX
// ==========================================================

#sous_titre[
L'ensemble des nombres décimaux
]

#v(0.15cm)

#definition[
L'ensemble des nombres décimaux est noté $𝔻$.

Il contient notamment les nombres décimaux positifs, les nombres décimaux négatifs et le nombre $0$.
]

#v(0.25cm)

#exemple[
Les nombres suivants appartiennent à $𝔻$ :

$+2,75$ ; $-3,15$ ; $+115$ ; $-305$ ; $+305,00$ ; $-400,05$.

Un nombre entier comme $115$ peut également s'écrire $115,0$.

Ainsi, les écritures $115$ et $115,0$ représentent le même nombre décimal.
]

#v(0.25cm)

#retenir[
Dans ce parcours, nous utiliserons principalement les nombres décimaux positifs et négatifs.

On peut écrire :

• $𝔻^+$ pour les nombres décimaux positifs ;

• $𝔻^-$ pour les nombres décimaux négatifs ;

• $𝔻^*$ pour les nombres décimaux non nuls.

• Le nombre $0$ appartient à $𝔻$.
]

#v(0.5cm)

// ==========================================================
// LIRE UNE POSITION SUR UNE DROITE GRADUÉE
// ==========================================================

#sous_titre[
Repérer une position sur une droite graduée
]

#v(0.15cm)

#definition[
Une droite graduée est une droite sur laquelle on choisit :

• une origine ;

• une unité de longueur ;

• un sens positif.

Chaque point de la droite est alors associé à un nombre appelé #strong[abscisse].


#align(center)[

  #image_full("grad-4e.jpeg")

]
]

#v(1cm)

#exemple_resolu[
Un robot se déplace sur une ligne droite.
On choisit comme origine la position $0$ et comme unité $1$ m.
Si le robot se trouve à $3,5$ m dans le sens positif, son abscisse est :
$+3,5$.
S'il se trouve à $2,5$ m dans le sens opposé, son abscisse est :
$-2,5$.
Les points d'abscisses $-2,5$ et $+3,5$ représentent donc deux positions situées de part et d'autre de l'origine.
]

#v(0.05cm)

#remarque[
Pour graduer une droite, il suffit de choisir une origine, une unité de longueur et un sens positif.
Sur une droite graduée, les nombres positifs se trouvent du côté positif de l'origine et les nombres négatifs du côté opposé.
]

#v(0.05cm)

// ==========================================================
// COMPARER DES NOMBRES DÉCIMAUX
// ==========================================================

#sous_titre[
Comparer des nombres décimaux positifs et négatifs
]

#v(0.05cm)

#propriete[
Sur une droite graduée, le nombre situé le plus à gauche est le plus petit.

Ainsi, si le point d'abscisse $a$ est situé à gauche du point d'abscisse $b$, alors :

$a < b$.

#align(center)[

  #image_full("comp-4e.png")

]

]

#v(0.3cm)

#exemple_resolu[
Comparons 
$-3 < -1,5$.

En effet, $-3$ est situé plus à gauche que $-1,5$.

Comparons :
$-3,5 < +4,5$.

Tout nombre négatif est inférieur à tout nombre positif.

Enfin 
$+1 < +5$.

Ainsi 
$-3 < -1,5 < +1 < +5$.
]

#v(0.05cm)

#regle[
Pour comparer deux nombres décimaux :

• s'ils sont de signes contraires, le nombre négatif est le plus petit ;

• s'ils sont positifs, on compare leurs distances à zéro ;

• s'ils sont négatifs, le plus petit est celui qui est le plus éloigné de zéro.
]

#v(0.05cm)

#exemple[
On compare $-2,6$ et $-1,5$.

Les distances à zéro sont respectivement $2,6$ et $1,5$.

Comme $2,6 > 1,5$, le nombre situé à gauche est $-2,6$.
Donc :
$-2,6 < -1,5$.
]

#v(0.05cm)

// ==========================================================
// RANGER DES NOMBRES DÉCIMAUX
// ==========================================================

#sous_titre[
Ranger des nombres dans l'ordre croissant
]

#v(0.05cm)

#exemple_resolu[
Rangeons les nombres suivants dans l'ordre croissant :
$-4$ ; $+1$ ; $-2,6$ ; $+4,5$ ; $-1,5$ ; $0$ ; $+5$.

On obtient :

$-4 < -2,6 < -1,5 < 0 < +1 < +4,5 < +5$.

Ainsi, l'ordre croissant correspond à l'ordre des points de gauche à droite sur la droite graduée.
]

#v(0.05cm)

// ==========================================================
// OPPOSÉ D'UN NOMBRE DÉCIMAL
// ==========================================================

#sous_titre[
L'opposé d'un nombre décimal
]

#v(0.01cm)

#definition[
L'opposé d'un nombre décimal est le nombre qui a la même distance à zéro mais un signe contraire.

L'opposé de #strong[$+a$] est #strong[$-a$].

L'opposé de #strong[$-a$] est #strong[$+a$].
]

#v(0.3cm)

#exemple_resolu[
L'opposé de $+4,5$ est $-4,5$.

L'opposé de $-3,2$ est $+3,2$.

L'opposé de $0$ est $0$.

Les nombres $-4,5$ et $+4,5$ sont donc opposés.
]

#v(0.05cm)

#remarque[
Deux nombres opposés sont représentés par deux points symétriques par rapport à l'origine de la droite graduée.

Ils ont la même distance à zéro.
]

#v(0.05cm)

// ==========================================================
// DISTANCE À ZÉRO
// ==========================================================

#sous_titre[
La distance à zéro d'un nombre décimal
]

#v(0.05cm)

#definition[
La distance à zéro d'un nombre décimal est la distance entre le point représentant ce nombre et l'origine de la droite graduée.

La distance à zéro est toujours positive ou nulle.
]

#v(0.05cm)

#exemple_resolu[
La distance à zéro de $-4,4$ est $4,4$.

La distance à zéro de $+6$ est $6$.

La distance à zéro de $0$ est $0$.

On peut écrire :

distance à zéro de $(-4,4)$ : $4,4$

distance à zéro de $(+6)$ : $6$.
]

#v(0.05cm)

#retenir[
Deux nombres décimaux opposés ont la même distance à zéro.

Par exemple
$-3,5$ et $+3,5$
ont tous les deux pour distance à zéro :
$3,5$.
]

#v(0.05cm)

// ==========================================================
// ACTIVITÉ — TEMPÉRATURE D'UN COMPOSANT
// ==========================================================

#sous_titre[
Activité — Mesurer des valeurs positives et négatives
]

#v(0.05cm)

#exemple[
Un robot d'exploration possède plusieurs capteurs.

Les mesures enregistrées par l'un de ses systèmes sont :
$+2$ ; $+3$ ; $-2,5$ ; $-1,5$ ; $+2,0$ ; $-3,5$ ; $+2,2$ ; $-4,5$ ; $+5,5$ ; $-5,5$ ; $-6$.

]

#v(0.05cm)

#exercice[
1. Recopie cette liste.

2. Dresse la liste des nombres décimaux positifs.

3. Dresse la liste des nombres décimaux négatifs.

4. Quels nombres sont opposés ?

5. Quels nombres ont la même distance à zéro ?

6. Range les nombres suivants dans l'ordre croissant :$-4,5$ ; $+2$ ; $-1,5$ ; $0$ ; $+5,5$.
]

#v(0.05cm)

// ==========================================================
// SOMME DE NOMBRES DÉCIMAUX
// ==========================================================

#sous_titre[
Additionner des nombres décimaux positifs et négatifs
]

#v(0.05cm)

#exemple_resolu[
Un robot avance de $5$ m puis recule de $4$ m.

On représente ces déplacements par :
$(+5)+(-4)$.

Le robot avance finalement de :
$+1$ m.

Donc :
$(+5)+(-4)=(+1)$.
]

#v(0.05cm)

#exemple[
Un robot avance de $1$ m puis recule de $4$ m :

$(+1)+(-4)=(-3)$.

Il recule donc finalement de $3$ m.

Un robot avance de $1$ m puis de $3$ m :

$(+1)+(+3)=(+4)$.

Il avance donc finalement de $4$ m.

Un robot recule de $3$ m puis de $2$ m :

$(-3)+(-2)=(-5)$.

Il recule donc finalement de $5$ m.
]

#v(0.05cm)

#regle[
La somme de deux nombres décimaux de même signe :

• garde ce signe ;

• a pour distance à zéro la somme des distances à zéro.

La somme de deux nombres décimaux de signes contraires :

• prend le signe du nombre ayant la plus grande distance à zéro ;

• a pour distance à zéro la différence des deux distances à zéro.
]

#v(0.05cm)

#exemple_resolu[
Calculons :
$(-7,5)+(-2,3)$.

Les deux nombres sont négatifs.

On additionne leurs distances à zéro :

$7,5+2,3=9,8$.

Donc 
$(-7,5)+(-2,3)=(-9,8)$.

Calculons maintenant :
$(+8,2)+(-3,7)$.

Les distances à zéro sont $8,2$ et $3,7$.

Comme $8,2>3,7$, le résultat est positif.

$8,2-3,7=4,5$.

Donc 
$(+8,2)+(-3,7)=(+4,5)$.
]

#v(0.05cm)

// ==========================================================
// OPPOSÉ ET DIFFÉRENCE
// ==========================================================

#sous_titre[
Soustraire des nombres décimaux
]

#v(0.05cm)

#definition[
La différence de deux nombres décimaux $a$ et $b$ est la somme de $a$ et de l'opposé de $b$.

On a :
#strong[$a-b=a+$opp$(b)$].
]

#v(0.3cm)

#exemple_resolu[
Calculons :
$(+4)-(+5)$.

L'opposé de $(+5)$ est $(-5)$.

Donc :
$(+4)-(+5)=(+4)+(-5)$.

Ainsi :
$(+4)-(+5)=(-1)$.
]

#v(0.05cm)

#exemple[
Un robot se trouve à la position $+2,5$ m.

Il doit atteindre la position $-1,5$ m.

La variation de position est :
$(-1,5)-(+2,5)$.

On transforme la différence en somme :

$(-1,5)+(-2,5)$.

Donc :
$(-1,5)-(+2,5)=(-4)$.

Le robot doit donc effectuer une variation de position de $-4$ m.
]

#v(0.05cm)

// ==========================================================
// SOMME ALGÉBRIQUE
// ==========================================================

#sous_titre[
Calculer une somme algébrique
]

#v(0.05cm)

#definition[
Une somme algébrique est une suite de sommes et de différences de nombres décimaux positifs ou négatifs.
]

#v(0.05cm)

#exemple_resolu[
Calculons :
$a=(+2,3)-(+2,9)-(-5,2)+(-0,5)$.

On transforme les différences en additions :

$a=(+2,3)+(-2,9)+(+5,2)+(-0,5)$.

On regroupe :
$a=(+2,3)+(+5,2)+(-2,9)+(-0,5)$.

Donc :
$a=(+7,5)+(-3,4)$.

Ainsi :
$a=+4,1$.

On peut également écrire directement :

$a=2,3-2,9+5,2-0,5$

et obtenir :
$a=4,1$.
]

#v(0.05cm)

// ==========================================================
// PRODUIT DE NOMBRES DÉCIMAUX
// ==========================================================

#sous_titre[
Multiplier des nombres décimaux positifs et négatifs
]

#v(0.05cm)

#exemple[
Un système de commande d'un robot utilise les produits suivants :

$(+1)×(+3)=(+3)$

$(-2)×(-3)=(+6)$

$(-2)×(+2)=(-4)$

$(+3)×(-4)=(-12)$

On remarque que le signe du résultat dépend des signes des facteurs.
]

#v(0.05cm)

#regle[
Pour multiplier deux nombres décimaux :

• le produit de deux nombres de même signe est positif ;

• le produit de deux nombres de signes contraires est négatif.
]

#v(0.05cm)

#exemple_resolu[
•Calculons :
$(-7)×(+2)$.

Les signes sont différents, donc le résultat est négatif.

$7×2=14$.

Donc :
$(-7)×(+2)=(-14)$.

•Calculons :
$(-5)×(-3)$.

Les signes sont identiques, donc le résultat est positif.

$5×3=15$.

Donc :
$(-5)×(-3)=(+15)$.

Enfin :
$(+8,5)×(+3)$.

Les deux facteurs sont positifs.

$8,5×3=25,5$.

Donc :
$(+8,5)×(+3)=(+25,5)$.
]

#v(0.3cm)

#retenir[
Pour calculer le produit de deux nombres décimaux :

1. on détermine le signe du produit ;

2. on multiplie les distances à zéro des deux facteurs.

Si un produit possède un nombre pair de facteurs négatifs, le résultat est positif.

S'il possède un nombre impair de facteurs négatifs, le résultat est négatif.
]

#v(0.05cm)

// ==========================================================
// PRODUITS DE PLUSIEURS FACTEURS
// ==========================================================

#sous_titre[
Produit de plusieurs nombres décimaux
]

#v(0.05cm)

#exemple_resolu[
Calculons :
$(-3)×(+2,5)×(-5)$.

Il y a deux facteurs négatifs.

Le nombre de facteurs négatifs est pair, donc le résultat est positif.

Calculons les distances à zéro :
$3×2,5×5=37,5$.

Donc :
$(-3)×(+2,5)×(-5)=(+37,5)$.
]

#v(0.05cm)

// ==========================================================
// PUISSANCES
// ==========================================================

#sous_titre[
Les puissances de nombres décimaux
]

#v(0.05cm)

#definition[
Pour tout nombre décimal $a$ et tout entier naturel non nul $n$, la puissance $a^n$ désigne le produit de $n$ facteurs égaux à $a$ :

#strong[$a^n=a×a×a×...×a$]
avec $n$ facteurs égaux à $a$.

• $a$ est la #strong[base] ;

• $n$ est l'#strong[exposant].
]

#v(1cm)

#exemple[
Un robot effectue plusieurs fois le même facteur dans un calcul de correction.

On peut écrire :

$0,5×0,5=0,5^2$

$(-0,5)×(-0,5)=(-0,5)^2$

$(-0,2)×(-0,2)×(-0,2)=(-0,2)^3$.

La puissance permet donc de représenter simplement une répétition du même nombre décimal.
]

#v(0.05cm)

#retenir[
$2,5^3$ signifie :
$2,5×2,5×2,5$.

De même :
$(-0,4)^2=(-0,4)×(-0,4)$.

La base d'une puissance peut donc être un nombre décimal positif ou négatif.
]

#v(0.05cm)

// ==========================================================
// CALCULER UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Calculer une puissance
]

#v(0.05cm)

#exemple_resolu[
• Calculons :
$(+0,5)^3$.

On développe :
$(+0,5)^3=(+0,5)×(+0,5)×(+0,5)$.

Donc :
$(+0,5)^3=+0,125$.

• Calculons :
$(-0,5)^2$.

On a 
$(-0,5)^2=(-0,5)×(-0,5)$.

Le produit de deux nombres négatifs est positif.

Donc :
$(-0,5)^2=+0,25$.

Enfin :
$(-0,5)^3=(-0,5)×(-0,5)×(-0,5)$.

Il y a trois facteurs négatifs.

Le résultat est donc négatif :
$(-0,5)^3=-0,125$.
]

#v(2cm)

#propriete[
Si la base est positive, toute puissance de cette base est positive.

Si la base est négative :

• une puissance d'exposant pair est positive ;

• une puissance d'exposant impair est négative.
]

#v(0.05cm)

// ==========================================================
// PUISSANCES PARTICULIÈRES
// ==========================================================

#sous_sous_titre[
Puissances particulières
]

#v(0.05cm)

#definition[
Pour tout nombre décimal $a$ :

$a^1=a$.

Pour tout nombre décimal non nul $a$ :

$a^0=1$.
]

#v(0.05cm)

#exemple[
$(+2,5)^1=+2,5$

$(-3,2)^1=-3,2$

$(+0,75)^0=1$

$(-4,5)^0=1$.
]

#v(0.05cm)

#remarque[
Dans les calculs élémentaires, le cas $0^0$ n'est pas utilisé.
]

#v(0.05cm)

// ==========================================================
// PRODUIT DE PUISSANCES DE MÊME BASE
// ==========================================================

#sous_titre[
Produit de puissances de même base
]

#v(0.05cm)

#retenir[
Pour multiplier des puissances de même base, on conserve la base et on additionne les exposants :

#strong[$a^n×a^m=a^(n+m)$].
]

#v(0.05cm)

#exemple[
Un système de commande utilise successivement les facteurs :

$(-0,5)^2$ et $(-0,5)^3$.

On peut écrire :

$(-0,5)^2×(-0,5)^3=(-0,5)^(2+3)$

$(-0,5)^2×(-0,5)^3=(-0,5)^5$.

Cette écriture regroupe les cinq facteurs égaux à $-0,5$.
]

#v(0.05cm)

// ==========================================================
// PUISSANCE D'UN PRODUIT
// ==========================================================

#sous_sous_titre[
Puissance d'un produit
]

#v(0.05cm)

#definition[
Pour deux nombres décimaux $a$ et $b$ et un entier naturel $n$, on a :

#strong[$(a×b)^n=a^n×b^n$].
]

#v(0.05cm)

#exemple[
Un calcul de commande utilise :

$(-0,5×2)^2$.

On peut écrire :

$(-0,5×2)^2=(-0,5)^2×2^2$.

Calculons :
$(-0,5)^2=0,25$
et 
$2^2=4$.

Donc :
$(-0,5×2)^2=0,25×4=1$.
]

#v(0.05cm)

// ==========================================================
// PUISSANCE D'UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Puissance d'une puissance
]

#v(0.05cm)

#retenir[
Pour élever une puissance à une autre puissance, on conserve la base et on multiplie les exposants :

#strong[$(a^n)^m=a^(n×m)$].
]

#v(1cm)

#exemple[
Un système de correction utilise la quantité :
$((-0,5)^2)^3$.

On applique la règle :
$((-0,5)^2)^3=(-0,5)^(2×3)$.

Donc :
$((-0,5)^2)^3=(-0,5)^6$.

L'exposant $6$ est pair, donc le résultat est positif.

Ainsi :
$(-0,5)^6=0,015625$.
]

#v(0.05cm)

// ==========================================================
// CALCULS AVEC DES PUISSANCES
// ==========================================================

#sous_sous_titre[
Calculs avec les puissances
]

#v(0.05cm)

#exemple_resolu[
Un robot effectue un calcul de correction donné par :$3×(-0,5)^2$.

La puissance est prioritaire.

On calcule d'abord :
$(-0,5)^2=0,25$.

Puis :
$3×0,25=0,75$.

Donc :
$3×(-0,5)^2=0,75$.

Considérons maintenant :
$2+(-0,5)^3$.

On calcule :
$(-0,5)^3=-0,125$.

Donc :
$2+(-0,125)=1,875$.

Enfin :
$(-1+0,5)^2$.

On calcule d'abord ce qui se trouve entre parenthèses :
$-1+0,5=-0,5$.

Donc :
$(-1+0,5)^2=(-0,5)^2=0,25$.
]

#v(0.05cm)

// ==========================================================
// PRIORITÉ DES OPÉRATIONS
// ==========================================================

#sous_sous_titre[
Priorité des puissances
]

#v(0.15cm)

#retenir[
Dans une suite d'opérations sans parenthèses, les puissances sont prioritaires sur les multiplications, les divisions, les additions et les soustractions.

Lorsque des parenthèses sont présentes, on effectue d'abord les calculs entre parenthèses.
]

#v(0.25cm)

#exemple[
Un robot reçoit l'instruction mathématique :

$4+3×(-0,5)^2$.

On calcule d'abord la puissance :$(-0,5)^2=0,25$.

Puis la multiplication :
$3×0,25=0,75$.

Enfin l'addition :
$4+0,75=4,75$.

Donc :
$4+3×(-0,5)^2=4,75$.
]

#v(0.05cm)

// ==========================================================
// EXERCICE D'APPLICATION
// ==========================================================

#exercice_resolu[

#mission[
🤖 Application — Programmer les mouvements d'un robot
]

#v(0.05cm)

#text(
weight:"bold",
)[
1. Représenter une position
]

Un robot se trouve à $-2,5$ m de son point de référence.
Il avance de $4$ m.

Détermine sa nouvelle position.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

La nouvelle position est :
$-2,5+4=+1,5$.

Le robot se trouve donc à $+1,5$ m du point de référence.

#v(0.05cm)

#text(
weight:"bold",
)[
2. Comparer deux positions
]

Deux robots se trouvent respectivement aux positions :
$-3,5$ m et $-1,2$ m.

Lequel est le plus proche du point de référence ?

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Les distances à zéro sont :
$3,5$ m et $1,2$ m.

Comme :
$1,2<3,5$,

le robot situé à $-1,2$ m est le plus proche du point de référence.

#v(0.05cm)

#text(
weight:"bold",
)[
3. Calculer une variation
]

Un robot avance de $3,5$ m puis recule de $5,2$ m.

Détermine son déplacement total.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On traduit la situation par :

$(+3,5)+(-5,2)$.

Les distances à zéro sont $3,5$ et $5,2$.

Comme $5,2>3,5$, le résultat est négatif.

$5,2-3,5=1,7$.

Donc :
$(+3,5)+(-5,2)=(-1,7)$.

Le robot a finalement reculé de $1,7$ m.

#v(0.05cm)

#text(
weight:"bold",
)[
4. Calculer une différence
]

Le robot passe de la position $-1,5$ m à la position $+2,5$ m.

Calcule la variation de position.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

La variation est :
$(+2,5)-(-1,5)$.

L'opposé de $-1,5$ est $+1,5$.

Donc :
$(+2,5)-(-1,5)=(+2,5)+(+1,5)$.

Ainsi :
$(+2,5)-(-1,5)=+4$.

Le robot a avancé de $4$ m.

#v(0.05cm)

#text(
weight:"bold",
)[
5. Calculer un produit
]

Un système de commande utilise :

$(-2,5)×(+0,4)$.

Calcule ce produit.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Les signes sont contraires.

Le résultat est donc négatif.

$2,5×0,4=1$.

Donc :
$(-2,5)×(+0,4)=(-1)$.

#v(0.05cm)

#text(
weight:"bold",
)[
6. Utiliser une puissance
]
Un calcul répète trois fois le facteur $-0,5$.

Écris cette répétition sous forme de puissance puis calcule-la.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On a :
$(-0,5)×(-0,5)×(-0,5)=(-0,5)^3$.

Comme l'exposant est impair, le résultat est négatif.

$0,5×0,5×0,5=0,125$.

Donc :
$(-0,5)^3=-0,125$.

#v(0.05cm)

#text(
weight:"bold",
)[
7. Produit de puissances
]

Simplifie :
$(-0,2)^3×(-0,2)^2$.

#v(1cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Les bases sont identiques.

On additionne les exposants :

$(-0,2)^3×(-0,2)^2=(-0,2)^(3+2)$.

Donc :
$(-0,2)^3×(-0,2)^2=(-0,2)^5$.

#v(0.05cm)

#text(
weight:"bold",
)[
8. Puissance d'un produit
]

Calcule :
$(-0,5×2)^2$.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On peut écrire :
$(-0,5×2)^2=(-0,5)^2×2^2$.

Donc :
$0,25×4=1$.

Ainsi :
$(-0,5×2)^2=1$.

#v(0.05cm)

#text(
weight:"bold",
)[
9. Priorité des opérations
]

Calcule :
$3+2×(-0,5)^2$.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On calcule d'abord la puissance :
$(-0,5)^2=0,25$.

Puis :
$2×0,25=0,5$.

Enfin :
$3+0,5=3,5$.

Donc :
$3+2×(-0,5)^2=3,5$.
]

#v(0.05cm)

// ==========================================================
// RÉINVESTISSEMENT — NAVIGATION D'UN ROBOT
// ==========================================================

#mission[

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
🤖 Réinvestissement — Programmer la trajectoire d'un robot
]

#v(0.2cm)

Un robot autonome se déplace dans un laboratoire.

On représente sa position sur un axe gradué en mètres.

Le point $0$ correspond à sa station de départ.

Le sens vers la droite est choisi comme sens positif.

#v(0.3cm)

#text(
weight: "bold",
)[
1. Lire et interpréter une position
]

Le robot se trouve à la position $-3,5$ m.

Que signifie cette information ?

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Le nombre $-3,5$ indique que le robot se trouve à $3,5$ m de la station de départ dans le sens opposé au sens positif.

Sa distance à zéro est donc :
$3,5$ m.

#v(0.3cm)

#text(
weight: "bold",
)[
2. Comparer deux positions
]

Le robot peut se trouver aux positions $-3,5$ m, $-1,5$ m ou $+2,5$ m.

Range ces positions dans l'ordre croissant.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Sur la droite graduée, on obtient :

$-3,5<$-1,5$<+2,5$.

#v(0.05cm)

#text(
weight: "bold",
)[
3. Déterminer une position opposée
]

Le robot se trouve à la position $-2,5$ m.

Quelle position lui est opposée par rapport à la station de départ ?

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

L'opposé de $-2,5$ est $+2,5$.

Les deux positions ont la même distance à zéro :
$2,5$ m.

#v(0.05cm)

#text(
weight: "bold",
)[
4. Calculer une succession de déplacements
]

Le robot avance de $4,5$ m puis recule de $2,7$ m.

Quelle est sa variation de position ?

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On écrit :
$(+4,5)+(-2,7)$.

Le résultat est positif.

$4,5-2,7=1,8$.

Donc :
$(+4,5)+(-2,7)=(+1,8)$.

Le robot a finalement avancé de $1,8$ m.

#v(0.05cm)

#text(
weight: "bold",
)[
5. Corriger une trajectoire
]

Le robot se trouve à $+1,8$ m.

Le système lui demande d'atteindre la position $-2,2$ m.

Quelle variation de position doit-il effectuer ?

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On calcule :
$(-2,2)-(+1,8)$.

Donc :
$(-2,2)+(-1,8)$.

Ainsi :
$(-2,2)-(+1,8)=(-4)$.

Le robot doit donc effectuer une variation de position de $-4$ m.

#v(1cm)

#text(
weight: "bold",
)[
6. Calculer un coefficient de correction
]

Un programme utilise le coefficient :

$(-2)×(+0,75)$.

Calcule ce coefficient.

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Les signes sont contraires.

Le résultat est négatif.

$2×0,75=1,5$.

Donc :
$(-2)×(+0,75)=(-1,5)$.

#v(0.05cm)

#text(
weight: "bold",
)[
7. Utiliser une puissance dans le programme
]

Une procédure de correction répète trois fois le facteur $-0,5$.

Écris cette répétition sous forme de puissance et calcule-la.

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On écrit :
$(-0,5)^3$.

Puis :
$(-0,5)^3=(-0,5)×(-0,5)×(-0,5)$.

Donc :
$(-0,5)^3=-0,125$.

#v(0.05cm)

#text(
weight: "bold",
)[
8. Comparer deux corrections
]

Deux procédures utilisent respectivement :

$(-0,5)^2$
et
$(-0,5)^3$.

Calcule ces deux valeurs et compare-les.

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On a :

$(-0,5)^2=+0,25$
et 
$(-0,5)^3=-0,125$.

Donc :
$(-0,5)^3<(-0,5)^2$.

#v(0.05cm)

#text(
weight: "bold",
)[
9. Simplifier une expression
]

Simplifie :

$(-0,4)^2×(-0,4)^3$.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Les bases sont identiques.

On additionne les exposants :

$(-0,4)^2×(-0,4)^3=(-0,4)^5$.

#v(2cm)

#text(
weight: "bold",
)[
10. Calculer une expression complète
]

Le programme d'un robot utilise l'expression :

$2+3×(-0,5)^2$.

Calcule cette expression.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

La puissance est prioritaire :
$(-0,5)^2=0,25$.

Puis :
$3×0,25=0,75$.

Enfin :
$2+0,75=2,75$.

Donc :
$2+3×(-0,5)^2=2,75$.

#v(0.05cm)

#text(
weight: "bold",
)[
11. Relier les mathématiques à la robotique
]

Complète les phrases suivantes :

a) Un nombre décimal ..... peut représenter une position ou un déplacement dans le sens choisi comme positif.(#strong[distance à zéro],#strong[positif],#strong[négatif]).

b) Un nombre décimal ..... peut représenter une position ou un déplacement dans le sens opposé.(#strong[distance à zéro],#strong[positif],#strong[négatif]).

c) La ..... indique la distance entre une position et l'origine.(#strong[distance à zéro],#strong[positif],#strong[négatif]).

d) Deux nombres ..... ont la même distance à zéro et des signes contraires.(#strong[opposés],#strong[distances à zéro],$a+$opp$(b)$).

e) Pour additionner deux nombres de signes contraires, on compare leurs .....(#strong[opposés],#strong[distances à zéro],$a+$opp$(b)$).

f) La différence $a-b$ peut être transformée en une somme :..... (#strong[opposés],$a+$opp$(b)$,#strong[distances à zéro]).

g) Le produit de deux nombres de même signe est .....(#strong[distance à zéro],#strong[positif],#strong[négatif]).

h) Le produit de deux nombres de signes contraires est .....(#strong[distance à zéro],#strong[positif],#strong[négatif]).

i) Une ..... permet de représenter un produit dans lequel un même facteur est répété.(#strong[puissance],#strong[positive lorsque l'exposant est pair],#strong[négative lorsque l'exposant est impair]).

j) Une puissance d'une base négative est ..... et .....(#strong[puissance],#strong[positive lorsque l'exposant est pair],#strong[négative lorsque l'exposant est impair]).
]

#v(0.4cm)

#retenir[

#v(0.1cm)

Pour analyser et programmer les déplacements d'un robot, je peux :

#v(0.05cm)

📍 utiliser les nombres décimaux positifs et négatifs pour représenter des positions ;

#v(0.05cm)

📏 utiliser la distance à zéro pour mesurer l'écart entre une position et l'origine ;

#v(0.05cm)

⚖️ comparer et ranger les positions sur une droite graduée ;

#v(0.05cm)

🔄 utiliser les opposés pour représenter deux positions symétriques ;

#v(0.05cm)

➕ additionner des déplacements pour déterminer une variation totale ;

#v(0.05cm)

➖ transformer une différence en somme de l'opposé ;

#v(0.05cm)

✖️ utiliser les règles de signes pour calculer des produits ;

#v(0.05cm)

🔢 utiliser les puissances pour représenter la répétition d'un même facteur décimal ;

#v(0.05cm)

🤖 et combiner ces outils pour analyser et corriger la trajectoire d'un robot.

]
]

#pagebreak()



















































// ==========================================================
// PARCOURS 4e
// NOMBRES DÉCIMAUX ET PUISSANCES DE 10 DANS L'ÉNERGIE SOLAIRE
// ==========================================================


#parcours(
  [PARCOURS 4ᵉ — Les nombres décimaux et les puissances de 10 dans l'énergie solaire],
  "parcours-nombres-decimaux-4e",
) <parcours-nombres-decimaux-4e>

// ==========================================================
// ACTIVITÉ DE DÉCOUVERTE
// ==========================================================

#activite[

  ☀️ À la découverte d'un système solaire autonome

  Dans de nombreuses zones rurales ou isolées, il est possible
  de produire de l'électricité sans être directement raccordé
  au réseau électrique.
  Une solution consiste à utiliser un #strong[système solaire
  photovoltaïque autonome].
  Un système solaire simple peut être constitué de plusieurs
  éléments :

  • un #strong[panneau solaire photovoltaïque] qui transforme
    l'énergie lumineuse du Soleil en énergie électrique ;

  • un #strong[contrôleur de charge] qui contrôle l'énergie
    provenant du panneau et protège la batterie pendant sa charge ;

  • une #strong[batterie] qui stocke l'énergie électrique
    pour pouvoir l'utiliser lorsque le Soleil ne produit plus
    suffisamment d'énergie ;

  • une #strong[lampe] qui transforme l'énergie électrique
    en énergie lumineuse ;

  • des #strong[fils conducteurs] qui permettent de relier
    les différents éléments du système.

  On peut représenter simplement le fonctionnement du système
  par la chaîne :

  #align(center)[
    ☀️ Panneau solaire
    $→$
    ⚙️ Contrôleur de charge
    $→$
    🔋 Batterie
    $→$
    💡 Lampe
  ]

  Les fils conducteurs permettent de réaliser les connexions
  électriques entre les différents composants.
  Le fonctionnement du système peut être résumé ainsi :

  #strong[Le panneau solaire produit de l'énergie électrique.]
  Cette énergie est dirigée vers le #strong[contrôleur de charge],
  qui régule la charge de la batterie.
  La #strong[batterie stocke] ensuite une partie de l'énergie
  produite.
  Lorsque la lampe est connectée au circuit, la batterie lui
  fournit l'énergie nécessaire à son fonctionnement.

  #v(0.12cm)

  Pour réaliser et étudier un tel système, le technicien doit
  effectuer différentes mesures.

  Il peut par exemple mesurer :

  • la tension électrique du panneau ;

  • la tension de la batterie ;

  • l'intensité du courant dans le circuit ;

  • la puissance de la lampe ;

  • la durée d'utilisation de la lampe ;

  • les dimensions du panneau solaire ;

  • la quantité d'énergie produite ou consommée.
]
#activite[

  Ces mesures sont souvent exprimées avec des
  #strong[nombres décimaux].
  Par exemple, une batterie peut avoir une tension nominale
  de $12,0V$, tandis qu'un panneau peut fournir une tension
  de $18,5V$ dans certaines conditions.
  Certaines grandeurs utilisées en électricité peuvent également
  être très grandes ou très petites.

  Pour écrire plus facilement ces nombres, les techniciens
  utilisent les #strong[puissances de $10$].
  Par exemple :

  $1 000 = 10^3$
et
$0,001 = 10^(-3)$.

  Les puissances de $10$ permettent ainsi d'écrire de manière
  compacte certaines mesures et de faciliter les calculs.

  #strong[Observe les nombres suivants :]

  $0,001$ ; $0,01$ ; $0,1$ ; $1$ ; $10$ ; $100$ ; $1 000$.

  1. Quels nombres sont inférieurs à $1$ ?

  2. Quels nombres sont supérieurs à $1$ ?

  3. Combien de chiffres après la virgule comporte $0,001$ ?

  4. Comment peut-on écrire $1 000$ à l'aide d'une puissance
     de $10$ ?

  5. Comment peut-on écrire $0,001$ à l'aide d'une puissance
     de $10$ ?

  6. Compare $0,001$ et $0,0001$.

  7. Que remarques-tu lorsque l'exposant de $10$ devient négatif ?

  8. Un technicien écrit une mesure sous la forme
     $625 × 10^(-5)$.
     Peut-il retrouver une écriture décimale de cette mesure ?

  9. Pourquoi les puissances de $10$ peuvent-elles être utiles
     pour écrire des mesures très grandes ou très petites ?

  10. Comment pourrait-on comparer deux mesures écrites sous la
      forme $a × 10^n$ ?

  #strong[Vers une réalisation concrète]

  Après avoir étudié les nombres décimaux et les puissances de $10$,
  les connaissances mathématiques pourront être réinvesties dans
  l'étude d'un #strong[petit système solaire autonome].

  L'objectif sera de comprendre les grandeurs électriques rencontrées
  dans le montage et de savoir exploiter les valeurs mesurées.

  Le système étudié sera constitué de :

  #align(center)[
    ☀️ panneau solaire
    $→$
    ⚙️ contrôleur de charge
    $→$
    🔋 batterie
    $→$
    💡 lampe
  ]

  Les différents composants seront reliés par des
  #strong[fils conducteurs] afin de former un circuit fonctionnel.
  Cette situation permettra de donner un sens concret aux
  nombres décimaux, aux puissances de $10$ et aux calculs
  utilisés pour caractériser les grandeurs électriques.
  Nous allons maintenant découvrir comment les puissances de $10$
  permettent d'écrire, de comparer et de calculer avec des nombres
  décimaux utilisés dans les systèmes électriques et photovoltaïques.
]

#align(center)[
  #image_full("energie-solaire-4e.jpeg")
]


#v(0.3cm)


// ==========================================================
// CE QUE TU VAS APPRENDRE
// ==========================================================

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
🎯 Ce que tu vas apprendre
]

#v(0.12cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

À la fin de ce parcours, tu seras capable de :

#v(0.08cm)

🔢 reconnaître et utiliser les #strong[puissances de $10$] ;

#v(0.05cm)

🔢 écrire une puissance de $10$ à exposant entier relatif
  sous forme décimale ;

#v(0.05cm)

↔️ passer d'une écriture décimale à une écriture faisant intervenir
  une #strong[puissance de $10$] ;

#v(0.05cm)

🧮 utiliser les règles de calcul sur les #strong[puissances de $10$] ;

#v(0.05cm)

⚙️ utiliser le #strong[produit de puissances de même base] ;

#v(0.05cm)

🔗 utiliser la #strong[puissance d'une puissance] ;

#v(0.05cm)

📐 écrire un nombre décimal sous la forme
  #strong[$a × 10^n$], avec $a$ et $n$ entiers relatifs ;

#v(0.05cm)

✖️ effectuer des produits et des quotients de nombres écrits
  sous la forme #strong[$a × 10^n$] ;

#v(0.05cm)

📏 encadrer un nombre décimal par deux puissances de $10$
  d'exposants consécutifs ;

#v(0.05cm)

⚖️ comparer deux nombres décimaux écrits sous la forme
  #strong[$a × 10^n$] ;

#v(0.05cm)

🔢 déterminer l'#strong[ordre d'un nombre décimal] ;

#v(0.05cm)

✂️ déterminer la #strong[troncature] d'un nombre décimal ;

#v(0.05cm)

☀️ et utiliser ces outils pour résoudre des problèmes simples
  liés aux #strong[mesures et aux installations solaires].
]


#v(0.3cm)

#remarque[
L'énergie solaire mobilise des mesures très diverses.

Certaines sont grandes, comme la puissance d'une installation
ou la surface d'un toit.

D'autres peuvent être très petites.

Les #strong[nombres décimaux] et les #strong[puissances de $10$]
permettent de représenter ces mesures de manière précise et
d'effectuer plus facilement certains calculs.
]


#v(0.4cm)
#pagebreak()


// ==========================================================
// PARTIE A — LES PUISSANCES DE 10
// ==========================================================

#deux-colonnes[


#sous_titre[
LES PUISSANCES DE $10$ À EXPOSANTS ENTIERS RELATIFS
]


// ==========================================================
// 1. LES PUISSANCES DE 10 À EXPOSANTS POSITIFS
// ==========================================================

#sous_sous_titre[
Les puissances de $10$ à exposants positifs
]

#v(0.15cm)

#definition[
Pour tout entier naturel non nul $n$, la puissance $10^n$
désigne le produit de $n$ facteurs égaux à $10$ :
#strong[$10^n = 10 × 10 × ... × 10$].

Le nombre #strong[$10$] est la #strong[base].

Le nombre #strong[$n$] est l'#strong[exposant].
]

#exemple[
Dans une installation solaire, un technicien doit représenter
le nombre $1 000$.

On a :
 $10^3 = 10 × 10 × 10$.

Donc : 
$10^3 = 1 000$.

De même : 
$10^5 = 100 000$.
]

#retenir[
Pour tout entier naturel $n$ :

$10^n$ est le nombre $1$ suivi de $n$ zéros.
]


// ==========================================================
// 2. LES PUISSANCES DE 10 À EXPOSANTS NÉGATIFS
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Découvrir les puissances de $10$ à exposants négatifs
]

#v(0.15cm)

Pour comprendre les exposants négatifs, observons les puissances
successives de $10$ :

$10^3 = 1 000$

$10^2 = 100$

$10^1 = 10$

$10^0 = 1$.

Lorsque l'exposant diminue encore d'une unité, on divise par $10$.

Ainsi :

$10^(-1) = 0,1$

$10^(-2) = 0,01$

$10^(-3) = 0,001$.

#definition[
Soit $n$ un entier naturel.

La puissance $10^(-n)$ est l'inverse de $10^n$ :

$10^(-n) = 1 / 10^n$.
]

#exemple_resolu[
Un technicien souhaite écrire une très petite mesure sous
forme décimale.

Calculons :
$10^(-3)$.

On utilise :

$10^(-3) = 1 / 10^3$.

Or :
$10^3 = 1 000$.

Donc :
$10^(-3) = 1 / (1 000)$.

Ainsi :
$10^(-3) = 0,001$.
]

#v(0.2cm)

#exemple[
De même :

$10^(-1) = 0,1$

$10^(-2) = 0,01$

$10^(-4) = 0,0001$

$10^(-5) = 0,00001$.
]

#retenir[
Pour tout entier naturel non nul $n$ :

#strong[$10^(-n)$] s'écrit sous forme décimale comme
#strong[$0,000...001$], avec $n$ chiffres après la virgule
et un seul chiffre $1$ à la fin.
]


// ==========================================================
// 3. PRODUIT DE PUISSANCES DE 10
// ==========================================================

#sous_sous_titre[
Produit de puissances de $10$
]

Dans les calculs liés à l'énergie solaire, on peut être amené
à multiplier des grandeurs exprimées à l'aide de puissances de $10$.

#retenir[
Pour tous entiers relatifs $n$ et $m$ :

#strong[$10^n × 10^m = 10^(n+m)$].
]

#exemple_resolu[
Calculons :
$10^3 × 10^(-5)$.

On utilise la règle du produit de puissances de même base :

$10^3 × 10^(-5) = 10^(3 + (-5))$.

Donc :
$10^3 × 10^(-5) = 10^(-2)$.

Or :
$10^(-2) = 0,01$.

Ainsi :
$10^3 × 10^(-5) = 0,01$.
]

#exemple[
Calculons :
$10^(-4) × 10^2$.

On a :
$10^(-4) × 10^2 = 10^(-4+2)$.

Donc :
$10^(-4) × 10^2 = 10^(-2)$.

Ainsi :
$10^(-4) × 10^2 = 0,01$.
]


// ==========================================================
// 4. PRODUIT D'UNE PUISSANCE PAR SON INVERSE
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Le produit d'une puissance de $10$ par son inverse
]

#exemple_resolu[
Calculons :
$10^5 × 10^(-5)$.

D'après la règle du produit :
$10^5 × 10^(-5) = 10^(5+(-5))$.

Donc :
$10^5 × 10^(-5) = 10^0$.

Or :
$10^0=1$.

Ainsi :
$10^5 × 10^(-5)=1$.
]

#retenir[
Pour tout entier relatif $n$ :

#strong[$10^n × 10^(-n)=1$].
]

#remarque[
Cette propriété traduit le fait que $10^(-n)$ est l'inverse
de $10^n$.
]


// ==========================================================
// 5. QUOTIENT DE PUISSANCES DE 10
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Quotient de puissances de $10$
]

#retenir[
Pour tous entiers relatifs $n$ et $m$ :

#strong[$10^n / 10^m = 10^(n-m)$].
]

#exemple_resolu[
Calculons :
$10^7 / 10^3$.

On a :
$10^7 / 10^3 = 10^(7-3)$.

Donc :
$10^7 / 10^3 = 10^4$.

Ainsi :
$10^7 / 10^3 = 10 000$.
]

#v(0.2cm)

#exemple[
Calculons :
$10^(-3) / 10^(-1)$.

On a :
$10^(-3) / 10^(-1) = 10^(-3-(-1))$.

Donc :
$10^(-3) / 10^(-1)=10^(-2)$.

Ainsi :
$10^(-3) / 10^(-1)=0,01$.
]


// ==========================================================
// 6. PUISSANCE D'UNE PUISSANCE
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Puissance d'une puissance de $10$
]

#retenir[
Pour tous entiers relatifs $n$ et $m$ :

#strong[$(10^n)^m = 10^(n×m)$].
]

#exemple_resolu[
Calculons :
$(10^(-3))^4$.

On utilise la règle de la puissance d'une puissance :

$(10^(-3))^4 = 10^((-3)×4)$.

Donc :
$(10^(-3))^4 = 10^(-12)$.

Ainsi :
$(10^(-3))^4 = 0,000000000001$.
]

#exemple[
Calculons :
$(10^2)^5$.

On a :
$(10^2)^5 = 10^(2×5)$.

Donc :
$(10^2)^5 = 10^10$.
]


// ==========================================================
// PARTIE B — ÉCRITURE D'UN NOMBRE DÉCIMAL
// ==========================================================

#sous_titre[
ÉCRIRE ET CALCULER AVEC LES NOMBRES DÉCIMAUX
]


// ==========================================================
// 7. ÉCRITURE D'UN NOMBRE DÉCIMAL SOUS LA FORME a × 10^n
// ==========================================================

#v(0.2cm)

#sous_sous_titre[
Écriture d'un nombre décimal sous la forme $a × 10^n$
]

#definition[
Un nombre décimal peut s'écrire sous la forme :
#strong[$a × 10^n$]
où $a$ et $n$ sont des entiers relatifs.
]

#exemple_resolu[
Un technicien mesure une distance de :
$6,25m$.

On sait que :
$6,25 = 625 / 100$.

Or :
$1 / 100 = 10^(-2)$.

Donc :
$6,25 = 625 × 10^(-2)$.

Ainsi :
$6,25m = 625 × 10^(-2)m$.
]
#exemple[
Écrivons $0,273$ sous la forme $a × 10^n$.

On déplace la virgule de trois rangs vers la droite :

$0,273 = 273 × 10^(-3)$.
Donc :
$0,273 = 273 × 10^(-3)$.
]

#exemple[
Écrivons $643 000$ sous la forme $a × 10^n$.

On peut écrire :
$643 000 = 643 × 10^3$.

Donc :
$643 000 = 643 × 10^3$.
]

#exemple[
Écrivons $-8,52$ sous la forme $a × 10^n$.

On a :
$-8,52 = -852 × 10^(-2)$.

Donc :
$-8,52 = -852 × 10^(-2)$.
]

#retenir[
Pour écrire un nombre décimal sous la forme #strong[$a × 10^n$],
on peut déplacer la virgule.

• Si on déplace la virgule vers la #strong[droite], l'exposant de $10$
  est #strong[négatif].

• Si on déplace la virgule vers la #strong[gauche], l'exposant de $10$
  est #strong[positif].
]


// ==========================================================
// 8. PRODUIT DE DEUX NOMBRES ÉCRITS SOUS LA FORME a × 10^n
// ==========================================================

#sous_sous_titre[
Produit de deux nombres écrits sous la forme $a × 10^n$
]
#retenir[
Pour tous nombres décimaux $a$ et $b$ et tous entiers relatifs
$n$ et $m$ :

$(a × 10^n) × (b × 10^m)
= (a × b) × 10^(n+m)$.
]

#exemple_resolu[
Une installation solaire utilise deux grandeurs représentées par :

$x = 6,25 × 10^(-3)$
et
$y = 0,25 × 10^(-3)$.

Écrivons $6,25$ sous la forme d'un entier multiplié
par une puissance de $10$ :

$6,25 = 625 × 10^(-2)$.

Donc :
$x = 625 × 10^(-2) × 10^(-3)$.

Ainsi :
$x = 625 × 10^(-5)$.

De même :
$y = (0,25 × 10^(-3)) × (32 × 10^(-2))$.

On a :
$y = (0,25 × 32) × 10^(-3-2)$.

Donc :
$y = 8 × 10^(-5)$.
]


// ==========================================================
// 9. QUOTIENT DE NOMBRES ÉCRITS SOUS LA FORME a × 10^n
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Quotient de deux nombres écrits sous la forme $a × 10^n$
]

#retenir[
Pour $b ≠ 0$ :

#strong[$(a × 10^n) / (b × 10^m)
= (a / b) × 10^(n-m)$].
]

#exemple_resolu[
Calculons :
$A = (6 × 10^5) / (3 × 10^2)$.

On sépare les nombres et les puissances de $10$ :

$A = (6 / 3) × (10^5 / 10^2)$.

Donc :
$A = 2 × 10^(5-2)$.

Ainsi :
$A = 2 × 10^3$.

Donc :
$A = 2 000$.
]


// ==========================================================
// 10. ENCADREMENT PAR DEUX PUISSANCES DE 10
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Encadrer un nombre décimal par deux puissances de $10$
d'exposants consécutifs
]

#exemple_resolu[
On considère :
$y = 8 × 10^(-5)$.

On sait que :
$1 < 8 < 10$.

Multiplions les trois membres par $10^(-5)$ :

$1 × 10^(-5)< 8 × 10^(-5)< 10 × 10^(-5)$.

Donc :
$10^(-5) < 8 × 10^(-5) < 10^(-4)$.

Ainsi :
$10^(-5) < y < 10^(-4)$.
]
#v(3cm)
#exemple[
Encadrons $84,5 × 10^(-4)$.

On sait que :
$10 < 84,5 < 100$.

Donc :
$10 × 10^(-4)
< 84,5 × 10^(-4)
< 100 × 10^(-4)$.

Ainsi :
$10^(-3)
< 84,5 × 10^(-4)
< 10^(-2)$.
]

#retenir[
Pour encadrer un nombre écrit sous la forme $a × 10^n$,
on commence par encadrer $a$ entre deux puissances de $10$
d'exposants consécutifs, puis on multiplie l'encadrement
par $10^n$.
]


// ==========================================================
// 11. COMPARER DES NOMBRES ÉCRITS SOUS LA FORME a × 10^n
// ==========================================================

#sous_sous_titre[
Comparer deux nombres décimaux écrits sous la forme $a × 10^n$
]

#exemple_resolu[
On considère :
$x = 625 × 10^(-5)$
et
$y = 8 × 10^(-5)$.

Les deux nombres sont écrits avec la même puissance de $10$.
Or 
$625 > 8$,

donc 
$625 × 10^(-5) > 8 × 10^(-5)$.
Ainsi :
$x > y$.
]

#exemple[
Comparons :
$7,5 × 10^5$
et
$34 × 10^4$.

On transforme le premier nombre :

$7,5 × 10^5 = 75 × 10^4$.

On compare alors :
$75 × 10^4$
et
$34 × 10^4$.

Comme :
$75 > 34$,

on obtient :
$7,5 × 10^5 > 34 × 10^4$.
]

#retenir[
Pour comparer deux nombres décimaux écrits sous la forme
$a × 10^n$, on peut les écrire avec une même puissance de $10$,
puis comparer les coefficients.
]


// ==========================================================
// 12. ORDRE D'UN NOMBRE DÉCIMAL
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Déterminer l'ordre d'un nombre décimal
]

#definition[
Soit $n$ un entier naturel.

On appelle #strong[nombre décimal d'ordre $n$] un nombre décimal
qui peut être écrit sous la forme :
#strong[$p × 10^(-n)$]
où $p$ est un entier relatif.
]

#exemple_resolu[
On considère :
$x = 625 × 10^(-5)$.

Le nombre $625$ est un entier relatif.

Ainsi :
$x = 625 × 10^(-5)$.

Donc $x$ est un nombre décimal d'ordre $5$.
]

#v(0.2cm)

#exemple[
Considérons :
$a = 3,72 × 10^(-9)$.

On écrit :
$3,72 = 372 × 10^(-2)$.

Donc :
$a = 372 × 10^(-2) × 10^(-9)$.

Ainsi :
$a = 372 × 10^(-11)$.

Donc $a$ est un nombre décimal d'ordre $11$.
]

#exemple[
Considérons :
$b = 0,0026 × 10^(-2)$.

On a :
$0,0026 = 26 × 10^(-4)$.

Donc :
$b = 26 × 10^(-4) × 10^(-2)$.

Ainsi :
$b = 26 × 10^(-6)$.

Donc $b$ est un nombre décimal d'ordre $6$.
]

#remarque[
Un même nombre décimal peut parfois être écrit sous la forme
$p × 10^(-n)$ pour plusieurs valeurs de $n$.
Le même nombre peut donc être considéré comme un nombre
décimal d'ordre $8$ mais aussi d'ordre $10$.
]

#exemple[
$25 × 10^(-8)
= 2500 × 10^(-10)$.
]


// ==========================================================
// 13. TRONCATURE D'UN NOMBRE DÉCIMAL
// ==========================================================

#sous_sous_titre[
Tronquer un nombre décimal
]

#definition[
Soit $n$ un entier naturel non nul.

La #strong[troncature à $n$ décimales] d'un nombre décimal
est le nombre obtenu en ne conservant que les $n$ premiers
chiffres après la virgule, sans modifier le dernier chiffre conservé.
]

#exemple_resolu[
Une mesure calculée par un logiciel donne :

$z = 22,857142...$

La troncature à $2$ décimales consiste à conserver seulement
les deux premiers chiffres après la virgule :
$22,85$.

Ainsi, la troncature à $2$ décimales de $z$ est :
$22,85$.
]

#exemple[
Pour :
$z = 22,857142...$

on obtient :

• troncature à $1$ décimale : $22,8$ ;

• troncature à $2$ décimales : $22,85$ ;

• troncature à $3$ décimales : $22,857$ ;

• troncature à $4$ décimales : $22,8571$.
]

#remarque[
La troncature ne doit pas être confondue avec l'arrondi.

Lors d'une troncature, on conserve simplement les chiffres
demandés sans modifier le dernier chiffre conservé.
]


// ==========================================================
// PARTIE C — RÉINVESTISSEMENT DANS L'ÉNERGIE SOLAIRE
// ==========================================================

#sous_titre[
RÉINVESTISSEMENT — DIMENSIONNER UNE INSTALLATION SOLAIRE
]


#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
☀️ Mission — Étudier les mesures d'une installation solaire
]

#v(0.2cm)

Une équipe technique prépare l'installation de panneaux
photovoltaïques sur le toit d'un centre communautaire.

Les techniciens disposent de plusieurs mesures exprimées sous
la forme de nombres décimaux et de puissances de $10$.

L'objectif est de transformer, comparer et encadrer ces mesures
afin de déterminer si elles conviennent au projet.


// ----------------------------------------------------------
// QUESTION 1
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
1. Écrire les puissances de $10$ sous forme décimale
]

Le technicien considère les mesures suivantes :

$10^(-2)$ ; $10^(-3)$ ; $10^4$.

Écris chacune d'elles sous forme décimale.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On a :

$10^(-2)=0,01$

$10^(-3)=0,001$

$10^4=10 000$.


// ----------------------------------------------------------
// QUESTION 2
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
2. Écrire une mesure sous la forme $a × 10^n$
]

La longueur d'un élément du système solaire est :

$6,25m$.

Écris cette longueur sous la forme :
$a × 10^n$.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On a :
$6,25 = 625 × 10^(-2)$.

Donc :
$6,2,m = 625 × 10^(-2)m$.


// ----------------------------------------------------------
// QUESTION 3
// ----------------------------------------------------------

#v(2cm)

#text(
  weight: "bold",
)[
3. Étudier une petite mesure
]

Un composant du système est caractérisé par la valeur :
$y = 8 × 10^(-5)$.

Encadre $y$ par deux puissances de $10$
d'exposants consécutifs.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On sait que :
$1 < 8 < 10$.

Donc :
$10^(-5)
< 8 × 10^(-5)
< 10^(-4)$.

Ainsi :
#strong[
$10^(-5) < y < 10^(-4)$.
]


// ----------------------------------------------------------
// QUESTION 4
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
4. Comparer deux mesures
]

Deux composants possèdent les valeurs :

$x = 625 × 10^(-5)$
et
$y = 8 × 10^(-5)$.

Compare $x$ et $y$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Les deux nombres ont la même puissance de $10$ :
$10^(-5)$.

Or :
$625 > 8$.

Donc :
$625 × 10^(-5)
> 8 × 10^(-5)$.

Ainsi :
#strong[
$x > y$.
]


// ----------------------------------------------------------
// QUESTION 5
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
5. Calculer un produit de mesures
]

Deux grandeurs utilisées dans le système sont :

$x = 6,25 × 10^(-3)$

et

$y = (0,25 × 10^(-3)) × (32 × 10^(-2))$.

Écris $x$ et $y$ sous la forme $a × 10^n$.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Pour $x$ :

$6,25 = 625 × 10^(-2)$.

Donc :
$x = 625 × 10^(-2) × 10^(-3)$.

Ainsi :
$x = 625 × 10^(-5)$.

Pour $y$ :

$y = (0,25 × 10^(-3)) × (32 × 10^(-2))$.

Donc :
$y = (0,25 × 32) × 10^(-3-2)$.

Or :
$0,25 × 32 = 8$.

Ainsi :
#strong[
$y = 8 × 10^(-5)$.
]


// ----------------------------------------------------------
// QUESTION 6
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
6. Déterminer l'ordre d'une mesure
]

On considère :
$x = 625 × 10^(-5)$.

Détermine l'ordre de $x$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On a directement :
$x = 625 × 10^(-5)$.

Comme $625$ est un entier relatif, $x$ est un nombre
décimal d'ordre $5$.

Donc :
#strong[
$x$ est un nombre décimal d'ordre $5$.
]


// ----------------------------------------------------------
// QUESTION 7
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
7. Déterminer une troncature
]

Une mesure calculée par le logiciel est :

$z = 22,857142...$

Donne sa troncature à $3$ décimales.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On conserve les trois premiers chiffres après la virgule :
$22,857$.

Donc la troncature à $3$ décimales est :
#strong[
$22,857$.
]


// ----------------------------------------------------------
// QUESTION 8
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
8. Utiliser plusieurs règles de calcul
]

Un système de mesure fournit :

$A = (3 × 10^(-4)) × (5 × 10^2)$.

Écris $A$ sous la forme $a × 10^n$ puis calcule sa valeur.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On utilise le produit de puissances de même base :

$A = (3 × 5) × 10^(-4+2)$. 

Donc :
$A = 15 × 10^(-2)$.

Or :
$10^(-2)=0,01$.
Ainsi :
$A = 15 × 0,01$.

Donc :
#strong[
$A = 0,15$.
]


// ----------------------------------------------------------
// QUESTION 9
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
9. Puissance d'une puissance
]

Une caractéristique technique est représentée par :

$B = (10^(-3))^4$.

Écris $B$ sous la forme d'une puissance de $10$.


#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On utilise :
$(10^n)^m = 10^(n×m)$.

Donc :
$B = (10^(-3))^4$.

Ainsi :
$B = 10^((-3)×4)$.

Donc :
#strong[
$B = 10^(-12)$.
]


// ----------------------------------------------------------
// QUESTION 10
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
10. Mission finale
]

On donne :

$x = 1,25 × 10^(-5)$

$y = 7500 × 10^(-9)$

$a = 0,185 × 10^(-4)$

$b = 4255000 × 10^(-11)$.

1. Écris chacun des nombres sous la forme
   $p × 10^q$, où $p$ et $q$ sont des entiers relatifs.

2. Compare $x$, $y$, $a$ et $b$.

3. Donne un encadrement de $a$ par deux puissances de $10$
   d'exposants consécutifs.

4. Justifie que $x$ est un nombre décimal d'ordre $9$.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

1. On transforme d'abord les nombres.

#strong[Pour $x$] :

$x = 1,25 × 10^(-5)$.

Comme :
$1,25 = 125 × 10^(-2)$,

on obtient :
$x = 125 × 10^(-7)$.

#strong[Pour $y$] :
$y = 7500 × 10^(-9)$.

Donc :
$y = 75 × 10^(-7)$.

#strong[Pour $a$] :

$a = 0,185 × 10^(-4)$.

Comme :
$0,185 = 185 × 10^(-3)$,

on obtient :
$a = 185 × 10^(-7)$.

#strong[Pour $b$] :

$b = 4255000 × 10^(-11)$.

Donc :
$b = 4255 × 10^(-8)$.

2. On peut alors écrire :

$y = 750 × 10^(-8)$

$x = 1250 × 10^(-8)$

$a = 1850 × 10^(-8)$

$b = 4255 × 10^(-8)$.

Or :
$750 < 1250 < 1850 < 4255$.

Donc :
#strong[
$y < x < a < b$.
]
#v(3cm)
3. Pour encadrer $a$ :

$a = 185 × 10^(-7)$.

On sait que :
$100 < 185 < 1000$.

Donc :
$100 × 10^(-7)
< a
< 1000 × 10^(-7)$.

Ainsi :
$10^(-5) < a < 10^(-4)$.

Enfin :
$x = 125 × 10^(-7)$.

4. On peut écrire :

$x = 12500 × 10^(-9)$.

Comme $12500$ est un entier relatif :

#strong[
$x$ est un nombre décimal d'ordre $9$.
]
]

#remarque[
Dans une installation solaire, les nombres décimaux permettent
d'exprimer précisément les mesures.

Les puissances de $10$ permettent quant à elles de simplifier
l'écriture et les calculs lorsque les nombres deviennent très
grands ou très petits.

La maîtrise de ces outils est donc utile aussi bien pour les
mathématiques que pour les sciences et les technologies.
]


// ==========================================================
// À RETENIR
// ==========================================================

#v(0.5cm)

#sous_titre[
À RETENIR — LES NOMBRES DÉCIMAUX ET LES PUISSANCES DE $10$
]

#retenir[

Pour tout entier naturel $n$ :

#strong[$10^n = 10 × 10 × ... × 10$]
et  #strong[$10^(-n) = 1 / 10^n$].

Pour tous entiers relatifs $n$ et $m$ :

#strong[$10^n × 10^m = 10^(n+m)$]

#strong[$10^n / 10^m = 10^(n-m)$]

#strong[$(10^n)^m = 10^(n×m)$].

Pour tous nombres décimaux $a$ et $b$ :

$(a × 10^n) × (b × 10^m)
= (a × b) × 10^(n+m)$.

#v(2cm)

Pour $b ≠ 0$ :

#strong[$(a × 10^n) / (b × 10^m)
= (a / b) × 10^(n-m)$].

Un nombre décimal peut être écrit sous la forme :

#strong[$a × 10^n$]

avec $a$ et $n$ entiers relatifs.

Un nombre décimal d'ordre $n$ peut être écrit sous la forme :

#strong[$p × 10^(-n)$]

où $p$ est un entier relatif.

La troncature à $n$ décimales consiste à conserver uniquement
les $n$ premiers chiffres après la virgule.
]

#remarque[
Les puissances de $10$ constituent un outil essentiel pour
passer d'une écriture décimale à une écriture adaptée aux calculs.

Elles seront également utiles pour étudier les écritures
scientifiques, les grandeurs physiques et les nombres très grands
ou très petits rencontrés dans les sciences et les technologies.
]

]
]
