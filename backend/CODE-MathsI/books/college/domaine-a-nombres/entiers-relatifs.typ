
#import "../../../code/code.typ": *
#import "../../../code/boxes.typ": *



#let entiers_relatifs() = [

#debut_notion()
// ==========================================================
// TITRE DE LA NOTION
// ==========================================================

#pagebreak()

#title(
  [II — LES ENTIERS RELATIFS],
  "notion-entiers-relatifs",
) <notion-entiers-relatifs>

#v(0.05cm)

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
🌍 Pourquoi les nombres négatifs sont-ils apparus ?
]


#v(0.05cm)


Pendant longtemps, les êtres humains ont surtout utilisé
les nombres pour #strong[compter ce qu'ils possédaient] :
des animaux, des récoltes, des objets ou de l'argent.
Mais certaines situations devenaient difficiles à représenter
avec les seuls entiers naturels.


#v(0.05cm)


Un commerçant pouvait, par exemple, posséder $5$ pièces mais
devoir en rendre $8$.

Un comptable pouvait enregistrer un #strong[déficit] lorsqu'une
dépense dépassait une recette.

De même, dans certaines régions, la température pouvait être
inférieure à $0°C$, ou un niveau pouvait être situé
au-dessous d'un niveau de référence.

#v(0.05cm)

Les humains ont alors rencontré une nouvelle difficulté :


#align(center)[
#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
Comment représenter une quantité située « en dessous » d'une référence ?
]
]
#v(0.05cm)
Pour résoudre progressivement ces problèmes, les mathématiciens
ont introduit de nouveaux nombres permettant de représenter
les situations opposées aux nombres positifs.
Ainsi, à côté de $+1$, $+2$, $+3$, ... sont apparus
$-1$, $-2$, $-3$, ...
Le symbole « $-$ » indique alors qu'une valeur se situe
#strong[en dessous d'une référence], tandis que le symbole
« $+$ » indique qu'elle se situe #strong[au-dessus de cette référence].

#v(0.05cm)
Les nombres positifs, les nombres négatifs et le nombre $0$
forment aujourd'hui un nouvel ensemble :


#align(center)[
#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
#strong[$ℤ = { ... , -3 , -2 , -1 , 0 , +1 , +2 , +3 , ... }$]
]
]


#v(0.05cm)


Cet ensemble est appelé #strong[l'ensemble des entiers relatifs].
Il permet de représenter des situations où une grandeur peut
se trouver #strong[de part et d'autre d'une valeur de référence] :
températures, altitudes, dettes, gains et pertes, déplacements,
niveaux ou encore variations de certaines grandeurs.

#v(0.05cm)

#remarque[
Le développement des nombres négatifs n'a donc pas été immédiat.
Ils ont été introduits progressivement pour répondre à des
problèmes que les nombres naturels ne permettaient pas de
représenter correctement.
]


#v(0.05cm)


// ==========================================================
// OBJECTIFS DE LA NOTION
// ==========================================================


#text(
  size: 12pt,
  weight: "bold",
  fill: code-blue,
)[
🎯 Ce que tu vas apprendre
]


#v(0.05cm)


À travers cette notion, tu vas apprendre à :

• reconnaître et utiliser l'ensemble des entiers relatifs $ℤ$ ;

• distinguer les entiers positifs, les entiers négatifs et $0$ ;

• déterminer l'opposé d'un entier relatif ;

• comparer et ranger des entiers relatifs ;

• représenter des entiers relatifs sur une droite graduée ;

• effectuer des additions et des soustractions d'entiers relatifs ;

• utiliser les entiers relatifs pour représenter et résoudre
des situations concrètes.
]
#pagebreak()

#align(center)[

#image_full("entiers-relatifs-origine.png")

]



#pagebreak()
// ==========================================================
// PARCOURS 5e
// ENTIERS RELATIFS ET PUISSANCES DANS ℤ
// AVEC LA MÉTÉOROLOGIE
// ==========================================================


#parcours(
  [PARCOURS 5ᵉ — Entiers relatifs et puissances dans $ℤ$ avec la météorologie],
  "parcours-entiers-relatifs-5e",
) <parcours-entiers-relatifs-5e>


// ==========================================================
// MISE EN SITUATION
// ==========================================================

#activite[
🌦️ #strong[la découverte de la météorologie : observer et prévoir le temps]

#v(0.05cm)

Pourquoi peut-on annoncer à l'avance qu'il fera beau demain, qu'il pleuvra dans l'après-midi ou qu'une nuit sera particulièrement froide ?
Ces prévisions sont réalisées grâce à la #strong[météorologie], une science qui étudie l'atmosphère et les phénomènes qui s'y produisent : température, pluie, vent, nuages, humidité, pression atmosphérique, ensoleillement, etc.
Les #strong[météorologues] recueillent ces informations à l'aide de stations météorologiques, de satellites, de radars et de différents instruments de mesure. Ils analysent ensuite ces données pour prévoir l'évolution du temps et informer les populations.
Ces prévisions sont utiles dans la vie quotidienne, mais aussi pour l'agriculture, les transports, la pêche, les activités en plein air et la prévention de certains risques liés aux phénomènes météorologiques.
Parmi les données étudiées, la #strong[température] occupe une place importante.
Une station météorologique peut relever au cours d'une journée $+8°C$ dans l'après-midi ;
$+3°C$ pendant la nuit ;
$-2°C$ au petit matin ;
$-7°C$ dans une zone montagneuse.
Le nombre $0°C$ sert ici de #strong[référence] : une température positive est supérieure à $0°C$, tandis qu'une température négative est inférieure à $0°C$.
Pour analyser ces relevés, le météorologue doit comparer les températures et étudier leurs variations.

1. Quelles températures sont supérieures à $0°C$ ? Lesquelles sont inférieures à $0°C$ ?

2. Parmi $-2°C$ et $-7°C$, quelle est la température la plus froide ?

3. Classe les températures suivantes de la plus froide à la plus chaude :
   $+8°C$, $+3°C$, $-2°C$ $-7°C$.

4. La température passe de $+8°C$ à $+3°C$. De combien de degrés diminue-t-elle ?

5. Elle passe ensuite de $+3°C$ à $-2°C$. De combien de degrés diminue-t-elle ?

6. Au petit matin, elle passe de $-7°C$ à $-2°C$. De combien de degrés augmente-t-elle ?

7. Une température de $-5°C$ est-elle plus chaude ou plus froide que $-2°C$ ? Justifie.

8. La température est de $-3°C$ et augmente de $4°C$. Quelle température obtient-on ?

9. La température est de $+2°C$ et diminue de $6°C$. Quelle température obtient-on ?

#v(0.05cm)

Les températures peuvent donc être situées #strong[au-dessus ou au-dessous de $0$] et #strong[augmenter ou diminuer].
Les météorologues ont donc besoin de nombres permettant de représenter
des températures situées au-dessus ou au-dessous de $0°C$, mais aussi
de décrire les variations de température.
Pour répondre à ce besoin, les mathématiques utilisent les
#strong[nombres entiers relatifs].
L'ensemble des entiers relatifs, noté #strong[$ℤ$], est constitué des entiers
négatifs, de zéro et des entiers positifs 
Nous allons maintenant apprendre à lire, représenter, comparer et
utiliser ces nombres pour analyser des situations telles que celles
rencontrées en météorologie.
]



#v(0.25cm)

#align(center)[

  #image_full("station-meteorologique-5e.png")

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

🌡️ reconnaître et utiliser les #strong[entiers relatifs] ;

#v(0.05cm)

📍 repérer et comparer des entiers relatifs sur une droite graduée ;

#v(0.05cm)

↔️ déterminer l'#strong[opposé] d'un entier relatif ;

#v(0.05cm)

📈 effectuer des #strong[additions et soustractions] d'entiers relatifs ;

#v(0.05cm)

✖️ effectuer des #strong[multiplications et divisions] d'entiers relatifs ;

#v(0.05cm)

🔢 utiliser les #strong[puissances d'entiers relatifs] ;

#v(0.05cm)

🧮 appliquer les règles de calcul sur les #strong[produits et puissances] ;

#v(0.05cm)

🌦️ et utiliser ces notions pour #strong[analyser des températures et des variations météorologiques].
]


#v(0.3cm)

#remarque[
Les mathématiques permettent ici de traduire des phénomènes observés dans l'atmosphère.

Une température de $+6°C$ et une température de $-6°C$ sont toutes deux des nombres, mais elles indiquent des situations opposées par rapport à la température de référence $0°C$.

Les entiers relatifs permettent donc de #strong[représenter, comparer et calculer] des variations dans lesquelles une grandeur peut évoluer dans deux directions opposées.
]
#pagebreak()

#deux-colonnes[


// ==========================================================
// LES ENTIERS RELATIFS
// ==========================================================

#sous_titre[
Les entiers relatifs
]

#v(0.05cm)

#definition[
Un #strong[entier relatif] est un nombre entier positif, négatif ou nul.

