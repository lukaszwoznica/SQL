CREATE OR REPLACE PACKAGE pracownicy AS

  PROCEDURE add_emp(
    in_last_name      IN emp.last_name%TYPE,
    in_first_name     IN emp.first_name%TYPE,
    in_userid         IN emp.userid%TYPE DEFAULT NULL,
    in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
    in_comments       IN emp.comments%TYPE DEFAULT NULL,
    in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
    in_title          IN emp.title%TYPE DEFAULT NULL,
    in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
    in_salary         IN emp.salary%TYPE DEFAULT NULL,
    in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
    );
    
  PROCEDURE change_emp(
    in_id             IN emp.id%TYPE,
    in_last_name      IN emp.last_name%TYPE DEFAULT NULL,
    in_first_name     IN emp.first_name%TYPE DEFAULT NULL,
    in_userid         IN emp.userid%TYPE DEFAULT NULL,
    in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
    in_comments       IN emp.comments%TYPE DEFAULT NULL,
    in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
    in_title          IN emp.title%TYPE DEFAULT NULL,
    in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
    in_salary         IN emp.salary%TYPE DEFAULT NULL,
    in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
  );
  
  PROCEDURE delete_emp(in_id IN emp.id%TYPE);
  PROCEDURE change_salary(in_id IN emp.id%TYPE, in_proc IN NUMBER);
  PROCEDURE change_dept(in_emp_id IN emp.id%TYPE, in_dept_id IN emp.dept_id%TYPE);
  FUNCTION stat_emp(in_param VARCHAR2) RETURN NUMBER;
  
END pracownicy;
/

CREATE OR REPLACE PACKAGE BODY pracownicy AS

--POCZĄTEK ADD_EMP---------------------------------------------

  PROCEDURE add_emp(
    in_last_name      IN emp.last_name%TYPE,
    in_first_name     IN emp.first_name%TYPE,
    in_userid         IN emp.userid%TYPE DEFAULT NULL,
    in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
    in_comments       IN emp.comments%TYPE DEFAULT NULL,
    in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
    in_title          IN emp.title%TYPE DEFAULT NULL,
    in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
    in_salary         IN emp.salary%TYPE DEFAULT NULL,
    in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
  ) AS
    uv_max_id NUMBER; 
    BEGIN 
      SELECT MAX(id) INTO uv_max_id FROM emp; 
      INSERT INTO
        emp
      VALUES 
        (uv_max_id + 1, in_last_name, in_first_name, in_userid, in_start_date, in_comments, in_manager_id, in_title, in_dept_id, in_salary, in_commission_pct); 
      COMMIT; 
    END add_emp;
    
--KONIEC ADD_EMP---------------------------------------------------

--POCZĄTEK CHANGE_EMP----------------------------------------------

  PROCEDURE change_emp(
    in_id             IN emp.id%TYPE,
    in_last_name      IN emp.last_name%TYPE DEFAULT NULL,
    in_first_name     IN emp.first_name%TYPE DEFAULT NULL,
    in_userid         IN emp.userid%TYPE DEFAULT NULL,
    in_start_date     IN emp.start_date%TYPE DEFAULT NULL,
    in_comments       IN emp.comments%TYPE DEFAULT NULL,
    in_manager_id     IN emp.manager_id%TYPE DEFAULT NULL,
    in_title          IN emp.title%TYPE DEFAULT NULL,
    in_dept_id        IN emp.dept_id%TYPE DEFAULT NULL,
    in_salary         IN emp.salary%TYPE DEFAULT NULL,
    in_commission_pct IN emp.commission_pct%TYPE DEFAULT NULL
  ) AS
    BEGIN
      IF in_last_name IS NOT NULL THEN
        UPDATE 
          emp
        SET 
          last_name = in_last_name
        WHERE 
          id = in_id;
      END IF;
   
      IF in_first_name IS NOT NULL THEN
        UPDATE
          emp
        SET
          first_name = in_first_name
        WHERE
          id = in_id;
      END IF;
   
      IF in_userid IS NOT NULL THEN
        UPDATE
          emp
        SET
          userid = in_userid
        WHERE
          id = in_id;
      END IF;
   
      IF in_start_date IS NOT NULL THEN
        UPDATE
          emp
        SET 
          start_date = in_start_date
        WHERE
          id = in_id;
      END IF;
   
      IF in_comments IS NOT NULL THEN
        UPDATE 
          emp
        SET 
          comments = in_comments
        WHERE
          id = in_id;
      END IF;
   
      IF in_manager_id IS NOT NULL THEN
        UPDATE
          emp
        SET
          manager_id = in_manager_id
        WHERE
          id = in_id;
      END IF;
   
      IF in_title IS NOT NULL THEN
        UPDATE 
          emp
        SET
          title = in_title
        WHERE
          id = in_id;
      END IF;
   
      IF in_dept_id IS NOT NULL THEN
        UPDATE 
          emp
        SET
          dept_id = in_dept_id
        WHERE
          id = in_id;
      END IF;
   
      IF in_salary IS NOT NULL THEN
        UPDATE
          emp
        SET
          salary = in_salary
        WHERE
          id = in_id;
      END IF;
   
      IF in_commission_pct IS NOT NULL THEN
        UPDATE
          emp
        SET 
          commission_pct = in_commission_pct
        WHERE
          id = in_id;
      END IF;
      COMMIT;  
  END change_emp;

