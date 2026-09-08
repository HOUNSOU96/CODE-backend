#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let nombres_reels() = [

#debut_notion()
// ==========================================================
// TITRE DE LA NOTION
// ==========================================================
#pagebreak()



#title(
  [V — LES NOMBRES RÉELS],
  "notion-nombres-reels",
) <notion-nombres-reels>

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
🌍 Quand les nombres rationnels ne suffisent plus
]

Après avoir découvert les #strong[nombres rationnels], l'être humain disposait déjà d'un outil puissant pour représenter les #strong[partages, les mesures et les longueurs]. Une longueur pouvait par exemple être exprimée par : $1/2 ; 3/4 ; 5/3 ; 7/2$.
Les nombres rationnels semblaient donc pouvoir répondre à de nombreux problèmes. Mais la géométrie allait faire apparaître une difficulté nouvelle : #strong[« Existe-t-il des longueurs qui ne peuvent être représentées par aucune fraction ? »
]

#strong[La réponse est oui.] Cette découverte allait conduire les mathématiciens à élargir l'univers des nombres.


// ----------------------------------------------------------
// UNE NOUVELLE QUESTION POSÉE PAR LA GÉOMÉTRIE
// ----------------------------------------------------------

#strong[
📐 La géométrie révèle une difficulté
]

Les mathématiciens de l'Antiquité cherchaient non seulement à compter et à partager, mais aussi à #strong[mesurer les longueurs]
et à construire des figures. Considérons un segment de longueur $1$ et construisons une longueur $x$ telle que : #strong[$ x^2 = 2 $].
Il faut alors trouver une longueur dont le carré vaut $2$. Cette longueur est notée :
#strong[$√2$]. Une question nouvelle apparaît alors :
#strong[
« Peut-on écrire $√2$ sous la forme d'une fraction ? »
]



// ----------------------------------------------------------
// LE PROBLÈME DE √2
// ----------------------------------------------------------

On sait que : #strong[$1^2 = 1$] et #strong[$2^2 = 4$]. Il existe donc un nombre compris entre $1$ et $2$ dont le carré vaut exactement $2$ : #strong[$1 < √2 < 2$].
Une valeur approchée est : #strong[$√2 ≈ 1,414213562...$].
Son écriture décimale est #strong[illimitée] et #strong[ne présente pas de période régulière]. Mais surtout, il est impossible d'écrire $√2$ sous la forme :
#strong[$√2 = a/b$] avec $a$ et $b$ entiers et $b ≠ 0$. Ainsi, $√2$ n'est pas un nombre rationnel. Il appartient à une nouvelle famille : #strong[les nombres irrationnels].

#exemple[
#strong[$√2$, $√3$, $√5$ et $π$] sont des nombres irrationnels.
]


// ----------------------------------------------------------
// L'ESCARGOT DE PYTHAGORE
// ----------------------------------------------------------

#strong[
🐚 L'escargot de Pythagore
]

Une construction géométrique permet de visualiser progressivement ces nouvelles longueurs : #strong[l'escargot de Pythagore].

À partir d'un segment de longueur $1$, on construit successivement des triangles rectangles. Les longueurs obtenues sont : $√2 ; √3 ; √4 ; √5 ; √6 ; ...$
Certaines sont rationnelles : $√4 = 2$. D'autres sont irrationnelles : $√2 ; √3 ; √5 ; ...$
Cette construction montre concrètement que les longueurs rencontrées sur une même droite (droite graduée) ne sont pas toutes représentables par des
fractions. On distingue alors deux grandes familles de nombres : #strong[
Nombres rationnels
]
et
#strong[
Nombres irrationnels
]

    
Ces deux familles vont être réunies dans un ensemble plus vaste: l'ensemble
des #strong[nombres réels], noté 



#align(center)[
#text(
  size: 11pt,
  weight: "bold",
  fill: code-blue,
)[$ℝ$]
]


#strong[
« Les nombres réels sont nés lorsque les mathématiques
ont dû dépasser les limites des nombres rationnels. »
]
]

#align(center)[
#image_full("nombres-reels-origine.png")
]









// ==========================================================
// PARCOURS 3e
// ==========================================================

#pagebreak()


#parcours(
  [PARCOURS 3ᵉ — Nombres réels avec la conception d'un satellite],
  "parcours-nombres-reels-3e",
) <parcours-nombres-reels-3e>

// ==========================================================
// MISE EN SITUATION
// ==========================================================

#activite[

🛰️ #strong[Concevoir un satellite : de l'idée aux calculs]

Un satellite artificiel est conçu pour réaliser une mission précise
dans l'espace. Il peut notamment :

• observer la Terre et son environnement ;

• transmettre des informations ;

• aider à déterminer des positions ;

• étudier l'atmosphère et l'espace ;

• recueillir des données scientifiques.

Avant son lancement, sa conception nécessite de nombreuses
précautions. Les ingénieurs doivent définir sa mission, choisir ses
équipements et déterminer avec précision les dimensions de ses
différentes structures. Un satellite comporte notamment :

• une #strong[structure] qui maintient les différents équipements ;

• des #strong[panneaux solaires] qui fournissent l'énergie ;

• des #strong[batteries] qui stockent cette énergie ;

• des #strong[capteurs et instruments] ;

• un #strong[système de communication] ;

• un #strong[système de contrôle et d'orientation].

Lors de la conception, les ingénieurs doivent donc déterminer avec
précision des #strong[longueurs, distances, surfaces et masses].

📐 #strong[Un problème de conception]

Imaginons qu'une équipe d'ingénieurs prépare un panneau solaire
rectangulaire destiné à être installé sur un satellite.

Le panneau mesure #strong[3 m de longueur et 2 m de largeur].
Pour fabriquer son cadre et vérifier son installation, les ingénieurs
doivent également connaître la longueur exacte de sa diagonale.
Notons $d$ cette diagonale.

Le panneau étant rectangulaire, le théorème de Pythagore permet
d'écrire : #[
$d^2 = 3^2 + 2^2$
]

Donc : #[
$d^2 = 13$
]. Il faut alors déterminer la valeur exacte de $d$.

On cherche donc un nombre dont le carré est égal à $13$ : #strong[$d^2 = 13$].
Ainsi : #strong[$d = √13$].

Une valeur approchée de cette longueur est : #strong[$√13 ≈ 3,6055...$].

La diagonale du panneau solaire mesure donc environ #strong[3,61 m].

]


#pagebreak()


#suite_activite[

Cette situation permet de mobiliser plusieurs notions mathématiques :

• déterminer et utiliser une #strong[racine carrée] ;

• calculer une #strong[valeur exacte] et une valeur approchée ;

• effectuer des calculs avec des #strong[nombres réels] ;

• comparer et représenter des nombres réels ;

• calculer des distances et des longueurs.

Le panneau solaire constitue ainsi un exemple concret permettant
d'étudier les #strong[nombres réels] et les opérations qui leur sont
associées.

#align(center)[
#strong[
Comment calculer, simplifier, comparer et représenter de tels nombres ?
]
]

C'est ce que nous allons découvrir dans ce parcours.

]


// ==========================================================
// OBJECTIFS DU PARCOURS
// ==========================================================

#v(0.12cm)

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

🛰️ comprendre le rôle des principaux éléments d'un satellite et
les contraintes liées à sa conception ;

🔢 distinguer un #strong[nombre rationnel] d'un
#strong[nombre irrationnel] ;

📐 reconnaître et utiliser les #strong[racines carrées] de nombres
réels positifs ;

📏 déterminer exactement certaines longueurs à l'aide du
#strong[théorème de Pythagore] ;

➕ effectuer des opérations sur les #strong[radicaux] ;

⚡ utiliser les #strong[puissances] de nombres réels ;

↔️ simplifier et factoriser des expressions comportant des
#strong[racines carrées] ;

⚖️ comparer des #strong[nombres réels] ;

📏 déterminer la #strong[valeur absolue] et la distance entre deux
nombres réels ;

📍 représenter des nombres réels sur une #strong[droite graduée] ;

📐 représenter et utiliser les #strong[intervalles] ;

🔗 résoudre des problèmes scientifiques et techniques liés à la
conception d'un satellite.

]

#pagebreak()



#align(center)[
#image_full("nombres-reels-3e-satellite.png")
]

#pagebreak()



// ==========================================================
// I — NOMBRES IRRATIONNELS ET RACINES CARRÉES
// ==========================================================

#deux-colonnes[

#sous_titre[
Nombres irrationnels
]

#v(0.12cm)


#definition[

Un nombre irrationnel est un nombre dont l'écriture décimale est
#strong[illimitée et non périodique].
]
#exemple[
Par exemple, la longueur exacte de la diagonale du panneau solaire
étudié précédemment est $√13$.
On a : $√13 ≈ 3,605551275...$

