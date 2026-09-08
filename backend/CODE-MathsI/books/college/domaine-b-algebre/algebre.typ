#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let algebre() = [

#debut_notion()

// ==========================================================
// TITRE DE LA NOTION
// ==========================================================
#pagebreak()



#title(
  [I — L'HISTOIRE DE L'ALGÈBRE],
  "notion-algebre",
) <notion-algebre>

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
🌍 D'où vient le besoin de l'algèbre ?
]

Bien avant l'apparition de l'algèbre comme branche des
mathématiques, les êtres humains devaient déjà résoudre
des problèmes concrets.
Il fallait partager des récoltes, calculer des quantités,
déterminer des longueurs, organiser des échanges, construire
des bâtiments, mesurer des terrains ou encore retrouver une
quantité inconnue.
Une question revenait alors souvent :
#strong[
« Quelle est la quantité que je cherche ? »
]
Pour répondre à ces questions, les premières civilisations
ont d'abord utilisé des méthodes concrètes : dessins,
schémas, objets, marques, nombres et opérations.
Peu à peu, les mathématiciens ont cherché des méthodes
générales permettant de résoudre plusieurs problèmes de
même nature.
C'est ainsi que s'est progressivement développée une
nouvelle manière de raisonner sur les nombres et les
quantités inconnues : #strong[l'algèbre].


#strong[
🏺 Les premières traces : les mathématiques de l'Antiquité
]

Les premières grandes civilisations ont développé des
méthodes permettant de résoudre des problèmes liés au
commerce, aux récoltes, aux impôts, aux constructions et
aux mesures.
En #strong[Mésopotamie], les scribes utilisaient déjà,
il y a plusieurs milliers d'années, des méthodes permettant
de résoudre des problèmes dans lesquels une quantité
inconnue devait être déterminée.
Les mathématiques étaient alors principalement écrites
sous forme de problèmes concrets.
Par exemple, on pouvait chercher une quantité qui, augmentée
d'une autre quantité connue, donnait un résultat déterminé.
Les nombres et les opérations permettaient alors de retrouver
la quantité inconnue.
Les mathématiques de l'Égypte ancienne ont également
développé des méthodes pour résoudre des problèmes de
partage, de mesure et de calcul.
À cette époque, il n'existait cependant pas encore de
notation algébrique utilisant des lettres comme celle que
nous connaissons aujourd'hui.

#strong[
🏛️ Les Grecs : raisonner et démontrer
]

Dans la Grèce antique, les mathématiques ont progressivement
pris une nouvelle dimension.
Les mathématiciens grecs ne cherchaient pas seulement à
obtenir un résultat : ils voulaient également comprendre
#strong[pourquoi] un résultat était vrai et construire des
raisonnements démontrés.
Des mathématiciens comme #strong[Euclide] ont développé une
géométrie fondée sur des définitions, des propriétés et des
démonstrations.
Les problèmes de longueurs, d'aires et de figures géométriques
ont ainsi contribué au développement de méthodes qui seront
plus tard importantes pour l'algèbre.
Cependant, les Grecs exprimaient généralement les relations
algébriques à l'aide de mots et de figures plutôt qu'avec
des lettres.

#strong[
🌏 L'apport majeur des mathématiques indiennes
]

Au cours des siècles suivants, les mathématiques se sont
développées dans différentes régions du monde.
Les mathématiciens de l'#strong[Inde] ont apporté des
contributions essentielles à l'histoire des nombres et de
l'algèbre.
Ils ont notamment développé et perfectionné l'utilisation
du #strong[zéro] ainsi que le système de numération décimale
positionnelle.
Ces avancées ont profondément facilité les calculs et la
manipulation des nombres.
Les mathématiciens indiens ont également développé des
méthodes permettant de résoudre des équations et des
problèmes comportant des quantités inconnues.
L'utilisation plus systématique de règles de calcul a ainsi
contribué à faire évoluer les mathématiques vers une forme
plus proche de l'algèbre moderne.
]

#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[

#strong[
🌙 Le monde arabo-musulman : naissance d'une nouvelle discipline
]

Entre le VIIIᵉ et le Xᵉ siècle, les mathématiques connaissent
un développement remarquable dans le monde arabo-musulman.
Des savants traduisent, étudient et développent des connaissances
issues notamment des traditions grecque, indienne et mésopotamienne.
Parmi eux se trouve le mathématicien persan
#strong[Muhammad ibn Musa al-Khwarizmi].
Vers le IXᵉ siècle, il rédige un ouvrage consacré à la
résolution des équations.
Le mot #strong[algèbre] vient de l'arabe
#strong[al-jabr], terme utilisé dans le titre de cet ouvrage.
Al-Khwarizmi développe des méthodes systématiques pour
transformer et résoudre certaines équations.
Son travail joue un rôle majeur dans l'histoire de l'algèbre.
Le mot #strong[algorithme] est également lié, par l'histoire
du mot, au nom latinisé d'#strong[Al-Khwarizmi].

#strong[
✍️ De la quantité inconnue à la lettre
]

Pendant longtemps, les mathématiciens écrivaient les problèmes
algébriques essentiellement avec des mots.
Progressivement, une notation plus symbolique s'est mise en
place.
Les mathématiciens ont commencé à utiliser des symboles pour
représenter des opérations et des quantités inconnues.
Une étape importante est franchie lorsque les lettres commencent
à être utilisées pour représenter des nombres quelconques ou
des quantités inconnues.
Par exemple, au lieu d'écrire uniquement :
« un nombre augmenté de $5$ donne $12$ »,
on peut représenter le nombre inconnu par une lettre :
$x + 5 = 12$.
La lettre $x$ représente alors la quantité que l'on cherche.
Cette écriture rend les raisonnements plus courts et permet
de construire des méthodes générales.


#strong[
📐 L'algèbre et la géométrie
]

L'algèbre ne s'est pas développée indépendamment de la
géométrie.
Les mathématiciens ont souvent utilisé des longueurs,
des aires et des figures pour représenter des relations
entre des quantités.
Par exemple, une aire rectangulaire de longueur $x$ et de
largeur $5$ peut être représentée par :
$x × 5$.
De même, une relation entre plusieurs dimensions peut être
traduite par une expression algébrique.
L'algèbre permet ainsi de transformer un problème géométrique
en une relation entre des nombres et des lettres.
Cette rencontre entre l'algèbre et la géométrie est devenue
essentielle dans le développement des mathématiques.


#strong[
🌍 L'algèbre devient un langage universel
]

À partir de la Renaissance puis au cours des siècles suivants,
la notation algébrique s'est progressivement perfectionnée.
Les mathématiciens européens ont contribué à généraliser
l'utilisation des lettres, des signes opératoires et des
symboles.
Les écritures deviennent progressivement plus proches de
celles utilisées aujourd'hui.
L'algèbre permet alors de représenter non seulement une
quantité inconnue, mais également une quantité quelconque.
Par exemple :
$a + b$
peut représenter la somme de deux nombres quelconques.
De même :
$2x + 3$
représente une expression dans laquelle $x$ peut prendre
différentes valeurs.
L'algèbre devient ainsi un véritable #strong[langage
mathématique] permettant de représenter des situations,
d'exprimer des relations et de résoudre des problèmes.

#strong[
🚀 L'algèbre dans le monde moderne
]

Aujourd'hui, l'algèbre est présente dans de nombreux domaines.
Elle intervient notamment en physique, ingénierie, architecture, économie , informatique, sciences naturelles , statistiques, technologie, cryptographie , intelligence artificielle.

Lorsqu'un ingénieur cherche une dimension, lorsqu'un économiste
étudie l'évolution d'une quantité, lorsqu'un informaticien
conçoit un programme ou lorsqu'un scientifique modélise un
phénomène, il peut utiliser des relations algébriques.
L'algèbre permet donc de passer d'une situation concrète à
un modèle mathématique.

]

#box(
  width: 100%,
  fill: rgb("#EEF6FF"),
  radius: 12pt,
  inset: 0.3cm,
  stroke: 0.8pt + code-blue,
)[

#strong[
🔎 De l'histoire à l'apprentissage
]

L'histoire de l'algèbre montre ainsi une évolution progressive :

#[
Situation concrète

→ quantité inconnue

→ raisonnement

→ symbole

→ lettre

→ expression algébrique

→ équation
]


L'algèbre n'est donc pas apparue uniquement pour manipuler
des lettres.
Elle est née du besoin de #strong[résoudre des problèmes],
de #strong[représenter des relations] et de #strong[généraliser
les raisonnements].
C'est cette longue évolution qui a conduit aux outils
algébriques que nous utilisons aujourd'hui.


// ==========================================================
// OBJECTIFS DE LA NOTION
// ==========================================================

#objectif[

À travers cette notion, l'apprenant doit être capable de :

• comprendre l'origine historique de l'algèbre ;

• expliquer pourquoi les êtres humains ont eu besoin de
  représenter des quantités inconnues ;

• découvrir quelques grandes étapes de l'évolution de
  l'algèbre ;

• connaître les contributions de différentes civilisations
  au développement des mathématiques ;

• comprendre le rôle d'Al-Khwarizmi dans l'histoire de
  l'algèbre ;

• comprendre progressivement le passage d'un problème concret
  à une écriture symbolique ;

• utiliser des lettres pour représenter des nombres inconnus
  ou quelconques ;

• reconnaître une expression algébrique ;

• comprendre que l'algèbre constitue un langage permettant
  de représenter des relations entre des quantités ;

• utiliser les outils algébriques dans des situations
  concrètes.

]
]

#v(0.2cm)

#align(center)[

#image_full("histoire-algebre-origine.png")

]

















// ==========================================================
// PARCOURS 6e — EXPRESSION LITTÉRALE ET CALCUL LITTÉRAL
// ==========================================================

#parcours(
  [PARCOURS 6ᵉ — Découvrir l'expression littérale avec l'ingénierie],
  "parcours-calcul-litteral-6e",
) <parcours-calcul-litteral-6e>


// ==========================================================
// MISE EN SITUATION
// ==========================================================

#activite[

⚙️ #strong[L'ingénierie : concevoir des objets et des systèmes]

L'#strong[ingénierie] consiste à utiliser les connaissances
scientifiques et techniques pour concevoir, fabriquer, tester
et améliorer des objets, des machines, des bâtiments ou des
systèmes répondant à des besoins précis.
Les ingénieurs interviennent dans de nombreux domaines :

• le #strong[génie civil], pour concevoir des bâtiments, des ponts
  et des routes ;

• le #strong[génie mécanique], pour concevoir des machines et
  des mécanismes ;

• le #strong[génie électrique], pour concevoir des installations
  et des systèmes électriques ;

• le #strong[génie électronique], pour concevoir des circuits
  et des appareils ;

• le #strong[génie informatique], pour concevoir des systèmes
  numériques et des logiciels ;

• le #strong[génie aérospatial], pour concevoir des avions,
  des satellites et des véhicules spatiaux.

📐 #strong[Des dimensions qui peuvent changer]

Lorsqu'un ingénieur conçoit une pièce, toutes ses dimensions
ne sont pas nécessairement fixées à l'avance.
Imaginons une pièce rectangulaire utilisée dans une machine.
Sa largeur est de $4$ cm, tandis que sa longueur peut varier
selon le modèle choisi.
Pour représenter cette longueur variable, on peut utiliser
une lettre.
On note par exemple sa longueur :
#strong[
$L$
]

Si la longueur de la pièce est $L$ cm et sa largeur est $4$ cm,
son périmètre peut être calculé en additionnant ses quatre côtés :
#strong[$L + 4 + L + 4$].
On peut écrire plus simplement :
#strong[$2 × L + 8$].
Ainsi, une même écriture permet de représenter le périmètre
pour différentes valeurs de $L$.
Par exemple, si l'ingénieur choisit :
$L = 6$ cm,
alors :
$2 × 6 + 8 = 20$.
Le périmètre de la pièce est donc de $20$ cm.
Si l'ingénieur choisit :
$L = 10$ cm,
alors :
$2 × 10 + 8 = 28$.
Le périmètre est alors de $28$ cm.

🔤 #strong[Pourquoi utiliser une lettre ?]

La lettre permet ici de représenter une #strong[grandeur qui peut
prendre différentes valeurs].
Au lieu de refaire une nouvelle formule pour chaque dimension,
l'ingénieur peut utiliser une seule expression :
$2 × L + 8$.
Cette écriture peut ensuite être utilisée avec différentes
valeurs de $L$.
Les mathématiques utilisent un nom précis pour désigner une
écriture contenant des nombres, des lettres et des opérations.
On l'appelle une #strong[expression littérale].
Par exemple :
$2 × L + 8$
est une expression littérale.
De même :
$3 × x + 5$
et 
$4 × a$
sont des expressions littérales.
Lorsqu'on effectue des calculs avec des expressions contenant
des lettres, on réalise du #strong[calcul littéral].

]

#pagebreak()
// ==========================================================
// OBJECTIFS
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

À la fin de cette notion, tu seras capable de :

• reconnaître une #strong[expression littérale] ;

• comprendre le rôle d'une #strong[lettre] dans une expression ;

• écrire une expression littérale à partir d'une situation ;

• remplacer une lettre par une valeur donnée ;

• calculer la #strong[valeur d'une expression littérale] ;

• utiliser des expressions littérales dans des situations
  simples d'ingénierie.

]

#v(0.3cm)

#align(center)[

#image_full("calcul-litteral-6e.png")

]

// ==========================================================
// I — EXPRESSION LITTÉRALE
// ==========================================================

#deux-colonnes[

#sous_titre[
Expression littérale
]

#definition[

Une #strong[expression littérale] est une expression mathématique
qui contient #strong[un ou plusieurs nombres, des lettres et des
opérations].

La lettre représente un nombre ou une grandeur dont la valeur
peut varier ou qui n'est pas encore connue.

]

#exemple[

Lors de la conception d'une pièce mécanique, sa longueur est
notée $L$ cm et sa largeur est de $5$ cm.

Son périmètre est : $L + 5 + L + 5$.

On peut aussi écrire : $2 × L + 10$.

L'expression : $2 × L + 10$
est une #strong[expression littérale].

]

#exemple[

Un ingénieur souhaite fabriquer une rangée de $n$ petits
composants électroniques identiques.
Chaque composant mesure $3$ cm de longueur.

La longueur totale de la rangée est :
$3 × n$.

L'expression :
$3 × n$
permet de représenter cette longueur pour différentes valeurs
de $n$.

]

#retenir[

Dans une expression littérale :

• la #strong[lettre] représente un nombre ou une grandeur ;

• les #strong[nombres] sont appelés coefficients ou constantes
  selon leur rôle ;

• les opérations permettent de relier les nombres et les lettres.

Une expression littérale permet donc de représenter
mathématiquement une situation générale.

]


// ==========================================================
// II — ÉCRIRE UNE EXPRESSION LITTÉRALE
// ==========================================================

#sous_titre[
Écrire une expression littérale
]

Pour écrire une expression littérale, on traduit une situation
en utilisant une lettre pour représenter la grandeur variable.

#exemple[

Un ingénieur construit une structure rectangulaire.
Sa longueur est $x$ cm et sa largeur est $6$ cm.
Le périmètre est :
$x + 6 + x + 6$.

Donc :
$P = 2 × x + 12$.


]

#exemple[

Un système comporte $n$ modules identiques.
Chaque module possède $4$ capteurs.

Le nombre total de capteurs est :
$4 × n$.

Ainsi, $4 × n$ est une expression littérale.

]

#retenir[

Pour traduire une situation :

1. on choisit une lettre pour représenter la grandeur variable ;

2. on identifie les opérations à effectuer ;

3. on écrit l'expression littérale correspondante.

]


// ==========================================================
// III — CALCULER LA VALEUR D'UNE EXPRESSION LITTÉRALE
// ==========================================================
#sous_titre[
Calculer la valeur d'une expression littérale
]

Lorsqu'on connaît la valeur de la lettre, on peut calculer
la valeur de l'expression littérale.
Pour cela, on #strong[remplace la lettre par sa valeur], puis
on effectue les calculs.

#exemple_resolu[

Une pièce mécanique possède un périmètre donné par :
$P = 2 × L + 8$.

L'ingénieur choisit :
$L = 7$ cm.

On remplace $L$ par $7$ :

$P = 2 × 7 + 8$

$P = 14 + 8$

$P = 22$.

Donc le périmètre de la pièce est :
#strong[$22$ cm].

]

#exemple_resolu[

Un dispositif électronique comporte $n$ capteurs.
Chaque module possède $5$ capteurs.

Le nombre total de capteurs est :
$N = 5 × n$.

Pour $n = 8$ modules :

$N = 5 × 8$

$N = 40$.

Le dispositif possède donc :
#strong[$40$ capteurs].


]


// ==========================================================
// IV — ÉCRITURES SIMPLIFIÉES
// ==========================================================

#sous_titre[
Simplifier certaines écritures
]
#retenir[
En calcul littéral, on peut parfois écrire une multiplication
de manière plus simple.

Par exemple : $2 × x$ peut s'écrire :
$2x$.


De même : $5 × L$ peut s'écrire :
$5L$.

Le signe $×$ est alors supprimé entre le nombre et la lettre.]

#exemple[

Lors de la conception d'un système mécanique, un ingénieur
utilise $n$ pièces identiques de masse $3$ kg chacune.

