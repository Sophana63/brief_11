### 1. Nombre total d’appartements vendus au 1er semestre 2020

``` sql
SELECT COUNT(*) FROM vente v
LEFT JOIN bien b ON b.id = v.id_bien
WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-03-30' 
AND b.type_local = 'Appartement'
```

COUNT(*) 	
15259


### Proportion des ventes d’appartements par le nombre de pièces.

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

### 3. Proportion des ventes d’appartements par le nombre de pièces

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
SELECT COUNT(v.id) as 'Nb 1 trim', (
    SELECT COUNT(vente.id) FROM vente
    LEFT JOIN bien ON bien.id = vente.id_bien
	WHERE vente.date_vente BETWEEN '2020-04-01' AND '2020-06-30'
    ) as 'Nb 2 Trim', ('Nb 1 trim' - 'Nb 2 trim') as nv
FROM vente v
LEFT JOIN bien b ON b.id = v.id_bien
WHERE v.date_vente BETWEEN '2020-01-01' AND '2020-03-30' 
```