Son écriture décimale ne s'arrête pas et ne présente pas de période.
Ainsi, $√13$ est un #strong[nombre irrationnel].

]

#sous_titre[
Racine carrée d'un nombre réel positif
]

#definition[

Soit $a$ un nombre réel positif ou nul.

La #strong[racine carrée de $a$], notée $√a$, est l'unique
nombre réel positif ou nul dont le carré est égal à $a$. Le symbole #strong[$√(...)$] est appelé #strong[radical].

Ainsi :
#strong[$(√a)^2 = a$]
et
#strong[$√a ≥ 0$].


]

#exemple[

Lors de la conception d'un satellite, un panneau solaire carré
possède un côté de longueur $√3$ m.
Sa longueur au carré est :
$(√3)^2 = 3$.
Comme une longueur est positive :
$√3 ≥ 0$.


]

#retenir[

Soit $a$ un nombre réel.

• si $a ≥ 0$, alors $√(a^2) = a$ ;

• si $a < 0$, alors $√(a^2) = -a$.

]

#v(0.15cm)

#exemple[

Pour vérifier certaines dimensions d'une structure de satellite :

• $√(5^2) = 5$ car $5 ≥ 0$.

• $√((-5)^2) = -(-5) = 5$ car $-5 < 0$.

Dans les deux cas, la racine carrée donne toujours un résultat
#strong[positif ou nul].

]






// ==========================================================
// II — L'ENSEMBLE DES NOMBRES RÉELS
// ==========================================================

#v(0.35cm)

#sous_titre[
L'ensemble des nombres réels
]

#v(0.18cm)


#definition[

L'ensemble des #strong[nombres réels], noté $ℝ$, est constitué
de tous les #strong[nombres rationnels] et de tous les
#strong[nombres irrationnels].

]

#v(0.15cm)

#exemple[

Lors de la conception et du contrôle d'un satellite, les ingénieurs
peuvent rencontrer différents nombres.

Par exemple :

• une longueur de structure de $5$ m ;

• une masse de $-3$ kg par rapport à une référence choisie ;

• une longueur de $7/2$ m ;

• une marge de positionnement de $0,25$ m ;

• une distance calculée égale à $√2$ m ;

• la diagonale d'un panneau égale à $√13$ m ;

• une variation de position égale à $-√5$ m.

Ces nombres peuvent être entiers, rationnels ou irrationnels.

Ils appartiennent tous à un même ensemble :
#strong[$ℝ$].


]


#v(5cm)


#retenir[

Les principaux ensembles de nombres sont emboîtés :

#align(center)[

$ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ ⊂ ℝ$

]

Ainsi :

• tout nombre naturel est un entier relatif ;

• tout entier relatif est un nombre décimal ;

• tout nombre décimal est un nombre rationnel ;

• tout nombre rationnel est un nombre réel ;

• tout nombre irrationnel est un nombre réel ;

• les nombres irrationnels appartiennent à $ℝ$ mais pas à $ℚ$.

]


#v(0.15cm)

#remarque[

Dans $ℝ$, on distingue également :

• $ℝ_+$ : ensemble des nombres réels positifs ou nuls ;

• $ℝ_-$ : ensemble des nombres réels négatifs ou nuls ;

• $ℝ^*$ : ensemble des nombres réels non nuls ;

• $ℝ^*_+$ : ensemble des nombres réels positifs non nuls ;

• $ℝ^*_-$ : ensemble des nombres réels négatifs non nuls.

]


#v(0.15cm)

#exemple[

Dans le suivi des paramètres d'un satellite, on peut rencontrer
les nombres suivants :

• $2 ∈ ℝ$ ; $2 ∈ ℝ_+$ et $2 ∈ ℝ^*_+$.

• $-7 ∈ ℝ$ ; $-7 ∈ ℝ_-$ et $-7 ∈ ℝ^*_-$.

• $-√3 ∈ ℝ^-$.

• $√5 ∉ ℚ$ car $√5$ est irrationnel.

• $0 ∉ ℝ^*$ car zéro est un nombre réel nul.

]





#v(2cm)

#sous_titre[
Puissances de nombres irrationnels
]

#v(0.18cm)

#definition[

Soit $a$ un nombre positif ou nul et $n$ un entier naturel non nul.

La #strong[puissance $n$-ième] d'un nombre irrationnel s'obtient
en multipliant ce nombre par lui-même $n$ fois.

Pour un nombre de la forme $√a$ :

#strong[$(√a)^n = √a × √a × ... × √a$]

avec $n$ facteurs de $√a$.

De même, pour un nombre de la forme $-√a$ :

$(-√a)^n = (-√a) × (-√a) × ... × (-√a)$

avec $n$ facteurs de $-√a$.

]

#v(0.15cm)

#exemple[

Lors de la conception d'un satellite, certaines longueurs ou
dimensions peuvent être exprimées à l'aide de racines carrées.

Considérons une longueur représentée par $√2$ m.

On obtient :

$(√2)^2 = √2 × √2 = 2$

$(√2)^3 = √2 × √2 × √2 = 2√2$

$(√2)^4 = √2 × √2 × √2 × √2 = 4$.

Si une grandeur orientée est représentée par $-√2$, alors :

$(-√2)^2 = (-√2) × (-√2) = 2$

$(-√2)^3 = (-√2) × (-√2) × (-√2) = -2√2$

$(-√2)^4 = 4$.

]

#v(5cm)

#propriete[

Soient $a$ et $b$ deux nombres positifs ou nuls.

• Le produit de deux racines carrées est la racine carrée du produit : 

#strong[$√a × √b = √(a × b)$].

• Si $b > 0$, le quotient de deux racines carrées est la racine carrée du quotient :


#strong[$√a / √b = √(a/b)$].

]

#exemple[

Lors du dimensionnement de deux éléments d'un satellite, on rencontre
les longueurs $√5$ m et $√3$ m.

Leur produit vaut : $√5 × √3 = √15$.

De même, si le rapport entre deux longueurs est $√12 / √3$ :

$√12 / √3 = √(12/3)$

$√12 / √3 = √4$

$√12 / √3 = 2$.

]

#erreur[

La propriété précédente ne s'applique pas à l'addition.

En général : $√(a+b) ≠ √a + √b$.

Par exemple, lors du calcul d'une dimension d'un satellite : $√(9+16) = √25 = 5$,

alors que : $√9 + √16 = 3 + 4 = 7$.

Donc : $√(9+16) ≠ √9 + √16$.

Ainsi, on ne peut pas distribuer une racine carrée sur une addition.
]

#regle[
#strong[Pour simplifier une racine carrée]

Pour écrire plus simplement $√n$, avec $n$ un entier naturel, on peut
utiliser la décomposition de $n$ en produit de facteurs premiers.

On procède en plusieurs étapes :

• #strong[Étape 1 :] décomposer $n$ en produit de facteurs premiers ;

• #strong[Étape 2 :] regrouper les facteurs premiers identiques
  par paires (par puissance de 2);

• #strong[Étape 2 :] regrouper les facteurs premiers identiques
  par paires, c'est-à-dire par groupes de deux
  (exposants pairs).

• #strong[Étape 4 :] laisser sous la racine les facteurs qui ne
  peuvent pas être regroupés par paires.

Ainsi, si #strong[$n = a² × b$], alors

 #strong[$√n = √(a² × b) = a√b$].
]

#v(0.18cm)

#exemple[
Lors de l'analyse d'une structure d'un satellite, une longueur
est représentée par $√72$ m.

Pour simplifier cette expression, décomposons $72$ en facteurs
premiers :

#decomposition-premiers(
  (
    ("72", "2"),
    ("36", "2"),
    ("18", "2"),
    ("9", "3"),
    ("3", "3"),
    ("1", ""),
  )
)

On obtient donc :

$72 = 2 × 2 × 2 × 3 × 3$.

Regroupons les facteurs identiques par paires :

$72 = (2 × 2) × (3 × 3) × 2$. Ainsi :

$√72 = √((2 × 2) × (3 × 3) × 2)$

$√72 = √((2^2) × (3^2) × 2)$

$√72 = 2 × 3 × √2$

Donc : $√72 = 6√2$.

La longueur peut ainsi être écrite plus simplement sous la forme
$6√2$ m.
]

#propriete[

Soient $a$, $b$, $c$ et $d$ deux nombres positifs ou nuls.

#strong[$a√b × c√d = (a × c)√(b × d)$].



]

#v(0.15cm)
#exemple[

Lors de la conception d'un satellite, deux éléments de sa structure
possèdent des longueurs représentées par :
$2√3$ m et $5√6$ m.

