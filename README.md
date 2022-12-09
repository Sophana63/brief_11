# brief 11 - Ma Base de données Immobilière

Le but de ce brief est retravaillé une base de données déjà existante en plusieurs parties.


## Partie 1
### 1. Préparer le dictionnaire des données
Le dictionnaire a été créé avec le logiciel Excel et exporté en PDF. Il se trouve sur le lien suivant : 
[Data-Dict.pdf](https://github.com/Sophana63/brief_11/blob/master/doc/Data-Dict.pdf) 

### 2. Proposer un modèle conceptuel des données
Le schéma relationnel sera normalisé en 3NF à partir de la base de données.
[MCD.png](https://github.com/Sophana63/brief_11/blob/master/doc/MCD_brief_11.png)

### 3. Mise à jour du MCD simplifié
Voici le nouveau schéma relationnel de la base de données qui donnera lieu à la création des nouvelles tables.
![MCD_new.png](https://github.com/Sophana63/brief_11/blob/master/doc/MCD_bien.jpg)


## Partie 2
### 1. Implémentation de la base de donnée
- J'ai utilisé PhpMyAdmin pour la création de la base de données en mySQL.   
- Pour l'insertion des données, j'ai utilisé Jupyter Notebook. Les librairies utilisées sont pandas, pandasql et mysql.connector
```
!pip install pandas
!pip install -U pandasql
!pip install mysql-connector
```
Lien vers la création de tables : [create_table.sql](https://github.com/Sophana63/brief_11/blob/master/doc/create_table.sql)  
Les fichiers Jupyter pour l'implémentation des données se trouvent à la racine de GitHub

### 2. Demande SQL (requêtes)
- Pour les requêtes, je les ai mis dans un readme. Voici le lien: 
[request.md](https://github.com/Sophana63/brief_11/blob/master/doc/request.md)
