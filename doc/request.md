### 1. Nombre total d’appartements vendus au 1er semestre 2020

``` sql
SELECT COUNT(*) FROM vente v
LEFT JOIN bien b ON b.id = v.id_bien
WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-03-30' 
AND b.type_local = 'Appartement'
```

COUNT(*) 	
15259


### 2 .Le nombre de ventes d’appartement par région pour le 1er semestre 2020

``` sql
SELECT r.nom_region, COUNT(b.id) AS 'Vente appartements' FROM bien b
JOIN commune c ON c.id = b.id_com
JOIN departement d ON d.id = c.id_dep
JOIN region r ON r.id = d.id_reg
JOIN vente v ON v.id_bien = b.id
WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-05-31'
AND b.type_local = 'Appartement'
GROUP BY r.nom_region
```

nom_region 	                    Vente appartements 	
Auvergne-RhÃ´ne-Alpes 	        2373
ÃŽle-de-France 	                10768
Bourgogne-Franche-ComtÃ© 	    298
Bretagne 	                    774
Centre-Val de Loire 	        535
Corse 	                        188
Grand Est 	                    679
Hauts-de-France 	            888
Normandie 	                    650
Nouvelle-Aquitaine 	            1544
Occitanie               	    1288
Pays de la Loire        	    1030
Provence-Alpes-CÃ´te d'Azur 	1816


### 3. Proportion des ventes d’appartements par le nombre de pièces

``` sql
SELECT COUNT(*) as 'Nb appart', b.total_piece FROM vente v
LEFT JOIN bien b ON b.id = v.id_bien
WHERE b.type_local = 'Appartement'
GROUP BY b.total_piece
```
Nb appart 	total_piece 	
30 	        0
6739 	    1
9783 	    2
8966 	    3
4460 	    4
1114 	    5
204 	    6
54 	        7
17 	        8
8 	        9
2 	        10
1 	        11

### 4. Liste des 10 départements où le prix du mètre carré est le plus élevé

``` sql
SELECT d.nom_dep as 'Nom', v.valeur / b.surface_carrez as prixMetreCarrez FROM departement d
LEFT JOIN commune c ON c.id_dep = d.id
JOIN bien b ON b.id_com = c.id
JOIN vente v ON v.id_bien = b.id
GROUP BY d.nom_dep
ORDER BY prixMetreCarrez DESC
LIMIT 10
```

Nom 	            prixMetreCarrez  	
Val-de-Marne 	    13761.468371521429
Corse-du-Sud 	    13608.13170291455
Paris 	            13401.655055296944
Yvelines 	        7419.383184597469
Seine-Saint-Denis 	6532.1424305396795
Hauts-de-Seine 	    6496.950568765205
Ille-et-Vilaine 	6411.39786673167
Nord 	            5492.813270760286
Savoie 	            5124.734898767288
Gard 	            4924.242495395812


### 5. Prix moyen du mètre carré d’une maison en Île-de-France

``` sql
SELECT r.nom_region as 'Nom', AVG(v.valeur / b.surface_carrez) as AVGprixMetreCarrez FROM departement d
LEFT JOIN commune c ON c.id_dep = d.id
JOIN bien b ON b.id_com = c.id
JOIN vente v ON v.id_bien = b.id
JOIN region r ON r.id = d.id_reg

WHERE r.nom_region = 'ÃŽle-de-France'
GROUP BY r.nom_region
```

Nom 	AVGprixMetreCarrez 	
ÃŽle-de-France 	6997.256875973556


### 6. Liste des 10 appartements les plus chers avec le département et le nombre de mètres carrés

``` sql
SELECT b.id as 'Id Appart ', d.nom_dep, v.valeur  as 'Valeur', b.surface_carrez  FROM departement d
LEFT JOIN commune c ON c.id_dep = d.id
JOIN bien b ON b.id_com = c.id
JOIN vente v ON v.id_bien = b.id
JOIN region r ON r.id = d.id_reg

WHERE b.type_local = "Appartement"
ORDER BY v.valeur DESC
LIMIT 10
```

Id Appart 	    nom_dep     Valeur 	    surface_carrez 	
32274 	        Paris 	    9000000 	9.1
21834 	        Essonne 	8600000 	64
29798 	        Paris 	    8577710 	20.55
32432 	        Paris 	    7620000 	42.77
29849 	        Paris 	    7600000 	253.3
29521 	        Paris 	    7535000 	139.9
31972 	        Paris 	    7420000 	360.95
32134 	        Paris 	    7200000 	595
29352 	        Paris 	    7050000 	122.56
29512 	        Paris 	    6600000 	79.38

### 7. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020


