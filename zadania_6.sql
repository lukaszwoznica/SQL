-- 1
SELECT
  first_name "Imiê",
  last_name "Nazwisko"
FROM 
  emp
WHERE
  salary < 1300
ORDER BY
  last_name;
  
--2
SELECT
  TO_CHAR(date_ordered, 'dd-mm-yyyy') || ' Wartoœæ: ' ||  total "Data i wartoœæ zamówienia"
FROM 
  ord;
  
--3
SELECT
  first_name || ' ' || last_name "Imiê i nazwisko"
FROM
  emp
WHERE 
  title = 'Stock Clerk' AND
  salary > (SELECT AVG(salary) FROM emp WHERE title = 'Warehouse Manager');
  
--4
SELECT
  COUNT(last_name) "Liczba pracowników"
FROM
  emp
WHERE
  salary < (SELECT AVG(salary) FROM emp);
  
--5
SELECT
  first_name || ' ' || last_name "Imiê i nazwisko"
FROM 
  emp
WHERE
  EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM start_date) > 26; 
  
--6
SELECT
  sales_rep_id "Nr",
  SUM(total) "Kwota zamówieñ"
FROM
  ord
GROUP BY 
  sales_rep_id
ORDER BY
  sales_rep_id;
  
--7
SELECT
  sales_rep_id "Nr",
  SUM(total) "Kwota"
FROM
  ord
GROUP BY 
  sales_rep_id
HAVING 
  SUM(total) = (SELECT MAX(SUM(total)) FROM ord GROUP BY sales_rep_id ); 
  
--8
SELECT
  last_name "Nazwisko"
FROM 
  emp
WHERE
  id IN 
  (SELECT sales_rep_id 
  FROM ord 
  GROUP BY sales_rep_id 
  HAVING  SUM(total) = (SELECT MAX(SUM(total)) FROM ord GROUP BY sales_rep_id));
  
--9
SELECT
  TO_CHAR(start_date, 'dd-mm-yyyy') "Data",
  COUNT(id) "Liczba"
FROM 
  emp
GROUP BY 
  start_date
ORDER BY 
  start_date;

---10
SELECT
  product.name "Nazwa produktu"
FROM
  product, inventory 
WHERE
  product.id = inventory.product_id AND
  inventory.amount_in_stock = 0 AND
  inventory.out_of_stock_explanation IS NOT NULL;
  
---11
SELECT
  name "Nazwa produktu"
FROM 
  product, inventory 
WHERE
  product.id = inventory.product_id AND
  inventory.amount_in_stock > 500;
      
---12
SELECT
  name "Nazwa"
FROM
  product
WHERE 
  name LIKE '% % %' AND 
  name NOT LIKE '% % % %';