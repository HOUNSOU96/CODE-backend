#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let fractions_rationnels() = [

#debut_notion()
// ==========================================================
// TITRE DE LA NOTION
// ==========================================================
#pagebreak()



#title(
  [IV — LES FRACTIONS],
  "notion-fractions",
) <notion-fractions>

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
🌍 Quand les nombres entiers ne suffisent plus
]

Lorsque l'être humain
a commencé à #strong[mesurer, partager et échanger] des quantités, une nouvelle difficulté est apparue:

Imagine un agriculteur qui possède une récolte et souhaite
la partager équitablement entre plusieurs personnes.
S'il possède $5$ sacs et veut les partager entre $2$ personnes,
les nombres entiers permettent d'écrire :
$5 = 2 + 2 + 1$.
Mais cette écriture ne décrit pas un partage parfaitement
équitable si le dernier sac doit lui aussi être partagé.
L'être humain a alors rencontré une nouvelle question :

#align(center)[
#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
« Comment représenter une quantité qui est une partie d'un tout ? »
]
]

Le même problème apparaît lorsqu'on mesure une longueur.
Supposons qu'une corde mesure $1$ mètre et qu'on souhaite
la partager en $2$ parties de même longueur.
Chaque partie mesure moins d'un mètre.
Le nombre entier $0$ ne convient pas, car la partie existe bien,
et le nombre entier $1$ ne convient pas non plus, car la partie
est plus petite qu'un mètre.
Il fallait donc inventer une nouvelle manière d'écrire
#strong[les parties d'une unité].
C'est ainsi que les fractions sont devenues indispensables
pour représenter des quantités telles que :

$1/2$, $1/3$, $3/4$, $5/8$...

Les fractions permettent donc d'exprimer précisément
#strong[une partie d'une unité ou d'une quantité].
// ----------------------------------------------------------
// DES MESURES AUX FRACTIONS
// ----------------------------------------------------------

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
📏 Mesurer : une nouvelle difficulté
]

L'apparition des fractions est également liée au développement
des #strong[mesures].
Pour construire une habitation, partager un terrain, fabriquer
un objet ou organiser une récolte, il ne suffisait plus
seulement de compter.
Il fallait aussi mesurer des #strong[longueurs, surfaces,
masses et capacités].
Or, une mesure ne correspond pas toujours exactement
à un nombre entier d'unités.
Par exemple, une planche peut mesurer plus de $2$ mètres
mais moins de $3$ mètres.
On peut alors chercher combien de parties égales d'un mètre
il faut pour représenter précisément cette longueur.

Si une unité est partagée en $4$ parties égales et qu'on
en utilise $3$, on obtient :
$3/4$ de l'unité.

La fraction permet ainsi de donner une écriture précise
à une quantité située #strong[entre deux nombres entiers].


// ----------------------------------------------------------
// PARTAGER ÉQUITABLEMENT
// ----------------------------------------------------------

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
⚖️ Partager sans gaspiller
]

Les échanges et les partages ont également joué un rôle
important dans le développement des fractions.
Lorsqu'une quantité devait être distribuée équitablement,
il fallait pouvoir représenter la part reçue par chaque personne.
Supposons qu'un groupe de $4$ personnes se partage
équitablement une même quantité.
Chaque personne reçoit une partie correspondant à :
$1/4$
de la quantité totale.

Si une personne reçoit $3$ de ces parts égales, elle reçoit :
$3/4$
de la quantité totale.

Les fractions permettent donc de décrire non seulement
#strong[le nombre de parts], mais aussi #strong[la part d'un tout]
qui revient à une personne.

]
// ----------------------------------------------------------
// DES PARTS AUX ÉCRITURES MATHÉMATIQUES
// ----------------------------------------------------------
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
🔢 Comment écrire une fraction ?
]

Pour représenter une quantité obtenue en partageant une unité
en plusieurs parts égales, les mathématiciens utilisent
une écriture particulière :
$3/4$.

Dans cette écriture :

• le nombre $4$ indique en combien de #strong[parts égales]
  l'unité a été partagée ;

• le nombre $3$ indique combien de ces #strong[parts] sont
  considérées.

Le nombre placé au-dessus de la barre est appelé
le #strong[numérateur].

Le nombre placé au-dessous de la barre est appelé
le #strong[dénominateur].

#exemple[
Dans la fraction $3/5$ :

$3$ est le #strong[numérateur] ;

$5$ est le #strong[dénominateur].

Cela signifie que l'unité a été partagée en $5$ parts égales
et que l'on considère $3$ de ces parts.
]


// ----------------------------------------------------------
// UNE NOUVELLE FAMILLE DE NOMBRES
// ----------------------------------------------------------

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🧩 Des quantités entre les entiers
]

Les fractions permettent ainsi de représenter des nombres
qui ne sont pas nécessairement des entiers naturels.

Par exemple :
$0 < 1/2 < 1$
et
$1 < 3/2 < 2$.

Entre deux nombres entiers, il peut donc exister
de nombreuses autres valeurs.
Les fractions permettent de représenter ces valeurs
avec précision.
Elles deviennent alors indispensables dans de nombreux
domaines : #strong[mesure, commerce, agriculture, construction,
sciences, cuisine, mécanique et technologie].


// ----------------------------------------------------------
// DES FRACTIONS DANS LA VIE QUOTIDIENNE
// ----------------------------------------------------------

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🌍 Les fractions autour de nous
]

Aujourd'hui encore, nous utilisons quotidiennement
les fractions sans toujours nous en rendre compte.

On peut parler :

• d'une #strong[demi-heure] : $1/2$ heure ;

• d'un #strong[quart de litre] : $1/4$ L ;

• de #strong[trois quarts] d'un terrain : $3/4$ ;

• d'une #strong[demi-distance] : $1/2$ de la distance ;

• d'une #strong[portion] d'une quantité ;

• d'une #strong[partie] d'une longueur, d'une surface
  ou d'une masse.

Les fractions sont donc nées d'un besoin fondamental :

#align(center)[
#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
« Compter ne suffit pas toujours : il faut aussi pouvoir mesurer
et partager les parties d'un tout. »
]
]

Elles prolongent ainsi naturellement l'utilisation
des nombres entiers naturels.
]

// ==========================================================
// OBJECTIFS DE LA NOTION
// ==========================================================
#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[
#objectif[

À travers cette notion, l'apprenant doit être capable de :

• reconnaître et lire une fraction ;

• identifier le #strong[numérateur] et le
  #strong[dénominateur] d'une fraction ;

• interpréter une fraction comme une #strong[partie d'un tout] ;

• représenter une fraction à l'aide d'une figure ou d'une
  quantité ;

• placer et repérer des fractions simples sur une droite graduée ;

• comparer des fractions dans des situations simples ;

• déterminer des fractions équivalentes ;

• simplifier une fraction lorsque cela est possible ;

• effectuer des calculs simples avec les fractions ;

• utiliser les fractions pour résoudre des problèmes de
  #strong[partage et de mesure] ;

• reconnaître l'utilité des fractions dans les situations
  de la vie quotidienne.

]

]

#v(0.2cm)

#align(center)[

#image_full("fractions-origine.jpeg")

]

#pagebreak()



// ==========================================================
// PARCOURS 6e
// FRACTIONS DANS LA CUISINE ET LA TRANSFORMATION ALIMENTAIRE
// ==========================================================

#parcours(
  [PARCOURS 6ᵉ — Découvrir les fractions avec la cuisine et la transformation alimentaire],
  "parcours-fractions-6e",
) <parcours-fractions-6e>


// ----------------------------------------------------------
// ACTIVITÉ DE DÉCOUVERTE
// ----------------------------------------------------------

#activite[

🍲 À la découverte de la cuisine et de la transformation alimentaire

La cuisine ne consiste pas seulement à mélanger des aliments.

Pour préparer un plat, une boisson ou un produit alimentaire,
il faut #strong[choisir les ingrédients, mesurer les quantités,
respecter les proportions, mélanger, cuire, refroidir,
conserver et parfois partager la préparation].

Ces différentes opérations sont réalisées aussi bien à la maison
que dans les restaurants, les boulangeries, les entreprises
agroalimentaires et les ateliers de transformation alimentaire.

Prenons l'exemple d'un atelier qui prépare une boisson à base
de fruits.

Pour fabriquer une certaine quantité de boisson, le responsable
doit connaître la quantité de chaque ingrédient.

Il peut utiliser :

• de l'eau ;

• du jus de fruit ;

• du sucre ;

• des arômes ou d'autres ingrédients.

Les quantités doivent être mesurées avec précision.

Par exemple, pour préparer une recette, on peut utiliser
$1L$ d'eau et une quantité de jus correspondant à la moitié
de cette quantité.
On peut alors écrire :
$1/2$.

Cette écriture signifie que l'on prend #strong[une partie d'une
quantité entière].

De la même manière, si une préparation est partagée en quatre
parts égales et que l'on en utilise trois, on peut représenter
la quantité utilisée par :
$3/4$.

La cuisine conduit donc naturellement à partager des quantités
en #strong[parts égales].

Avant de préparer une recette, le professionnel doit également
savoir #strong[adapter les quantités].

Une recette prévue pour quatre personnes peut devoir être
préparée pour deux personnes.

Il faut alors prendre une partie de chacune des quantités
prévues dans la recette.

Une recette peut également être préparée en grande quantité.
Il faut alors multiplier les quantités initiales.

Dans tous ces cas, il est nécessaire de savoir représenter
et calculer des #strong[parties d'une quantité].
]


#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[
Observe les situations suivantes :

1. Une tablette de chocolat est divisée en $4$ morceaux égaux.
   On utilise $1$ morceau.

2. Une pâte est divisée en $8$ portions égales.
   On utilise $3$ portions.

3. Une bouteille contient $1\,L$ de jus.
   On utilise la moitié du contenu.

4. Une recette demande $3/4$ de kilogramme de farine.

5. Un gâteau est découpé en $6$ parts égales et $5$ parts
   sont distribuées.

6. Une préparation est divisée en $10$ portions égales.
   On utilise $7$ portions.

#v(0.12cm)

1. Dans chacune de ces situations, quelle est la quantité
   entière de départ ?

2. En combien de parts égales cette quantité est-elle divisée ?

3. Combien de parts sont utilisées ?

4. Comment peut-on représenter la quantité utilisée ?

5. Que signifie le nombre situé au-dessus de la barre ?

6. Que signifie le nombre situé au-dessous de la barre ?

7. Peut-on écrire plusieurs fractions différentes pour
   représenter une même quantité ?

8. Comment pourrait-on calculer une partie d'une quantité ?

9. Une recette nécessite $2/3$ de kilogramme de farine.
   Comment pourrait-on déterminer cette quantité si l'on
   dispose d'une masse totale de $3\,k g$ ?

10. Pourquoi les fractions peuvent-elles être utiles à un
    cuisinier, un pâtissier ou un transformateur alimentaire ?

La cuisine et la transformation alimentaire montrent donc
qu'une quantité entière peut être #strong[partagée en plusieurs
parts égales] et qu'il est nécessaire de pouvoir représenter
ces parts.

Les mathématiques disposent d'un outil particulièrement adapté
à cette situation : #strong[la fraction].

Nous allons maintenant découvrir comment écrire, lire,
représenter et utiliser les fractions.
]


#v(0.3cm)

#align(center)[

#image_full("fractions-6e.jpeg")

]

#pagebreak()


// ==========================================================
// DEFINITION 1
// ==========================================================

#deux-colonnes[

#sous_titre[
  Découvrir la notion de fraction
]

#definition[
Une fraction est une écriture de la forme :
#strong[$frac(a, b)$]

où $a$ et $b$ sont des entiers naturels et $b ≠ 0$.

On peut également noter cette fraction :
#strong[a/b].

Le nombre $a$ placé au-dessus de la barre est appelé
le #strong[numérateur].

Le nombre $b$ placé au-dessous de la barre est appelé
le #strong[dénominateur].

Les nombres $a$ et $b$ sont les #strong[termes de la fraction].
]

// ==========================================================
// A RETENIR
// ==========================================================

#retenir[
Dans la fraction $a/b$ :

• $a$ est le #strong[numérateur] ;

• $b$ est le #strong[dénominateur] ;

• le dénominateur indique en combien de parts égales
  l'unité est partagée ;

• le numérateur indique combien de ces parts sont considérées ;

• le dénominateur ne peut jamais être égal à $0$.
]

// ==========================================================
// REMARQUES
// ==========================================================

#remarque[
Une fraction permet de représenter une partie d'une unité
ou d'une quantité.
Lorsque le numérateur est inférieur au dénominateur,
la fraction représente une quantité inférieure à $1$.
]

#exemple[
Une tablette de chocolat est divisée en $8$ morceaux égaux.
Si on prend $3$ morceaux, la partie prise est :
$3/8$.

Le nombre $8$ indique que la tablette entière a été divisée
en $8$ parts égales.

Le nombre $3$ indique que $3$ de ces parts ont été prises.
Ainsi :
$3/8$ de la tablette a été utilisée.
]

// ==========================================================
// LIRE UNE FRACTION
// ==========================================================

#sous_titre[
Lire une fraction
]

#definition[
Pour lire une fraction, on lit d'abord le numérateur puis
le dénominateur.

Lorsque le dénominateur est :

• $2$, on utilise « demi » ;

• $3$, on utilise « tiers » ;

• $4$, on utilise « quarts » ;

• $5$, on utilise « cinquièmes » ;

• $6$, on utilise « sixièmes » ;

• $7$, on utilise « septièmes » ;

• $8$, on utilise « huitièmes » ;

• $9$, on utilise « neuvièmes » ;

• $10$, on utilise « dixièmes ».
]

#exemple[
Dans un atelier de pâtisserie, un gâteau est partagé
en $8$ parts égales.
Si l'on considère $3$ parts, on obtient :
$3/8$.

On lit :
#strong[« trois huitièmes »].
]

#exemple[
On lit :

$1/2$ → un demi ;

