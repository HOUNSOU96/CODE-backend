// ==========================================================
// CODE-MATHS
// DOMAINE A — NOMBRES ET CALCULS
// NOTION 1 — LES ENTIERS NATURELS
// Parcours collège : 6e → 5e → 4e → 3e
// ==========================================================


#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let entiers_naturels() = [

#debut_notion()
// ==========================================================
// TITRE DE LA NOTION
// ==========================================================
#pagebreak()



#title(
  [I — LES ENTIERS NATURELS],
  "notion-entiers-naturels",
) <notion-entiers-naturels>

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
🌍 D'où vient le besoin de compter ?
]
#v(0.55cm)
Bien avant l'apparition des nombres tels que nous les
écrivons aujourd'hui, l'être humain devait déjà répondre
à une question essentielle :
#align(center)[
#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
« Combien y en a-t-il ? »
]
]
Il fallait compter les animaux d'un troupeau, les récoltes,
les objets possédés, les habitants d'un village ou les
marchandises échangées.
Pour garder la trace de ces quantités, les premières
civilisations ont utilisé des marques, des cailloux,
des bâtonnets et différentes formes de représentation.
Peu à peu, l'être humain a compris qu'il était possible
de représenter les quantités par des nombres, puis de
construire des symboles pour écrire ces nombres.
Dans le système de numération décimale (base 10), ces symboles
sont les dix chiffres $0$ à $9$.


#v(0.25cm)

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🔟 Qu'est-ce que le système de numération décimale ?
]

#v(0.1cm)

Le #strong[système de numération décimale] est un système qui
permet d'écrire et de représenter les nombres en utilisant
#strong[dix chiffres] :

#align(center)[
  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    $0, 1, 2, 3, 4, 5, 6, 7, 8, 9$
  ]
]

On l'appelle #strong[décimal] parce qu'il est fondé sur le
nombre #strong[10].

Dans ce système, la valeur d'un chiffre dépend non seulement
du chiffre lui-même, mais aussi de sa #strong[position] dans
le nombre.

Par exemple, dans le nombre $5 284$ :

#align(center)[
  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    $5 284 = 5 × 1000 + 2 × 100 + 8 × 10 + 4$
  ]
]

Le chiffre $5$ représente donc #strong[5 milliers], le chiffre
$2$ représente #strong[2 centaines], le chiffre $8$ représente
#strong[8 dizaines] et le chiffre $4$ représente
#strong[4 unités].

On peut également écrire :

#align(center)[
  $5 284 = 5 × 10^3 + 2 × 10^2 + 8 × 10^1 + 4 × 10^0$
]

Ainsi, dans le système décimal, chaque position correspond à
une puissance de $10$.

#align(center)[
  #table(
    columns: (2.5cm, 2.5cm, 2.5cm, 2.5cm),
    stroke: 0.5pt + rgb("#D5E2EF"),
    inset: 0.12cm,

    [#strong[Milliers]],
    [#strong[Centaines]],
    [#strong[Dizaines]],
    [#strong[Unités]],

    [$10^3 = 1000$],
    [$10^2 = 100$],
    [$10^1 = 10$],
    [$10^0 = 1$],
  )
]

#exemple[

Dans le nombre $3 742$, le chiffre $7$ est placé au rang
des centaines. Il représente donc $7 × 100 = 700$.

Le chiffre $4$ est placé au rang des dizaines. Il représente
donc $4 × 10 = 40$.

]

#text(
  size: 10pt,
  style: "italic",
  fill: rgb("#60758A"),
)[
À retenir : dans le système décimal, nous utilisons dix chiffres,
et la position de chaque chiffre détermine sa valeur.
]
]

#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🔢 Nombre et chiffre : quelle différence ?
]
#v(0.1cm)
Il ne faut pas confondre un #strong[nombre] et un
#strong[chiffre].
Un #strong[chiffre] est un symbole utilisé pour écrire
les nombres. Dans notre système de numération décimale,
il existe seulement #strong[dix chiffres] :

#align(center)[
  #text(
    size: 13pt,
    weight: "bold",
    fill: code-blue,
  )[
    $0, 1, 2, 3, 4, 5, 6, 7, 8, 9$
  ]
]
Un #strong[nombre], quant à lui, représente une quantité
ou une valeur. Il peut être écrit avec un ou plusieurs
chiffres.


#exemple[
Le nombre $7$ est écrit avec un seul chiffre : $7$.
Le nombre $25$ est écrit avec deux chiffres : $2$ et $5$.
Le nombre $5203504$ est écrit avec sept chiffres :
$5$, $2$, $0$, $3$, $5$, $0$ et $4$.
]
Ainsi, dans le nombre $25$, les symboles $2$ et $5$ sont
des #strong[chiffres], tandis que $25$ est un #strong[nombre].
Peu à peu, les systèmes de numération se sont perfectionnés
afin de permettre d'écrire et de comparer des quantités
de plus en plus grandes.
Les nombres entiers naturels constituent ainsi l'un des
fondements des mathématiques et interviennent dans de
nombreuses situations de la vie quotidienne : compter,
mesurer, classer, organiser ou dénombrer.
#v(0.05cm)
// ==========================================================
// OBJECTIFS DE LA NOTION
// ==========================================================
#objectif[

À travers cette notion, l'apprenant doit être capable de :

• reconnaître un entier naturel ;
• utiliser l'ensemble $ℕ$ ;
• distinguer les nombres appartenant ou non à $ℕ$ ;
• lire et écrire les nombres entiers ;
• comparer et ranger les entiers naturels ;
• utiliser les propriétés des entiers naturels
dans des situations concrètes.

]
]

#v(0.2cm)

#align(center)[

#image_full("entiers-naturels-origine.png")

]

#pagebreak()





// ==========================================================
// PARCOURS 6e
// ==========================================================

#parcours(
  [PARCOURS 6ᵉ — Découvrir les entiers naturels avec la médecine],
  "parcours-entiers-naturels-6e",
) <parcours-entiers-naturels-6e>


// ----------------------------------------------------------
// ACTIVITÉ DE DÉCOUVERTE
// ----------------------------------------------------------
#activite[

🩺 #strong[La médecine : connaître le corps humain pour mieux le soigner]

#v(0.05cm)

La #strong[médecine] est un domaine qui s'intéresse à la santé de
l'être humain. Elle cherche notamment à prévenir les maladies,
à identifier leurs causes, à établir des diagnostics, à proposer
des traitements et à accompagner les personnes dans leur parcours
de soins.
Dans différentes sociétés et à différentes époques, les êtres
humains ont développé des connaissances et des pratiques pour
préserver la santé et soigner les maladies.
On distingue notamment plusieurs grandes approches de la médecine.

#v(0.05cm)

• La #strong[médecine moderne ou conventionnelle] s'appuie notamment
sur les connaissances scientifiques, l'observation clinique,
les examens médicaux, l'imagerie, les analyses biologiques et
les traitements dont l'efficacité et la sécurité sont étudiées.

• Les #strong[médecines traditionnelles] regroupent des connaissances
et des pratiques transmises au sein de différentes cultures.
On peut citer, par exemple, certaines pratiques de la
#strong[médecine traditionnelle africaine] ainsi que la
#strong[médecine traditionnelle chinoise].

Ces différentes traditions possèdent leurs propres conceptions
du corps, de la santé et de la maladie.
Pour comprendre le fonctionnement du corps humain, les professionnels
de santé ont besoin de connaître son organisation.
C'est notamment le rôle de l'#strong[anatomie].

#v(0.05cm)

#strong[Qu'est-ce que l'anatomie ?]

L'#strong[anatomie] est la science qui étudie la
#strong[structure et l'organisation du corps humain].

Elle permet notamment de connaître :
• les différentes parties du corps ;
• les organes et les tissus ;
• la forme et la position des organes ;
• les relations entre les différentes parties du corps ;
• l'organisation des systèmes qui composent l'organisme.

#v(0.05cm)

L'anatomie joue donc un rôle essentiel dans la médecine.
Un professionnel de santé doit connaître l'organisation du corps
pour pouvoir comprendre où se situe une structure, identifier
certaines anomalies et mieux interpréter les résultats des examens
médicaux.
Par exemple, pour étudier une fracture, un médecin doit connaître
l'organisation des #strong[os] et leur position dans le corps.
L'étude des os constitue une partie importante de l'anatomie,
appelée #strong[ostéologie].
]
#v(0.05cm)
#activite[
🦴 #strong[Découvrons maintenant le squelette humain]

Le #strong[squelette humain adulte] est l'ensemble des os qui
constituent la charpente du corps.
Chez l'être humain adulte, on compte généralement
#strong[206 os].

Le squelette joue plusieurs rôles importants :
• il donne une #strong[structure] et une forme au corps ;
• il participe au #strong[soutien] du corps ;
• il protège certains organes internes ;
• il intervient avec les muscles dans les #strong[mouvements] ;
• certains os participent à la production des cellules sanguines
  dans la moelle osseuse ;
• les os constituent également une réserve de certains minéraux,
  notamment le calcium et le phosphore.

#v(0.05cm)

Pour mieux étudier l'organisation du squelette, les anatomistes
regroupent les os selon les différentes régions du corps.

Par exemple :
• le #strong[crâne] comprend $22$ os ;
• la cage thoracique comprend notamment
  #strong[24 côtes], soit $12$ paires de côtes ;
• chaque #strong[poignet] possède $8$ os ;
• chaque #strong[cheville] possède $7$ os.

Ces nombres permettent déjà de décrire et de comparer certaines
parties du squelette.

#v(0.05cm)
On peut par exemple déterminer le nombre d'os des deux poignets :
$#strong[2 × 8 = 16]$.
De même, le nombre d'os des deux chevilles est :
$#strong[2 × 7 = 14]$.
On peut alors comparer certaines quantités :
$#strong[22 > 16 > 14]$.
Le nombre d'os du crâne est donc supérieur au nombre total d'os
des deux poignets, lui-même supérieur au nombre total d'os des
deux chevilles.

#v(0.05cm)
On peut également regrouper ces quantités :
$#strong[22 + 16 + 14 = 52]$.
Ainsi, l'étude du squelette permet de #strong[compter],
#strong[calculer], #strong[comparer] et #strong[regrouper] des
quantités.
Les nombres obtenus sont :
#strong[$206$ ; $22$ ; $24$ ; $8$ ; $7$ ; $16$ ; $14$ ; $52$.]
Tous ces nombres sont des nombres entiers positifs ou nuls utilisés
pour compter des quantités.
#v(0.05cm)

On rencontre la même situation lorsqu'on compte :
• le nombre de personnes dans une population ;
• le nombre de patients dans un établissement de santé ;
• le nombre de médicaments dans une pharmacie ;
• le nombre d'objets dans une collection ;
• le nombre d'animaux dans un groupe ;
• le nombre d'éléments dans un ensemble.
#v(0.05cm)
Mais alors, #strong[comment appelle-t-on l'ensemble des nombres
utilisés pour compter ?]

Les mathématiciens ont regroupé ces nombres dans un même ensemble
appelé #strong[l'ensemble des nombres naturels], noté :
#strong[$ℕ$].
#v(0.05cm)
Cette découverte nous conduit maintenant à étudier les
#strong[nombres naturels] et leur utilisation pour compter,
comparer et organiser les quantités.
]

#v(0.3cm)

#align(center)[

#image_full("entiers-naturels-6e.png")

]

#pagebreak()


// ==========================================================
// DEFINITION 1
// ==========================================================

#deux-colonnes[

#sous_titre[
  Connaître l'ensemble $ℕ$
]

#v(0.12cm)

#definition[
L'ensemble des entiers naturels est l'ensemble des nombres
utilisés pour compter. On le note : $ℕ$.

Les premiers éléments de cet ensemble sont :
$0 ; 1 ; 2 ; 3 ; 4 ; 5 ; 6 ; ...$
]

#v(0.25cm)


// ==========================================================
// A RETENIR
// ==========================================================

#retenir[
• Tout entier naturel est un nombre entier positif ou nul.

• Le plus petit entier naturel est : $0$.

• L'ensemble $ℕ$ possède une infinité d'éléments.

• L'ensemble $ℕ$ n'a pas de plus grand élément.
]

#v(0.25cm)


// ==========================================================
// REMARQUES
// ==========================================================

#remarque[
Un nombre décimal dont les chiffres après la virgule sont
uniquement des 0 est un entier naturel.
]

#v(0.2cm)

#exemple[
Dans un dossier médical, la masse d'un patient peut être
indiquée sous la forme $70,00k g$.

Comme les chiffres après la virgule sont uniquement des 0,
on peut écrire simplement $70k g$ et $70 ∈ ℕ$.

En revanche, une température de $36,5°C$ ne correspond
pas à un entier naturel car $36,5 ∉ ℕ$.

Dans le premier cas, le nombre permet de compter une quantité
entière de kilogrammes ; dans le second, la température peut
prendre une valeur située entre deux entiers.
]

#v(1.5cm)


// ==========================================================
// APPARTENANCE A L'ENSEMBLE ℕ
// ==========================================================

#sous_titre[
Appartenance à l'ensemble $ℕ$
]

#v(0.12cm)

#definition[
Le symbole $∈$ signifie « appartient à ».

Le symbole $∉$ signifie « n'appartient pas à ».
]

#v(0.2cm)

#exemple[
Dans un service hospitalier, on compte $7$ patients dans
une salle.

Le nombre $7$ est un entier naturel, donc :

$7 ∈ ℕ$.

En revanche, un thermomètre qui indique une température de
#strong[$37,2°C$] présente un nombre non entier naturel :

$37,2 ∉ ℕ$.

On peut donc distinguer les nombres utilisés pour compter
des quantités entières de ceux qui permettent de mesurer
des grandeurs pouvant prendre des valeurs intermédiaires.
]

#v(0.35cm)


// ==========================================================
// ECRITURE DES ENTIERS NATURELS
// ==========================================================

#sous_titre[
Lire et écrire les entiers naturels
]

#v(0.12cm)

#definition[
Un entier naturel peut être écrit :

• avec des chiffres ;

• avec des lettres.
]

#v(0.2cm)

#exemple[
Dans un centre de santé, une campagne de vaccination a
permis de vacciner $5203504$ personnes au total.

Le nombre $5203504$ s'écrit en lettres :

« Cinq millions deux cent trois mille cinq cent quatre. »
]

#v(0.25cm)


// ==========================================================
// EXEMPLES
// ==========================================================

#exemple[
Dans un établissement de santé :

• $301$ se lit « Trois cent un. »

• $200700$ se lit « Deux cent mille sept cents. »

• $480$ se lit « Quatre cent quatre-vingts. »

Ces écritures permettent de transmettre sans ambiguïté
le nombre de patients, de doses ou de matériels comptés.
]

#v(0.25cm)


// ==========================================================
// REGLES D'ECRITURE
// ==========================================================


#remarque[
Dans l'écriture des nombres en lettres :

• « mille » est toujours invariable ;

• « cent » et « vingt » prennent un « s » seulement lorsqu'ils
  ne sont pas suivis d'un autre nombre ;

• les mots qui composent un nombre peuvent être reliés par
  des traits d'union ;

• dans certains nombres, le mot « et » est utilisé entre
  les dizaines et les unités.
]


#v(0.2cm)


#exemple[
Un laboratoire reçoit des lots contenant :

• $3000$ comprimés → trois mille comprimés ;

• $300$ comprimés → trois cents comprimés ;

• $301$ comprimés → trois cent un comprimés ;

• $480$ comprimés → quatre cent quatre-vingts comprimés ;

• $481$ comprimés → quatre cent quatre-vingt-un comprimés.

On constate que « mille » reste toujours invariable,
tandis que « cent » et « vingt » prennent un « s » lorsqu'ils
terminent le nombre.

Ainsi :

• trois cents, mais trois cent un ;

• quatre-vingts, mais quatre-vingt-un.
]


#v(2cm)


#sous_sous_titre[
Le trait d'union
]


#v(0.12cm)


#definition[
Le #strong[trait d'union] sert à relier certains mots qui
forment ensemble l'écriture d'un nombre.

Il est notamment utilisé entre les dizaines et les unités
lorsqu'il n'y a pas le mot « et ».

Par exemple :

• $21$ → vingt-et-un ;

• $35$ → trente-cinq ;

• $48$ → quarante-huit ;

• $71$ → soixante-et-onze ;

• $92$ → quatre-vingt-douze.
]


#v(0.2cm)


#remarque[
Le mot « et » est utilisé dans certaines écritures entre
la dizaine et l'unité.

On écrit notamment :

• vingt-et-un ;

• trente-et-un ;

• quarante-et-un ;

• cinquante-et-un ;