La masse totale est :
$3 × n$.

On peut écrire plus simplement :
$3n$.

Si $n = 12$ alors $3n = 3 × 12 = 36$.

La masse totale est donc de $36$ kg.

]

#v(4cm)

#remarque[

On écrit généralement :

$2 × x = 2x$
et 
$7 × a = 7a$.

Mais on conserve le signe $×$ lorsqu'il permet d'éviter
une confusion ou lorsque deux nombres sont multipliés.
Par exemple : $3 × 5$
reste généralement écrit $3 × 5$.
]


// ==========================================================
// V — CALCUL LITTÉRAL
// ==========================================================

#sous_titre[
Calcul littéral
]

#definition[

Le #strong[calcul littéral] est l'ensemble des méthodes qui
permettent d'effectuer des calculs avec des expressions contenant
des lettres.

Il permet notamment de :

• écrire des expressions littérales ;

• simplifier certaines écritures ;

• remplacer les lettres par des valeurs ;

• calculer la valeur d'une expression.

]

#exemple[

Un ingénieur étudie une plaque rectangulaire de longueur $L$
et de largeur $4$ cm.

Son périmètre est :
$P = 2L + 8$.

Pour $L = 9$ cm :

$P = 2 × 9 + 8$

$P = 18 + 8$

$P = 26$.

Ainsi, le calcul littéral permet d'abord de représenter
la situation par $P = 2L + 8$,
puis de calculer le résultat lorsque la valeur de $L$ est connue.

]

#v(4cm)
// ==========================================================
// VI — APPLICATIONS À L'INGÉNIERIE
// ==========================================================

#sous_titre[
Applications
]

#exercice[

Une équipe d'ingénieurs conçoit une petite passerelle métallique.
Sa longueur est $L$ m et sa largeur est $3$ m.

1. Écris une expression littérale représentant son périmètre.

2. Calcule ce périmètre pour $L = 8$ m.

3. Calcule ce périmètre pour $L = 12$ m.

]

#exercice[

Un ingénieur assemble des modules solaires.

Chaque module possède $6$ cellules photovoltaïques.

On note $n$ le nombre de modules.

1. Écris une expression littérale représentant le nombre total
   de cellules photovoltaïques.

2. Calcule ce nombre pour $n = 5$.

3. Calcule ce nombre pour $n = 12$.

]

#v(0.15cm)

#exercice[

Un robot industriel utilise $4$ roues identiques.

Chaque roue a une masse de $m$ kg.

1. Écris une expression littérale représentant la masse totale
   des quatre roues.

2. Calcule cette masse pour $m = 7$ kg.

]

#v(0.15cm)

#exercice[

Un ingénieur dispose de $x$ mètres de câble.

Il utilise $5$ mètres pour une première partie de l'installation
et $8$ mètres pour une deuxième partie.

1. Écris une expression littérale représentant la longueur
   de câble restante.

2. Calcule cette longueur lorsque $x = 25$ m.

]


// ==========================================================
// À RETENIR
// ==========================================================

#v(0.45cm)


#retenir[
🎯 #strong[À retenir — Expression littérale et calcul littéral]

Une #strong[expression littérale] contient des nombres,
des lettres et des opérations.

La #strong[lettre] représente un nombre ou une grandeur
qui peut varier ou qui n'est pas encore connue.

Par exemple :

$2x + 5$ est une expression littérale.

Le #strong[calcul littéral] permet d'effectuer des calculs
avec des expressions contenant des lettres.

Pour calculer la valeur d'une expression littérale :

1. on remplace la lettre par sa valeur ;

2. on effectue les calculs en respectant les priorités
   opératoires.

Par exemple, si :

$x = 6$,

alors :

$2x + 5 = 2 × 6 + 5 = 17$.

Dans les domaines de l'ingénierie, les expressions littérales
permettent de représenter des situations générales avant de
remplacer les lettres par des valeurs particulières.
]




]






// ==========================================================
// PARCOURS 4e — CALCULS SUR LES EXPRESSIONS ALGÉBRIQUES,
// ÉQUATIONS ET INÉQUATIONS
// ==========================================================

#pagebreak()

#parcours(
  [PARCOURS 4ᵉ — Calculs sur les expressions algébriques, équations et inéquations avec l'aéronautique],
  "parcours-calculs-expressions-algebriques-4e",
) <parcours-calculs-expressions-algebriques-4e>


// ==========================================================
// MISE EN SITUATION
// ==========================================================

#activite[

✈️ #strong[L'aéronautique : imaginer, concevoir et faire voler]


L'#strong[aéronautique] est le domaine scientifique et technique
qui concerne les appareils capables de se déplacer dans l'air,
ainsi que leur conception, leur fabrication, leur entretien
et leur utilisation.
Elle intervient notamment dans :

• le #strong[transport aérien], pour déplacer des personnes
  et des marchandises ;

• les #strong[secours], pour intervenir rapidement dans certaines
  situations ;

• la #strong[surveillance], pour observer de vastes territoires ;

• la #strong[recherche scientifique], pour étudier l'atmosphère
  et différents phénomènes ;

• la #strong[formation], pour apprendre à piloter et à maîtriser
  les systèmes aéronautiques.

🛫 #strong[Comment construit-on un avion ?]

Un avion est un ensemble complexe de structures et de systèmes
qui doivent fonctionner ensemble avec précision.
On trouve notamment :

• le #strong[fuselage], qui constitue la partie principale
  de l'appareil ;

• les #strong[ailes], qui permettent notamment de produire
  la portance nécessaire au vol ;

• les #strong[moteurs], qui fournissent la poussée ;

• l'#strong[empennage], qui contribue à la stabilité et au
  contrôle de l'appareil ;

• le #strong[train d'atterrissage], utilisé lors des phases
  au sol ;

• les #strong[systèmes de commande et de navigation], qui
  permettent de contrôler l'appareil.

Chaque élément doit être dimensionné et vérifié avec précision.

🏗️ #strong[Des ingénieurs face à des choix]

Lorsqu'un ingénieur aéronautique conçoit une nouvelle partie
d'un avion, certaines dimensions sont déjà connues tandis que
d'autres doivent être déterminées.
Imaginons une partie rectangulaire d'une structure d'aile.
Sa largeur est de $4$ m et sa longueur est représentée par $x$ m.
Son périmètre est $x + 4 + x + 4$.
Cette expression peut être simplifiée $2x + 8$. Sa surface est $x × 4$, soit $4x$.
La lettre $x$ permet donc de représenter une dimension qui peut varier.

🔧 #strong[Plusieurs éléments, une même structure]

Une structure aéronautique peut être constituée de plusieurs
parties.Supposons qu'une première partie ait une longueur $x + 3$, et qu'une seconde partie ait une longueur $2x + 5$. La longueur totale est $(x + 3) + (2x + 5)$.
En regroupant les termes de même nature $3x + 8$.On obtient ainsi une écriture plus simple de la même longueur.
]

#activite[


🧩 #strong[Changer une écriture sans changer la quantité]

Dans les calculs de conception, une même quantité peut apparaître
sous différentes formes.
Par exemple, une surface peut être représentée par
$3(x + 5)$.
En utilisant la distributivité
$3(x + 5)=3x+15$.
Les deux expressions représentent pourtant la même quantité.
L'ingénieur peut donc choisir la forme la plus pratique selon
le calcul qu'il souhaite effectuer.

🎯 #strong[Mais comment déterminer une dimension inconnue ?]

Imaginons maintenant qu'un ingénieur connaisse la longueur totale
d'une structure.
Une partie mesure $x$ m et une autre mesure $5$ m.
La longueur totale est de $17$ m.
On peut alors traduire cette situation par
$x + 5 = 17$.
Il ne s'agit plus seulement de transformer une expression.
Il faut maintenant #strong[déterminer la valeur de la dimension
inconnue].
Les mathématiques fournissent une méthode pour résoudre ce type
de problème : c'est une #strong[équation].

⚠️ #strong[Et lorsque certaines valeurs sont interdites ?]

Dans la conception d'un avion, toutes les dimensions ne sont
pas nécessairement possibles.
Une pièce peut, par exemple, devoir respecter une contrainte
$x > 2$.
Cela signifie que sa dimension doit être supérieure à $2$ m.
On rencontre alors une #strong[inéquation].
L'ingénieur ne cherche plus une seule valeur : il cherche
l'ensemble des valeurs qui respectent la condition imposée.

🔤 #strong[Des expressions aux équations et aux inéquations]

Ainsi, dans l'étude d'une structure aéronautique, les mathématiques
peuvent intervenir progressivement :

• on #strong[écrit] une expression pour représenter une quantité ;

• on #strong[réduit] ou #strong[développe] cette expression ;

• on peut #strong[transformer] une expression en une autre
  expression équivalente ;

• on utilise une #strong[équation] pour déterminer une valeur
  inconnue ;

• on utilise une #strong[inéquation] pour déterminer les valeurs
  qui respectent une contrainte.

Les mathématiques deviennent alors un véritable outil de
#strong[conception, de vérification et de décision].

Dans ce parcours, nous allons découvrir comment les calculs
sur les expressions algébriques, les équations et les inéquations
permettent de résoudre progressivement des problèmes rencontrés
dans l'#strong[aéronautique].

]


// ==========================================================
// OBJECTIFS
// ==========================================================

#v(5cm)

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

À la fin de cette notion, tu seras capable de :

• #strong[réduire] une expression algébrique ;

• regrouper des #strong[termes de même nature] ;

• utiliser la #strong[distributivité] pour développer une
  expression ;

• reconnaître et utiliser les principales
  #strong[identités remarquables] ;

• #strong[factoriser] une expression algébrique ;

• reconnaître que deux expressions différentes peuvent
  représenter une #strong[même quantité] ;

• résoudre des #strong[équations] du premier degré ;

• traduire une situation par une équation et interpréter
  sa solution ;

• résoudre des #strong[inéquations] du premier degré ;

• représenter et interpréter les solutions d'une inéquation ;

• utiliser ces outils pour résoudre des problèmes simples
  liés à l'#strong[aéronautique].

]


#align(center)[

#image_full("calculs-expressions-algebriques-4e.png")

]


// ==========================================================
// I — EXPRESSION ALGÉBRIQUE
// ==========================================================

#deux-colonnes[

#sous_titre[
LES EXPRESSIONS ALGÉBRIQUES
]


// ==========================================================
// 1. UNE EXPRESSION POUR REPRÉSENTER UNE DIMENSION
// ==========================================================

#sous_sous_titre[
Une expression pour représenter une dimension
]

Dans la conception d'un avion, une dimension peut dépendre
d'une autre dimension.

#exemple[

Une partie rectangulaire d'une aile possède une longueur
de $a+3$ mètres et une largeur de $a+2$ mètres. Son aire est $A=(a+3)(a+2)$.

L'expression $A=(a+3)(a+2)$ permet de représenter
l'aire de cette partie de l'aile.

]

// ==========================================================
// 2. PRODUIT DE FACTEURS
// ==========================================================

#sous_sous_titre[
Reconnaître un produit
]

Une expression de la forme $A×B$ est un produit.
Les expressions $A$ et $B$ sont ses #strong[facteurs].

#exemple[

Pour la plaque de l'aile, $(a+3)(a+2)$ est un produit.
Ses deux facteurs sont $(a+3)$ et $(a+2)$.
]

#retenir[

Dans une expression comme $(a+3)(a+2)$,
les expressions $(a+3)$ et $(a+2)$ sont les
#strong[facteurs du produit].

]


// ==========================================================
// 3. SOMME ALGÉBRIQUE
// ==========================================================
#sous_sous_titre[
Reconnaître une somme algébrique
]

Une expression constituée de plusieurs termes reliés
par des additions ou des soustractions est une
#strong[somme algébrique].

#exemple[

Après développement de $(a+3)(a+2)$,
on obtient $a^2+5a+6$.
Cette expression est une somme algébrique.
Elle possède trois termes : $a^2$, $+5a$ et $+6$.
]

#exemple[

Dans l'expression $3x^2-7x+4$,les trois termes sont : $3x^2$, $-7x$ et $+4$.
]


// ==========================================================
// 4. PARTIE NUMÉRIQUE ET PARTIE LITTÉRALE
// ==========================================================

#sous_sous_titre[
Identifier les parties d'un terme
]

#exemple[

Dans le terme $5a$, la partie numérique est
$5$, et la partie littérale est $a$.

Dans $-3x^2$,la partie numérique est $-3$,
et la partie littérale est $x^2$.

]

#retenir[

Dans un terme comme $5a$ :

• $5$ est la #strong[partie numérique] ;

• $a$ est la #strong[partie littérale].

]


// ==========================================================
// II — DÉVELOPPEMENT
// ==========================================================
#sous_titre[
DÉVELOPPER UNE EXPRESSION
]


// ==========================================================
// 5. DISTRIBUTIVITÉ SIMPLE
// ==========================================================

#sous_sous_titre[
Développer avec la distributivité
]

Lorsqu'un ingénieur calcule la surface ou la longueur
d'une structure composée de plusieurs parties, il peut
rencontrer une expression comme
$3(a+4)$.
Pour supprimer les parenthèses, on utilise la distributivité.

#retenir[
Pour tous nombres $a$, $b$ et $k$ :

$k(a+b)=k a+k b$.

De même $k(a-b)=k a-k b$.

]

#v(2cm)

#exemple_resolu[

Une plaque d'un avion possède une largeur de $3$ mètres et une longueur de $a+4$ mètres.

Son aire est $A=3(a+4)$.

Développons A :

$A=3×a+3×4$.

Donc : $A=3a+12$.

Ainsi : $3(a+4)=3a+12$.

]


#exemple[

Développons $5(x-2)$.

On distribue $5$ :

$5(x-2)=5x-10$.

]


#exemple[

Développons $-2(a+5)$.

On obtient $-2(a+5)=-2a-10$.

]


// ==========================================================
// 6. DOUBLE DISTRIBUTIVITÉ
// ==========================================================


#sous_sous_titre[
Développer un produit de deux sommes
]

Lorsqu'une surface rectangulaire possède deux dimensions
qui dépendent d'une même grandeur, on rencontre un produit
de deux expressions.

#exemple_resolu[

Une partie d'une aile possède $L=a+3$ et $l=a+2$.

Son aire est $A=(a+3)(a+2)$.

Chaque terme du premier facteur doit être multiplié par chaque terme du second facteur :

$(a+3)(a+2) = a×a+a×2+3×a+3×2$

$(a+3)(a+2) = a^2+2a+3a+6$.

Réduisons :

$2a+3a=5a$.

Donc : $(a+3)(a+2)=a^2+5a+6$.

]
#retenir[

Pour développer un produit de deux sommes,
chaque terme du premier facteur est multiplié
par chaque terme du second facteur.

]


// ==========================================================
// 7. AUTRES EXEMPLES DE DOUBLE DISTRIBUTIVITÉ
// ==========================================================

#exemple[

Développons $(x+4)(x+2)$. On obtient :

$(x+4)(x+2) = x×x+x×2+4×x+4×2$

$(x+4)(x+2) = x^2+2x+4x+8$

$(x+4)(x+2) = x^2+6x+8$.

]


#exemple[

Développons $(x-3)(x+5)$.

On obtient $x^2+5x-3x-15$.

Donc $(x-3)(x+5)=x^2+2x-15$.

]


// ==========================================================
// III — RÉDUIRE UNE EXPRESSION
// ==========================================================

#sous_titre[
Réduire une expression algébrique
]


// ==========================================================
// 8. REGROUPER LES TERMES DE MÊME NATURE
// ==========================================================

#sous_sous_titre[
Réduire une somme algébrique
]

Pour simplifier une expression, on peut regrouper
les termes de même nature.

#exemple_resolu[

Une structure d'aile est représentée par :

$3a+5+2a+7$.

On regroupe les termes en $a$ : $3a+2a=5a$.

Puis les nombres : $5+7=12$.

Donc : $3a+5+2a+7=5a+12$.

]


#exemple[

Réduisons $7x-3+2x+8$.

On regroupe :
$7x+2x=9x$
et
$-3+8=5$.

Donc : $7x-3+2x+8=9x+5$.

]


// ==========================================================
// 9. DÉVELOPPER PUIS RÉDUIRE
// ==========================================================

#sous_sous_titre[
Développer puis réduire
]

#exemple_resolu[

Une structure d'un avion est représentée par :

$2(a+3)+3(a+4)$.
Développons-le

$2(a+3)=2a+6$
et
$3(a+4)=3a+12$.

Donc on obtient: $2a+6+3a+12$.

Réduisons :
$2a+3a=5a$
et
$6+12=18$.

Ainsi : $2(a+3)+3(a+4)=5a+18$.

]


#exemple[

Développons et réduisons : $4(x+2)-2(x-3)$.

On obtient : $4x+8-2x+6$.

Donc : $4x-2x+8+6 = 2x+14$.

]


// ==========================================================
// IV — IDENTITÉS REMARQUABLES
// ==========================================================

#sous_titre[
Les identités remarquables
]


// ==========================================================
// 10. CARRÉ D'UNE SOMME
// ==========================================================

#sous_sous_titre[
Le carré d'une somme
]

Certaines expressions apparaissent très fréquemment
dans les calculs de surfaces et de dimensions.

#retenir[
Pour tous nombres $a$ et $b$ :

