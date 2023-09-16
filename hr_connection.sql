show user;
create user C##manager identified by mg123;

--alter session set "_ORACLE_SCRIPT"=true;
GRANT CREATE SESSION TO C##manager;
GRANT ALL PRIVILEGES TO C##manager;

create user C##admin identified by admin123;

--alter session set "_ORACLE_SCRIPT"=true;
GRANT CREATE SESSION TO C##admin;
GRANT ALL PRIVILEGES TO C##admin;

GRANT SELECT ON employee TO C##test_user1 WITH GRANT OPTION;
--creating a table of name Employee

CREATE TABLE employee (
    emp_id         INT PRIMARY KEY NOT NULL,
    emp_name       VARCHAR2(25),
    age            INT,
    salary         NUMBER,
    commission_pct NUMBER
);
select count(*) from employee;
--inserting data in Employee table
INSERT INTO employee (emp_id,emp_name,age,salary,commission_pct) 
VALUES (101,'Manish',22,20000,2);

INSERT INTO employee (emp_id,emp_name,age,salary,commission_pct)
VALUES (102,'Jack',22,30000,4);

INSERT INTO employee (emp_id,emp_name,age,salary,commission_pct)
VALUES (103,'Amit',24,40000,6);

INSERT INTO employee (emp_id,emp_name,age,salary,commission_pct)
VALUES (104,'Jimmy',25,50000,7);

INSERT INTO employee (emp_id,emp_name,age,salary,commission_pct)
VALUES (105,'Ali',22,60000,8);

DROP TABLE employee;

TRUNCATE TABLE employee;

SELECT * FROM employee;

SELECT * FROM employee
WHERE age = &empid
ORDER BY &col_name;

SELECT ceil(76.28),floor(76.82)FROM dual;

SELECT upper(emp_name),initcap('this is the test string')
FROM employee
WHERE emp_id = 102;

ALTER TABLE employee DROP COLUMN age;

ALTER TABLE employee ADD(age INT);

ALTER TABLE employee ADD (commission_pct NUMBER);

SELECT sysdate FROM dual;

SELECT current_date,current_timestamp FROM dual;

SELECT sysdate,round(sysdate, 'MONTH') "ROUND",trunc(sysdate, 'MONTH') "TRUNC"
FROM dual;

SELECT sysdate,sysdate - 1 "YESTERDAY",sysdate + 1 "TOMORROW"
FROM dual;

SELECT sysdate,to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') FROM dual;

SELECT sysdate,to_char(sysdate, 'YYYY-Mon-Day HH:MI:SS PM') FROM dual;

SELECT sysdate,to_char(sysdate, 'fmDY-MONTH "of" YYYY HH24:MI:SS')
FROM dual;

SELECT emp_name,salary,to_char(salary, '$99,999.99') "format 1"
FROM employee;

SELECT sysdate,to_char(add_months(sysdate, 4),'YYYY/MM/DD HH24:MI:SS'),
to_char(sysdate, 'Day,"the" Ddspth "of" MONTH,YYYY') FROM dual;

ALTER SESSION SET nls_currency = '€';
SELECT emp_name || ' earns ' || to_char(salary, 'L99,999.99') || ' 
monthly but wants '|| salary * 3 FROM employee
WHERE emp_id = 101;

SELECT TO_NUMBER('$76,746.45', '$99,999.99') + 1000 FROM dual;

SELECT TO_DATE('17-05-2023', 'DD-MM-YYYY') FROM dual;

UPDATE employee SET commission_pct = NULL WHERE emp_id = 102;

SELECT emp_name,salary,commission_pct,nvl(commission_pct, 0),
( salary * 2 ) + ( salary * 4 * nvl(commission_pct, 0) )
FROM employee;

SELECT emp_name,salary,commission_pct,nvl2(commission_pct, 'Has com', 'No com') "Com ?",
( salary * 2 ) + ( salary * 3 * nvl2(commission_pct, commission_pct, 0) ) "Annual Salary"
FROM employee;

SELECT emp_name,salary,emp_id,
       CASE
           WHEN emp_id = 101 THEN
               salary + 1000
           WHEN emp_id = 102 THEN
               salary + 2000
           WHEN emp_id = 103 THEN
               salary + 3000
           ELSE
               salary
       END AS "New Salary"
FROM employee;

SELECT emp_id,emp_name,salary,
       decode(emp_id, 101, salary + 1000, 
              102, salary + 2000,
              103, salary + 3000, 
              salary) AS "New Salary"
FROM employee;

SELECT AVG(nvl(commission_pct, 0)) FROM employee;

--It provides information about all objects that you own
SELECT object_name,object_type,status,created from user_objects;
/*
It provides information about all the objects that you own and also 
get the information about other users that you have access*/
SELECT owner,object_name,object_type,status,created from all_objects 
where object_type='TABLE';

