--Zadanie 1

CREATE TABLE klient
(
  customerID  INTEGER NOT NULL
    CONSTRAINT klient_pk PRIMARY KEY,
  name  VARCHAR(25) NOT NULL,
  surname VARCHAR(35) NOT NULL,
  addr_street VARCHAR(45),
  addr_zip  CHAR(5),
  addr_city VARCHAR(45),
  login VARCHAR(14) NOT NULL,
  passwd  VARCHAR(12) NOT NULL
);

CREATE TABLE zamowienia
(
  orderID INTEGER NOT NULL
    CONSTRAINT zamowienia_pk PRIMARY KEY,
  IDcustomer  INTEGER NOT NULL,
  orDATE  DATE
);

ALTER TABLE zamowienia
ADD CONSTRAINT klient_zamowienia_fk
FOREIGN KEY (IDcustomer)
REFERENCES klient (customerID);

CREATE TABLE pozycja
(
  IDproduct INTEGER NOT NULL,
  IDorder INTEGER NOT NULL,
  quantity INTEGER
);

ALTER TABLE pozycja
ADD CONSTRAINT produkt_pozycja_fk
FOREIGN KEY (IDproduct)
REFERENCES produkt (productID);

ALTER TABLE pozycja
ADD CONSTRAINT zamowienia_pozycja_fk
FOREIGN KEY (IDorder)
REFERENCES zamowienia (orderID);

CREATE TABLE produkt
(
  productID INTEGER NOT NULL
    CONSTRAINT produkt_pk PRIMARY KEY,
  name VARCHAR(35) NOT NULL,
  price_net FLOAT NOT NULL,
  price_gross FLOAT NOT NULL,
  description CLOB
);

--Zadanie 2
--1
ALTER TABLE klient 
ADD email VARCHAR(40);

--2
ALTER TABLE klient 
MODIFY addr_zip VARCHAR(7);    
  
ALTER TABLE klient
RENAME COLUMN addr_zip TO addr_postcode;

--3
ALTER TABLE zamowienia
ADD is_in_realization CHAR NOT NULL CHECK (is_in_realization IN ('Y','N'));

--4
ALTER TABLE zamowienia
ADD date_realized TIMESTAMP;

--5
ALTER TABLE zamowienia
ADD realization_status VARCHAR2(20) NOT NULL CHECK (realization_status IN ('New order', 'Order in progress', 'Shipment forwarded', 'Order realized'));

--6
ALTER TABLE produkt
ADD vat_rate INTEGER NOT NULL;

ALTER TABLE produkt
DROP COLUMN price_gross;

ALTER TABLE produkt
ADD price_gross AS (price_net + (price_net * vat_rate)/100);

--7
CREATE INDEX klient_index ON klient(surname, login, email);

--8
CREATE UNIQUE INDEX klient_login_index ON klient(login);


   