$(a+b)^2=a^2+2a b+b^2$.

]


#exemple_resolu[

Une plaque carrée utilisée dans la structure d'un avion
possède un côté de longueur : $a+3$.

Son aire est : $(a+3)^2$.

En utilisant l'identité remarquable :

$(a+3)^2=a^2+2×a×3+3^2$.

Donc : $(a+3)^2=a^2+6a+9$.

]


#exemple[

Développons $(x+5)^2$.

$(x+5)^2 = x^2+2×x×5+5^2$.

Donc : $(x+5)^2=x^2+10x+25$.

]


// ==========================================================
// 11. CARRÉ D'UNE DIFFÉRENCE
// ==========================================================

#sous_sous_titre[
Le carré d'une différence
]

#retenir[

Pour tous nombres $a$ et $b$ :

$(a-b)^2=a^2-2a b+b^2$.

]


#exemple_resolu[

Une dimension d'une structure est représentée par : $a-2$. Le carré de cette dimension est : $(a-2)^2$.

Donc : $(a-2)^2=a^2-2×a×2+2^2$.

Ainsi : $(a-2)^2=a^2-4a+4$.

]


#exemple[

Développons $(x-5)^2$.

Après développement, on obtient :
$x^2-10x+25$.

]


// ==========================================================
// 12. PRODUIT D'UNE SOMME PAR UNE DIFFÉRENCE
// ==========================================================

#sous_sous_titre[
La différence de deux carrés
]

#retenir[

Pour tous nombres $a$ et $b$ :

$(a-b)(a+b)=a^2-b^2$.

]


#exemple_resolu[
Lors de l'étude de deux dimensions d'une structure
aéronautique, on rencontre :
$(x-4)(x+4)$.

On reconnaît la troisième identité remarquable.

Donc : $(x-4)(x+4)=x^2-4^2$.

Ainsi : $(x-4)(x+4)=x^2-16$.

]


#exemple[

Développons $(a-7)(a+7)$.

On obtient directement $a^2-49$.

]


// ==========================================================
// 13. RECONNAÎTRE UNE IDENTITÉ REMARQUABLE
// ==========================================================

#sous_sous_titre[
Reconnaître une forme remarquable
]

#exemple[

On considère $x^2+6x+9$.

On remarque que $6x=2×x×3$ et $9=3^2$.

Donc $x^2+6x+9=(x+3)^2$.

]

#exemple[
On considère $x^2-10x+25$.

On remarque que $10x=2×x×5$ et $25=5^2$.

Donc $x^2-10x+25=(x-5)^2$.

]

#exemple[

On considère $x^2-36$.

Comme $36=6^2$, 

on obtient $x^2-36=(x-6)(x+6)$.

]


// ==========================================================
// V — FACTORISATION
// ==========================================================

#v(0.5cm)

#sous_titre[
Factoriser une expression algébrique
]


// ==========================================================
// 14. FACTORISER PAR UN FACTEUR COMMUN
// ==========================================================

#sous_sous_titre[
Mettre un facteur commun en évidence
]

#v(0.15cm)

Factoriser une expression consiste à l'écrire sous forme
d'un produit.

#exemple_resolu[

Un calcul portant sur une structure aéronautique donne : $3a+12$.

Les deux termes sont divisibles par $3$.

On met donc $3$ en facteur :

$3a+12=3(a+4)$.

La forme factorisée est $3(a+4)$.

]


#exemple[

Factorisons $5x+15$.

Le facteur commun est $5$.

Donc $5x+15=5(x+3)$.

]


#exemple[

Factorisons $4a^2+8a$.

Le facteur commun est $4a$.

Donc $4a^2+8a=4a(a+2)$.

]


// ==========================================================
// 15. FACTORISER À L'AIDE DES IDENTITÉS REMARQUABLES
// ==========================================================

#sous_sous_titre[
Reconnaître une forme factorisable
]

#exemple_resolu[

Factorisons $a^2+4a+4$.

On reconnaît $a^2+2×a×2+2^2$.

Donc $a^2+4a+4=(a+2)^2$.

]


#exemple_resolu[

Factorisons $x^2-9$.

On écrit $x^2-3^2$.

D'après l'identité :

$a^2-b^2=(a-b)(a+b)$.

Donc $x^2-9=(x-3)(x+3)$.

]


#exemple_resolu[

Factorisons $a^2-4a+4$.

On reconnaît $a^2-2×a×2+2^2$.

Donc $a^2-4a+4=(a-2)^2$.

]

#v(2cm)

#exemple_resolu[

Factorisons $3a^2-3$.

On commence par mettre $3$ en facteur :

$3a^2-3=3(a^2-1)$.

Or $a^2-1=(a-1)(a+1)$.

Donc $3a^2-3=3(a-1)(a+1)$.

]
#exemple_resolu[

Factorisons $4x^2-25$.

On remarque que :

$4x^2=(2x)^2$
et
$25=5^2$.

Donc $4x^2-25=(2x-5)(2x+5)$.

]


// ==========================================================
// VI — CALCULER RAPIDEMENT
// ==========================================================

#sous_titre[
Utiliser les identités remarquables pour calculer
]


// ==========================================================
// 16. CALCULER UN CARRÉ RAPIDEMENT
// ==========================================================

#sous_sous_titre[
Calculer efficacement un carré
]

Les identités remarquables permettent également de
simplifier certains calculs numériques.

#exemple_resolu[

Calculons $21^2$.

On écrit $21=20+1$.

Donc $21^2=(20+1)^2$.

Ainsi :

$21^2 = 20^2+2×20×1+1^2$

$21^2 = 400+40+1$

$21^2 = 441$.

]


#exemple_resolu[

Calculons $19^2$.

On écrit $19 = 20-1$.

Donc $19^2 = (20-1)^2$.

Ainsi $19^2 = 400-40+1$
$=361$.

]


// ==========================================================
// 17. CALCULER UNE DIFFÉRENCE DE CARRÉS
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Utiliser la différence de deux carrés
]

#exemple_resolu[

Calculons $31^2-30^2$.

On utilise $a^2-b^2=(a-b)(a+b)$.

Donc $31^2-30^2=(31-30)(31+30)$.

Ainsi $31^2-30^2=1×61$.

Donc $31^2-30^2=61$.

]


// ==========================================================
// VII — APPLICATIONS À L'AÉRONAUTIQUE
// ==========================================================

#sous_titre[
Réinvestissement - Calculer les dimensions d'un aéronef
]


// ==========================================================
// 18. SURFACE D'UNE AILE
// ==========================================================

#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
✈️ Mission — Étudier une partie d'une aile
]

Une partie rectangulaire d'une aile possède une longueur
de $a+3$ mètreset une largeur de $a+2$ mètres.

1. Exprime son aire en fonction de $a$.

2. Développe et réduis l'expression obtenue.

3. Calcule cette aire pour $a=4$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

L'aire du rectangle est $A=(a+3)(a+2)$.

Développons A:

$A = a^2+2a+3a+6$.

Donc $A = a^2+5a+6$.

Pour $a=4$ :

$A = 4^2+5×4+6$

$A = 16+20+6$

$A = 42$.

L'aire est donc #strong[$42m^2$.]

]


// ==========================================================
// 19. STRUCTURE DE FUSELAGE
// ==========================================================

#v(4cm)

#exercice[

#mission[
🔧 Application — Étudier une structure du fuselage
]

#v(0.2cm)

Une structure rectangulaire située à l'intérieur
du fuselage possède une longueur $2x+5$ et une largeur $x+3$.

1. Écris l'expression de son aire.

2. Développe cette expression.

3. Réduis-la.

4. Calcule cette aire pour $x=2$.

]


// ==========================================================
// 20. PANNEAU CARRÉ
// ==========================================================

#v(0.35cm)

#exercice[

#mission[
🛩️ Application — Dimensionner un panneau
]

#v(0.2cm)

Un panneau carré utilisé dans un aéronef possède un côté
de longueur
$a+4$ cm.

1. Écris son aire sous forme d'un produit.

2. Développe cette expression à l'aide d'une identité
   remarquable.

3. Calcule l'aire pour $a=6$.

4. Compare les deux formes obtenues.

]


// ==========================================================
// 21. PIÈCE DE STRUCTURE
// ==========================================================

#v(0.35cm)

#exercice[

#mission[
⚙️ Application — Simplifier une expression de dimension
]

#v(0.2cm)

La longueur totale d'une structure est donnée par :

$3(x+4)+2(x+6)$.

1. Développe.

2. Réduis.

3. Calcule la longueur pour $x=5$.

]


// ==========================================================
// 22. SURFACE D'UNE STRUCTURE
// ==========================================================

#v(0.35cm)

#exercice[

#mission[
📐 Application — Calculer une surface
]

#v(0.2cm)

Une plaque rectangulaire possède les dimensions $x+5$ et $x-2$.

1. Écris l'expression de son aire.

2. Développe et réduis.

3. Calcule l'aire pour $x=4$.

]


// ==========================================================
// 23. FACTORISATION D'UNE EXPRESSION
// ==========================================================

#v(0.35cm)

#exercice[

#mission[
🔩 Application — Retrouver les dimensions d'une pièce
]

#v(0.2cm)

Un ingénieur obtient les expressions suivantes lors
de l'étude d'une pièce :

$A = a^2+6a+9$

$B = x^2-16$

$C = a^2-10a+25$

$D = 4x^2-49$

$E = 3a^2-12$.

Factorise chacune de ces expressions.

]


// ==========================================================
// 24. CALCULS RAPIDES EN AÉRONAUTIQUE
// ==========================================================

#v(0.35cm)

#exercice[

#mission[
🧮 Application — Calculer rapidement
]

#v(0.2cm)

Dans certains calculs de dimensionnement, il est utile
d'effectuer rapidement des calculs numériques.

Calcule de manière astucieuse :

1. $21^2$

2. $19^2$

3. $51^2$

4. $49^2$

5. $31^2-30^2$

6. $102^2-98^2$.

Utilise lorsque cela est possible les identités remarquables.

]


// ==========================================================
// VIII — PROBLÈME DE SYNTHÈSE
// ==========================================================


#sous_titre[
Mission - Concevoir une partie d'un avion
]


#exercice[

#mission[
✈️ Mission — Vérification mathématique d'une structure aéronautique
]

#v(0.25cm)

Un ingénieur étudie une partie de la structure d'un avion.
Une plaque rectangulaire utilisée dans une aile possède une longueur $a+4$ mètres et une largeur $a+2$ mètres.

Une seconde plaque carrée possède un côté de longueur $a+3$ mètres.

 #strong[Partie A — Première plaque]

1. Exprime l'aire $A_1$ de la première plaque.

2. Développe et réduis l'expression de $A_1$.

3. Calcule $A_1$ pour $a=5$.

#v(0.2cm)

 #strong[Partie B — Deuxième plaque]

4. Exprime l'aire $A_2$ de la deuxième plaque.

5. Développe l'expression obtenue à l'aide d'une identité
   remarquable.

6. Calcule $A_2$ pour $a=5$.

#v(0.2cm)

 #strong[Partie C — Comparaison]

7. Écris l'expression $A_2-A_1$.

8. Développe et réduis cette expression.

9. Calcule sa valeur pour $a=5$.

10. Explique ce que représente cette différence dans
   le contexte de l'étude.

]


// ==========================================================
// IX — EXERCICES D'ENTRAÎNEMENT
// ==========================================================

#v(0.5cm)

#sous_titre[
Entraînement - Calculer, développer et factoriser
]
#exercice[

Développe et réduis :

1. $2(x+5)$

2. $-3(a-4)$

3. $4(2x+3)$

4. $(x+3)(x+5)$

5. $(a-4)(a+2)$

6. $(2x+3)(x+4)$.

]
#exercice[

Développe et réduis :

1. $(x+3)^2$

2. $(x-4)^2$

3. $(a+5)^2$

4. $(a-6)^2$

5. $(x-7)(x+7)$

6. $(2a-3)(2a+3)$.

]


#exercice[

Réduis les expressions suivantes :

1. $3x+5+2x+7$

2. $8a-3+4a+9$

3. $7x-5-2x+8$

4. $4a+3+6a-11$.

]


#exercice[

Factorise :

1. $5x+20$

2. $3a^2+6a$

3. $x^2+8x+16$

4. $a^2-12a+36$

5. $x^2-25$

6. $4a^2-9$

7. $3x^2-27$.

]


// ==========================================================
// X — RÉINVESTISSEMENT FINAL
// ==========================================================

#sous_titre[
Réinvestissement - Analyser une structure d'aéonef
]


#exercice[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
✈️ Mission finale — Optimiser une structure
]

#v(0.2cm)

Un bureau d'études aéronautiques doit vérifier les dimensions
d'une nouvelle pièce destinée à un avion.
La longueur de la pièce est $x+4$ cm et sa largeur est $x+2$ cm.

Une deuxième pièce possède une forme carrée de côté $x+3$ cm.

#v(0.2cm)

1. Détermine l'aire de la première pièce.

2. Développe et réduis cette expression.

3. Détermine l'aire de la deuxième pièce.

4. Développe cette expression à l'aide d'une identité remarquable.

5. Pour $x=7$, calcule les deux aires.

6. Compare les deux résultats.

7. Écris l'expression de la différence des deux aires.

8. Développe et réduis cette différence.

9. Factorise, lorsque cela est possible, l'expression
   obtenue.

10. Explique pourquoi une écriture développée peut être
    utile pour certains calculs et une écriture factorisée
    pour d'autres.

]


// ==========================================================
// À RETENIR
// ==========================================================
#v(5cm)
#retenir[

🎯 #strong[À retenir — Calculs sur les expressions algébriques]

#v(0.12cm)

Une #strong[expression algébrique] contient des nombres,
des lettres et des opérations.

#v(0.08cm)

Dans un produit, les expressions multipliées sont appelées
#strong[facteurs].

#v(0.08cm)

Dans une somme algébrique, les expressions séparées par
des additions ou des soustractions sont appelées
#strong[termes].

#v(0.08cm)

Pour développer une expression, on utilise notamment
la distributivité :

$k(a+b)=k a+k b$.

#v(0.08cm)

Pour développer un produit de deux sommes, on multiplie
chaque terme du premier facteur par chaque terme du second.

#v(0.08cm)

Pour réduire une expression, on regroupe les
#strong[termes de même nature].

#v(0.08cm)

Les trois #strong[identités remarquables] sont :

$(a+b)^2=a^2+2a b+b^2$ ;

$(a-b)^2=a^2-2a b+b^2$ ;

$(a-b)(a+b)=a^2-b^2$.

#v(0.08cm)

#strong[Développer] permet de transformer certaines expressions
écrites sous forme de produit en expressions écrites sous
forme de somme.

#v(0.08cm)

#strong[Factoriser] permet de transformer certaines expressions
écrites sous forme de somme en expressions écrites sous
forme de produit.

#v(0.08cm)

Ces techniques permettent de calculer, simplifier,
comparer et interpréter des expressions algébriques.

Dans le domaine aéronautique, elles peuvent être utilisées
pour étudier les #strong[dimensions], les #strong[surfaces],
les #strong[structures] et différents paramètres intervenant
dans la conception d'un aéronef.

]




// ==========================================================
// CE QUE LES MATHÉMATIQUES M'ONT PERMIS DE COMPRENDRE
// ==========================================================

#v(5cm)

#remarque[

✈️ Lorsqu'un ingénieur aéronautique conçoit une pièce,
il doit souvent travailler avec des dimensions qui dépendent
les unes des autres.
Les expressions algébriques permettent de représenter
ces relations.
Une même quantité peut être écrite sous plusieurs formes.

Par exemple 
$(a+3)(a+2)$
et
$a^2+5a+6$
représentent la même quantité.

La première forme permet de visualiser directement
les deux dimensions d'une plaque rectangulaire.

La seconde peut faciliter certains calculs ou certaines
comparaisons.

Ainsi, les mathématiques ne servent pas seulement à
obtenir un résultat numérique : elles permettent aussi
de #strong[représenter, transformer, simplifier et analyser
une situation technique].

Dans l'aéronautique, ces outils contribuent à vérifier
les dimensions et les propriétés géométriques des structures
avant leur fabrication.
]




#v(1cm)


#sous_titre[
Équations
]


// ==========================================================
// 1. MESURER UNE GRANDEUR INCONNUE
// ==========================================================

#sous_sous_titre[
Une dimension inconnue dans une structure aéronautique
]

Dans la conception d'un avion, certaines dimensions doivent être
déterminées à partir des contraintes imposées par la structure.

Un ingénieur peut connaître la longueur totale d'une pièce ainsi
que certaines de ses dimensions, mais une autre dimension peut
rester inconnue.

Les mathématiques permettent alors de déterminer cette grandeur.

#v(2cm)

#exemple[

Une pièce située dans la structure d'une aile doit avoir une
longueur inconnue notée $x$ cm.
Deux parties identiques de cette pièce mesurent chacune $x$ cm.
Une autre partie mesure $6$ cm.

La longueur totale de la pièce doit être de $20$ cm.

On peut traduire cette situation par :

$x + x + 6 = 20$.

En regroupant les deux longueurs inconnues :

$2x + 6 = 20$.

Il faut maintenant déterminer la valeur de $x$.

]



#definition[

Une #strong[équation] est une égalité dans laquelle apparaît
un nombre inconnu, généralement désigné par une lettre.

