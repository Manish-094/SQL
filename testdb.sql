CREATE TABLE Employee(
 emp_id INT PRIMARY KEY NOT NULL,
 emp_name VARCHAR2(25),
 age INT,
 salary number
);


INSERT INTO Employee(emp_id,emp_name,age,salary)VALUES(101,'Manish',22,20000);
INSERT INTO Employee(emp_id,emp_name,age,salary)VALUES(102,'Jack',23,30000);
INSERT INTO Employee(emp_id,emp_name,age,salary)VALUES(103,'Amit',24,40000);
INSERT INTO Employee(emp_id,emp_name,age,salary)VALUES(104,'Jimmy',25,50000);
INSERT INTO Employee(emp_id,emp_name,age,salary)VALUES(105,'Ali',26,60000);

SELECT * FROM Employee FETCH FIRST 2 ROWS ONLY;
SELECT * FROM Employee ORDER BY emp_id;
DELETE FROM Employee WHERE emp_id = 102;
UPDATE Employee SET age = 26 WHERE emp_id = 102;
COMMIT;
ROLLBACK;

CREATE TABLE Department(
 emp_id INT PRIMARY KEY NOT NULL,
 dep_name VARCHAR2(25),
 status VARCHAR2(25)
);

INSERT INTO Department(emp_id,dep_name,status)VALUES(101,'Full Stack','Trainee');
INSERT INTO Department(emp_id,dep_name,status)VALUES(103,'PHP','Full Time');
INSERT INTO Department(emp_id,dep_name,status)VALUES(106,'Java Developer','Trainee');
INSERT INTO Department(emp_id,dep_name,status)VALUES(104,'React Developer','Full Time');

SELECT * FROM Department;

SELECT * FROM Employee E1 INNER JOIN Department E2 ON E1.emp_id = E2.emp_id;
SELECT * FROM Employee E1 LEFT JOIN Department E2 ON E1.emp_id = E2.emp_id;
SELECT * FROM Employee E1 RIGHT JOIN Department E2 ON E1.emp_id = E2.emp_id;
SELECT * FROM Employee E1 FULL JOIN Department E2 ON E1.emp_id = E2.emp_id;

SELECT * FROM Employee NATURAL JOIN Department;
SELECT * FROM Employee NATURAL LEFT JOIN Department;
SELECT * FROM Employee NATURAL RIGHT JOIN Department;
SELECT * FROM Employee NATURAL FULL JOIN Department;

SELECT * FROM Employee  CROSS JOIN Department;


CREATE TABLE Customer(
  id INT PRIMARY KEY NOT NULL,
  name VARCHAR2(20)NOT NULL,
  age INT NOT NULL,
  address VARCHAR2(50) NOT NULL,
  salary NUMBER NOT NULL
);

INSERT INTO Customer(id,name,age,address,salary)VALUES
(1,'Ramesh',32,'Ahmedabad',2000.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(2,'Khilan',25,'Delhi',1500.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(3,'kaushik',23,'Kota',2000.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(4,'Chaitali',25,'Mumbai',6500.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(5,'Hardik',22,'Bhopal',8500.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(6,'Komal',22,'MP',4500.00);
INSERT INTO Customer(id,name,age,address,salary)VALUES
(7,'Muffy',24,'Indore',10000.00);

DROP TABLE Customer;
TRUNCATE TABLE Customer;

SELECT * FROM Customer ORDER BY id;

--savepoint after each operation
DELETE FROM Customer WHERE id = 1;
SAVEPOINT SP1;
DELETE FROM Customer WHERE id = 2;
SAVEPOINT SP2;
DELETE FROM Customer WHERE id = 3;
SAVEPOINT SP3;
DELETE FROM Customer WHERE id = 4;
SAVEPOINT SP4;
DELETE FROM Customer WHERE id = 5;
SAVEPOINT SP5;
DELETE FROM Customer WHERE id = 6;
SAVEPOINT SP6;

ROLLBACK TO SP2;
--RELEASE SAVEPOINT SP2;


--CREATING A TABLE of named Student
CREATE TABLE Student(
  student_id INT PRIMARY KEY NOT NULL,
  first_name VARCHAR2(25) NOT NULL,
  last_name VARCHAR2(25) NOT NULL,
  age INT NOT NULL,
  gender CHAR(6) NOT NULL
);

--inserting data in table Student
INSERT INTO Student(student_id,first_name,last_name,age,gender)VALUES
(101,'Ramesh','Patel',22,'Male');
INSERT INTO Student(student_id,first_name,last_name,age,gender)VALUES
(102,'Manish','Patel',23,'Male');
INSERT INTO Student(student_id,first_name,last_name,age,gender)VALUES
(103,'Jack','Doe',24,'Male');
INSERT INTO Student(student_id,first_name,last_name,age,gender)VALUES
(104,'Rashmi','Patel',19,'Female');
INSERT INTO Student(student_id,first_name,last_name,age,gender)VALUES
(105,'Shivangi','Patel',18,'Female');

--fetching data from Student table
SELECT * FROM Student;

--drop the table Student, deleted all the record and structure of the table
DROP TABLE Student;
--deleting single column
ALTER TABLE Student DROP COLUMN last_name;
--adding new column
ALTER TABLE Student ADD(department VARCHAR2(50));
--modify the existing department column
ALTER TABLE Student MODIFY(department VARCHAR2(40));
--rename the clumn name
ALTER TABLE Student RENAME COLUMN gender to sex;
--rename the table name
ALTER TABLE Student RENAME TO Students;
--truncate the table student, only the record delete structure remains the same
TRUNCATE TABLE Students;

--deleting Student data of student_id equal to 103
DELETE FROM Student WHERE student_id = 103;
--delete student table, only the records are deleting, work as truncate
DELETE FROM Student;
--updating first name of studentID equals to 102
UPDATE Student SET first_name = 'Jimmy' WHERE student_id = 102;

--ROLLBACK the updated data
UPDATE Students SET student_id = 110 WHERE student_id = 102;
ROLLBACK;




--CREATE TABLE Worker (
--    worker_id    INT NOT NULL PRIMARY KEY,
--    first_name   VARCHAR2(25),
--    last_name    VARCHAR2(25),
--    salary       NUMBER,
--    joining_date TIMESTAMP ,
--    department   VARCHAR2(25)
--);
--
--INSERT INTO Worker(worker_id, first_name, last_name, salary, joining_date, department) VALUES
--		(002, 'Monika', 'Arora', 200000, '08-MAY-24', 'HR'),
--        
--        		(003, 'MSConika', 'Arora', 200000, '08-MAY-24', 'CS');
--
--DELETE FROM Worker where first_name = 'Monika';
--SELECT * FROM Worker;
--SELECT CURRENT_TIMESTAMP FROM DUAL;






















CREATE TABLE persons (
    person_id INT PRIMARY KEY NOT NULL,
    firstname VARCHAR(20),
    lastname  VARCHAR2(20),
    age       NUMBER,
    salary    NUMBER
);

INSERT INTO persons (
    person_id,
    firstname,
    lastname,
    age,
    salary
) VALUES (
    3,
    'Diljeet',
    'Patel',
    23,
    30000
);

SELECT *
FROM persons;

TRUNCATE TABLE persons;

SELECT *
FROM persons self
JOIN persons ON persons.age = persons.age;


----ii ->INSERT INTO table VALUES ()
----ssf SELECT * FROM table
--
----SELECT /*insert*/*
----FROM persons;
----SELECT /*CSV*/ *
----FROM persons;