Les entiers relatifs positifs sont précédés du signe $+$ ou ne portent pas de signe.

Les entiers relatifs négatifs sont précédés du signe $-$.

L'ensemble des entiers relatifs est noté $ℤ$.
]

#v(0.05cm)

#exemple[
Une station météorologique relève les températures suivantes :
$+7°C$, $+2°C$, $0°C$, $-3°C$ et $-8°C$.

Les nombres 
$+7$, $+2$, $0$
sont positifs ou nuls.

Les nombres 
$-3$, $-8$
sont négatifs.
]

#v(0.25cm)

#remarque[
Le signe d'un entier relatif permet de savoir de quel côté de $0$ se trouve le nombre.

• Un nombre positif est situé à droite de $0$.

• Un nombre négatif est situé à gauche de $0$.
]


#v(0.5cm)


// ==========================================================
// REPÉRER SUR UNE DROITE GRADUÉE
// ==========================================================

#sous_titre[
Repérer un entier relatif
]

#v(0.15cm)

#definition[
Sur une droite graduée, chaque point est associé à un nombre.

Le point correspondant à $0$ est appelé #strong[origine].

Les nombres positifs sont placés à droite de $0$ et les nombres négatifs à gauche de $0$.

#align(center)[

  #image_full("graduation-1-5e.jpeg")

]

]

#v(0.25cm)

#exemple[
Les températures relevées au cours d'une journée sont :

$-6°C$, $-2°C$, $+1°C$, $+5°C$.

Sur une droite graduée, elles se placent dans l'ordre :

$-6 < -2 < +1 < +5$.

La température augmente lorsqu'on se déplace vers la droite.
]

#v(0.3cm)

#remarque[
Plus un entier relatif est situé à droite sur la droite graduée, plus il est grand.

Plus il est situé à gauche, plus il est petit.
]


#v(0.5cm)


// ==========================================================
// OPPOSÉS
// ==========================================================

#sous_titre[
L'opposé d'un entier relatif
]

#v(0.15cm)

#definition[
Deux entiers relatifs sont #strong[opposés] lorsqu'ils ont la même distance à $0$ et des signes contraires.

L'opposé de $+a$ est $-a$. On note:

 #strong[opp($+a$)=$-a$].

L'opposé de $-a$ est $+a$. On note:

 #strong[opp($-a$)=$+a$].


]

#v(0.25cm)

#exemple_resolu[
Une station relève une température de $-6°C$.

L'entier relatif opposé à $-6$ est $+6$.

On a donc :

opp($-1$) = $+1$.

De même :

opp($+2$) = $-2$.

opp($0$) = $0$.
]

#v(2cm)

#remarque[
Deux nombres opposés sont situés à la même distance de $0$, mais de part et d'autre de $0$.

Par exemple, $-4$ et $+4$ sont opposés.
]


#v(0.5cm)


// ==========================================================
// COMPARER DES ENTIERS RELATIFS
// ==========================================================

#sous_titre[
Comparer des entiers relatifs
]

#v(0.15cm)

#propriete[
Sur une droite graduée, le nombre situé le plus à droite est le plus grand.
]

#v(0.25cm)

#exemple_resolu[
Une station météorologique compare deux températures :
$-3°C$ et $-8°C$.

Sur la droite graduée, $-3$ est situé à droite de $-8$.

Donc :
$-3 > -8$.

La température $-3°C$ est donc plus élevée que la température $-8°C$.
]

#v(0.05cm)

#exemple[
On peut également comparer :

$+5 > -2$

$-4 < +1$

$-7 < -3$

$+8 > +4$.
]

#v(0.3cm)

#remarque[
Entre deux nombres négatifs, le plus grand est celui qui est le plus proche de $0$.

Ainsi :
$-2 > -6$.

En météorologie, cela signifie que $-2°C$ est une température plus élevée que $-6°C$.
]


#v(0.5cm)
// ==========================================================
// DROITE GRADUÉE ET ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Représenter les entiers relatifs sur une droite graduée
]

#v(0.15cm)


#definition[
Une #strong[droite graduée] est une droite sur laquelle on choisit :

• un point appelé #strong[origine], auquel on associe le nombre $0$ ;

• un point appelé #strong[point unité], auquel on associe le nombre $+1$ ;

• un sens positif, généralement orienté vers la droite ;

• une unité de longueur permettant de réaliser les graduations.

#align(center)[

  #image_full("graduation-1-5e.jpeg")

]
]


#v(0.25cm)


#remarque[
Pour graduer une droite, il suffit donc de choisir une origine
et un point unité.

Une fois la droite graduée construite, chaque nombre relatif
est associé à un point unique de cette droite.
]


#v(0.25cm)


#definition[
Le nombre associé à un point d'une droite graduée est appelé
son #strong[abscisse].
]


#v(0.25cm)


#exemple[
Sur une droite graduée, le point $A$ placé trois graduations
à gauche de l'origine a pour abscisse $-3$.

Le point $H$ placé cinq graduations à droite de l'origine
a pour abscisse $+5$.

Ainsi 
$A(-3)$ et $H(+5)$.
]

#v(0.05cm)




#remarque[
Sur une droite graduée, deux nombres opposés correspondent
à deux points symétriques par rapport à l'origine.
]
#v(0.05cm)


// ==========================================================
// COMPARER DES ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Comparer des entiers relatifs
]


#v(0.05cm)


#propriete[
Sur une droite graduée, le nombre correspondant au point situé
le plus à gauche est le plus petit.

Le nombre correspondant au point situé le plus à droite
est le plus grand.
]


#v(0.05cm)


#exemple_resolu[
Comparons $-5$ et $-2$.

Sur une droite graduée, $-5$ est situé à gauche de $-2$.

Donc 
$-5 < -2$.

Ainsi, une température de $-5°C$ est plus froide qu'une
température de $-2°C$.
]


#v(0.05cm)


#exemple_resolu[
Comparons $-3$ et $+4$.

Le point d'abscisse $-3$ est situé à gauche du point
d'abscisse $+4$.

Donc
$-3 < +4$.

Une température de $-3°C$ est donc inférieure à
une température de $+4°C$.
]


#v(0.05cm)


#remarque[
Si deux entiers relatifs sont de signes différents,
le nombre négatif est toujours le plus petit.

#exemple[
$-8 < +2$.

$-1 < +7$.]
]


#v(0.05cm)


// ==========================================================
// RANGER DES ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Ranger des entiers relatifs
]


#v(0.05cm)


#exemple_resolu[
Une station météorologique enregistre les températures suivantes :

$+4°C, -2°C, +1°C, -5°C, 0°C$.

Rangeons-les dans l'ordre croissant.

Sur la droite graduée, on les rencontre de gauche à droite
dans l'ordre :

$-5, -2, 0, +1, +4$.

Donc 
$-5 < -2 < 0 < +1 < +4$.

L'ordre croissant des températures est donc :

$-5°C, -2°C, 0°C, +1°C, +4°C$.
]

#exemple[
Range dans l'ordre décroissant :
$-3, +5, -1, +2, 0$.

On obtient 
$+5 > +2 > 0 > -1 > -3$.
]



// ==========================================================
// DÉPLACEMENTS SUR UNE DROITE GRADUÉE
// ==========================================================


#sous_titre[
Interpréter une variation sur une droite graduée
]

#exemple[
Une station météorologique relève une température de
$-3°C$ le matin.
Dans la journée, la température augmente de $5°C$.
Pour représenter cette évolution, on peut partir du point
d'abscisse $-3$ et avancer de $5$ graduations vers la droite.

1. À quelle température arrive-t-on ?
2. Quelle opération permet de traduire cette évolution ?
3. Que signifie le déplacement vers la droite ?


À présent, la température est de $+4°C$ et elle diminue
de $6°C$.
4. Dans quelle direction faut-il se déplacer sur la droite ?
5. À quelle température arrive-t-on ?
6. Quelle opération permet de traduire cette évolution ?
]


#v(0.05cm)

#exemple_resolu[
Une station relève $-3°C$.
La température augmente de $5°C$.

Sur une droite graduée, augmenter de $5$ revient à
se déplacer de $5$ graduations vers la droite.
On part donc de $-3$ :

$-3 → -2 → -1 → 0 → +1 → +2$.

On arrive en $+2$.
Ainsi $-3 + 5 = +2.$
La température finale est donc $+2°C$.
]

#exemple_resolu[
La température est de $+4°C$ et diminue de $6°C$.
On part de $+4$ et on recule de $6$ graduations :

$+4 → +3 → +2 → +1 → 0 → -1 → -2$.

Donc $+4 - 6 = -2$.
La température finale est donc $-2°C$.
]

// ==========================================================
// ADDITION DE DEUX ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Additionner deux entiers relatifs
]


#definition[
Additionner un entier relatif à un autre revient à effectuer
un déplacement sur une droite graduée.

• Ajouter un nombre positif revient à se déplacer vers la droite.

• Ajouter un nombre négatif revient à se déplacer vers la gauche.
]