$2/3$ → deux tiers ;

$3/4$ → trois quarts ;

$5/6$ → cinq sixièmes ;

$7/10$ → sept dixièmes.
]


#v(5cm)


// ==========================================================
// REPRESENTATION D'UNE FRACTION
// ==========================================================

#sous_titre[
Représenter une fraction
]

#definition[
Pour représenter une fraction d'une unité, on partage cette
unité en un nombre de parts égales indiqué par le dénominateur,
puis on considère le nombre de parts indiqué par le numérateur.
]

#exemple[
Un gâteau entier représente l'unité.

On le partage en $4$ parts égales.

Si l'on prend $3$ parts, on représente :
$3/4$.

Ainsi, le dénominateur $4$ indique le nombre de parts égales
et le numérateur $3$ indique le nombre de parts considérées.
]

#retenir[
Pour représenter une fraction :

1. je partage l'unité en parts égales ;

2. le nombre de parts est donné par le dénominateur ;

3. je considère le nombre de parts indiqué par le numérateur.
]

// ==========================================================
// FRACTIONS ET PARTIES D'UNE QUANTITE
// ==========================================================

#sous_titre[
Fraction d'une quantité
]

#definition[
Pour déterminer une fraction d'une quantité, on peut :

1. diviser la quantité par le dénominateur ;

2. multiplier le résultat obtenu par le numérateur.
]


#v(2cm)

#exemple_resolu[
Un atelier dispose de $12k g$ de farine.

Pour une préparation, on utilise les $2/3$ de cette quantité.

Cherchons la quantité de farine utilisée.

On partage d'abord les $12k g$ en $3$ parts égales :
$12 ÷ 3 = 4$.

Une part représente donc $4k g$.

On prend ensuite $2$ parts :
$2 × 4 = 8$.

Donc :
$2/3 × 12 = 8$.

L'atelier utilise donc :
#strong[$8k g$ de farine.]
]

#exemple[
Une cuisinière dispose de $20L$ de jus.

Elle utilise $3/5$ de cette quantité.

On calcule :
$20 ÷ 5 = 4$

puis :
$4 × 3 = 12$.

Donc :
$3/5 × 20 = 12$.

Elle utilise $12L$ de jus.
]


// ==========================================================
// FRACTIONS EGALES
// ==========================================================

#sous_titre[
Découvrir les fractions égales
]

#definition[
Deux fractions sont #strong[égales] lorsqu'elles représentent
la même quantité.
]

#exemple_resolu[
Un gâteau est partagé en $2$ parts égales.

On considère une seule part :
$1/2$.

On peut maintenant partager chacune des deux parts en
$2$ nouvelles parts.
Le gâteau est alors partagé en $4$ parts égales.
La moitié du gâteau correspond toujours à $2$ parts sur $4$ :
$1/2 = 2/4$.

On peut encore partager chaque part en $2$.
Le gâteau est alors partagé en $8$ parts égales et la moitié
correspond à $4$ parts :
$1/2 = 2/4 = 4/8$.
]

#retenir[
On obtient une fraction égale à une fraction donnée en
multipliant ou en divisant son numérateur et son dénominateur
par un même nombre non nul, lorsque cette opération est possible.
]

#exemple[
On a :
$2/3 = 4/6 = 6/9$.

En effet :

$2 × 2 = 4$ et $3 × 2 = 6$ ;

$2 × 3 = 6$ et $3 × 3 = 9$.
]


// ==========================================================
// FRACTIONS DECIMALES
// ==========================================================

#sous_titre[
Découvrir les fractions décimales
]

#definition[
Une fraction décimale est une fraction dont le dénominateur
est $10$, $100$, $1000$, $10000$, etc.
]

#exemple[
Dans un atelier, une quantité de sucre peut être exprimée
en kilogrammes.

On a :
$3/10k g = 0,3k g$.

De même :
$25/100k g = 0,25k g$.
et 
$125/1000k g = 0,125k g$.
]

#exemple[
Écrivons les nombres décimaux suivants sous forme de fractions :

$1,36 = 136/100$

$0,065 = 65/1000$

$4,125 = 4125/1000$

$5,3 = 53/10$.
]


#v(0.35cm)


// ==========================================================
// COMPARER DES FRACTIONS DE MEME DENOMINATEUR
// ==========================================================

#sous_titre[
Comparer des fractions de même dénominateur
]

#definition[
Lorsque deux fractions ont le même dénominateur,
la plus grande est celle qui possède le plus grand numérateur.
]

#exemple[
Deux préparations utilisent des parties différentes
d'une même quantité de farine.

On compare :
$3/8$ et $5/8$.

Les deux fractions ont le même dénominateur $8$.

On compare donc les numérateurs :
$3 < 5$.

Ainsi :
$3/8 < 5/8$.
]

#exemple[
On compare :
$7/10$ et $4/10$.

Comme :
$7 > 4$,

on a :
$7/10 > 4/10$.
]

#retenir[
Pour comparer deux fractions de même dénominateur,
je compare leurs numérateurs.

Le plus grand numérateur correspond à la plus grande fraction.
]

// ==========================================================
// SOMME DE DEUX FRACTIONS
// ==========================================================

#sous_titre[
Additionner des fractions de même dénominateur
]

#definition[
Pour additionner deux fractions de même dénominateur,
on conserve le dénominateur et on additionne les numérateurs.
]

#v(0.2cm)

#exemple_resolu[
Une pâte est préparée en plusieurs étapes.

Au cours de la première étape, on utilise $2/7$ de la quantité
prévue.

Au cours de la deuxième étape, on utilise $3/7$.

La quantité totale utilisée est :
$2/7 + 3/7$

On conserve le dénominateur $7$ et on additionne les numérateurs :
$2 + 3 = 5$.

Donc :
$2/7 + 3/7 = 5/7$.
]

#exemple[
Calculons :
$3/8 + 2/8$.

On a :
$3/8 + 2/8 = (3 + 2)/8$

donc :
$3/8 + 2/8 = 5/8$.
]

// ==========================================================
// SOUSTRACTION DE DEUX FRACTIONS
// ==========================================================

#sous_titre[
Soustraire des fractions de même dénominateur
]

#definition[
Pour soustraire deux fractions de même dénominateur,
on conserve le dénominateur et on soustrait les numérateurs.
]

#exemple_resolu[
Une préparation correspond à une quantité entière.

On utilise d'abord $5/8$ de cette quantité.

Il reste donc :
$1 - 5/8$.

On écrit $1$ sous la forme $8/8$ :

$1 - 5/8 = 8/8 - 5/8$.

Donc :
$1 - 5/8 = 3/8$.

Il reste $3/8$ de la quantité initiale.
]

#v(2cm)

#exemple[
Calculons :
$7/9 - 2/9$.

On a :
$7/9 - 2/9 = (7 - 2)/9$

donc :
$7/9 - 2/9 = 5/9$.
]

// ==========================================================
// PRODUIT D'UNE FRACTION PAR UN ENTIER
// ==========================================================

#sous_titre[
Multiplier une fraction par un entier
]

#definition[
Pour multiplier une fraction par un entier naturel,
on peut multiplier le numérateur par cet entier
et conserver le même dénominateur.
]

#exemple_resolu[
Une recette nécessite $2/3k g$ de farine pour une préparation.

Un atelier doit réaliser $4$ préparations identiques.

La quantité totale de farine nécessaire est :
$4 × 2/3$.

On multiplie le numérateur par $4$ :
$4 × 2/3 = 8/3$.

Ainsi, il faut :
$8/3k g$ de farine.
]

#exemple[
Calculons :
$3 × 2/5$.

On a :
$3 × 2/5 = 6/5$.
]

// ==========================================================
// PRODUIT DE DEUX FRACTIONS
// ==========================================================

#sous_titre[
Multiplier deux fractions
]

#v(0.12cm)

#definition[
Pour multiplier deux fractions, on multiplie les numérateurs
entre eux et les dénominateurs entre eux :

$a/b × c/d = (a × c)/(b × d)$.

Les dénominateurs sont non nuls.
]

#v(0.2cm)

#exemple_resolu[
Pour confectionner une préparation, un cuisinier utilise
$2/3$ d'une quantité de farine.

Parmi cette quantité, il utilise ensuite $3/4$ pour une
préparation particulière.

La part de la quantité initiale utilisée est :
$2/3 × 3/4$.

On multiplie les numérateurs :
$2 × 3 = 6$.

Puis les dénominateurs :
$3 × 4 = 12$.

Donc :
$2/3 × 3/4 = 6/12$.
Or :
$6/12 = 1/2$.

Donc la quantité utilisée représente la moitié
de la quantité initiale.
]

// ==========================================================
// VALEUR APPROCHEE D'UNE FRACTION
// ==========================================================

#sous_titre[
Approcher une fraction par un nombre décimal
]

#definition[
Lorsqu'une fraction ne possède pas d'écriture décimale exacte,
on peut chercher une valeur décimale approchée.
Cette valeur peut être obtenue par défaut ou par excès
à un ordre donné.
]

#exemple_resolu[
Un atelier doit partager équitablement une quantité de
$13k g$ entre $3$ récipients.
Chaque récipient reçoit :
$13/3k g$.

Or :
$13 ÷ 3 = 4,3333...$
Donc :
$13/3 ≈ 4,33$.

À $1/100$ près :

• une valeur approchée par défaut est $4,33$ ;

• une valeur approchée par excès est $4,34$.
]

#exemple[
On a :
$26/9 = 2,8888...$

À $1/100$ près :

$2,88 < 26/9 < 2,89$.

On peut donc utiliser $2,88$ comme valeur approchée
par défaut et $2,89$ comme valeur approchée par excès.
]

// ==========================================================
// TRAVAIL SUR LES FRACTIONS EQUIVALENTES
// ==========================================================

#sous_titre[
Simplifier une fraction
]

#definition[
Simplifier une fraction consiste à trouver une fraction égale
dont les termes sont plus petits, en divisant le numérateur
et le dénominateur par un même diviseur commun non nul.
]

#exemple_resolu[
Dans une recette, une quantité est représentée par :

$12/18$.

Le numérateur et le dénominateur sont divisibles par $6$.

On obtient :
$12/18 = (12 ÷ 6)/(18 ÷ 6)$.

Donc :
$12/18 = 2/3$.

La fraction $2/3$ est une forme simplifiée de $12/18$.
]

// ==========================================================
// REINVESTISSEMENT — CUISINE ET TRANSFORMATION ALIMENTAIRE
// ==========================================================

#sous_titre[
RÉINVESTISSEMENT — Préparer une production alimentaire
]


#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
🍲 Mission — Préparer une boisson pour une production
]

Un petit atelier de transformation alimentaire prépare
une boisson à base de fruits.

Pour une production, l'atelier dispose de $12L$ de jus.
Le responsable décide d'utiliser :
$2/3$
du jus pour remplir les bouteilles destinées aux clients.


// ----------------------------------------------------------
// QUESTION 1
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
1. Déterminer la quantité de jus utilisée
]

On cherche :
$2/3 × 12$.

On partage d'abord les $12L$ en $3$ parts égales :
$12 ÷ 3 = 4$.

Une part représente donc $4L$.

On prend $2$ parts :
$2 × 4 = 8$.

Donc :
$2/3 × 12 = 8$.

L'atelier utilise :
#strong[$8L$ de jus.]


// ----------------------------------------------------------
// QUESTION 2
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
2. Déterminer la quantité restante
]

La quantité totale correspond à :
$1$.

La quantité utilisée correspond à :
$2/3$.

La quantité restante est donc :
$1 - 2/3$.

On écrit :
$1 = 3/3$.

Ainsi :
$1 - 2/3 = 3/3 - 2/3$.

Donc :
$1 - 2/3 = 1/3$.

Il reste donc :
#strong[$1/3$ du jus initial.]

En quantité :
$12 × 1/3 = 4$.

Il reste donc :
#strong[$4L$ de jus.]


// ----------------------------------------------------------
// QUESTION 3
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
3. Adapter la production
]

L'atelier souhaite maintenant préparer deux fois cette
quantité de boisson.
La quantité de jus utilisée devient :
$2 × 8 = 16L$.

On peut également écrire :
$2 × 2/3 = 4/3$.

Ainsi :
$4/3 × 12 = 16$.

Il faudra donc :
#strong[$16L$ de jus.]


// ----------------------------------------------------------
// QUESTION 4
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
4. Partager la production
]

L'atelier répartit les $16L$ de jus dans $8$ récipients
de même capacité.

La quantité versée dans chaque récipient est :

$16 ÷ 8 = 2L$.

Chaque récipient contient donc :
#strong[$2L$.]


// ----------------------------------------------------------
// QUESTION 5
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
5. Fraction correspondant à plusieurs récipients
]

Deux récipients contiennent :
$2 × 2 = 4L$.

La production totale est de $16L$.

La part correspondante est donc :
$4/16$.

On simplifie :
$4/16 = 1/4$.

Ainsi, deux récipients représentent :

#strong[$1/4$ de la production totale.]


// ----------------------------------------------------------
// QUESTION 6
// ----------------------------------------------------------

#v(2cm)

#text(
  weight: "bold",
)[
6. Une nouvelle recette
]

Une nouvelle recette utilise $3/5$ d'une quantité de
$20k g$ de fruits.

Déterminons la quantité de fruits utilisée.

On calcule :
$20 ÷ 5 = 4$

puis :
$4 × 3 = 12$.

Donc :
$3/5 × 20 = 12$.

La nouvelle recette nécessite :
#strong[$12k g$ de fruits.]


// ----------------------------------------------------------
// QUESTION 7
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
7. Comparer deux quantités
]

Deux recettes utilisent respectivement :

$3/8$
et
$5/8$
d'une même quantité de fruits.

Comme les dénominateurs sont identiques, on compare
les numérateurs :
$3 < 5$.

Donc :
$3/8 < 5/8$.

La deuxième recette utilise une plus grande part
de la quantité disponible.


