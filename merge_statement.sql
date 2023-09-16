CREATE TABLE region_old(
  region_id NUMBER,
  region_name VARCHAR2(100)
);

CREATE TABLE region(
 region_id NUMBER,
 region_name VARCHAR2(100)
);
select * from region_old;
select * from region;
INSERT INTO region_old VALUES(1,'E');
INSERT INTO region_old VALUES(2,'A');
INSERT INTO region_old VALUES(5,'Africa');

INSERT INTO region VALUES(1,'Europe');
INSERT INTO region VALUES(2,'America');
INSERT INTO region VALUES(3,'Asia');
INSERT INTO region VALUES(4,'Middle East And Africa');

SELECT * FROM region_old;
select * from region;
TRUNCATE TABLE region_old;
TRUNCATE TABLE region;

MERGE INTO region_old target
USING region source
ON (target.region_id = source.region_id)
WHEN MATCHED THEN
   DELETE WHERE target.region_name = 'Africa';
WHEN NOT MATCHED THEN
  INSERT (region_id, region_name) VALUES (source.region_id, source.region_name);



MERGE INTO region_old target
USING region source
ON(target.region_id = source.region_id)
WHEN MATCHED THEN
    DELETE WHERE target.region_name = source.region_name
    UPDATE SET target.region_name = source.region_name
WHEN NOT MATCHED THEN
   INSERT VALUES(source.region_id,source.region_name);
   
-- Delete rows from region_old table that were matched in the merge operation
DELETE FROM region_old
WHERE region_id IN (
  SELECT region_id FROM region
);
commit;

CREATE TABLE emp12(
  employee_id NUMBER,
  hire_date DATE,
  salary NUMBER,
  manager_id NUMBER,
  department_id NUMBER
);

INSERT INTO emp12 VALUES
(100,TO_DATE('01-05-2023','DD-MM-YYYY'),10000,101,1);
INSERT INTO emp12 VALUES
(101,TO_DATE('02-05-2023','DD-MM-YYYY'),20000,102,2);
INSERT INTO emp12 VALUES
(102,TO_DATE('03-05-2023','DD-MM-YYYY'),30000,103,3);
INSERT INTO emp12 VALUES
(103,TO_DATE('04-05-2023','DD-MM-YYYY'),40000,104,4);
INSERT INTO emp12 VALUES
(104,TO_DATE('05-05-2023','DD-MM-YYYY'),50000,105,5);
select * from emp12;
CREATE TABLE emp_sal(
  eid NUMBER,
  hiredate DATE,
  sla NUMBER
);
CREATE TABLE mgr_sal(
  eid NUMBER,
  mgrid NUMBER,
  sal NUMBER
);
select * from emp_sal;
select * from mgr_sal;
/*UNCONDITIONAL INSERT ALL =>EACH ROW 
INSERTED IN BOTH THE TABLE AT THE SAME TIME
SELECT STATEMENT WILL EXECUTE FIRST*/
INSERT ALL
INTO emp_sal VALUES(employee_id,hire_date,salary)
INTO mgr_sal VALUES(employee_id,manager_id,salary)
SELECT employee_id,hire_date,salary,manager_id
FROM emp12
WHERE department_id = 1;

/*CONDITIONAL INSERT ALL=> EACH ROW DATA INSERTED 
IN THE TABLE BASED ON THE CONDITION PROVIDED*/
INSERT ALL
WHEN salary<=40000 THEN
INTO emp_sal VALUES(employee_id,hire_date,salary)
WHEN employee_id<104 THEN
INTO mgr_sal VALUES(employee_id,manager_id,salary)
SELECT employee_id,manager_id,salary,hire_date
FROM emp12
WHERE department_id = 3;

/*CONDITIONAL INSERT FIRST=> IT INSERT THE DATA BY CHECKING WHEN CLAUSE(CHECKING CONDITION),
IF FIRST WHEN CLAUSE GIVES TRUE THEN IT WILL 
DISCARD ALL THE WHEN CAUSE THAT COMES AFTER IT*/
INSERT FIRST
WHEN salary<=40000 THEN
INTO emp_sal VALUES(employee_id,hire_date,salary)
WHEN employee_id<104 THEN
INTO mgr_sal VALUES(employee_id,manager_id,salary)
SELECT employee_id,manager_id,salary,hire_date
FROM emp12
WHERE department_id = 4;