#exemple_resolu[
Une station relève une température de $-4°C$ le matin.
La température augmente de $7°C$.

On traduit cette évolution par 
$-4 + (+7)$.

On part de $-4$ et on avance de $7$ graduations :

$-4 → -3 → -2 → -1 → 0 → +1 → +2 → +3$.

Donc 
$-4 + (+7) = +3$.

La température finale est $+3°C$.
]


#v(0.05cm)


#exemple_resolu[
Une température de $-2°C$ diminue encore de $5°C$.
La variation est donc $-5°C$.

On calcule :
$-2 + (-5)$.

On part de $-2$ et on se déplace de $5$ graduations
vers la gauche :

$-2 → -3 → -4 → -5 → -6 → -7$.

Donc :
$-2 + (-5) = -7$.
La température finale est $-7\,°C$.
]

#regle[
Pour additionner deux entiers relatifs :

• s'ils ont le même signe, on additionne leurs distances
à l'origine et on conserve leur signe commun ;

• s'ils ont des signes différents, on soustrait les deux
distances à l'origine et on conserve le signe du nombre
situé le plus loin de l'origine.
]

#exemple[
$(-4)+(-3)=-7$
car les deux nombres sont négatifs.

$(-8)+(+5)=-3$
car $8>5$ et le nombre ayant la plus grande distance
à l'origine est $-8$.

$(+6)+(-2)=+4$
car $6>2$ et le nombre ayant la plus grande distance
à l'origine est $+6$.
]

// ==========================================================
// SOUSTRACTION D'ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Soustraire des entiers relatifs
]


#v(0.15cm)


#propriete[
Soustraire un entier relatif revient à ajouter son opposé :

$a-b=a+(-b)$.
]


#v(2cm)


#exemple_resolu[
Une station relève une température de $+6°C$.

Quelques heures plus tard, la température diminue de
$9°C$.
On traduit cette évolution par :
$+6-9$.

Soustraire $9$ revient à ajouter son opposé $-9$ :

$+6-9=+6+(-9)$.

On obtient :
$+6-9=-3$.

La température finale est donc $-3°C$.
]

#exemple_resolu[
Une station relève une température de $-3°C$.

Elle augmente ensuite jusqu'à atteindre $+4°C$.

La variation est :
$+4-(-3)$.

On transforme la soustraction en addition de l'opposé :
$+4-(-3)=+4+(+3)$.

Donc :
$+4-(-3)=+7$.

La température a augmenté de $7°C$.
]

// ==========================================================
// PRODUIT DE DEUX ENTIERS RELATIFS
// ==========================================================


#sous_titre[
Multiplier deux entiers relatifs
]

#definition[
Multiplier un entier relatif par un entier naturel revient
à effectuer une addition répétée.

Par exemple
$4 × (-2)=(-2)+(-2)+(-2)+(-2)$.
]

#regle[
Pour multiplier deux entiers relatifs :

• le produit de deux nombres de même signe est #strong[positif] ;

• le produit de deux nombres de signes différents est #strong[négatif].

Pour déterminer la partie numérique du résultat, on multiplie
les nombres sans tenir compte de leurs signes.
]


#exemple[
$(-3) × (-4)=+12$
car les deux facteurs sont négatifs.

$(-3) × (+4)=-12$
car les facteurs sont de signes différents.

$(+3) × (+4)=+12$
car les deux facteurs sont positifs.
]

#exemple_resolu[
Une variation de température de $-2°C$ se répète pendant
$4$ heures.

La variation totale est :
$4 × (-2)$.

On obtient :
$4 × (-2)=-8$.

La température a donc diminué de $8°C$ par rapport
à la température de départ.
]

// ==========================================================
// À RETENIR
// ==========================================================


#retenir[
Sur une droite graduée :

• $0$ est l'#strong[origine] ;

• le point correspondant à $+1$ permet de définir
le #strong[point unité] ;

• les nombres négatifs sont situés à gauche de $0$ ;

• les nombres positifs sont situés à droite de $0$ ;

• plus un nombre est situé à droite, plus il est grand ;

• deux nombres opposés sont représentés par deux points
symétriques par rapport à l'origine.

Pour les calculs :

• ajouter un nombre positif correspond à un déplacement
vers la droite ;

• ajouter un nombre négatif correspond à un déplacement
vers la gauche ;

• soustraire un nombre revient à ajouter son opposé ;

• le produit de deux nombres de même signe est positif ;

• le produit de deux nombres de signes différents est négatif.
]


#v(0.5cm)


// ==========================================================
// EXERCICES D'APPLICATION
// ==========================================================


#exercice[
#mission[
🌦️ Mission — Lire et interpréter une droite graduée
]


Une station météorologique utilise une droite graduée pour
représenter certaines températures relevées au cours d'une
journée.

Les points $A$, $B$, $C$, $D$ et $E$ ont respectivement pour
abscisses 
$-6, -2, 0, +3, +5$.

1. Quelle est la température correspondant à chaque point ?

2. Quel point correspond à la température la plus froide ?

3. Quel point correspond à la température la plus chaude ?

4. Compare $-6$ et $-2$.

5. Compare $+3$ et $+5$.

6. Range les cinq températures dans l'ordre croissant.
]

#exercice[
#mission[
🌡️ Mission — Opposés de températures
]

Une station enregistre les températures :

$+5,°C, -5,°C, +3,°C, -3,°C, 0,°C$.

1. Donne l'opposé de $+5$.

2. Donne l'opposé de $-5$.

3. Donne l'opposé de $+3$.

4. Donne l'opposé de $-3$.

5. Donne l'opposé de $0$.

6. Quels couples de températures sont opposés ?
]
#v(5cm)
#exercice[
#mission[
🌦️ Mission — Évolution de la température
]

Une station relève $-5°C$ à $6$ heures.

À midi, la température a augmenté de $8°C$.

1. Traduis cette évolution par une addition.

2. Calcule la température à midi.

3. Représente le déplacement sur une droite graduée.

Dans l'après-midi, la température diminue de $6°C$.

4. Traduis cette nouvelle évolution par une soustraction.

5. Calcule la température obtenue.
]

#exercice[
#mission[
🌧️ Mission — Variations successives
]

Une température est de $+4°C$ au début d'une période.
Pendant les heures suivantes, elle diminue successivement
de $3°C$, puis de $5°C$.

1. Écris la première évolution sous forme d'une opération.

2. Calcule la température après la première diminution.

3. Écris la seconde évolution sous forme d'une opération.

4. Calcule la température finale.

5. Représente les deux déplacements sur une droite graduée.
]
#v(5cm)
#exercice[
#mission[
🌡️ Mission — Répétition d'une variation
]

Dans une situation météorologique simplifiée, une température
diminue de $2°C$ par heure pendant $6$ heures.

1. Écris cette variation sous forme d'un produit.

2. Calcule la variation totale.

3. La variation totale est-elle positive ou négative ?

4. Interprète le résultat dans le contexte météorologique.
]

#exercice[
#mission[
☀️ Mission — Comparer des températures
]

Une station relève les températures suivantes :

$-7°C, -4,°C, -1,°C, +2,°C, +6,°C$.

1. Range ces températures dans l'ordre croissant.

2. Quelle est la température la plus froide ?

3. Quelle est la température la plus chaude ?

4. Compare $-7$ et $-1$.

5. Compare $-4$ et $+2$.

6. Donne l'opposé de chaque température.

]

// ==========================================================
// DIVISION
// ==========================================================

#sous_titre[
Diviser des entiers relatifs
]

#regle[
Pour diviser deux entiers relatifs non nuls :

• le quotient de deux nombres de même signe est positif ;

• le quotient de deux nombres de signes différents est négatif.

La distance à zéro du quotient est obtenue en divisant les distances à zéro des deux nombres.
]

#exemple_resolu[
Une température a diminué de $12°C$ en $4$ heures, avec une diminution supposée régulière.

La variation horaire est :

$(-12) ÷ 4 = -3$.

La température diminuait donc de $3°C$ par heure dans cette modélisation.
]

#v(0.25cm)

#exemple[
$(-20) ÷ (-5)=+4$

car les deux nombres ont le même signe.

$(-20) ÷ (+5)=-4$

car les signes sont différents.
]


#v(0.5cm)


// ==========================================================
// RÈGLES DE SIGNES
// ==========================================================

#sous_titre[
Les règles de signes
]

#v(0.15cm)

#retenir[
Pour une multiplication ou une division :

$+ × +=+$

$- × -=+$

$+ × -=-$

$- × +=-$

Les mêmes règles de signes s'appliquent à la division.
]

#v(0.25cm)

#exemple[
$(-6) × (-2)=+12$

$(+6) × (-2)=-12$

$(-18) ÷ (+3)=-6$

$(-18) ÷ (-3)=+6$.
]


#v(0.5cm)


// ==========================================================
// PRIORITÉS DE CALCUL
// ==========================================================

#sous_titre[
Calculs avec des entiers relatifs
]

#v(0.15cm)

#retenir[
Dans une expression comportant plusieurs opérations :

