--1
SELECT * 
FROM dept;

--2
SELECT dept_id, last_name, manager_id
FROM emp;

--3
SELECT salary*12, last_name
FROM emp;

--4
SELECT first_name "Imiê", last_name "Nazwisko", salary "Zarobki miesiêczne", salary*12+1000 "Roczne z premi¹"
FROM emp;

--5
SELECT first_name "Imiê", last_name "Nazwisko", salary*1.08 "Zarobki miesiêczne", salary*1.08*12 "Zarobki roczne"
FROM emp;

--6
SELECT last_name, salary*12+salary*0.05 "ROCZNY DOCHÓD"
FROM emp;

--7
SELECT first_name || last_name "Imiê i Nazwisko"
FROM emp;

--8
SELECT first_name || ' ' || last_name || ' - ' || title "Super Pracownicy"
FROM emp;

--9
SELECT last_name, salary, title, salary*(commission_pct*0.01) "PROWIZJA"
FROM emp;
-- Niektóre rekordy nie maj¹ wartoœci, poniewa¿ maj¹ wartoœæ NULL w polu commission_ptc 

--10
SELECT last_name, salary, title, NVL(salary*(commission_pct*0.01),0) "PROWIZJA"
FROM emp;

--11
SELECT DISTINCT name
FROM dept;

--12
SELECT last_name, dept_id, salary, TO_CHAR(start_date, 'dd-mon-yyyy') "START_DATE"
FROM emp
ORDER BY dept_id ASC, salary DESC;

--13
SELECT last_name, dept_id, TO_CHAR(start_date, 'dd-mon-yyyy')
FROM emp
ORDER BY TO_CHAR(start_date, 'yyyy-mm-dd') ASC;

--14
SELECT first_name, last_name, title
FROM emp
WHERE last_name LIKE 'Patel';

--15
SELECT last_name, TO_CHAR(start_date, 'dd-mon-yyyy')
FROM emp
WHERE start_date > TO_DATE('02-05-1991', 'dd-mm-yyyy') AND start_date < TO_DATE('15-06-1991', 'dd-mm-yyyy');

--16
SELECT id, name, region_id
FROM dept
WHERE region_id LIKE 1 OR region_id LIKE 3;

--17
SELECT *
FROM emp
WHERE last_name LIKE 'M%';

--18
SELECT *
FROM emp
WHERE last_name NOT LIKE '%a%';

--19
SELECT last_name, TO_CHAR(start_date, 'dd-mon-yyyy')
FROM emp
WHERE start_date >= TO_DATE('01-01-1991','dd-mm-yyyy') AND start_date <= TO_DATE('31-12-1991','dd-mm-yyyy');

--20
SELECT last_name
FROM emp
WHERE last_name LIKE '_a%';

--21
SELECT name
FROM customer
WHERE name LIKE '%s_o%';