Cette lettre est appelée #strong[inconnue].

Par exemple $2x + 6 = 20$

est une équation d'inconnue $x$.

]


// ==========================================================
// 2. MEMBRES D'UNE ÉQUATION
// ==========================================================

#v(1cm)

#sous_sous_titre[
Les deux membres d'une équation
]

Dans une équation, l'expression située à gauche du signe $=$
est appelée le #strong[premier membre].

L'expression située à droite du signe $=$ est appelée
le #strong[deuxième membre].

#exemple[

Dans l'équation $2x + 6 = 20$,

$2x + 6$ est le premier membre.

$20$ est le deuxième membre.

]

#exemple_resolu[

Reprenons la pièce de l'aile.

On sait que $2x + 6 = 20$.

Soustrayons $6$ aux deux membres :

$2x + 6 - 6 = 20 - 6$. Donc : $2x = 14$.

Divisons les deux membres par $2$ :

$2x ÷ 2 = 14 ÷ 2$. Ainsi : $x = 7$.

La longueur inconnue est donc #strong[$7$ cm.]

]


// ==========================================================
// 3. SOLUTION D'UNE ÉQUATION
// ==========================================================


#sous_sous_titre[
Vérifier une solution
]

#definition[

Un nombre est une #strong[solution d'une équation] lorsqu'en
remplaçant l'inconnue par ce nombre, l'égalité devient vraie.

Résoudre une équation consiste à #strong[déterminer l'ensemble
de ses solutions].

]

#exemple[
Vérifions que $7$ est solution de :
$2x + 6 = 20$.

On remplace $x$ par $7$ :

$2×7+6=14+6=20$.

L'égalité est vraie.

Donc :
$7$ est solution de l'équation.

]


// ==========================================================
// 4. TRANSFORMER UNE ÉQUATION
// ==========================================================

#sous_sous_titre[
Conserver les mêmes solutions
]

Pour résoudre une équation, on transforme progressivement
l'égalité afin d'isoler l'inconnue.

#retenir[
$*$Lorsqu'on #strong[ajoute ou soustrait un même nombre] aux deux
membres d'une équation, on obtient une équation qui possède
les mêmes solutions.

$*$Lorsqu'on #strong[multiplie ou divise les deux membres] d'une
équation par un même nombre non nul, on obtient une équation
qui possède les mêmes solutions.

]


#exemple_resolu[

Un ingénieur étudie une pièce dont la longueur $x$ vérifie :
$3x + 12 = 30$.

Soustrayons $12$ aux deux membres :

$3x + 12 - 12 = 30 - 12$.

Donc $3x = 18$.

Divisons par $3$ : 

$x = 6$.

La dimension recherchée est donc #strong[$6$ unités de longueur.]

]


// ==========================================================
// 5. ÉQUATION DU TYPE ax + b = 0
// ==========================================================

#sous_sous_titre[
Résoudre une équation du 

type $a x+b=0$
]

De nombreuses situations techniques peuvent conduire à une
équation de la forme : #strong[$a x+b=0$].

#exemple_resolu[

Un calcul de conception conduit à l'équation :

$14x+7=0$.

Soustrayons $7$ aux deux membres :

$14x+7-7=0-7$.

Donc : $14x=-7$.

Divisons par $14$ :

$x=-7/14$.

Ainsi : $x=-1/2$.

La solution est donc : #strong[$x=-1/2$.]

Soit S l'ensemble des solutions de cette équation :

$S = {-1/2}$.

]


// ==========================================================
// 6. ÉQUATIONS AVEC DES PARENTHESES
// ==========================================================

#v(5cm)

#sous_sous_titre[
Développer avant de résoudre
]

Lorsqu'une équation contient des parenthèses, on peut utiliser
la distributivité afin de simplifier les calculs.

#exemple_resolu[
Une expression utilisée dans le dimensionnement d'une structure
conduit à : $2(x+4)=18$.

Développons : $2x+8=18$.

Soustrayons $8$ : $2x=10$.

Puis divisons par $2$ : $x=5$.

Donc la dimension recherchée est :

#strong[$5$ unités de longueur.]

]


// ==========================================================
// 7. PRODUIT NUL
// ==========================================================
#sous_sous_titre[
Un produit égal à zéro
]

#retenir[
Si un produit de deux nombres est nul, alors au moins
l'un des deux facteurs est nul.

Ainsi $(A×B)=0$ équivaut à $A=0$ ou $B=0$.

]

#exemple_resolu[

Une étude mathématique d'une structure conduit à :
$(x-3)(x+5)=0$.

Un produit est nul lorsque l'un de ses facteurs est nul.

Donc $x-3=0$ ou $x+5=0$.

Ainsi $x=3$ ou $x=-5$.

L'équation possède donc deux solutions : #strong[$3$ et $-5$.]

Soit S' l'ensemble des solution de l'équation:

S' = {-5 ; 3}
]


// ==========================================================
// 8. MISE EN ÉQUATION
// ==========================================================

#v(4cm)

#sous_sous_titre[
Traduire une situation aéronautique par une équation
]

Avant de résoudre une équation, il faut parfois commencer
par transformer une situation concrète en langage mathématique.

#exemple_resolu[

Un panneau destiné à un avion possède une longueur inconnue $x$.

Deux panneaux identiques et une pièce supplémentaire de $8$ cm
doivent former une longueur totale de $38$ cm.

On traduit la situation par : #strong[$2x+8=38$].

Résolvons l'équation obtenue :

$2x+8=38$ équivaut à $2x=38-8$.

$2x+8=38$ équivaut à $2x=30$.

$2x+8=38$ équivaut à $x=15$.

Chaque panneau mesure donc :

#strong[$15$ cm.]

]


// ==========================================================
// 9. RÉINVESTISSEMENT — ÉQUATIONS
// ==========================================================

#sous_titre[
Réinvestissement - Déterminer une grandeur inconnue
]

#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
✈️ Mission — Dimensionner une pièce d'avion
]
Un ingénieur étudie une pièce rectangulaire utilisée dans
la structure d'un avion.

Sa longueur est $x$ cm et sa largeur est de $5$ cm.

Le périmètre de la pièce est de $34$ cm.

On cherche la longueur $x$.

#text(
  weight: "bold",
)[
1. Mettre la situation en équation
]

Le périmètre d'un rectangle est :
$2×L+2×l$.

On obtient donc :
$2x+2×5=34$.

Ainsi :
$2x+10=34$.

$2x+10=34$ équivaut à $2x+10=34$

$2x+10=34$ équivaut à $2x=34-10$

$2x+10=34$ équivaut à $2x=24$

$2x+10=34$ équivaut à $x=12$.

La longueur de la pièce est donc :
#strong[$12$ cm.]

]

#text(
  weight: "bold",
)[
2. Vérifier le résultat
]

Si $x=12$ :

$2×12+2×5 = 24+10 = 34$.

Le résultat est donc cohérent avec la contrainte imposée.




// ==========================================================
// PARTIE B — INÉQUATIONS
// ==========================================================
#v(1cm)
#sous_titre[
Les inéquations
]


// ==========================================================
// 10. UNE CONTRAINTE À RESPECTER
// ==========================================================
#sous_sous_titre[
Une masse maximale pour un aéronef
]

Lorsqu'un avion est préparé pour un vol, sa masse totale
doit respecter certaines limites.

La masse de l'avion vide est connue.

La masse du carburant et celle de la charge embarquée
peuvent varier.

L'ingénieur doit donc vérifier que la masse totale
ne dépasse pas la limite autorisée.

#exemple[

Un appareil possède une masse de base de $12000$ kg.

On ajoute une charge de masse $x$ kg.

La masse totale doit rester inférieure à $15000$ kg.

On peut écrire :

$12 000+x<15 000$.

Cette écriture est une #strong[inéquation].

]


// ==========================================================
// 11. NOTION D'INÉQUATION
// ==========================================================

#v(5cm)

#sous_sous_titre[

Comprendre une inéquation

]

#definition[

Une #strong[inéquation] est une inégalité dans laquelle apparaît
un nombre inconnu, généralement désigné par une lettre.

Par exemple :

$12000+x<15000$

est une inéquation d'inconnue $x$.

Dans une inéquation, on peut rencontrer les signes :
$<$ ; $>$ ; $≤$ ; $≥$.

]

#retenir[

Dans : $3x+70<1000$,

$3x+70$ est le #strong[premier membre].

$1000$ est le #strong[deuxième membre].

]


// ==========================================================
// 12. SOLUTION D'UNE INÉQUATION
// ==========================================================

#sous_sous_titre[

Vérifier si une valeur respecte une contrainte

]

#definition[

On appelle #strong[solution d'une inéquation] tout nombre
qui rend l'inégalité vraie lorsqu'on le remplace par
l'inconnue.

Résoudre une inéquation consiste à #strong[déterminer l'ensemble
de ses solutions].

]

#exemple_resolu[

Un appareil doit respecter :
$12000+x<15000$.

Soustrayons $12000$ aux deux membres :
$x<3000$.

La charge supplémentaire doit donc être :

#strong[inférieure à $3000$ kg.]

Une charge de $2500$ kg convient car :

$12000+2500=14500<15000$.

Une charge de $3500$ kg ne convient pas car :

$12000+3500=15500>15000$.

]


// ==========================================================
// 13. TRANSFORMER UNE INÉQUATION
// ==========================================================

#sous_sous_titre[
Ajouter ou soustraire un même nombre
]

#retenir[
Lorsqu'on ajoute ou soustrait un même nombre aux deux membres
d'une inéquation, le #strong[sens de l'inégalité ne change pas].
]

#exemple[
Une contrainte de masse est donnée par :

$x+4000<15000$.

On soustrait $4000$ aux deux membres :

$x+4000-4000<15000-4000$.

Donc :
$x<11000$.

]


// ==========================================================
// 14. MULTIPLIER PAR UN NOMBRE POSITIF
// ==========================================================


#sous_sous_titre[
Multiplier par un nombre positif
]

#retenir[

Lorsqu'on multiplie ou divise les deux membres d'une inéquation
par un même nombre #strong[positif non nul], le sens de
l'inégalité ne change pas.

]

#exemple_resolu[
Une contrainte sur trois éléments identiques conduit à :
$3x<900$.

On divise les deux membres par $3$ :
$x<300$.

Le sens de l'inégalité reste donc le même.

]


// ==========================================================
// 15. MULTIPLIER PAR UN NOMBRE NÉGATIF
// ==========================================================

#v(2cm)

#sous_sous_titre[
Le sens de l'inégalité change
]

#retenir[

Lorsqu'on multiplie ou divise les deux membres d'une inéquation
par un même nombre #strong[négatif non nul], le sens de
l'inégalité doit être #strong[inversé].

]

#exemple_resolu[

Une contrainte mathématique sur un paramètre de vol conduit à :
$-4x+5 < 21$.

Soustrayons $5$ :
$-4x < 16$.

On divise par $-4$.
Comme on divise par un nombre négatif, le sens de l'inégalité
change :
$x > -4$.

Les solutions sont donc les nombres supérieurs à #strong[$-4$].
]
// ==========================================================
// 16. RÉSOUDRE UNE INÉQUATION DU PREMIER DEGRÉ
// ==========================================================


#sous_sous_titre[
Résoudre une inéquation du premier degré
]

#exemple_resolu[

Une étude de charge donne :
$4x+5 < x-3$.

Soustrayons $5$ aux deux membres :
$4x < x-8$.

Soustrayons $x$ aux deux membres :
$4x-x < -8$.

Donc :
$3x < -8$.

Divisons par $3$ :
$x < -8/3$.

Les solutions sont donc les nombres rationnels
strictement inférieurs à :
#strong[$-8/3$].

]

#exemple_resolu[

Considérons maintenant :
$-4x+5 < x-3$.

Soustrayons $5$ :
$-4x < x-8$.

Soustrayons $x$ :
$-5x < -8$.

On divise par $-5$ :
$x > 8/5$.
(Le sens change)


Les solutions sont donc les nombres rationnels
strictement supérieurs à :
#strong[$8/5$].

]


// ==========================================================
// 17. REPRÉSENTER LES SOLUTIONS
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Une contrainte peut être représentée sur une droite graduée
]

Une inéquation permet souvent de décrire une plage de valeurs
possibles pour une grandeur.

#exemple[
Si la température de fonctionnement d'un équipement aéronautique
doit être supérieure ou égale à $-20°C$ et inférieure ou égale
à $60°C$, on écrit : #strong[$-20 ≤ T ≤ 60$].

Les valeurs admissibles sont donc comprises entre $-20°C$
et $60°C$, bornes comprises.

]

#remarque[
Dans l'aéronautique, les inéquations permettent de traduire
de nombreuses #strong[contraintes techniques] :

• une masse maximale ;

• une température minimale ou maximale ;

• une vitesse à ne pas dépasser ;

• une longueur comprise dans une plage donnée ;

• une quantité minimale de carburant ;

• une distance de sécurité ;

• une charge maximale admissible.

]


// ==========================================================
// 18. COMPARER DES VALEURS
// ==========================================================

#sous_sous_titre[
Vérifier plusieurs valeurs
]

#exemple[
Une pièce ne doit pas dépasser une masse de :

$500$ kg.

On traduit cette contrainte par :
$x ≤ 500$.

Parmi les valeurs suivantes :

$420$ ; $500$ ; $530$ ; $480$ ; $610$,

les valeurs qui respectent la contrainte sont :

$420$ ; $500$ ; $480$.

La valeur $500$ est acceptée car la limite est incluse.

]


// ==========================================================
// 19. MISE EN INÉQUATION
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Traduire une contrainte aéronautique
]

#exemple_resolu[
Un drone destiné à transporter du matériel possède une masse
à vide de $8$ kg.

La masse du matériel transporté est $x$ kg.

La masse totale ne doit pas dépasser $20$ kg.

La situation se traduit par :
$8+x≤20$.

En soustrayant $8$ aux deux membres :
$x≤12$.

Le drone peut donc transporter une masse de matériel
inférieure ou égale à :
#strong[$12$ kg.]

]


// ==========================================================
// 20. ÉQUATIONS ET INÉQUATIONS : UNE DIFFÉRENCE ESSENTIELLE
// ==========================================================

#sous_sous_titre[
Une valeur précise ou une plage de valeurs
]
#retenir[
Une équation cherche généralement à déterminer une ou plusieurs
valeurs qui rendent une égalité vraie.

Une inéquation permet de déterminer un #strong[ensemble de valeurs]
qui respectent une contrainte.
]

#exemple[
Si une pièce doit avoir exactement une longueur de $25$ cm :

$x=25$.

On cherche une valeur précise.

]

#exemple[

Si la longueur doit être inférieure à $25$ cm :

$x<25$.

Il existe alors une infinité de valeurs possibles.

]


// ==========================================================
// PARTIE C — RÉINVESTISSEMENT AÉRONAUTIQUE
// ==========================================================

#v(0.6cm)

#sous_titre[
Réinvestissement - Contrôler les contraintes aéronef
]


#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[

✈️ Mission — Préparer un aéronef pour un vol

]

#v(0.2cm)

Un aéronef est préparé avant un vol.

Les ingénieurs doivent vérifier plusieurs caractéristiques
afin de respecter les limites prévues lors de la conception.


// ----------------------------------------------------------
// QUESTION 1
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
1. Déterminer une masse inconnue
]

La masse de base de l'aéronef est de $12000$ kg.

Une charge supplémentaire de masse $x$ kg est ajoutée.

La masse totale obtenue est de $14500$ kg.

Détermine $x$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On écrit : $12000+x=14500$.

Donc : $x=14500-12000$.

Ainsi : $x=2500$.

La masse supplémentaire est donc :
#strong[$2500$ kg.]


// ----------------------------------------------------------
// QUESTION 2
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
2. Vérifier une contrainte de masse
]

La masse totale de l'aéronef ne doit pas dépasser
$15000$ kg.

La masse de base est de $12000$ kg.

Écris une inéquation permettant de déterminer la masse
$x$ de la charge supplémentaire.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On doit avoir : $12000+x≤15000$.

Donc : $x≤3000$.

La charge supplémentaire ne doit donc pas dépasser :
#strong[$3000$ kg.]


// ----------------------------------------------------------
// QUESTION 3
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
3. Vérifier plusieurs charges
]

Parmi les charges suivantes :

$2400$ kg ; $2800$ kg ; $3000$ kg ;
$3200$ kg,

lesquelles respectent la contrainte précédente ?

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

La condition est :
$x≤3000$.

On obtient :

$2400≤3000$ : #text(
  weight: "bold",
  fill: code-green,
)[accepté].

$2800≤3000$ : #text(
  weight: "bold",
  fill: code-green,
)[accepté].

$3000≤3000$ : #text(
  weight: "bold",
  fill: code-green,
)[accepté].

$3200>3000$ : #text(
  weight: "bold",
  fill: code-red,
)[refusé].

Les charges possibles sont donc :

#strong[$2400$ kg], #strong[$2800$ kg] et #strong[$3000$ kg.]


// ----------------------------------------------------------
// QUESTION 4
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
4. Déterminer une température admissible
]

Un équipement électronique de bord fonctionne correctement
lorsque sa température $T$ vérifie :

$-20≤T≤60$.
Parmi les températures suivantes :

$-25°C$ ; $-20°C$ ; $0°C$ ;
$45°C$ ; $60°C$ ; $65°C$,

