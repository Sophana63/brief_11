CREATE DATABASE IF NOT EXISTS valeur_fonciere;
USE valeur_fonciere;


-- Création des tables
--
CREATE TABLE IF NOT EXISTS region (  
  id INT NOT NULL,
  nom_region VARCHAR(50) NOT NULL,
  groupe VARCHAR(16) NOT NULL,
  PRIMARY KEY (id)
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS departement (  
  id VARCHAR(10) NOT NULL,
  nom_dep VARCHAR(50) NOT NULL,
  id_reg INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_reg) REFERENCES region(id)
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS commune (
  id VARCHAR(10) NOT NULL,
  nom_com VARCHAR(50) NOT NULL,
  cp INT(6),  
  population INT(16) NOT NULL,
  id_dep VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_dep) REFERENCES departement(id)
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS bien (  
  id INT NOT NULL,
  num_voie INT(5),
  type_voie VARCHAR(5) NOT NULL,
  voie VARCHAR(50) NOT NULL,
  total_piece INT(5),
  surface_carrez FLOAT(8),
  surface_local INT(16),
  type_local VARCHAR(50) NOT NULL,
  id_com VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_com) REFERENCES commune(id)  
) DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS vente (  
  id INT NOT NULL,
  date_vente DATETIME,
  valeur FLOAT,
  id_bien INT,
  PRIMARY KEY (id),
  FOREIGN KEY (id_bien) REFERENCES bien(id)
) DEFAULT CHARSET=utf8;