// ----------------------------------------------------------
// QUESTION 8
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
8. Bilan
]

Dans cette mission, nous avons utilisé les fractions pour :

• représenter une partie d'une quantité ;

• calculer une fraction d'une quantité ;

• déterminer une quantité restante ;

• multiplier une fraction par un entier ;

• comparer des fractions ;

• trouver des fractions égales ;

• simplifier une fraction ;

• partager une production.

Les fractions constituent donc un outil essentiel pour
exprimer et calculer des #strong[parts de quantités].
]


// ==========================================================
// A RETENIR — SYNTHESE
// ==========================================================

#v(8cm)

#retenir[
#strong[Les idées essentielles]

• Une fraction s'écrit sous la forme $a/b$ avec $b ≠ 0$.

• $a$ est le #strong[numérateur].

• $b$ est le #strong[dénominateur].

• Le dénominateur indique le nombre de parts égales
  dans lesquelles l'unité est partagée.

• Le numérateur indique le nombre de parts considérées.

• Deux fractions peuvent être différentes dans leur écriture
  tout en représentant la même quantité.

• Pour calculer une fraction d'une quantité, on divise
  d'abord par le dénominateur puis on multiplie par
  le numérateur.

• Pour additionner ou soustraire des fractions de même
  dénominateur, on conserve le dénominateur et on effectue
  l'opération sur les numérateurs.

• Pour multiplier deux fractions, on multiplie les
  numérateurs entre eux et les dénominateurs entre eux.

• Une fraction peut également être utilisée pour représenter
  une proportion, une part d'une production ou une quantité
  utilisée dans une recette.
]

]




#pagebreak()































// ==========================================================
// PARCOURS 5e
// FRACTIONS ET PROPORTIONS DANS ℚ
// AVEC L'INTELLIGENCE ARTIFICIELLE
// ==========================================================


#parcours(
  [PARCOURS 5ᵉ — Fractions et proportions avec l'intelligence artificielle],
  "parcours-fractions-5e",
) <parcours-fractions-5e>




// ==========================================================
// MISE EN SITUATION
// ==========================================================

#activite[

🤖 #strong[La découverte de l'intelligence artificielle : analyser des données]

Avant de découvrir comment l'#strong[intelligence artificielle (IA)]
peut utiliser les fractions, commençons par comprendre les deux
mots qui composent cette expression : #strong[intelligence] et
#strong[artificielle].

#strong[Intelligence]

L'#strong[intelligence] est la capacité d'un être vivant à
#strong[comprendre, apprendre, raisonner, résoudre des problèmes
et prendre des décisions].

Par exemple, un élève utilise son intelligence lorsqu'il observe
un problème, réfléchit aux informations données et cherche une
solution.

#strong[Artificielle]

Le mot #strong[artificielle] signifie qu'une chose a été
#strong[créée ou fabriquée par l'être humain], plutôt que de
provenir naturellement de la nature.

Par exemple, une plante est naturelle, tandis qu'un robot est une
création artificielle de l'être humain.

#strong[Intelligence artificielle]

L'#strong[intelligence artificielle], souvent abrégée #strong[IA],
désigne un ensemble de techniques permettant à une machine ou à
un programme informatique de réaliser certaines tâches qui
nécessitent habituellement des capacités humaines, comme
#strong[apprendre, reconnaître, analyser, raisonner ou prendre une
décision].

Une IA peut, par exemple, analyser des images, reconnaître une
voix, traduire un texte, détecter une anomalie ou encore faire des
prévisions à partir de données.

Aujourd'hui, l'#strong[intelligence artificielle] est utilisée
dans de nombreux domaines : médecine, agriculture, éducation,
commerce, transport, sport, météorologie, finance et
communication.

Une intelligence artificielle ne fonctionne pas seulement avec
des mots ou des images. Elle travaille également avec de grandes
quantités de #strong[données].

Pour prendre une décision, une IA peut par exemple analyser
combien d'éléments d'un ensemble possèdent une certaine
caractéristique.

Imaginons qu'une IA analyse les réponses de $60$ élèves à une
question.

Elle constate que :

• $36$ élèves ont répondu correctement ;

• $24$ élèves ont répondu incorrectement.
]

#activite[
Pour mesurer la proportion d'élèves ayant répondu correctement,
elle peut calculer le rapport entre le nombre de réponses
correctes et le nombre total de réponses :
$36/60$.
Cette proportion peut ensuite être simplifiée.
L'IA analyse maintenant une autre série de données.
Sur $80$ images analysées :

• $48$ images sont reconnues correctement ;

• $32$ images sont mal reconnues.

Elle doit déterminer la proportion d'images correctement
reconnues.
Elle obtient :
$48/80$.

Dans un autre test, une IA classe $100$ objets.
Elle réussit à identifier $75$ objets.
La proportion d'objets correctement identifiés est :
$75/100$.
Pour comparer les performances de plusieurs systèmes d'IA,
il est donc nécessaire de savoir :

• écrire une proportion sous forme de fraction ;

• simplifier une fraction ;

• comparer deux fractions ;

• placer une fraction sur une droite graduée ;

• additionner ou soustraire des fractions ;

• multiplier et diviser des fractions ;

• interpréter une fraction comme une proportion ;

• utiliser des fractions positives ou négatives pour représenter
des variations ou des écarts.

L'IA peut également analyser une évolution.
Par exemple, si le taux d'erreur d'un système passe de
$1/5$ à $1/10$, la variation peut être étudiée à l'aide
de fractions.
Une valeur positive peut représenter une amélioration tandis
qu'une valeur négative peut représenter une diminution.
Les fractions deviennent ainsi un outil permettant à l'IA de
#strong[mesurer, comparer et interpréter des données].
À partir de cette situation :

1. Quelle fraction représente la proportion d'élèves ayant répondu correctement parmi les $60$ élèves ?

2. Simplifie la fraction $36/60$.

3. Simplifie $48/80$.

4. Quelle est la proportion d'images correctement reconnues ?

5. Parmi $36/60$ et $48/80$, quelles proportions sont égales ?

6. Comment pourrait-on placer $1/2$, $3/4$ et $4/5$ sur une droite graduée ?

7. Une proportion peut-elle être supérieure à $1$ ?

8. Une fraction peut-elle être négative ?

9. Comment représenter une fraction négative sur une droitegraduée ?

10. Comment une IA pourrait-elle utiliser les fractions pourcomparer deux performances ?
]

#pagebreak()

#align(center)[
  #image_full("intelligence-artificielle-5e.jpeg")
]

#pagebreak()

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

🤖 interpréter une #strong[fraction comme une proportion d'un ensemble] ;

#v(0.05cm)

🔢 reconnaître et simplifier une #strong[fraction irréductible] ;

#v(0.05cm)

📍 placer une fraction positive ou négative sur une
#strong[droite graduée] ;

#v(0.05cm)

⚖️ comparer et ranger des fractions ;

#v(0.05cm)

➗ écrire une fraction sous la forme
#strong[$q + r/b$] ;

#v(0.05cm)

📏 encadrer une fraction par des nombres entiers ou décimaux ;

#v(0.05cm)

➕ effectuer des #strong[additions et soustractions de fractions] ;

#v(0.05cm)

✖️ effectuer des #strong[multiplications et divisions de fractions] ;

#v(0.05cm)

🔢 utiliser les #strong[puissances de fractions] ;

#v(0.05cm)

🧮 respecter les #strong[priorités de calcul] ;

#v(0.05cm)

🤖 utiliser les fractions pour #strong[analyser et mesurer
des données].
]


#v(0.3cm)

#remarque[
Les fractions permettent à une intelligence artificielle de
représenter des proportions.

Par exemple, si une IA reconnaît correctement $45$ images
sur $60$, la proportion de réussite est :

$45/60 = 3/4$.

La fraction $3/4$ signifie que la réussite représente
#strong[trois quarts] de l'ensemble des images analysées.

Les fractions permettent donc de transformer des quantités
en #strong[mesures comparables].
]

#pagebreak()
#deux-colonnes[


// ==========================================================
// FRACTION ET PROPORTION
// ==========================================================

#sous_titre[
La fraction comme proportion d'un ensemble
]

#v(0.15cm)

#definition[
Une #strong[fraction] est un nombre qui s'écrit sous la forme :
#strong[$a/b$]

où $a$ et $b$ sont des entiers relatifs et $b$ est non nul.

$a$ est appelé #strong[numérateur].

$b$ est appelé #strong[dénominateur].
]

#definition[
Lorsqu'une fraction représente une partie d'un ensemble,
elle peut être interprétée comme une #strong[proportion].

Si un ensemble contient $N$ éléments et qu'une partie contient
$n$ éléments, alors la proportion de cette partie est :
#strong[$n/N$].
]

#exemple[
Une IA analyse $40$ images.
Parmi elles, $30$ sont correctement reconnues.
La proportion d'images correctement reconnues est :
$30/40$.

En simplifiant :
$30/40 = 3/4$,

La proportion de réussite est donc :
$3/4$.
]

#v(0.25cm)

#remarque[
Une proportion peut être exprimée :

• sous forme de fraction ;

• sous forme décimale ;

• éventuellement sous forme de pourcentage.

Par exemple :

$3/4 = 0,75 = 75%$.
]


#v(0.5cm)


// ==========================================================
// NUMÉRATEUR ET DÉNOMINATEUR
// ==========================================================

#sous_titre[
Comprendre les deux termes d'une fraction
]

#v(0.15cm)

#definition[
Dans la fraction :
#strong[$a/b$]

• le #strong[numérateur] indique le nombre de parts considérées;

• le #strong[dénominateur] indique le nombre de parts égales
dans l'ensemble de référence.
]

#exemple[
Une IA étudie $12$ données.
$5$ données appartiennent à une certaine catégorie.

La proportion correspondante est :
$5/12$.

Le numérateur est $5$.

Le dénominateur est $12$.
]

#remarque[
Le dénominateur ne peut jamais être nul.

La fraction 
#strong[$a/0$]
n'est pas définie.
]


#remarque[
Une fraction est appelée #strong[décimale] lorsqu'elle peut être
écrite avec un dénominateur qui est un #strong[diviseur de $10$, de
$100$, de $1000$, de $10\,000$, etc.].

Autrement dit, le dénominateur peut être $1$, $2$, $4$, $5$, $10$,
$20$, $25$, $50$, $100$, etc., à condition qu'il soit un diviseur
d'une puissance de $10$.

Par exemple :
$
5/4 ; 3/5 ; 7/20 ; 3/25
$

sont des fractions décimales car leurs dénominateurs peuvent être
transformés en $10$, $100$, $1000$, etc.

#v(2cm)

En effet :

$• 4 × 25 = 100,$

$• 5 × 2 = 10,$

$• 20 × 5 = 100,$

$• 25 × 4 = 100.$


Ainsi :

$5/4 =(5 × 25)/(4 × 25)$

$5/4 =125/100$

$5/4 =1,25.$


Le fait que le dénominateur de départ soit $4$ ne signifie donc
pas que la fraction n'est pas décimale.

Ce qui compte, c'est qu'on puisse #strong[transformer son
dénominateur en $10$, $100$, $1000$, etc.].
]


#retenir[

Pour reconnaître facilement une fraction décimale, on peut chercher
si son dénominateur est un #strong[diviseur d'une puissance de $10$].

Par exemple :

$• #[2 est un diviseur de 10],$

$• #[4 est un diviseur de 100],$

$• #[5 est un diviseur de 10],$

$• #[25 est un diviseur de 100],$

$• #[8  est un diviseur de  1000].$

On peut donc transformer les fractions correspondantes en fractions
dont le dénominateur est $10$, $100$, $1000$, etc.

Par exemple :

$3/5 = 6/10 = 0,6$

$5/4 = 125/100 = 1,25$

$7/8 = 875/1000 = 0,875.$

En revanche, une fraction comme $1/3$ n'est pas une fraction décimale, car aucun des nombres
$10$, $100$, $1000$, $10000$, etc. n'est divisible exactement par $3$.
]

#table(
  columns: (1.2fr, 1.5fr, 1.5fr),
  inset: 8pt,
  align: center,
  stroke: 0.6pt,

  [#strong[Fraction]],
  [#strong[Transformation]],
  [#strong[Fraction décimale ?]],

  [$5/4$],
  [$5/4 = 125/100$],
  [Oui],

  [$3/5$],
  [$3/5 = 6/10$],
  [Oui],

  [$7/20$],
  [$7/20 = 35/100$],
  [Oui],

  [$7/8$],
  [$7/8 = 875/1000$],
  [Oui],

  [$2/3$],
  [Impossible avec $10$, $100$, $1000$, etc.],
  [Non],

  [$5/7$],
  [Impossible avec $10$, $100$, $1000$, etc.],
  [Non],
)


// ==========================================================
// FRACTIONS ÉGALES
// ==========================================================

#sous_titre[
Fractions égales
]

#propriete[
Multiplier ou diviser le numérateur et le dénominateur
d'une fraction par un même nombre entier non nul ne change
pas la valeur de la fraction.
]

#exemple_resolu[
Une IA réussit $20$ tests sur $40$.

La proportion est :
$20/40$.

En divisant le numérateur et le dénominateur par $20$ :

$20/40 = 1/2$.

Ainsi 
$20/40 = 1/2$.

Ces deux fractions représentent la même proportion.
]

#exemple[
On a :
$2/3 = 4/6 = 6/9 = 8/12$.

Toutes ces fractions représentent le même nombre.
]

#v(2cm)
// ==========================================================
// FRACTION IRRÉDUCTIBLE
// ==========================================================

#sous_titre[
Fraction irréductible
]

#definition[
Une fraction est dite #strong[irréductible] lorsque $1$ est
le seul entier naturel diviseur commun à son numérateur
et à son dénominateur.
]

#remarque[
Rendre une fraction irréductible consiste à déterminer la
fraction irréductible qui lui est égale.

On peut procéder :

• par simplifications successives ;

• en recherchant le plus grand diviseur commun ;

• par décomposition en facteurs premiers.
]

