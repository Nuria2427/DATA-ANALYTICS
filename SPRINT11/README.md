# Visualització de Dades amb Python i Power BI
📌 Descripció del projecte

Aquesta pràctica integra l'ús de Python amb les llibreries de visualització Pandas, Matplotlib i Seaborn, així com la seva integració amb Power BI.  
L'objectiu és treballar tot el procés complet: des de la connexió a una base de dades MySQL, l'anàlisi i visualització avançada de dades amb Python, fins a la incorporació d'aquestes visualitzacions en un informe dinàmic a Power BI.

El projecte es divideix en tres nivells de dificultat progressiva.

🛠️ Tecnologies utilitzades

Python 3.11
MySQL Workbench
Pandas
Matplotlib
Seaborn
Power BI Desktop
Connector MySQL / SQLAlchemy

📂 Estructura del projecte
├── data/
│   └── dades_sprint4.sql
├── notebooks/
│   └── visualitzacio_dades.ipynb
├── scripts/
│   └── connexio_mysql.py
├── powerbi/
│   └── informe_visualitzacions.pbix
└── README.md  

## Nivell 1: Connexió i visualització bàsica

1. Connexió a MySQL amb Python
- Connexió a la base de dades del Sprint 4 mitjançant mysql-connector-python o SQLAlchemy.
- Càrrega de les taules necessàries en DataFrames de Pandas.
Aquestes dades s'utilitzen en tots els exercicis posteriors.

2. Visualitzacions requerides

Per a cada cas, s'ha creat una visualització adequada i una interpretació dels resultats:

Una variable numèrica
Exemple: Histograma o Boxplot.

Dues variables numèriques
Exemple: Scatter plot amb línia de tendència.

Una variable categòrica
Exemple: Gràfic de barres.

Una variable categòrica i una numèrica
Exemple: Boxplot o Barplot.

Dues variables categòriques
Exemple: Heatmap de freqüències o gràfic de barres apilades.

Tres variables combinades
Exemple: Scatter plot amb color o mida.

Pairplot
Exploració conjunta de múltiples variables numèriques.

📌 Nota: En cada visualització s'han seleccionat les columnes adequades segons el mètode utilitzat.

## Nivell 2: Anàlisi avançada

1. Correlació entre variables

- Càlcul de la matriu de correlació.
- Representació amb heatmap.
- Interpretació dels valors obtinguts segons les dades del projecte.

2. Jointplot

- Exploració de la relació entre dues variables numèriques.
- Inclou distribucions marginals.
- Interpretació visual i estadística dels resultats.

## Nivell 3: Integració amb Power BI

1. Transferència de visualitzacions a Power BI

- Importació dels DataFrames mitjançant scripts de Python dins de Power BI.
- Reproducció de totes les visualitzacions del Nivell 1 a Power BI.

Consideracions importants

Cada DataFrame inclou: Una columna identificadora única o Una combinació de columnes que garanteixi la unicitat dels registres.

⚠️ Power BI elimina duplicats per defecte; no seguir aquesta pràctica pot provocar pèrdua d'informació.

✅ Resultats

Visualitzacions clares i interpretables.

Anàlisi completa del conjunt de dades.

Informe dinàmic i interactiu a Power BI.



📎 Notes finals

Aquest projecte demostra la integració completa entre bases de dades, Python i eines de BI, simulant un flux de treball real en anàlisi i visualització de dades.