1. on effectue d'abord les calculs entre parenthèses ;

2. puis les puissances ;

3. puis les multiplications et les divisions ;

4. enfin les additions et les soustractions.

Lorsque plusieurs opérations de même priorité se suivent, on les effectue de gauche à droite.
]

#v(0.3cm)

#exemple_resolu[
Une station météorologique modélise une variation de température par l'expression :

$-4 + 3 × (-2)$.

La multiplication est prioritaire.

On calcule :
$3 × (-2)=-6$.

Donc :
$-4+(-6)=-10$.

Ainsi :
$-4 + 3 × (-2)=-10$.
]

// ==========================================================
// PUISSANCES D'ENTIERS RELATIFS
// ==========================================================

#sous_titre[
Les puissances d'un entier relatif
]

#definition[
Pour tout entier relatif $a$ et tout entier naturel non nul $n$, la puissance $a^n$ désigne le produit de $n$ facteurs égaux à $a$ :

$a^n=a×a×a×...×a$

avec $n$ facteurs égaux à $a$.

• $a$ est la #strong[base] ;

• $n$ est l'#strong[exposant].
]

#v(0.4cm)

#exemple[
Une station météorologique peut utiliser une modélisation mathématique dans laquelle une même variation est répétée plusieurs fois.

On peut alors rencontrer des produits tels que :

$(-2) × (-2) × (-2)$.

Cette répétition peut s'écrire :
$(-2)^3$.

Ainsi :
$(-2)^3=(-2)×(-2)×(-2)=-8$.
]

#remarque[
Il est essentiel de conserver les parenthèses lorsque la base est négative.

$(-3)^2$
et
$-3^2$
ne désignent pas la même expression.

En effet :
$(-3)^2=(-3)×(-3)=+9$.

Tandis que :
$-3^2=-(3^2)=-9$.
]


// ==========================================================
// SIGNE D'UNE PUISSANCE
// ==========================================================

#sous_titre[
Le signe d'une puissance
]

#v(0.15cm)

#propriete[
Si la base est positive, toute puissance est positive.

Si la base est négative :

• lorsque l'exposant est #strong[pair], la puissance est positive ;

• lorsque l'exposant est #strong[impair], la puissance est négative.
]

#exemple_resolu[
Considérons la puissance :
$(-3)^4$.

L'exposant $4$ est pair.

Donc la puissance est positive.

On calcule :

$(-3)^4=(-3)×(-3)×(-3)×(-3)$

$(-3)^4=81$.
]

#exemple_resolu[
Considérons maintenant :
$(-3)^5$.

L'exposant $5$ est impair.

Donc la puissance est négative.

$(-3)^5=-243$.
]

#retenir[
Pour une base négative $-a$, avec $a>0$ :

• si l'exposant $n$ est #strong[pair], alors la puissance est #strong[positive] :
$(-a)^n > 0$.

• si l'exposant $n$ est #strong[impair], alors la puissance est #strong[négative] :
$(-a)^n < 0$.
]
#exemple[

$(-2)^4 = 16 > 0$
et
$(-2)^3 = -8 < 0$.
]
// ==========================================================
// PUISSANCES PARTICULIÈRES
// ==========================================================

#sous_sous_titre[
Puissances particulières
]


#definition[
Pour tout entier relatif $a$ :

$a^1=a$.

Pour tout entier relatif non nul $a$ :

$a^0=1$.
]

#exemple[
$(-7)^1=-7$

$(+5)^1=5$

$(-8)^0=1$

$(+12)^0=1$.
]

#remarque[
Le cas $0^0$ n'est pas utilisé dans les calculs élémentaires.
]

// ==========================================================
// CALCULER UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Calculer une puissance d'un entier relatif
]

#exemple_resolu[
Une modélisation météorologique fait apparaître le produit :

$(-2)×(-2)×(-2)×(-2)$.

On reconnaît quatre facteurs égaux à $-2$.

On écrit donc :
$(-2)^4$.

Comme l'exposant $4$ est pair :
$(-2)^4=16$.
]

#exemple[
$(-5)^2=(-5)×(-5)=25$

$(-2)^3=(-2)×(-2)×(-2)=-8$

$(-4)^3=-64$

$(+3)^4=81$.
]

// ==========================================================
// PRODUIT DE PUISSANCES DE MÊME BASE
// ==========================================================

#sous_sous_titre[
Produit de puissances de même base
]

#retenir[
Pour multiplier des puissances de même base, on conserve la base et on additionne les exposants :

$a^n × a^m=a^(n+m)$.
]

#exemple_resolu[
Dans une modélisation numérique, une même quantité relative intervient sous la forme :

$(-2)^3 × (-2)^4$.

Les deux puissances ont la même base.

On peut donc écrire :
$(-2)^3 × (-2)^4=(-2)^(3+4)$.

Ainsi :
$(-2)^3 × (-2)^4=(-2)^7$.

Comme $7$ est impair, le résultat est négatif.

On obtient :
$(-2)^7=-128$.
]

#exemple[
$(+3)^2 × (+3)^4=3^6$

$(-5)^2 × (-5)^3=(-5)^5$.

La règle fonctionne également lorsque la base est négative.
]

// ==========================================================
// PUISSANCE D'UN PRODUIT
// ==========================================================

#sous_sous_titre[
Puissance d'un produit
]

#definition[
Pour deux entiers relatifs $a$ et $b$ et un entier naturel $n$, on a :
#strong[$(a×b)^n=a^n×b^n$.]
]

#exemple_resolu[
Une expression utilisée dans une modélisation météorologique est :
$(-2×3)^2$.

On peut calculer directement :

$(-2×3)^2=(-6)^2=36$.

Ou utiliser la propriété :

$(-2×3)^2=(-2)^2×3^2$.

Donc :
$(-2)^2×3^2=4×9=36$.

On obtient bien le même résultat.
]

// ==========================================================
// PUISSANCE D'UNE PUISSANCE
// ==========================================================

#sous_sous_titre[
Puissance d'une puissance
]

#retenir[
Pour élever une puissance à une autre puissance, on conserve la base et on multiplie les exposants :
$(a^n)^m=a^(n×m)$.
]

#exemple_resolu[
Considérons :
$((-2)^3)^2$.

On applique la règle :
$((-2)^3)^2=(-2)^(3×2)$.

Donc :
$((-2)^3)^2=(-2)^6$.

L'exposant $6$ est pair.
Ainsi :
$(-2)^6=64$.
]

// ==========================================================
// CALCULS AVEC DES PUISSANCES
// ==========================================================

#sous_sous_titre[
Calculs avec les puissances
]

#exemple_resolu[
Une station météorologique utilise une expression simplifiée :
$-3+2^3×(-2)$.

La puissance est prioritaire.

On calcule :
$2^3=8$.

Puis :
$8×(-2)=-16$.

Enfin :
$-3+(-16)=-19$.

Donc :
$-3+2^3×(-2)=-19$.
]

#exemple_resolu[
Considérons maintenant :
$(-2)^3+5×(-2)$.

On calcule d'abord la puissance :
$(-2)^3=-8$.

Puis :
$5×(-2)=-10$.

Enfin :
$-8+(-10)=-18$.

Donc :
$(-2)^3+5×(-2)=-18$.
]

// ==========================================================
// PRIORITÉ DES PUISSANCES
// ==========================================================

#sous_sous_titre[
Priorité des puissances
]

#retenir[
Dans une expression sans parenthèses, les puissances sont prioritaires sur les multiplications, les divisions, les additions et les soustractions.
Lorsque des parenthèses sont présentes, les calculs entre parenthèses sont effectués en priorité.
]

#exemple_resolu[
Une expression simplifiée associée à une évolution météorologique est :
$4-(-2)^3×3$.

On calcule d'abord la puissance :
$(-2)^3=-8$.

Puis la multiplication :
$-8×3=-24$.

Enfin :
$4-(-24)=28$.

Donc :
$4-(-2)^3×3=28$.
]

// ==========================================================
// PUISSANCES ET PRODUITS DE FACTEURS
// ==========================================================

#sous_sous_titre[
Puissances et produits de facteurs
]

#exemple_resolu[
Dans une modélisation numérique, on obtient :

$(-2)×(-2)×(-2)×3×3$.

Les facteurs $-2$ apparaissent trois fois et les facteurs $3$ apparaissent deux fois.

On peut donc écrire :
$(-2)^3×3^2$.

Ainsi :
$(-2)^3×3^2=-8×9$.

Donc :
$(-2)^3×3^2=-72$.

La puissance permet ici d'écrire plus simplement les facteurs identiques.
]

// ==========================================================
// EXERCICE D'APPLICATION
// ==========================================================

#exercice_resolu[

#mission[
🌦️ Application — Analyser l'évolution des températures
]

#text(
weight:"bold",
)[
1. Lire et comparer des températures
]

Une station météorologique relève les températures suivantes :

$-7,°C$, $-2,°C$, $+1,°C$, $+6,°C$.