``` sql
SELECT 
	(SELECT COUNT(id) FROM vente
    WHERE date_vente BETWEEN '2020-01-01' AND '2020-03-30') AS firstTrim,
	(SELECT COUNT(id) FROM vente
	WHERE date_vente BETWEEN '2020-04-01' AND '2020-06-30') AS secondTrim,    
	(SELECT (secondTrim - firstTrim) / firstTrim * 100) AS 'Taux évolution'
```

firstTrim 	secondTrim 	Taux évolution 	
16632       17393 	    4.5755


### 8. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020

``` sql
SELECT a.nom_com, a.firstTrim, b.secondTrim, ((b.secondTrim - a.firstTrim) / a.firstTrim * 100) AS Taux_evolution
FROM   (SELECT c.nom_com, COUNT(c.nom_com) as firstTrim FROM commune c
    JOIN bien b ON b.id_com = c.id
    JOIN vente v ON v.id_bien = b.id
    WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-03-30'
    GROUP BY c.nom_com) a
JOIN   (SELECT c.nom_com, COUNT(c.nom_com) as secondTrim FROM commune c
    JOIN bien b ON b.id_com = c.id
    JOIN vente v ON v.id_bien = b.id
    WHERE v.date_vente BETWEEN '2020-04-01' AND '2020-06-30'
    GROUP BY c.nom_com) b ON a.nom_com = b.nom_com
WHERE ((b.secondTrim - a.firstTrim) / a.firstTrim * 100) > 20
ORDER BY Taux_evolution ASC
``` 

Total de 558 lignes trouvées

nom_com 	                firstTrim 	secondTrim 	Taux_evolution Croissant 1 	
Leucate 	                29 	        35 	        20.6897
Ã‰tampes 	                24 	        29 	        20.8333
Villers-sur-Mer 	        33 	        40 	        21.2121
Le Chesnay-Rocquencourt 	14 	        17 	        21.4286
Villejuif 	                23 	        28 	        21.7391
Orly 	                    9 	        11 	        22.2222
Boissy-Saint-LÃ©ger 	    9 	        11 	        22.2222
Saint-Germain-en-Laye 	    35 	        43 	        22.8571
...
Ronchin 	                1 	        9 	        800.0000
Lyon 7e Arrondissement  	7 	        63 	        800.0000
Morlaix 	                1 	        11 	        1000.0000
DÃ©voluy 	                1 	        11 	        1000.0000
L'Isle-sur-la-Sorgue 	    1 	        13 	        1200.0000
Cavaillon 	                1 	        17 	        1600.0000
Lyon 8e Arrondissement  	3 	        53 	        1666.6667
Pau 	                    3 	        78 	        2500.0000


### 9. Liste des communes ayant eu au moins 50 ventes au 1er trimestre 

``` sql
SELECT c.nom_com, COUNT(c.nom_com) as firstTrim FROM commune c
    JOIN bien b ON b.id_com = c.id
    JOIN vente v ON v.id_bien = b.id
    WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-03-30'   
	
GROUP BY c.nom_com
HAVING COUNT(c.nom_com) > 50
ORDER BY firstTrim ASC
```

Total de 47 lignes trouvées

nom_com 	            firstTrim Croissant	
Puteaux 	            52
Ajaccio 	            53
Versailles 	            53
Saint-Maur-des-FossÃ©s 	56
Levallois-Perret 	    58
Toulon 	                58
...

### 10. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces

``` sql 
SELECT 
	(SELECT (SUM(v.valeur) / COUNT(v.id)) / (SUM(b.surface_local) / COUNT(v.id))  FROM vente v
    JOIN bien b ON b.id = v.id_bien
    WHERE b.total_piece = 2
    AND b.type_local = "Appartement") AS moyenMetreCarrez2Pieces,
	(SELECT (SUM(v.valeur) / COUNT(v.id)) / (SUM(b.surface_local) / COUNT(v.id))  FROM vente v
    JOIN bien b ON b.id = v.id_bien
    WHERE b.total_piece = 3
    AND b.type_local = "Appartement") AS moyenMetreCarrez3Pieces,    
	(SELECT (moyenMetreCarrez3Pieces - moyenMetreCarrez2Pieces) / moyenMetreCarrez2Pieces * 100) AS 'Différence'
```

moyenMetreCarrez2Pieces 	moyenMetreCarrez3Pieces 	Différence 	
4763.409396899574 	        4228.2699306492 	        -11.234379026893786 11 


### 11. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69

``` sql
SELECT c.nom_com, d.id, AVG(v.valeur) moyenneFonciere FROM vente v
JOIN bien b ON b.id = v.id_bien
JOIN commune c ON c.id = b.id_com
JOIN departement d ON d.id = c.id_dep
WHERE d.id = 6
OR d.id = 13
OR d.id = 33
OR d.id = 59
OR d.id = 69
GROUP BY c.nom_com
ORDER BY d.id, moyenneFonciere DESC

```