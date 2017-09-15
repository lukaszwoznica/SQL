--1
SELECT
  id "NR ZAMÓWIENIA",
  total "WARTOŒÆ"
FROM
  ord
WHERE
  total = (SELECT MAX(total) FROM ord);
  
--2
SELECT
  id "NUMER",
  date_ordered "DATA ZAMÓWIENIA",
  date_shipped "DATA REALIZACJI",
  total "WARTOŒÆ"
FROM
  ord
WHERE
  payment_type = 'CASH' AND
  total = (SELECT MIN(total) FROM ord);

--3
SELECT
  id "NUMER",
  date_ordered "DATA ZAMÓWIENIA",
  date_shipped "DATA REALIZACJI",
  total "WARTOŒÆ"
FROM
  ord
WHERE
  total > (SELECT AVG(total) FROM ord);
  
--4
SELECT
  name "NAZWA",
  suggested_whlsl_price "CENA"
FROM
  product
WHERE
  suggested_whlsl_price < (SELECT AVG(suggested_whlsl_price) FROM product WHERE name LIKE 'Prostar%');
  
--5
SELECT
  warehouse_id "NR MAGAZYNU",
  product_id "NR PRODUKTU",
  amount_in_stock "LICZBA PROUKTÓW"
FROM
  inventory
WHERE
  (warehouse_id, amount_in_stock) IN (SELECT warehouse_id, MAX(amount_in_stock) FROM inventory GROUP BY warehouse_id);

-- Informacja o magazynie 301 pojawia siê dwukrotnie, poniewa¿ s¹ dwa produkty których jest najwiêcej w magazynie.

--6
SELECT
  warehouse_id "NR MAGAZYNU",
  product_id "NR PRODUKTU",
  amount_in_stock "LICZBA PROUKTÓW"
FROM
  inventory I1
WHERE
  amount_in_stock IN (SELECT MAX(amount_in_stock) FROM inventory I2 WHERE I1.warehouse_id = I2.warehouse_id);
  
--7  
SELECT
  warehouse.city "MIASTO",
  product.name "NAZWA PRODUKTU",
  amount_in_stock "LICZBA PROUKTÓW"
FROM
  inventory I1, product, warehouse
WHERE
  I1.product_id = product.id AND
  I1.warehouse_id = warehouse.id AND
  amount_in_stock IN (SELECT MAX(amount_in_stock) FROM inventory I2 WHERE I1.warehouse_id = I2.warehouse_id);
  
--8
SELECT
  name "NAZWA"
FROM
  customer
WHERE 
  NOT EXISTS (SELECT * FROM ord WHERE customer.id = ord.customer_id);
  
--9
SELECT
  customer.id "NR KLIENTA",
  customer.name "NAZWA",
  ord.id "NR ZAMÓWIENIA"
FROM
  customer, ord
WHERE 
  customer.id = ord.customer_id AND
  EXISTS (SELECT * FROM ord WHERE customer.id = ord.customer_id);

--10
SELECT
  customer_id "NR KLIENTA",
  id "NR ZAMÓWIENIA"
FROM
  ord
ORDER BY
  customer_id;
  
--11  
SELECT 
  last_name "NAZWISKO"
FROM
  emp
WHERE EXISTS (SELECT * FROM ord WHERE ord.sales_rep_id=emp.id AND ord.id < 100);

  
--12
SELECT
  last_name "NAZWISKO"
FROM
  emp, ord
WHERE
  emp.id = ord.sales_rep_id AND
  ord.id < 100;

-- Mo¿na u¿yæ operatora DISTINCT

--13
SELECT
  first_name || ' ' || last_name "IMIÊ I NAZWISKO"
FROM
  emp
WHERE
  EXISTS 
    (SELECT ord.sales_rep_id, COUNT(id) 
    FROM ord
    WHERE ord.sales_rep_id=emp.id 
    GROUP BY ord.sales_rep_id 
    HAVING COUNT(id) >= 4);