Classe ces températures dans l'ordre croissant.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On obtient :
$-7<-2<+1<+6$.

La température la plus basse est donc $-7°C$ et la plus élevée est $+6°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
2. Calculer une variation
]

Une station relève $-4°C$ le matin puis $+3°C$ dans l'après-midi.

Détermine la variation de température.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

La variation est :
$+3-(-4)$.

Donc :
$+3+4=+7$.

La température a augmenté de $7°C$.

#v(1cm)

#text(
weight:"bold",
)[
3. Étudier une baisse de température
]

Une température de $+5°C$ diminue de $8°C$.
Quelle est la température finale ?

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On calcule :
$+5-8=-3$.

La température finale est donc $-3°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
4. Utiliser un produit
]

Pendant $5$ heures, une température diminue de $2°C$ chaque heure.

Exprime la variation totale par un produit puis calcule-la.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

La variation est :
$5×(-2)=-10$.

La température a donc diminué de $10°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
5. Calculer une puissance
]

Une modélisation utilise l'expression :
$(-2)^4$.

Calcule cette puissance et indique son signe.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

L'exposant $4$ est pair.
La puissance est donc positive.

$(-2)^4=(-2)×(-2)×(-2)×(-2)$.

Donc :
$(-2)^4=16$.

#v(0.05cm)

#text(
weight:"bold",
)[
6. Comparer deux puissances
]

Compare :
$(-3)^2$
et
$(-3)^3$.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On calcule :
$(-3)^2=9$
et :
$(-3)^3=-27$.

Donc :
$(-3)^2>(-3)^3$.

#v(0.05cm)

#text(
weight:"bold",
)[
7. Utiliser le produit de puissances
]

Une expression météorologique simplifiée est :

$(-2)^3×(-2)^2$. 
Réduis cette expression à une seule puissance puis calcule-la.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Les deux puissances ont la même base.

Donc :
$(-2)^3×(-2)^2=(-2)^(3+2)$.

Ainsi :
$(-2)^3×(-2)^2=(-2)^5$.

Donc :
$(-2)^5=-32$.

#v(0.05cm)

#text(
weight:"bold",
)[
8. Utiliser une puissance d'une puissance
]

Calcule :
$((-2)^2)^3$.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On applique la règle :
$((-2)^2)^3=(-2)^(2×3)$.

Donc :
$((-2)^2)^3=(-2)^6$.

L'exposant est pair.

Ainsi :
$(-2)^6=64$.

#v(0.05cm)

#text(
weight:"bold",
)[
9. Calculer une expression complète
]

Une modélisation simplifiée donne :

$-5+(-2)^3×4$.

Calcule cette expression en respectant les priorités de calcul.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On calcule d'abord la puissance :
$(-2)^3=-8$.

Puis :
$-8×4=-32$.

Enfin :
$-5+(-32)=-37$.

Donc :
$-5+(-2)^3×4=-37$.

#v(0.05cm)

#text(
weight:"bold",
)[
10. Interpréter un relevé météorologique
]

Une station relève les températures suivantes au cours d'une journée :

$-6°C$, $-2°C$, $+3°C$, $+1°C$, $-4°C$.

a) Quelle est la température minimale ?

b) Quelle est la température maximale ?

c) De combien la température a-t-elle augmenté entre $-6°C$ et $+3°C$ ?

d) De combien a-t-elle diminué entre $+3°C$ et $-4°C$ ?

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

a) La température minimale est $-6°C$.

b) La température maximale est $+3°C$.

c) La variation est :
$+3-(-6)=+9$.

La température a augmenté de $9°C$.

d) La variation est :
$-4-(+3)=-7$.

La température a diminué de $7°C$.
]





#v(1cm)


// ==========================================================
// RÉINVESTISSEMENT — ANALYSER UN RELEVÉ MÉTÉOROLOGIQUE
// ==========================================================

#exemple_resolu[

#text(
size: 13pt,
weight: "bold",
fill: code-blue,
)[
🌦️ Réinvestissement — Étudier l'évolution de la température
]

#v(0.2cm)

Une station météorologique automatique effectue des relevés horaires pendant une journée d'hiver.

À $6$ h, la température est de :
$-5°C$.

À $10$ h, elle est de :
$+1°C$.

À $14$ h, elle atteint :
$+6°C$.

À $20$ h, elle redescend à :
$-2°C$.

On souhaite analyser mathématiquement cette évolution.

#v(0.05cm)

#text(
weight:"bold",
)[
1. Déterminer l'évolution entre 6 h et 10 h
]

La température passe de $-5°C$ à $+1°C$.

La variation est :
$+1-(-5)$.

Donc :
$+1+5=+6$.

La température a augmenté de $6°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
2. Déterminer l'évolution entre 10 h et 14 h
]

La température passe de $+1°C$ à $+6°C$.

La variation est :
$+6-(+1)=+5$.

La température a donc encore augmenté de $5°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
3. Déterminer l'évolution entre 14 h et 20 h
]

La température passe de $+6°C$ à $-2°C$.

La variation est :
$-2-(+6)$.

Donc :
$-2-6=-8$.

La température a diminué de $8°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
4. Déterminer l'amplitude thermique de la journée
]

L'amplitude thermique correspond ici à l'écart entre la température maximale et la température minimale.

La température maximale est :
$+6°C$.

La température minimale est :
$-5°C$.

L'écart est :
$+6-(-5)$.

Donc :
$6+5=11$.

L'amplitude thermique de la journée est donc de :

#strong[$11°C$].

#v(0.3cm)

#text(
weight:"bold",
)[
5. Modéliser une baisse régulière
]

Supposons que pendant $4$ heures, la température diminue de $2\,°C$ chaque heure.

La variation totale peut être représentée par :

$4×(-2)$.

Donc :
$4×(-2)=-8$.

Une diminution régulière de $2°C$ par heure pendant $4$ heures correspond donc à une baisse totale de $8°C$.

#v(0.05cm)

#text(
weight:"bold",
)[
6. Utiliser une puissance
]

Une modélisation informatique utilisée pour analyser les données météorologiques fait apparaître la répétition :

$(-2)×(-2)×(-2)$.

Écris cette répétition sous forme de puissance et calcule-la.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Le facteur $-2$ apparaît trois fois.

On écrit donc :
$(-2)^3$.

Comme l'exposant est impair :
$(-2)^3=-8$.

#v(0.05cm)

#text(
weight:"bold",
)[
7. Comparer deux expressions
]

Compare :
$(-2)^4$
et
$(-2)^5$.

#v(0.05cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

On calcule :
$(-2)^4=16$
et :
$(-2)^5=-32$.

Donc :
$(-2)^4>(-2)^5$.

#v(0.05cm)

#text(
weight:"bold",
)[
8. Utiliser les propriétés des puissances
]

Une expression issue d'une modélisation numérique est :

$(-3)^2×(-3)^4$.

Réduis-la à une seule puissance.

#v(0.12cm)

#text(
weight:"bold",
fill:code-blue,
)[
Solution
]

Les deux puissances ont la même base.

Donc :
$(-3)^2×(-3)^4=(-3)^(2+4)$.

Ainsi :
$(-3)^2×(-3)^4=(-3)^6$.

Comme $6$ est pair :
$(-3)^6=729$.

#v(1cm)

#text(
weight:"bold",
)[
9. Interpréter les mathématiques dans la météorologie
]

Complète :

a) Les nombres ..... permettent notamment de représenter des températures situées au-dessus de $0°C$.#strong[(positifs,négatifs,parité)]

b) Les nombres ..... permettent notamment de représenter des températures situées au-dessous de $0°C$.#strong[(positifs,négatifs,parité)]

c) L'..... permet de représenter deux valeurs situées à la même distance de la référence mais de part et d'autre de celle-ci.#strong[(facteur,opposé,soustraction)]

d) La ..... permet de déterminer une variation entre deux températures.#strong[(facteur,opposé,soustraction)]

e) Le ..... permet notamment de modéliser une même variation répétée plusieurs fois.#strong[(puissance,produit,parité)]

f) Les ..... permettent d'écrire plus simplement un produit dans lequel un même facteur relatif se répète.#strong[(produit,puissance,parité)]

g) Le signe d'une puissance de base négative dépend de la ..... de son exposant.#strong[(positifs,négatifs,parité)]

]


#v(20cm)


// ==========================================================
// SYNTHÈSE
// ==========================================================

#retenir[

#v(0.1cm)

Pour analyser des situations météorologiques faisant intervenir des températures et des variations, je peux :

#v(0.05cm)

🌡️ utiliser les #strong[entiers relatifs] pour représenter des valeurs situées au-dessus ou au-dessous d'une référence ;

#v(0.05cm)

📍 repérer les entiers relatifs sur une #strong[droite graduée] ;

#v(0.05cm)

↔️ déterminer l'#strong[opposé] d'un entier relatif ;

#v(0.05cm)

📊 comparer des températures en utilisant l'ordre des entiers relatifs ;

#v(0.05cm)

➕ effectuer des #strong[additions] d'entiers relatifs ;

