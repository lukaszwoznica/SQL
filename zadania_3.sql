--1
SELECT
  emp.last_name "NAZWISKO",
  emp.first_name "IMIÊ",
  emp.dept_id "NUMER DEPARTAMENTU",
  dept.name "NAZWA DEPARTAMENTU"
FROM
  emp, dept
WHERE
  emp.dept_id = dept.id;

--2
SELECT
  dept.id "ID",
  dept.region_id "NR REGIONU",
  region.name "NAZWA REGIONU"
FROM
  dept, region
WHERE
  dept.region_id = region.id;
  
--3
SELECT 
  emp.last_name "NAZWISKO",
  emp.first_name "IMIÊ",
  emp.dept_id "NR DEPARTAMENTU",
  dept.name "NAZWA"
FROM
  emp, dept
WHERE
  emp.dept_id = dept.id AND
  last_name LIKE 'Menchu';
  
--4
SELECT
  emp.last_name "NAZWISKO",
  region.name "NAZWA",
  emp.commission_pct "PROWIZJA"
FROM
  emp, region, dept
WHERE
  emp.dept_id = dept.id AND
  dept.region_id = region.id AND
  emp.commission_pct IS NOT NULL;
  
--5
SELECT
  NVL(emp.last_name,'-') "NAZWISKO",
  NVL(TO_CHAR(emp.id), '-') "ID",
  customer.name "NAZWA KLIENTA"
FROM
  emp, customer
WHERE
  emp.id (+) = customer.sales_rep_id ;
    
--6
SELECT 
  e1.last_name || ' pracuje dla ' || e2.last_name "KTO DLA KOGO" 
FROM
  emp e1, emp e2
WHERE
  e1.manager_id = e2.id;
  
--7
SELECT
  customer.name "NAZWA KLIENTA",
  emp.last_name "NAZWISKO",
  ord.date_ordered "DATA ZAMÓWIENIA",
  item.quantity "LICZBA",
  product.name "NAZWA PRODUKTU"
FROM
  customer, emp, ord, item, product
WHERE
  item.ord_id LIKE 101 AND
  ord.sales_rep_id = emp.id AND
  ord.customer_id = customer.id AND
  item.product_id = product.id AND
  item.ord_id = ord.id;
  
--8
SELECT
  customer.id "NR KLIENTA",
  customer.name "NAZWA KLIENTA",
  NVL(TO_CHAR(ord.id),'-') "NR ZAMÓWIENIA"
FROM
  customer, ord
WHERE
  customer.id = ord.customer_id(+);

--9
SELECT
  MAX(salary) "MAKSYMALNA",
  MIN(salary) "MINIMALNA",
  AVG(salary) "ŒREDNIA",
  SUM(salary) "SUMA",
  COUNT(salary) "LICZBA PRACOWNIKÓW"
FROM
  emp;
  
--10
SELECT
  MIN(last_name) "PIERWSZE NAZWISKO",
  MAX(last_name) "OSTATNIE NAZWISKO"
FROM
  emp;
  
--11
SELECT
  COUNT(last_name) "LICZBA PRACOWNIKÓW"
FROM
  emp
WHERE
  dept_id LIKE 31 AND
  commission_pct IS NOT NULL;