• soixante-et-un ;

• soixante-et-onze.

Dans ces cas, « et » ne remplace donc pas simplement un
trait d'union : il fait partie de la construction du nombre.
]


#v(0.2cm)


#exemple[

• $21$ → vingt-et-un ;

• $31$ → trente-et-un ;

• $41$ → quarante-et-un ;

• $51$ → cinquante-et-un ;

• $61$ → soixante-et-un ;

• $71$ → soixante-et-onze.

En revanche :

• $22$ → vingt-deux ;

• $32$ → trente-deux ;

• $42$ → quarante-deux ;

• $52$ → cinquante-deux ;

• $62$ → soixante-deux ;

• $72$ → soixante-douze.
]


#v(0.2cm)


#retenir[
Pour bien écrire un entier naturel en lettres, je dois :

• savoir quand utiliser le trait d'union ;

• savoir quand employer « et » ;

• ne pas mettre « et » dans toutes les écritures se terminant
  par $1$ ;

• écrire « mille » sans « s » ;

• accorder « cent » et « vingt » lorsqu'ils terminent le nombre.
]
#v(15cm)


// ==========================================================
// COMPARER LES ENTIERS NATURELS
// ==========================================================

#sous_titre[
Comparer les entiers naturels
]

#v(0.12cm)

#definition[
Comparer deux nombres consiste à déterminer lequel est :

• plus petit , plus grand ou égal à l'autre .

On utilise les symboles :

• #strong[a < b] : #strong[a] est #strong[inférieur] à #strong[b] ou #strong[b] est #strong[supérieur] à #strong[a].

• #strong[a > b] : #strong[a] est #strong[supérieur] à #strong[b] ou #strong[b] est #strong[inférieur] à #strong[a].

• #strong[a = b] : #strong[a] est #strong[égal] à #strong[b].

• #strong[a ≤ b] : #strong[a] est #strong[inférieur ou égal] à #strong[b] ou #strong[b] est
#strong[supérieur ou égal] à #strong[a].

• #strong[a ≥ b] : #strong[a] est #strong[supérieur ou égal] à #strong[b] ou #strong[b] est
#strong[inférieur ou égal] à #strong[a].

#v(0.12cm)

#strong[
Dans cette première notion, nous utiliserons pour l'instant
uniquement les symboles $<$, $>$ et $=$ pour comparer les nombres.
]
]

#v(0.25cm)

#exemple[
Dans trois services d'un centre hospitalier, on compte
respectivement $25$, $40$ et $32$ patients.

On peut comparer les effectifs :

$25 < 32 < 40$.

Le service qui compte $25$ patients a donc moins de patients
que celui qui en compte $32$, tandis que celui qui en compte
$40$ en a davantage.

On peut également comparer les effectifs de deux jours
dans un même service.

Lundi : $125$ patients - Mardi : $98$ patients.

Comme $125 > 98$, le nombre de patients reçus lundi est
supérieur à celui reçu mardi.

Enfin, si deux services accueillent chacun $300$ patients
sur une période donnée, on écrit :

$300 = 300$.

]

// ==========================================================
// RANGER LES ENTIERS NATURELS
// ==========================================================

#sous_titre[
Ranger les entiers naturels
]

#v(0.12cm)

#retenir[
Ranger des nombres consiste à les placer dans un ordre précis.
Deux possibilités existent :

• ordre croissant : du plus petit au plus grand ;

• ordre décroissant : du plus grand au plus petit.
]

#v(0.1cm)

#exemple_resolu[
Dans un centre de santé, quatre services ont accueilli
respectivement $45$, $12$, $78$ et $30$ patients au cours
d'une journée.

Rangeons ces effectifs :

• Ordre croissant : $12 < 30 < 45 < 78$

• Ordre décroissant : $78 > 45 > 30 > 12$

On peut donc identifier rapidement le service ayant accueilli
le moins de patients et celui ayant accueilli le plus de patients.
]

#v(0.35cm)

#sous_titre[
Les opérations dans $ℕ$
]

#v(0.12cm)

#definition[
Une opération est un calcul permettant d'obtenir un résultat
à partir d'un ou de plusieurs nombres.

Dans $ℕ$, on utilise notamment :

• l'addition $+$ ;

• la soustraction $-$ ;

• la multiplication $×$ ;

• la division $÷$.

Chaque opération possède un vocabulaire particulier.
]

#v(1cm)

#exemple[
Dans un centre de santé, les opérations permettent de traiter
différentes situations.

• $12 + 3 = 15$

  → l'opération effectuée est une #strong[addition] ;

  → $12$ et $3$ sont les #strong[termes] de l'addition ;

  → $15$ est la #strong[somme].

  Cette opération peut représenter, par exemple, l'arrivée
  de $12$ patients le matin puis de $3$ patients l'après-midi.
  Le centre a alors accueilli $15$ patients.

#v(0.12cm)

• $12 - 3 = 9$

  → l'opération effectuée est une #strong[soustraction] ;

  → $12$ est le #strong[terme initial] et $3$ le
  #strong[terme retranché] ;

  → $9$ est la #strong[différence].

  Si $12$ lits sont occupés et que $3$ patients quittent
  le service, il reste $9$ patients hospitalisés.

#v(0.12cm)

• $25 × 8 = 200$

  → l'opération effectuée est une #strong[multiplication] ;

  → $25$ et $8$ sont les #strong[facteurs] ;

  → $200$ est le #strong[produit].

  Si une boîte contient $25$ gants et qu'un service reçoit
  $8$ boîtes identiques, le nombre total de gants est :

  $25 × 8 = 200$.

#v(0.12cm)

• $24 ÷ 6 = 4$

  → l'opération effectuée est une #strong[division] ;

  → $24$ est le #strong[dividende] ;

  → $6$ est le #strong[diviseur] ;

  → $4$ est le #strong[quotient].

  Si $24$ patients doivent être répartis équitablement
  entre $6$ salles, chaque salle reçoit :

  $24 ÷ 6 = 4$ patients.
]

#v(1cm)

#definition[
Lorsqu'une expression contient plusieurs opérations, il faut
respecter un ordre précis pour effectuer les calculs. Cet ordre
est appelé #strong[priorité des opérations].
]

#v(0.5cm)

#regle[
#strong[Ordre des priorités]

Pour calculer une expression contenant plusieurs opérations :

1. on effectue d'abord les calculs entre parenthèses ;

2. puis les multiplications et les divisions ;

3. enfin les additions et les soustractions.

Lorsque plusieurs opérations de même priorité se suivent,
on les effectue #strong[de gauche à droite].
]

#v(0.2cm)

#exemple[
Dans un service de soins, on peut utiliser une expression
pour déterminer le nombre total de patients pris en charge
au cours d'une journée.

• $3 + 5 × 2$

  La multiplication est prioritaire sur l'addition.

  $3 + 5 × 2 = 3 + 10$

  $3 + 5 × 2 = 13$

  Donc #strong[$3 + 5 × 2 = 13$].

  Cela peut représenter $3$ patients déjà pris en charge,
  puis $5$ groupes de $2$ patients supplémentaires.

#v(0.12cm)

• $20 - 12 ÷ 3$

  La division est prioritaire sur la soustraction.

  $20 - 12 ÷ 3 = 20 - 4$

  $20 - 12 ÷ 3 = 16$

  Donc #strong[$20 - 12 ÷ 3 = 16$].

  Par exemple, si un stock contient $20$ unités et que
  $12$ unités sont réparties en $3$ lots égaux, on retire
  d'abord la quantité correspondant à un lot.

#v(0.12cm)

• $24 ÷ 6 × 2$

  La division et la multiplication ont la même priorité.
  On effectue donc les calculs de gauche à droite.

  $24 ÷ 6 × 2 = 4 × 2$

  $24 ÷ 6 × 2 = 8$

  Donc #strong[$24 ÷ 6 × 2 = 8$].

  Cette expression peut représenter une quantité de
  $24$ unités répartie en $6$ groupes, puis une quantité
  deux fois plus grande.

#v(0.12cm)

• $(3 + 5) × 2$

  Les calculs entre parenthèses sont prioritaires.

  $(3 + 5) × 2 = 8 × 2$

  $(3 + 5) × 2 = 16$

  Donc #strong[$(3 + 5) × 2 = 16$].

  Mais :

  $3 + 5 × 2 = 3 + 10$

  $3 + 5 × 2 = 13$

  Les parenthèses peuvent donc #strong[modifier le résultat]
  d'une expression.

  En médecine, elles permettent notamment de regrouper
  clairement des quantités avant d'effectuer une multiplication.
]

#v(0.2cm)

#retenir[
Pour calculer une expression contenant plusieurs opérations :

• on effectue d'abord les calculs entre parenthèses ;

• puis les multiplications et les divisions ;

• enfin les additions et les soustractions ;

• à priorité égale, on calcule de gauche à droite.
]

#v(0.12cm)

#exemple[
Dans une pharmacie hospitalière, trois services reçoivent
chacun une certaine quantité de matériel.

On considère :

$A = 18 - 2 × (3 + 4)$

On calcule d'abord ce qui est entre parenthèses :

$A = 18 - 2 × 7$

Puis la multiplication :

$A = 18 - 14$

Enfin la soustraction :

$A = 4$.

Donc #strong[$A = 4$].

]


#v(0.1cm)

// ==========================================================
// PRÉDÉCESSEUR, SUCCESSEUR ET ENTIERS CONSÉCUTIFS
// ==========================================================

#sous_titre[
Prédécesseur, successeur et entiers naturels consécutifs
]

#v(0.05cm)

#definition[
Le #strong[prédécesseur] d'un entier naturel est l'entier naturel
qui vient immédiatement avant lui.

Le #strong[successeur] d'un entier naturel est l'entier naturel
qui vient immédiatement après lui.
]

#v(0.05cm)

#exemple[
Dans le suivi quotidien des patients d'un service :

• si $30$ patients sont enregistrés aujourd'hui, son prédécesseur
  est $29$ et son successeur est $31$ ;

• le prédécesseur de $56$ est $55$ ;

• le successeur de $56$ est $57$.

Ainsi, lorsqu'un effectif augmente ou diminue d'une unité,
on peut utiliser directement le successeur ou le prédécesseur.
]

#v(0.05cm)

#retenir[
Pour obtenir le #strong[prédécesseur] d'un entier naturel,
on lui soustrait $1$.

Pour obtenir le #strong[successeur] d'un entier naturel,
on lui ajoute $1$.

Ainsi : #strong[$30 - 1 = 29$]   et   #strong[$30 + 1 = 31$].
]

#v(0.25cm)

#definition[
Des entiers naturels sont dits #strong[consécutifs] lorsqu'ils
se suivent immédiatement dans la suite des entiers naturels.
]

#v(0.2cm)

#exemple[
Dans le registre des patients d'un service, les numéros
d'enregistrement peuvent se suivre ainsi :

$23 ; 24 ; 25$.

Ces trois nombres sont des entiers naturels consécutifs.

De même :

$41 ; 42 ; 43 ; 44$

sont quatre entiers naturels consécutifs.
]

#v(0.2cm)

#exemple_resolu[
Un service hospitalier a enregistré un patient portant le
numéro $25$.

Les trois numéros d'enregistrement consécutifs qui entourent
le numéro $25$ sont :

$24 ; 25 ; 26$.

En effet :

$24 + 1 = 25$

et

$25 + 1 = 26$.

On peut également former d'autres groupes de trois entiers
consécutifs contenant $25$ :

$23 ; 24 ; 25$

ou

$25 ; 26 ; 27$.

Le choix dépend de la position occupée par $25$ dans le groupe.
]

#v(2.5cm)

#remarque[
Dans une suite d'entiers naturels consécutifs, chaque nombre
est le #strong[successeur] du précédent et le #strong[prédécesseur]
du suivant.

Par exemple, dans : $24 ; 25 ; 26$

$25$ est le successeur de $24$ et le prédécesseur de $26$.
]

#v(0.45cm)


// ==========================================================
// APPLICATION
// ==========================================================

#exemple_resolu[
Déterminons si $729$ et $864$ sont des multiples de $36$.

• Pour $729$ :

$729 ÷ 36 = 20,25$

Le quotient n'est pas un entier naturel. Donc $729$ n'est pas
un #strong[multiple de $36$].

• Pour $864$ :

$864 ÷ 36 = 24$

Le quotient est un entier naturel. Donc $864$ est un
#strong[multiple de $36$].

Dans le contexte du laboratoire, cela signifie que $864$ tubes
peuvent être répartis exactement en boîtes de $36$ tubes, contrairement
à $729$ tubes.
]

#v(0.2cm)

#exemple_resolu[
Un centre de santé utilise des lots de $3$ compresses.

Les dix premiers multiples de $3$ sont :

$0 ; 3 ; 6 ; 9 ; 12 ; 15 ; 18 ; 21 ; 24 ; 27$.

Déterminons maintenant les multiples de $6$ compris entre $50$ et $110$.


// ==========================================================
// MULTIPLES D'UN ENTIER NATUREL
// ==========================================================

#sous_titre[
Les multiples d'un entier naturel
]

#v(0.12cm)

#definition[
Un entier naturel $a$ est appelé #strong[multiple] d'un entier
naturel $b$ lorsqu'il existe un entier naturel $k$ tel que
$a = b × k$.

On dit alors que $a$ est #strong[multiple de] $b$.
]

#v(0.2cm)

#exemple[
Dans une pharmacie, des boîtes identiques contiennent chacune
$36$ comprimés.

Si une réserve contient $24$ boîtes, le nombre total de
comprimés est :

$36 × 24 = 864$.

On peut donc dire que $864$ est un #strong[multiple de $36$].

En revanche, si une réserve contient $729$ comprimés,
on cherche s'il est possible de les répartir exactement
dans des boîtes de $36$ comprimés.

Aucun entier naturel multiplié par $36$ ne donne $729$.

Donc $729$ n'est #strong[pas un multiple de $36$].
]

#v(0.2cm)

#retenir[
Pour savoir si un entier naturel est multiple d'un autre
entier naturel, on peut rechercher s'il existe un entier
naturel qui, multiplié par le deuxième nombre, donne le premier.
]

#v(0.2cm)

#exemple[
Dans un service de soins, les médicaments sont conditionnés
par lots de $5$ ou de $7$ unités.

Comme :

$5 × 7 = 35$,

on peut former exactement $7$ lots de $5$ unités avec
$35$ unités.

Ainsi, $35$ est un #strong[multiple de $5$].

De même :

$7 × 5 = 35$,

donc $35$ est également un #strong[multiple de $7$].

Cette propriété permet notamment de déterminer si une quantité
de matériel peut être répartie exactement en groupes de même
taille.
]

#v(1cm)

#exemple[
Dans une salle de soins, on dispose de $18$ compresses.
On prépare $2$ lots de $(3 + 4)$ compresses.

$A = 18 - 2 × (3 + 4)$

$A = 18 - 2 × 7$

$A = 18 - 14$

$A = 4$

Il reste donc $4$ compresses.
]

#v(0.05cm)

// ==========================================================
// PRÉDÉCESSEUR, SUCCESSEUR ET ENTIERS CONSÉCUTIFS
// ==========================================================

#sous_titre[
Prédécesseur, successeur et entiers naturels consécutifs
]

#v(0.05cm)

#definition[
Le #strong[prédécesseur] d'un entier naturel est l'entier naturel
qui vient immédiatement avant lui.

Le #strong[successeur] d'un entier naturel est l'entier naturel
qui vient immédiatement après lui.
]

#v(0.05cm)

#exemple[
Dans le dossier d'un patient, le numéro d'enregistrement est $30$.

• Le prédécesseur de $30$ est $29$.

• Le successeur de $30$ est $31$.

De même :

• le prédécesseur de $56$ est $55$ ;

• le successeur de $56$ est $57$.
]

#v(0.05cm)

#retenir[
Pour obtenir le #strong[prédécesseur] d'un entier naturel, on lui
soustrait $1$.

Pour obtenir le #strong[successeur] d'un entier naturel, on lui
ajoute $1$.

Ainsi :
#strong[$30 - 1 = 29$]
et
#strong[$30 + 1 = 31$.]
]

#v(0.2cm)

#definition[
Des entiers naturels sont dits #strong[consécutifs] lorsqu'ils
se suivent immédiatement dans la suite des entiers naturels.
]

#v(0.2cm)

#exemple[
Dans une liste de patients, les numéros $23$, $24$ et $25$
sont trois entiers naturels consécutifs.

De même, les numéros $41$, $42$, $43$ et $44$ sont quatre entiers
naturels consécutifs.
]

#v(0.2cm)

