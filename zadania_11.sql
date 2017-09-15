--1
DECLARE
  liczba NUMBER(4) := 150;
  tekst VARCHAR(20) := 'Przykladowy tekst';
  data CONSTANT DATE := TO_DATE('19-05-2012','dd-mm-yyyy');
BEGIN
  DBMS_OUTPUT.PUT_LINE(liczba);
  DBMS_OUTPUT.PUT_LINE(tekst);
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(data, 'dd-mm-yyyy'));
END;

--2
DECLARE
  data_aktualna DATE := SYSDATE;
  data_urodzin DATE := TO_DATE('20-08-1996','dd-mm-yyyy');
BEGIN
  DBMS_OUTPUT.PUT_LINE('Liczba dni: ' || ROUND(data_aktualna - data_urodzin));
  DBMS_OUTPUT.PUT_LINE('Liczba tygodni: ' || ROUND(ROUND(data_aktualna - data_urodzin)/7));
  DBMS_OUTPUT.PUT_LINE('Liczba miesiêcy: ' || ROUND(MONTHS_BETWEEN(data_aktualna, data_urodzin)));
END;

--3
DECLARE
  uv_min_salary emp.salary%TYPE;
  uv_max_salary emp.salary%TYPE;
  uv_imie emp.first_name%TYPE;
  uv_nazwisko emp.last_name%TYPE;
  uv_salary emp.salary%TYPE;
  uv_licznik PLS_INTEGER;
BEGIN
  SELECT MAX(salary) INTO uv_max_salary FROM emp;
  SELECT MIN(salary) INTO uv_min_salary FROM emp;
  
  SELECT last_name, first_name, salary INTO uv_nazwisko, uv_imie, uv_salary
  FROM emp 
  WHERE salary = uv_max_salary;
  DBMS_OUTPUT.PUT_LINE(uv_imie || ' ' || uv_nazwisko || ' zarabia najwiecej');
  
  SELECT last_name, first_name, salary INTO uv_nazwisko, uv_imie, uv_salary
  FROM emp
  WHERE salary = uv_min_salary;
  DBMS_OUTPUT.PUT_LINE(uv_imie || ' ' || uv_nazwisko || ' zarabia najmniej' );
  
  EXCEPTION
  WHEN TOO_MANY_ROWS THEN
  SELECT COUNT(*) INTO uv_licznik FROM emp;
  DBMS_OUTPUT.PUT_LINE('Zwrócono' || uv_licznik || ' rekordów.');     
END;

--4
--kursor jawny
DECLARE
  CURSOR emp_curs IS
    SELECT * FROM emp ORDER BY last_name; 
  uv_emp emp_curs%ROWTYPE;
BEGIN
  OPEN emp_curs;
  LOOP
    FETCH emp_curs INTO uv_emp;
    EXIT WHEN emp_curs%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(uv_emp.last_name|| ' ' || uv_emp.first_name || ' - ' || uv_emp.title);
  END LOOP;
  CLOSE emp_curs;
END;

/*bez kursora*/
BEGIN
FOR uv_emp IN (SELECT * FROM emp ORDER BY last_name) LOOP
  DBMS_OUTPUT.PUT_LINE(uv_emp.last_name|| ' ' || uv_emp.first_name || ' - ' || uv_emp.title);
END LOOP;
END;



--6
CREATE TABLE emp_new AS (SELECT * FROM emp); 
--a
BEGIN
  UPDATE 
    emp_new
  SET
    salary=1.2*salary
  WHERE
    salary < (SELECT (1/2)*AVG(salary) FROM emp_new);
END;
--b
BEGIN
  UPDATE
    emp_new
  SET 
    salary=1.1*salary
  WHERE
    salary BETWEEN (SELECT (1/2)*AVG(salary) FROM emp_new) AND (SELECT (5/6)*AVG(salary) FROM emp_new);
END;
--c
BEGIN
  UPDATE
    emp_new
  SET 
    salary=1.05*salary
  WHERE
    salary > (SELECT (5/6)*AVG(salary) FROM emp_new);
END;