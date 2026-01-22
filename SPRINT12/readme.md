# Consum i exploració d’APIs REST amb Python

## Descripció

En aquest projecte aplicaràs els coneixements adquirits sobre APIs REST, mètodes HTTP i codis d’estat, utilitzant diferents APIs públiques per consultar dades, filtrar-les i finalment desar-les en un DataFrame de pandas.

Tot el treball es desenvolupa dins d’un Jupyter Notebook, fent ús principalment de la llibreria requests de Python.

## Recursos utilitzats

**Nivell 1**: JSONPlaceholder ({JSON} Placeholder)

**Nivell 2**: Repositori de APIs públiques (Try Public APIs for free)

**Nivell 3**: Open Data Barcelona (Open Data BCN)



## Requisits

Per executar correctament el notebook cal disposar de:

Python 3.8 o superior

Jupyter Notebook o JupyterLab

Llibreries Python:

requests

pandas

Instal·lació de dependències:

pip install requests pandas
Estructura del projecte


## Nivell 1 
**– Exploració bàsica amb una API de laboratori**

Utilitzant l’API pública JSONPlaceholder, es realitzen els següents exercicis:

Peticions GET per obtenir:

Llista de publicacions (/posts)

Llista d’usuaris (/users)

Llista de tasques (/todos)

Visualització per pantalla de:

Quantitat total d’elements de cada recurs

Codi d’estat HTTP de cada petició

Petició a un recurs inexistent per provocar un error 404 i mostrar-ne el codi d’estat.

Petició POST per crear una publicació fictícia, incloent:

Títol

Cos del missatge

userId

Es mostra la resposta JSON i el codi d’estat.

Petició PATCH per modificar parcialment una publicació existent.

Es mostra la resposta JSON

Es mostra el codi d’estat

Petició DELETE sobre una publicació.

Es mostra la resposta JSON

Es mostra el codi d’estat

## Nivell 2 
**– Interacció amb una API pública real**

Exploració del repositori Public APIs i selecció d’una API que permeti peticions GET.

Anàlisi de la documentació de l’API seleccionada:

Identificació d’almenys dos endpoints diferents (documentats en markdown).

Revisió de filtres o paràmetres opcionals disponibles.

Verificació que la resposta sigui en format JSON.

Execució d’una petició GET:

Mostra del codi d’estat

Impressió clara d’alguns camps rellevants de la resposta JSON

Conversió de la resposta a un DataFrame de pandas:

Visualització de les primeres files del DataFrame

##Nivell 3 
**– API d’Open Data Barcelona**

Ús de l’API d’Open Data BCN per cercar datasets mitjançant:

package_search

package_show

Selecció d’un dataset que contingui recursos en format CSV o JSON.

Obtenció del resource_id i realització d’una consulta amb datastore_search per:

Recuperar almenys 100 registres

Conversió dels resultats a un DataFrame de pandas.

Desar el DataFrame obtingut en un fitxer .csv.



**Notes**

Les APIs utilitzades són públiques i no requereixen autenticació.

JSONPlaceholder és una API de proves; les dades no són reals.