#v(0.05cm)

➖ transformer une #strong[soustraction] en addition de l'opposé ;

#v(0.05cm)

✖️ effectuer des #strong[multiplications] d'entiers relatifs en appliquant les règles de signes ;

#v(0.05cm)

➗ effectuer des #strong[divisions] d'entiers relatifs en appliquant les règles de signes ;

#v(0.05cm)

🔢 écrire un produit de facteurs identiques sous forme de #strong[puissance] ;

#v(0.05cm)

⚖️ déterminer le signe d'une puissance en étudiant la #strong[parité de l'exposant] ;

#v(0.05cm)

🧩 utiliser les propriétés du #strong[produit de puissances de même base] ;

#v(0.05cm)

🧮 utiliser la #strong[puissance d'un produit] et la #strong[puissance d'une puissance] ;

#v(0.05cm)

🎯 respecter les #strong[priorités de calcul] dans une expression contenant des puissances ;

#v(0.05cm)

🌦️ et utiliser toutes ces notions pour #strong[analyser et interpréter des relevés météorologiques].
]


#v(5cm)

#remarque[
Les entiers relatifs ne servent donc pas uniquement à effectuer des calculs.

Ils permettent de traduire mathématiquement des situations dans lesquelles une grandeur peut évoluer dans deux directions opposées.

En météorologie, ils permettent notamment de représenter et d'analyser des températures, des variations et des écarts par rapport à une référence.

Les puissances prolongent cette étude en permettant d'exprimer de manière compacte des produits dans lesquels un même facteur relatif se répète.
]


]

























// ==========================================================
// PARCOURS 4e
// ENTIERS RELATIFS ET PUISSANCES DANS L'ÉLECTRONIQUE
// ==========================================================


#parcours(
  [PARCOURS 4ᵉ — Les entiers relatifs et les puissances dans l'électronique],
  "parcours-entiers-relatifs-4e",
) <parcours-entiers-relatifs-4e>


// ==========================================================
// ACTIVITÉ DE DÉCOUVERTE
// ==========================================================

#activite[

  ⚡ À la découverte des signaux électriques

  #v(0.12cm)

  L'électronique est une branche des sciences et des technologies
  qui permet de concevoir des dispositifs capables de
  #strong[produire, mesurer, traiter, amplifier ou transmettre
  des signaux électriques].

  On retrouve l'électronique dans les téléphones, les ordinateurs,
  les téléviseurs, les véhicules, les appareils médicaux,
  les systèmes de communication et les objets connectés.

  Pour étudier un signal électrique, les électroniciens utilisent
  souvent une #strong[tension de référence], notée $0V$.

  Une tension peut alors être située :

  • #strong[au-dessus de la référence] : elle est positive ;

  • #strong[au-dessous de la référence] : elle est négative ;

  • #strong[au niveau de la référence] : elle est nulle.

  Par exemple, un capteur électronique peut fournir successivement
  les valeurs :

  $+5V ; +2V ; 0V ; -2V ; -5V$.

  Ces valeurs indiquent la position du signal par rapport à la
  tension de référence.

  Dans certains circuits, un composant peut également modifier
  l'amplitude d'un signal. Par exemple, un amplificateur peut
  multiplier une tension par un nombre positif, tandis qu'un
  montage inverseur peut multiplier le signal par un nombre négatif
  et ainsi #strong[inverser sa polarité].

  Lorsqu'un signal traverse plusieurs étages électroniques
  successifs, les transformations peuvent se répéter.

  Les mathématiques permettent alors de représenter ces
  transformations à l'aide des #strong[entiers relatifs] et des
  #strong[puissances].

  #v(0.15cm)

  Observe les valeurs suivantes :

  $+5 ; +2 , 0 ; -2 ; -5$

  1. Quelles valeurs sont supérieures à $0$ ?

  2. Quelles valeurs sont inférieures à $0$ ?

  3. Parmi $-2$ et $-5$, laquelle correspond à la valeur la plus basse ?

  4. Que représente le signe $+$ dans une mesure située au-dessus
     de la référence ?

  5. Que représente le signe $-$ dans une mesure située au-dessous
     de la référence ?

]
#activite[
  6. Un montage transforme une tension $-2\,V$ en multipliant sa
     valeur par $-3$. Quelle valeur obtient-on ?

  7. Si un deuxième étage applique encore une multiplication par
     $-3$, que devient le résultat ?

  8. Que remarques-tu lorsque deux transformations successives
     changent le signe du signal ?

  9. Comment pourrais-tu représenter une transformation répétée
     quatre fois par un même facteur ?

  10. Quel outil mathématique permet d'écrire simplement un produit
      dans lequel le même facteur apparaît plusieurs fois ?

  Les circuits électroniques permettent donc d'observer des
  grandeurs situées de part et d'autre d'une référence ainsi que
  des transformations répétées.

  Pour représenter ces situations, les mathématiques utilisent
  les #strong[entiers relatifs] et les #strong[puissances].

  Nous allons maintenant étudier l'ensemble des entiers relatifs
  $ℤ$ et découvrir comment les puissances permettent de représenter
  des transformations répétées dans un système électronique.
]


#v(0.3cm)

#align(center)[
  #image_full("electronique-4e.jpeg")
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

🔢 reconnaître et utiliser les #strong[entiers relatifs] ;

#v(0.05cm)

📍 repérer et comparer des entiers relatifs par rapport à une
#strong[référence] ;

#v(0.05cm)

↔️ déterminer l'#strong[opposé] d'un entier relatif ;

#v(0.05cm)

⚡ interpréter des valeurs positives et négatives dans certaines
situations électroniques ;

#v(0.05cm)

🔢 calculer une #strong[puissance d'un entier relatif] ;

#v(0.05cm)

➕ déterminer le #strong[signe d'une puissance] selon la parité
de son exposant ;

#v(0.05cm)

🧮 utiliser les règles de calcul sur les #strong[produits de
puissances de même base] ;

#v(0.05cm)

🧩 utiliser la #strong[puissance d'un produit] ;

#v(0.05cm)

🔗 utiliser la #strong[puissance d'une puissance] ;

#v(0.05cm)

⚙️ respecter les #strong[priorités de calcul] avec les puissances ;

#v(0.05cm)

⚡ et utiliser ces outils pour analyser des situations simples
de #strong[transformation et de transmission de signaux
électroniques].
]


#v(0.3cm)

#remarque[
L'électronique ne consiste pas seulement à assembler des composants.

Elle permet de #strong[mesurer, transformer, amplifier, filtrer,
commander et transmettre des informations].

Dans ce parcours, les mathématiques vont nous aider à décrire
certaines de ces transformations.
]


#v(0.4cm)
#pagebreak()

// ==========================================================
// PARTIE A — LES ENTIERS RELATIFS
// ==========================================================

#deux-colonnes[


#sous_titre[
LES PUISSANCES D'ENTIERS RELATIFS
]


// ==========================================================
// 6. UNE TRANSFORMATION RÉPÉTÉE
// ==========================================================

#sous_sous_titre[
Une transformation répétée dans un circuit
]

#v(0.15cm)

#definition[
Pour tout entier relatif $a$ et tout entier naturel non nul $n$,
la puissance $a^n$ désigne le produit de $n$ facteurs égaux à $a$ :
$a^n = a × a × ... × a$.

Le nombre $a$ est la #strong[base].

Le nombre $n$ est l'#strong[exposant].
]

#exemple[ 
Dans un circuit électronique, un signal peut traverser plusieurs
étages successifs.

Imaginons qu'un étage multiplie la valeur d'un signal par $-2$.

Si le signal traverse un seul étage, il est multiplié par :
$-2$.

S'il traverse deux étages identiques, il est multiplié par :
$(-2) × (-2)$.

Avec trois étages :
$(-2) × (-2) × (-2)$.

Avec quatre étages :
$(-2) × (-2) × (-2) × (-2)$.

Pour écrire plus simplement ces produits, on utilise les puissances.

Ainsi :
$(-2)^4 = (-2) × (-2) × (-2) × (-2)$.
]

// ==========================================================
// 7. CALCULER UNE PUISSANCE
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Calculer une puissance d'un entier relatif
]

#exemple_resolu[
Un signal traverse trois étages identiques.

Chaque étage multiplie la valeur du signal par $-2$.

Le facteur global est donc :
$(-2)^3$.

Développons :
$(-2)^3=(-2)×(-2)×(-2)$.

Or :
$(-2)×(-2)=4$.

Donc :
$(-2)^3=4×(-2)=-8$.

Le facteur global est donc $-8$.

Cela signifie que le signal a changé de signe et que sa valeur
absolue a été multipliée par $8$.
]


#v(0.05cm)

#exemple[
Calculons :
$(-3)^2$.

On a :
$(-3)^2=(-3)×(-3)=9$.

Donc :
$(-3)^2=9$.
]


#exemple[
Calculons :
$(-3)^4$.

$(-3)^4=(-3)×(-3)×(-3)×(-3)$

$(-3)^4=9×9$