Pour déterminer une grandeur liée à ces deux dimensions, on calcule
leur produit :

$2√3 × 5√6$
$= (2 × 5)√(3 × 6)$

$2√3 × 5√6$
$= 10√18$.

Or $√18 = √(9 × 2)= 3√2$.

Donc $10√18 = 10 × 3√2 = 30√2$.

Ainsi, le produit des deux longueurs est :
$30√2$ m².
]

#propriete[

Pour tout entier naturel non nul $n$ et tout nombre $a ≥ 0$ :

#strong[$(√a)^n = a^(n/2)$].

]

#exemple[

Dans le calcul d'une grandeur géométrique intervenant dans la
conception d'un panneau solaire, on peut avoir :

$(√3)^8 = 3^(8/2) = 3^4$.

]

#propriete[

Pour tout entier naturel non nul $n$, tout nombre réel $a$ et tout
nombre $b ≥ 0$ :

$(√b)^n = √(b^n)$ et $(a√b)^n = (a^n)(√b)^n$.

Ainsi :

$(a√b)^n = a^n√(b^n)$.

]
#v(8cm)

#exemple[

Lorsqu'un ingénieur modélise une dimension répétée dans la structure
d'un satellite, des expressions telles que $(2√3)^4$ et $(3√2)^3$ peuvent apparaître. On calcule : 

$*$$(2√3)^4 = 2^4(√3)^4 = 16 × 9 = 144$.

$*$$(3√2)^3 = 3^3(√2)^3 = 27 × 2√2 = 54√2$.

]

#propriete[

Pour tout entier naturel non nul $n$ :

$(-√a)^n = (-1)^n(√a)^n$.

Ainsi :

• si $n$ est pair, alors $(-√a)^n = (√a)^n$ ;

• si $n$ est impair, alors $(-√a)^n = -(√a)^n$.

]

#exemple[

Dans l'étude d'une grandeur orientée associée au système
d'orientation d'un satellite :

$(-√3)^2 = (√3)^2 = 3$

$(-√3)^3 = -(√3)^3 = -3√3$

$(-√3)^4 = (√3)^4 = 9$.

On constate que le signe dépend de la parité de l'exposant.

]

#propriete[

Soit $a$ un nombre réel strictement positif et $n$ un entier relatif non nul.

• $√(a^(2n)) = a^n$ ;

• $√(a^(2n+1)) = a^n√a$.

]

#exemple[

Lorsqu'une dimension d'un élément du satellite est exprimée sous
forme d'une puissance, ces propriétés permettent de retrouver sa
racine carrée.

Par exemple :

$√(3^6) = 3^3 = 27$ et $√(3^7) = 3^3√3 = 27√3$.

]


// ==========================================================
// V — EXPRESSIONS CONJUGUÉES
// ==========================================================

#v(0.35cm)

#sous_titre[
Expressions conjuguées
]

#definition[

Soient $a$ et $b$ deux nombres.

Les expressions #strong[$a + b$] et #strong[$a - b$] sont appelées
#strong[expressions conjuguées].

Ainsi $a + b$ et $a - b$ sont deux expressions conjuguées.

]

#v(0.15cm)

#exemple[

Lors du calcul de deux dimensions possibles d'une structure de
satellite, on peut rencontrer les expressions $5 + √3$ et $5 - √3$.

Ces deux expressions sont conjuguées.

L'expression conjuguée de $5 + √3$ est donc :

$5 - √3$.

L'expression conjuguée de $5 - √3$ est : $5 + √3$.

]

#remarque[
Une expression de la forme $a+b$ a pour expression conjuguée $a-b$.
Ainsi, lorsque $b=0$, les deux expressions sont identiques.
]

#retenir[

L'expression conjuguée de $√a$ est $√a$.

En effet, on peut écrire : $√a = √a + 0$.

Son expression conjuguée est alors : $√a - 0$.

Or $√a - 0 = √a$.

Donc : 

$√a$ est sa propre expression conjuguée.

]

#exemple[
  L'expression conjuguée de $√7$ est $√7$.
]

#propriete[

Le produit de deux expressions conjuguées est égal à la différence
des carrés :

#strong[$(a + b)(a - b) = a^2 - b^2$].

En particulier, si $a$ et $b$ sont rationnels et si $b ≥ 0$ :

$(a + √b)(a - √b) = a^2 - b$.

]

#exemple[

Dans un calcul de dimensionnement d'un panneau ou d'un élément de
la structure du satellite, on rencontre $(5 + √10)(5 - √10)$.

On utilise les expressions conjuguées :

$(5 + √10)(5 - √10)$
$= 5^2 - (√10)^2$

$(5 + √10)(5 - √10)$
$= 25 - 10$

$(5 + √10)(5 - √10)$
$= 15$.

Le résultat ne contient plus de radical.

]

#v(0.15cm)

#remarque[

Les termes contenant le radical disparaissent lors du développement
du produit de deux expressions conjuguées.

Ainsi :

$(a + √b)(a - √b) = a^2 - b$.

Cette propriété peut être utile pour simplifier certains calculs
réalisés lors du dimensionnement des éléments d'un satellite.

]

#v(0.15cm)

#sous_titre[Deux nombres inverses]

#definition[

Deux nombres réels non nuls sont dits #strong[inverses l'un de l'autre]
lorsque leur produit est égal à $1$.

]

#v(4cm)

#exemple[

Lors du calcul d'un facteur de correction dans un modèle de
conception d'un satellite, on rencontre les deux nombres :

$√(3 - 2√2)$ et $√(3 + 2√2)$.

Vérifions qu'ils sont inverses l'un de l'autre.

On calcule : $√(3 - 2√2) × √(3 + 2√2)$

$√(3 - 2√2) × √(3 + 2√2) = √((3 - 2√2)(3 + 2√2))$

$√(3 - 2√2) × √(3 + 2√2) = √(3^2 - (2√2)^2)$

$√(3 - 2√2) × √(3 + 2√2) = √(9 - 8)$

$√(3 - 2√2) × √(3 + 2√2) = √1$

$√(3 - 2√2) × √(3 + 2√2)= 1$.

Les deux nombres sont donc #strong[inverses l'un de l'autre].

]

#sous_titre[
Écriture sans radical au dénominateur
]

#definition[

Pour écrire un quotient sans radical au dénominateur, on peut
multiplier le numérateur et le dénominateur par une expression
conjuguée du dénominateur.

Cette technique permet notamment de simplifier certaines expressions
rencontrées lors des calculs de dimensions et de rapports entre
éléments d'un satellite.

]

#exemple_resolu[

Lors du calcul d'un rapport entre deux dimensions d'un panneau solaire,
un ingénieur obtient : $5/√7$.
Écrivons ce quotient sans radical au dénominateur.
On multiplie le numérateur et le dénominateur par l'expression conjuguée de $√7$ qui est $√7$ :

$5/√7 = (5 × √7)/(√7 × √7)$

$5/√7 = (5√7)/7$.

Ainsi : $5/√7 = (5√7)/7$.

]

#exemple_resolu[

Lors du calcul d'un facteur géométrique intervenant dans
l'installation d'un équipement du satellite, on obtient : $1/(3 + √2)$.

L'expression conjuguée de $3 + √2$ est $3 - √2$.

Donc :

$1/(3 + √2) = (3 - √2)/((3 + √2)(3 - √2)) = (3 - √2)/(9 - 2) = (3 - √2)/7$.

Ainsi, le quotient est écrit sans radical au dénominateur.

]

#retenir[

Les expressions conjuguées sont particulièrement utiles pour :

• développer et factoriser des expressions ;

• simplifier des produits contenant des racines carrées ;

• écrire un quotient sans radical au dénominateur ;

• rechercher l'inverse d'un nombre de la forme $a + √b$ ;

• simplifier certains rapports de longueurs ou de dimensions
  intervenant dans la conception d'un satellite.

]


// ==========================================================
// VI — COMPARAISON DE NOMBRES
// ==========================================================
#sous_titre[
Comparaison de deux nombres réels
]

#definition[

Comparer deux nombres, c'est déterminer lequel est le plus grand,
lequel est le plus petit ou s'ils sont égaux.
Pour deux nombres $a$ et $b$, on peut avoir :
$a < b$, $a > b$ ou $a = b$.

Dans la conception d'un satellite, comparer deux nombres permet
par exemple de déterminer quelle dimension est la plus grande,
quelle distance est la plus courte ou quelle marge de sécurité
est la plus importante.

]

#v(0.15cm)


#sous_sous_titre[Comparaison de deux nombres de signes contraires]

#propriete[

Soient $a$ et $b$ deux nombres de signes contraires.

• Si $a < 0$ et $b > 0$, alors $a < b$.

• Si $a > 0$ et $b < 0$, alors $a > b$.

