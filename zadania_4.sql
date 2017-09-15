--1
SELECT
  credit_rating "ZDOLNOŒÆ KREYTOWA",
  COUNT(credit_rating) "LICZBA KLIENTÓW"
FROM
  customer
GROUP BY
  credit_rating;
  
--2
SELECT
  title "STANOWISKO",
  SUM(salary) "ZAROBKI"
FROM 
  emp
WHERE
  title NOT LIKE 'VP%'
GROUP BY
  title
ORDER BY
  SUM(salary);
  
--3
SELECT
  title "STANOWISKO",
  MAX(salary) "MAKSYMALNE ZAROBKI"
FROM
  emp
GROUP BY
  title;
  
--4
SELECT
  dept.name "NAZWA DEPARTAMENTU",
  AVG(emp.salary) "ŒREDNIE ZAROBKI"
FROM
  dept, emp
WHERE
  dept.id = emp.dept_id 
GROUP BY 
  dept.name
HAVING
  AVG(emp.salary) > 1499;

--5
SELECT
  ord.id "NR",
  customer.name "KLIENT",
  product.name "PRODUKT",
  ord.payment_type "P£ATNOŒÆ",
  TO_CHAR(ord.date_ordered, 'YYYY/MM/DD') "DATA ZAMÓWIENIA",
  item.price "CENA",
  item.quantity "LICZBA"
FROM
  ord, customer, product, item
WHERE
  ord.payment_type = 'CASH' AND
  TO_CHAR(ord.date_ordered, 'MM/YYYY') = '09/1992' AND
  customer.id = ord.customer_id AND
  ord.id = item.ord_id AND
  product.id = item.product_id;
  
--6
SELECT
  ord.id "NR",
  customer.name "KLIENT",
  ord.payment_type "P£ATNOŒÆ",
  TO_CHAR(ord.date_ordered, 'YYYY/MM/DD') "DATA ZAMÓWIENIA", 
  SUM(item.price * item.quantity) "WYSOKOŒÆ ZAMÓWIENIA"
FROM
  ord, customer, item
WHERE
  ord.payment_type = 'CASH' AND
  TO_CHAR(ord.date_ordered, 'MM/YYYY') = '09/1992' AND
  customer.id = ord.customer_id AND
  ord.id = item.ord_id 
GROUP BY
  ord.id, customer.name, ord.payment_type, ord.date_ordered
ORDER BY
  ord.id;

--7
SELECT
  last_name "NAZWISKO"
FROM
  emp
GROUP BY
  last_name
HAVING
  COUNT(last_name) > 1;
  
--8
SELECT
  first_name "IMIÊ",
  last_name "NAZWISKO",
  title "STANOWISKO",
  manager_id "ZWIERZCHNIK",
  LEVEL "POZIOM"
FROM
  emp
CONNECT BY PRIOR
  id = manager_id
START WITH
  manager_id IS NULL
ORDER BY
  LEVEL;

--9
SELECT
  first_name "IMIÊ",
  last_name "NAZWISKO",
  title "STANOWISKO",
  manager_id "ZWIERZCHNIK",
  LEVEL "POZIOM"
FROM
  emp
CONNECT BY PRIOR
  id = manager_id
START WITH
  title = 'VP, Operations'
ORDER BY
  LEVEL;
  
--10
SELECT
  region_id "ID REGIONU",
  name "NAZWA"
FROM
  dept
UNION
SELECT
  id,
  name
FROM
  region
ORDER BY 2;

--11
SELECT
  name "NAZWA"
FROM
  dept
UNION
SELECT
  name
FROM
  region;
  
--12
SELECT
  name "NAZWA"
FROM
  dept
UNION ALL
SELECT
  name
FROM
  region;

--13
SELECT
  dept.id "NR DEPT/REG",
  emp.last_name "NAZWISKO/NAZWA"
FROM
  dept, emp
WHERE
  emp.dept_id = dept.id 
UNION 
SELECT
  id,
  name
FROM
  region
ORDER BY 2;

--14
SELECT id "ID"
FROM customer
INTERSECT
SELECT customer_id
FROM ord;

--15
SELECT id "ID"
FROM customer
MINUS
SELECT customer_id
FROM ord;
