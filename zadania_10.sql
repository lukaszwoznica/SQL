--1
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE dept CASCADE CONSTRAINTS;
DROP TABLE emp CASCADE CONSTRAINTS;
DROP TABLE image CASCADE CONSTRAINTS;
DROP TABLE inventory CASCADE CONSTRAINTS;
DROP TABLE item CASCADE CONSTRAINTS;
DROP TABLE klient CASCADE CONSTRAINTS;
DROP TABLE longtext CASCADE CONSTRAINTS;
DROP TABLE ord CASCADE CONSTRAINTS;
DROP TABLE pozycja CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE produkt CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;
DROP TABLE title CASCADE CONSTRAINTS;
DROP TABLE warehouse CASCADE CONSTRAINTS;
DROP TABLE zamowienia CASCADE CONSTRAINTS;

--2
CREATE TABLE Gatunek
  (
    gatunek_id NUMBER (7) NOT NULL ,
    nazwa      VARCHAR2 (30) NOT NULL ,
    opis CLOB
  )
  LOGGING ;
ALTER TABLE Gatunek ADD CONSTRAINT Gatunek_PK PRIMARY KEY ( gatunek_id ) ;


CREATE TABLE Gra
  (
    id            NUMBER (7) NOT NULL ,
    tytul         VARCHAR2 (50) NOT NULL ,
    data_premiery DATE ,
    opis CLOB ,
    cena                   NUMBER (5,2) ,
    Wydawca_wydawca_id     NUMBER (7) NOT NULL ,
    Producent_producent_id NUMBER (7) NOT NULL ,
    Gatunek_gatunek_id     NUMBER (7) NOT NULL
  )
  LOGGING ;
ALTER TABLE Gra ADD CONSTRAINT Gra_PK PRIMARY KEY ( id ) ;


CREATE TABLE Producent
  (
    producent_id   NUMBER (7) NOT NULL ,
    nazwa          VARCHAR2 (30) NOT NULL ,
    data_zalozenia DATE ,
    panstwo        VARCHAR2 (30)
  )
  LOGGING ;
ALTER TABLE Producent ADD CONSTRAINT Producent_PK PRIMARY KEY ( producent_id ) ;


CREATE TABLE Wydawca
  (
    wydawca_id     NUMBER (7) NOT NULL ,
    nazwa          VARCHAR2 (30) NOT NULL ,
    data_zalozenia DATE ,
    panstwo        VARCHAR2 (30)
  )
  LOGGING ;
ALTER TABLE Wydawca ADD CONSTRAINT Wydawca_PK PRIMARY KEY ( wydawca_id ) ;


ALTER TABLE Gra ADD CONSTRAINT Gra_Gatunek_FK FOREIGN KEY ( Gatunek_gatunek_id ) REFERENCES Gatunek ( gatunek_id ) NOT DEFERRABLE ;

ALTER TABLE Gra ADD CONSTRAINT Gra_Producent_FK FOREIGN KEY ( Producent_producent_id ) REFERENCES Producent ( producent_id ) NOT DEFERRABLE ;

ALTER TABLE Gra ADD CONSTRAINT Gra_Wydawca_FK FOREIGN KEY ( Wydawca_wydawca_id ) REFERENCES Wydawca ( wydawca_id ) NOT DEFERRABLE ;

--3
SELECT
  table_name "Nazwa tabeli"
FROM 
  user_tables;
  
--4
SELECT
  table_name,
  column_name,
  data_type,
  data_length,
  data_precision,
  nullable
FROM
  user_tab_cols;

--5
SELECT *
FROM
  user_constraints
WHERE
  table_name = 'GATUNEK' OR
  table_name = 'GRA' OR
  table_name = 'PRODUCENT' OR
  table_name = 'WYDAWCA';
  
  
--6
CREATE TABLE Recenzja
(
  recenzja_id NUMBER (7) NOT NULL 
    CONSTRAINT Recenzja_PK PRIMARY KEY,
  gra_id NUMBER (7) NOT NULL,
  tekst_recenzji CLOB,
  ocena NUMBER (2) CHECK (ocena IN (1,2,3,4,5,6,7,8,9,10))
);

-- Metoda ALTER
ALTER TABLE recenzja
ADD CONSTRAINT recenzja_gra_fk  
FOREIGN KEY  (gra_id) 
REFERENCES gra (id); 

-- Metoda kolumnowa
CREATE TABLE recenzja
(
  recenzja_id NUMBER (7) NOT NULL 
    CONSTRAINT recenzja_PK PRIMARY KEY,
  gra_id NUMBER (7) NOT NULL,
      CONSTRAINT recenzja_gra_fk
      REFERENCES gra (id), 
  tekst_recenzji CLOB,
  ocena NUMBER (2) CHECK (ocena IN (1,2,3,4,5,6,7,8,9,10))
);