#exemple_resolu[
Déterminons trois entiers naturels consécutifs dont l'un est $25$.

Le nombre qui précède $25$ est $24$ et celui qui le suit est $26$.

On peut donc prendre :

$24 ; 25 ; 26$

Dans une liste de numéros, on pourrait également rencontrer :

$23 ; 24 ; 25$

ou

$25 ; 26 ; 27$.

Le contexte permet donc de préciser les trois nombres recherchés.
]

#v(0.2cm)

#remarque[
Dans une suite d'entiers naturels consécutifs, chaque nombre est le
#strong[successeur] du précédent et le #strong[prédécesseur] du suivant.

Par exemple, $25$ est le successeur de $24$ et $25$ est le
prédécesseur de $26$.
]

#v(3cm)

// ==========================================================
// MULTIPLES D'UN ENTIER NATUREL
// ==========================================================

#sous_titre[
Les multiples d'un entier naturel
]

#v(0.2cm)

#definition[
Un entier naturel $a$ est appelé #strong[multiple] d'un entier naturel
$b$ lorsqu'il existe un entier naturel $k$ tel que $a = b × k$.

On dit alors que $a$ est #strong[multiple de $b$].
]

#v(0.2cm)

#exemple[
Un laboratoire range $36$ tubes dans chacune de ses boîtes.
S'il utilise $24$ boîtes, le nombre total de tubes est :

$36 × 24 = 864$.

Ainsi, $864$ est un #strong[multiple de $36$].

En revanche, aucun entier naturel multiplié par $36$ ne donne $729$.
Donc $729$ n'est #strong[pas un multiple de $36$].
]

#v(0.2cm)

#retenir[
Pour savoir si un entier naturel est multiple d'un autre entier naturel,
on peut rechercher s'il existe un entier naturel qui, multiplié par le
deuxième nombre, donne le premier.
]

#v(0.2cm)

#exemple[
Un service médical prépare des lots de $5$ compresses.

$5 × 7 = 35$

Donc $35$ est un #strong[multiple de $5$].

De même :

$7 × 5 = 35$

Donc $35$ est également un #strong[multiple de $7$].

Cela signifie que $35$ compresses peuvent être réparties exactement
en $7$ lots de $5$ compresses ou en $5$ lots de $7$ compresses.
]

#v(0.3cm)

// ==========================================================
// LISTE DES MULTIPLES
// ==========================================================

#sous_titre[
Quelques multiples d'un entier naturel
]

#v(0.15cm)

#definition[
Pour obtenir les multiples d'un entier naturel, on le multiplie
successivement par les entiers naturels $0, 1, 2, 3, 4, ...$
]

#v(0.2cm)

#exemple[
Un laboratoire prépare des boîtes contenant chacune $6$ tubes.

Les nombres de tubes correspondant à $0$, $1$, $2$, $3$, $4$, $5$
et $6$ boîtes sont :

$6 × 0 = 0$

$6 × 1 = 6$

$6 × 2 = 12$

$6 × 3 = 18$

$6 × 4 = 24$

$6 × 5 = 30$

$6 × 6 = 36$

$6 × ... = ...$

Ainsi, les premiers multiples de $6$ sont :

$0 ; 6 ; 12 ; 18 ; 24 ; 30 ; 36 ; ...$
]

#v(0.2cm)

#retenir[
• Un entier naturel possède une infinité de multiples.

• Le nombre $0$ est multiple de tout entier naturel.

• Tout entier naturel non nul est multiple de $1$ et de lui-même.
]

#v(0.25cm)
Les multiples de $6$ sont :

$0 ; 6 ; 12 ; 18 ; 24 ; ...$

Le premier multiple de $6$ supérieur à $50$ est $54$.

Le dernier multiple de $6$ inférieur à $110$ est $108$.

En ajoutant successivement $6$, on obtient :

$54 ; 60 ; 66 ; 72 ; 78 ; 84 ; 90 ; 96 ; 102 ; 108$.

Ainsi, les multiples de $6$ compris entre $50$ et $110$ sont :

$54 ; 60 ; 66 ; 72 ; 78 ; 84 ; 90 ; 96 ; 102 ; 108$.
]

#v(0.2cm)

#remarque[
Lorsqu'un entier naturel $a$ est multiple d'un entier naturel $b$,
on peut également dire que $b$ est un #strong[diviseur] de $a$.
]

#v(0.2cm)

#exemple[
$36 × 24 = 864$.

Donc $864$ est multiple de $36$ et $36$ est diviseur de $864$.

Dans un laboratoire, cela signifie que $864$ tubes peuvent être
répartis exactement en groupes de $36$ tubes.
]

#v(0.5cm)

// ==========================================================
// NOMBRES PAIRS ET IMPAIRS
// ==========================================================

#sous_titre[
Nombres pairs et impairs
]

#v(0.15cm)

#exemple[
Un service de soins doit répartir des compresses par groupes de $2$.

Considérons les quantités suivantes :

$54 ; 16 ; 27 ; 3$.

Cherchons celles qui peuvent être réparties exactement par groupes
de $2$.

On a :

• $54 = 2 × 27$

• $16 = 2 × 8$

• $27$ ne peut pas s'écrire sous la forme $2 × k$ avec $k ∈ ℕ$.

• $3$ ne peut pas non plus s'écrire sous la forme $2 × k$ avec
$k ∈ ℕ$.
]

#v(0.2cm)

#definition[
• Un entier naturel qui est #strong[multiple de $2$] est appelé
un #strong[nombre pair].

• Un entier naturel qui n'est #strong[pas multiple de $2$] est
appelé un #strong[nombre impair].
]

#v(0.2cm)

#exemple[
• $54 = 2 × 27$ alors $54$ est pair.

• $16 = 2 × 8$ alors $16$ est pair.

• $27$ n'est pas multiple de $2$ alors $27$ est impair.

• $3$ n'est pas multiple de $2$ alors $3$ est impair.

Ainsi, une quantité paire peut être répartie exactement en groupes
de $2$.
]

#v(0.2cm)

#retenir[
Pour reconnaître rapidement un nombre pair ou impair, on peut observer
son chiffre des unités.

• Un nombre pair se termine par $0$, $2$, $4$, $6$ ou $8$.

• Un nombre impair se termine par $1$, $3$, $5$, $7$ ou $9$.
]

#v(0.2cm)

#exemple_resolu[
Déterminons si les nombres suivants sont pairs ou impairs.

• $128$ se termine par $8$. Donc $128$ est #strong[pair].

• $345$ se termine par $5$. Donc $345$ est #strong[impair].

• $720$ se termine par $0$. Donc $720$ est #strong[pair].

• $913$ se termine par $3$. Donc $913$ est #strong[impair].

Cette propriété permet notamment de savoir rapidement si une quantité
peut être répartie en deux groupes de même effectif.
]

#v(0.25cm)

// ==========================================================
// LIEN ENTRE PAIR ET MULTIPLE DE 2
// ==========================================================

#deductogramme_2(
  hypothese-1: [
    $128$ se termine par $8$.
  ],

  hypothese-2: [
    $8$ se trouve dans la liste
    ${0, 2, 4, 6, 8}$.
  ],

  conclusion: [
    $128$ est un nombre pair.
  ],
)

#v(0.3cm)

#deductogramme_2(
  hypothese-1: [
    $345$ se termine par $5$.
  ],

  hypothese-2: [
    $5$ ne se trouve pas dans la liste
    ${0, 2, 4, 6, 8}$.
  ],

  conclusion: [
    $345$ est un nombre impair.
  ],
)

#v(0.5cm)

// ==========================================================
// LISTE DE MULTIPLES ET DIVISEURS
// ==========================================================

#sous_titre[
Relation entre multiple et diviseur d'un entier naturel
]

#v(0.15cm)

// ==========================================================
// INTRODUCTION AUX DIVISEURS
// ==========================================================

#definition[
Un entier naturel $b$ non nul est un #strong[diviseur] d'un entier
naturel $a$ lorsqu'il existe un entier naturel $n$ tel que
$a = b × n$.

On dit alors que $a$ est un #strong[multiple de $b$].
]

#v(2cm)

#exemple[
Un centre de santé possède $27$ doses à répartir.

Comme :

$27 = 3 × 9$

alors $3$ est un #strong[diviseur de $27$].

Cela signifie que les $27$ doses peuvent être réparties exactement
en $3$ groupes de $9$ doses.
]

#v(0.5cm)

// ==========================================================
// CAS PARTICULIER DU NOMBRE 0
// ==========================================================

#sous_titre[
Le cas particulier de $0$
]

#v(0.15cm)

#retenir[
$0$ est un #strong[multiple de tout entier naturel] $b$ car :

$0 = b × 0$.

Ainsi, pour tout $b ∈ ℕ$, $0$ est un multiple de $b$.
]

#v(0.2cm)

#exemple[
$0 = 5 × 0$ donc $0$ est un multiple de $5$.

$0 = 12 × 0$ donc $0$ est un multiple de $12$.

$0 = 0 × 0$ donc $0$ est également un multiple de $0$.
]

#v(0.2cm)

#retenir[
En revanche, aucun entier naturel non nul n'est un multiple de $0$.

En effet, quel que soit $k ∈ ℕ$ :

$0 × k = 0$.

Un produit dont l'un des facteurs est $0$ est donc toujours égal
à $0$. Il est par conséquent impossible d'obtenir un nombre différent
de $0$ en multipliant $0$ par un entier naturel.
]

#v(2cm)

#exemple[
Prenons par exemple le nombre $15$.

Pour que $15$ soit un multiple de $0$, il faudrait trouver un entier
naturel $k$ tel que :

$15 = 0 × k$.

Or, quel que soit $k$, on a toujours :

$0 × k = 0$.

Il est donc impossible d'obtenir $15$.

Ainsi, $15$ n'est #strong[pas un multiple de $0$].
]

#v(0.2cm)

#remarque[
Puisqu'un entier naturel non nul n'est pas un multiple de $0$,
il n'est donc pas #strong[divisible par $0$].
]

#v(0.2cm)

#exemple[
• $15$ n'est pas multiple de $0$ alors $15 ÷ 0$ n'est pas défini.

• $24$ n'est pas multiple de $0$ alors $24 ÷ 0$ n'est pas défini.
]

#v(0.2cm)

#remarque[
Le cas de $0 ÷ 0$ est particulier.

On pourrait chercher un entier naturel $k$ tel que :

$0 = 0 × k$.

Mais cette égalité est vraie pour #strong[tout] $k ∈ ℕ$ :

$0 = 0 × 0$ ;

$0 = 0 × 1$ ;

$0 = 0 × 2$ ;

etc.

Il n'existe donc pas de quotient unique $k$ avec $k ∈ ℕ$ permettant
de définir $0 ÷ 0$.

Ainsi, en mathématiques, #strong[$0 ÷ 0$ n'est pas défini].
]

#v(2cm)

#retenir[
• $0$ est un multiple de tout entier naturel.

• Aucun entier naturel non nul n'est un multiple de $0$.

• On ne divise jamais un nombre par $0$.

• $0 ÷ 0$ n'est pas défini, car il n'existe pas de quotient unique.

• Dans la définition des diviseurs, $0$ est donc exclu comme diviseur.
]

#v(0.5cm)

// ==========================================================
// DÉTERMINER LES DIVISEURS
// ==========================================================

#retenir[
Pour déterminer les diviseurs d'un entier naturel, on recherche tous
les nombres qui permettent de l'obtenir par une multiplication avec
un entier naturel.
]

#v(0.2cm)

#exemple[
Pour préparer une répartition identique de $27$ doses, recherchons
les différentes façons d'obtenir $27$ par multiplication.

$27 = 1 × 27$

$27 = 3 × 9$

$27 = 9 × 3$

$27 = 27 × 1$

Donc les diviseurs de $27$ sont :

$1 ; 3 ; 9 ; 27$.

Ces nombres correspondent aux différentes tailles de groupes dans
lesquels les $27$ doses peuvent être réparties exactement.
]

#v(0.3cm)

// ==========================================================
// LIEN MULTIPLE / DIVISEUR
// ==========================================================

#deductogramme_2(
  hypothese-1: [
    $27 = 3 × 9$.
  ],

  hypothese-2: [
    $3$ et $9$ sont des entiers naturels.
  ],

  conclusion: [
    $3$ est un diviseur de $27$.
  ],
)

#v(0.3cm)

#deductogramme_2(
  hypothese-1: [
    $27 = 3 × 9$.
  ],

  hypothese-2: [
    $3$ et $9$ sont des entiers naturels.
  ],

  conclusion: [
    $27$ est un multiple de $3$.
  ],
)

#v(0.2cm)

#retenir[
Lorsqu'on a $a = b × n$ avec $b ≠ 0$ :

• $a$ est un #strong[multiple de $b$] ;

• $b$ est un #strong[diviseur de $a$].

Ces deux affirmations désignent la même relation entre les nombres.
]

#v(3cm)

// ==========================================================
// CRITÈRES DE DIVISIBILITÉ
// ==========================================================

#sous_titre[
Critères ou caractères de divisibilité
]

#v(0.15cm)

#definition[
Un critère de divisibilité est une règle qui permet de reconnaître
rapidement si un nombre entier naturel est divisible par un autre
nombre entier naturel, sans effectuer nécessairement la division.
]

#v(0.2cm)

#retenir[
Un nombre peut être divisible par un autre nombre lorsque certaines
propriétés de son écriture permettent de le reconnaître.

Nous allons découvrir progressivement ces critères.
]

#v(0.3cm)

#sous_sous_titre[
Divisibilité par $2$
]

#v(0.15cm)

#definition[
Un nombre entier naturel est divisible par $2$ lorsque son chiffre
des unités est $0$, $2$, $4$, $6$ ou $8$.
]

#v(0.2cm)

#exemple[
Dans un stock médical :

• le chiffre des unités de $138$ est $8$, donc $138$ est divisible
par $2$ ;

• le chiffre des unités de $145$ est $5$, donc $145$ n'est pas
divisible par $2$.

Ainsi, $138$ peut être réparti exactement en deux groupes de même
effectif, contrairement à $145$.
]

#v(2cm)

#sous_sous_titre[
Divisibilité par $5$ et par $10$
]

#v(0.15cm)

#retenir[
• Un nombre entier naturel est divisible par $5$ lorsque son chiffre
des unités est $0$ ou $5$.

• Un nombre entier naturel est divisible par $10$ lorsqu'il se termine
par $0$.
]

#v(0.3cm)

#sous_sous_titre[
Divisibilité par $4$, par $25$ et par $100$
]

#v(0.15cm)

#retenir[
• Un nombre entier naturel est divisible par $4$ lorsque le nombre
formé par ses deux derniers chiffres est divisible par $4$.

• Un nombre entier naturel est divisible par $25$ lorsque le nombre
formé par ses deux derniers chiffres est divisible par $25$.

• Un nombre entier naturel est divisible par $100$ lorsqu'il se termine
par $00$.
]

#v(0.3cm)

#sous_sous_titre[
Divisibilité par $3$ et par $9$
]

#v(0.15cm)

#retenir[
• Un nombre entier naturel est divisible par $3$ lorsque la somme de
ses chiffres est divisible par $3$.

• Un nombre entier naturel est divisible par $9$ lorsque la somme de
ses chiffres est divisible par $9$.
]

#v(3cm)

#sous_sous_titre[
Divisibilité par $6$ et par $12$
]

#v(0.15cm)

#retenir[
• Un nombre entier naturel est divisible par $6$ lorsqu'il est à la
fois divisible par $2$ et par $3$.

• Un nombre entier naturel est divisible par $12$ lorsqu'il est à la
fois divisible par $3$ et par $4$.
]

#v(0.3cm)

#sous_sous_titre[
Divisibilité par $8$
]

#v(0.15cm)

#retenir[
Un nombre entier naturel est divisible par $8$ lorsque le nombre formé
par ses trois derniers chiffres est divisible par $8$.
]

#v(0.01cm)

// ==========================================================
// DIVISIBILITÉ PAR 7
// ==========================================================

#sous_sous_titre[
Divisibilité par $7$
]

#v(0.01cm)

#definition[
Pour vérifier si un entier naturel est divisible par $7$, on peut
utiliser la règle suivante :    

• on sépare le #strong[chiffre des unités] du nombre ;
• on multiplie ce chiffre par $2$ ;

• on soustrait le double du chiffre des unités au nombre formé par
les chiffres restants lorsque ce dernier est supérieur ou égal au
double ;

• dans le cas contraire, on effectue la soustraction dans l'autre
sens afin de conserver un résultat dans les entiers naturels ;