Ainsi, deux nombres de signes contraires sont toujours rangés
dans l'ordre déterminé par leur signe :

#strong[tout nombre négatif est inférieur à tout nombre positif.]

]

#v(0.15cm)

#exemple_resolu[

Dans le système de contrôle d'orientation d'un satellite, deux
écarts angulaires par rapport à une position de référence sont
représentés par :

$-3√5$ et $2√3$.

Comparons ces deux valeurs: 

$-3√5 < 0$ et $2√3 > 0$.

Les deux nombres sont donc de signes contraires.

On en déduit directement : $-3√5 < 2√3$.
Ainsi, le premier écart est inférieur au second.

]

#v(0.15cm)

#sous_sous_titre[Comparaison de deux nombres positifs]

#propriete[

Soient $a$ et $b$ deux nombres positifs ou nuls.

• Si $a ≤ b$, alors $a^2 ≤ b^2$.

Réciproquement,

• Si $a^2 ≤ b^2$, alors $a ≤ b$.

Ainsi, deux nombres positifs ou nuls sont rangés dans le
#strong[même ordre] que leurs carrés.

]

#exemple_resolu[

Deux dimensions calculées pour des éléments d'un panneau solaire
sont représentées par :

$2√3$ m et $5√2$ m.

Comparons ces deux longueurs.

$2√3 > 0$ et $5√2 > 0$.

Calculons leurs carrés :

$(2√3)^2 = 4 × 3 = 12$
et
$(5√2)^2 = 25 × 2 = 50$.

Comme $12 < 50$, on en déduit : $2√3 < 5√2$.

La première dimension est donc plus petite que la seconde.

]

#sous_sous_titre[Comparaison de deux nombres négatifs]

#propriete[

Soient $a$ et $b$ deux nombres négatifs.

• Si $a ≤ b$, alors $a^2 ≥ b^2$.

Réciproquement,

• Si $a^2 ≥ b^2$, alors $a ≤ b$.

Ainsi, deux nombres négatifs sont rangés dans l'#strong[ordre contraire]
de celui de leurs carrés.

]

#exemple[

Dans le système de contrôle d'orientation du satellite, deux écarts
par rapport à une position de référence sont représentés par :

$-3√5$ et $-2√7$.

Les deux nombres sont négatifs.

Calculons leurs carrés :

$(-3√5)^2 = 45$ et $(-2√7)^2 = 28$.

Comme $45 > 28$, les deux nombres négatifs sont rangés dans
l'ordre contraire de celui de leurs carrés.

On en déduit : 

$-3√5 < -2√7$.

]

#sous_sous_titre[
Comparaison de l'inverse de deux nombres de même signe
]

#propriete[

Soient $a$ et $b$ deux nombres non nuls de même signe.

• Si $a$ et $b$ sont positifs et $a ≤ b$, alors $1/a ≥ 1/b$.

• Si $a$ et $b$ sont négatifs et $a ≤ b$, alors $1/a ≥ 1/b$.

Ainsi, deux nombres non nuls de même signe sont rangés dans
l'#strong[ordre contraire] de celui de leurs inverses.

]

#exemple[

Lors du calcul d'un rapport entre deux dimensions positives d'un
satellite, on compare $1/2$ et $1/5$.
Comme $2 < 5$ et que $2$ et $5$ sont positifs, on obtient : $1/2 > 1/5$.

De même, pour deux valeurs négatives représentant des écarts
orientés : $-5 < -2$.
Comme $-5$ et $-2$ sont négatifs :
$1/(-5) > 1/(-2)$.

]


#v(0.15cm)

#propriete[

#strong[Produit par un nombre positif]

Soient $a$, $b$ et $c$ trois nombres réels.

• Si $a ≤ b$ et $c > 0$, alors $a × c ≤ b × c$.

• Si $a < b$ et $c > 0$, alors $a × c < b × c$.

]

#v(0.15cm)

#remarque[

Lorsqu'on multiplie les deux membres d'une inégalité par un nombre
#strong[positif], le sens de l'inégalité est conservé.

Lorsqu'on multiplie les deux membres d'une inégalité par un nombre
#strong[négatif], le sens de l'inégalité est inversé.

Cette règle est particulièrement importante lorsqu'on compare des
grandeurs orientées ou des écarts associés au positionnement d'un
satellite.

]

#v(0.15cm)

#exemple[

Deux longueurs d'un panneau solaire vérifient : $3 < 5$. Comme $√2 > 0$ alors $3√2 < 5√2$.
En revanche, si l'on considère une grandeur orientée et que l'on
multiplie par $-√2$ :
$3 < 5$ et $-√2 < 0$.
Le sens de l'inégalité s'inverse :
$-3√2 > -5√2$.

]

#retenir[

Pour comparer des nombres :

• deux nombres positifs sont rangés dans le même ordre que leurs carrés ;

• deux nombres négatifs sont rangés dans l'ordre contraire de celui
  de leurs carrés ;

• deux nombres non nuls de même signe sont rangés dans l'ordre
  contraire de celui de leurs inverses ;

• deux nombres de signes contraires sont rangés selon leur signe :
  tout nombre négatif est inférieur à tout nombre positif ;

• multiplier les deux membres d'une inégalité par un nombre positif
  conserve le sens de l'inégalité ;

• multiplier les deux membres d'une inégalité par un nombre négatif
  inverse le sens de l'inégalité.

]

#v(0.15cm)

#sous_sous_titre[Étude du signe d'un nombre]

#propriete[

Pour déterminer le signe d'un nombre contenant une racine carrée,
on peut le comparer à $0$. Ainsi :

• si $a > 0$, alors $a$ est positif ;

• si $a < 0$, alors $a$ est négatif ;

• si $a = 0$, alors $a$ est nul.

Pour les expressions contenant une différence de deux termes
positifs, on peut comparer ces deux termes.

]

#v(0.15cm)

#exemple_resolu[

#strong[1. Étudions le signe de $A = 1 - 2√2$.]

Lors du calcul d'une marge géométrique dans la structure d'un
satellite, on obtient :
$A = 1 - 2√2$.

On compare $1$ et $2√2$.

$1 > 0$ et $2√2 > 0$.
De plus $1^2 = 1$ et $(2√2)^2 = 8$.
Comme $1 < 8$ alors $1 < 2√2$.

Donc : $1 - 2√2 < 0$. Ainsi #strong[$A$ est négatif].

]

#exemple_resolu[

#strong[2. Étudions le signe de $B = -5 - 3√7$.]

Dans l'étude d'un écart orienté par rapport à une position de
référence, on obtient : $B = -5 - 3√7$.

On sait que : $-5 < 0$ et $-3√7 < 0$.

La somme de deux nombres négatifs est négative.

Donc : $-5 - 3√7 < 0$. Ainsi #strong[$B$ est négatif].

]

#exemple_resolu[

#strong[3. Étudions le signe de $C = 7 - 4√3$.]

Lors du calcul d'une marge de positionnement d'un équipement,
on obtient : $C = 7 - 4√3$.

On compare $7$ et $4√3$.

$7 > 0$ et $4√3 > 0$.

Calculons leurs carrés :

$7^2 = 49$ et $(4√3)^2 = 16 × 3 = 48$.

Comme $49 > 48$, alors $7 > 4√3$.

Donc : $7 - 4√3 > 0$. Ainsi #strong[$C$ est positif].

]

#exemple_resolu[

#strong[4. Étudions le signe de $D = 4 + 2√3$.]

Lors du calcul d'une dimension totale dans la structure du satellite,
on obtient : $D = 4 + 2√3$.

On sait que : $4 > 0$ et $2√3 > 0$.

La somme de deux nombres positifs est positive.

Donc : $4 + 2√3 > 0$. Ainsi #strong[$D$ est positif].

]

#retenir[

Pour étudier le signe d'une expression contenant des racines carrées,
on peut :

• utiliser directement le signe de ses termes ;

• comparer deux nombres positifs en comparant leurs carrés ;

• utiliser le fait que la somme de deux nombres positifs est positive ;

• utiliser le fait que la somme de deux nombres négatifs est négative ;

• interpréter le résultat dans le contexte du problème : une grandeur
  positive peut représenter une longueur ou une marge, tandis qu'une
  grandeur négative peut représenter un écart orienté ou une variation
  par rapport à une référence.

]

#sous_titre[
Encadrement d'un nombre irrationnel
]

#definition[

• Encadrer un nombre consiste à trouver deux nombres, l'un inférieur
et l'autre supérieur à ce nombre.

• Un #strong[encadrement d'ordre $n$] est un encadrement dont les deux
bornes sont des nombres décimaux ayant $n$ chiffres après la virgule.