-- Metoda tablicowa
CREATE TABLE recenzja
(
  recenzja_id NUMBER (7) NOT NULL 
    CONSTRAINT recenzja_PK PRIMARY KEY,
  gra_id NUMBER (7) NOT NULL,
  tekst_recenzji CLOB,
  ocena NUMBER (2) CHECK (ocena IN (1,2,3,4,5,6,7,8,9,10)),
  CONSTRAINT recenzja_gra_fk 
  FOREIGN KEY  (gra_id) 
  REFERENCES gra (id)
);

--7
ALTER TABLE recenzja
ADD CONSTRAINT recenzja_gra_id_fk 
FOREIGN KEY (gra_id) 
REFERENCES recenzja (recenzja_id); 

--8
INSERT INTO gatunek VALUES (1, 'Akcji', 'Gatunek gier komputerowych, w których ca³a rozgrywka polega w g³ównej mierze na szybkoœci akcji, której gracz jest uczestnikiem oraz na refleksie gracza');
INSERT INTO gatunek VALUES (2, 'Sportowa', 'gatunek gier komputerowych, których tematyk¹ s¹ dyscypliny sportowe zwi¹zane z aktywnoœci¹ fizyczn¹');
INSERT INTO gatunek VALUES (3, 'Wyœcigowa', 'gatunek gier komputerowych polegaj¹cy na œciganiu siê pojazdami z przeciwnikami sterowanymi przez komputer lub z osob¹ lub osobami siedz¹cym obok, b¹dŸ przez sieci Internet');
INSERT INTO gatunek VALUES (4, 'Strategiczna', 'gatunek gier komputerowych, w których zwyciêstwo wymaga przede wszystkim umiejêtnoœci myœlenia i planowania');
    
INSERT INTO producent VALUES (1, 'Electronic Arts', TO_DATE('28-05-1982','dd-mm-yyyy'), 'USA');
INSERT INTO producent VALUES (2, 'Ubisoft', TO_DATE('1986','yyyy'), 'Francja');
INSERT INTO producent VALUES (3, 'Ghost Games', TO_DATE('2011','yyyy'), 'Szwecja');

INSERT INTO wydawca VALUES (1, 'Electronic Arts', TO_DATE('28-05-1982','dd-mm-yyyy'), 'USA');
INSERT INTO wydawca VALUES (2, 'Ubisoft', TO_DATE('1986','yyyy'), 'Francja');

INSERT INTO gra VALUES (1, 'FIFA 17', TO_DATE('27-09-2016','dd-mm-yyyy'), NULL, '150', 1, 1, 2);
INSERT INTO gra VALUES (2, 'Far Cry 4', TO_DATE('18-11-2014','dd-mm-yyyy'), NULL, '99', 2, 2, 1);
INSERT INTO gra VALUES (3, 'Need For Speed', TO_DATE('15-03-2016','dd-mm-yyyy'), NULL, '120', 1, 3, 3);

INSERT INTO recenzja VALUES (1, 1, 'FIFA 17 daje masê satysfakcji i radoœci. To kolejny solidny produkt – lepszy, ciekawszy i fajniejszy od ubieg³orocznego. Czy gra jest lepsza od PES-a? Na PC na pewno, bo Konami kolejny rok z rzêdu traktuje komputerowych graczy po macoszemu. Na konsolach wybór nie jest ju¿ taki oczywisty.', 8);

--9
SELECT * FROM gra;

--10
UPDATE 
  gra
SET 
  opis = 'Komputerowa gra sportowa podejmuj¹ca tematykê pi³ki no¿nej, stworzona przez studio EA Sports. Jest to dwudziesta czwarta czêœæ pi³karskiej serii FIFA'
WHERE
  id = 1;

--11
SELECT * FROM gra;

--12
CREATE TABLE dept 
(id                         NUMBER(7) 
   CONSTRAINT dept_id_nn NOT NULL,
 name                       VARCHAR2(25) 
   CONSTRAINT dept_name_nn NOT NULL,
 region_id                  NUMBER(7),
     CONSTRAINT dept_id_pk PRIMARY KEY (id),
     CONSTRAINT dept_name_region_id_uk UNIQUE (name, region_id));

INSERT INTO dept VALUES (
   10, 'Finance', 1);
INSERT INTO dept VALUES (
   31, 'Sales', 1);
INSERT INTO dept VALUES (
   32, 'Sales', 2);
INSERT INTO dept VALUES (
   33, 'Sales', 3);
INSERT INTO dept VALUES (
   34, 'Sales', 4);
INSERT INTO dept VALUES (
   35, 'Sales', 5);
INSERT INTO dept VALUES (
   41, 'Operations', 1);
INSERT INTO dept VALUES (
   42, 'Operations', 2);
INSERT INTO dept VALUES (
   43, 'Operations', 3);
INSERT INTO dept VALUES (
   44, 'Operations', 4);
INSERT INTO dept VALUES (
   45, 'Operations', 5);
INSERT INTO dept VALUES (
   50, 'Administration', 1);
COMMIT;

--13
INSERT INTO wydawca (wydawca_id, nazwa)
SELECT id, name
FROM dept; 

--14
SELECT * FROM wydawca;