# Sprint 10: Analítica de Dades en Pandas
# Descripció

Aquesta tasca consisteix en realitzar un procés complet de neteja, transformació i anàlisi de dades mitjançant la llibreria Pandas de Python. Partint d’un dataset obtingut d’una enquesta interna a treballadors/es, l’objectiu és garantir una correcta manipulació de les dades i generar resultats útils per a l’empresa.

La tasca està dividida en tres nivells:

Nivell 1: neteja i transformació de dades

Nivell 2: actualitzacions, increments i exportació de fitxers

Nivell 3: exercicis avançats de visualització automatitzada i resolució heurística d’una ruta òptima

🧩 Requisits

Python 3.x

Llibreries necessàries:

pandas
numpy
seaborn
matplotlib
openpyxl     # per llegir/escriure Excel


Arxius proporcionats:

sprint10.xlsx

matriu_distancies.xlsx

# Nivell 1 — Neteja i preparació del dataset

## Importació i ordenació

Importar el fitxer sprint10.xlsx com a DataFrame.

Assegurar la importació correcta sense modificar l’arxiu original.

Ordenar per país d’origen i, en cas d’empat, per ciutat.

Mostrar les 10 primeres files.

Validar que el DNI té valors únics.

## Creació i transformació de columnes

Crear columna de Nom Complet (nom + cognoms).

Crear columna per indicar si la persona és nascuda a Espanya.

Posar el DNI com a índex.

Renombrar:

Dia de Naixement → Dia

Mes de Naixement → Mes

Any de Naixement → Any

Substituir valors de gènere:

H → Home

D → Dona

A → Altres

NC → Nan/null

Mostrar tots els canvis en una sola taula final.

## Unificar columnes : Fills / No Fills

Combinar les columnes Fills i No Fills en una nova columna única Fills.

Utilitzar .apply() amb una funció personalitzada.

La nova columna ha de contenir: "Sí" o "No".

## Taula resum per gènere

Crear un DataFrame que mostri:

Sou mitjà

Sou mediana

Sou mínim

Sou màxim

I ordenar-lo pel sou mitjà.

## Taula pivot amb salari mitjà

Files: gènere

Columnes: país d'origen

Valors: salari mitjà

Afegir mitjanes als marges.

(Extra) Aplicar format condicional per ressaltar valors elevats.

## Data de naixement i edat actual

Crear columna datetime a partir de: Dia, Mes, Any.

Crear una funció que calculi l’edat actual.

Afegir columna amb l’edat de cada persona.


# Nivell 2 — Increments i exportacions
## Afegir increments salarials

Treballar amb el DataFrame:

df_increment = pd.DataFrame({
    "Grup":["Grup A","Grup B","Grup C","Grup D"],
    "Increment":["5%","3,5%","2%","8%"]
})


Accions:

Afegir la columna Increment al DataFrame principal.

Convertir els increments a percentatges numèrics.

Actualitzar el salari aplicant l’increment corresponent via codi (no manual).

## Exportació automatitzada per grups

Crear un fitxer .xlsx o .csv per a cada grup professional:
Exemple: dades_GrupA.xlsx

Crear un fitxer final amb:

Nombre de treballadors per grup

Sou mitjà

Edat mediana


# Nivell 3 — Exercicis avançats
## Funció automàtica de gràfics

Crear una funció que:

Rebi qualsevol DataFrame.

Generi i exporti un gràfic per a cada columna:

Numèrica → histograma o boxplot

Categòrica → barres de freqüència

Dates → barres per anys

Provar amb datasets de seaborn (iris, penguins, titanic).

## Ruta més curta entre ciutats (heurística)

Carregar matriu_distancies.xlsx com a DataFrame.

Usar noms de files i columnes com a ciutats.

Eliminar ciutats no accessibles per carretera:

Las Palmas de Gran Canaria

Palma

Crear una funció que:

Rebi la matriu i la ciutat d’origen.

Apliqui l’estratègia heuristicà: anar sempre a la ciutat no visitada més propera.

Retorni:

L’ordre de la ruta

La distància total

(Extra) Determinar quina ciutat produeix la ruta més curta amb la mateixa heurística.

🏁 Resultats esperats

Dataset inicial completament net i estructurat.

Informes salarials clars.

Fitxers exportats automàticament.

Gràfics generats segons tipus de dada.

Una aproximació funcional a un problema típic de "travelling salesman".

📂 Estructura recomanada del projecte
project/
│── data/
│   ├── sprint10.xlsx
│   ├── matriu_distancies.xlsx
│── output/
│   ├── dades_GrupA.xlsx
│   ├── dades_GrupB.xlsx
│   ├── ...
│   ├── resum_grups.xlsx
│── plots/
│── main.ipynb
│── README.md
