CREATE TABLE employees(
 dept_id INT,
 last_name VARCHAR(20)
);

CREATE TABLE department(
 department_id INT,
 department_name VARCHAR2(25)
);

TRUNCATE table department;
INSERT INTO department VALUES(10,'Administration');
INSERT INTO department VALUES(20,'Marketing');
INSERT INTO department VALUES(40,'Human Resource');
INSERT INTO department VALUES(50,'Shipping');
INSERT INTO department VALUES(80,'Sales');

INSERT INTO employees VALUES(50,'Oconnell');
INSERT INTO employees VALUES(50,'Grant');
INSERT INTO employees VALUES(10,'Whalen');
INSERT INTO employees VALUES(20,'Hartstein');
INSERT INTO employees VALUES(20,'Fay');
INSERT INTO employees VALUES(100,'Manish');
INSERT INTO employees VALUES(120,'Abhijeet');

select * from employees;
select * from department;
select * from emp;

CREATE TABLE emp
AS
SELECT * FROM employees;
ALTER TABLE emp ADD(depart_name VARCHAR(25));
ALTER TABLE emp RENAME COLUMN depart_name TO department_name;

/*we have to fill the department_name null value to 
actual department name from department table ,basically 
we are updating emp table using correlated update query*/
UPDATE emp outer_table SET department_name = 
(SELECT department_name from department inner_table 
WHERE inner_table.department_id = outer_table.dept_id );

DELETE FROM emp outer_table 
WHERE dept_id = 
(SELECT department_id FROM department inner_table 
WHERE inner_table.department_id = outer_table.dept_id );
rollback;
