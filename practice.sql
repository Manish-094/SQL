----------------2nd Highest salary-------------------------------------------------------
select max(salary) from Employee where salary 
< (select max(salary) from Employee);

----------------nth Highest salary--------------------------------------------------------
create table nthHighest_table(
   id INT,
   salary INT
);
insert into nthHighest_table values(5,200);
select * from nthHighest_table;

SELECT *
FROM(
      SELECT salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
      FROM (SELECT DISTINCT salary FROM nthHighest_table) );

CREATE OR REPLACE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
  result NUMBER;
BEGIN
  SELECT salary INTO result
  FROM (
    SELECT salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM nthHighest_table
  )
  WHERE rn = N;
  
  RETURN result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Nth highest salary not found.');
END;
/

set SERVEROUTPUT on;
DECLARE
  highest_salary NUMBER;
BEGIN
  highest_salary := getNthHighestSalary(2); -- Retrieves the 3rd highest salary
  DBMS_OUTPUT.PUT_LINE('The 2nd highest salary is: ' || highest_salary);
END;
/
select * from nthHighest_table where exists (select * from nthHighest_table where id = 3);


SELECT name FROM V$controlfile;