• si le résultat obtenu est encore difficile à examiner, on peut
#strong[répéter la même opération] jusqu'à obtenir un nombre dont
on peut facilement déterminer la divisibilité par $7$.
Si le résultat final est divisible par $7$, alors le nombre de départ
est divisible par $7$.
]

#v(0.2cm)

#exemple_resolu[
Vérifions si $203$ est divisible par $7$.

• Le chiffre des unités est $3$.

• Son double est $6$ car $3 × 2 = 6$.

• Le nombre formé par les chiffres restants est $20$.

• Comme $6$ est inférieur à $20$, on effectue :

$20 - 6 = 14$

• Or $14 = 7 × 2$, donc $14$ est divisible par $7$.

Par conséquent, $#strong[203 est divisible par 7.]$

En effet :

$203 = 7 × 29$.
]

#v(0.02cm)

#exemple_resolu[
Vérifions si $1234$ est divisible par $7$.

• Le chiffre des unités est $4$.

• Son double est :
$4 × 2 = 8$.

• Le nombre formé par les chiffres restants est $123$.

• Comme $8$ est inférieur à $123$, on effectue :

$123 - 8 = 115$.

Le résultat $115$ est encore difficile à examiner.
On recommence alors avec $115$.

• Le chiffre des unités est $5$.

• Son double est :
$5 × 2 = 10$.

• Le nombre formé par les chiffres restants est $11$.

• On effectue :
$11 - 10 = 1$.

• Or $1$ n'est pas divisible par $7$.

Donc $#strong[1234 n'est pas divisible par 7.]$
]

#v(1cm)

#remarque[
Lorsque le double du chiffre des unités est plus grand que le nombre
formé par les chiffres restants, on effectue la soustraction dans
l'autre sens afin de conserver un résultat dans les entiers naturels.
]

#v(0.2cm)

#exemple[
Prenons $35$.

• Le chiffre des unités est $5$ ;

• son double est $5 × 2 = 10$ ;

• le nombre formé par les chiffres restants est $3$ ;

• comme $10$ est supérieur à $3$, on calcule :

$10 - 3 = 7$ ;

• or $7$ est divisible par $7$.

Donc $#strong[$35$ est divisible par 7.]$

En effet :

$35 = 7 × 5$.
]

#v(0.2cm)

#remarque[
Le critère de divisibilité par $7$ est moins immédiat que ceux de
$2$, $3$, $4$, $5$, $8$, $9$, $10$, $25$ ou $100$.

Il nécessite d'effectuer un petit calcul à partir du chiffre des
unités. La méthode peut être #strong[répétée plusieurs fois] jusqu'à
obtenir un nombre dont on peut facilement déterminer s'il est
divisible par $7$.

Dans cette méthode, on veille à conserver des résultats dans
l'ensemble des #strong[entiers naturels].
]

#v(0.2cm)
// ==========================================================
// 6.8. DIVISIBILITÉ PAR 11
// ==========================================================

#sous_sous_titre[
Divisibilité par $11$
]

#v(0.15cm)

#definition[
Pour vérifier si un entier naturel est divisible par $11$, on peut utiliser
la règle suivante :

• on repère le #strong[rang de chaque chiffre], en comptant les rangs
à partir de la droite ;

• on calcule la somme des chiffres de #strong[rangs impairs]
(rang $1$, rang $3$, rang $5$, etc.) ;

• on calcule la somme des chiffres de #strong[rangs pairs]
(rang $2$, rang $4$, rang $6$, etc.) ;

• on calcule ensuite la #strong[différence entre les deux sommes],
en soustrayant la plus petite somme de la plus grande ;

• si cette différence est un multiple de $11$, alors le nombre de départ
est divisible par $11$.

Si les deux sommes sont égales, leur différence est $0$.
Or $0$ est un multiple de $11$.
]


#v(0.2cm)


#exemple[
Considérons le nombre $4735$.
En comptant les rangs à partir de la droite :

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  gutter: 0.5cm,

  [#align(center)[$4$]],
  [#align(center)[$7$]],
  [#align(center)[$3$]],
  [#align(center)[$5$]],

  [#align(center)[rang $4$]],
  [#align(center)[rang $3$]],
  [#align(center)[rang $2$]],
  [#align(center)[rang $1$]],
)

Ainsi :

• $5$ est au rang $1$ ;

• $3$ est au rang $2$ ;

• $7$ est au rang $3$ ;

• $4$ est au rang $4$.

Les chiffres de rangs impairs sont donc $5$ et $7$.

Les chiffres de rangs pairs sont donc $3$ et $4$.
]
#v(0.2cm)
#exemple_resolu[
Vérifions si $121$ est divisible par $11$.

Les chiffres sont pris alternativement :

• premier groupe : $1 + 1 = 2$ ;

• deuxième groupe : $2$.

On calcule la différence entre les deux sommes :

$2 - 2 = 0$.

Or $0$ est un multiple de $11$.

Donc $#strong[121 est divisible par 11.]$

En effet $121 = 11 × 11$.
]


#v(5cm)


#exemple_resolu[
Vérifions si $2453$ est divisible par $11$.

On prend les chiffres alternativement :

• premier groupe : $2 + 5 = 7$ ;

• deuxième groupe : $4 + 3 = 7$.

La différence entre les deux sommes est :

$7 - 7 = 0$.

Or $0$ est un multiple de $11$.

Donc $#strong[2453 est divisible par 11.]$

En effet $2453 = 11 × 223$.
]


#v(0.2cm)


#exemple_resolu[
Vérifions si $1452$ est divisible par $11$.

On prend les chiffres alternativement :

• premier groupe : $1 + 5 = 6$ ;

• deuxième groupe : $4 + 2 = 6$.

La différence entre les deux sommes est :

$6 - 6 = 0$.

Or $0$ est un multiple de $11$.

Donc #strong[1452 est divisible par 11.]

En effet :

$1452 = 11 × 132$.
]


#v(0.2cm)


#exemple_resolu[
Vérifions si $1234$ est divisible par $11$.

On prend les chiffres alternativement :

• premier groupe : $1 + 3 = 4$ ;

• deuxième groupe : $2 + 4 = 6$.

La plus grande somme est $6$.

On calcule donc :

$6 - 4 = 2$.

Or $2$ n'est pas un multiple de $11$.

Donc :
$#strong[1234 n'est pas divisible par 11.]$
]


#v(0.05cm)


#exemple_resolu[
Vérifions si $3872$ est divisible par $11$.

On prend les chiffres alternativement :

• premier groupe : $3 + 7 = 10$ ;

• deuxième groupe : $8 + 2 = 10$.

La différence entre les deux sommes est :

$10 - 10 = 0$.

Or $0$ est un multiple de $11$.

Donc :
$#strong[3872 est divisible par 11.]$

En effet :

$3872 = 11 × 352$.
]


#v(0.05cm)


#remarque[
Pour un nombre comportant plusieurs chiffres, on additionne les chiffres
placés alternativement.
On peut commencer par le premier chiffre et prendre ensuite un chiffre
sur deux.
Les chiffres restants forment le deuxième groupe.
On compare ensuite les deux sommes en calculant la différence entre la
plus grande et la plus petite.
Si cette différence est $0$, $11$, $22$, $33$, etc., alors le nombre
est divisible par $11$.
]


#v(0.2cm)




// ==========================================================
// 6.9. DIVISIBILITÉ PAR 12
// ==========================================================

#sous_sous_titre[
Divisibilité par $12$
]

#v(0.15cm)



#retenir[
Un nombre entier naturel est divisible par $12$ lorsqu'il est à la fois divisible par $3$ et par $4$.
]

#v(0.2cm)

#exemple_resolu[

$348$ est divisible par $3$ car :

$3 + 4 + 8 = 15$

et $15$ est divisible par $3$.

De plus, $48$ est divisible par $4$.

Donc $348$ est divisible par $12$.

]

#v(0.2cm)

#remarque[
Pour vérifier la divisibilité par $12$, il suffit donc de vérifier
simultanément les critères de divisibilité par $3$ et par $4$.
]




// ==========================================================
// 6.10. DIVISIBILITÉ PAR 13
// ==========================================================

#sous_sous_titre[
Divisibilité par $13$
]

#v(0.15cm)


#retenir[
Un nombre entier naturel est divisible par $13$ lorsqu'il peut s'écrire comme le produit de $13$ par un entier naturel.
]

#v(0.2cm)

#exemple_resolu[

$286 = 13 × 22$.

Donc $286$ est divisible par $13$.

De même :

$78 = 13 × 6$.

Donc $78$ est divisible par $13$.

]

#v(0.2cm)

#remarque[
Comme $13$ est un diviseur de lui-même, tout nombre de la forme $13 × k$, où $k$ est un entier naturel, est divisible par $13$.
]



// ==========================================================
// 6.11. DIVISIBILITÉ PAR 1000
// ==========================================================

#sous_sous_titre[
Divisibilité par $1000$
]

#v(0.15cm)

#retenir[
Un nombre entier naturel est divisible par $1000$ lorsqu'il se termine par trois zéros.
]

#v(0.2cm)

#remarque[
Le critère de divisibilité par $100$ utilise les deux derniers chiffres du nombre, tandis que celui de divisibilité par $1000$
utilise les trois derniers chiffres.
]

#v(0.3cm)

#exemple_resolu[
7#strong[000] se termine par trois zéros alors il est divisible par 1#strong[000].

12#strong[000] se termine par trois zéros alors il est divisible par 1#strong[000].

35#strong[00] ne se termine pas par trois zéros alors il n'est pas divisible par $1000$.
]














#v(0.15cm)
#retenir[

#align(center)[

  #text(
    size: 14pt,
    weight: "bold",
    fill: code-blue,
  )[
    🧠 LES CRITÈRES DE DIVISIBILITÉ À CONNAÎTRE
  ]

]

#v(0.25cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 9pt,
  inset: 0.25cm,
  stroke: 0.8pt + code-blue,
)[

  #text(
    size: 11.5pt,
    weight: "bold",
    fill: code-blue,
  )[
    🟦 Je regarde le dernier chiffre
  ]

  #v(0.1cm)

  • $2$ : le nombre se termine par $0$, $2$, $4$, $6$ ou $8$.

  • $5$ : le nombre se termine par $0$ ou $5$.

  • $10$ : le nombre se termine par $0$.

]

#v(0.18cm)

#box(
  width: 100%,
  fill: rgb("#EAF4EC"),
  radius: 9pt,
  inset: 0.25cm,
  stroke: 0.8pt + code-green,
)[

  #text(
    size: 11.5pt,
    weight: "bold",
    fill: code-green,
  )[
    🟩 Je regarde les derniers chiffres
  ]

  #v(0.1cm)

  • $4$ : le nombre formé par les deux derniers chiffres est un multiple de $4$.

  • $8$ : le nombre formé par les trois derniers chiffres est un multiple de $8$.

  • $25$ : le nombre formé par les deux derniers chiffres est un multiple de $25$.

  • $100$ : le nombre se termine par $00$.

  • $1000$ : le nombre se termine par $000$.

]

#v(0.18cm)

#box(
  width: 100%,
  fill: rgb("#FFF8E7"),
  radius: 9pt,
  inset: 0.25cm,
  stroke: 0.8pt + rgb("#D6A700"),
)[

  #text(
    size: 11.5pt,
    weight: "bold",
    fill: rgb("#A47700"),
  )[
    🟨 Je calcule avec les chiffres
  ]

  #v(0.1cm)

  • $3$ : la somme des chiffres est un multiple de $3$.

  • $9$ : la somme des chiffres est un multiple de $9$.

  • $11$ : la différence entre les sommes des chiffres placés alternativement est un multiple de $11$.

]

#v(0.18cm)

#box(
  width: 100%,
  fill: rgb("#F3EAF8"),
  radius: 9pt,
  inset: 0.25cm,
  stroke: 0.8pt + rgb("#8A4FA3"),
)[

  #text(
    size: 11.5pt,
    weight: "bold",
    fill: rgb("#703A88"),
  )[
    🟪 Je combine plusieurs critères
  ]

  #v(0.1cm)

  • $6$ : le nombre est à la fois divisible par $2$ et par $3$.

  • $12$ : le nombre est à la fois divisible par $3$ et par $4$.

]

#v(0.18cm)

#box(
  width: 100%,
  fill: rgb("#FFF0E5"),
  radius: 9pt,
  inset: 0.25cm,
  stroke: 0.8pt + rgb("#D66A00"),
)[

  #text(
    size: 11.5pt,
    weight: "bold",
    fill: rgb("#B05500"),
  )[
    🟧 Je recherche un multiple
  ]

  #v(0.1cm)

  • $7$ : je vérifie si le nombre peut s'écrire sous la forme $7 × k$, avec $k ∈ ℕ$.

  • $13$ : je vérifie si le nombre peut s'écrire sous la forme $13 × k$, avec $k ∈ ℕ$.

]

#v(0.15cm)

#align(center)[

  #text(
    size: 10.5pt,
    style: "italic",
    fill: code-gray,
  )[
    💡 Plus le nombre est grand, plus il est utile de choisir le critère adapté plutôt que d'effectuer directement la division.
  ]

]

]



#exercice_resolu[

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
🧠 Réinvestissement — Les os du squelette et la divisibilité
]

#v(0.2cm)

#text(
weight: "bold",
)[
1. Compter les os selon des groupes
]
Un squelette humain adulte possède environ $206$ os.

Pour une activité pédagogique, on répartit certains os
en groupes de $2$.

Cite les dix premiers nombres d'os qui peuvent représenter
un nombre pair mais qui ne sont pas des multiples de $3$.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Les premiers multiples de $2$ sont :

$0 ; 2 ; 4 ; 6 ; 8 ; 10 ; 12 ; 14 ; 16 ; 18 ; 20 ; ...$

Parmi eux, ceux qui ne sont pas multiples de $3$ sont :

$2 ; 4 ; 8 ; 10 ; 14 ; 16 ; 20 ; 22 ; 26 ; 28$.

Donc les dix premiers nombres recherchés sont :

$2 ; 4 ; 8 ; 10 ; 14 ; 16 ; 20 ; 22 ; 26 ; 28$.

#v(1cm)

#text(
weight: "bold",
)[
2. Vérifier un nombre d'os
]

Une partie du squelette étudiée en classe comporte $182$ os
dans une représentation théorique.

Peut-on répartir exactement ces $182$ os en groupes de $13$ ?

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On a :

$182 = 13 × 14$.

Donc $182$ est un multiple de $13$.

Ainsi, les $182$ os peuvent être répartis exactement
en $14$ groupes de $13$ os.

#v(0.3cm)

#text(
weight: "bold",
)[
3. Cas particuliers des groupes d'os
]

Un préparateur souhaite former des groupes contenant
un nombre entier naturel d'os.

a) Quels sont les multiples de $0$ ?

b) Quels sont les multiples de $1$ ?

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

a) Un multiple de $0$ est de la forme :

$0 × k = 0$ avec $k$ un nombre entier naturel.

Donc :

$M_0 = {0}$.

b) Un multiple de $1$ est de la forme :

$1 × k = k$ avec $k$ un nombre entier naturel.

Ainsi, tout entier naturel est un multiple de $1$ .

#v(0.3cm)

#text(
weight: "bold",
)[
4. Rechercher des nombres d'os possibles
]

Un chercheur étudie des groupes contenant $17$ os.

Il recherche les nombres d'os strictement supérieurs à $170$
et strictement inférieurs à $340$ qui permettent de former
des groupes complets de $17$ os.

Écris l'ensemble $M$ de ces nombres.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Les nombres recherchés sont les multiples de $17$ compris
strictement entre $170$ et $340$.

On a :

$17 × 11 = 187$

$17 × 12 = 204$

$17 × 13 = 221$

$17 × 14 = 238$

$17 × 15 = 255$

$17 × 16 = 272$

$17 × 17 = 289$

$17 × 18 = 306$

$17 × 19 = 323$

Ainsi :

$M = {187 ; 204 ; 221 ; 238 ; 255 ; 272 ; 289 ; 306 ; 323}$.

#v(0.3cm)

#text(
weight: "bold",
)[
5. Identifier rapidement des nombres d'os divisibles
]

On considère plusieurs nombres représentant des quantités
d'os utilisées dans différentes activités :

$75$ ; $100$ ; $123$ ; $783$ ; $990$ ; $6300$.

Pour chacun de ces nombres, indique s'il est divisible par
$1$, $2$, $3$, $4$, $5$, $9$ et $10$.

#v(0.15cm)

#table(
columns: (2.2cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm),
align: center,
stroke: 0.5pt + rgb("#C9D7E5"),
inset: 0.12cm,