lesquelles sont admissibles ?

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Les températures admissibles sont celles qui appartiennent
à l'intervalle :
$[-20 ; 60]$.

Ainsi :

$-20°C$ est #text(
  weight: "bold",
  fill: code-green,
)[admissible].

$0°C$ est #text(
  weight: "bold",
  fill: code-green,
)[admissible].

$45°C$ est #text(
  weight: "bold",
  fill: code-green,
)[admissible].

$60°C$ est #text(
  weight: "bold",
  fill: code-green,
)[admissible].

Mais :
$-25°C$ et $65°C$ ne sont #text(
  weight: "bold",
  fill: code-red,
)[pas admissible].




// ----------------------------------------------------------
// QUESTION 5
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
5. Résoudre une équation de conception
]

Une pièce possède une longueur $x$ cm.

Deux pièces identiques et une partie de $6$ cm
forment une longueur totale de $30$ cm.

Détermine $x$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On écrit :
$2x+6=30$.

Donc :
$2x=24$.

Ainsi :
$x=12$.

Chaque pièce mesure :
#strong[$12$ cm.]


// ----------------------------------------------------------
// QUESTION 6
// ----------------------------------------------------------

#v(2cm)

#text(
  weight: "bold",
)[
6. Résoudre une inéquation
]

Une charge composée de trois éléments identiques doit avoir
une masse totale inférieure à $900$ kg.

Chaque élément possède une masse $x$ kg.

Détermine les valeurs possibles de $x$.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On écrit :
$3x<900$.

En divisant par $3$ :
$x<300$.

Chaque élément doit donc avoir une masse strictement
inférieure à :
#strong[$300$ kg.]


// ----------------------------------------------------------
// QUESTION 7
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
7. Une contrainte avec un coefficient négatif
]

Une étude mathématique conduit à l'inéquation :

$-4x+5<21$.

Résous cette inéquation.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

$-4x+5<21$

$-4x<16$

En divisant par $-4$, le sens change :
$x>-4$.

Les solutions sont donc les nombres supérieurs à :

#strong[$-4$.]


// ----------------------------------------------------------
// QUESTION 8
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
8. Une contrainte sur une dimension
]

La longueur $x$ d'une pièce doit satisfaire :

$4x+5<x-3$.

Résous cette inéquation.

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

$4x+5<x-3$

$4x<x-8$

$3x < -8$

Donc : $x < -8/3$.

Les solutions sont les nombres rationnels
strictement inférieurs à :
#strong[$-8/3$.]




// ----------------------------------------------------------
// QUESTION 9
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
9. Résoudre une équation à produit nul
]

Une relation de conception conduit à :

$(x-3)(x+5)=0$.

Détermine les valeurs de $x$.

#v(2cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Un produit est nul si l'un des facteurs est nul.

Donc : $x-3=0$ ou $x+5=0$.

Ainsi : $x=3$ ou $x=-5$.




// ----------------------------------------------------------
// QUESTION 10
// ----------------------------------------------------------

#text(
  weight: "bold",
)[
10. Interpréter une solution
]

Un système aéronautique impose la condition :

$T≤80$.

Que signifie cette inégalité dans le contexte
de fonctionnement du système ?

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Cela signifie que la température $T$ doit être
inférieure ou égale à $80°C$.

Une température de $80°C$ est donc autorisée.

Une température supérieure à $80°C$ ne respecte pas
la contrainte.



// ==========================================================
// EXERCICE D'APPLICATION
// ==========================================================

#exercice[

#mission[
✈️ Application — Contrôler les contraintes d'un aéronef
]

Un bureau d'études aéronautiques travaille sur un nouvel
aéronef.

Les ingénieurs doivent déterminer certaines dimensions
et vérifier plusieurs contraintes.

1. Une pièce possède une longueur $x$ cm. Deux pièces identiques
et une partie de $8$ cm donnent une longueur totale de $38$ cm.
Détermine $x$.

2. Une structure possède une longueur $x$ m et une autre partie
de $12$ m. La longueur totale doit être de $45$ m.
Écris puis résous l'équation correspondante.

3. La masse totale d'un aéronef doit être inférieure à $20000$ kg. Sa masse de base est de $15000$ kg et une charge de masse $x$ kg doit être ajoutée. Écris puis résous l'inéquation.

4. Parmi les masses suivantes :
$3500$ kg ; $4000$ kg ; $5000$ kg ;
$5500$ kg, lesquelles respectent la contrainte de la question 3 ?

5. Un équipement électronique fonctionne lorsque :

$-30≤T≤70$.

Parmi les températures suivantes :
$-40°C$ ; $-30°C$ ; $0°C$ ;
$65°C$ ; $70°C$ ; $75°C, 

$détermine celles qui sont admissibles.

6. Résous dans $ℚ$ : $3x+5=20$.

7. Résous dans $ℚ$ : $6x-7=21$.

8. Résous dans $ℚ$ : $4x+5<x-3$.

9. Résous dans $ℚ$ : $-4x+5<x-3$.

10. Résous : $(x-4)(x+6)=0$.

11. Une pièce doit avoir une longueur comprise entre $2,5$ m et $3,8$ m. Traduis cette contrainte par une
double inégalité.

12. Explique pourquoi le sens d'une inégalité change lorsqu'on multiplie ou divise ses deux membres par
un nombre négatif.

]


// ==========================================================
// À RETENIR
// ==========================================================

#retenir[

🎯 #strong[À retenir — Équations et inéquations]

#v(0.12cm)

• Une #strong[équation] est une égalité dans laquelle apparaît
une inconnue.

• Résoudre une équation consiste à déterminer
#strong[l'ensemble de ses solutions].

• Pour transformer une équation, on peut ajouter, soustraire,
multiplier ou diviser ses deux membres par un même nombre
non nul, sans modifier l'ensemble de ses solutions.

• Pour une équation du type : $a x+b=0$, avec $a≠0$ :

$x=-b/a$.

• Un produit est nul si et seulement si au moins
l'un de ses facteurs est nul :

$A×B=0$ équivaut à $A=0$ ou $B=0$.

• Une #strong[inéquation] est une inégalité dans laquelle
apparaît une inconnue.

• Pour une inéquation, ajouter ou soustraire un même nombre
aux deux membres ne change pas le sens de l'inégalité.

• Multiplier ou diviser par un nombre #strong[positif non nul]
ne change pas le sens de l'inégalité.

• Multiplier ou diviser par un nombre #strong[négatif non nul]
inverse le sens de l'inégalité.

• Les équations permettent de déterminer une #strong[valeur
inconnue], tandis que les inéquations permettent souvent
de déterminer une #strong[plage de valeurs admissibles].

• En aéronautique, ces outils permettent notamment de déterminer
des #strong[dimensions], des #strong[masses], des
#strong[températures], des #strong[charges] et différentes
#strong[limites de fonctionnement].

]



// ==========================================================
// CE QUE LES MATHÉMATIQUES M'ONT PERMIS DE COMPRENDRE
// ==========================================================

#remarque[

✈️ Dans l'aéronautique, une grande partie du travail consiste
à respecter des contraintes.

Une pièce doit avoir la bonne dimension.

Une structure doit supporter une charge suffisante.

La masse totale d'un aéronef doit rester dans certaines limites.

Un équipement doit fonctionner dans une plage de températures
déterminée.

Une vitesse ou une distance peut également être limitée.

Les mathématiques permettent de traduire ces contraintes
sous forme d'#strong[équations et d'inéquations].

Une équation permet de rechercher une #strong[valeur précise].

Une inéquation permet de déterminer un #strong[ensemble de valeurs
admissibles].

Ainsi, les mathématiques permettent aux ingénieurs de
#strong[vérifier qu'une conception respecte les contraintes
imposées avant même la fabrication et les essais physiques].
]


// ==========================================================
// OUVERTURE
// ==========================================================

#v(0.45cm)

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
🔭 Pour aller plus loin
]

$*$La conception d'un aéronef fait intervenir de nombreux
domaines scientifiques.
Les ingénieurs utilisent notamment les mathématiques pour
étudier :

• les dimensions et les formes des ailes ;

• les surfaces et les volumes ;

• les structures du fuselage ;

• les mouvements de l'aéronef ;

• la vitesse et l'accélération ;

• la consommation de carburant ;

• les performances des moteurs ;

• les trajectoires de vol ;

• la résistance des matériaux ;

• la stabilité et l'équilibre de l'aéronef.

Les expressions algébriques constituent donc un outil
important pour #strong[modéliser des situations techniques]
et préparer des calculs plus complexes.

Les notions étudiées dans ce parcours constituent une étape
vers l'utilisation des mathématiques dans les sciences de
l'ingénieur et dans l'aéronautique.




$*$Les ingénieurs aéronautiques utilisent des modèles mathématiques
beaucoup plus complexes pour étudier les aéronefs.
Les équations et les inéquations interviennent notamment dans :

• le #strong[dimensionnement des structures] ;

• l'étude des #strong[performances de vol] ;

• la détermination de la #strong[masse maximale] ;

• l'étude de la #strong[consommation de carburant] ;

• le contrôle de la #strong[température des équipements] ;

• la détermination des #strong[plages de fonctionnement] ;

• l'étude des #strong[forces et des mouvements] ;

• la conception des #strong[systèmes de commande] ;

• la vérification des #strong[contraintes de sécurité].

Les notions étudiées dans ce parcours constituent ainsi
une première étape vers la #strong[modélisation mathématique
des contraintes rencontrées dans l'aéronautique].
]

]




















// ==========================================================
// PARCOURS 3e — OCÉANOGRAPHIE ET TECHNOLOGIES MARINES
// ==========================================================

#pagebreak()

#parcours(
  [PARCOURS 3ᵉ — Monôme-Polynôme, Équations de droites, Équations-Inéquations et Application affine-Application linéaire au service de l'océanographie et des technologies marines],
  "parcours-oceanographie-technologies-marines-3e",
) <parcours-oceanographie-technologies-marines-3e>


// ==========================================================
// ACTIVITÉ DE DÉCOUVERTE
// ==========================================================

#activite[

🌊 #strong[L'océanographie : explorer, comprendre et protéger les océans]

#v(0.12cm)

L'#strong[océanographie] est une discipline scientifique qui
consiste à étudier les océans et les mers.
Les océans occupent une très grande partie de la surface de
notre planète. Ils jouent un rôle essentiel dans le climat,
la biodiversité, les ressources naturelles et les activités
humaines.
Pour mieux les comprendre, les scientifiques étudient notamment :

• la #strong[température] de l'eau ;

• la #strong[profondeur] des océans ;

• les #strong[courants marins] ;

• les #strong[vagues] et les marées ;

• la #strong[pression] sous-marine ;

• la #strong[salinité] de l'eau ;

• les #strong[écosystèmes marins] ;

• les fonds océaniques et leur relief.

L'océanographie permet ainsi de mieux comprendre le
fonctionnement des océans et leur influence sur notre planète.

🔬 #strong[Comment les scientifiques explorent-ils les océans ?]

Les océans sont immenses et certaines régions sont très
difficiles d'accès.
Les scientifiques ne peuvent donc pas toujours effectuer
leurs observations directement.
Ils utilisent différents instruments et différentes technologies
pour recueillir des informations.
Parmi ces outils, on trouve :

• des #strong[navires océanographiques] équipés de nombreux
  instruments de mesure ;

• des #strong[sondes] qui peuvent descendre à différentes
  profondeurs ;

• des #strong[capteurs] capables de mesurer la température,
  la pression ou la salinité ;

• des #strong[robots sous-marins] capables d'explorer des zones
  difficiles d'accès ;

• des #strong[véhicules sous-marins autonomes] capables de
  se déplacer et de réaliser des mesures sans être directement
  pilotés depuis la surface ;

• des #strong[systèmes satellites] permettant d'observer
  certaines caractéristiques de la surface des océans.

]
#suite_activite[

🤖 #strong[Les robots sous-marins]

Imagine un robot capable de quitter un navire scientifique,
de descendre plusieurs centaines de mètres sous la surface
de l'océan et d'effectuer automatiquement une mission.
Un tel robot peut être équipé de caméras, de capteurs et
d'instruments scientifiques.
Il peut par exemple :

• mesurer la température de l'eau à différentes profondeurs ;

• déterminer sa position ;

• suivre une trajectoire programmée ;

• cartographier les fonds marins ;

• recueillir des informations sur l'environnement ;

• transmettre les données recueillies aux scientifiques.

Le robot doit donc être capable de #strong[mesurer],
#strong[calculer], #strong[se déplacer] et #strong[prendre
des décisions] en fonction des informations reçues.

🧭 #strong[Une mission sous-marine doit être préparée avec précision]

Avant de lancer un robot sous-marin, les scientifiques et les
ingénieurs doivent préparer sa mission.
Ils doivent notamment déterminer :

• la zone à explorer ;

• la profondeur à atteindre ;

• la trajectoire à suivre ;

• la durée de la mission ;

• la quantité d'énergie disponible ;

• les limites de fonctionnement des instruments ;

• les conditions dans lesquelles le robot peut fonctionner
  en toute sécurité.

Chaque choix doit être étudié avec précision.
Une erreur dans la trajectoire, dans une mesure ou dans le
calcul de l'autonomie peut compromettre une partie de la mission.

📐 #strong[Les mathématiques entrent dans la mission]

Pour préparer une mission d'exploration sous-marine, les
scientifiques doivent représenter des grandeurs qui peuvent
varier.
Par exemple, la position d'un robot peut dépendre du temps.
Sa profondeur peut également varier au cours de la mission.
La surface d'une zone à explorer peut dépendre de plusieurs
dimensions.
La quantité d'énergie consommée peut dépendre de la durée
de fonctionnement du robot.
Certaines grandeurs doivent également respecter des limites.
Ainsi, derrière une mission d'exploration sous-marine se cachent
de nombreux problèmes que les mathématiques permettent de
représenter et de résoudre.

📊 #strong[Des grandeurs qui peuvent varier]

Supposons qu'un robot explore une zone rectangulaire dont
la longueur dépend d'une grandeur que l'on ne connaît pas
encore.
On peut représenter cette longueur par une lettre :
#strong[
$x$
].

]

#suite_activite[
Si la largeur de la zone est fixée à $5$ unités, certaines
grandeurs liées à cette zone peuvent alors s'écrire à l'aide
de $x$.
Par exemple, une longueur totale pourrait être représentée par
$x + 3$,
tandis qu'une autre grandeur pourrait être représentée par
$2x + 5$.
Ces écritures permettent de représenter une situation dont
certaines dimensions ne sont pas encore connues.

📈 #strong[Décrire une évolution]

Lorsqu'un robot descend dans l'océan, sa position peut évoluer
régulièrement avec le temps.
Dans certaines situations, cette évolution peut être représentée
par une relation entre deux grandeurs.
Par exemple, la profondeur du robot peut dépendre de la durée
écoulée depuis le début de la descente.
Lorsque cette relation est régulière, une représentation graphique
peut permettre de visualiser le mouvement du robot.
Les mathématiques permettent alors de passer
d'une #strong[situation réelle]
à une #strong[représentation graphique],
puis à une #strong[relation mathématique].

⚙️ #strong[Respecter les contraintes d'une mission]

Une mission sous-marine ne peut pas toujours être réalisée
avec n'importe quelles valeurs.
Un robot peut disposer d'une quantité limitée d'énergie.
Il peut également être conçu pour fonctionner seulement
dans certaines profondeurs ou pendant une durée maximale.
On peut alors se poser des questions comme :

• Quelle durée de fonctionnement est possible ?

• Quelle profondeur peut être atteinte ?

• Quelle distance peut être parcourue ?

• Quelles valeurs sont compatibles avec les contraintes
  de la mission ?

Pour répondre à ces questions, les scientifiques utilisent
des #strong[équations] et des #strong[inéquations].

🧩 #strong[Des outils mathématiques pour modéliser le monde réel]

Dans l'étude des océans et la conception des technologies
marines, les mathématiques permettent donc de représenter
des situations de plus en plus complexes.
Une grandeur peut être représentée par une lettre.
Plusieurs grandeurs peuvent être regroupées dans une même
expression.
Une relation entre deux grandeurs peut être représentée
dans un repère.
Une contrainte peut être traduite par une équation ou une
inéquation.
Les mathématiques deviennent ainsi un véritable outil de
#strong[modélisation].

🔎 #strong[Trois questions pour préparer une mission]

Au cours de ce parcours, nous allons nous intéresser à
plusieurs problèmes rencontrés dans les technologies marines.
Comment représenter et transformer des expressions contenant
des lettres ?
Comment décrire mathématiquement une trajectoire rectiligne
d'un robot sous-marin ?
Comment déterminer les valeurs qui permettent à une mission
de respecter ses contraintes ?
Ces questions vont nous conduire progressivement vers
trois grands outils mathématiques :

• les #strong[monômes et les polynômes] ;

• les #strong[équations de droites] ;

• les #strong[équations et les inéquations].

]

#suite_activite[

🌍 #strong[Les mathématiques au service de l'exploration]

L'océanographie et les technologies marines montrent que
les mathématiques ne servent pas uniquement à effectuer
des calculs en classe.
Elles permettent aux scientifiques et aux ingénieurs de
#strong[mesurer], #strong[prévoir], #strong[modéliser],
#strong[comparer] et #strong[décider].
Dans ce parcours, nous allons donc partir de situations
rencontrées dans l'exploration des océans pour découvrir
progressivement comment les outils mathématiques permettent
de préparer et d'analyser une mission sous-marine.

]