$(-3)^4=81$.

Donc :
$(-3)^4=81$.
]


// ==========================================================
// 8. SIGNE D'UNE PUISSANCE
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Déterminer le signe d'une puissance
]

#v(0.05cm)

Lorsque la base est positive, la puissance est positive.

Lorsque la base est négative, le signe dépend de l'exposant.

#retenir[
Si la base est négative :

• lorsque l'exposant est #strong[pair], la puissance est positive ;

• lorsque l'exposant est #strong[impair], la puissance est négative.
]
#v(5cm)
#exemple[
Dans un montage électronique, chaque étage inverse le signal.

Avec deux étages :
$(-2)^2=4$.

Le signal a subi deux inversions : son signe final est positif.

Avec trois étages :
$(-2)^3=-8$.

Le signal a subi trois inversions : son signe final est négatif.

Avec quatre étages :
$(-2)^4=16$.

Le signal retrouve à nouveau un signe positif.
]

#remarque[
Chaque multiplication par un nombre négatif provoque un changement
de signe.

Ainsi, lorsqu'un facteur négatif est répété :

• un nombre pair de fois donne un signe positif ;

• un nombre impair de fois donne un signe négatif.
]


// ==========================================================
// 9. PUISSANCES PARTICULIÈRES
// ==========================================================

#v(0.35cm)

#sous_sous_titre[
Puissances particulières
]

#definition[
Pour tout entier relatif $a$ :
#strong[$a^1=a$].

Pour tout entier relatif non nul $a$ :
#strong[$a^0=1$.]
]

#exemple[
$(-7)^1=-7$;
$+5^1=5$;
$(-3)^0=1$;
$12^0=1$.
]

#remarque[
Il ne faut pas confondre :
$(-3)^2$
et 
$-3^2$.

En effet :
$(-3)^2=(-3)×(-3)=9$

alors que :
$-3^2=-(3^2)=-9$.

Les parenthèses sont donc essentielles lorsque la base
d'une puissance est négative.
]


// ==========================================================
// 10. PRODUIT DE PUISSANCES DE MÊME BASE
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Produit de puissances de même base
]

#v(0.15cm)

Lorsqu'un signal traverse deux séries successives d'étages
identiques, on peut rencontrer un produit de puissances
de même base.

#retenir[
Pour tout entier relatif $a$ et tous entiers naturels $n$ et $m$ :
#strong[$a^n × a^m = a^(n+m)$.]
]

#exemple_resolu[
Un premier ensemble électronique comporte $3$ étages qui
multiplient chacun un signal par $-2$.

Un second ensemble comporte $2$ étages identiques.

Le facteur global est :
$(-2)^3 × (-2)^2$.

En utilisant la règle :
$(-2)^3 × (-2)^2=(-2)^(3+2)$.

Donc :
$(-2)^3 × (-2)^2=(-2)^5$.

Puis :
$(-2)^5=-32$.

Le signal est donc multiplié globalement par $-32$.
]

#v(0.05cm)

#exemple[
Vérifions directement :

$(-2)^3×(-2)^2$
$=(-8)×4$
$=-32$.

On retrouve bien :
$(-2)^5=-32$.
]


// ==========================================================
// 11. PUISSANCE D'UN PRODUIT
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Puissance d'un produit
]

#v(0.05cm)

Dans certains systèmes, une transformation peut être composée
de plusieurs facteurs.

#retenir[
Pour tous entiers relatifs $a$ et $b$ et tout entier naturel $n$ :
#strong[$(a×b)^n=a^n×b^n$.]
]
#v(2cm)
#exemple_resolu[
Un étage électronique applique une transformation représentée
par le facteur :
$(-2)×3$.

Cette transformation est répétée trois fois.

Le facteur global est :
$((-2)×3)^3$.

On peut utiliser la propriété :
$((-2)×3)^3=(-2)^3×3^3$.

Calculons :
$(-2)^3=-8$
et 
$3^3=27$.

Donc :
$(-2)^3×3^3=-8×27=-216$.

Ainsi :
$((-2)×3)^3=-216$.
]

#v(0.05cm)

#remarque[
Cette propriété permet de séparer les différents facteurs
qui composent une transformation répétée.
]


// ==========================================================
// 12. PUISSANCE D'UNE PUISSANCE
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Puissance d'une puissance
]

#v(0.15cm)

Un système électronique peut être organisé en blocs.

Un premier bloc peut lui-même représenter une transformation
répétée.

#retenir[
Pour tout entier relatif $a$ et tous entiers naturels $n$ et $m$ :
#strong[$(a^n)^m=a^(n×m)$.]
]

#exemple_resolu[
Un bloc électronique applique trois fois une multiplication
par $-2$.

Ce bloc est ensuite utilisé deux fois successivement.

La transformation globale est :
$((-2)^3)^2$.

En utilisant la propriété :
$((-2)^3)^2=(-2)^(3×2)$.

Donc :
$((-2)^3)^2=(-2)^6$.

Or :
$(-2)^6=64$.

La transformation globale correspond donc à un facteur $64$.
]


// ==========================================================
// 13. CALCULER DES PUISSANCES AVEC DES PARENTHÈSES
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
L'importance des parenthèses
]

#v(0.15cm)

Dans les calculs avec les entiers relatifs, les parenthèses
permettent de déterminer précisément la base de la puissance.

#exemple[
Calculons :
$(-4)^2$.

On a :
$(-4)^2=(-4)×(-4)=16$.

Mais :
$-4^2=-(4^2)=-16$.

Les deux écritures ne donnent donc pas le même résultat.
]

#erreur[
Lorsque le nombre négatif est la base de la puissance,
on écrit cette base entre parenthèses.

On écrit 
$(-5)^3$
et non 
$-5^3$
lorsque l'on veut élever $-5$ au cube.
]


// ==========================================================
// 14. PRIORITÉ DES PUISSANCES
// ==========================================================

#v(0.05cm)

#sous_sous_titre[
Priorité des puissances dans les calculs
]

#v(0.05cm)

Dans une expression sans parenthèses, les puissances sont
effectuées avant les multiplications, les divisions,
les additions et les soustractions.

Lorsque des parenthèses sont présentes, on effectue d'abord
les calculs entre parenthèses.

#exemple_resolu[
Un circuit électronique produit un signal dont la valeur est
calculée par :
$3×(-2)^3+5$.

On calcule d'abord la puissance :
$(-2)^3=-8$.

Puis la multiplication :
$3×(-8)=-24$.

Enfin :
$-24+5=-19$.

Donc :
$3×(-2)^3+5=-19$.
]

#v(4cm)

#exemple[
Calculons :
$4+2×(-3)^2$.

D'abord :
$(-3)^2=9$.

Puis :
$2×9=18$.

Enfin :
$4+18=22$.

Donc :
$4+2×(-3)^2=22$.
]


// ==========================================================
// 15. CALCULS AVEC DES PRODUITS DE PUISSANCES
// ==========================================================

#v(0.4cm)

#sous_sous_titre[
Calculs avec les puissances
]

#exemple_resolu[
Un système électronique comporte trois étages qui multiplient
le signal par $-2$, puis deux étages qui multiplient le signal
par $-2$.

Le facteur global est :
$(-2)^3×(-2)^2$.

On peut regrouper les puissances :
$(-2)^3×(-2)^2=(-2)^5$.

Puis :
$(-2)^5=-32$.

Le système produit donc globalement une multiplication
par $-32$.

Comme l'exposant $5$ est impair, le signe final est négatif.
]


// ==========================================================
// PARTIE C — RÉINVESTISSEMENT ÉLECTRONIQUE
// ==========================================================

#v(0.05cm)

#sous_titre[
RÉINVESTISSEMENT — ANALYSER UN SYSTÈME ÉLECTRONIQUE
]

#exercice_resolu[

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
⚡ Mission — Suivre un signal dans un système électronique
]

#v(0.05cm)

Un laboratoire teste un système électronique simplifié.

Le signal d'entrée possède une valeur de :
$+2V$.

Le premier module est un #strong[étage inverseur] : il multiplie
la valeur du signal par $-2$.

Le signal traverse ensuite plusieurs étages identiques.

L'objectif est de déterminer la valeur du signal à différentes
étapes et de comprendre le rôle des signes et des puissances.


// ----------------------------------------------------------
// QUESTION 1
// ----------------------------------------------------------

#v(0.05cm)

#text(
  weight: "bold",
)[
1. Après un premier étage
]

Le signal initial vaut :
$+2V$.

Le premier étage multiplie cette valeur par $-2$.

Calcule la nouvelle valeur du signal.

#v(0.05cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On calcule :
$+2×(-2)=-4$.

Le signal devient donc :
#strong[$-4V$.]

Le signe a changé parce que le facteur $-2$ est négatif.


// ----------------------------------------------------------
// QUESTION 2
// ----------------------------------------------------------

#v(0.05cm)

#text(
  weight: "bold",
)[
2. Après deux étages
]

Le signal traverse maintenant deux étages identiques.