/*PIVOTING INSERT => SAME AS UNCONDITIONAL INSERT ALL 
CONVERT NON RELATIONAL DATABASE TABLE INTO RELATIONAL TABLE
*/

--source table
CREATE TABLE emp_sales(
  eid NUMBER,
  weekid NUMBER,
  sun_sales NUMBER,
  mon_sales NUMBER,
  tue_sales NUMBER,
  web_sales NUMBER,
  thu_sales NUMBER
);
--target table
CREATE TABLE emp_sales_info(
  eid NUMBER,
  weekid NUMBER,
  sales NUMBER
);
INSERT INTO emp_sales VALUES(110,3,1500,2000,3500,4000,3000);
INSERT INTO emp_sales VALUES(120,3,2000,2500,2400,3000,3200);
select * from emp_sales;

--pivoting insert
INSERT ALL
INTO emp_sales_info VALUES(eid,weekid,sun_sales)
INTO emp_sales_info VALUES(eid,weekid,mon_sales)
INTO emp_sales_info VALUES(eid,weekid,tue_sales)
INTO emp_sales_info VALUES(eid,weekid,web_sales)
INTO emp_sales_info VALUES(eid,weekid,thu_sales)
SELECT * FROM emp_sales;

select * from emp_sales_info order by eid;


---------------------PIVOT----------------------------------------------------------------
/*transforming rows of data into columns
This can be useful when you want to present data in a 
different format or perform calculations on grouped data.

Now, suppose you want to pivot the data to show the total sales 
amount for each year, with separate columns for each month. 
You can achieve this by using conditional aggregation and the CASE statement:*//
CREATE TABLE Sale (
  ID INT PRIMARY KEY,
  SalesYear NUMBER,
  Month VARCHAR(10),
  Amount DECIMAL(10, 2)
);

INSERT INTO Sale VALUES (1, 2021, 'Jan', 100);
INSERT INTO Sale VALUES (2, 2021, 'Feb', 150);
INSERT INTO Sale VALUES (3, 2021, 'Mar', 200);
INSERT INTO Sale VALUES (4, 2022, 'Jan', 120);
INSERT INTO Sale VALUES (5, 2022, 'Feb', 180);
INSERT INTO Sale VALUES (6, 2022, 'Mar', 220);
INSERT INTO Sale VALUES (7, 2023, 'Jan', 130);
INSERT INTO Sale VALUES (8, 2023, 'Feb', 170);
INSERT INTO Sale VALUES (9, 2023, 'Mar', 210);
INSERT INTO Sale VALUES (10, 2023, 'Apr', 190);

SELECT
  SalesYear,
  SUM(CASE WHEN Month = 'Jan' THEN Amount ELSE 0 END) AS Jan,
  SUM(CASE WHEN Month = 'Feb' THEN Amount ELSE 0 END) AS Feb,
  SUM(CASE WHEN Month = 'Mar' THEN Amount ELSE 0 END) AS Mar
FROM
  Sale
GROUP BY
  SalesYear;

select * from Sale;

---------------pivot using pivot keyword-------------------------------------------------------
SELECT *
FROM (
  SELECT SalesYear, Month, Amount
  FROM Sale
) 
PIVOT (
  SUM(Amount)
  FOR Month IN ('Jan' AS Jan, 'Feb' AS Feb, 'Mar' AS Mar)
);

---------------unpivot---------------------------------------------------------------------------------
 /*you can use the UNPIVOT operator to transform columns into rows, 
 effectively reversing the pivot operation*/

CREATE TABLE employee_sales (
  employee_id NUMBER,
  quarter1 NUMBER,
  quarter2 NUMBER,
  quarter3 NUMBER,
  quarter4 NUMBER
);

INSERT INTO employee_sales VALUES(1, 5000, 6000, 5500, 4800);
INSERT INTO employee_sales VALUES(2, 5200, 5900, 5100, 5300);

select * from employee_sales;

SELECT employee_id, quarter, amount
FROM employee_sales
UNPIVOT (amount FOR quarter IN (quarter1, quarter2, quarter3, quarter4));

