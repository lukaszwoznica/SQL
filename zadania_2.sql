--1
SELECT LOWER(first_name) "IMIÊ", LOWER(last_name) "NAZWISKO", INITCAP(userid) "IENTYFIKATOR", UPPER(title) "STANWOSIKO"
FROM emp
WHERE title LIKE 'VP%';

--2
SELECT first_name "IMIÊ", last_name "NAZWISKO"
FROM emp
WHERE last_name LIKE INITCAP(LOWER('PATEL'));

--3
SELECT name || ' - ' || country "NAZWA I PAÑSTWO"
FROM customer
WHERE credit_rating LIKE 'GOOD';

--4
SELECT name "NAZWA", LENGTH(name) "LICZBA ZNAKÓW"
FROM product
WHERE name LIKE 'Ace%';

--5
SELECT ROUND(41.5843,2) "SETNE", ROUND(41.5843,0) "CA£KOWITE", ROUND(41.5843,-1) "DZIESI¥TKI" 
FROM dual;

--6
SELECT TRUNC(41.5843,2) "SETNE", TRUNC(41.5843,0) "CA£KOWITE", TRUNC(41.5843,-1) "DZIESI¥TKI"
FROM dual;

--7
SELECT last_name "NAZWISKO", MOD(salary,commission_pct) "RESZTA"
FROM emp
WHERE salary > 1380;

--7a
SELECT last_name "NAZWISKO", MOD(salary,commission_pct) "RESZTA"
FROM emp
WHERE salary > 1380 AND commission_pct NOT LIKE 'null';

--8
SELECT SYSDATE "AKTUALNA DATA"
FROM dual;

--9
SELECT last_name "NAZWISKO", ROUND((SYSDATE - start_date)/7,0) "LICZBA TYGODNI"
FROM emp
WHERE dept_id LIKE 43;

--10
SELECT id "ID", ROUND(MONTHS_BETWEEN(SYSDATE,start_date),0) "LICZBA MIESIÊCY", ADD_MONTHS(start_date,3) "DATA KOÑCA OKRESU PRÓBNEGO"
FROM emp
WHERE MONTHS_BETWEEN(SYSDATE,start_date) < 308;

--11
SELECT product_id "PRODUKT", restock_date "DOSTAWA", NEXT_DAY(restock_date,'PI¥TEK') "PI¥TEK PO DOSTAWIE", LAST_DAY(restock_date) "OSTATNI DZIEÑ MIESI¥CA"
FROM inventory
WHERE restock_date IS NOT NULL
ORDER BY restock_date ASC;

--12
SELECT id "ID", start_date "DATA", EXTRACT(MONTH FROM start_date) "MIESI¥C"
FROM emp
WHERE TRUNC(TO_CHAR(start_date, 'YYYY')) = '1991';

--13
SELECT id "ID", TO_CHAR(date_ordered, 'MM/YY') "MM/RR"
FROM ord
WHERE sales_rep_id = '11';

--14
SELECT last_name "NAZWISKO", TO_CHAR(start_date, 'dd Month yyyy ') || 'roku'  "DATA"
FROM emp
WHERE TO_CHAR(start_date, 'YYYY') = '1991';