Dans la conception d'un satellite, l'encadrement permet notamment
d'obtenir une valeur approchée d'une longueur ou d'une distance avec
la précision souhaitée.

]

#exemple[

Lors du calcul de la diagonale d'un panneau solaire, on obtient $√2$ m.
On sait que : $1,41 < √2 < 1,42$.
Ainsi, $1,41 < √2 < 1,42$ est un encadrement d'ordre $2$ de $√2$ .

La longueur de la diagonale est donc comprise entre $1,41$ m et $1,42$ m.

]

#exercice_resolu[

#strong[• Un ingénieur doit encadrer la longueur $3√2 + 5$ m par deux
nombres décimaux consécutifs d'ordre $2$.]

Cette expression peut représenter une dimension calculée lors du
dimensionnement d'un élément de la structure du satellite.
On donne : $1,414 < √2 < 1,415$.

Comme $3 > 0$, on peut multiplier les trois membres par $3$ : 
$4,242 < 3√2 < 4,245$.

En ajoutant $5$ aux trois membres :

$9,242 < 3√2 + 5 < 9,245$.

On recherche alors deux nombres décimaux consécutifs d'ordre $2$.

Donc : $9,24 < 3√2 + 5 < 9,25$.
La dimension recherchée est donc comprise entre $9,24$ m et $9,25$ m.

]

#exercice_resolu[

#strong[• Un panneau solaire possède une dimension exprimée par
$2√3 - 3$ m. Encadrons cette dimension par deux nombres décimaux
consécutifs d'ordre $2$.]

On donne :
$1,732 < √3 < 1,733$.
Comme $2 > 0$ :

$3,464 < 2√3 < 3,466$.

En soustrayant $3$ aux trois membres :

$0,464 < 2√3 - 3 < 0,466$.

Donc : $0,46 < 2√3 - 3 < 0,47$.
La dimension est donc comprise entre $0,46$ m et $0,47$ m.

]

#exercice_resolu[

#strong[• Un système d'orientation présente un écart représenté par
$-3√2$. Encadrons cet écart par deux nombres décimaux consécutifs
d'ordre $2$.]

On donne : $1,414 < √2 < 1,415$.
En multipliant par $-3$, le sens des inégalités est inversé :

$-4,245 < -3√2 < -4,242$.

Donc : $-4,25 < -3√2 < -4,24$.

L'écart est donc compris entre $-4,25$ et $-4,24$.

]

#exercice_resolu[

#strong[• Un ingénieur doit encadrer le rapport $1/(3√2)$ par deux
nombres décimaux consécutifs d'ordre $2$.]

On donne : $1,414 < √2 < 1,415$.

Comme $3 > 0$ :

$4,242 < 3√2 < 4,245$.

Les trois nombres étant strictement positifs, en prenant les inverses,
le sens des inégalités est inversé :

$1/4,245 < 1/(3√2) < 1/4,242$.

Or : $0,23 < 1/4,245$ et $1/4,242 < 0,24$.

Donc : $0,23 < 1/(3√2) < 0,24$.

Le rapport recherché est donc compris entre $0,23$ et $0,24$.

]

#propriete[

#strong[• Méthode pour encadrer une somme]

Si $a < x < b$ et $c < y < d$, alors :

$a + c < x + y < b + d$.

Cette méthode peut être utilisée lorsque plusieurs dimensions
interviennent dans le calcul d'une dimension totale d'un satellite.

]

#v(0.15cm)

#propriete[

#strong[• Méthode pour encadrer une différence]

Pour encadrer une différence $x-y$, on peut :

$*$ déterminer un encadrement de $-y$ ;

$*$ puis utiliser la méthode d'encadrement d'une somme pour
calculer $x + (-y)$.

Cette méthode peut notamment être utilisée pour déterminer
l'intervalle dans lequel se trouve un écart entre deux dimensions.

]

#v(3cm)

#propriete[

#strong[• Méthode pour encadrer un produit]

Si les nombres utilisés sont positifs, on peut multiplier
membre à membre les bornes des encadrements.
Ainsi, si $0 < a < x < b$ et $0 < c < y < d$, alors
$a × c < x × y < b × d$.

Cette méthode permet par exemple d'encadrer une surface obtenue
à partir de deux dimensions positives d'un panneau solaire.

]

#v(0.15cm)

#propriete[

#strong[• Méthode pour encadrer un quotient]

Pour encadrer un quotient $x/y$, on peut :

$*$ déterminer un encadrement de $y$ ;

$*$ déterminer un encadrement de $1/y$ ;

$*$ puis utiliser la méthode d'encadrement d'un produit pour
encadrer $x × (1/y)$.

Cette méthode peut être utilisée pour encadrer un rapport entre
deux dimensions ou deux grandeurs positives intervenant dans
la conception du satellite.

]

#v(0.15cm)

#retenir[

Pour encadrer un nombre :

• on utilise les propriétés de comparaison ;

• multiplier une inégalité par un nombre positif conserve son sens ;

• multiplier une inégalité par un nombre négatif inverse son sens ;

• prendre les inverses de nombres strictement positifs inverse
le sens de l'inégalité ;

• on peut ensuite rechercher deux nombres décimaux consécutifs
de l'ordre demandé ;

• l'encadrement permet d'obtenir une valeur approchée avec une
précision adaptée aux besoins de la conception du satellite.

]


// ==========================================================
// VIII — VALEUR ABSOLUE ET RACINE CARRÉE DU CARRÉ
// ==========================================================

#v(0.35cm)

#sous_titre[

Valeur absolue et racine carrée du carré

]

#sous_sous_titre[Valeur absolue d'un nombre réel]

#definition[

La #strong[valeur absolue] d'un nombre réel $a$, notée $|a|$,
est la distance de $a$ à zéro sur la droite graduée.
Ainsi, la valeur absolue est toujours positive ou nulle :

#strong[$|a| ≥ 0$].

Dans l'étude d'un satellite, une valeur absolue peut notamment
représenter l'écart entre une position mesurée et une position
de référence, sans tenir compte du sens de cet écart.

]

#propriete[

Pour tout nombre réel $a$ :

• si $a > 0$, alors $|a| = a$ ;

• si $a = 0$, alors $|a| = 0$ ;

• si $a < 0$, alors $|a| = -a$.

]

#exemple_resolu[

Lors du contrôle de différents paramètres d'un satellite, on obtient
les valeurs $-8$, $√5$ et $2 - √3$.

Déterminons leurs valeurs absolues.

• Comme $-8 < 0$ alors $|-8| = -(-8) = 8$.

• Comme $√5 > 0$ alors $|√5| = √5$.

• Comparons $2$ et $√3$.

$2^2 = 4$ et $(√3)^2 = 3$.

Comme $4 > 3$ et que $2 ≥ 0$ et $√3 ≥ 0$, 

alors $2 > √3$. Donc $2 - √3 > 0$.

Ainsi $|2 - √3| = 2 - √3$.

]

#sous_sous_titre[Racine carrée du carré d'un nombre réel]

#propriete[

Pour tout nombre réel $a$ :

$√(a^2) = |a|$.

Ainsi, la racine carrée du carré d'un nombre réel est égale
à sa valeur absolue.

]

#exemple_resolu[

Dans le système de contrôle du satellite, certaines grandeurs
peuvent être positives ou négatives selon leur orientation.

Simplifions : $√((-3)^2)$ ; $√(3^2)$ ; $√((-5)^2)$.

On a :

$√((-3)^2) = |-3| = 3$ ;

$√(3^2) = |3| = 3$ ;

$√((-5)^2) = |-5| = 5$.

]

#erreur[

Il est important de ne pas écrire :
$√(a^2) = a$ pour tout nombre réel $a$.

Cette égalité est vraie seulement lorsque $a ≥ 0$.

La formule valable pour tout nombre réel est :

$√(a^2) = |a|$.

Dans l'étude d'une grandeur orientée du satellite, cette distinction
est essentielle : une grandeur négative devient positive lorsqu'on
calcule sa distance à zéro.

]

#exemple_resolu[

Lors du contrôle de la position d'un équipement du satellite,
on obtient l'expression : $√((3 - √2)^2)$.

On a : $√((3 - √2)^2) = |3 - √2|$.

Comparons $3$ et $√2$.

$3^2 = 9$ et $(√2)^2 = 2$.

Comme $9 > 2$, alors $3 > √2$.

Donc : $3 - √2 > 0$.

Ainsi : $|3 - √2| = 3 - √2$.

Par conséquent : $√((3 - √2)^2) = 3 - √2$.

]

#exemple_resolu[

Considérons maintenant un écart de position représenté par : $√((2 - √7)^2)$.

On a : $√((2 - √7)^2) = |2 - √7|$.

Comparons $2$ et $√7$.