[#strong[Nombre]],
[#strong[$1$]],
[#strong[$2$]],
[#strong[$3$]],
[#strong[$4$]],
[#strong[$5$]],
[#strong[$9$]],
[#strong[$10$]],

[$75$], [], [], [], [], [], [], [],

[$100$], [], [], [], [], [], [], [],

[$123$], [], [], [], [], [], [], [],

[$783$], [], [], [], [], [], [], [],

[$990$], [], [], [], [], [], [], [],

[$6300$], [], [], [], [], [], [], [],
)

#v(0.15cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

#table(
columns: (2.2cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm, 0.9cm),
align: center,
stroke: 0.5pt + rgb("#C9D7E5"),
inset: 0.12cm,

[#strong[Nombre]],
[#strong[$1$]],
[#strong[$2$]],
[#strong[$3$]],
[#strong[$4$]],
[#strong[$5$]],
[#strong[$9$]],
[#strong[$10$]],

[$75$], [×], [], [×], [], [×], [], [],

[$100$], [×], [×], [], [×], [×], [], [×], 

[$123$], [×], [], [×], [], [], [], [],

[$783$], [×], [], [×], [], [], [×], [],

[$990$], [×], [×], [×], [], [×], [×], [×],

[$6300$], [×], [×], [×], [], [×], [×], [×],
)

#v(0.3cm)

#text(
weight: "bold",
)[
6. Déterminer les diviseurs d'un nombre d'os
]

Dans une représentation simplifiée, on dispose de $48$ os
destinés à être répartis en groupes identiques.

Écris l'ensemble $A$ des diviseurs de $48$, puis précise
le plus petit et le plus grand diviseur de $48$.

#v(4cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On recherche les nombres naturels qui permettent de répartir
exactement les $48$ os en groupes identiques.

On a :

$48 = 1 × 48$

$48 = 2 × 24$

$48 = 3 × 16$

$48 = 4 × 12$

$48 = 6 × 8$

Donc :

$A = {1 ; 2 ; 3 ; 4 ; 6 ; 8 ; 12 ; 16 ; 24 ; 48}$.

Le #strong[plus petit diviseur] de $48$ est $1$.

Le #strong[plus grand diviseur] de $48$ est $48$.

#v(0.3cm)





#retenir[ 
Pour résoudre ce type de problème, je peux :

#v(0.05cm)

🔎 rechercher les multiples ;

🧠 utiliser le critère de divisibilité adapté ;

🔗 combiner plusieurs critères ;

🎯 rechercher les diviseurs à partir des produits.


]

]
]




#pagebreak()
























// ==========================================================
// PARCOURS 5e
// DIVISION DANS ℕ
// ==========================================================




#parcours(
  [PARCOURS 5ᵉ — Division dans $ℕ$ avec l'architecture de l'ordinateur],
  "parcours-entiers-naturels-5e",
) <parcours-entiers-naturels-5e>

// ----------------------------------------------------------
// MISE EN SITUATION
// ----------------------------------------------------------



  #activite[
    💻 À la découverte de l'ordinateur portable
  

  #v(0.12cm)

  Un ordinateur portable est une machine composée de plusieurs éléments qui travaillent ensemble pour permettre à l'utilisateur
  d'écrire, de calculer, de regarder des vidéos, de stocker des fichiers, de communiquer ou encore d'utiliser Internet.
  Lorsque tu regardes un ordinateur portable, tu peux facilement identifier certains de ses éléments : l'#strong[écran], le
  #strong[clavier], le #strong[pavé tactile], les #strong[haut-parleurs], la #strong[caméra], les différents #strong[ports] et le #strong[chargeur].
  Mais une grande partie de ce qui fait fonctionner l'ordinateur se trouve à l'intérieur de la machine.
  On y trouve notamment la #strong[carte mère], le #strong[processeur], la #strong[mémoire vive (RAM)], le #strong[stockage], la #strong[batterie], le système de #strong[refroidissement] et différents circuits électroniques.
  Ces éléments ne sont pas placés au hasard. Ils possèdent des caractéristiques précises et sont organisés de manière à fonctionner ensemble.

  Par exemple, un ordinateur peut posséder plusieurs ports, plusieurs haut-parleurs, plusieurs touches sur son clavier et plusieurs composants électroniques. Certains composants peuvent eux-mêmes être constitués de plusieurs éléments identiques.
  Pour mieux comprendre le fonctionnement et l'organisation d'un ordinateur, nous pouvons utiliser les mathématiques pour
  #strong[compter ses éléments], #strong[les regrouper], #strong[comparer leurs caractéristiques] et #strong[étudier les relations entre les différentes quantités].
  Observe attentivement un ordinateur portable réel ou une photographie d'un ordinateur portable.

  1. Identifie et nomme les principaux éléments que tu peux observer à l'extérieur de l'ordinateur : écran, clavier, pavé tactile, caméra, haut-parleurs, ports, etc.

  2. Certains de ces éléments sont-ils présents en plusieurs exemplaires ? Lesquels ? Combien peux-tu en compter ?

  3. Une mémoire vive de $8$ Go peut, selon sa conception, être organisée en plusieurs modules de même capacité. Quelles répartitions de $8$ Go en modules de même capacité peux-tu envisager ?

  4. Un ordinateur possède un espace de stockage de $512$ Go. Si l'on souhaite représenter cet espace sous forme de plusieurs parties de même capacité, quelles répartitions exactes peux-tu envisager ?

  5. Parmi les nombres obtenus, lesquels permettent de former des groupes identiques sans reste ?

  6. Que remarques-tu lorsque tu cherches les différentes façons de répartir exactement une même quantité ?

  7. Pour organiser certaines quantités de manière régulière dans un ordinateur, il faut savoir effectuer des partages sans reste, rechercher des quantités qui se répètent et déterminer les tailles de groupes possibles.
]

#v(0.25cm)

#align(center)[

  #image_full("ordinateur-portable-5e.png")

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

🔎 reconnaître et utiliser les #strong[nombres premiers] ;

#v(0.05cm)

📐 utiliser les #strong[puissances] pour représenter des répétitions de facteurs identiques ;

#v(0.05cm)

🧩 décomposer un nombre entier naturel en #strong[produit de facteurs premiers] ;

#v(0.05cm)

🔗 déterminer le #strong[PPCM] de deux nombres ;

#v(0.05cm)

🎯 déterminer le #strong[PGCD] de deux nombres ;

#v(0.05cm)

💻 et utiliser ces outils pour mieux comprendre certaines façons d'#strong[organiser, répartir et synchroniser les éléments et les données d'un ordinateur].
]


#v(0.3cm)

#remarque[
Les mathématiques ne servent donc pas seulement à effectuer des calculs.

Elles permettent aussi de #strong[comprendre, organiser, mesurer et analyser] les objets et les technologies qui nous entourent.

Dans ce parcours, nous allons utiliser les mathématiques pour explorer progressivement la structure, l'organisation et certains composants d'un ordinateur portable.
]


#v(0.3cm)
#pagebreak()
#deux-colonnes[

// ==========================================================
// MULTIPLES
// ==========================================================

#sous_titre[
Les multiples d'un entier naturel
]

#v(0.15cm)

#definition[
Un multiple d'un nombre entier naturel est obtenu en multipliant ce nombre par un entier naturel.
]

#v(0.3cm)

#exemple_resolu[
Un ordinateur possède une mémoire de stockage représentée ici par des blocs de $50$ Go.

Les capacités obtenues en ajoutant successivement des blocs de $50$ Go sont :

$50 × 0 = 0$

$50 × 1 = 50$

$50 × 2 = 100$

$50 × 3 = 150$

$50 × 4 = 200$

$50 × ... = ...$

Donc $0 ; 50 ; 100 ; 150 ; 200 ; ...$ sont des multiples de $50$.

Cela signifie qu'une capacité comme $200$ Go peut être obtenue avec $4$ blocs de $50$ Go.
]

#v(0.3cm)

#remarque[
Dans un ordinateur, une quantité peut être organisée en blocs de même taille.

Les multiples permettent donc de représenter différentes quantités obtenues en répétant une même capacité.
]

#v(8cm)

// ==========================================================
// DIVISEURS D'UN ENTIER NATUREL
// ==========================================================

#sous_titre[
Les diviseurs d'un entier naturel
]

#v(0.15cm)

#definition[
Un entier naturel non nul $b$ est un diviseur d'un entier naturel $a$ lorsqu'il existe un entier naturel $k$ tel que : #strong[$ a = b × k $.] Autrement dit, la division euclidienne de $a$ par $b$ donne un reste nul.



#image_division(
  "division-eucludienne-5e.jpeg",
  width: 3.5cm,
)


• #strong[$a$] est le #strong[dividende];

• #strong[$b$] est le #strong[diviseur] de cette opération;

• #strong[$q$] est le #strong[quotient]

• #strong[$r$] est le #strong[reste].


]

#v(0.05cm)


#exemple_resolu[
Une mémoire de stockage contient $20$ blocs identiques.

Si on les répartit en groupes de $4$ blocs :

$20 ÷ 4 = 5$
et le reste est nul.
Donc $4$ est un diviseur de $20$.
Cela signifie que les $20$ blocs peuvent être répartis exactement en $5$ groupes de $4$ blocs.
]


#v(0.01cm)

#regle[
Pour trouver tous les diviseurs d'un nombre entier naturel non nul, on :

• effectue la division du nombre concerné par les nombres entiers naturels à partir de $1$ ;

• arrête la recherche lorsque le quotient est inférieur ou égal au diviseur ;

• retient le diviseur et le quotient lorsque le reste est nul.
]

#v(0.3cm)

#exemple_resolu[
Cherchons les diviseurs de $50$.

On peut former les répartitions suivantes :

$50 = 1 × 50$

$50 = 2 × 25$

$50 = 5 × 10$

Ainsi, les diviseurs de $50$ sont :

$1 ; 2 ; 5 ; 10 ; 25 ; 50$.

Ces résultats indiquent par exemple que $50$ éléments peuvent être organisés en $5$ groupes de $10$, en $10$ groupes de $5$, en $2$ groupes de $25$, etc.
]


#v(0.05cm)

#retenir[
Si $a=b×k$ alors :

• $b$ est un diviseur de $a$ ;

• $a$ est un multiple de $b$.
]

#v(0.05cm)

// ==========================================================
// DIVISION EUCLIDIENNE
// ==========================================================

#sous_titre[
La division euclidienne dans ℕ
]

#v(0.15cm)

#definition[
Effectuer la division euclidienne d'un entier naturel $a$ par un entier naturel non nul $b$ consiste à trouver deux entiers naturels $q$ et $r$ tels que :

$a=b×q+r$

avec :

$r<b$.
]

#v(0.3cm)

#text(
weight:"bold",
)[
Vocabulaire :
]

Dans l'égalité $50=8×6+2$ :

• $50$ est #strong[le dividende] ;

• $8$ est #strong[le diviseur] ;

• $6$ est #strong[le quotient] ;

• $2$ est #strong[le reste].

#v(0.4cm)

#exemple_resolu[
Un technicien souhaite répartir $50$ composants électroniques identiques dans des sachets contenant chacun $8$ composants.

Effectuons la division de $50$ par $8$ :

$50=8×6+2$.

Le quotient est $6$.

Le reste est $2$.

Donc le technicien peut remplir #strong[6 sachets complets de 8 composants] et il lui reste #strong[2 composants].

La division n'est pas exacte car le reste est différent de $0$.
]

#v(0.6cm)

// ==========================================================
// ENCADREMENT PAR DES MULTIPLES CONSECUTIFS
// ==========================================================

#sous_titre[
Encadrer un entier naturel par deux multiples consécutifs
]

#v(0.15cm)

#propriete[
Si $a=b×q+r$ avec $r ≠ 0$ alors :

$b×q<a<b×(q+1)$.
]

#v(0.3cm)

#exemple_resolu[
Un ordinateur doit traiter $50$ éléments par groupes de $8$.

On sait que :

$50=8×6+2$.

Donc :

$8×6<50<8×7$.

Ainsi :

$48<50<56$.

Les deux multiples consécutifs de $8$ qui encadrent $50$ sont donc $48$ et $56$.

Cela permet de savoir immédiatement que $50$ contient $6$ groupes complets de $8$, avec quelques éléments supplémentaires.
]

#v(0.6cm)

// ==========================================================
// NOMBRES PREMIERS
// ==========================================================

#sous_titre[
Les nombres premiers
]

#v(0.15cm)

#definition[
Un nombre premier est un entier naturel supérieur à $1$ qui possède exactement deux diviseurs : $1$ et lui-même.
]

#v(0.3cm)

#exemple[
Considérons les tailles de groupes possibles suivantes :

$2 ; 3 ; 5 ; 7 ; 11 ; 13$.

Chacun de ces nombres possède exactement deux diviseurs : $1$ et lui-même.

Ce sont donc des nombres premiers.

Dans l'étude de l'organisation des données, les nombres premiers jouent un rôle important car ils ne peuvent pas être décomposés en produits de deux entiers naturels supérieurs à $1$.
]

#v(0.4cm)

#remarque[
• $0$ n'est pas un nombre premier.

• $1$ n'est pas un nombre premier.

• Un nombre premier possède exactement deux diviseurs.

• $2$ est le premier nombre premier.
]

#v(0.6cm)

#retenir[
Les nombres premiers strictement inférieurs à $100$ sont :

$2 ; 3 ; 5 ; 7 ; 11 ; 13 ; 17 ; 19 ; 23 ; 29 ;$

$31 ; 37 ; 41 ; 43 ; 47 ; 53 ; 59 ; 61 ; 67 ; 71 ;$

$73 ; 79 ; 83 ; 89 ; 97$.
]

#v(3cm)

// ==========================================================
// PUISSANCES
// ==========================================================

#sous_titre[
Les puissances
]

#v(0.15cm)

#definition[
Pour tout entier naturel $a$ et tout entier naturel non nul $n$, la puissance $a^n$ désigne le produit de $n$ facteurs égaux à $a$ :

$a^n = a × a × a × ... × a$

avec $n$ facteurs égaux à $a$.

• Le nombre $a$ est appelé la #strong[base].

• Le nombre $n$ est appelé l'#strong[exposant].

• $a^n$ se lit « #strong[$a$ puissance $n$] » ou « #strong[$a$ exposant $n$] ».
]

#v(0.05cm)

#exemple[
Dans un ordinateur, certaines structures peuvent comporter plusieurs groupes identiques.

Mathématiquement, lorsqu'un même facteur apparaît plusieurs fois, on peut utiliser une puissance.

$2 × 2 × 2 = 2^3$

$4 × 4 × 4 = 4^3$

$8 × 8 = 8^2$

$10 × 10 × 10 × 10 = 10^4$
]

#v(0.25cm)

#retenir[
$2^3$ signifie que le facteur $2$ apparaît trois fois :

$2^3 = 2 × 2 × 2 = 8$.

La puissance permet donc d'écrire plus simplement une répétition du même facteur.
]

#v(8cm)

#exemple_resolu[
Dans une architecture informatique simplifiée, une structure possède $4$ groupes, chacun contenant $4$ sous-groupes, eux-mêmes contenant $4$ éléments.

Le nombre total d'éléments est :

$4 × 4 × 4 = 4^3$.

Ainsi :

$4^3 = 64$.

La puissance permet ici de représenter une organisation répétée à trois niveaux.
]

#v(0.4cm)

// ==========================================================
// PUISSANCES PARTICULIÈRES
// ==========================================================

#sous_sous_titre[
Puissances particulières
]

#v(0.15cm)

#definition[
• Pour tout entier naturel $a$ :

$a^1 = a$.

• Pour tout entier naturel non nul $a$ :

$a^0 = 1$.
]

#v(0.25cm)

#exemple[
$2^1 = 2$

$8^1 = 8$

$2^0 = 1$

$125^0 = 1$
]

#v(0.3cm)

#remarque[
Le cas $0^0$ n'est pas utilisé dans les calculs élémentaires.
]

#v(10cm)

// ==========================================================
// CALCULER UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Calculer une puissance
]

#v(0.15cm)

#exemple_resolu[
Un processeur effectue, dans une situation théorique, une opération répétée selon une structure comportant $2$ éléments à chacun de $4$ niveaux.

Le nombre total d'éléments dans cette structure est :

$2^4 = 2 × 2 × 2 × 2 = 16$.

De même :

$3^3 = 3 × 3 × 3 = 27$.

$5^2 = 5 × 5 = 25$.

$10^3 = 10 × 10 × 10 = 1#strong[000]$.
]

#v(0.3cm)

#exercice[
Complète :

1. Une structure informatique comporte $10$ éléments à chacun de $5$ niveaux. Écris cette quantité sous forme de puissance.

