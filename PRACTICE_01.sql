CREATE TABLE employees (
  EMPLOYEE_ID numeric(6) NOT NULL primary key,
  FIRST_NAME varchar2(20) DEFAULT NULL,
  LAST_NAME varchar2(25) NOT NULL,
  EMAIL varchar2(25) NOT NULL,
  PHONE_NUMBER varchar2(20) DEFAULT NULL,
  HIRE_DATE date NOT NULL,
  JOB_ID varchar2(10) NOT NULL,
  SALARY decimal(8,2) DEFAULT NULL,
  COMMISSION_PCT decimal(2,2) DEFAULT NULL,
  MANAGER_ID numeric(6) DEFAULT NULL,
  DEPARTMENT_ID numeric(4) DEFAULT NULL
);

select * from employees;

select sum(SALARY) FROM employees;

SELECT  FIRST_NAME ||' '|| LAST_NAME AS NAME,SALARY FROM employees 
ORDER BY SALARY,FIRST_NAME;

SELECT  FIRST_NAME ||' '|| LAST_NAME AS NAME,SALARY FROM employees 
ORDER BY SALARY DESC;


SELECT  FIRST_NAME ||' '|| LAST_NAME AS NAME FROM employees 
ORDER BY FIRST_NAME;

SELECT FIRST_NAME,EMPLOYEE_ID,DEPARTMENT_ID,SALARY FROM employees
ORDER BY FIRST_NAME ASC,DEPARTMENT_ID ASC,SALARY DESC;

SELECT FIRST_NAME,SALARY*12 AS ANNUAL FROM employees
ORDER BY SALARY DESC;

SELECT E.DEPARTMENT_ID,COUNT(1) CNT FROM employees E
GROUP BY E.DEPARTMENT_ID;

SELECT E.JOB_ID,COUNT(1) CNT FROM employees E
GROUP BY E.JOB_ID;

SELECT E.DEPARTMENT_ID,SUM(SALARY) TOTAL_SALARY FROM employees E
GROUP BY E.DEPARTMENT_ID;

SELECT E.DEPARTMENT_ID ,MAX(SALARY) MAXIMUMN_SALARY FROM employees E
GROUP BY E.DEPARTMENT_ID;

SELECT E.JOB_ID,SUM(E.SALARY) TOTAL_SALARY FROM employees E
GROUP BY E.JOB_ID;

-- SUBQUERY
CREATE TABLE STUDENT(
  StudentId VARCHAR2(20),
  StudName VARCHAR2(20)
);

CREATE TABLE MARKS(
  StudentId VARCHAR2(20),
  TotalMarks INTEGER
);


INSERT INTO STUDENT(StudentId,StudName) VALUES('V001','Abe');
INSERT INTO STUDENT(StudentId,StudName) VALUES('V002','Abhay');
INSERT INTO STUDENT(StudentId,StudName) VALUES('V003','Acelin');
INSERT INTO STUDENT(StudentId,StudName) VALUES('V004','Adelphos');

INSERT INTO MARKS(StudentId,TotalMarks) VALUES('V001',95);
INSERT INTO MARKS(StudentId,TotalMarks) VALUES('V002',80);
INSERT INTO MARKS(StudentId,TotalMarks) VALUES('V003',74);
INSERT INTO MARKS(StudentId,TotalMarks) VALUES('V004',81);

SELECT S.StudentId,S.StudName,M.TotalMarks
FROM STUDENT S INNER JOIN MARKS M
ON S.StudentId = M.StudentId AND M.TotalMarks > 
(SELECT TotalMarks
FROM MARKS
WHERE StudentId = 'V002');

-- SUBQUERY WITH INSERT / UPDATE AND DELETE
CREATE TABLE ORDERS(
  OrdNum INTEGER,
  OrdAmount DECIMAL(10,2),
  AdvanceAmount DECIMAL(10,2),
  OrdDate DATE,
  AgentCode VARCHAR2(20),
  OrderDescription VARCHAR2(100)
);


-- Record 1
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (1, 100.00, 20.00, TO_DATE('2023-08-10','YYYY-MM-DD'), 'A001', 'Sample Order 1');

-- Record 2
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (2, 150.50, 30.00, TO_DATE('2023-08-11','YYYY-MM-DD'), 'A002', 'Sample Order 2');

-- Record 3
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (3, 75.25, 10.00, TO_DATE('2023-08-12','YYYY-MM-DD'), 'A003', 'Sample Order 3');

-- Record 4
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (4, 200.00, 50.00, TO_DATE('2023-08-13','YYYY-MM-DD'), 'A004', 'Sample Order 4');

-- Record 5
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (5, 80.75, 15.00, TO_DATE('2023-08-14','YYYY-MM-DD'), 'A001', 'Sample Order 5');

-- Record 6
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (6, 300.00, 60.00, TO_DATE('2023-08-15','YYYY-MM-DD'), 'A002', 'Sample Order 6');

-- Record 15
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (7, 125.50, 25.00, TO_DATE('2023-08-24','YYYY-MM-DD'), 'A003', 'Sample Order 15');

-- Record 16
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (8, 180.25, 20.00, TO_DATE('2023-08-25','YYYY-MM-DD'), 'A004', 'Sample Order 16');

-- Record 17
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (9, 95.00, 10.00, TO_DATE('2023-08-26','YYYY-MM-DD'), 'A005', 'Sample Order 17');

-- Record 18
INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (10, 200.00, 40.00, TO_DATE('2023-08-27','YYYY-MM-DD'), 'A006', 'Sample Order 18');

INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (11, 50.75, 5.00, TO_DATE('2023-08-28','YYYY-MM-DD'), 'A001', 'Sample Order 19');

INSERT INTO ORDERS (OrdNum, OrdAmount, AdvanceAmount, OrdDate, AgentCode, OrderDescription)
VALUES (12, 300.00, 60.00, TO_DATE('2023-08-29','YYYY-MM-DD'), 'A004', 'Sample Order 20');

SELECT * FROM ORDERS;

CREATE TABLE NEWORDERS
AS
SELECT * FROM ORDERS WHERE 1 = 2;

SELECT * FROM  NEWORDERS;