#exemple_resolu[
Une IA réussit $36$ tests sur $60$.

La proportion est :
$36/60$.

On peut diviser les deux termes par $6$ :
$36/60 = 6/10$.

Puis par $2$ :
$6/10 = 3/5$.

Ainsi :
$36/60 = 3/5$.

La fraction $3/5$ est irréductible.
]

#exemple[
Les fractions suivantes sont irréductibles :

$2/3$ ; $5/7$ ; $7/11$ ; $13/20$.

En revanche $12/18$ n'est pas irréductible car $12$ et $18$ sont divisibles par $6$.
]

#v(4cm)

// ==========================================================
// SIMPLIFICATIONS SUCCESSIVES
// ==========================================================

#sous_titre[
Simplifier une fraction
]

#exemple_resolu[
Une IA analyse $75$ données et classe correctement $45$ d'entre elles.

La proportion est :
$45/75$.

On peut simplifier par $5$ :
$45/75 = 9/15$.

Puis par $3$ :
$9/15 = 3/5$.

Donc :
$45/75 = 3/5$.
]

#exemple[
Simplifions :
$30/75$.

On divise les deux termes par $15$ :
$30/75 = 2/5$.

La fraction $2/5$ est irréductible.
]

// ==========================================================
// PLUS GRAND DIVISEUR COMMUN
// ==========================================================

#sous_titre[
Simplifier à l'aide du plus grand diviseur commun
]
#exemple_resolu[
Pour simplifier $30/75$, on recherche les diviseurs communs de $30$ et $75$.

Les diviseurs de $30$ sont :

$1; 2; 3; 5; 6; 10; 15; 30$.

Les diviseurs de $75$ sont :

$1; 3; 5; 15; 25; 75$.

Le plus grand diviseur commun est :
$15$.

Donc :
$30/75 = (30 ÷ 15)/(75 ÷ 15)$.

Ainsi :
$30/75 = 2/5$.
]

#v(5cm)
// ==========================================================
// FRACTIONS ET PROPORTIONS D'UN ENSEMBLE
// ==========================================================

#sous_titre[
Interpréter une fraction comme une proportion
]

#exemple[
Une IA analyse $200$ photographies.
Elle identifie correctement $150$ photographies.

La proportion de réussite est :
$150/200$.

Après simplification,
$150/200 = 3/4$.

L'IA a donc correctement identifié $3/4$ des photographies.
]

#exemple_resolu[
Une base de données contient $120$ enregistrements.
Une IA détecte une anomalie dans $18$ enregistrements.

La proportion d'enregistrements présentant une anomalie est $18/120$.

On simplifie par $6$ :
$18/120 = 3/20$.

La proportion est donc :
$3/20$.
]

// ==========================================================
// DROITE GRADUÉE ET FRACTIONS
// ==========================================================

#sous_titre[
Placer une fraction sur une droite graduée
]

#definition[
Une #strong[droite graduée] est une droite sur laquelle on choisit :

• une #strong[origine], correspondant à $0$ ;

• un #strong[point unité], correspondant à $1$ ;

• un sens positif ;

• une unité de longueur permettant de construire
les graduations.

#align(center)[

  #image_full("grad-fract-4e.jpeg")

]



]

#v(0.25cm)

#definition[
L'#strong[abscisse] d'un point est le nombre associé à ce point
sur la droite graduée.
]

#remarque[
Pour placer une fraction sur une droite graduée, on partage
chaque unité en un nombre de parts égal au dénominateur.
]

#exemple_resolu[
Plaçons $3/4$ sur une droite graduée.

Le dénominateur est $4$.

On partage donc l'intervalle entre $0$ et $1$ #[(car le numérateur est inférieur au dénominateur)] en $4$ parties égales.

On avance de $3$ parts à partir de $0$.

On obtient $3/4$.

Ainsi, le point d'abscisse $3/4$ se trouve entre $0$ et $1$, à la troisième graduation.
]

#exemple[
Pour placer $2/3$, on partage l'intervalle $[0;1]$ en $3$ parties égales et on prend la deuxième graduation.

Pour placer $5/4$, on partage chaque unité en $4$ parties et on avance de $5$ quarts.

On obtient $5/4 = 1 + 1/4$. Le point est donc situé entre $1$ et $2$.
]


// ==========================================================
// FRACTIONS NÉGATIVES SUR UNE DROITE GRADUÉE
// ==========================================================

#sous_titre[
Placer une fraction négative sur une droite graduée
]

#definition[
Une #strong[fraction négative] est une fraction dont le numérateur
et le dénominateur sont de signes contraires.

Par exemple $-3/4$, $-5/2$, $-7/3$.
]

#remarque[
Sur une droite graduée :

• les fractions positives sont situées à droite de $0$ ;

• les fractions négatives sont situées à gauche de $0$.
]

#v(0.25cm)

#exemple_resolu[
Plaçons :
$-3/4$.

On partage l'unité entre $0$ et $-1$ en $4$ parties égales.

Puisque le nombre est négatif, on se déplace vers la gauche.

On avance de $3$ graduations.

On atteint le point d'abscisse :
$-3/4$.
]

#exemple[
Pour placer $-5/4$,
on remarque que :
$-5/4 = -1 - 1/4$.

Le point se trouve donc entre $-1$ et $-2$,
à une graduation après $-1$ en allant vers la gauche.
]

// ==========================================================
// COMPARER DES FRACTIONS
// ==========================================================

#sous_titre[
Comparer deux fractions
]

#propriete[
Deux fractions placées sur une même droite graduée
se comparent comme les nombres associés à leurs points.

La fraction dont le point est situé le plus à droite est la plus grande.
]

#exemple_resolu[
Comparons :
$1/2$ et $3/4$.

On réduit au même dénominateur :
$1/2 = 2/4$.

Donc :
$2/4 < 3/4$.

Ainsi :
$1/2 < 3/4$.
]

#propriete[
Lorsque deux fractions ont le même dénominateur,
la plus grande est celle qui a le plus grand numérateur.
]

#v(0.25cm)

#exemple[
$5/8 > 3/8$
car $5>3$.

De même : $2/7 < 6/7$.
]

#propriete[
Lorsque deux fractions positives ont le même numérateur,
la plus grande est celle qui possède le plus petit dénominateur.
]

#exemple[
$3/5 > 3/8$

car les deux fractions ont le même numérateur
et $5<8$.
]

// ==========================================================
// COMPARER DES FRACTIONS NÉGATIVES
// ==========================================================

#sous_titre[
Comparer des fractions négatives
]

#exemple_resolu[
Comparons : $-1/2$ et $-3/4$.

On réduit au même dénominateur :
$-1/2 = -2/4$.

Donc : $-2/4 > -3/4$.

Ainsi : $-1/2 > -3/4$.
]

#remarque[
Pour deux fractions négatives, celle qui est la plus proche
de $0$ est la plus grande.
]

#exemple[
On a $-1/3 > -5/6$.

En effet, $-1/3$ est plus proche de $0$ que $-5/6$.
]

// ==========================================================
// RANGER DES FRACTIONS
// ==========================================================

#sous_titre[
Ranger des fractions
]

#exemple_resolu[
Rangeons dans l'ordre croissant :

$-1/2, 3/4, -3/4, 1/2, 0$.

On compare les fractions :

$-3/4 < -1/2 < 0 < 1/2 < 3/4$.

Donc :
$-3/4 < -1/2 < 0 < 1/2 < 3/4$.
]

// ==========================================================
// ÉCRITURE SOUS LA FORME q + r/b
// ==========================================================

#sous_titre[
Écrire une fraction sous la forme $q + r/b$
]

#definition[
Si $a$ et $b$ sont des entiers naturels avec $b$ non nul,
la fraction $a/b$ peut s'écrire : #strong[$a/b = q + r/b$] où $q$ est le quotient et $r$ le reste de la division euclidienne de $a$ par $b$, avec : #strong[$r < b$].
]

#exemple_resolu[
Écrivons $7/3$ sous la forme $q + r/b$.

La division euclidienne de $7$ par $3$ donne :

$7 = 3 × 2 + 1$.

Donc :
$7/3 = 2 + 1/3$.
]

#exemple[
Pour :
$22/9$,

On a :
$22 = 9 × 2 + 4$.

Donc :
$22/9 = 2 + 4/9$.
]

#v(8cm)
// ==========================================================
// ENCADRER UNE FRACTION
// ==========================================================

#sous_titre[
Encadrer une fraction
]

#exemple_resolu[
Encadrons :
$22/9$.

On sait que :
$22/9 = 2 + 4/9$.
Comme :
$0 < 4/9 < 1$,

on obtient :
$2 < 22/9 < 3$.

Ainsi, $22/9$ est encadrée par les deux entiers consécutifs $2$ et $3$.
]

#exemple_resolu[
On sait approximativement que :
$22/9 ≈ 2,4444$.

À un dixième près :
$2,4 < 22/9 < 2,5$.

À un centième près :
$2,44 < 22/9 < 2,45$.
]

#remarque[
Encadrer une fraction à :

• l'unité près consiste à utiliser deux entiers consécutifs ;

• un dixième près consiste à utiliser deux nombres décimaux
consécutifs ayant un chiffre après la virgule ;

• un centième près consiste à utiliser deux nombres décimaux
consécutifs ayant deux chiffres après la virgule.
]

// ==========================================================
// ADDITION DE FRACTIONS
// ==========================================================

#sous_titre[
Additionner deux fractions
]

#propriete[
Pour additionner deux fractions de même dénominateur,
on conserve le dénominateur et on additionne les numérateurs :

$a/b + c/b = (a+c)/b$.
]

#exemple[
$2/7 + 3/7 = 5/7$.
]

#propriete[
Pour additionner deux fractions de dénominateurs différents,
on les réduit d'abord au même dénominateur.
]

#exemple_resolu[
Calculons :
$7/5 + 3/5$.

Les dénominateurs sont déjà identiques.

Donc :
$7/5 + 3/5 = 10/5 = 2$.
]

#exemple_resolu[
Calculons :
$3/6 + 17/4$.

Un dénominateur commun est $12$.

On a 
$3/6 = 6/12$
et 
$17/4 = 51/12$.

Donc :
$3/6 + 17/4 = 6/12 + 51/12$.

Ainsi :
$3/6 + 17/4 = 57/12 = 19/4$.
]

// ==========================================================
// DIFFÉRENCE DE FRACTIONS
// ==========================================================

#sous_titre[
Soustraire deux fractions
]

#propriete[
Pour calculer la différence de deux fractions,
on les réduit au même dénominateur puis on soustrait
les numérateurs.
]

#exemple_resolu[
Calculons :
$7/12 - 5/18$.

Un dénominateur commun est $36$.

On obtient :
$7/12 = 21/36$
et 
$5/18 = 10/36$.

Donc :
$7/12 - 5/18 = 21/36 - 10/36$.

Ainsi :
$7/12 - 5/18 = 11/36$.
]

#exemple[
Pour 
$3/4 - 17/10$,
on peut prendre $20$ comme dénominateur commun.

On obtient :
$3/4 = 15/20$
et 
$17/10 = 34/20$.

Donc :
$3/4 - 17/10 = -19/20$.
]

// ==========================================================
// FRACTIONS NÉGATIVES ET ADDITION
// ==========================================================

#sous_titre[
Additionner et soustraire des fractions négatives
]

#exemple_resolu[
Calculons :
$-2/3 + 1/6$.

On réduit au même dénominateur :
$-2/3 = -4/6$.

Donc :
$-2/3 + 1/6 = -4/6 + 1/6$.

Ainsi :
$-2/3 + 1/6 = -3/6 = -1/2$.
]

#exemple_resolu[
Calculons :
$-3/4 - 1/2$.

On écrit :
$1/2 = 2/4$.

Donc :
$-3/4 - 1/2 = -3/4 - 2/4$.

Ainsi :
$-3/4 - 1/2 = -5/4$.
]

// ==========================================================
// PRODUIT D'UNE FRACTION PAR UN ENTIER
// ==========================================================

#sous_titre[
Multiplier une fraction par un entier
]

#propriete[
Pour tout entier relatif $k$ et toute fraction $a/b$ avec
$b$ non nul : #strong[$k × a/b = (k×a)/b$].
]

#exemple[
$2 × 3/7 = 6/7$ et $-3 × 2/5 = -6/5$.
]

#exemple_resolu[
Une IA mesure une variation de performance de $2/5$ par période pendant $3$ périodes.

La variation totale est : $3 × 2/5$.

Donc : $3 × 2/5 = 6/5$.

La variation totale est donc de $6/5$.
]

// ==========================================================
// PRODUIT DE DEUX FRACTIONS
// ==========================================================

#sous_titre[
Multiplier deux fractions
]

#v(0.15cm)

#propriete[
Pour multiplier deux fractions :

#strong[$a/b × c/d = (a×c)/(b×d)$] avec $b$ et $d$ non nuls.
]

#exemple_resolu[
Calculons :
$2/3 × 3/5$.

On multiplie les numérateurs entre eux
et les dénominateurs entre eux :
$2/3 × 3/5 = 6/15$.

On simplifie :
$6/15 = 2/5$.

Donc :
$2/3 × 3/5 = 2/5$.
]

#exemple[
$7/4 × 3/5 = 21/20$.

$-2/3 × 5/7 = -10/21$.
]

// ==========================================================
// SIMPLIFICATION AVANT LE PRODUIT
// ==========================================================

#sous_titre[
Simplifier avant de multiplier
]

#exemple_resolu[
Calculons :
$8/21 × 45/16$.

On peut simplifier avant de multiplier :

$8/16 = 1/2$
et
$45/21 = 15/7$.

Donc :
$8/21 × 45/16 = 1/2 × 15/7$.

Ainsi :
$8/21 × 45/16 = 15/14$.
]

#remarque[
Simplifier avant de multiplier permet souvent de rendre
les calculs plus simples.
]

#v(4cm)

// ==========================================================
// INVERSE D'UNE FRACTION
// ==========================================================

