create user C##HR identified by hr123;
--alter session set "_ORACLE_SCRIPT"=true;
GRANT CREATE SESSION TO c##HR;
GRANT ALL PRIVILEGES TO c##HR;

CREATE user c##test_user1 identified by test_user1;
CREATE user c##test_user2 identified by test_user2;
create user c##test_user3 identified by user3;
create user c##test_user4 identified by user4;
GRANT create table,create view to c##test_user1 with admin option;
GRANT CREATE SESSION TO c##test_user1 with admin option;
GRANT CREATE SESSION TO c##test_user3;
GRANT CREATE SESSION TO c##test_user4;
-- Create the role c##mgr_role
CREATE ROLE c##mgr_role;
-- Grant privileges to c##mgr_role
GRANT create table,create sequence,create procedure,create view TO c##mgr_role;
GRANT select,update,delete,insert ON c##hr.employee TO c##mgr_role;
GRANT select any table,update any table,delete any table,insert any table TO c##mgr_role;
-- Grant privileges to c##test_user1
GRANT UNLIMITED TABLESPACE TO c##test_user1;
GRANT UNLIMITED TABLESPACE TO c##test_user2;
GRANT UNLIMITED TABLESPACE TO c##test_user3;
GRANT UNLIMITED TABLESPACE TO c##test_user4;

GRANT create procedure,create trigger,create materialized view,create any directory TO c##test_user1;
GRANT create procedure,create trigger,create materialized view,create any directory TO c##test_user3;
GRANT create procedure,create type,CREATE any  TABLE  to c##test_user4;
GRANT c##mgr_role TO  c##test_user3;
GRANT c##mgr_role TO c##test_user4;


SELECT * FROM USER_ROLE_PRIVS where granted_role = 'C##MGR_ROLE'; 
SHOW USER


select tablespace_name from user_tablespaces;
select tablespace_name,file_name,bytes from dba_data_files;


-- Grant necessary privileges for Oracle Scheduler
GRANT CREATE JOB TO c##test_user1;
GRANT CREATE EXTERNAL JOB TO your_user;
GRANT MANAGE SCHEDULER TO your_user;
GRANT EXECUTE ON DBMS_SCHEDULER TO c##test_user1;


--------------------DATABASE LEVEL TRIGGER WHICH SHOW THE LOGON AND LOGOFF FOR ALL THE USER----------------------------------
SHOW USER;


CREATE TABLE db_event_audit(
  user_name VARCHAR(20),
  event_type VARCHAR(20),
  logon_date DATE,
  logon_time VARCHAR(20),
  logof_date DATE,
  logof_time VARCHAR(20)
);

CREATE OR REPLACE TRIGGER db_logoff_audit
BEFORE LOGOFF ON DATABASE
BEGIN
   INSERT INTO db_event_audit VALUES(
    user,
    ora_sysevent,
    NULL,
    NULL,
    sysdate,
    TO_CHAR(SYSDATE,'hh24:mi:ss')
   );
COMMIT;
END;

select * from db_event_audit;


---------------------------------------------------------------------
select * from dba_directories;

create or replace directory DIR1 as 'C:\DIR1';

SELECT value FROM v$parameter WHERE name = 'undo_retention';
ALTER SYSTEM SET undo_retention = 3600;



drop directory DIR2;
-- Grant EXECUTE privilege on UTL_FILE package
GRANT EXECUTE ON UTL_FILE TO C##test_user1;

-- Grant READ and WRITE privileges on directory DIR1
GRANT READ, WRITE ON DIRECTORY DIR1 TO C##test_user1;

grant create database link to C##TEST_USER2;
-- Grant CREATE ANY DIRECTORY privilege to test_user1 (if needed)
GRANT CREATE ANY DIRECTORY TO C##test_user1;

-- Revoke CREATE ANY DIRECTORY privilege from test_user1 (if needed)
REVOKE CREATE ANY DIRECTORY FROM C##test_user1;

grant create synonym to c##test_user2;

select * from v$session;



CREATE TABLE Employees(
 emp_id INT PRIMARY KEY NOT NULL,
 emp_name VARCHAR2(25),
 age INT,
 salary number
);

INSERT INTO Employees(emp_id,emp_name,age,salary)VALUES(101,'Manish',22,20000);
INSERT INTO Employees(emp_id,emp_name,age,salary)VALUES(102,'Jack',23,30000);
INSERT INTO Employees(emp_id,emp_name,age,salary)VALUES(103,'Amit',24,40000);
INSERT INTO Employees(emp_id,emp_name,age,salary)VALUES(104,'Jimmy',25,50000);
INSERT INTO Employees(emp_id,emp_name,age,salary)VALUES(105,'Ali',26,60000);

SELECT * FROM Employee;

ALTER TABLE Employee DROP COLUMN age;

select object_name,object_type,created,status from user_objects WHERE object_type='TABLE';


----------------######BACKUP USER######-----------------------------------------------
CREATE USER c##SYS_BACKUP IDENTIFIED BY backup123;
GRANT SYSBACKUP TO c##SYS_BACKUP;