--KONIEC CHANGE_EMP---------------------------------------------------

--POCZĄTEK DELETE_EMP-------------------------------------------------

  PROCEDURE delete_emp(in_id IN emp.id%TYPE) AS
    ex_error_id EXCEPTION;
    uv_max_id NUMBER;
    uv_min_id NUMBER;
    BEGIN
      SELECT MAX(id) INTO uv_max_id FROM emp;
      SELECT MIN(id) INTO uv_min_id FROM emp;
      IF in_id > uv_max_id OR in_id < uv_min_id THEN
        RAISE ex_error_id;
      ELSE
        DELETE FROM 
          emp
        WHERE
          id = in_id;
      END IF;
      COMMIT;
    EXCEPTION
      WHEN ex_error_id THEN
        DBMS_OUTPUT.PUT_LINE('Pracownik o podanym ID nie istnieje!'); 
  END delete_emp;
  
--KONIEC DELETE_EMP-----------------------------------------------------

--POCZĄTEK CHANGE_SALARY------------------------------------------------

  PROCEDURE change_salary(in_id IN emp.id%TYPE, in_proc IN NUMBER) AS
    uv_max_id NUMBER;
    uv_min_id NUMBER;
    ex_error_procentage_value EXCEPTION;
    ex_error_id EXCEPTION;
    BEGIN
      SELECT MAX(id) INTO uv_max_id FROM emp;
      SELECT MIN(id) INTO uv_min_id FROM emp;
      IF in_id > uv_max_id OR in_id < uv_min_id THEN
        RAISE ex_error_id;
      ELSIF in_proc < 0 OR in_proc > 100 THEN
        RAISE ex_error_procentage_value;
      ELSE
        UPDATE 
          emp
        SET 
          salary = salary + (salary * (in_proc / 100))
        WHERE 
          id = in_id;
      END IF;
      COMMIT;
    EXCEPTION  
      WHEN ex_error_id THEN 
        DBMS_OUTPUT.PUT_LINE('Pracownik o podanym ID nie istnieje!'); 
      WHEN ex_error_procentage_value THEN 
        DBMS_OUTPUT.PUT_LINE('Niepoprawna wartość procentowa!'); 
  END change_salary;
  
--KONIEC CHANGE_SALARY-------------------------------------------------

--POCZĄTEK CHANGE_DEPT-------------------------------------------------

  PROCEDURE change_dept(in_emp_id IN emp.id%TYPE, in_dept_id IN emp.dept_id%TYPE) AS
    uv_max_emp_id NUMBER;
    uv_min_emp_id NUMBER;
    ex_error_emp_id EXCEPTION;
    uv_max_dept_id NUMBER;
    uv_min_dept_id NUMBER;
    ex_error_dept_id EXCEPTION;
    BEGIN
      SELECT MAX(id) INTO uv_max_emp_id FROM emp;
      SELECT MIN(id) INTO uv_min_emp_id FROM emp;
      SELECT MAX(id) INTO uv_max_dept_id FROM dept;
      SELECT MIN(id) INTO uv_min_dept_id FROM dept;
      IF in_emp_id > uv_max_emp_id OR in_emp_id < uv_min_emp_id THEN
        RAISE ex_error_emp_id;
      ELSIF in_dept_id > uv_max_emp_id OR in_dept_id < uv_min_emp_id THEN
        RAISE ex_error_dept_id;
      ELSE
        UPDATE 
          emp
        SET 
          dept_id = in_dept_id
        WHERE
          id = in_emp_id;
      END IF;
    EXCEPTION 
      WHEN ex_error_emp_id THEN 
        DBMS_OUTPUT.PUT_LINE('Pracownik o podanym ID nie istnieje!'); 
      WHEN ex_error_dept_id THEN
        DBMS_OUTPUT.PUT_LINE('Departament o podanym ID nie istnieje!');
    COMMIT;
  END change_dept;

--KONIEC CHANGE_DEPT----------------------------------------------------

--POCZĄTEK STAT_EMP-----------------------------------------------------

  FUNCTION stat_emp(in_param VARCHAR2) RETURN NUMBER AS
    uv_result NUMBER := 0;
    ex_error_parameter EXCEPTION;
    BEGIN
      IF in_param NOT IN('MAX', 'MIN', 'SUM', 'AVG') THEN 
        RAISE ex_error_parameter;
      END IF;
      IF in_param = 'MAX' THEN
        SELECT MAX(salary) INTO uv_result FROM emp;
      ELSIF in_param = 'MIN' THEN
        SELECT MIN(salary) INTO uv_result FROM emp;
      ELSIF in_param = 'AVG' THEN
        SELECT AVG(salary) INTO uv_result FROM emp;
      ELSIF in_param = 'SUM' THEN  
        SELECT SUM(salary) INTO uv_result FROM emp;
      END IF;
      RETURN uv_result;
      
    EXCEPTION
      WHEN ex_error_parameter THEN
        DBMS_OUTPUT.PUT_LINE('Podano niepoprawny parametr!'); 
  END stat_emp;

--KONIEC STAT_EMP------------------------------------------------------

END pracownicy;