#sous_titre[
L'inverse d'un nombre
]

#definition[
L'#strong[inverse] d'un nombre non nul $a/b$ est le nombre
$b/a$.

Le produit d'un nombre non nul par son inverse est égal à $1$.
]

#v(0.25cm)

#exemple[
L'inverse de $3/5$ est $5/3$.

En effet 
$3/5 × 5/3 = 1$.
]

#exemple[
L'inverse de $-2/7$ est $-7/2$.

En effet 
$-2/7 × -7/2 = 1$.
]

// ==========================================================
// DIVISION DE DEUX FRACTIONS
// ==========================================================

#sous_titre[
Diviser deux fractions
]

#propriete[
Diviser par un nombre non nul revient à multiplier par
son inverse.

Ainsi :
$a/b ÷ c/d = a/b × d/c$.
]

#exemple_resolu[
Calculons :
$3/4 ÷ 2/5$.

On remplace la division par une multiplication par l'inverse :

$3/4 ÷ 2/5 = 3/4 × 5/2$.

Donc :
$3/4 ÷ 2/5 = 15/8$.
]

#v(4cm)

#exemple_resolu[
Calculons :
$-5/6 ÷ 10/9$.

On obtient :
$-5/6 × 9/10$.

On simplifie :
$-5/10 = -1/2$
et
$9/6 = 3/2$.

Donc :
$-5/6 ÷ 10/9 = -3/4$.
]

// ==========================================================
// RÈGLES DE SIGNES POUR LES FRACTIONS
// ==========================================================

#sous_titre[
Les signes des fractions
]

#retenir[
Une fraction est positive lorsque son numérateur
et son dénominateur ont le même signe.

Une fraction est négative lorsque son numérateur
et son dénominateur ont des signes différents.

Ainsi :

#strong[$(+a)/(+b) = +a/b$] ; #strong[$(-a)/(-b) = +a/b$]

#strong[$(-a)/(+b) = -a/b$] ; #strong[$(+a)/(-b) = -a/b$].
]

#exemple[
$(-3)/(-5)=3/5$ ; $(-3)/(+5)=-3/5$ ; $(+3)/(-5)=-3/5$.
]

// ==========================================================
// PRIORITÉS DE CALCUL AVEC LES FRACTIONS
// ==========================================================

#sous_titre[
Calculs avec des fractions
]

#v(0.15cm)

#retenir[
Dans une expression comportant plusieurs opérations :

1. on effectue les calculs entre parenthèses ;

2. puis les puissances ;

3. puis les multiplications et les divisions ;

4. enfin les additions et les soustractions.

Lorsque plusieurs opérations de même priorité se suivent,
on les effectue de gauche à droite.
]

#v(0.25cm)

#exemple_resolu[
Calculons :
$1/2 + 3/4 × 2/3$.

La multiplication est prioritaire.

On calcule :
$3/4 × 2/3 = 6/12 = 1/2$.

Donc :
$1/2 + 1/2 = 1$.

Ainsi :
$1/2 + 3/4 × 2/3 = 1$.
]

#exemple_resolu[
Calculons :
$3/5 - 1/2 ÷ 3/4$.

On effectue d'abord la division :

$1/2 ÷ 3/4 = 1/2 × 4/3 = 2/3$.

Donc :
$3/5 - 2/3$.

On réduit au même dénominateur :

$3/5 = 9/15$
et
$2/3 = 10/15$.

Ainsi :
$3/5 - 2/3 = -1/15$.
]

// ==========================================================
// PUISSANCES DE FRACTIONS
// ==========================================================

#sous_titre[
Les puissances de fractions
]

#definition[
Pour une fraction $a/b$ et un entier naturel $n$ supérieur
ou égal à $1$ :

#strong[$(a/b)^n = a/b × a/b × ... × a/b$]

avec $n$ facteurs de $a/b$.
]

#v(0.25cm)

#exemple[
Calculons :
$(2/3)^2$.

On a :
$(2/3)^2 = 2/3 × 2/3$.

Donc :
$(2/3)^2 = 4/9$.
]

#exemple[
Calculons :
$(-1/2)^3$.

On obtient :
$(-1/2)^3 = (-1/2)×(-1/2)×(-1/2)$.

Donc :
$(-1/2)^3 = -1/8$.
]

// ==========================================================
// SIGNE D'UNE PUISSANCE DE FRACTION
// ==========================================================

#sous_titre[
Le signe d'une puissance de fraction
]

#propriete[
Si une fraction est positive, toute puissance de cette fraction
est positive.

Si une fraction est négative :

• une puissance d'exposant pair est positive ;

• une puissance d'exposant impair est négative.
]

#exemple_resolu[
$(-2/3)^2 = 4/9$.

L'exposant $2$ est pair, donc le résultat est positif.
]

#exemple_resolu[
$(-2/3)^3 = -8/27$.

L'exposant $3$ est impair, donc le résultat est négatif.
]

// ==========================================================
// PUISSANCE D'UN PRODUIT
// ==========================================================

#sous_titre[
Puissance d'un produit de fractions
]

#propriete[
Soient $a$, $b$ et $n$ des entiers naturels, avec $b != 0$ et $n$ un entier naturel supérieur ou égal à $2$.

La puissance d'une fraction est définie par :

#strong[$(a/b)^n = (a/b) × (a/b) × ... × (a/b)$]

avec $n$ facteurs de $a/b$.


]

#v(5cm)

// ==========================================================
// PRODUIT DE PUISSANCES DE MÊME BASE
// ==========================================================

#sous_titre[
Produit de puissances de même base
]

#propriete[
Pour une même base non nulle :

#strong[$(a/b)^m × (a/b)^n = (a/b)^(m+n)$].
]

#exemple[
$(2/3)^2 × (2/3)^3 = (2/3)^5$.

Donc :
$(2/3)^2 × (2/3)^3 = 32/243$.
]

// ==========================================================
// PROPORTIONS COMPLÉMENTAIRES
// ==========================================================

#sous_titre[
Proportion d'une partie et proportion du reste
]

#exemple_resolu[
Une IA classe $80$ images.

Elle reconnaît correctement $60$ images.

La proportion de réussite est :
$60/80 = 3/4$.

La proportion d'images non reconnues est donc :
$1 - 3/4$.

Ainsi :
$1 - 3/4 = 1/4$.

La proportion d'images non reconnues est donc $1/4$.
]

#remarque[
Lorsqu'une partie représente une proportion $p$ d'un ensemble,
le reste représente :
$1-p$.
]

// ==========================================================
// FRACTION D'UNE FRACTION
// ==========================================================

#sous_titre[
Prendre une fraction d'une quantité
]

#propriete[
Prendre une fraction $a/b$ d'une quantité revient à multiplier
cette quantité par $a/b$.
]

#v(2cm)

#exemple_resolu[
Une base contient $120$ données.
Une IA utilise $3/5$ de ces données pour son apprentissage.
Le nombre de données utilisées est :
$3/5 × 120$.

Donc :
$3/5 × 120 = 3 × 24 = 72$.

L'IA utilise donc $72$ données pour son apprentissage.
]

#exemple[
Une IA utilise $2/3$ d'un ensemble de $90$ images.

On calcule :
$2/3 × 90 = 60$.

Elle utilise donc $60$ images.
]

// ==========================================================
// À RETENIR
// ==========================================================

#retenir[
🤖 #strong[À retenir — Fractions et proportions]

Une fraction #strong[$a/b$] est formée d'un #strong[numérateur] $a$ et d'un
#strong[dénominateur] $b$, avec $b ≠ 0$.
Une fraction peut représenter une #strong[proportion d'un ensemble].
Pour simplifier une fraction, on divise son numérateur
et son dénominateur par un même diviseur commun.
Une fraction #strong[irréductible] possède #strong[$1$] comme seul diviseur
commun naturel de ses deux termes.
Sur une droite graduée :

• les fractions positives sont à droite de $0$ ;

• les fractions négatives sont à gauche de $0$ ;

• plus une fraction est située à droite, plus elle est grande.

Pour #strong[additionner] ou soustraire deux fractions de dénominateurs
différents, on les réduit au même dénominateur.
Pour #strong[multiplier] deux fractions, on multiplie les numérateurs
entre eux et les dénominateurs entre eux.
Pour #strong[diviser] par une fraction non nulle, on multiplie par
son inverse.

Pour une #strong[puissance] : #strong[$(a/b)^n = (a/b) × ... × (a/b)$]

avec $n$ facteurs de $a/b$.

Enfin, les fractions permettent de #strong[mesurer, comparer
et interpréter des données].
]

// ==========================================================
// EXERCICES D'APPLICATION
// ==========================================================

#exercice[
#mission[
🤖 Mission — Mesurer la performance d'une IA
]

Une intelligence artificielle analyse $100$ images.

Elle reconnaît correctement $80$ images.

1. Écris la proportion d'images correctement reconnues.

2. Simplifie cette fraction.

3. Donne la proportion d'images mal reconnues.

4. Quelle fraction représente le reste ?

5. Exprime les deux proportions sous forme de fractions
irréductibles.
]

#exercice[
#mission[
📊 Mission — Simplifier des proportions
]

Simplifie les fractions suivantes :

$36/60$ ; $48/80$ ; $75/100$ ; $30/75$ ; $45/90$ ; $18/120$.

Pour chacune, interprète le résultat comme une proportion.
]

#exercice[
#mission[
📍 Mission — Placer des fractions sur une droite graduée
]

Sur une droite graduée, place les nombres :

$1/2$ ; $3/4$ ; $5/4$ ; $-1/2$ ; $-3/4$ ; $-5/4$.

1. Quels nombres sont situés à droite de $0$ ?

2. Quels nombres sont situés à gauche de $0$ ?

3. Quel nombre est le plus proche de $0$ ?

4. Range ces nombres dans l'ordre croissant.
]

#exercice[
#mission[
⚖️ Mission — Comparer les performances de deux IA
]

Une première IA reconnaît correctement $45$ images sur $60$.
Une seconde IA reconnaît correctement $35$ images sur $50$.

1. Écris les deux proportions.

2. Simplifie-les.

3. Compare les deux fractions.

4. Quelle IA possède la meilleure proportion de réussite ?
]

#exercice[
#mission[
📈 Mission — Encadrer une proportion
]
Une IA donne une mesure représentée par :
$22/9$.

1. Écris cette fraction sous la forme : $q + r/9$.

2. Encadre-la par deux entiers consécutifs.

3. Encadre-la à un dixième près.

4. Encadre-la à un centième près.
]

#exercice[
#mission[
➕ Mission — Additionner des proportions
]
Une IA analyse deux catégories de données.

La première représente :
$3/8$
des données.

La seconde représente :
$5/12$
des données.

1. Réduis les deux fractions au même dénominateur.

2. Calcule leur somme.

3. Le résultat est-il inférieur ou supérieur à $1$ ?
]

#exercice[
#mission[
➖ Mission — Calculer une différence de proportions
]

Une IA avait un taux d'erreur représenté par : $7/12$.

Après amélioration, le taux d'erreur devient : $5/18$.

1. Calcule la différence entre les deux taux.

2. Cette différence est-elle positive ou négative ?

3. Interprète le résultat.
]

#exercice[
#mission[
✖️ Mission — Une fraction d'un ensemble
]

Une base de données contient $240$ images.

Une IA utilise $3/8$ des images pour son apprentissage.

1. Calcule le nombre d'images utilisées.

2. Quelle proportion d'images reste disponible ?

3. Combien d'images restent disponibles ?
]

#exercice[
#mission[
➗ Mission — Comparer deux groupes de données
]

Une IA doit analyser un ensemble de données.

Elle traite $3/4$ de l'ensemble en $6$ minutes.

1. Calcule :
$3/4 ÷ 6$.

2. Interprète le résultat comme la proportion traitée
par minute.

3. Le résultat est-il positif ou négatif ?
]

#v(2cm)

#exercice[
#mission[
🔢 Mission — Puissances de fractions
]

Calcule :

$(2/3)^2$ ; $(-2/3)^2$ ; $(-2/3)^3$ ; $(3/5)^2$ ; $(-1/2)^4$.
]

#exercice[
#mission[
🧮 Mission — Priorités de calcul
]

Calcule :

$1/2 + 3/4 × 2/3$ ;

$3/5 - 1/2 ÷ 3/4$ ;

$(-2/3)^2 + 1/3$ ;

$1 - 3/4 × 2/5$.
]

// ==========================================================
// EXERCICE D'APPLICATION RÉSOLU
// ==========================================================

#exercice_resolu[

#mission[
🤖 Application — Évaluer un système d'intelligence artificielle
]

Une équipe développe une intelligence artificielle capable
de reconnaître des images.
Lors d'un test, elle lui présente $120$ images.
L'IA reconnaît correctement $90$ images.
Elle classe incorrectement
$30$ images.
On souhaite analyser mathématiquement les résultats.

#text(
weight:"bold",
)[
1. Déterminer la proportion de réussites
]

La proportion de réussites est :
$90/120$.

On simplifie par $30$ :
$90/120 = 3/4$.

La proportion de réussites est donc :
$3/4$.

#text(
weight:"bold",
)[
2. Déterminer la proportion d'erreurs
]

La proportion d'erreurs est :
$30/120$.

On simplifie par $30$ :
$30/120 = 1/4$.

La proportion d'erreurs est donc :
$1/4$.

#text(
weight:"bold",
)[
3. Vérifier que les proportions couvrent tout l'ensemble
]

On calcule :
$3/4 + 1/4$.

Donc :
$3/4 + 1/4 = 4/4 = 1$.

Les deux proportions représentent donc l'ensemble
des $120$ images.

#text(
weight:"bold",
)[
4. Placer la proportion de réussite sur une droite graduée
]

La proportion de réussite est :
$3/4$.

On partage l'intervalle $[0;1]$ en $4$ parties égales.

Le point correspondant à $3/4$ est la troisième graduation
à partir de $0$.