$2^2 = 4$ et $(√7)^2 = 7$.

Comme $4 < 7$, alors $2 < √7$.

Donc : $2 - √7 < 0$.

Ainsi : $|2 - √7| = -(2 - √7 = -2 + √7$.

Par conséquent : $√((2 - √7)^2) = -2 + √7$.

Cette valeur représente une #strong[distance] : elle est donc
positive.

]

#propriete[

Pour tous nombres réels $a$ et $b$ :

• $|a × b| = |a| × |b|$ ;

• si $b ≠ 0$, $|a/b| = |a|/|b|$.

Ces propriétés permettent notamment de calculer des écarts
et des rapports de grandeurs sans se préoccuper du sens
d'une orientation.

]

#v(0.35cm)

#sous_titre[

Distance de deux nombres réels

]

#v(0.18cm)

#align(center)[

#image_full("graduation-3e.png")

]

#v(0.15cm)

#definition[

Soient $α$ et $β$ deux nombres réels.

On considère une droite graduée sur laquelle $A$ et $B$ sont les points
d'abscisses respectives $α$ et $β$.

La #strong[distance des nombres $α$ et $β$], notée $d(α, β)$,
est la distance entre les points $A$ et $B$.

On a :

#align(center)[

$d(α, β) = |α - β|$.

]

Dans le contexte d'un satellite, cette relation permet de calculer
l'écart entre deux positions représentées sur une même droite
graduée, par exemple entre une position réelle et une position
de référence.

]

#v(0.15cm)

#propriete[

Pour tous nombres réels $α$ et $β$ :

• $d(α, β) = |α - β| = |β - α|$ ;

• la distance entre deux nombres est toujours positive ou nulle :

$d(α, β) ≥ 0$ ;

• $d(α, β) = 0$ si et seulement si $α = β$.

]

#v(0.15cm)

#exemple_resolu[

Lors du contrôle d'une position sur un axe de référence, deux
positions sont représentées par les nombres $-4$ et $-9$.

Calculons la distance entre ces deux positions.

$d(-4,-9) = |-4 - (-9)|$

$d(-4,-9) = |-4 + 9|$

$d(-4,-9) = |5|$

$d(-4,-9) = 5$.

Ainsi : $d(-4,-9) = 5$.

Les deux positions sont séparées d'une distance de $5$ unités.

]

#v(2cm)

#exemple_resolu[

Deux positions d'un équipement du satellite sont représentées sur
un axe par les nombres $7$ et $-3√2$.

Calculons leur distance.

$d(7,-3√2) = |7 - (-3√2)|$

$d(7,-3√2) = |7 + 3√2|$.

Or $7 > 0$ et $3√2 > 0$, donc $7 + 3√2 > 0$.

Ainsi : $d(7,-3√2) = 7 + 3√2$.

]

#exemple_resolu[

Lors d'un contrôle du positionnement d'un élément du satellite,
deux positions sont représentées par $3$ et $-2√2$.

Calculons la distance entre ces deux positions.

$d(3,-2√2) = |3 - (-2√2)|$

$d(3,-2√2) = |3 + 2√2|$.

Or $3 > 0$ et $2√2 > 0$, donc $3 + 2√2 > 0$.

Ainsi : $d(3,-2√2) = 3 + 2√2$.

Cette distance représente l'écart entre les deux positions,
indépendamment du sens dans lequel on se déplace sur l'axe.

]

#remarque[

La valeur absolue permet donc de transformer une différence de deux
nombres en une #strong[distance].

Ainsi #strong[$|α - β|$] représente la distance entre les nombres $α$ et $β$ sur la droite graduée.

Dans la conception et le contrôle d'un satellite, cette notion
permet notamment de mesurer un écart entre une position prévue et
une position mesurée, ou entre deux positions d'un même équipement.

]
// ==========================================================
// IX — INTERVALLES
// ==========================================================

#v(4cm)

#sous_titre[
Intervalles
]

#definition[

Un #strong[intervalle] est un ensemble de nombres réels compris
entre deux nombres appelés #strong[bornes], éventuellement avec
une seule borne lorsque l'intervalle est non borné.

Dans la conception d'un satellite, un intervalle peut représenter
une #strong[plage de valeurs autorisées] pour une dimension,
une température, une position ou une autre grandeur mesurée. Un intervalle peut être :

• #strong[fermé] à une borne lorsque cette borne appartient à
l'intervalle ;

• #strong[ouvert] à une borne lorsque cette borne n'appartient pas
à l'intervalle.

]

#sous_sous_titre[Intervalles non bornés]

#propriete[

Les principaux intervalles non bornés sont :

• $x ≤ a$ équivaut à $x ∊ ]← ; a]$ ;

• $x < a$ équivaut à $x ∊ ]← ; a[$ ;

• $x ≥ a$ équivaut à $x ∊ [a ; →[$ ;

• $x > a$ équivaut à $x ∊ ]a ; →[$.

]

#exemple_resolu[

Lors du contrôle d'une grandeur liée au fonctionnement d'un satellite,
on impose certaines conditions. Traduisons les inégalités suivantes sous forme d'intervalles.

• Si une grandeur doit être au plus égale à $-2$ :

$x ≤ -2$ équivaut à $x ∊ ]← ; -2]$.

• Si une valeur doit être strictement supérieure à $3$ :

$x > 3$ équivaut à $x ∊ ]3 ; →[$.

• Si une grandeur doit être supérieure ou égale à $-√5$ :

$x ≥ -√5$ équivaut à $x ∊ [-√5 ; →[$.

• Si une valeur doit être strictement inférieure à $1$ :

$x < 1$ équivaut à $x ∊ ]← ; 1[$.

]



]


#pagebreak()


#retenir[
$a$ et $b$ sont des nombres réels tels que a < b. Les nombres a et b sont les bornes de chacun des nombres suivants: $[a ; b[$, $[a ; b]$, $]a ; b[$, $]a ; b]$.
]

#image_full("intervalle2.png")






#pagebreak()


#deux-colonnes[
#remarque[

Dans la représentation d'un intervalle sur une droite graduée :

• une #strong[borne incluse] est représentée par un point plein ;

• une #strong[borne exclue] est représentée par un point creux ;

• une flèche indique que l'intervalle se poursuit indéfiniment.

Dans le contrôle d'un satellite, cette représentation permet de
visualiser rapidement les valeurs autorisées ou interdites pour
une grandeur.

]

#sous_sous_titre[Intervalles bornés]

#propriete[

Soient $a$ et $b$ deux nombres réels tels que

$a < b$.

On distingue quatre intervalles bornés :

• $[a ; b]$ correspond à $a ≤ x ≤ b$ ;

• $]a ; b]$ correspond à $a < x ≤ b$ ;

• $[a ; b[$ correspond à $a ≤ x < b$ ;

• $]a ; b[$ correspond à $a < x < b$.

]

#v(0.15cm)

#exemple_resolu[

Lors de la fabrication d'un élément du satellite, une dimension
doit rester dans une plage de valeurs déterminée.

Traduisons les doubles inégalités suivantes sous forme d'intervalles.

• $-2 ≤ x ≤ 7$ équivaut à $x ∊ [-2 ; 7]$.

• $-2 < x ≤ 5$ équivaut à $x ∊ ]-2 ; 5]$.

• $0 ≤ x < 4$ équivaut à $x ∊ [0 ; 4[$.

• $-5 < x < 3$ équivaut à $x ∊ ]-5 ; 3[$.

]

#v(0.15cm)

#propriete[

#strong[Appartenance à un intervalle]

Soient $a < b$.

• $x ∊ [a ; b]$ signifie $a ≤ x ≤ b$ ;

• $x ∊ ]a ; b]$ signifie $a < x ≤ b$ ;

• $x ∊ [a ; b[$ signifie $a ≤ x < b$ ;

• $x ∊ ]a ; b[$ signifie $a < x < b$.

]

#sous_sous_titre[Amplitude d'un intervalle]

#definition[

Soient $a$ et $b$ deux nombres réels distincts.

L'#strong[amplitude] d'un intervalle ayant pour bornes $a$ et $b$
est la distance entre ces deux nombres.

Elle est notée : #strong[$|a - b|$].



Ainsi, pour tout intervalle borné ayant pour bornes $a$ et $b$ : #strong[$$amplitude$ = |a - b|$].

L'amplitude représente donc la #strong[largeur de la plage de valeurs]
considérée.

]

#exemple_resolu[

Lors de la conception d'un satellite, différentes plages de valeurs
peuvent être utilisées pour définir des tolérances de fabrication.

Déterminons l'amplitude des intervalles suivants.

• Pour $[-8 ; -5]$ :

$|-8 - (-5)| = |-3| = 3$. L'amplitude est donc $3$.