2. Une organisation comporte $6$ éléments répétés $3$ fois. Écris cette répétition sous forme de puissance.

3. Une structure comporte $9$ éléments répétés $2$ fois. Écris cette répétition sous forme de puissance.

4. Une organisation comporte $4$ éléments répétés $4$ fois. Écris cette répétition sous forme de puissance.
]

#v(0.25cm)

#exemple[
Pour une structure comportant $10$ éléments répétés à chacun de $5$ niveaux :

$10 × 10 × 10 × 10 × 10 = 10^5 = 1#strong[00000]$.
]

#v(4cm)

// ==========================================================
// PRODUIT DE PUISSANCES
// ==========================================================

#sous_sous_titre[
Produit de puissances de même base
]

#v(0.05cm)

#retenir[
Pour multiplier des puissances de même base, on conserve la base et on additionne les exposants :

$a^n × a^m = a^(n+m)$.
]

#v(0.05cm)

#exemple[
Une organisation informatique possède une structure répétée $2^3$ fois dans une première partie et $2^2$ fois dans une seconde partie.

Le produit correspondant est :

$2^3 × 2^2 = 2^(3+2) = 2^5$.

Ainsi :

$2^3 × 2^2 = 32$.

La règle permet de regrouper une même base répétée dans plusieurs facteurs.
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
Pour deux entiers naturels $a$ et $b$ et un entier naturel $n$, on a :

#strong[$(a × b)^n = a^n × b^n$.]
]

#v(0.05cm)

#exemple[
Supposons qu'une structure informatique possède $2$ groupes de $3$ éléments, et que cette même organisation soit répétée $2$ fois.

On peut écrire :
$(2 × 3)^2 = 6^2$.

D'autre part :
$2^2 × 3^2 = 4 × 9 = 36$.

Donc :
$(2 × 3)^2 = 2^2 × 3^2 = 36$.

Cette écriture permet de distinguer les deux facteurs qui composent la structure.
]

#v(0.05cm)

// ==========================================================
// PUISSANCE D'UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Puissance d'une puissance
]

#retenir[
Pour élever une puissance à une autre puissance, on conserve la base et on multiplie les exposants :
#strong[$(a^n)^m = a^(n × m)$.]
]

#v(0.05cm)

#exemple[
Une organisation informatique peut être décrite par une structure de $2^3$ éléments, elle-même répétée $2$ fois.

On obtient :
$(2^3)^2 = 2^(3×2) 
         = 2^6$.

Donc :
$(2^3)^2 = 64$.
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
Un système informatique simplifié utilise des groupes contenant $2^2$ éléments.

Calculons :
$3 × 2^2$.

On calcule d'abord la puissance :

$2^2 = 4$.

Donc :
$3 × 2^2 = 3 × 4 = 12$.

La structure contient donc $12$ éléments.

#v(0.05cm)

Une autre organisation comporte $5^2$ éléments auxquels on ajoute une unité.

$5^2 = 25$.

Donc :
$1 + 5^2 = 1 + 25 = 26$.

#v(0.05cm)

Enfin, considérons une structure composée de $2$ groupes contenant chacun $3$ éléments, le tout répété selon une organisation carrée :

$(2 + 3)^2$.

On calcule d'abord ce qui est entre parenthèses :

$2 + 3 = 5$.

Donc :
$(2 + 3)^2 = 5^2 = 25$.
]

#v(0.05cm)

// ==========================================================
// RÈGLE DE PRIORITÉ
// ==========================================================

#sous_sous_titre[
Priorité des puissances
]

#v(0.05cm)

#retenir[
Dans une suite d'opérations sans parenthèses, les puissances sont prioritaires sur les multiplications, les divisions, les additions et les soustractions.

Lorsque des parenthèses sont présentes, on effectue d'abord les calculs entre parenthèses.
]

#v(0.05cm)

#exemple[
Un système traite $3$ groupes supplémentaires après avoir construit $2^3$ éléments dans chacun des $4$ ensembles.

On calcule :
$3 + 2^3 × 4$.

D'abord :
$2^3 = 8$.

Puis :
$8 × 4 = 32$.

Enfin :
$3 + 32 = 35$.

Donc :
$3 + 2^3 × 4 = 35$.
]

#v(0.05cm)

// ==========================================================
// PUISSANCES ET DÉCOMPOSITION EN FACTEURS PREMIERS
// ==========================================================

#sous_sous_titre[
Puissances et facteurs premiers
]

#v(0.05cm)

#exemple_resolu[
Un ordinateur dispose, dans une représentation théorique, de $120$ unités de stockage réparties selon plusieurs facteurs.

Décomposons $120$ en produit de facteurs premiers.

#decomposition-premiers((
  ("120", "60"),
  ("60", "2"),
  ("30", "2"),
  ("15", "3"),
  ("5", "5"),
  ("1", ""),
))

On obtient :

$120 = 2 × 2 × 2 × 3 × 5$.

Les facteurs $2$ apparaissent trois fois.

On peut donc utiliser une puissance :

$2 × 2 × 2 = 2^3$.

Ainsi :
$120 = 2^3 × 3 × 5$.

Cette écriture permet de voir immédiatement quels facteurs premiers composent la quantité $120$ et lesquels sont répétés.
]

#v(0.25cm)

#retenir[
Les puissances permettent d'écrire plus simplement les facteurs premiers qui se répètent dans une décomposition.

Par exemple :

#decomposition-premiers((
  ("72", "2"),
  ("36", "2"),
  ("18", "2"),
  ("9", "3"),
  ("3", "3"),
  ("1", ""),
))

$72 = 2 × 2 × 2 × 3 × 3$

Donc :
$72 = 2^3 × 3^2$.

Cette écriture sera particulièrement utile pour déterminer le #strong[PPCM] et le #strong[PGCD] de quantités utilisées dans l'organisation d'un système informatique.
]

#v(0.05cm)

// ==========================================================
// EXERCICE D'APPLICATION
// ==========================================================

#exercice_resolu[

#mission[
🧠 Application — Les puissances dans l'organisation d'un ordinateur
]

#v(0.05cm)

#text(
weight:"bold",
)[
1. Identifier une organisation répétitive
]

Une architecture informatique simplifiée comporte une structure dans laquelle le nombre $2$ apparaît comme facteur à quatre niveaux.

Écris cette répétition sous forme de puissance puis calcule le nombre obtenu.

#v(0.1cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On a :
$2 × 2 × 2 × 2 = 2^4$.
Donc :
$2^4 = 16$.

La structure contient donc $16$ éléments dans cette représentation.

#v(0.05cm)

#text(
weight:"bold",
)[
2. Comparer deux organisations
]

Deux architectures simplifiées utilisent respectivement :

$2^5$ éléments et $3^3$ éléments.
Calcule chacune de ces quantités puis indique laquelle est la plus grande.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

$2^5 = 32$ et
$3^3 = 27$.
Donc :
$32 > 27$.

La première organisation contient davantage d'éléments dans cette représentation.

#v(0.05cm)

#text(
weight:"bold",
)[
3. Regrouper des facteurs identiques
]

Une architecture informatique simplifiée est représentée par :
$2^3 × 2^2$.

Réduis cette expression à l'aide de la règle du produit de puissances de même base.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

$2^3 × 2^2 = 2^(3+2)$.
Donc :
$2^3 × 2^2 = 2^5 = 32$.

#v(0.25cm)

#text(
weight:"bold",
)[
4. Décomposer une quantité informatique
]

Une mémoire théorique contient $180$ unités.

Décompose $180$ en produit de facteurs premiers en utilisant les puissances.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On a :

#decomposition-premiers((
  ("180", "2"),
  ("90", "2"),
  ("45", "3"),
  ("15", "3"),
  ("5", "5"),
  ("1", ""),
))
$180 = 2 × 2 × 3 × 3 × 5$.

Donc :
$180 = 2^2 × 3^2 × 5$.

Cette écriture montre que $2$ et $3$ sont les facteurs qui se répètent dans la composition de $180$.

]

#v(8cm)

// ==========================================================
// PPCM
// ==========================================================

#sous_titre[
Le plus petit multiple commun — PPCM
]

#v(0.05cm)

#definition[
Le #strong[PPCM] de deux entiers naturels non nuls est le plus petit entier naturel non nul qui est à la fois multiple de ces deux nombres.
]

#v(0.05cm)

#exemple_resolu[
Dans un système informatique simplifié, deux processus effectuent respectivement une opération toutes les $12$ unités de temps et toutes les $18$ unités de temps.

Cherchons le premier instant, après le départ, où les deux opérations auront lieu simultanément.

Les multiples non nuls de $12$ sont :

$12 ; 24 ; 36 ; 48 ; 60 ; 72 ; ...$

Les multiples non nuls de $18$ sont :

$18 ; 36 ; 54 ; 72 ; 90 ; ...$

Les multiples communs sont notamment :
$36 ; 72 ; ...$
Le plus petit est $36$.
Donc :
#strong[PPCM(12 ; 18) = 36].

Les deux processus se retrouveront donc simultanément au bout de $36$ unités de temps.
]

#v(0.05cm)

#remarque[
Le PPCM permet ainsi de rechercher le #strong[premier moment où deux cycles se retrouvent ensemble].

Dans notre exemple :

$36 = 12 × 3$
et
$36 = 18 × 2$.

Ainsi, $36$ est à la fois un multiple de $12$ et de $18$.
]

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Une autre stratégie
]

#v(0.05cm)

Lorsque les nombres deviennent plus grands, écrire leurs multiples peut devenir long.

On peut alors utiliser leur #strong[décomposition en produit de facteurs premiers].

On a :
$12 = 2^2 × 3$
et
$18 = 2 × 3^2$.

Pour obtenir le PPCM, on prend #strong[tous les facteurs premiers présents dans les deux décompositions], chacun étant affecté de #strong[son plus grand exposant].

Ainsi :

$#strong[PPCM(12 ; 18) = $2^2$ × $3^2$]$

$#strong[PPCM(12 ; 18) = 36]$.

#v(0.05cm)

#retenir[
#strong[Pour déterminer le PPCM à l'aide des facteurs premiers :]

On prend tous les facteurs premiers présents dans les décompositions et on affecte chacun de son #strong[plus grand exposant].

Le PPCM est particulièrement utile lorsqu'on cherche le #strong[premier moment où plusieurs cycles ou répétitions coïncident].
]

#v(0.05cm)

// ==========================================================
// PGCD
// ==========================================================

#sous_titre[
Le plus grand diviseur commun — PGCD
]

#v(0.15cm)

#definition[
Le #strong[PGCD] de deux entiers naturels non nuls est le plus grand entier naturel qui est à la fois diviseur de ces deux nombres.
]

#v(0.05cm)

#exemple_resolu[
Un technicien dispose de $12$ modules électroniques d'un type et de $18$ modules d'un autre type.

Il souhaite former le #strong[plus grand nombre possible de lots identiques], sans laisser aucun module de côté.

L'ensemble des diviseurs de $12$ est 

{1 ; 2 ; 3 ; 4 ; 6 ; 12}.

L'ensemble des diviseurs de $18$ est 

{1 ; 2 ; 3 ; 6 ; 9 ; 18}.

L'ensemble des diviseurs communs est :

{1 ; 2 ; 3 ; 6}.

Le plus grand est $6$.

Donc :
#strong[PGCD(12 ; 18) = 6].

Le technicien peut former $6$ lots identiques.

Chaque lot contiendra :

$12 ÷ 6 = 2$
modules du premier type et :

$18 ÷ 6 = 3$
modules du second type.
]

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Une autre stratégie
]

#v(0.05cm)

Lorsque les nombres deviennent plus grands, rechercher tous leurs diviseurs peut devenir long.

On peut alors utiliser leur #strong[décomposition en produit de facteurs premiers].

On a :
$12 = 2^2 × 3$
et
$18 = 2 × 3^2$.

Pour obtenir le PGCD, on conserve #strong[uniquement les facteurs premiers communs], chacun étant affecté de #strong[son plus petit exposant].
Ainsi :
#strong[PGCD(12 ; 18) = 2 × 3]
et
#strong[PGCD(12 ; 18) = 6].

#v(0.25cm)

#retenir[
#strong[Pour déterminer le PGCD à l'aide des facteurs premiers :]

On conserve uniquement les facteurs premiers communs aux deux décompositions et on affecte chacun de son #strong[plus petit exposant].

Le PGCD est particulièrement utile lorsqu'on cherche à #strong[répartir plusieurs quantités en groupes identiques sans reste].
]

#v(1.5cm)

// ==========================================================
// RÉINVESTISSEMENT — ARCHITECTURE D'UN ORDINATEUR
// ==========================================================

#exemple_resolu[

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
💻 Réinvestissement — Organiser les composants d'un ordinateur
]

#v(0.05cm)

Un laboratoire dispose de $168$ modules électroniques d'un premier type et de $120$ modules d'un second type.

Les techniciens souhaitent utiliser ces modules pour construire des ensembles identiques destinés à plusieurs ordinateurs expérimentaux.

#v(0.05cm)

#text(
weight: "bold",
)[
1. Effectuer une division euclidienne
]

Les $168$ modules du premier type doivent être placés dans des boîtes contenant $12$ modules chacune.
Combien de boîtes complètes peut-on remplir ? Combien de modules restent-ils ?

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On effectue la division euclidienne de $168$ par $12$ :

$168 = 12 × 14 + 0$.
Le quotient est $14$ et le reste est $0$.

On peut donc remplir #strong[14 boîtes complètes] et il ne reste #strong[aucun module].

Cette division permet au technicien de vérifier que la quantité de modules peut être répartie exactement par groupes de $12$.

#v(0.05cm)

#text(
weight: "bold",
)[
2. Rechercher les diviseurs
]

On souhaite maintenant connaître toutes les tailles de groupes permettant de répartir exactement les $168$ modules du premier type.

Détermine l'ensemble des diviseurs de $168$.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On recherche les produits donnant $168$ :

$168 = 1 × 168$

$168 = 2 × 84$

$168 = 3 × 56$

$168 = 4 × 42$

$168 = 6 × 28$

$168 = 7 × 24$

$168 = 8 × 21$

$168 = 12 × 14$.

Donc :
L'ensemble des diviseurs de $168$ est 

{1 ; 2 ; 3 ; 4 ; 6 ; 7 ; 8 ; 12 ; 14 ; 21 ; 24 ; 28 ; 42 ; 56 ; 84 ; 168}.

Ces nombres représentent toutes les tailles de groupes possibles pour répartir exactement les $168$ modules.

#v(0.05cm)

#text(
weight: "bold",
)[
3. Rechercher les diviseurs communs
]

Les techniciens disposent également de $120$ modules du second type.

Détermine les diviseurs communs à $168$ et $120$.

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

L'ensemble des diviseurs de $120$ est 

{1 ; 2 ; 3 ; 4 ; 5 ; 6 ; 8 ; 10 ; 12 ; 15 ; 20 ; 24 ; 30 ; 40 ; 60 ; 120}.

L'ensemble des diviseurs communs est 

{1 ; 2 ; 3 ; 4 ; 6 ; 8 ; 12 ; 24}.

Le plus grand est $24$.

Donc :
#strong[PGCD(168 ; 120) = 24].

#v(0.05cm)

#text(
weight: "bold",
)[
4. Construire le plus grand nombre d'ensembles identiques
]

Les techniciens veulent construire le #strong[plus grand nombre possible d'ensembles identiques], chaque ensemble devant recevoir le même nombre de modules du premier type et le même nombre de modules du second type.

Combien d'ensembles peuvent-ils construire ?

Combien de modules de chaque type chaque ensemble recevra-t-il ?

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

Le nombre maximal d'ensembles identiques correspond au PGCD de $168$ et $120$.

On a :
#strong[PGCD(168 ; 120) = 24].

Les techniciens peuvent donc construire #strong[24 ensembles identiques].

Pour le premier type :
$168 ÷ 24 = 7$.

Pour le second type :
$120 ÷ 24 = 5$.

Chaque ensemble recevra donc :

#strong[$7$ modules du premier type et $5$ modules du second type].

Le PGCD permet ainsi de déterminer une organisation dans laquelle #strong[aucun module n'est laissé de côté et tous les ensembles sont identiques].

#v(0.05cm)

#text(
weight: "bold",
)[
5. Vérifier avec l'algorithme d'Euclide
]

Retrouve le #strong[PGCD(168 ; 120)] en utilisant des divisions euclidiennes successives.

#v(0.05cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On effectue des divisions euclidiennes successives :

$168 = 120 × 1 + 48$

$120 = 48 × 2 + 24$

$48 = 24 × 2 + 0$.

Le dernier reste non nul est $24$.

Donc :
#strong[PGCD(168 ; 120) = 24].