#text(
weight:"bold",
)[
5. Comparer avec une seconde IA
]

Une seconde IA réussit $64$ tests sur $80$.

Sa proportion de réussite est :
$64/80$.

On simplifie par $16$ :
$64/80 = 4/5$.

On compare :
$3/4$ et $4/5$.

On réduit au même dénominateur :

$3/4 = 15/20$
et
$4/5 = 16/20$.

Donc
$3/4 < 4/5$.

La seconde IA possède donc une meilleure proportion
de réussite.

#text(
weight:"bold",
)[
6. Mesurer l'écart entre les deux performances
]

On calcule :
$4/5 - 3/4$.

Un dénominateur commun est $20$.

Donc :
$4/5 = 16/20$
et
$3/4 = 15/20$.

Ainsi : $4/5 - 3/4 = 1/20$.

La seconde IA possède donc une proportion de réussite
supérieure de $1/20$.

#text(
weight:"bold",
)[
7. Interpréter le résultat
]

La fraction $1/20$ représente l'écart entre les deux
proportions de réussite.

Les fractions permettent donc de mesurer précisément
la différence entre les performances des deux systèmes
d'intelligence artificielle.
]


// ==========================================================
// FRACTIONS NÉGATIVES — VARIATION D'UNE PERFORMANCE
// ==========================================================

#v(2cm)

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
🤖 Réinvestissement — Mesurer une variation de performance
]

Une intelligence artificielle possède initialement un taux
de réussite de :
$3/5$.

Après une amélioration de son algorithme, son taux de réussite
devient :
$4/5$.

On veut mesurer la variation de sa performance.

#text(
weight:"bold",
)[
1. Calcul de la variation
]

La variation est :
$4/5 - 3/5$.

Les dénominateurs sont identiques.

Donc :
$4/5 - 3/5 = 1/5$.

La performance a augmenté de $1/5$.

#text(
weight:"bold",
)[
2. Une diminution de performance
]

Supposons maintenant qu'un autre système passe de $4/5$ à
$3/5$.

La variation est : $3/5 - 4/5 = -1/5$.

La variation est donc négative.

Elle traduit une diminution de la performance de $1/5$.

#text(
weight:"bold",
)[
3. Représentation sur une droite graduée
]

Les deux performances sont placées à droite de $0$ :
$3/5 < 4/5$.

La variation $-1/5$ est située à gauche de $0$.

Ainsi, le signe de la fraction permet de distinguer :

• une variation positive ;

• une variation négative ;

• une variation nulle.

#v(0.25cm)

#remarque[
Dans l'analyse des données, les fractions négatives peuvent
donc représenter des #strong[diminutions, écarts ou variations]
par rapport à une valeur de référence.

Elles ne représentent pas nécessairement une « partie négative »
d'un ensemble : elles peuvent représenter une #strong[variation
orientée].
]


#v(2cm)


// ==========================================================
// RÉINVESTISSEMENT — ANALYSER UN TABLEAU DE DONNÉES
// ==========================================================

#exemple_resolu[

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
📊 Réinvestissement — L'IA analyse les résultats d'un test
]

#v(0.2cm)

Une équipe teste trois systèmes d'intelligence artificielle
sur $200$ images.
Les résultats sont les suivants :

• IA-A reconnaît correctement $150$ images ;

• IA-B reconnaît correctement $160$ images ;

• IA-C reconnaît correctement $140$ images.

#v(0.3cm)

#text(
weight:"bold",
)[
1. Proportion de réussite de IA-A
]

$150/200 = 3/4$.

La proportion de réussite de IA-A est donc : $3/4$.

#text(
weight:"bold",
)[
2. Proportion de réussite de IA-B
]

$160/200 = 4/5$.

La proportion de réussite de IA-B est donc :
$4/5$.

#text(
weight:"bold",
)[
3. Proportion de réussite de IA-C
]

$140/200 = 7/10$.

La proportion de réussite de IA-C est donc :
$7/10$.

#text(
weight:"bold",
)[
4. Comparaison des trois systèmes
]

On compare :
$3/4, 4/5, 7/10$.

On choisit le dénominateur commun $20$ :

$3/4 = 15/20$ et $4/5 = 16/20$ alors $7/10 = 14/20$.

Donc :
$7/10 < 3/4 < 4/5$.

Le classement est donc :
IA-C < IA-A < IA-B.

#text(
weight:"bold",
)[
5. Écart entre IA-B et IA-C
]

On calcule :
$4/5 - 7/10$.
On réduit :
$4/5 = 8/10$.

Donc :
$4/5 - 7/10 = 1/10$.

IA-B possède une proportion de réussite supérieure
de $1/10$ à celle de IA-C.

#text(
weight:"bold",
)[
6. Interprétation
]

L'utilisation des fractions permet à l'équipe de comparer
les performances des systèmes d'intelligence artificielle
même lorsque les résultats sont exprimés à partir de
différentes proportions.

Les fractions constituent donc un outil mathématique
pour #strong[mesurer, comparer et interpréter des données].
]


// ==========================================================
// MISSION FINALE
// ==========================================================

#exercice[
#mission[
🤖 #strong[MISSION FINALE — L'IA doit prendre une décision]
]

Une entreprise teste trois intelligences artificielles
pour choisir celle qui sera utilisée dans son système
de reconnaissance d'images. Chaque IA reçoit $240$ images. Les résultats sont :

• IA-A : $180$ images correctement reconnues ;

• IA-B : $192$ images correctement reconnues ;

• IA-C : $168$ images correctement reconnues.

#strong[ Partie A — Proportions]

1. Écris la proportion de réussite de chaque IA.

2. Rends chaque fraction irréductible.


#strong[ Partie B — Comparaison]

3. Compare les trois proportions.

4. Range-les dans l'ordre croissant.

5. Quelle IA possède la meilleure performance ?

#strong[ Partie C — Droite graduée]

6. Place les trois proportions sur une droite graduée.

7. Explique pourquoi la position des points permet
de comparer les performances.

#strong[ Partie D — Écarts]

8. Calcule l'écart de performance entre IA-B et IA-A.

9. Calcule l'écart de performance entre IA-A et IA-C.

10. Indique le signe de chaque variation.

#strong[Partie E — Décision]

11. Si l'entreprise choisit l'IA possédant la plus grande proportion de réussite, quelle IA doit-elle choisir ?

12. Explique ta décision en utilisant les fractions.

#v(2cm)

#strong[Partie F — Interprétation]

13. Explique en quelques lignes pourquoi les fractions sont utiles à une intelligence artificielle lorsqu'elle analyse des données.

14. Donne un exemple d'une situation réelle dans laquelle une proportion peut être utilisée par une IA.

]

// ==========================================================
// SYNTHÈSE DU PARCOURS
// ==========================================================

#retenir[
🤖 #strong[Synthèse — Les fractions comme outils d'analyse des données]

Une fraction permet de représenter une proportion. Par exemple : $75/100 = 3/4$.

La fraction $3/4$ indique que la partie étudiée représente
trois quarts de l'ensemble.
Les fractions peuvent être :

• positives ;

• négatives lorsqu'elles représentent notamment une variation
ou un écart orienté ;

• inférieures à $1$ ;

• égales à $1$ ;

• supérieures à $1$.

Elles peuvent être représentées sur une droite graduée.
Les fractions positives se situent à droite de $0$, les fractions négatives à gauche de $0$.

Pour comparer des fractions, on peut les réduire au même
dénominateur ou les représenter sur une droite graduée.Les fractions permettent également d'effectuer :

• des additions ;

• des soustractions ;

• des multiplications ;

• des divisions ;

• des puissances.

Dans l'analyse des données, elles permettent notamment
de calculer des proportions, des taux, des écarts
et des variations.

L'intelligence artificielle peut donc utiliser les fractions
pour transformer des données brutes en informations
#strong[mesurables et comparables].
]

// ==========================================================
// OUVERTURE
// ==========================================================

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🤖 Ouverture — Des fractions aux données de l'intelligence artificielle
]

#v(0.12cm)

Une intelligence artificielle reçoit souvent des données
en très grande quantité.

Pour les analyser, elle doit être capable de mesurer
des proportions et de comparer des résultats.

Une réussite de $3/4$ signifie que $3$ éléments sur $4$
possèdent une certaine caractéristique.

Une variation de $-1/5$ peut indiquer une diminution
d'une mesure de référence.

Ainsi, derrière une réponse produite par une IA,
on trouve souvent des données, des proportions,
des comparaisons et des calculs.

Les fractions constituent donc un véritable langage
mathématique permettant de #strong[mesurer et interpréter
les données].
]



// ==========================================================
// FIN DU PARCOURS
// ==========================================================

#align(center)[

#v(0.4cm)

#text(
  size: 10pt,
  weight: "bold",
  fill: code-blue,
)[
🤖 FRACTIONS → PROPORTIONS → DONNÉES → DÉCISION
]

#v(0.12cm)

#text(
  size: 10.5pt,
)[
Les mathématiques permettent à l'IA de transformer
des données en informations mesurables.
]

]


]
































#pagebreak()

// ==========================================================
// PARCOURS 4e
// NOMBRES RATIONNELS
// AVEC LA GESTION ET LA FINANCE
// ==========================================================

#parcours(
  [PARCOURS 4ᵉ — Nombres rationnels avec la gestion et la finance],
  "parcours-rationnels-4e",
) <parcours-rationnels-4e>


// ==========================================================
// MISE EN SITUATION
// ==========================================================
#activite[

💰 #strong[La gestion : représenter, comparer et faire évoluer des quantités]

Dans la vie quotidienne, une personne, une famille, une entreprise
ou une association doit prendre des décisions concernant ses
ressources.
Il faut notamment :

• connaître les sommes disponibles ;

• enregistrer les recettes et les dépenses ;

• prévoir un budget ;

• comparer des prix ;

• calculer des parts et des proportions ;

• suivre les bénéfices et les pertes ;

• répartir une somme entre plusieurs activités ;

• mesurer l'évolution d'une quantité.

Toutes ces opérations relèvent de la #strong[gestion].
Lorsqu'elles concernent particulièrement l'argent, on parle de
#strong[gestion financière].

#strong[Une attention particulière à l'écriture des sommes d'argent]

Dans les documents économiques et financiers, il est très important
de distinguer #strong[la partie entière], #strong[la partie décimale]
et #strong[les séparations entre les milliers].
En notation française, on utilise généralement :

• un #strong[espace] pour séparer les groupes de trois chiffres : $600 000$ FCFA ;

• une #strong[virgule] pour séparer la partie entière de la partie
décimale : $600,50$ FCFA.

Ainsi 
$600 000$ FCFA signifie #strong[six cent mille francs CFA].
Ce nombre est un #strong[entier] et il appartient donc également à
l'ensemble des nombres décimaux.

En revanche
$600,000$ signifie #strong[six cents] en écriture décimale française.

Dans certains documents ou logiciels utilisant les conventions anglo-saxonnes, on peut rencontrer $600.50$ pour représenter #strong[six cents virgule cinquante].

Le point joue alors le rôle de séparateur décimal.

En revanche, une écriture comme $600.000$ peut avoir une signification différente selon la convention utilisée. Il faut donc toujours
#strong[vérifier la convention d'écriture des nombres] utilisée dans un document financier.

Cette distinction est importante en économie et en gestion : #strong[une mauvaise lecture du séparateur peut modifier complètement la
valeur d'une somme.]
]

#activite[
Prenons l'exemple de l'entreprise #strong[CODE-Meuble].

Au début d'une journée, sa caisse contient : $600 000$ FCFA. Au cours de la journée, l'entreprise :

• reçoit $150 000$ FCFA d'un client ;

• dépense $90 000$ FCFA pour acheter du bois ;

• dépense $30 000$ FCFA pour acheter des accessoires ;

• reçoit encore $120 000$ FCFA grâce à la vente d'un meuble.

Pour suivre cette situation, il faut représenter aussi bien les #strong[augmentations] que les #strong[diminutions].
Une recette peut être représentée par un nombre positif et une dépense par un nombre négatif. Par exemple :
#strong[$+150 000$] et #strong[$-90 000$].

L'entreprise doit également savoir quelle partie de son budget est consacrée à chaque activité.

Supposons que, sur un budget de $1 000 000$ FCFA, $250 000$ FCFA soient consacrés à l'achat du bois. La part correspondante est :
$(250 000)/(1 000 000) = 1/4$.

Le bois représente donc #strong[un quart] du budget total.

Dans d'autres situations, les fractions permettent de représenter
des évolutions.
Une dépense de $200 000$ FCFA augmente de $50 000$ FCFA.
La variation relative correspondante est : $(50 000)/(200 000) = 1/4$.

Une dépense de $150 000$ FCFA diminue de $30 000$ FCFA.
La variation peut être représentée par :
$(-30 000)/(150 000) = -1/5$.

On rencontre ainsi, en gestion, des nombres tels que :
$1/4$, $3/5$, $7/10$, $11/20$, $-1/5$, $-3/4$.

Mais toutes les fractions ne possèdent pas une écriture décimale limitée.

Par exemple $1/4 = 0,25$ alors que $1/3 = 0,333...$

Le gestionnaire doit donc savoir choisir l'écriture la plus adaptée :
#strong[fraction, nombre décimal ou valeur approchée.]

À partir de cette situation, réponds aux questions suivantes :

1. Quelle fraction du budget de CODE-Meuble est consacrée au bois ?

2. Simplifie $(250 000)/(1 000 000)$.

3. Transforme $1/4$ en une fraction de dénominateur $100$.

4. Transforme $3/5$ en une fraction de dénominateur $10$.

5. Parmi les nombres suivants, lesquels possèdent une écriture
   décimale limitée ?

   $3/10$, $7/100$, $5/8$, $2/3$, $11/20$, $7/12$.

6. Peut-on écrire exactement $1/3$ avec un dénominateur égal à
   $10$, $100$ ou $1000$ ?

7. Une diminution peut-elle être représentée par un nombre négatif ?