Le facteur global est :
$(-2)^2$.

Calcule la valeur finale du signal.

#v(0.05cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

$(-2)^2=4$.

Le signal initial étant $+2V$ :
$2×4=8$.

La valeur finale est donc :
#strong[$+8V$.]

Deux inversions successives donnent un signe positif.


// ----------------------------------------------------------
// QUESTION 3
// ----------------------------------------------------------

#v(0.05cm)

#text(
  weight: "bold",
)[
3. Après cinq étages
]

Le signal traverse cinq étages identiques.

Le facteur global est :
$(-2)^5$.

Calcule la valeur finale du signal.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

$(-2)^5=-32$.

Donc :
$2×(-32)=-64$.

La valeur finale est :
#strong[$-64V$.]

Comme le nombre d'étages est impair, le signe final est négatif.


// ----------------------------------------------------------
// QUESTION 4
// ----------------------------------------------------------

#v(3cm)

#text(
  weight: "bold",
)[
4. Interpréter le résultat
]

Pourquoi le signal obtenu après cinq étages est-il négatif alors
qu'il était initialement positif ?

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Chaque étage multiplie le signal par $-2$.

Chaque multiplication par un nombre négatif inverse le signe.

Après :

• une inversion, le signe est négatif ;

• deux inversions, le signe redevient positif ;

• trois inversions, il devient négatif ;

• quatre inversions, il redevient positif ;

• cinq inversions, il devient négatif.

Le nombre de facteurs négatifs est donc déterminant.


// ----------------------------------------------------------
// QUESTION 5
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
5. Écrire une transformation répétée
]

Un autre dispositif possède $4$ étages qui multiplient chacun
le signal par $-3$.

Écris le facteur global sous forme de puissance puis calcule-le.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Le facteur $-3$ apparaît quatre fois :
$(-3)^4$.

Donc :

$(-3)^4=(-3)×(-3)×(-3)×(-3)$

$(-3)^4=9×9$

$(-3)^4=81$.

Le facteur global est donc :
#strong[$81$.]


// ----------------------------------------------------------
// QUESTION 6
// ----------------------------------------------------------

#v(0.3cm)

#text(
  weight: "bold",
)[
6. Deux groupes d'étages
]

Un système comporte un premier groupe de $3$ étages
et un second groupe de $4$ étages.

Tous les étages multiplient le signal par $-2$.

Écris le facteur global sous la forme d'un produit
de puissances puis sous la forme d'une seule puissance.

#v(4cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

Le premier groupe donne :
$(-2)^3$.

Le deuxième groupe donne :
$(-2)^4$.

Le facteur global est donc :
$(-2)^3×(-2)^4$.

En utilisant le produit de puissances de même base :

$(-2)^3×(-2)^4=(-2)^(3+4)$.

Donc 
$(-2)^3×(-2)^4=(-2)^7$.

Et 
$(-2)^7=-128$.


// ----------------------------------------------------------
// QUESTION 7
// ----------------------------------------------------------

#v(0.05cm)

#text(
  weight: "bold",
)[
7. Une organisation en blocs
]

Un module électronique réalise une transformation correspondant
à $(-2)^3$.

Ce module est ensuite utilisé deux fois successivement.

Écris la transformation globale sous la forme d'une puissance.

#v(0.05cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

La transformation est :
$((-2)^3)^2$.

En utilisant la puissance d'une puissance :

$((-2)^3)^2=(-2)^(3×2)$.

Donc 
$((-2)^3)^2=(-2)^6$.

Ainsi 
$((-2)^3)^2=64$.


// ----------------------------------------------------------
// QUESTION 8
// ----------------------------------------------------------

#v(0.05cm)

#text(
  weight: "bold",
)[
8. Séparer les facteurs
]

Un dispositif applique à chaque étape une transformation
représentée par :
$(-2)×3$.

Cette transformation est répétée deux fois.

Écris le facteur global sous la forme d'une puissance,
puis utilise la puissance d'un produit.

#v(0.12cm)

#text(
  weight: "bold",
  fill: code-blue,
)[
Solution
]

On écrit :
$((-2)×3)^2$.

Avec la puissance d'un produit :

$((-2)×3)^2=(-2)^2×3^2$.

Donc 
$4×9=36$.

Le facteur global est 
#strong[$36$.]
]


// ==========================================================
// EXERCICE D'APPLICATION
// ==========================================================

#v(5cm)

#exercice[

#mission[
⚙️ Application — Concevoir et analyser un système électronique
]

#v(0.2cm)

Un ingénieur teste un dispositif comportant plusieurs étages
de traitement d'un signal.

Chaque étage peut amplifier ou inverser le signal.

#v(0.2cm)

1. Un signal de $-3V$ traverse un étage qui multiplie sa valeur par $4$. Quelle est la nouvelle valeur du signal ?

2. Un signal de $+5V$ traverse trois étages qui multiplient
chacun sa valeur par $-2$. Écris le calcul sous forme de puissance
puis détermine la valeur finale.

3. Un signal de $-1V$ traverse quatre étages qui multiplient
chacun sa valeur par $-3$. Quelle est sa valeur finale ?

4. Un dispositif comporte $2$ étages dans un premier bloc et
$5$ étages dans un second bloc. Chaque étage multiplie le signal
par $-2$. Écris le facteur global sous la forme d'une seule
puissance.

5. Calcule $(-4)^2$;$(-4)^3$;$(-4)^4$;$(-4)^5$.

Que remarques-tu concernant le signe ?

6. Calcule $(-2)^3×(-2)^4$.

7. Calcule :$((-3)^2)^3$.

8. Calcule :$((-2)×5)^2$.

9. Un signal est multiplié successivement par $-2$; $-2$;$-2$ et $-2$. Le facteur global est-il positif ou négatif ? Justifie.

10. Explique pourquoi un nombre pair d'inversions de polarité fait retrouver au signal son signe initial.

]


// ==========================================================
// À RETENIR
// ==========================================================

#v(2cm)



#retenir[

🎯 #strong[À retenir — Entiers relatifs et puissances]

#v(0.1cm)

Les #strong[entiers relatifs] comprennent les entiers positifs,
les entiers négatifs et $0$ :

$ℤ={...;-3;-2;-1;0;+1;+2;+3;...}$.

#v(0.08cm)

Sur une droite graduée, le nombre situé le plus à droite
est le plus grand.

#v(0.08cm)

L'#strong[opposé] d'un entier relatif possède la même distance
à $0$ mais se situe de l'autre côté de $0$.

#v(0.08cm)

Pour un entier relatif $a$ et un entier naturel non nul $n$ :

$a^n=a×a×...×a$.

#v(0.08cm)

Si la base est négative :

• une puissance d'exposant pair est positive ;

• une puissance d'exposant impair est négative.

#v(0.08cm)

Pour le produit de puissances de même base :

$a^n×a^m=a^(n+m)$.

#v(0.08cm)

Pour la puissance d'un produit :

$(a×b)^n=a^n×b^n$.

#v(0.08cm)

Pour la puissance d'une puissance :

$(a^n)^m=a^(n×m)$.

#v(0.08cm)

Les puissances sont prioritaires sur les multiplications,
divisions, additions et soustractions lorsqu'il n'y a pas
de parenthèses imposant un autre ordre.

#v(0.08cm)

En électronique, ces outils permettent notamment de représenter
des #strong[valeurs situées de part et d'autre d'une référence],
des #strong[inversions de signe] et des #strong[transformations
répétées d'un signal].

]



// ==========================================================
// CE QUE LES MATHÉMATIQUES M'ONT PERMIS DE COMPRENDRE
// ==========================================================

#v(5cm)

#remarque[

⚡ Dans un système électronique, un signal peut être mesuré
par rapport à une valeur de référence.

Une valeur positive peut représenter une situation située
au-dessus de cette référence, tandis qu'une valeur négative
peut représenter une situation située au-dessous.

Lorsqu'un système comporte plusieurs transformations successives,
les mathématiques permettent de représenter leur effet global.

Un facteur négatif peut représenter une inversion de signe,
et une puissance permet de représenter la répétition d'une
même transformation.

Ainsi, les mathématiques permettent à l'électronicien de
#strong[modéliser et prévoir le comportement d'un système]
avant même de réaliser physiquement le circuit.
]


// ==========================================================
// OUVERTURE
// ==========================================================

#v(0.4cm)

#text(
  size: 13pt,
  weight: "bold",
  fill: code-blue,
)[
🔭 Pour aller plus loin
]

#v(0.12cm)

Les systèmes électroniques réels sont beaucoup plus complexes.

Les ingénieurs utilisent notamment les mathématiques pour étudier :

• les tensions et les courants ;

• les signaux analogiques et numériques ;

• les amplificateurs ;

• les filtres électroniques ;

• les capteurs ;

• les systèmes de communication ;

• les microprocesseurs ;

• les circuits de commande.

Les notions étudiées dans ce parcours constituent donc
une première étape vers la #strong[modélisation mathématique
des systèmes électroniques].
]

]