• Pour $]-5 ; 4]$ :

$|-5 - 4| = |-9| = 9$. L'amplitude est donc $9$.

• Pour $]0 ; 4]$ :

$|0 - 4| = |-4| = 4$. L'amplitude est donc $4$.

• Pour $[-4 ; 0[$ :

$|-4 - 0| = |-4| = 4$. L'amplitude est donc $4$.

]

#exemple_resolu[

Lors du contrôle d'une dimension d'un élément du satellite,
on sait que sa valeur $x$ doit vérifier :

$-1 ≤ x ≤ √5 - 1$.

Les deux bornes sont incluses. On obtient :

$x ∊ [-1 ; √5 - 1]$.

Par exemple, les nombres $-1$, $0$ et $1$ appartiennent à cet intervalle.
Cet intervalle représente donc la #strong[plage des valeurs autorisées]
pour la grandeur étudiée.

]

#exemple_resolu[

Un système de positionnement impose que la position $x$ d'un
équipement du satellite vérifie :

$-√2 < x ≤ √2$.

La borne $-√2$ est exclue tandis que la borne $√2$ est incluse.
On obtient donc : $x ∊ ]-√2 ; √2]$.
La position de l'équipement doit ainsi rester dans cette plage.

]

#retenir[

Pour passer d'une inégalité à un intervalle :

• $≤$ ou $≥$ correspond à une #strong[borne incluse] ;

• $<$ ou $>$ correspond à une #strong[borne exclue].

Pour un intervalle borné de bornes $a$ et $b$, son amplitude est : #strong[$|a-b|$.]

Dans une situation de conception d'un satellite, un intervalle peut
représenter une #strong[plage de fonctionnement], une #strong[tolérance
de fabrication] ou une #strong[zone de positionnement autorisée].

]


// ==========================================================
// ACTIVITÉ DE RÉINVESTISSEMENT
// ==========================================================



#mission[

🛰️ #strong[Contrôle d'un élément du satellite]

Lors de la phase finale de conception d'un satellite, une équipe
d'ingénieurs contrôle la position et les dimensions d'un élément
important de sa structure.
Deux grandeurs apparaissent dans les calculs :

$A = √(3 + 2√2)$ et $B = √(3 - 2√2)$.

Ces deux nombres interviennent dans la détermination de certaines
positions et distances du système de contrôle.

]

#strong[1°) Vérification d'une grandeur]

Avant d'utiliser $B$, l'ingénieur doit vérifier que son expression
est bien définie.

Justifie que $3 - 2√2$ est un nombre réel positif.

#strong[2°) Relations entre deux grandeurs]

On donne : $A = √(3 + 2√2)$ et $B = √(3 - 2√2)$.

a) Justifie que $A$ et $B$ sont inverses l'un de l'autre.

b) Calcule :

• $(A + B)^2$ ;

• $(A - B)^2$ ;

• $(A + B)(A - B)$.

#v(0.15cm)

#strong[3°) Simplification des expressions]

Pour simplifier les calculs effectués par le système de contrôle,
calcule :

$(1 + √2)^2$ et $(1 - √2)^2$,

puis donne une écriture simplifiée de $A$ et de $B$.

#v(0.15cm)

#strong[4°) Calcul de rapports et d'écarts]

Dans le système de positionnement du satellite, on doit déterminer
certains rapports et certains écarts.

Calcule :

• $A/B$ 

• $B/A$ 

• $A - B$.

#v(0.15cm)

#strong[5°) Détermination de longueurs exactes]

Deux autres longueurs apparaissent dans les calculs de conception.

Écris chacune des expressions suivantes sous la forme
$a + √b$ ou $a - √b$, où $a$ et $b$ sont des entiers relatifs
et $b ≥ 0$ :

• $√(9 - 4√5)$ ;

• $√(23 + 8√7)$.



#v(4cm)

#correction[

#v(0.1cm)

#strong[1°) Vérification d'une grandeur]

On compare $3$ et $2√2$.

On a : $3^2 = 9$ et $(2√2)^2 = 8$.

Comme $9 > 8$ et que $3 ≥ 0$, $2√2 ≥ 0$, 

alors : $3 > 2√2$.

Donc : $3 - 2√2 > 0$.

Ainsi, $3 - 2√2$ est #strong[positif].

Le nombre $B$ est donc bien défini.

#strong[2°) a) Relation entre $A$ et $B$]

On a : $A × B = √(3 + 2√2) × √(3 - 2√2)$.

Comme les deux radicands sont positifs :

$A × B = √((3 + 2√2)(3 - 2√2))$.

Or : 

$(3 + 2√2)(3 - 2√2)$
$= 3^2 - (2√2)^2$

$(3 + 2√2)(3 - 2√2)$
$= 9 - 8$

$(3 + 2√2)(3 - 2√2)$
$= 1$.

Donc : $A × B = √1 = 1$.

Ainsi : $A × B = 1$.

Par conséquent, $A$ et $B$ sont inverses l'un de l'autre.

#strong[2°) b) Calculs de puissances et de produits]

Comme $A × B = 1$ :

$(A + B)^2 = A^2 + 2 × A × B + B^2$.

Or $A^2 = 3 + 2√2$ et $B^2 = 3 - 2√2$.

Donc :

$(A + B)^2$
$= (3 + 2√2) + 2 + (3 - 2√2)$

$(A + B)^2$
$= 8$.

Ainsi : $(A + B)^2 = 8$.



De même :

$(A - B)^2 = A^2 - 2 × A × B + B^2$

$(A - B)^2 = (3 + 2√2) - 2 + (3 - 2√2)$

Donc : $(A - B)^2 = 4$.

Enfin :

$(A + B)(A - B) = A^2 - B^2$

$(A + B)(A - B) = (3 + 2√2) - (3 - 2√2)$

$(A + B)(A - B) = 4√2$.

Donc : $(A + B)(A - B) = 4√2$.



#v(0.15cm)

#strong[3°) Simplification des expressions]

On a : $(1 + √2)^2 = 1 + 2√2 + 2$

d'où : $(1 + √2)^2 = 3 + 2√2$.

Ainsi :

$A = √((1 + √2)^2)$

$A = |1 + √2|$.

Or : $1 + √2 > 0$.

Donc : $A = 1 + √2$

De même : $(1 - √2)^2 = 1 - 2√2 + 2$

d'où : $(1 - √2)^2 = 3 - 2√2$.

Ainsi :

$B = √((1 - √2)^2)$

$B = |1 - √2|$.

Or $1 < √2$, donc : $1 - √2 < 0$.

Ainsi :

$|1 - √2| = -(1 - √2)$

$|1 - √2| = √2 - 1$.

Donc : $B = √2 - 1$

#strong[4°) Calcul de rapports et d'écarts]

Comme : $A = 1 + √2$ et $B = √2 - 1$,

on obtient :
$A/B = (1 + √2)/(√2 - 1)$.

En multipliant le numérateur et le dénominateur par
l'expression conjuguée $√2 + 1$ :

$A/B = ((1 + √2)(√2 + 1))/((√2 - 1)(√2 + 1))$

$A/B = (1 + √2)^2/(2 - 1)$

$A/B = 3 + 2√2$.

Ainsi : $A/B = 3 + 2√2$

De même $B/A = 3 - 2√2$.

Enfin : 

$A - B = (1 + √2) - (√2 - 1)$

$A - B = 2$.

Donc : $A - B = 2$

Dans le contexte du satellite, cette différence peut représenter
un #strong[écart entre deux positions ou deux grandeurs] exprimées
sur un même axe.

#strong[5°) Détermination de longueurs exactes]

Étudions $√(9 - 4√5)$.

On remarque que :

$9 - 4√5 = 4 - 4√5 + 5$

$9 - 4√5 = 2^2 - 2 × 2 × √5 + (√5)^2$

$9 - 4√5 = (2 - √5)^2$.

Donc :

$√(9 - 4√5) = √((2 - √5)^2)$

$√(9 - 4√5) = |2 - √5|$.

$2^2 = 4 #[et] (√5)^2 = 5$.

Or 4 < 5 donc
$2 < √5$.

Ainsi :
$2 - √5 < 0$.

Par conséquent :
$|2 - √5| = √5 - 2$.

Donc : $√(9 - 4√5) = √5 - 2$

Cette expression donne une #strong[valeur exacte] de la longueur
étudiée.

Étudions maintenant : $√(23 + 8√7)$.

On remarque que :

$23 + 8√7 = 16 + 8√7 + 7$

$23 + 8√7 = 4^2 + 2 × 4 × √7 + (√7)^2$

$23 + 8√7 = (4 + √7)^2$.

Donc :

$√(23 + 8√7) = √((4 + √7)^2)$