8. Pourquoi un gestionnaire peut-il avoir besoin de nombres positifs
   et négatifs ?

9. Comment comparer deux parts de budget comme $2/5$ et $3/8$ ?

]
#activite[

10. Pourquoi une valeur approchée peut-elle être utile en gestion ?

11. Dans l'écriture française des nombres, que signifie :

   a) $600 000$ ?

   b) $600,000$ ?

   c) $600,50$ ?

12. Pourquoi faut-il connaître la convention utilisée lorsqu'on lit
    un document économique ou financier ?

Cette situation montre que les nombres rationnels permettent de
représenter des #strong[parts], des #strong[proportions],
des #strong[variations] et des #strong[quantités financières].

Elle montre également que, dans la gestion et la finance, une bonne
#strong[lecture de l'écriture des nombres] est essentielle pour éviter
les erreurs d'interprétation.

L'ensemble des nombres qui peuvent s'écrire sous la forme d'une
fraction dont le numérateur et le dénominateur sont des entiers
relatifs, avec un dénominateur non nul, est l'ensemble des
#strong[nombres rationnels], noté $ℚ$.
]


#v(0.25cm)

#align(center)[
  #image_full("gestion-rationnels-4e.jpeg")
]

#pagebreak()

#deux-colonnes[
// ==========================================================
// I — NOMBRE RATIONNEL ET OPPOSÉ
// ==========================================================

#sous_titre[
Nombre rationnel et opposé
]

#sous_sous_titre[
Notion de nombre rationnel
]

#definition[
Un #strong[nombre rationnel] est un nombre qui peut s'écrire sous
la forme : #strong[$a/b$]
où $a$ et $b$ sont des entiers relatifs et $b ≠ 0$.

L'ensemble des nombres rationnels est noté $ℚ$.
]

#exemple[
Les nombres suivants sont rationnels :

$1/2$, $-3/4$, $7/5$, $-11/2$, $8/1$.

En effet, chacun peut s'écrire sous la forme $a/b$ avec
$a,b ∈ ℤ$ et $b ≠ 0$.

Tout entier relatif est donc un nombre rationnel puisque : #strong[$a = a/1$].
]

#sous_sous_titre[
Opposé d'un nombre rationnel
]

#definition[
L'#strong[opposé] d'un nombre rationnel $a$ est le nombre $-a$.

Deux nombres opposés ont la même distance à zéro et des signes
contraires lorsqu'ils sont non nuls.
]

#exemple[
L'opposé de :

$3/4$ est $-3/4$ ;

$-5/7$ est $5/7$ ;

$8$ est $-8$ ;

$-2$ est $2$.
]

#sous_sous_titre[
Réinvestissement — Les ensembles de nombres
]

#exercice_resolu[

Une entreprise utilise les nombres suivants pour enregistrer ses
opérations :
$3$, $-2$, $0,51$, $2/3$, $-11/4$.

Indiquons à quels ensembles ils appartiennent.

On rappelle : $ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ$.

• $3 ∈ ℕ$, donc $3 ∈ ℤ$, $3 ∈ 𝔻$ et $3 ∈ ℚ$.

• $-2 ∈ ℤ$, donc $-2 ∈ 𝔻$ et $-2 ∈ ℚ$.

• $0,51 ∈ 𝔻$ et donc $0,51 ∈ ℚ$.

• $2/3 ∈ ℚ$, mais $2/3 ∉ 𝔻$.

• $-11/4 = -2,75$, donc $-11/4 ∈ 𝔻$ et $-11/4 ∈ ℚ$.

]

#retenir[

• Un nombre rationnel peut être positif, négatif ou nul.

• L'opposé de $a$ est noté $-a$.

• Deux nombres opposés ont la même distance à zéro.

• On a : $ℕ ⊂ ℤ ⊂ 𝔻 ⊂ ℚ$.

]


// ==========================================================
// II — FRACTION DÉCIMALE ET ÉCRITURE DÉCIMALE
// ==========================================================

#sous_titre[
Fraction décimale et écriture décimale
]

#sous_sous_titre[
Distinguer une fraction décimale d'une autre fraction
]

#definition[
Une #strong[fraction décimale] est une fraction dont le dénominateur est une puissance de $10$ :

$10$, $100$, $1000$, $10000$, etc.
]

#v(2cm)

#exemple[
Les fractions suivantes sont des fractions décimales :
$7/10$, $23/100$, $5/1000$ et $125/10000$.
]

#exemple[
Les fractions suivantes sont rationnelles mais ne sont pas écrites
avec un dénominateur qui est une puissance de $10$ :

$1/3$, $5/8$, $7/12$ et $11/15$.

Certaines peuvent néanmoins être transformées en fractions décimales.

Par exemple
$5/8 = 625/1000 = 0,625$.

En revanche, $1/3$ ne possède pas d'écriture décimale limitée.
]


#sous_sous_titre[
Écriture décimale limitée
]

#exemple_resolu[

Une entreprise consacre $1/4$ de son budget au transport. La fraction $1/4$ n'est pas écrite avec un dénominateur qui est une
puissance de $10$.

Mais $1/4 = 25/100$. Donc $1/4 = 0,25$.

Le transport représente donc exactement $25%$ du budget.
]

#sous_sous_titre[
Écriture décimale illimitée périodique
]

#propriete[
Pour une fraction irréductible :

• si son dénominateur ne contient comme facteurs premiers que $2$
  et/ou $5$, alors elle possède une écriture décimale limitée ;

• si son dénominateur possède un autre facteur premier, alors son
  écriture décimale est illimitée périodique.
]

#v(0.18cm)

#exemple_resolu[

Une entreprise consacre $5/6$ de son budget à plusieurs charges.

On a :
$5/6 = 0,83333...$
Le chiffre $3$ se répète indéfiniment.

L'écriture décimale est donc #strong[illimitée périodique].

La partie $8$ est non périodique et la période est $3$.

On peut écrire 
#strong[$5/6 = 0,8overline(3)$].
]

#retenir[

Un nombre rationnel possède toujours une écriture décimale :

• #strong[limitée], comme $1/4 = 0,25$ ;

ou

• #strong[illimitée périodique], comme $1/3 = 0,333...$.

]


// ==========================================================
// III — COMPARAISON DES NOMBRES RATIONNELS
// ==========================================================

#sous_titre[
Comparaison des nombres rationnels
]


#propriete[
Pour comparer deux nombres rationnels, on peut :

• les écrire sous forme décimale lorsqu'une écriture décimale exacte
  est disponible ;

• les réduire au même dénominateur ;

• utiliser un produit en croix lorsque les dénominateurs sont
  positifs.
]

#exemple_resolu[

Comparons $7/12$ et $5/8$.

On réduit au même dénominateur :

$7/12 = 14/24$
et
$5/8 = 15/24$.

Comme $14 < 15$ alors
$7/12 < 5/8$.

]

#sous_sous_titre[
Réinvestissement — Classement des parts de budget
]

#exercice[

💰 #strong[Exercice — Classement des parts de budget]

Une entreprise répartit une somme entre plusieurs activités. Les parts sont : $2/5$, $3/8$, $1/2$, $7/12$ et $-1/10$.

1. Compare les nombres rationnels suivants :

$2/5$ et $3/8$ ; $7/12$ et $1/2$ puis $1/4$ et $-1/5$.

2. Range dans l'ordre croissant : $2/5$ ; $3/8$ ; $1/2$ ; $7/12$ ; $-1/10$.

3. Compare : $-2/5$ et $-3/8$.

4. Interprète le nombre négatif dans le contexte de la gestion.
]


// ==========================================================
// IV — SOMME ET DIFFÉRENCE
// ==========================================================

#sous_titre[
Somme et différence de nombres rationnels
]


#propriete[
Pour additionner ou soustraire deux nombres rationnels :

• on conserve le même dénominateur lorsqu'ils l'ont déjà ;

• sinon, on recherche un dénominateur commun ;

• on additionne ou soustrait les numérateurs ;

• on simplifie le résultat lorsque cela est possible.
]

#exemple_resolu[

Une entreprise réalise une recette correspondant à $3/5$ de son objectif, puis une autre recette correspondant à $1/4$ de cet
objectif.

La proportion totale obtenue est :
$17/20$

En effet,

$3/5 + 1/4 = 12/20 + 5/20$

$3/5 + 1/4 = 17/20$.

]

#sous_sous_titre[
Réinvestissement — Bilan d'une journée
]
#exercice[

💰 #strong[Exercice — Bilan d'une journée]

Au cours d'une journée, une entreprise enregistre les variations
suivantes de son budget, exprimées en milliers de FCFA :

$+3/5$, $-2/3$, $+1/4$ et $-1/6$.

1. Calcule la variation totale.

2. Le résultat est-il positif ou négatif ?

3. Interprète le résultat dans le contexte de la gestion.
]


// ==========================================================
// V — PRODUIT
// ==========================================================

#sous_titre[
Produit de nombres rationnels
]

#propriete[
Pour multiplier deux nombres rationnels, on multiplie les
numérateurs entre eux et les dénominateurs entre eux.

Ainsi :

#strong[$a/b × c/d = (a × c)/(b × d)$]
avec $b ≠ 0$ et $d ≠ 0$.
]

#exemple_resolu[

Une entreprise consacre $2/5$ de ses bénéfices à l'investissement.

Elle utilise ensuite $3/4$ de cette somme pour acheter du matériel.

La part du bénéfice consacrée à cet achat est : $2/5 × 3/4$

$2/5 × 3/4 = 6/20$

$2/5 × 3/4 = 3/10$.

Ainsi, $3/10$ du bénéfice est consacré à l'achat du matériel.
]


#v(2cm)

#sous_sous_titre[
Réinvestissement — Répartition d'un bénéfice
]

#exercice[

💰 #strong[Exercice — Répartition d'un bénéfice]

Une entreprise réalise un bénéfice de $1\,200\,000$ FCFA.

Elle consacre :

• $2/5$ du bénéfice à l'investissement ;

• puis $3/4$ de cette somme à l'achat d'une nouvelle machine.

1. Calcule la somme consacrée à l'investissement.

2. Calcule la somme consacrée à la machine.

3. Quelle fraction du bénéfice total représente la somme consacrée
   à la machine ?
]


// ==========================================================
// VI — INVERSE ET QUOTIENT
// ==========================================================

#sous_titre[
Inverse et quotient de nombres rationnels
]

#sous_sous_titre[
Inverse d'un nombre rationnel non nul
]

#exemple_resolu[

💰 #strong[Partager une somme]

Une entreprise dispose de $2/5$ de million de FCFA et souhaite
répartir cette somme en parts de $1/10$ de million.

Pour savoir combien de parts sont possibles, on calcule :

$(2/5) ÷ (1/10)$.

On obtient :

$(2/5) × (10/1) = 4$.

L'entreprise peut donc constituer $4$ parts de $1/10$ de million.
]

#definition[
L'#strong[inverse] d'un nombre rationnel non nul #strong[$a/b$] est le nombre : #strong[$b/a$]. En effet :
#strong[$a/b × b/a = 1$].
]

#exemple_resolu[

Déterminons les inverses suivants :

• l'inverse de $2/5$ est $5/2$ ;

• l'inverse de $-3/7$ est $-7/3$ ;

• l'inverse de $11$ est $1/11$ ;

• l'inverse de $-5$ est $-1/5$.
]

#sous_sous_titre[
Quotient de deux nombres rationnels
]

#propriete[
Diviser par un nombre rationnel non nul revient à multiplier par
son inverse :

#strong[$a ÷ b = a × 1/b$].
]

#exemple[
Par exemple : $(2/5) ÷ (1/10) = (2/5) × (10/1)$

Alors $(2/5) ÷ (1/10) = 4$.
]

#sous_sous_titre[
Réinvestissement — Coût unitaire
]

#exercice[

💰 #strong[Exercice — Coût unitaire]

Une entreprise dépense $3/4$ de million de FCFA pour produire
$5/8$ de sa capacité mensuelle.

1. Écris le quotient : $(3/4) ÷ (5/8)$.

2. Remplace la division par une multiplication par un inverse.

3. Effectue le calcul.

4. Interprète le résultat.
]


// ==========================================================
// VII — APPROXIMATION DÉCIMALE
// ==========================================================

#sous_titre[
Approximation décimale d'un nombre rationnel
]

#sous_sous_titre[
Encadrement décimal
]

#v(0.15cm)

#exemple_resolu[

💰 #strong[Une valeur approchée pour une décision financière]

Un gestionnaire doit calculer : $11/7$.

À la calculatrice : 

$11/7 = 1,571428...$

Cette écriture est illimitée périodique.

Pour effectuer certains calculs pratiques, il peut utiliser une
valeur approchée.

On obtient : 

$1,571 < 11/7 < 1,572$.

Ainsi, $1,571$ est une approximation décimale d'ordre $3$ par défaut
et $1,572$ une approximation décimale d'ordre $3$ par excès.
]

#definition[
Un #strong[encadrement d'ordre $n$] d'un nombre consiste à trouver
deux nombres décimaux ayant $n$ chiffres après la virgule qui
l'encadrent.
]

#exemple_resolu[

Une entreprise calcule le coût moyen par produit : $11/7$ milliers de FCFA.

On a : 

$1,571 < 11/7 < 1,572$.

Au centième près : 

$1,57 < 11/7 < 1,58$.

L'arrondi au centième est : $1,57$.
]

#v(2cm)

#sous_sous_titre[
Arrondi d'un nombre rationnel
]

#exemple[
Pour arrondir un nombre au centième, on conserve deux chiffres
après la virgule et on observe le chiffre suivant.

Par exemple : $11/7 = 1,571428...$

Au centième près, on obtient : $1,57$.
]

#sous_sous_titre[
Réinvestissement — Prix moyen
]

#exercice[

💰 #strong[Exercice — Prix moyen]

Le coût moyen d'une opération est : $53/7$ milliers de FCFA.

1. Donne une valeur décimale de $53/7$.

2. Encadre $53/7$ par deux décimaux consécutifs d'ordre $3$.