--get all the information about all the tables that you own 
select table_name,tablespace_name,status,read_only from user_tables;
/*
It provides information about all the tables that you own and also 
get the information about other users tables that you have access*/
select owner,table_name,status,read_only from all_tables;

--get all the information about all the COLUMNS that you own 
select column_name,data_type,data_length,nullable from USER_TAB_COLUMNS 
where table_name = '&table_name';
/*
It provides information about all the table columns that you own and also 
get the information about other users table columns that you have access*/
select owner,column_name,data_type,data_length from ALL_TAB_COLUMNS 
where table_name='EMPLOYEE';

SELECT table_name,constraint_name,constraint_type,delete_rule,status 
from USER_CONSTRAINTS where table_name = '&table_name';

SELECT table_name,constraint_name,column_name
from USER_CONS_COLUMNS where table_name = '&table_name';





CREATE  VIEW emp1 as 
SELECT * FROM employee WHERE emp_id = 101;

CREATE or REPLACE VIEW emp2 as 
SELECT emp_name,emp_id,age,salary FROM employee WHERE emp_id = 102;

select * from emp2;
select * from emp1;
 
delete from employee where emp_id = 101;

select view_name,text from user_views;
select view_name,text from all_views;
select * from user_views;

create SEQUENCE dept_seq
start with 1
increment by 5
MAXVALUE 20
NOCACHE
NOCYCLE

create table emp12(
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(20),
  age INT
);

insert into emp12 values(emp_id_seq.NEXTVAL,'jonathan',32);
select * from emp12;

select emp_id_seq.currval from dual;
select emp_id_seq.nextval from dual;
create sequence emp_id_seq
start with 1
increment by 2
maxvalue 20
NOCACHE
NOCYCLE


select sequence_name,min_value,max_value,
increment_by,last_number,cycle_flag from user_sequences;

create synonym emp_id_sequence for  emp_id_seq;
CREATE SYNONYM EMP for emp12;
select * from EMP;
select emp_id_sequence.currval from dual;

select * from user_synonyms;
drop synonym emp_id_sequence;

CREATE INDEX emp_id_idx ON emp12(emp_name);

select table_name,index_name,index_type,uniqueness from user_indexes;
select table_name,index_name,index_type,uniqueness from all_indexes;
select table_name,index_name,column_name 
from user_ind_columns where table_name='EMP12';
select table_name,index_name,column_name from all_ind_columns;
drop index emp_id_idx;


CREATE TABLE my_dept(
  dept_id NUMBER,
  dept_name VARCHAR2(200)
);
SELECT * FROM my_dept;
ALTER TABLE my_dept ADD CONSTRAINT my_dept_id_pk PRIMARY KEY(dept_id);

INSERT INTO my_dept VALUES(1,'Marketing');
INSERT INTO my_dept VALUES(1,'Hr');
INSERT INTO my_dept VALUES(2,'Manager');

desc user_constraints;
SELECT table_name,constraint_name,constraint_type,status,validated
from user_constraints where table_name='MY_DEPT';

--disabled the constraint and denied all the DML operaation (we cannot perform any DML operation)
ALTER TABLE my_dept disable validate constraint my_dept_id_pk;
--disabled the constraint and also we can perform all the DML operations
ALTER TABLE my_dept disable novalidate constraint my_dept_id_pk;
ALTER TABLE my_dept ENABLE constraint my_dept_id_pk;
/*
it rollback the transaction, it check constraints until the end of the transaction
here we defined dept_name unique but we provide dept_name dublicate it will 
run but we commit(means end of the transaction it will show error)*/
ALTER TABLE my_dept add constraint my_dept_name_un UNIQUE(dept_name)
DEFERRABLE INITIALLY DEFERRED;
INSERT INTO my_dept VALUES(3,'Manager');
INSERT INTO my_dept VALUES(4,'Manager');
commit;
ALTER TABLE my_dept DROP CONSTRAINT my_dept_name_un;

CREATE GLOBAL TEMPORARY TABLE emp_temp
ON COMMIT PRESERVE ROWS
AS
select * from my_dept;
SELECT * FROM emp_temp;

CREATE TABLE TEMPORARY TABLE emp_temp2
ON COMMIT DELETE ROWS
as
select * from my_dept where dept_id = 1;

CREATE GLOBAL TEMPORARY TABLE my_temp_items(
 item_id number(5),
 item_name varchar2(50),
 item_description varchar2(100)
)
ON COMMIT PRESERVE ROWS;

INSERT INTO my_temp_items VALUES(2,'PC','Computer');
select * from my_temp_items;
commit;

create table emp23(
 emp_id INT,
 emp_name varchar(20)
);
drop table emp23;
insert into emp23 values(1,'MANISH');
select * from emp23;

create global temporary table my_temp_items2(
  item_id number(5),
 item_name varchar2(50),
 item_description varchar2(100)
)
ON COMMIT DELETE ROWS;
insert into my_temp_items2 values(1,'tv','telivision');
select * from my_temp_items2;
commit;