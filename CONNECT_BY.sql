
CREATE TABLE Employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100),
    job_title VARCHAR2(100),
    manager_id NUMBER REFERENCES Employees(employee_id)
);
-- top to bottom hierarchical
SELECT employee_id,employee_name,job_title,manager_id,PRIOR employee_name,LEVEL
FROM Employees
WHERE LEVEL <= 3
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER BY LEVEL;

-- bottom to top hierarchical
SELECT employee_id,employee_name,job_title,manager_id,PRIOR employee_name,LEVEL
FROM Employees
WHERE LEVEL <= 3
START WITH manager_id = 2
CONNECT BY  employee_id = PRIOR manager_id
ORDER BY LEVEL;

-- specific information
SELECT employee_id,employee_name,job_title,manager_id,PRIOR employee_name,CONNECT_BY_ROOT employee_name,
SYS_CONNECT_BY_PATH(employee_name,'->')PATH,CONNECT_BY_ISLEAF, LEVEL
FROM Employees
WHERE LEVEL <= 4
START WITH employee_name = 'John CEO'
CONNECT BY PRIOR employee_id = manager_id
ORDER BY LEVEL;

SELECT employee_id,employee_name,job_title,manager_id
FROM Employees
START WITH manager_id = 1
CONNECT BY PRIOR employee_id = manager_id;

SELECT employee_id,employee_name,job_title,manager_id
FROM Employees
START WITH employee_name = 'Charlie Marketing Manager'
CONNECT BY PRIOR employee_id = manager_id;


SELECT * FROM Employees;



 CREATE TABLE AD_CODE_HIRE_FILTER(
   MANAGER_TYPE VARCHAR2(100),
   EMPLOYEE_ID NUMBER,
   EMPLOYEE_NAME VARCHAR2(100),
   TOP_REPORTING_MANAGER VARCHAR2(100), 
   MANAGER_LEVEL NUMBER
 );
 INSERT INTO AD_CODE_HIRE_FILTER(MANAGER_TYPE,EMPLOYEE_ID,EMPLOYEE_NAME,TOP_REPORTING_MANAGER,MANAGER_LEVEL)
 SELECT 'DIRECT' MANAGER_TYPE,employee_id,employee_name,CONNECT_BY_ROOT employee_name,LEVEL
 FROM Employees
 WHERE  LEVEL <= 3
 START WITH manager_id IS NULL
 CONNECT BY PRIOR employee_id = manager_id;

SELECT * FROM AD_CODE_HIRE_FILTER;
truncate table AD_CODE_HIRE_FILTER;
/*

   CEO (John CEO)
   |
   ??? Vice President of Marketing (Alice VP Marketing)
   ?   |
   ?   ??? Marketing Manager (Charlie Marketing Manager)
   ?   ?   |
   ?   ?   ??? Marketing Specialist 1 (Eve Marketing Specialist 1)
   ?   ?   ??? Marketing Specialist 2 (Frank Marketing Specialist 2)
   ?   ??? Marketing Manager (Isaac Marketing Manager)
   ?       |
   ?       ??? Marketing Specialist 3 (Kevin Marketing Specialist 3)
   ?       ??? Marketing Specialist 4 (Michael Marketing Specialist 4)
   ?
   ??? Vice President of Sales (Bob VP Sales)
       |
       ??? Sales Manager (David Sales Manager)
       ?   |
       ?   ??? Sales Representative 1 (Grace Sales Representative 1)
       ?   ??? Sales Representative 2 (Helen Sales Representative 2)
       ??? Sales Manager (Jasmine Sales Manager)
           |
           ??? Sales Representative 3 (Linda Sales Representative 3)
           ??? Sales Representative 4 (Nina Sales Representative 4)


                  CEO (John CEO)
                 /                   \
    VP Marketing (Alice VP Marketing)  VP Sales (Bob VP Sales)
     /              \               /               \
Marketing Mgr   Marketing Mgr    Sales Mgr       Sales Mgr
   /   \            /   \          /   \            /   \
Mkt Spcl  Mkt Spcl Mkt Spcl Mkt Spcl Sales Rep Sales Rep
*/