3. Donne l'approximation d'ordre $2$ par excès.

4. Donne l'arrondi d'ordre $2$.

5. Explique pourquoi un gestionnaire peut préférer une valeur
   approchée dans un tableau financier.
]


// ==========================================================
// VIII — RÉINVESTISSEMENT
// ==========================================================

#sous_titre[
Réinvestissement — Gérer un budget
]

#sous_sous_titre[
Budget annuel d'une petite entreprise
]

#exercice[

💰 #strong[Budget annuel d'une petite entreprise]

Une entreprise dispose d'un budget de $3\,000\,000$ FCFA.

Elle prévoit :

• $2/5$ pour l'achat des matières premières ;

• $1/6$ pour les salaires ;

• $1/10$ pour le transport ;

• le reste pour les autres dépenses.

1. Calcule la part du budget consacrée aux trois premières
   catégories.

2. Détermine la fraction restante.

3. Calcule le montant correspondant à chaque catégorie.

4. Compare la part consacrée aux matières premières à celle
   consacrée aux salaires.

5. Quelle catégorie reçoit la plus grande part ?

6. Si les dépenses de transport diminuent de $1/20$ du budget,
   quelle nouvelle fraction représente le transport ?

7. Donne cette fraction sous forme décimale si possible.
]


// ==========================================================
// IX — PUISSANCES
// ==========================================================

#sous_titre[
Puissances d'un nombre rationnel
]

#sous_sous_titre[
Définition d'une puissance
]

#definition[
Pour un nombre rationnel $a$ et un entier naturel non nul $n$ :

#strong[$a^n = a × a × ... × a$]

avec $n$ facteurs égaux à $a$.
]

#v(0.18cm)

#exemple[
Dans un modèle simplifié, un capital est multiplié chaque année
par $6/5$.

Après deux applications du même coefficient, le facteur global est :

$(6/5)^2 = 36/25$.

Après trois applications :

$(6/5)^3 = 216/125$.
]


#v(0.3cm)

#sous_sous_titre[
Propriétés des puissances
]

#v(0.15cm)

#propriete[
Pour tout nombre rationnel non nul $a$ et pour tous entiers naturels
$m$ et $n$ :

#strong[$a^m × a^n = a^(m+n)$].

#strong[$(a^m)^n = a^(m×n)$].

#strong[$a^m / a^n = a^(m-n)$] lorsque $m ≥ n$.
]

#v(0.18cm)

#exemple_resolu[

Simplifions : $(3/5)^2 × (3/5)^4$.

En utilisant la propriété des puissances :

$(3/5)^(2+4) = (3/5)^6$.
]

#sous_titre[
Identités remarquables
]

#definition[

Pour tous nombres $a$ et $b$, on dispose de trois égalités
importantes appelées #strong[identités remarquables].

Elles permettent de développer ou de factoriser certaines
expressions algébriques plus rapidement.

]

#v(0.15cm)

#propriete[

Pour tous nombres $a$ et $b$ :

• #strong[Carré d'une somme]

$(a + b)^2 = a^2 + 2a b + b^2$.

• #strong[Carré d'une différence]

$(a - b)^2 = a^2 - 2a b + b^2$.

• #strong[Produit d'une somme par une différence]

$(a + b)(a - b) = a^2 - b^2$.

]

#exemple[

Lors du calcul de certaines dimensions d'une structure de
satellite, on peut rencontrer l'expression :
$(5 + √3)^2$.

En utilisant la première identité remarquable :

$(5 + √3)^2$
$= 5^2 + 2 × 5 × √3 + (√3)^2$

$(5 + √3)^2$
$= 25 + 10√3 + 3$

$(5 + √3)^2$
$= 28 + 10√3$.

Ainsi : #strong[$(5 + √3)^2 = 28 + 10√3$.]

]
#exemple[

On peut également rencontrer l'expression :
$(5 - √3)^2$.

En utilisant la deuxième identité remarquable :

$(5 - √3)^2$
$= 5^2 - 2 × 5 × √3 + (√3)^2$

$(5 - √3)^2$
$= 25 - 10√3 + 3$

Ainsi : #strong[$(5 - √3)^2 = 28 - 10√3$.]

]

#exemple[

Enfin, le produit des deux expressions conjuguées :

$(5 + √3)(5 - √3)$

peut être calculé avec la troisième identité remarquable :

$(5 + √3)(5 - √3)$
$= 5^2 - (√3)^2$

$(5 + √3)(5 - √3)$
$= 25 - 3$

Ainsi : #strong[$(5 + √3)(5 - √3) = 22$.]

]

#retenir[

Les trois identités remarquables sont :

$(a + b)^2 = a^2 + 2a b + b^2$

$(a - b)^2 = a^2 - 2a b + b^2$

$(a + b)(a - b) = a^2 - b^2$.

Elles permettent notamment de #strong[développer] ou de
#strong[factoriser] certaines expressions.

]

#sous_sous_titre[
Réinvestissement — Évolution répétée d'un stock
]

#exercice[

💰 #strong[Exercice — Évolution répétée d'un stock]

Un magasin applique un coefficient $4/5$ à la quantité d'un article
restant après chaque opération de contrôle.

1. Écris sous forme de puissance la quantité obtenue après
   trois applications du coefficient.

2. Calcule : $(4/5)^3$.

3. Simplifie : $(4/5)^2 × (4/5)^3$.

4. Donne le signe de : $(-2/3)^4$ ; $(-2/3)^5$ ; $-(2/3)^6$.

5. Interprète le signe obtenu dans le contexte d'une évolution
   financière ou commerciale.
]


// ==========================================================
// X — PROBLÈME DE SYNTHÈSE
// ==========================================================

#sous_titre[
Problème de synthèse
]

#sous_sous_titre[
Projet — Le bilan financier de CODE-Meuble
]

#exercice[

💰 #strong[PROJET — Le bilan financier de CODE-Meuble]

CODE-Meuble dispose au début du mois d'un budget de
$2 400 000$ FCFA.

Le responsable prévoit :

• $2/5$ pour l'achat du bois ;

• $1/4$ pour les accessoires ;

• $1/6$ pour le transport ;

• le reste pour les autres dépenses.

Au cours du mois, l'entreprise réalise également une recette
correspondant à $3/4$ du budget initial, puis une dépense
correspondant à $2/5$ de cette recette.

#v(2cm)

#strong[Partie A — Fractions et budget]

1. Quelle fraction du budget est consacrée au bois et aux
   accessoires réunis ?

2. Quelle fraction du budget reste-t-il après les trois premières
   catégories ?

3. Calcule le montant consacré au bois.

4. Calcule le montant consacré aux accessoires.

#strong[Partie B — Comparaison]

5. Compare les parts $2/5$ et $1/4$.

6. Range dans l'ordre croissant : $1/6$ ; $1/4$ ; $2/5$ ; $3/4$.

#strong[Partie C — Recette et dépense]

7. Exprime la recette sous forme d'une fraction du budget initial.

8. Quelle fraction du budget initial représente la dépense effectuée
   sur cette recette ?

9. Calcule cette fraction.

#strong[Partie D — Nombres positifs et négatifs]

10. Une recette est représentée par $+3/4$ et une dépense par
    $-2/5$.

    Explique le rôle du signe dans chacune de ces écritures.

11. Détermine l'opposé de : $3/4$, $-2/5$, $7/10$.

#strong[Partie E — Approximation]

12. Le coût moyen d'un article est $53/7$ milliers de FCFA.

    a) Donne une valeur décimale de cette quantité.

    b) Encadre-la par deux décimaux consécutifs d'ordre $2$.

    c) Donne son arrondi au centième.

#strong[Partie F — Puissances]

13. Un coefficient d'évolution égal à $6/5$ est appliqué pendant
    trois périodes.

    Écris le coefficient global sous forme d'une puissance.

14. Calcule : $(6/5)^3$.

15. Explique ce que signifie cette puissance dans le contexte
    de l'évolution d'une quantité.
]

#v(4cm)
// ==========================================================
// XI — DÉFI DU GESTIONNAIRE
// ==========================================================

#sous_titre[
Défi du gestionnaire
]

#sous_sous_titre[
Mission — Préparer le budget d'une petite entreprise
]

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

💰 #strong[MISSION — Préparer le budget d'une petite entreprise]

Tu fais partie d'une équipe chargée de préparer le budget mensuel
d'une petite entreprise.

Le budget disponible est de $4\,000\,000$ FCFA.

Les responsables prévoient :

• $3/8$ pour les matières premières ;

• $1/5$ pour les salaires ;

• $1/10$ pour le transport ;

• $1/20$ pour la communication.

Le reste est réservé aux dépenses imprévues.

#v(0.15cm)

1. Calculer la fraction du budget consacrée aux quatre catégories.

2. Déterminer la fraction restante.

3. Calculer le montant correspondant à chaque catégorie.

4. Quelle catégorie reçoit la plus grande somme ?

5. Une dépense imprévue représente $-1/20$ du budget.

   Interprète le signe négatif.

6. Compare $3/8$ et $2/5$.

7. Le coût d'un service est $53/7$ milliers de FCFA.

   Donne son arrondi au centième.

8. Un coefficient multiplicateur de $4/3$ est appliqué deux fois.

   Écris le coefficient global sous forme de puissance.

9. Explique pourquoi les nombres rationnels sont particulièrement
   utiles pour représenter les parts, les variations et les
   répartitions d'un budget.
]


// ==========================================================
// XII — SYNTHÈSE DU PARCOURS
// ==========================================================

#sous_titre[
Synthèse du parcours
]

#sous_sous_titre[
Les nombres rationnels
]

#v(0.15cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Un nombre rationnel peut s'écrire : #strong[$a/b$]

avec $a,b ∈ ℤ$ et $b ≠ 0$.
]

#sous_sous_titre[
Opposé
]

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

L'opposé de $a$ est $-a$.

Une recette de $+50 000$ FCFA et une dépense de
$-50 000$ FCFA correspondent à deux variations opposées.
]

#sous_sous_titre[
Comparaison
]
#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Pour comparer deux nombres rationnels, on peut utiliser :

• un même dénominateur ;

• une écriture décimale ;

• un produit en croix lorsque les dénominateurs sont positifs.
]

#sous_sous_titre[
Somme et différence
]

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Pour additionner ou soustraire des fractions, on les réduit
au même dénominateur.
]

#sous_sous_titre[
Produit
]

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

#strong[$a/b × c/d = (a × c)/(b × d)$].
]

#sous_sous_titre[
Inverse
]

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

L'inverse de $a/b$, avec $a ≠ 0$, est $b/a$.
]


#v(0.25cm)

#sous_sous_titre[
Quotient
]

#v(0.15cm)

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Diviser par un nombre rationnel non nul revient à multiplier
par son inverse.
]


#v(0.25cm)

#sous_sous_titre[
Approximation
]

#v(0.15cm)

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Un nombre rationnel peut avoir une écriture décimale limitée
ou illimitée périodique.

Une valeur approchée permet de travailler plus facilement
avec certaines quantités.
]


#v(0.25cm)

#sous_sous_titre[
Puissances
]

#v(0.15cm)

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Une puissance permet d'écrire simplement un produit de facteurs
identiques :

$a^n = a × a × ... × a$.
]


#v(0.25cm)

#sous_sous_titre[
Gestion
]

#v(0.15cm)

#box(
  width: 100%,
  fill: rgb("#E8F1FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

Les nombres rationnels permettent de représenter :

• des parts de budget ;

• des proportions ;

• des recettes et des dépenses ;

• des bénéfices et des pertes ;

• des répartitions ;

• des coefficients d'évolution ;

• des coûts moyens ;

• des variations de quantités.
]

#v(4cm)
// ==========================================================
// XIII — CE QUE TU DOIS SAVOIR FAIRE
// ==========================================================

#sous_titre[
Ce que tu dois savoir faire
]

#v(0.18cm)

#box(
  width: 100%,
  fill: rgb("#F4F7FA"),
  radius: 10pt,
  inset: 0.25cm,
)[

💰 Reconnaître et utiliser un nombre rationnel.

#v(0.08cm)

↔️ Déterminer l'opposé d'un nombre rationnel.

#v(0.08cm)

📍 Placer un nombre rationnel sur une droite graduée.

#v(0.08cm)

🔢 Distinguer une fraction décimale d'une autre fraction.

#v(0.08cm)

⚖️ Comparer des nombres rationnels.

#v(0.08cm)

➕ Additionner et soustraire des nombres rationnels.

#v(0.08cm)

✖️ Multiplier des nombres rationnels.

#v(0.08cm)

➗ Diviser des nombres rationnels.

#v(0.08cm)

🔄 Déterminer l'inverse d'un nombre rationnel non nul.

#v(0.08cm)

📐 Donner une approximation décimale d'un nombre rationnel.

#v(0.08cm)

⚡ Utiliser les puissances d'un nombre rationnel.

#v(0.08cm)

💼 Utiliser les nombres rationnels pour représenter des parts,
des proportions et des variations.

#v(0.08cm)

📊 Utiliser les nombres rationnels pour analyser et gérer
un budget.

#v(0.08cm)

💰 Résoudre un problème de gestion en mobilisant plusieurs
notions sur les nombres rationnels.
]


// ==========================================================
// FIN DU PARCOURS
// ==========================================================

#v(8cm)


#text(
  size: 15pt,
  weight: "bold",
  fill: code-blue,
)[
💰 DES NOMBRES À LA GESTION FINANCIÈRE
]

#v(0.12cm)

Les nombres rationnels permettent de représenter précisément
des parts, des proportions, des recettes, des dépenses et
des variations.

#v(0.08cm)

Une fraction comme $3/5$ n'est donc pas seulement une écriture
mathématique :

elle peut représenter une part réelle d'un budget,
d'une production ou d'une dépense.

#v(0.12cm)

#strong[
Les mathématiques deviennent alors un outil pour
prévoir, répartir, comparer, calculer et prendre des décisions.
]
]
]



