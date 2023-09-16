CREATE TABLE employees (
  id NUMBER primary key,
  name VARCHAR2(100),
  salary NUMBER
);
drop table employees;
INSERT INTO employees (id, name, salary)
VALUES (1, 'John Doe', 5000);

INSERT INTO employees (id, name, salary)
VALUES (2, 'Jane Smith', 6000);

INSERT INTO employees (id, name, salary)
VALUES (3, 'Michael Johnson', 7000);

INSERT INTO employees (id, name, salary)
VALUES (4, 'Emily Davis', 5500);

INSERT INTO employees (id, name, salary)
VALUES (5, 'Robert Brown', 6500);

select * from employees;

--procedure to increase the salary
CREATE OR REPLACE PROCEDURE increase_salary_loop(
  p_percentage IN NUMBER
) AS
  v_employee_count NUMBER;
  my_exception EXCEPTION;
--  PRAGMA EXCEPTION_INIT(my_exception, -54321);
  v_employee_id employees.id%TYPE;
  v_employee_salary employees.salary%TYPE;
BEGIN
  SELECT COUNT(*) INTO v_employee_count FROM employees;
  
  FOR i IN 1..v_employee_count LOOP
    SELECT id, salary INTO v_employee_id, v_employee_salary
    FROM employees
    WHERE id = i;
    
    v_employee_salary := v_employee_salary + (v_employee_salary * p_percentage / 100);
    
    IF v_employee_salary > 10000 THEN
      --RAISE_APPLICATION_ERROR(-20001, 'Salary exceeds the maximum limit.');
      RAISE my_exception;
    END IF;
    
    UPDATE employees
    SET salary = v_employee_salary
    WHERE id = v_employee_id;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ': Salary increased to ' || v_employee_salary);
  END LOOP;
  
   DBMS_OUTPUT.PUT_LINE('Salary increase process completed successfully.');

    EXCEPTION
      WHEN my_exception THEN
        DBMS_OUTPUT.PUT_LINE('Salary exceeds the maximum limit.');
    
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    
END increase_salary_loop;
/

BEGIN
  increase_salary_loop(10);
END;
/

select * from employees;