#v(0.05cm)

#text(
weight: "bold",
)[
6. Vérifier avec la décomposition en facteurs premiers
]

Détermine le #strong[PGCD(168 ; 120)] à l'aide de la décomposition en produit de facteurs premiers.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On utilise :

$168 = 2^3 × 3 × 7$
et
$120 = 2^3 × 3 × 5$.

Les facteurs premiers communs sont $2$ et $3$.

On conserve le plus petit exposant pour chacun :

#strong[PGCD(168 ; 120) = $2^3$ × 3].

Donc :
#strong[PGCD(168 ; 120) = 24].

On retrouve bien le même résultat.

#v(0.35cm)

#text(
weight: "bold",
)[
7. Rechercher une synchronisation entre deux composants
]

Deux composants électroniques effectuent une opération répétitive.

Le premier effectue une opération toutes les $12$ unités de temps et le second toutes les $18$ unités de temps.

Après combien d'unités de temps effectueront-ils à nouveau leur opération simultanément ?

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

On cherche le PPCM de $12$ et $18$.

On a :

$12 = 2^2 × 3$
et
$18 = 2 × 3^2$.

Pour le PPCM, on prend tous les facteurs premiers avec leur plus grand exposant :

#strong[PPCM(12 ; 18) = $2^2 × 3^2$].

Donc :
#strong[PPCM(12 ; 18) = 36].

Les deux composants effectueront donc à nouveau leur opération simultanément après #strong[36 unités de temps].

#v(2cm)

#text(
weight: "bold",
)[
8. Interpréter les deux notions dans l'ordinateur
]

Explique dans chacun des cas si tu dois utiliser plutôt le PGCD ou le PPCM :

a) Répartir deux quantités de composants en un nombre maximal d'ensembles identiques sans reste.

b) Trouver le premier moment où deux composants ayant des cycles différents effectuent à nouveau une opération simultanément.

#v(0.12cm)

#text(
weight: "bold",
fill: code-blue,
)[
Solution
]

a) Il faut utiliser le #strong[PGCD], car on recherche le plus grand nombre de groupes identiques permettant de répartir exactement les deux quantités.

b) Il faut utiliser le #strong[PPCM], car on recherche le plus petit moment commun auquel les deux cycles se retrouvent simultanément.



]


#v(0.05cm)
#retenir[



Pour analyser certaines organisations informatiques, je peux :

#v(0.05cm)

🔎 rechercher les multiples pour étudier des quantités répétées ;

#v(0.05cm)

🧩 rechercher les diviseurs pour trouver des répartitions exactes ;

#v(0.05cm)

🧮 utiliser la division euclidienne pour savoir combien de groupes complets peuvent être formés et s'il reste des éléments ;

#v(0.05cm)

🔢 utiliser les puissances pour représenter des facteurs répétés ;

#v(0.05cm)

🧩 décomposer les nombres en facteurs premiers pour mieux analyser leur structure ;

#v(0.05cm)

🏆 utiliser le PGCD pour organiser plusieurs quantités en groupes identiques ;

#v(0.05cm)

🔄 utiliser le PPCM pour étudier la rencontre de plusieurs cycles.

]

]





#pagebreak()





























// ==========================================================
// PARCOURS 4e — PGCD ET PPCM
// ==========================================================


// ==========================================================
// TITRE DU PARCOURS
// ==========================================================

#parcours(
  [PARCOURS 4ᵉ — Le PGCD et le PPCM dans l'architecture et l'aménagement],
  "parcours-entiers-naturels-4e",
) <parcours-entiers-naturels-4e>


// ==========================================================
// ACTIVITÉ DE DÉCOUVERTE
// ==========================================================

#activite[

🏗️ #strong[L'architecture et l'aménagement : concevoir et organiser les espaces]

#v(0.12cm)

L'#strong[architecture] est un domaine qui consiste à concevoir,
organiser et réaliser des bâtiments et des espaces adaptés aux
besoins des personnes.

L'architecte imagine notamment la forme des bâtiments, organise
les différents espaces et réfléchit à leur utilisation.

Il peut concevoir :

• des maisons ;

• des immeubles ;

• des écoles ;

• des hôpitaux ;

• des bureaux ;

• des commerces ;

• des espaces culturels et sportifs ;

• des bâtiments industriels ou technologiques.

L'architecture ne consiste donc pas seulement à donner une belle
apparence à un bâtiment. Elle doit également prendre en compte
la #strong[fonctionnalité], la #strong[sécurité], la #strong[circulation],
le #strong[confort] et l'utilisation efficace de l'espace.

#v(0.05cm)

🏢 #strong[Qu'est-ce que l'aménagement ?]

L'#strong[aménagement] consiste à organiser et à disposer
convenablement les différents éléments d'un espace afin de le
rendre adapté à son utilisation.

Dans un bâtiment, l'aménagement peut concerner :

• la disposition des pièces ;

• l'organisation des espaces de circulation ;

• l'installation du mobilier ;

• le revêtement des sols et des murs ;

• l'organisation des équipements ;

• l'éclairage ;

• la décoration et l'aspect visuel des espaces.

Un bon aménagement doit donc être à la fois
#strong[pratique], #strong[fonctionnel] et #strong[adapté aux besoins].

]
#activite[

Dans certains projets modernes, l'architecte doit également
travailler avec des dimensions précises et choisir des matériaux
qui permettent de couvrir ou d'organiser les espaces sans gaspillage.

Par exemple, lorsqu'un sol doit être recouvert de carreaux carrés,
il est intéressant de choisir des carreaux dont les dimensions
permettent de couvrir exactement la surface sans devoir découper
les carreaux.

🏗️ #strong[Une situation d'aménagement]

Imaginons qu'un architecte prépare l'aménagement du sol d'un
bâtiment futuriste.

Dans une première partie du projet, il doit recouvrir entièrement
deux zones rectangulaires avec des carreaux carrés tous identiques,
sans découper aucun carreau.

La première zone mesure :

$51d m$ de longueur et $30d m$ de largeur.

La deuxième zone mesure :

$93d m$ de longueur et $30d m$ de largeur.

Pour obtenir un aménagement à la fois esthétique et pratique,
l'architecte souhaite utiliser #strong[les carreaux carrés les plus
grands possibles].

Il doit donc déterminer la longueur maximale du côté d'un carreau
qui permet de recouvrir exactement les deux zones, sans découper
aucun carreau.

#v(0.15cm)

Cette situation demande de rechercher une longueur qui puisse
#strong[diviser exactement] chacune des dimensions considérées.

L'architecte doit donc trouver une longueur commune aux différentes
dimensions, mais surtout la #strong[plus grande longueur possible].

#v(0.15cm)

💡 #strong[Une autre situation dans le même bâtiment]

L'aménagement d'un bâtiment ne concerne pas uniquement les
dimensions et les matériaux.

Les bâtiments modernes peuvent également comporter des systèmes
automatiques : éclairage, ventilation, signalisation, alarmes,
affichages numériques ou autres équipements.

Dans une autre partie du même bâtiment, deux installations
lumineuses fonctionnent automatiquement à intervalles réguliers.

La première installation se déclenche :

$#[toutes les] 12$ minutes.

La deuxième installation se déclenche :

$#[toutes les] 15$ minutes.

Le responsable du bâtiment souhaite savoir dans combien de temps
les deux installations se déclencheront de nouveau exactement
#strong[au même moment].

]
#activite[

Pour répondre à cette question, il faut rechercher un nombre de
minutes qui soit obtenu en répétant l'intervalle de la première
installation et également celui de la deuxième.

Il faut donc rechercher le #strong[plus petit multiple commun]
aux deux intervalles.

#v(0.05cm)

🔎 #strong[Deux problèmes, deux recherches]

Ces deux situations appartiennent au domaine de l'architecture
et de l'aménagement, mais elles conduisent à deux recherches
mathématiques différentes.

Dans la première situation, l'architecte cherche :

#strong[la plus grande longueur qui divise exactement plusieurs
dimensions.]

Dans la deuxième situation, le responsable cherche :

#strong[le plus petit nombre qui est un multiple de plusieurs
intervalles.]

#v(0.15cm)

En mathématiques, ces deux recherches portent des noms précis.

La première conduit au #strong[plus grand commun diviseur],
noté #strong[PGCD].

La deuxième conduit au #strong[plus petit commun multiple],
noté #strong[PPCM].

#v(0.18cm)

À partir de ces situations concrètes, tu vas apprendre à :

• reconnaître les situations dans lesquelles on recherche un
  #strong[diviseur commun] ;

• reconnaître les situations dans lesquelles on recherche un
  #strong[multiple commun] ;

• déterminer le #strong[PGCD] de deux ou plusieurs entiers naturels ;

• déterminer le #strong[PPCM] de deux ou plusieurs entiers naturels ;

• utiliser différentes méthodes de calcul ;

• résoudre des problèmes de dimensions et d'aménagement ;

• résoudre des problèmes de partage ;

• utiliser le PGCD et le PPCM dans des situations de synchronisation.

#v(0.15cm)

Ainsi, les mathématiques permettent à l'architecte et au responsable
du bâtiment de prendre des décisions précises pour organiser les
espaces, choisir les dimensions adaptées et synchroniser certains
équipements.

]

#v(0.4cm)

#align(center)[
  #image_full("architecture-4e.png")
]


// ==========================================================
// PARTIE A — LE PGCD
// ==========================================================

#deux-colonnes[

#sous_titre[
  Le plus grand commun diviseur
]


// ==========================================================
// 1. RECHERCHER UNE DIMENSION MAXIMALE
// ==========================================================

#sous_sous_titre[
Rechercher une dimension maximale
]

#v(0.05cm)

Le sol d'une salle mesure $51\d m$ sur $93\d m$.
On souhaite le recouvrir entièrement avec des carreaux
carrés identiques, sans découper aucun carreau.
La longueur du côté du carreau doit donc diviser exactement
$51$ et $93$.

On cherche la plus grande longueur possible.

#exemple[
Les diviseurs de $51$ sont :
$1 ; 3 ; 17 ; 51$.

Les diviseurs de $93$ sont :
$1 ; 3 ; 31 ; 93$.

Les diviseurs communs à $51$ et $93$ sont donc :

$1$ et $3$.

Le plus grand est $3$.
Ainsi :
#strong[PGCD(51;93)=3.]

Le côté maximal d'un carreau est donc de $3\d m$.
]


// ==========================================================
// 2. NOMBRE DE CARREAUX
// ==========================================================

#v(0.01cm)

#sous_sous_titre[
Déterminer le nombre de carreaux
]

#v(0.05cm)

Le sol mesure $51\d m$ sur $93\d m$ et chaque carreau possède
un côté de $3\d m$.

Dans le sens de la longueur, il faut :

$51 ÷ 3 = 17$ carreaux.

Dans le sens de la largeur, il faut :

$93 ÷ 3 = 31$ carreaux.

Le nombre total de carreaux est donc :

#strong[N = 17 × 31.]
D'où :
#strong[$N = 527$.]

#retenir[
Pour carreler entièrement un rectangle avec des carrés identiques
de côté maximal, on recherche le #strong[PGCD des dimensions
du rectangle].
]


// ==========================================================
// 3. DÉFINITION DU PGCD
// ==========================================================

#v(2cm)

#sous_sous_titre[
Définition du PGCD
]

#v(0.05cm)

On appelle #strong[plus grand commun diviseur], ou #strong[PGCD],
de deux ou plusieurs entiers naturels non tous nuls, le plus grand
entier naturel qui divise chacun de ces nombres.

On note :
#strong[PGCD(a;b)]
pour le PGCD de $a$ et $b$.

Par exemple :
#strong[PGCD(18;24)=6]

car $6$ est le plus grand entier qui divise à la fois
$18$ et $24$.

#remarque[
Le PGCD peut être déterminé pour deux, trois ou plusieurs
entiers naturels, à condition qu'ils ne soient pas tous nuls.
]


// ==========================================================
// 4. PREMIÈRE MÉTHODE — RECHERCHE DES DIVISEURS
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Première méthode : rechercher les diviseurs communs
]

#v(0.05cm)

Pour déterminer le PGCD de deux nombres, on peut rechercher
leurs diviseurs.

#exemple[
Déterminons :
#strong[PGCD(36;48).]

Les diviseurs de $36$ sont :
$1 ; 2 ; 3 ; 4 ; 6 ; 9 ; 12 ; 18 ; 36$.

Les diviseurs de $48$ sont :
$1 ; 2 ; 3 ; 4 ; 6 ; 8 ; 12 ; 16 ; 24 ; 48$.

Les diviseurs communs sont :
$1 ; 2 ; 3 ; 4 ; 6 ; 12$.

Le plus grand est $12$.

Donc :
#strong[PGCD(36;48)=12.]
]

#remarque[
Cette méthode est particulièrement pratique lorsque les nombres
sont relativement petits.

Pour des nombres plus grands, d'autres méthodes sont souvent
plus efficaces.
]


// ==========================================================
// 5. DEUXIÈME MÉTHODE — ALGORITHME D'EUCLIDE
// ==========================================================

#v(4cm)

#sous_sous_titre[
Deuxième méthode : divisions euclidiennes successives
]

#v(0.05cm)

On peut déterminer le PGCD de deux nombres en effectuant
des divisions euclidiennes successives.
On divise le plus grand nombre par le plus petit, puis le
diviseur par le reste obtenu, et ainsi de suite jusqu'à
obtenir un reste nul.
Le #strong[dernier reste non nul] est alors le PGCD des deux nombres.

#exemple[
Déterminons :
$#strong[PGCD(126;84).]$

On effectue les divisions euclidiennes successives :

$126 = 84 × 1 + 42$
et
$84 = 42 × 2 + 0$.

Le dernier reste non nul est $42$.

Donc 
$#strong[PGCD(126;84)=42.]$
]

#retenir[
Dans l'algorithme d'Euclide, le #strong[dernier reste non nul]
est le PGCD des deux nombres.
]


// ==========================================================
// 6. TROISIÈME MÉTHODE — FACTEURS PREMIERS
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Troisième méthode : décomposition en facteurs premiers
]

#v(0.05cm)

On peut également déterminer le PGCD à partir des
décompositions en facteurs premiers.

Pour cela :

• on décompose chaque nombre en produit de facteurs premiers ;

• on conserve uniquement les facteurs premiers communs ;

• pour chaque facteur commun, on choisit le plus petit exposant ;

• on multiplie les facteurs ainsi obtenus.

#exemple[
Déterminons :
$#strong[PGCD(180;252).]$

On décompose les deux nombres :

#v(1cm)
#decomposition-premiers((
  ("180", "2"),
  ("90", "2"),
  ("45", "3"),
  ("15", "3"),
  ("5", "5"),
  ("1", ""),
))

On obtient alors

#strong[180 = $2^2 × 3^2 × 5$]

#decomposition-premiers((
  ("252", "2"),
  ("126", "2"),
  ("63", "3"),
  ("21", "3"),
  ("7", "7"),
  ("1", ""),
))

On obtient alors

#strong[252 = $2^2 × 3^2 × 7$]

Les facteurs premiers communs sont $2$ et $3$.

On choisit le plus petit exposant de chacun :

#strong[PGCD(180;252)=$2^2 × 3^2$].

Donc :
#strong[PGCD(180;252)=36.]
]


// ==========================================================
// 7. CAS DE PLUSIEURS NOMBRES
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Déterminer le PGCD de plusieurs nombres
]

#v(0.05cm)

La méthode par décomposition en facteurs premiers peut
également être utilisée pour trois nombres ou davantage.

#exemple[
Déterminons :
#strong[PGCD(90;75;60).]

On décompose :

$90 = 2 × 3^2 × 5$

$75 = 3 × 5^2$

$60 = 2^2 × 3 × 5$

Les facteurs premiers communs aux trois décompositions
sont $3$ et $5$.

On choisit les plus petits exposants :

$3^1$ et $5^1$.
Ainsi :
#strong[PGCD(90;75;60)=3 × 5]

Donc :
#strong[PGCD(90;75;60)=15.]
]


// ==========================================================
// 8. APPLICATION — FABRICATION DE SAVONS
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Utiliser le PGCD dans un problème de rangement
]

#v(0.05cm)

Une entreprise fabrique des savons cubiques.

Elle souhaite ranger les savons dans des cartons
parallélépipédiques de dimensions :

$90\c m$, $75\c m$ et $60\c m$.

Elle souhaite que les savons soient cubiques, qu'ils aient
tous la même arête et qu'aucun espace ne reste entre les savons.

La longueur maximale de l'arête d'un savon est :

#strong[a = PGCD(90;75;60)].