// ==========================================================
// OBJECTIFS
// ==========================================================

#v(0.25cm)

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

• reconnaître et utiliser des #strong[monômes] ;

• identifier les éléments d'un #strong[polynôme] ;

• réduire et effectuer des calculs sur des expressions
  polynomiales ;

• développer et factoriser certaines expressions ;

• représenter une situation dans un #strong[repère] ;

• déterminer et utiliser l'#strong[équation d'une droite] ;

• interpréter le #strong[coefficient directeur] et
  l'#strong[ordonnée à l'origine] ;

• résoudre des #strong[équations] ;

• résoudre des #strong[inéquations] ;

• reconnaître et manipuler des #strong[applications affines] ;

• reconnaître et manipuler des #strong[applications linéaires] ;

• représenter et interpréter les solutions ;

• utiliser ces outils mathématiques pour analyser des
  situations liées à l'#strong[océanographie et aux
  technologies marines].

]

#v(0.3cm)

#align(center)[

#image_full("oceanographie-technologies-marines-3e.png")

]

#pagebreak()


#deux-colonnes[

#sous_titre[
Monôme-Polynôme
]


// ==========================================================
// 1. MONÔME
// ==========================================================

#sous_sous_titre[
Définition d'un monôme
]

#definition[

Un #strong[monôme] est une expression littérale qui s'écrit sous
la forme :
#strong[$a x^n$]
où $a$ est un nombre et $n$ est un entier naturel.

Le nombre $a$ est appelé le #strong[coefficient] du monôme.

La lettre $x$ est appelée la #strong[variable].

L'entier naturel $n$ est appelé le #strong[degré] du monôme.
]

#exemple[
Dans l'étude d'un équipement marin, la longueur d'un câble peut
être représentée par une variable $x$.

L'expression $5x$ est un monôme.

Son coefficient est $5$.

Sa variable est $x$.

Son degré est $1$.

]

#exemple[

Considérons le monôme
$7x^2$.

Son coefficient est $7$.

Sa variable est $x$.

Son degré est $2$.
]

#exemple[
Le monôme $-3x^4$ a pour coefficient $-3$ et pour degré $4$.
]

#remarque[
Un nombre seul peut également être considéré comme un monôme.
]
#exemple[

$-5$ est un monôme de degré $0$.

En effet  $-5=-5x^0$.

]



// ==========================================================
// 2. RECONNAÎTRE LE COEFFICIENT ET LE DEGRÉ
// ==========================================================

#sous_sous_titre[
Coefficient et degré d'un monôme
]

#exemple_resolu[

Un capteur sous-marin mesure une grandeur représentée par $x$.
On considère les monômes suivants :
$4x$ ; $-7x^2$ ; $3x^5$ ; $-9$.

On peut identifier leur coefficient et leur degré.

• Pour $4x$ le coefficient est $4$ et le degré est $1$.

• Pour $-7x^2$ le coefficient est $-7$ et le degré est $2$.

• Pour $3x^5$ le coefficient est $3$ et le degré est $5$.

• Pour $-9$ le coefficient est $-9$ et le degré est $0$.

]

#retenir[

Pour identifier un monôme $a x^n$ :

• $a$ est son #strong[coefficient] ;

• $x$ est sa #strong[variable] ;

• $n$ est son #strong[degré].

]


// ==========================================================
// 3. POLYNÔME
// ==========================================================


#sous_sous_titre[
Définition d'un polynôme
]

#definition[

Un #strong[polynôme] est une somme de plusieurs monômes
de même variable.

]

#exemple[

$6x^2+2x-5$

est un polynôme.

Il est constitué des trois monômes :

$6x^2$, $2x$ et $-5$.

]

#exemple[

Dans l'étude de la forme d'une structure sous-marine,
une grandeur peut être représentée par :

$P(x)=3x^2+5x-7$.
Cette expression est un polynôme.

Elle est la somme des monômes :
$3x^2$ ;
$5x$ ;
$-7$.
]

#remarque[

Un polynôme peut comporter un seul monôme.
]

#exemple[

$4x^3$
est à la fois un monôme et un polynôme.

]



// ==========================================================
// 4. DEGRÉ D'UN POLYNÔME
// ==========================================================

#sous_sous_titre[
Degré d'un polynôme
]

#definition[

Le #strong[degré d'un polynôme] est le plus grand degré
des monômes qui le composent.

]

#exemple_resolu[

Considérons le polynôme :

$P(x)=6x^4-3x^2+8x-5$.

Les monômes qui le composent sont :

$6x^4$ de degré $4$ ;

$-3x^2$ de degré $2$ ;

$8x$ de degré $1$ ;

$-5$ de degré $0$.

Le plus grand degré est $4$.

Donc : #strong[$P$ est un polynôme de degré $4$].

]

#exemple[

Considérons $Q(x)=7x^3-2x+9$.

Les degrés des monômes sont respectivement :

$3$, $1$ et $0$.

Le degré de $Q$ est donc 
#strong[$3$].

]


// ==========================================================
// 5. IDENTIFIER LES MONÔMES D'UN POLYNÔME
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Identifier les monômes d'un polynôme
]

#exemple_resolu[

Une étude océanographique conduit à l'expression :

$P(x)=4x^3-7x^2+2x+6$.

Cette expression est constituée des monômes :

$4x^3$ ;
$-7x^2$ ;
$2x$ ;
$6$.

Leurs coefficients sont respectivement :
$4$ ; $-7$ ; $2$ ; $6$.

Leurs degrés sont :
$3$ ; $2$ ; $1$ ; $0$.

Le degré du polynôme est donc $3$.

]

#remarque[

Le signe placé devant un monôme appartient à son coefficient.

Ainsi, dans
$5x^2-3x+8$,
le coefficient du deuxième monôme est $-3$.

]


// ==========================================================
// 6. POLYNÔMES ORDONNÉS
// ==========================================================


#sous_sous_titre[
Écrire un polynôme selon les puissances décroissantes
]

Pour faciliter les calculs, on peut écrire les termes d'un
polynôme en respectant l'ordre décroissant des puissances
de la variable.

#exemple_resolu[

Considérons 
$P(x)=5x+3x^3-7+2x^2$.

Les termes peuvent être réorganisés selon les puissances
décroissantes de $x$ :

$P(x)=3x^3+2x^2+5x-7$.

Les deux écritures représentent le même polynôme.

]

#retenir[
Pour ordonner un polynôme, on place généralement les termes
du plus grand degré au plus petit degré.
]


// ==========================================================
// 7. RÉDUIRE UNE EXPRESSION
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Réduire une expression algébrique
]

#definition[

#strong[Réduire une expression] consiste à regrouper les termes
de même nature afin d'obtenir une écriture plus simple.

Des termes de même nature possèdent la même partie littérale.

]

#exemple_resolu[

Une station sous-marine mesure différentes grandeurs liées
à une même variable $x$.

On considère
$3x+5x-2$.

Les termes $3x$ et $5x$ sont de même nature.

On les regroupe :
$3x+5x=8x$.

Donc :
$3x+5x-2=8x-2$.

]

#exemple[

Réduisons :
$7x^2-3x+4x^2+8x$.

On regroupe les termes en $x^2$ :

$7x^2+4x^2=11x^2$.

Puis les termes en $x$ :
$-3x+8x=5x$.

Donc :
$7x^2-3x+4x^2+8x=11x^2+5x$.

]


// ==========================================================
// 8. ADDITION DE POLYNÔMES
// ==========================================================

#sous_sous_titre[
Additionner des polynômes
]

#retenir[

Pour additionner des polynômes, on regroupe les monômes
de même nature.

]

#exemple_resolu[

Un modèle mathématique décrivant une structure marine est donné
par :

$P(x)=3x^2+5x-2$
et
$Q(x)=2x^2-3x+7$.

Calculons :
$P(x)+Q(x)$.

$P(x)+Q(x) = (3x^2+5x-2)+(2x^2-3x+7)$.

On regroupe les termes de même nature :

$3x^2+2x^2=5x^2$ ;

$5x-3x=2x$ ;

$-2+7=5$.

Donc :
$P(x)+Q(x)=5x^2+2x+5$.

]


// ==========================================================
// 9. SOUSTRACTION DE POLYNÔMES
// ==========================================================

#sous_sous_titre[
Soustraire des polynômes
]

#exemple_resolu[

Considérons :

$P(x)=5x^2+4x-3$
et
$Q(x)=2x^2-x+6$.

Calculons :
$P(x)-Q(x)$.

On obtient :

$P(x)-Q(x) = (5x^2+4x-3)-(2x^2-x+6)$.

On enlève les parenthèses :

$P(x)-Q(x) = 5x^2+4x-3-2x^2+x-6$.

Puis on réduit :

$5x^2-2x^2=3x^2$ ;

$4x+x=5x$ ;

$-3-6=-9$.

Donc :
$P(x)-Q(x)=3x^2+5x-9$.

]


// ==========================================================
// 10. MULTIPLICATION D'UN MONÔME PAR UN POLYNÔME
// ==========================================================

#sous_sous_titre[
Multiplier un monôme par un polynôme
]

#retenir[

Pour multiplier un monôme par un polynôme, on multiplie
ce monôme par chacun des termes du polynôme.

]

#exemple_resolu[

Une relation utilisée pour modéliser une mesure marine est :
$3x(2x^2-4x+5)$.

On distribue $3x$ à chaque terme :

$3x×2x^2=6x^3$ ;

$3x×(-4x)=-12x^2$ ;

$3x×5=15x$.

Donc :

$3x(2x^2-4x+5)=6x^3-12x^2+15x$.

]


// ==========================================================
// 11. DÉVELOPPER UNE EXPRESSION
// ==========================================================

#sous_sous_titre[
Développer une expression
]

#definition[

#strong[Développer] une expression consiste à transformer
un produit en une somme ou une différence.

Cette transformation repose notamment sur la distributivité.

]

#retenir[

Pour tous nombres $a$, $b$ et $c$ :

#strong[$a(b+c)=a b+a c$] ;

#strong[$a(b-c)=a b-a c$].

]

#exemple_resolu[

Un modèle de calcul lié à une structure marine conduit
à l'expression :
$4(x+3)$.

En utilisant la distributivité :

$4(x+3)=4x+12$.

L'expression développée est donc :
$4x+12$.

]

#exemple[

Développons 
$-2(3x-5)$.

$-2(3x-5) = -2×3x+(-2)×(-5)$

$-2(3x-5) = -6x+10$.

Donc :
$-2(3x-5) = -6x+10$.

]


// ==========================================================
// 12. IDENTITÉS REMARQUABLES
// ==========================================================

#sous_sous_titre[
Développer avec les identités remarquables
]

#retenir[

Pour tous nombres $a$ et $b$ :

$(a+b)^2=a^2+2a b+b^2$.

$(a-b)^2=a^2-2a b+b^2$.

$(a+b)(a-b)=a^2-b^2$.

]

#exemple_resolu[

Considérons :
$(x+4)^2$.

Avec :
$(a+b)^2=a^2+2a b+b^2$,

on obtient :

$(x+4)^2=x^2+(2)(x)(4)+4^2$.

Donc :
$(x+4)^2=x^2+8x+16$.

]

#exemple[

Développons :
$(x-3)^2$.

On obtient :
$(x-3)^2=x^2-6x+9$.

]


// ==========================================================
// 13. FACTORISER UNE EXPRESSION
// ==========================================================

#sous_sous_titre[
Factoriser une expression
]

#definition[

#strong[Factoriser] une expression consiste à transformer
une somme ou une différence en un produit.

C'est l'opération inverse du développement.

]

#exemple_resolu[

Considérons :
$6x+12$.

Le facteur commun est $6$.

On obtient :
$6x+12=6(x+2)$.

L'expression a donc été factorisée.

]

#v(0.2cm)

#exemple[
Factorisons :
$5x^2+10x$.

Le facteur commun est $5x$.

Donc :
$5x^2+10x=5x(x+2)$.
]
// ==========================================================
// 14. FACTORISATION AVEC LES IDENTITÉS REMARQUABLES
// ==========================================================

#sous_sous_titre[
Utiliser les identités remarquables pour factoriser
]

#exemple_resolu[

Considérons :
$x^2-16$.

On reconnaît une différence de deux carrés :

$x^2-4^2$.

En utilisant :
$a^2-b^2=(a-b)(a+b)$,
on obtient :
$x^2-16=(x-4)(x+4)$.
]

#exemple[
Considérons :
$x^2+6x+9$.

On reconnaît :
$x^2+(2)(x)(3)+3^2$.

Donc :
$x^2+6x+9=(x+3)^2$.

]


// ==========================================================
// 15. ÉGALITÉ ENTRE DEUX EXPRESSIONS
// ==========================================================

#sous_sous_titre[
Reconnaître deux expressions équivalentes
]

#definition[
Deux expressions algébriques sont #strong[équivalentes]
lorsqu'elles représentent la même quantité pour toute valeur
admissible de la variable.
]

#exemple_resolu[
Considérons :
$A=3(x+4)$
et 
$B=3x+12$.
Développons $A$ :

$A=3x+12$.

On obtient exactement l'expression $B$.
Donc :
$3(x+4)=3x+12$.
Les deux expressions sont équivalentes.
]

#v(0.2cm)

#remarque[

Développer, réduire et factoriser permettent de changer la forme
d'une expression tout en conservant la quantité qu'elle représente.

]


// ==========================================================
// À RETENIR
// ==========================================================

#retenir[

🎯 #strong[À retenir — Monômes et polynômes]

#v(0.1cm)

Un #strong[monôme] est une expression de la forme :
#strong[$a x^n$]
où $a$ est le coefficient et $n$ le degré.

#v(0.08cm)

Un #strong[polynôme] est une somme de plusieurs monômes
de même variable.

#v(0.08cm)

Le #strong[degré d'un polynôme] est le plus grand degré
de ses monômes.

#v(0.08cm)

Pour #strong[réduire] une expression, on regroupe les termes
de même nature.

#v(0.08cm)

Pour #strong[développer], on utilise notamment la distributivité :

$a(b+c)=a b+a c$.

#v(0.08cm)

Pour #strong[factoriser], on transforme une somme ou une différence
en produit.

#v(0.08cm)

Les identités remarquables sont :

$(a+b)^2=a^2+2a b+b^2$

$(a-b)^2=a^2-2a b+b^2$

$(a+b)(a-b)=a^2-b^2$.

#v(0.08cm)

Ces outils permettent de transformer et simplifier les expressions
utilisées pour modéliser des phénomènes en #strong[océanographie]
et dans les #strong[technologies marines].

]

















#sous_titre[
Équations de droites
]

Dans les domaines de l'#strong[océanographie] et des
#strong[technologies marines], les scientifiques et les ingénieurs
doivent représenter et étudier de nombreux phénomènes à l'aide
de modèles mathématiques.
Ils peuvent notamment étudier :

• la trajectoire d'un robot sous-marin ;

• le déplacement d'un drone marin ;

• la position d'un navire à la surface de l'eau ;

• l'évolution de la profondeur d'un engin sous-marin ;

• le déplacement d'un capteur dans une zone océanique ;

• la représentation de profils sous-marins ;

• les trajectoires rectilignes suivies par des équipements marins.

#v(0.15cm)

Dans une représentation mathématique, on peut associer à chaque
position d'un équipement marin un couple de coordonnées
#strong[$(x ; y)$] dans un repère.

Lorsque toutes les positions étudiées sont alignées, elles peuvent
être représentées par une #strong[droite].

L'équation de cette droite permet alors de décrire mathématiquement
la trajectoire ou la relation entre les deux coordonnées.

#v(0.18cm)

#definition[

Une #strong[équation du premier degré dans 

$ℝ × ℝ$] est une équation
qui peut s'écrire sous la forme :
#strong[$a x + b y + c = 0$]
où $a$, $b$ et $c$ sont des nombres réels et où
$(a ; b) ≠ (0 ; 0)$.

Une solution d'une telle équation est un couple de nombres réels
$(x ; y)$ qui vérifie l'égalité.
]

#exemple[
Considérons l'équation : $2x + y - 6 = 0$.

Le couple $(2 ; 2)$ est solution car :

$2 × 2 + 2 - 6 = 0$.

Le point de coordonnées $(2 ; 2)$ appartient donc à la droite
représentée par cette équation.

Dans le contexte de l'océanographie, cette équation peut par
exemple représenter la trajectoire rectiligne suivie par un
véhicule sous-marin autonome dans une zone d'étude.
]
#v(4cm)

#definition[
On appelle #strong[équation cartésienne d'une droite] une équation
du type :

#strong[$a x + b y + c = 0$]
où $a$, $b$ et $c$ sont des nombres réels avec
$(a ; b) ≠ (0 ; 0)$.

L'ensemble des solutions de cette équation correspond exactement
aux coordonnées des points appartenant à la droite.

Ainsi, résoudre une équation du premier degré dans $ℝ × ℝ$ revient
à déterminer les couples $(x ; y)$ qui correspondent aux points
de la droite.
]

#sous_sous_titre[
Forme réduite d'une équation de droite
]