$√(23 + 8√7) = |4 + √7|$.

Or $4 + √7 > 0$, donc $√(23 + 8√7) = 4 + √7$

Cette longueur peut donc être conservée sous une #strong[forme exacte]
sans utiliser d'approximation décimale.

#retenir[

Cette activité permet de réinvestir les notions étudiées dans
des calculs liés à la conception et au contrôle d'un satellite :

• la comparaison de nombres contenant des racines carrées ;

• l'étude du signe ;

• la valeur absolue ;

• la propriété $√(a^2) = |a|$ ;

• les identités remarquables ;

• le calcul avec les expressions conjuguées ;

• la simplification d'expressions contenant des racines carrées ;

• le calcul exact de longueurs et d'écarts.

Les nombres réels permettent ainsi aux ingénieurs de représenter
avec précision les #strong[dimensions, positions, distances et écarts]
rencontrés lors de la conception d'un satellite.

]

// ==========================================================
// X — RÉUNION ET INTERSECTION DE DEUX INTERVALLES
// ==========================================================

#sous_titre[
Réunion et intersection de deux intervalles
]

#sous_sous_titre[Intersection de deux intervalles]

#definition[

L'#strong[intersection] de deux intervalles est l'ensemble des
nombres qui appartiennent aux deux intervalles à la fois.
L'intersection de deux intervalles $I$ et $J$ se note : #strong[$I ∩ J$].

Ainsi, un nombre $x$ appartient à $I ∩ J$ si et seulement si $x$ appartient à $I$ #strong[et] à $J$. Dans la conception d'un satellite, l'intersection peut représenter
la #strong[plage de valeurs qui respecte simultanément deux contraintes].

]

#v(2cm)

#exemple_resolu[

🛰️ #strong[Contrôle de deux contraintes de fonctionnement]

Pour un équipement du satellite, deux contraintes sont imposées
à une même grandeur $x$ :

• la première contrainte impose : $x ∊ ]← ; 1,5[$ ;

• la seconde impose : $x ∊ ]-3 ; →[$.

Pour respecter les deux contraintes à la fois, $x$ doit appartenir
aux deux intervalles.

Il doit donc vérifier : $x < 1,5$ et $x > -3$.

Ainsi : $-3 < x < 1,5$.

On obtient : $]← ; 1,5[ ∩ ]-3 ; →[ = ]-3 ; 1,5[$

La plage de fonctionnement compatible avec les deux contraintes
est donc : $]-3 ; 1,5[$.

]

#propriete[

Pour déterminer une intersection, on recherche la partie
#strong[commune] aux deux intervalles.

Dans une situation de conception, l'intersection correspond donc
aux valeurs qui satisfont #strong[toutes les contraintes imposées
simultanément].

]

#sous_sous_titre[Réunion de deux intervalles]

#definition[

La #strong[réunion] de deux intervalles est l'ensemble des nombres
qui appartiennent à au moins l'un des deux intervalles.
La réunion de deux intervalles $I$ et $J$ se note : #strong[$I ∪ J$].
Ainsi, un nombre $x$ appartient à $I ∪ J$ si et seulement si
$x$ appartient à $I$ #strong[ou] à $J$.
Dans la conception d'un satellite, la réunion peut représenter
l'ensemble des valeurs acceptées par #strong[au moins l'une de
plusieurs conditions ou zones de fonctionnement].

]

#exemple_resolu[

🛰️ #strong[Deux plages de fonctionnement possibles]

Un système embarqué peut fonctionner dans l'une des deux plages
suivantes :

$I = ]-5 ; 4[$ ou $J = ]0 ; 9]$.

Les deux plages se recouvrent entre $0$ et $4$.

En réunissant les deux plages, on obtient tous les nombres
strictement supérieurs à $-5$ et inférieurs ou égaux à $9$.

Ainsi : $]-5 ; 4[ ∪ ]0 ; 9] = ]-5 ; 9]$

La réunion représente donc l'ensemble des valeurs permettant
le fonctionnement du système dans #strong[au moins l'une des
deux plages].

]

#propriete[

Pour déterminer une réunion, on recherche tous les nombres qui
appartiennent à #strong[l'un au moins] des deux intervalles.

Lorsque deux intervalles se recouvrent ou se touchent, leur réunion
peut être un seul intervalle.

]

#exemple_resolu[

🛰️ #strong[Deux plages de tolérance qui se touchent]

Lors de la fabrication d'un élément du satellite, deux plages
de tolérance sont considérées :

$I = [-2 ; 3]$ et $J = [3 ; 7[$.

Les deux intervalles ont le nombre $3$ en commun.

La réunion des deux plages est donc :
$I ∪ J = [-2 ; 7[$

Cela signifie que l'ensemble des valeurs couvertes par les
deux plages s'étend de $-2$ inclus à $7$ exclu.

]

#v(4cm)

#remarque[

Il ne faut pas confondre les deux opérations :

• $I ∩ J$ correspond à la partie #strong[commune] aux deux
intervalles ;

• $I ∪ J$ correspond à l'ensemble des nombres appartenant à
#strong[l'un au moins] des deux intervalles.

On peut retenir :

#strong[Intersection → ET]

#strong[Réunion → OU]

Dans une situation de conception :

• l'#strong[intersection] correspond aux valeurs qui respectent
plusieurs contraintes simultanément ;

• la #strong[réunion] correspond aux valeurs qui appartiennent
à au moins une des plages considérées.

]

#sous_sous_titre[Application au contrôle d'un satellite]

#exercice_resolu[

🛰️ #strong[Contrôle de plages de fonctionnement]

Un ingénieur étudie différentes plages de fonctionnement d'un
système du satellite.
Représente sur un axe gradué les réunions des intervalles suivants.

#strong[a)] Première étude : $]-5 ; 4[$ et $]-4 ; 4]$.

Les deux plages ne se recouvrent pas.
On obtient alors :
#align(center)[
$]-5 ; -4[ ∪ ]-4 ; 4] = ]-5 ; -4[ ∪ ]-4 ; 4]$.
]
#align(center)[
#image_full("reunion-1.png")
]

#strong[b)] Deuxième étude : $]← ; 7[$ et $]4√2 ; 11,33]$.

Comme : $4√2 ≈ 5,657$,

on a : $4√2 < 7$.
Les deux intervalles se recouvrent donc.

Ainsi : $]← ; 7[ ∪ ]4√2 ; 11,33] = ]← ; 11,33]$

#align(center)[
#image_full("reunion-2.png")
]

#strong[c)] Troisième étude : $]-2/3 ; 5[$ et $[3 ; √65]$.

On remarque que : $√65 ≈ 8,062$.

Les deux intervalles se recouvrent entre $3$ et $5$.

On obtient donc : 

$]-2/3 ; 5[ ∪ [3 ; √65] = ]-2/3 ; √65]$

#align(center)[
#image_full("reunion-3.png")
]

]

#exemple_resolu[

🛰️ #strong[Recherche d'une plage compatible avec deux contraintes]

Lors du contrôle d'un panneau solaire, deux contraintes sont
imposées à une dimension $x$ :

$x ∊ [2 ; 6]$ et $x ∊ ]4 ; 8[$.

Pour que la dimension respecte les deux contraintes simultanément,
elle doit appartenir à leur intersection.

On cherche donc la partie commune :

#align(center)[
$[2 ; 6] ∩ ]4 ; 8[ = ]4 ; 6]$

La plage réellement acceptable est donc :
#strong[$]4 ; 6]$].

Cette plage correspond aux valeurs qui respectent simultanément
les deux contraintes de conception.
]

#exemple_resolu[

🛰️ #strong[Deux possibilités de fonctionnement]

Un système de communication du satellite peut fonctionner dans
l'une des deux plages suivantes :
$I = [1 ; 3]$ ou $J = [5 ; 7]$.

Les deux intervalles ne se recouvrent pas.

La réunion est donc constituée de deux intervalles distincts :

$I ∪ J = [1 ; 3] ∪ [5 ; 7]$

Il existe donc deux plages de fonctionnement possibles.

]

#v(2cm)

#retenir[

Pour deux intervalles $I$ et $J$ :

$*$$I ∩ J$ : partie commune aux deux intervalles.

$*$$I ∪ J$ : ensemble des nombres appartenant à $I$ ou à $J$ ou aux deux.

Dans les problèmes liés au satellite :

$*$#strong[Intersection → toutes les contraintes doivent être respectées.]

$*$#strong[Réunion → au moins une des possibilités est acceptée.]

L'intersection permet donc de déterminer une #strong[plage compatible avec plusieurs contraintes], tandis que la réunion permet de regrouper plusieurs #strong[plages ou possibilités de fonctionnement].
]
]
]]]