Or :
#strong[PGCD(90;75;60)=15].

Donc :
#strong[$a=15\c m$.]

Le nombre de savons nécessaires pour remplir un carton est :

#strong[N = $90/15 × 75/15 × 60/15$]

D'où :
$#strong[N=6 × 5 × 4]$
et 
#strong[$N=120$.]

#retenir[
Dans les problèmes de découpage, de pavage, de rangement
ou de constitution de blocs identiques sans reste, le PGCD
permet souvent de déterminer la #strong[plus grande dimension
commune possible].
]


// ==========================================================
// 9. UTILISER LE PGCD POUR SIMPLIFIER UNE FRACTION
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Simplifier une fraction grâce au PGCD
]

#v(0.05cm)

Pour simplifier une fraction, on peut diviser son numérateur
et son dénominateur par leur PGCD.

#exemple[
Simplifions : $45/75$

On cherche :
$#strong[PGCD(45;75)=15]$.

On divise le numérateur et le dénominateur par $15$ :

$45/75 = (45÷15) / (75÷15)$
     $ = 3/5$

Donc 
#strong[$45/75 = 3/5.$]
]


// ==========================================================
// À RETENIR — PGCD
// ==========================================================

#v(0.45cm)



#retenir[


Le PGCD de plusieurs entiers naturels est leur plus grand
diviseur commun.

Pour le déterminer, on peut :

• rechercher les diviseurs communs ;

• utiliser l'algorithme d'Euclide ;

• décomposer les nombres en facteurs premiers.

Avec les décompositions en facteurs premiers, le PGCD est obtenu
en prenant les facteurs premiers communs avec leurs
#strong[plus petits exposants].

Le PGCD est notamment utile pour :

• découper ou carreler sans reste ;

• déterminer une dimension maximale commune ;

• constituer des groupes identiques ;

• simplifier des fractions.

]





// ==========================================================
// PARTIE B — LE PPCM
// ==========================================================

#sous_titre[
  Le plus petit commun multiple
]


// ==========================================================
// 10. RECHERCHER UN MOMENT DE SYNCHRONISATION
// ==========================================================

#sous_sous_titre[
Rechercher un moment commun
]

#v(0.15cm)

Dans un bâtiment moderne, plusieurs équipements peuvent
fonctionner automatiquement à intervalles réguliers.

Par exemple, deux installations lumineuses sont programmées
pour se déclencher périodiquement.

La première se déclenche toutes les $12$ minutes.

La deuxième se déclenche toutes les $15$ minutes.

Les deux installations viennent de fonctionner ensemble.

Le responsable souhaite savoir dans combien de temps elles
se déclencheront de nouveau simultanément.
#v(2cm)
#exemple[
Les instants de déclenchement de la première installation,
exprimés en minutes, sont les multiples de $12$ :

$12 ; 24 ; 36 ; 48 ; 60 ; 72 ; ...$

Les instants de déclenchement de la deuxième installation
sont les multiples de $15$ :

$15 ; 30 ; 45 ; 60 ; 75 ; 90 ; ...$

Le premier nombre qui apparaît dans les deux listes est :
$60$.

Donc les deux installations se déclencheront de nouveau
ensemble après :
#strong[$60$ minutes.]

On a donc :
#strong[PPCM(12;15)=60.]
]


// ==========================================================
// 11. DÉFINITION DU PPCM
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Définition du PPCM
]

#v(0.05cm)

On appelle #strong[plus petit commun multiple], ou #strong[PPCM],
de deux ou plusieurs entiers naturels non nuls, le plus petit
entier naturel non nul qui est un multiple de chacun de ces nombres.

On note :

#strong[PPCM(a;b)]

pour le PPCM de $a$ et $b$.

#exemple[
Déterminons :
#strong[PPCM(6;8).]

Les multiples de $6$ sont :

$6 ; 12 ; 18 ; 24 ; 30 ; 36 ; ...$

Les multiples de $8$ sont :

$8 ; 16 ; 24 ; 32 ; 40 ; ...$

Le premier multiple commun non nul est $24$.

Donc :
#strong[PPCM(6;8)=24.]
]

#remarque[
Le PPCM est toujours un entier naturel non nul.

Il peut être déterminé pour deux, trois ou plusieurs
entiers naturels non nuls.
]


// ==========================================================
// 12. PREMIÈRE MÉTHODE — RECHERCHE DES MULTIPLES
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Première méthode : rechercher les multiples communs
]

#v(0.15cm)

Pour déterminer le PPCM de deux nombres, on peut écrire
leurs premiers multiples et rechercher le premier multiple
commun non nul.

#exemple[
Déterminons :

#strong[PPCM(9;12).]

Les multiples de $9$ sont :

$9 ; 18 ; 27 ; 36 ; 45 ; 54 ; ...$

Les multiples de $12$ sont :

$12 ; 24 ; 36 ; 48 ; 60 ; ...$

Le premier multiple commun non nul est $36$.

Donc :

#strong[PPCM(9;12)=36.]
]

#remarque[
Cette méthode est pratique lorsque les nombres sont relativement
petits.

Lorsque les nombres sont plus grands, la décomposition en
facteurs premiers permet souvent de déterminer plus rapidement
le PPCM.
]


// ==========================================================
// 13. DEUXIÈME MÉTHODE — FACTEURS PREMIERS
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Deuxième méthode : décomposition en facteurs premiers
]

#v(0.15cm)

On peut déterminer le PPCM à partir des décompositions
en facteurs premiers.

Pour cela :

• on décompose chaque nombre en produit de facteurs premiers ;

• on retient tous les facteurs premiers présents dans les
  décompositions ;

• pour chaque facteur premier, on choisit le plus grand exposant ;

• on multiplie les facteurs ainsi obtenus.

#exemple[
Déterminons :

#strong[PPCM(36;48).]

On décompose les deux nombres :

#strong[36 = $2^2 × 3^2$]

#strong[48 = $2^4 × 3$]

Les facteurs premiers présents sont $2$ et $3$.

Pour obtenir le PPCM, on choisit le plus grand exposant
de chaque facteur :

$2^4$ et $3^2$.

Ainsi :
#strong[PPCM(36;48)=$2^4 × 3^2$]

Donc :
#strong[PPCM(36;48)=144.]
]


// ==========================================================
// 14. COMPARAISON ENTRE PGCD ET PPCM
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
PGCD et PPCM : deux recherches différentes
]

#v(0.15cm)

Le PGCD et le PPCM utilisent tous les deux les notions
de #strong[diviseur] et de #strong[multiple], mais ils répondent
à des questions différentes.

#exemple[
Considérons les nombres $12$ et $18$.

Pour le PGCD, on recherche le plus grand nombre qui divise
exactement $12$ et $18$ :

#strong[PGCD(12;18)=6.]

Pour le PPCM, on recherche le plus petit nombre non nul qui
est un multiple de $12$ et de $18$ :

#strong[PPCM(12;18)=36.]
]

#retenir[
Pour ne pas confondre :

• le #strong[PGCD] recherche le #strong[plus grand diviseur commun] ;

• le #strong[PPCM] recherche le #strong[plus petit multiple commun].
]


// ==========================================================
// 15. APPLICATION — SYNCHRONISATION DES ÉQUIPEMENTS
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Utiliser le PPCM pour synchroniser des équipements
]

#v(0.15cm)

Dans un bâtiment intelligent, trois systèmes automatiques
fonctionnent régulièrement :

• l'éclairage se déclenche toutes les $12$ minutes ;

• la ventilation se déclenche toutes les $18$ minutes ;

• un système de contrôle se déclenche toutes les $30$ minutes.

Les trois systèmes viennent de fonctionner ensemble.

Le responsable souhaite déterminer dans combien de temps
ils fonctionneront de nouveau simultanément.

#exemple[
Il faut rechercher le plus petit nombre de minutes qui soit
un multiple de $12$, de $18$ et de $30$.

On cherche donc :
#strong[PPCM(12;18;30).]

Les décompositions sont :

$12 = 2^2 × 3$

$18 = 2 × 3^2$

$30 = 2 × 3 × 5$

On prend chaque facteur premier avec son plus grand exposant :
$2^2$, $3^2$ et $5$.

Ainsi :
$P P C M(12;18;30)=2^2 × 3^2 × 5$

$P P C M(12;18;30)=4 × 9 × 5$
$=180$.
Les trois systèmes fonctionneront donc de nouveau ensemble
après :
#strong[$180$ minutes], soit $3$ heures.
]


// ==========================================================
// 16. APPLICATION — ORGANISATION D'UN ÉVÉNEMENT
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Utiliser le PPCM pour organiser des répétitions
]

#v(0.05cm)

Dans un centre culturel, trois activités sont organisées
à intervalles réguliers.
Une activité est répétée toutes les $8$ minutes,
une deuxième toutes les $12$ minutes et une troisième
toutes les $20$ minutes.
Les trois activités commencent simultanément.
Le responsable souhaite savoir quand elles recommenceront
ensemble.

#exemple[
Il faut calculer :

#strong[PPCM(8;12;20).]

On décompose :

$8 = 2^3$

$12 = 2^2 × 3$

$20 = 2^2 × 5$

On prend les plus grands exposants :

$2^3$, $3$ et $5$.

Donc :

$P P C M(8;12;20)=2^3 × 3 × 5$

$P P C M(8;12;20)=8 × 3 × 5$

$P P C M(8;12;20)=120$.

Les trois activités recommenceront donc ensemble
après $120$ minutes, soit $2$ heures.
]


// ==========================================================
// 17. RELATION ENTRE PGCD ET PPCM
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Une relation importante entre le PGCD et le PPCM
]

#v(0.05cm)

Pour deux entiers naturels non nuls $a$ et $b$, on a :

#strong[
$P G C D(a;b) × P P C M(a;b) = a × b$.
]

Cette relation permet notamment de retrouver le PPCM
lorsque le PGCD est connu.

#exemple[
On connaît :
$P G C D(18;24)=6$.

On cherche $P P C M(18;24)$.

On utilise :

$P G C D(18;24) × P P C M(18;24)=18 × 24$.

Donc :
$6 × P P C M(18;24)=432$.

Ainsi :

$P P C M(18;24)=432 ÷ 6$

$P P C M(18;24)=72$.

Donc :
#strong[PPCM(18;24)=72.]
]
#v(1cm)
#remarque[
Cette relation concerne deux nombres naturels non nuls.
Elle constitue une méthode supplémentaire pour déterminer
le PPCM.
]


// ==========================================================
// 18. APPLICATION — CYCLES D'ENTRETIEN
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Utiliser le PPCM pour prévoir une intervention commune
]

#v(0.15cm)

Dans un bâtiment, deux équipements doivent être contrôlés
régulièrement.

Le premier est contrôlé tous les $20$ jours.

Le second est contrôlé tous les $30$ jours.

Les deux équipements viennent d'être contrôlés le même jour.

Le responsable souhaite savoir après combien de jours
ils seront de nouveau contrôlés le même jour.

#exemple[
Il faut déterminer :
#strong[PPCM(20;30).]

On décompose :

$20 = 2^2 × 5$
et
$30 = 2 × 3 × 5$

On choisit les plus grands exposants :
$2^2$, $3$ et $5$.

Donc :

$P P C M(20;30)=2^2 × 3 × 5$

$P P C M(20;30)=60$.

Les deux équipements seront donc de nouveau contrôlés
ensemble après :
#strong[60 jours.]
]


// ==========================================================
// 19. EXERCICE — RECONNAÎTRE PGCD OU PPCM
// ==========================================================

#v(8cm)

#sous_sous_titre[
Reconnaître s'il faut utiliser le PGCD ou le PPCM
]

#v(0.05cm)

#exercice[
Pour chaque situation, indique s'il faut utiliser le
#strong[PGCD] ou le #strong[PPCM].

1. Un architecte souhaite découper deux longueurs de
   $48d m$ et $72d m$ en morceaux de même longueur,
   aussi grands que possible.

2. Deux lampes clignotent respectivement toutes les
   $8$ secondes et toutes les $12$ secondes.
   Elles viennent de clignoter ensemble.

3. Une entreprise souhaite répartir $84$ objets et
   $126$ objets en groupes identiques, avec le plus grand
   nombre d'objets possible dans chaque groupe.

4. Trois machines effectuent un cycle toutes les
   $6$, $10$ et $15$ minutes.
   On cherche le prochain moment où elles fonctionneront
   ensemble.

5. Un fabricant veut découper plusieurs barres en morceaux
   de même longueur, sans chute et avec des morceaux
   aussi longs que possible.
]


// ==========================================================
// 20. PROBLÈME DE SYNTHÈSE — ARCHITECTURE
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Problème de synthèse : aménager et synchroniser un bâtiment
]

#v(0.15cm)

#exercice[
🏗️ #strong[Projet — Le bâtiment intelligent]

Un architecte travaille sur l'aménagement d'un bâtiment
intelligent.

Une salle rectangulaire mesure $72d m$ sur $108d m$.

Il souhaite la recouvrir avec des carreaux carrés identiques,
sans découper aucun carreau, en utilisant les carreaux
les plus grands possibles.

1. Quel outil mathématique faut-il utiliser : PGCD ou PPCM ?

2. Calcule le côté du plus grand carreau possible.

3. Détermine le nombre de carreaux nécessaires.

Dans une autre partie du bâtiment, trois équipements
fonctionnent automatiquement :

• le système d'éclairage se déclenche toutes les $12$ minutes ;

• le système de ventilation toutes les $18$ minutes ;

• le système de signalisation toutes les $30$ minutes.

Les trois systèmes viennent de fonctionner ensemble.

4. Quel outil mathématique faut-il utiliser : PGCD ou PPCM ?

5. Dans combien de temps fonctionneront-ils de nouveau
   simultanément ?

6. Explique avec tes propres mots la différence entre
   une situation de PGCD et une situation de PPCM.
]


// ==========================================================
// 21. À RETENIR — PPCM
// ==========================================================

#v(0.45cm)


#retenir[
🎯 #strong[À retenir — PPCM]

Le PPCM de plusieurs entiers naturels non nuls est leur
#strong[plus petit multiple commun non nul].

Pour le déterminer, on peut :

• rechercher les multiples communs ;

• décomposer les nombres en facteurs premiers ;

• utiliser, pour deux nombres, la relation entre le PGCD
  et le PPCM.

Avec les décompositions en facteurs premiers, le PPCM est obtenu
en prenant #strong[tous les facteurs premiers présents] avec
leurs #strong[plus grands exposants].

Le PPCM est notamment utile pour :

• synchroniser des événements périodiques ;

• déterminer un moment commun ;

• organiser des cycles ;

• planifier des interventions répétées ;

• résoudre des problèmes de répétition et de synchronisation.
]


// ==========================================================
// 22. SYNTHÈSE — PGCD OU PPCM ?
// ==========================================================

#v(5cm)

#sous_titre[
Choisir entre le PGCD et le PPCM
]

#v(0.05cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

#strong[🔵 PGCD — chercher le plus grand]

On utilise généralement le PGCD lorsqu'il faut :

• partager ou découper en parties #strong[identiques] ;

• obtenir la #strong[plus grande dimension possible] ;

• éviter les chutes ou les restes ;

• constituer le plus grand groupe ou la plus grande unité
  commune.

Exemples :

• carreler une surface ;

• découper des longueurs ;

• répartir des objets en groupes identiques ;

• simplifier une fraction.


#v(0.18cm)

#strong[🟢 PPCM — chercher le plus petit]

On utilise généralement le PPCM lorsqu'il faut :

• trouver un #strong[moment commun] ;

• synchroniser plusieurs événements ;

• rechercher le #strong[plus petit nombre commun] ;

• déterminer quand plusieurs cycles se reproduiront
  simultanément.

#exemple[

• synchroniser des lampes ;

• faire fonctionner plusieurs machines ensemble ;

• planifier des contrôles périodiques ;

• organiser des événements répétitifs.
]
]


// ==========================================================
// FIN DE LA PARTIE B
// ==========================================================

#v(8cm)

#retenir[

#strong[Idée essentielle]

Le #strong[PGCD] et le #strong[PPCM] répondent à deux questions
différentes :

#v(0.1cm)

#strong[PGCD → « Quelle est la plus grande dimension commune ? »]

#v(0.08cm)

#strong[PPCM → « Quel est le plus petit moment ou nombre commun ? »]

Dans les problèmes d'architecture et d'aménagement :

• le PGCD intervient souvent lorsqu'on cherche à
  #strong[découper, carreler, partager ou organiser sans reste] ;

• le PPCM intervient souvent lorsqu'on cherche à
  #strong[synchroniser, répéter ou faire coïncider plusieurs cycles].

]



]
]