#retenir[
Lorsque la droite n'est pas parallèle à l'axe des ordonnées,
son équation peut être écrite sous la forme :

#strong[$y = a x + b$] où $a$ et $b$ sont des nombres réels.
]
#definition[

Dans l'équation réduite
#strong[$y = a x + b$],

$*$$a$ est appelé le #strong[coefficient directeur] de la droite

$*$$b$ est appelé son #strong[ordonnée à l'origine].

Le coefficient directeur permet de caractériser la variation
de l'ordonnée lorsque l'abscisse augmente.

L'ordonnée à l'origine correspond à l'ordonnée du point
d'intersection de la droite avec l'axe des ordonnées.
]

#v(4cm)

#exemple[

Un robot sous-marin suit une trajectoire rectiligne dont l'équation
est :
$y = 2x + 3$.

Cette équation est sous forme réduite.

On identifie : $a = 2$ et $b = 3$.

Le coefficient directeur de la trajectoire est donc $2$ et
l'ordonnée à l'origine est $3$.

Pour $x = 0$, on obtient :

$y = 2 × 0 + 3 = 3$.

La droite passe donc par le point de coordonnées $(0 ; 3)$.

]

#sous_sous_titre[
Coefficient directeur d'une droite
]
#retenir[
Soient $A(x_A ; y_A)$ et $B(x_B ; y_B)$ deux points distincts
d'une droite, avec $x_A ≠ x_B$.

Le coefficient directeur $a$ de cette droite est donné par :
#strong[$a = (y_B - y_A)/(x_B - x_A)$].

Cette relation permet de déterminer la pente d'une trajectoire
rectiligne à partir des coordonnées de deux positions connues
d'un équipement marin.
]
#exemple[

Un drone sous-marin passe par les positions

$A(2 ; 5)$ et $B(6 ; 13)$.

Son coefficient directeur est :

$a = (13 - 5)/(6 - 2)$

$a = 8/4$

$a = 2$.

La trajectoire du drone possède donc un coefficient directeur égal
à $2$.

]

#v(4cm)

#sous_sous_titre[
Détermination d'une équation de droite
]
#retenir[
Pour déterminer l'équation d'une droite non parallèle à l'axe des
ordonnées, on peut utiliser sa forme réduite :
$y = a x + b$.

Il suffit alors de déterminer le coefficient directeur $a$, puis
l'ordonnée à l'origine $b$.
]

#exemple[

Un véhicule sous-marin suit une trajectoire passant par les points
$A(2 ; 5)$ et $B(6 ; 13)$.

On a déjà obtenu :
$a = 2$.

L'équation de la droite est donc de la forme :
$y = 2x + b$.

Comme $A(2 ; 5)$ appartient à la droite :
$5 = 2 × 2 + b$.

Donc :
$b = 1$.

L'équation de la trajectoire est ainsi :
$y = 2x + 1$.

]

#remarque[

Une même droite peut être décrite par plusieurs équations
équivalentes.
]
#exemple[

$2x + 2y - 6 = 0$ et $x + y - 3 = 0$

ont exactement les mêmes solutions.

Elles représentent donc la même droite.

]






// ==========================================================
// IV — INÉQUATIONS DU PREMIER DEGRÉ DANS ℝ
// ==========================================================

#v(5cm)
#sous_sous_titre[Inéquations du premier degré dans $ℝ$]

#definition[

Une #strong[inéquation] est une inégalité dans laquelle intervient
un ou plusieurs nombres inconnus.

Résoudre une inéquation consiste à #strong[déterminer toutes les
valeurs de l'inconnue] qui rendent l'inégalité vraie.

L'ensemble de ces valeurs constitue #strong[l'ensemble des solutions]
de l'inéquation.

]

#exemple[

🌊 #strong[Exemple — Zone de fonctionnement d'un capteur sous-marin]

Un capteur de pression installé sur un robot sous-marin ne doit pas
être utilisé lorsque la pression dépasse $80$ unités de pression.

On note #strong[$x$] la pression mesurée par le capteur.

La condition de fonctionnement peut alors s'écrire :

#strong[$x ≤ 80$].

Cette inégalité est une #strong[inéquation du premier degré dans $ℝ$].

L'ensemble des solutions est : #strong[$S_ℝ = ]←; 80]$].

Cela signifie que toutes les valeurs de pression inférieures ou
égales à $80$ respectent la condition imposée.

]

#definition[
On appelle #strong[inéquation du premier degré dans $ℝ$] toute
inéquation qui peut se ramener à l'une des formes :

$a x + b < 0$ ;

$a x + b ≤ 0$ ;

$a x + b > 0$ ;

$a x + b ≥ 0$,

où $a$ et $b$ sont des nombres réels avec $a ≠ 0$.

]

#v(0.15cm)

#propriete[

Lorsqu'on ajoute ou soustrait un même nombre aux deux membres
d'une inéquation, le sens de l'inégalité est conservé.

Lorsqu'on multiplie ou divise les deux membres par un nombre réel
#strong[positif], le sens de l'inégalité est également conservé.

Lorsqu'on multiplie ou divise les deux membres par un nombre réel
#strong[négatif], le sens de l'inégalité #strong[est inversé].

]

#exemple[

🌊 #strong[Température d'un équipement marin]

Un équipement électronique embarqué sur une bouée océanographique
fonctionne lorsque sa température $T$ est supérieure ou égale à
$-10$ °C.
La condition s'écrit :
#strong[$T ≥ -10$].

Ainsi : $S_ℝ = [-10; →[$.

]

#exemple[

🌊 #strong[Profondeur d'un robot]

Un robot sous-marin doit rester à une profondeur supérieure à
$120$ m.
Si $x$ désigne la profondeur du robot, on obtient :
$x > 120$.

L'ensemble des solutions est :
$S_ℝ = ]120; →[$.

]


// ==========================================================
// V — INÉQUATIONS DU TYPE ax + b < cx + d
// ==========================================================

#sous_sous_titre[Inéquations du type $a x+b < c x+d$]

#definition[

Une inéquation du type
#strong[$a x+b < c x+d$]
ou de l'une des formes analogues
$a x+b ≤ c x+d$,
$a x+b > c x+d$,
$a x+b ≥ c x+d$
est une #strong[inéquation du premier degré dans $ℝ$].
Pour la résoudre, on regroupe les termes contenant l'inconnue
dans un membre et les nombres dans l'autre membre.

]

#v(3cm)

#exemple[

🌊 #strong[Température de fonctionnement d'un drone marin]

Un drone océanographique possède un système de refroidissement.
Une relation entre deux mesures de température conduit à
l'inéquation :

$3x + 5 < 6x - 10$.

Résolvons-la :

$3x + 5 < 6x - 10$

$5 + 10 < 6x - 3x$

$15 < 3x$

$x > 5$.

Ainsi :
$S_ℝ = ]5; →[$.

]

#exemple[

🌊 #strong[Pression sous-marine]

Une relation entre la profondeur d'un robot et une limite de
pression conduit à :
$2x - 4 ≥ 7x - 4$.

On obtient :

$2x - 7x ≥ -4 + 4$

$-5x ≥ 0$.

En divisant par $-5$, on inverse le sens de l'inégalité :
$x ≤ 0$.

Ainsi :
$S_ℝ = ]←; 0]$.

]

#exemple[
🌊 #strong[Exemple avec un coefficient irrationnel]

Une relation entre deux mesures effectuées par un capteur
océanographique conduit à :
$-x√2 - 5 ≤ x + 8$.
On obtient :

$-x√2 - x ≤ 13$

$-x(√2 + 1) ≤ 13$.
Comme $-(√2+1) < 0$, 

on obtient :
$x ≥ -13/(√2+1)$.

Après rationalisation :
$x ≥ 13(1-√2)$.

Ainsi :
$S_ℝ = [13(1-√2); →[$.
]


// ==========================================================
// VI — REPRÉSENTATION DES SOLUTIONS SUR UNE DROITE GRADUÉE
// ==========================================================

#v(0.35cm)

#sous_sous_titre[Représentation des solutions sur une droite graduée]

#definition[

L'ensemble des solutions d'une inéquation du premier degré dans
$ℝ$ est généralement représenté par un #strong[intervalle].

Cet intervalle peut être représenté sur une #strong[droite graduée].

]

#propriete[

Pour représenter graphiquement une inéquation :

• une borne incluse est représentée par un point fermé ;

• une borne exclue est représentée par un point ouvert ;

• la partie correspondant aux solutions est indiquée sur la droite
  graduée.

]

#exemple[

Pour l'inéquation :
$x ≥ 4$,
l'ensemble des solutions est :
$S_ℝ = [4; →[$.
La valeur $4$ appartient à l'ensemble des solutions et toutes les
valeurs supérieures à $4$ sont également solutions.

]
// ==========================================================
// VII — SYSTÈMES D'INÉQUATIONS DU PREMIER DEGRÉ DANS ℝ
// ==========================================================
#sous_titre[Systèmes d'inéquations du premier degré dans $ℝ$]

#definition[
Un #strong[système d'inéquations du premier degré dans $ℝ$] est
un ensemble de plusieurs inéquations du premier degré portant sur
la même inconnue.

Résoudre le système consiste à déterminer les nombres réels qui
sont #strong[solutions de toutes les inéquations à la fois].

]

#v(0.15cm)

#exemple[

🌊 #strong[Domaine de fonctionnement d'un capteur marin]

Un capteur installé sur une bouée doit fonctionner dans une zone
de température définie par les deux conditions :
$x > 5$ et $x < 18$.

Le système est :
$cases(
x > 5,
x < 18
)$

Les solutions communes aux deux inéquations sont les nombres
strictement compris entre $5$ et $18$.

Ainsi :
$S_ℝ = ]5;18[$.

]

#propriete[

Pour résoudre un système d'inéquations dans $ℝ$ :

1. on détermine l'ensemble des solutions de chaque inéquation ;

2. on représente ces ensembles sur une même droite graduée ;

3. on recherche leur #strong[intersection].

L'ensemble obtenu est l'ensemble des solutions du système.

]

#exemple[

🌊 #strong[Température admissible d'une bouée]

Une bouée océanographique fonctionne lorsque sa température $T$
respecte simultanément :

$T ≥ -5$ et $T ≤ 35$.

On obtient :

$S_1 = [-5; +∞[$ et $S_2 = ]←;35]$.

L'ensemble des solutions du système est :

$S = S_1 ∩ S_2$

$S = [-5;35]$.

La température de fonctionnement de la bouée appartient donc à
l'intervalle $[-5;35]$ °C.

]


// ==========================================================
// VIII — ÉQUATIONS DU PREMIER DEGRÉ DANS ℝ × ℝ
// ==========================================================

#v(3cm)

#sous_titre[Équations du premier degré dans $ℝ × ℝ$]

#definition[

Une #strong[équation du premier degré dans 

$ℝ × ℝ$] est une
équation qui peut s'écrire sous la forme :
#strong[$a x + b y + c = 0$]
où $a$, $b$ et $c$ sont des nombres réels et
$(a;b) ≠ (0;0)$.

Elle comporte deux inconnues, généralement notées $x$ et $y$.

Un #strong[couple $(x;y)$] est solution de cette équation lorsque
ses coordonnées vérifient l'égalité.

]

#exemple[

🌊 #strong[Position d'un robot sous-marin]

La position d'un robot sous-marin est repérée dans un plan par ses
coordonnées $(x;y)$.

Une relation entre les deux coordonnées est donnée par :
$2x + y - 6 = 0$.

Le couple $(2;2)$ est solution car :

$2×2 + 2 - 6 = 0$.

En revanche, le couple $(1;1)$ n'est pas solution car :

$2×1 + 1 - 6 ≠ 0$.

]

#v(0.15cm)

#propriete[

Dans un plan muni d'un repère, les solutions d'une équation du
premier degré dans $ℝ × ℝ$ sont représentées par les points d'une
#strong[droite].

L'équation $a x+b y+c=0$ est appelée #strong[équation cartésienne de la droite].

]


// ==========================================================
// IX — INÉQUATIONS DU PREMIER DEGRÉ DANS ℝ × ℝ
// ==========================================================

#v(5cm)

#sous_titre[Inéquations du premier degré dans $ℝ × ℝ$]

#definition[

Une #strong[inéquation du premier degré dans $ℝ × ℝ$] est une
inéquation qui peut s'écrire sous l'une des formes :

$a x + b y + c < 0$ ;

$a x + b y + c ≤ 0$ ;

$a x + b y + c > 0$ ;

$a x + b y + c ≥ 0$,

où $a$, $b$ et $c$ sont des nombres réels et

$(a;b) ≠ (0;0)$.

Un couple $(x;y)$ est solution lorsque ses coordonnées vérifient
l'inéquation.

]

#v(0.15cm)

#exemple[

🌊 #strong[Exemple — Zone de déplacement d'un robot marin]

Dans un repère, on considère la condition :

$x - 2y - 4 ≤ 0$.

Cette inéquation décrit une partie du plan correspondant à une
zone autorisée pour le déplacement du robot.

La droite frontière est :

$x - 2y - 4 = 0$.

Les points situés d'un côté de cette droite vérifient :

$x - 2y - 4 < 0$,

tandis que les points situés de l'autre côté vérifient :

$x - 2y - 4 > 0$.

]

#v(5cm)

#propriete[

La droite d'équation
#strong[$a x + b y + c = 0$]
partage le plan en deux demi-plans :

• le demi-plan dans lequel $a x+b y+c < 0$ ;

• le demi-plan dans lequel $a x+b y+c > 0$.

La droite elle-même correspond à :

$a x+b y+c = 0$.

]

#v(0.15cm)

#definition[

Un #strong[système d'inéquations du premier degré dans $ℝ × ℝ$]
est constitué de plusieurs inéquations du premier degré portant
sur les mêmes inconnues $x$ et $y$.

Sa résolution consiste à déterminer les couples $(x;y)$ qui
vérifient simultanément toutes les inéquations du système.

]


// ==========================================================
// X — RÉSOLUTION GRAPHIQUE D'UNE INÉQUATION DANS ℝ × ℝ
// ==========================================================

#v(0.35cm)

#sous_sous_titre[Résolution graphique d'une inéquation dans $ℝ × ℝ$]

#definition[

Pour résoudre graphiquement une inéquation du premier degré dans
$ℝ × ℝ$ :

1. on considère la droite frontière obtenue en remplaçant
   l'inégalité par une égalité ;

2. on trace cette droite dans le plan muni d'un repère ;

3. la droite partage le plan en deux demi-plans ;

4. on choisit un point test dans l'un des demi-plans ;

5. on vérifie si ses coordonnées satisfont l'inéquation ;

6. on identifie alors le demi-plan correspondant aux solutions.

]

#v(2cm)

#exemple[

🌊 #strong[Zone autorisée autour d'un dispositif marin]

On considère l'inéquation :
$x - 2y - 4 ≤ 0$.

La droite frontière est :
$x - 2y - 4 = 0$.

On peut écrire :
$y = 1/2 x - 2$.

On trace cette droite dans le repère.

Le plan est alors partagé en deux demi-plans.

En choisissant un point test, on détermine le demi-plan dans lequel
l'inéquation est vérifiée.

Ce demi-plan représente la #strong[zone des positions autorisées]
pour le dispositif marin.

]
// ==========================================================
// XI — SYSTÈMES D'INÉQUATIONS DANS ℝ × ℝ
// ==========================================================
cm)

#sous_sous_titre[Résolution graphique d'un système d'inéquations dans $ℝ × ℝ$]

#definition[

La résolution graphique d'un système d'inéquations du premier degré
dans $ℝ × ℝ$ consiste à représenter graphiquement chaque inéquation
dans le même repère.

L'ensemble des solutions du système est alors
#strong[l'intersection des régions correspondant aux différentes
inéquations].

]

#exemple[

🌊 #strong[Zone de navigation d'un robot sous-marin]

Un robot sous-marin doit respecter simultanément deux conditions
liées à sa position $(x;y)$ :

$
  cases(
x - 2y + 6 > 0,

x + y - 4 < 0
  )
$.

Les droites frontières sont :

$
  cases(
x - 2y + 6 = 0,
x + y - 4 = 0
  )
  $.

On trace les deux droites dans le même repère.

La première inéquation détermine un premier demi-plan.

La seconde détermine un deuxième demi-plan.

La région commune aux deux demi-plans représente l'ensemble des
positions $(x;y)$ qui respectent simultanément les deux conditions.

Cette région constitue la #strong[zone de déplacement autorisée]
du robot.

]

#v(0.15cm)

#propriete[

Pour résoudre graphiquement un système d'inéquations dans
$ℝ × ℝ$ :

• on trace les droites frontières ;

• on détermine le demi-plan correspondant à chaque inéquation ;

• on recherche la partie commune à tous les demi-plans ;

• cette partie commune est #strong[l'ensemble des solutions du
système].

]


// ==========================================================
// XII — SYSTÈMES DE DEUX ÉQUATIONS DANS ℝ × ℝ
// ==========================================================

#v(0.35cm)

#sous_titre[Systèmes de deux équations du premier degré dans $ℝ × ℝ$]

#definition[

Un #strong[système de deux équations du premier degré dans
$ℝ × ℝ$] est constitué de deux équations du premier degré portant
sur les mêmes inconnues $x$ et $y$.

Résoudre le système consiste à déterminer le ou les couples
$(x;y)$ qui vérifient simultanément les deux équations.

]

