--1
/*
COMMIT - polecenie to pozwala na zatwierdzenie tymczasowo wprowadzonych zmian i wprowadza je o bazy danych na stale.
ROLLBACK - umoøliwia anulowanie wprowadzonych tymczasowych zmian, ktÛre jeszcze nie zostaly  zatwierdzone poleceniem COMMIT.
SAVEPOINT - pozwala tworzyÊ punkty przywracania danych, do ktÛrych moøna wrÛciÊ poleceniem ROLLBACK.
*/

--2
SET AUTOCOMMIT OFF;

--3
INSERT INTO 
  emp (id, first_name, last_name)
VALUES
  (100, 'Jan', 'Kowalski');

COMMIT;

--4
INSERT INTO
  emp (id, first_name, last_name, start_date, salary)
VALUES 
  (101, '£ukasz', 'Woünica', SYSDATE, 2000);
  
SELECT * FROM emp WHERE id = 101;

ROLLBACK;

SELECT * FROM emp WHERE id = 101;

--5
INSERT INTO
  emp (id, first_name, last_name, start_date, salary)
VALUES 
  (101, '£ukasz', 'Woünica', SYSDATE, 2000);
  
COMMIT;

--6
UPDATE
  product
SET
  suggested_whlsl_price = suggested_whlsl_price*1.15;
  
SAVEPOINT S1;

SELECT 
  SUM(suggested_whlsl_price)
FROM
  product;
  
UPDATE
  product
SET
  suggested_whlsl_price = suggested_whlsl_price*1.10;
  
SAVEPOINT S2;

SELECT
  SUM(suggested_whlsl_price)
FROM
  product;
  
UPDATE
  product
SET
  suggested_whlsl_price = suggested_whlsl_price*1.60;
  
SELECT
  SUM(suggested_whlsl_price)
FROM
  product;
  
ROLLBACK TO SAVEPOINT S2;
  
SELECT
  SUM(suggested_whlsl_price)
FROM
  product;
  
ROLLBACK TO SAVEPOINT S1;

SELECT
  SUM(suggested_whlsl_price)
FROM
  product;
  
COMMIT;
  
--7
SET AUTOCOMMIT ON;

--8
CREATE TABLE region_kopia(
  id NUMBER(7),
  name VARCHAR2(50)
);

INSERT INTO region_kopia
  SELECT * FROM region;

--9
INSERT INTO dept
  SELECT id*100, SUBSTR(name, 1, 4), region_id FROM dept;
  
SELECT * FROM dept;

--10
INSERT INTO region_kopia (name)
  SELECT
    customer.name
  FROM
    customer, ord
  WHERE
    customer.id = ord.customer_id AND
    ord.total > 1000;
    
SELECT * FROM region_kopia;

--11
UPDATE
  emp
SET
  salary = salary*4,
  start_date = TO_DATE('31-12-2001', 'dd-mm-yyyy')
WHERE
  last_name = 'Woünica';

--12
UPDATE
  product
SET
  suggested_whlsl_price = suggested_whlsl_price*0.90
WHERE
  id IN (
    SELECT product_id
    FROM inventory
    WHERE max_in_stock - amount_in_stock < 30
  );

UPDATE
  product
SET
  suggested_whlsl_price = suggested_whlsl_price*1.08
WHERE
  id IN(
    SELECT 
      product_id
    FROM 
      (SELECT product_id, max_in_stock - amount_in_stock FROM inventory ORDER BY 2 DESC) 
    WHERE ROWNUM <=5
);

--13
UPDATE
  emp
SET
  salary = salary*1.30
WHERE
  title LIKE 'VP%';
  
--14
DELETE FROM emp
WHERE 
  last_name LIKE 'Kowalski' OR
  last_name LIKE 'Woünica';

--15
DROP TABLE region_kopia;