#v(4cm)

#exemple[

🌊 #strong[Exemple — Localisation d'un robot océanographique]

La position d'un robot est déterminée par le système :
$
cases(
  2x + 3y - 6 = 0,
  2x - 5y + 2 = 0
)
$
La résolution du système permet de déterminer les coordonnées du
point correspondant à la position recherchée.
On obtient :
$y = 1$
puis
$x = 3/2$.

Le couple solution est donc :
$S_(ℝ×ℝ) = {(3/2;1)}$.

]

#propriete[

Un système de deux équations du premier degré dans $ℝ × ℝ$ peut
être résolu par différentes méthodes :

• #strong[la méthode graphique] ;

• #strong[la méthode de substitution] ;

• #strong[la méthode de combinaison] ;

• #strong[la méthode de comparaison].

Ces différentes méthodes conduisent au même ensemble de solutions.

]


// ==========================================================
// XIII — RÉSOLUTION GRAPHIQUE D'UN SYSTÈME
// ==========================================================

#v(0.35cm)

#sous_sous_titre[Résolution graphique d'un système de deux équations dans $ℝ × ℝ$]

#definition[

Pour #strong[résoudre graphiquement] un système de deux équations du premier
degré dans 

$ℝ × ℝ$ :

1. on représente chacune des équations par une droite ;

2. on recherche le ou les points communs aux deux droites ;

3. les coordonnées du ou des points communs donnent les solutions
   du système.

]

#v(0.15cm)

#propriete[
Lorsque deux droites sont #strong[sécantes], le système possède une
unique solution correspondant aux coordonnées de leur point
d'intersection.

• Lorsque deux droites sont #strong[parallèles et distinctes], le
système n'a aucune solution.

• Lorsque les deux équations représentent la #strong[même droite],
le système possède une infinité de solutions.

]


// ==========================================================
// XIV — MÉTHODES ALGÉBRIQUES DE RÉSOLUTION
// ==========================================================

#sous_titre[Résolution par substitution, combinaison et comparaison]

#sous_sous_titre[La méthode de substitution]

#definition[

La #strong[méthode de substitution] consiste à :

• exprimer une inconnue en fonction de l'autre à partir de l'une
  des équations ;

• remplacer cette expression dans l'autre équation ;

• résoudre l'équation obtenue ;

• déterminer ensuite la seconde inconnue ;

• présenter le couple solution.

]

#sous_sous_titre[La méthode de combinaison]

#definition[

La #strong[méthode de combinaison] consiste à multiplier les
équations par des nombres convenablement choisis afin d'obtenir
des coefficients opposés pour l'une des inconnues.

• On additionne ensuite les équations membre à membre afin
d'éliminer cette inconnue.

• On détermine alors l'autre inconnue, puis on revient à l'une des
équations initiales pour déterminer la première.

]

#sous_sous_titre[La méthode de comparaison]

#definition[

La #strong[méthode de comparaison] consiste à exprimer la même
inconnue en fonction de l'autre dans chacune des deux équations,
puis à comparer les expressions obtenues.

L'égalité entre ces expressions permet de déterminer l'une des
inconnues.

On détermine ensuite l'autre inconnue.

]

#exemple[

🌊 #strong[Exemple — Détermination de la position d'un robot]

On considère le système :

$

cases(
  2x + 3y - 6 = 0,

  2x - 5y + 2 = 0

)
$

#strong[Méthode de substitution]

$2x + 3y - 6 = 0$ donne $x = 3 - 3/2 y$.

En remplaçant cette expression dans la deuxième équation :

$2(3 - 3/2 y) - 5y + 2 = 0$

D'où : $8 - 8y = 0$

Donc : $y = 1$.

Puis : $x = 3 - 3/2 = 3/2$.

Ainsi : $S_(ℝ×ℝ) = {(3/2;1)}$.

]

#v(8cm)

#retenir[

• Les équations et les inéquations permettent de modéliser de
nombreuses situations rencontrées en océanographie et dans les
technologies marines.

• Une #strong[équation] permet notamment de déterminer une valeur
inconnue.

• Une #strong[inéquation] permet de déterminer un ensemble de valeurs
respectant une condition.

• Dans le plan, une équation du premier degré dans $ℝ × ℝ$ représente
une #strong[droite], tandis qu'une inéquation du premier degré
détermine généralement un #strong[demi-plan].

• Un système d'équations ou d'inéquations permet de rechercher les
valeurs ou les positions qui satisfont simultanément plusieurs
conditions.

• Ces outils mathématiques sont essentiels pour déterminer des zones
de fonctionnement, contrôler les paramètres d'un équipement et
définir les trajectoires ou les positions admissibles des
technologies utilisées en milieu marin.

]


















#sous_titre[
Applications affines
]

Dans les domaines de l'#strong[océanographie] et des
#strong[technologies marines], les scientifiques et les ingénieurs
doivent étudier l'évolution de nombreuses grandeurs liées aux
milieux marins et aux équipements utilisés en mer.
Ils peuvent notamment étudier :

• la distance parcourue par un robot sous-marin ;

• la profondeur atteinte par un drone marin ;

• la température de l'eau en fonction de la profondeur ;

• la pression exercée sur un équipement sous-marin ;

• la consommation d'énergie d'un véhicule autonome ;

• la position d'un capteur au cours du temps ;

• l'évolution d'une grandeur mesurée lors d'une mission océanographique.

Dans certaines situations, une grandeur $y$ peut évoluer

régulièrement en fonction d'une autre grandeur $x$.

Lorsque cette relation peut s'écrire sous la forme
#strong[$y = a x + b$],
elle est modélisée par une #strong[application affine].

#definition[

Soient $a$ et $b$ deux nombres réels.

On appelle #strong[application affine] de coefficient $a$ et de
terme constant $b$, la correspondance qui, à chaque nombre réel
$x$, associe le nombre réel :

#strong[$f(x) = a x + b$].

Dans cette expression :

• $a$ est le #strong[coefficient] de l'application affine ;

• $b$ est le #strong[terme constant].
]
#exemple[
Lors d'une mission océanographique, un capteur mesure la profondeur
d'un équipement sous-marin en fonction du temps.

Supposons que cette profondeur soit modélisée par :

$f(x) = 4x + 10$,
où $x$ représente le temps en minutes et $f(x)$ la profondeur
en mètres.

On identifie :
$a = 4$
et
$b = 10$.

Pour $x = 5$, on obtient :

$f(5) = 4 × 5 + 10 = 30$.

Après $5$ minutes, le modèle indique donc une profondeur de
$30$ mètres.

]

#v(8cm)

#sous_sous_titre[
Reconnaître une application affine
]
#retenir[
Une expression est celle d'une application affine lorsqu'elle
peut être écrite sous la forme :

#strong[$a x + b$],
où $a$ et $b$ sont des nombres réels.
]
#exemple[
On considère les applications définies sur $ℝ$ par :

$f(x) = 3x + 2$ ;

$g(x) = -2x$ ;

$h(x) = x^2 + 1$ ;

$p(x) = 7$.

Les applications $f$, $g$ et $p$ sont affines.

En effet :

$f(x) = 3x + 2$ ;

$g(x) = -2x + 0$ ;

$p(x) = 0x + 7$.

En revanche,
$h(x) = x^2 + 1$
n'est pas de la forme $a x + b$.

]

#sous_sous_titre[
Détermination d'une application affine à partir de deux valeurs
]
Une application affine est entièrement déterminée lorsque l'on
connaît les images de deux nombres réels distincts.

#exemple[

Lors d'une mission sous-marine, la profondeur d'un drone est

modélisée par une application affine $f$.

On sait que :
$f(2) = 18$
et
$f(6) = 34$.

On cherche l'expression de $f$.

Comme $f$ est affine, on écrit :
$f(x) = a x + b$.

Donc
$f(2) = 2a + b = 18$
et
$f(6) = 6a + b = 34$.


On obtient alors

$
 cases(

2a + b = 18,

6a + b = 34

 )
$

En soustrayant les deux égalités :
$4a = 16$.

Donc :
$a = 4$.

On obtient alors :
$2 × 4 + b = 18$,

D'où :
$b = 10$.

Ainsi :
$f(x) = 4x + 10$.
]

#sous_sous_titre[
Représentation graphique d'une application affine
]

#definition[

La #strong[représentation graphique] d'une application affine

#strong[$f(x) = a x + b$] est une droite d'équation :

#strong[$y = a x + b$].

Le nombre #strong[$a$] caractérise l'inclinaison de la droite.

Le nombre #strong[$b$] correspond à l'ordonnée du point où la droite coupe
l'axe des ordonnées.
]
#exemple[

La profondeur d'un équipement sous-marin est modélisée par :
$f(x) = 3x + 8$.

Sa représentation graphique est la droite d'équation :
$y = 3x + 8$.

Pour $x = 0$ :
$f(0) = 8$.

La droite passe donc par le point :
$(0 ; 8)$.

Pour $x = 2$ :
$f(2) = 14$.

Elle passe également par le point :
$(2 ; 14)$.

Ces deux points permettent de représenter graphiquement la droite.

]

#v(4cm)

#sous_sous_titre[
Sens de variation d'une application affine
]

Soit $f$ l'application affine définie par :

$f(x) = a x + b$.
Le sens de variation de $f$ dépend du signe de son coefficient $a$.

#definition[

• Si $a > 0$, l'application affine $f$ est #strong[strictement
croissante] sur $ℝ$.

• Si $a < 0$, l'application affine $f$ est #strong[strictement
décroissante] sur $ℝ$.

• Si $a = 0$, l'application affine $f$ est #strong[constante] sur $ℝ$.

]

#exemple[

La température de l'eau dans une zone océanique est modélisée
par 
$f(x) = 2x + 18$.

Le coefficient est :
$a = 2$.

Comme $2 > 0$, l'application $f$ est strictement croissante.

#strong[Lorsque $x$ augmente, $f(x)$ augmente également].

]

#exemple[

La pression mesurée par un capteur est modélisée par :
$g(x) = -3x + 50$.

Le coefficient est :
$a = -3$.

Comme $-3 < 0$, l'application $g$ est strictement décroissante.

#strong[Lorsque $x$ augmente, $g(x)$ diminue].

]

#exemple[

La température d'un équipement marin est considérée constante
pendant une phase d'une mission :
$t(x) = 25$.
On a :
$t(x) = 0x + 25$.

Le coefficient est donc nul.

#strong[L'application $t$ est constante sur $ℝ$].

]

#sous_sous_titre[
Comparaison des images de deux nombres
]
#retenir[
Soit $f(x) = a x + b$ une application affine.

Pour deux nombres réels $x_1$ et $x_2$ tels que

$x_1 < x_2$, le signe de $a$ permet de comparer

$f(x_1)$ et $f(x_2)$.
]

#exemple[

On considère :
$f(x) = 2x + 5$.

Soient $x_1$ et $x_2$ deux nombres réels tels que :

$x_1 < x_2$.

Comme $2 > 0$, on a :
$2x_1 < 2x_2$.

En ajoutant $5$ aux deux membres :

$2x_1 + 5 < 2x_2 + 5$.

Ainsi :
$f(x_1) < f(x_2)$.

#strong[L'application $f$ est donc strictement croissante].
]

#sous_sous_titre[
Coefficient directeur et variation d'une grandeur
]
#retenir[
Le coefficient #strong[$a$] d'une application affine mesure la variation
de la grandeur $f(x)$ lorsque $x$ augmente d'une unité.

Pour deux nombres réels distincts $x_1$ et $x_2$ :

#strong[$a = (f(x_2) - f(x_1))/(x_2 - x_1)$].
]
#exemple[

Un drone marin est observé à deux instants.

À $x = 4$ minutes, sa profondeur est de $20$ mètres.

À $x = 9$ minutes, sa profondeur est de $35$ mètres.

Le coefficient de variation est :

$a = (35 - 20)/(9 - 4) = 15/5 = 3$.

La profondeur augmente donc de $3$ mètres par minute selon
le modèle affine considéré.
]

#remarque[

Une application affine peut modéliser une évolution régulière
d'une grandeur en fonction d'une autre.

Le coefficient #strong[$a$] indique le sens de variation et mesure
la variation de la grandeur associée à une augmentation d'une
unité de la variable $x$.

]

#sous_titre[
Applications linéaires
]

Dans les domaines de l'#strong[océanographie] et des
#strong[technologies marines], certaines situations correspondent
à une relation de proportionnalité.

Par exemple, la distance parcourue par un équipement se déplaçant
à vitesse constante peut être proportionnelle au temps écoulé.

Dans ce cas, la relation entre les deux grandeurs peut être
modélisée par une #strong[application linéaire].

#definition[
On appelle #strong[application linéaire] une application affine
dont le terme constant est nul.

Ainsi, une application linéaire de coefficient $a$ est définie
par
#strong[$g(x) = a x$].
Une application linéaire est donc un cas particulier d'application
affine.

En effet :
#strong[$g(x) = a x + 0$].
]
#exemple[
Un robot sous-marin se déplace à vitesse constante de
$4$ mètres par seconde.
La distance parcourue en fonction du temps $t$ est 
$d(t) = 4t$.
Cette relation est une application linéaire de coefficient $4$.

Pour $t = 5$ secondes :
$d(5) = 4 × 5 = 20$.

Le robot a donc parcouru $20$ mètres.

]

#v(0.18cm)

#sous_sous_titre[
Tableau de valeurs d'une application linéaire
]
#retenir[
Les valeurs d'une application linéaire sont proportionnelles
aux valeurs de la variable.
]
#exemple[

On considère l'application linéaire :
$g(x) = 3x$.
On obtient le tableau :

#table(

  columns: 4,

  align: center,

  [ $x$ ], [ $0$ ], [ $2$ ], [ $5$ ],

  [ $g(x)$ ], [ $0$ ], [ $6$ ], [ $15$ ]

)

Le quotient entre une valeur de $g(x)$ et la valeur correspondante
de $x$, lorsque $x ≠ 0$, est toujours égal à $3$.

Le tableau est donc un tableau de proportionnalité.

]

#definition[

Un #strong[tableau de valeurs d'une application linéaire] est
un #strong[tableau de proportionnalité].

Réciproquement, un #strong[tableau de proportionnalité] peut être
interprété comme un tableau de valeurs d'une application linéaire.

]

#sous_sous_titre[
Représentation graphique d'une application linéaire
]
#retenir[
Soit $g$ une application linéaire définie par :
#strong[$g(x) = a x$].
Sa représentation graphique est la droite d'équation :
#strong[$y = a x$].

Pour $x = 0$, on a :
$g(0) = a × 0 = 0$.

Le point de coordonnées $(0 ; 0)$ appartient donc toujours
à cette droite.
]

#definition[

La représentation graphique d'une application linéaire est une
droite qui #strong[passe par l'origine] du repère.

]

#exemple[

On considère l'application linéaire :
$g(x) = -2x$.

Sa représentation graphique est la droite :
$y = -2x$.

Pour $x = 0$ :
$g(0) = 0$.

Pour $x = 1$ :
$g(1) = -2$.

La droite passe donc par les points :

$(0 ; 0)$ et $(1 ; -2)$.

Comme son coefficient est négatif, elle est décroissante.

]

#sous_sous_titre[
Propriétés d'une application linéaire
]
#retenir[
Soit $g$ une application linéaire définie par :
$g(x) = a x$.

Pour tous nombres réels $u$, $v$ et $k$, on a :

• #strong[$g(u + v) = g(u) + g(v)$]

• #strong[$g(k v) = k g(v)$].
]
#exemple[

Soit :
$g(x) = 5x$.

Pour deux nombres réels $u$ et $v$ :

$g(u+v) = 5(u+v) = 5u + 5v$

Comme $g(u) = 5u$ et $g(v) = 5v$

Alors : $g(u+v) = g(u) + g(v)$.

De même :

$g(k v) = 5k v = k(5v)$

Comme $g(v) = 5v$, on conclut que 

$g(k v) = k g(v)$.

]

#remarque[

Toute application linéaire est une application affine particulière.

En effet :
$g(x) = a x$

peut s'écrire :
$g(x) = a x + 0$.

Ainsi, le terme constant d'une application linéaire est toujours nul.

]

#v(1cm)

#sous_sous_titre[
Synthèse
]

#table(

  columns: 3,

  align: center,

  [ *Type* ], [ *Expression* ], [ *Représentation graphique* ],

  [ Application affine ],
  [ $f(x)=a x+b$ ],
  [ Une droite d'équation $y=a x+b$ ],

  [ Application linéaire ],
  [ $g(x)=a x$ ],
  [ Une droite passant par l'origine ],

)


Pour une application affine $f(x)=a x+b$ :

• si $a>0$, $f$ est strictement croissante ;

• si $a<0$, $f$ est strictement décroissante ;

• si $a=0$, $f$ est constante.

#v(0.15cm)

Pour une application linéaire $g(x)=a x$ :

• son terme constant est nul ;

• sa représentation graphique passe par l'origine ;

• ses valeurs sont proportionnelles aux valeurs de $x$.

#remarque[

Les applications affines et linéaires permettent de modéliser
de nombreuses situations de l'océanographie et des technologies
marines : déplacement d'un robot, évolution d'une profondeur,
variation d'une température, évolution d'une pression ou relation
de proportionnalité entre deux grandeurs.

]


]


]























