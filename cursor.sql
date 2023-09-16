CREATE TABLE employee1 (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    salary NUMBER(10, 2)
);

INSERT INTO employee1 VALUES (1, 'John', 'Doe', TO_DATE('01-01-2001','DD-MM-YYYY'), 5000);
INSERT INTO employee1 VALUES (2, 'Jane', 'Smith', TO_DATE('01-01-2022','DD-MM-YYYY'), 6000);
INSERT INTO employee1 VALUES (3, 'Michael', 'Johnson', TO_DATE('01-10-2022','DD-MM-YYYY'), 8000);
INSERT INTO employee1 VALUES (4, 'Manish', 'Patel', TO_DATE('02-04-2023','DD-MM-YYYY'), 7000);
INSERT INTO employee1 VALUES (5, 'Abhishek', 'Patel', TO_DATE('03-05-2011','DD-MM-YYYY'), 2000);

select rowid , rownum,m. * from employee1 m where rownum < 3;


--cursor without parameter
set serveroutput on;
DECLARE
    v_emp_id employee1.employee_id%TYPE;
    v_first_name employee1.first_name%TYPE;
    v_last_name employee1.last_name%TYPE;

    --DECLARE THE CURSOR
    CURSOR cur_manish IS
    SELECT employee_id,first_name,last_name FROM employee1
    WHERE employee_id>2;
BEGIN
    OPEN cur_manish;
    LOOP
       FETCH cur_manish INTO v_emp_id,v_first_name,v_last_name;
       EXIT WHEN cur_manish%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE(v_emp_id||' '||v_first_name||' '||v_last_name);
    END LOOP;
    CLOSE cur_manish;
END;


--cursor with parameter
DECLARE 
      v_name employee1.first_name%TYPE;
      CURSOR cur_with_para(emp_id INT)IS
      SELECT first_name
      from employee1 where employee_id>emp_id;
BEGIN
     OPEN  cur_with_para(3);
     -- Check if the cursor is open
     IF cur_with_para%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is open');
     ELSE
       DBMS_OUTPUT.PUT_LINE('Cursor is closed');
    END IF;
    LOOP 
      FETCH cur_with_para INTO v_name;
      EXIT WHEN cur_with_para%NOTFOUND;
      IF cur_with_para%FOUND THEN
        DBMS_OUTPUT.PUT_LINE(v_name);
      END IF;
    END LOOP;
     -- Display the row count
    DBMS_OUTPUT.PUT_LINE('Total Rows Fetched: ' || cur_with_para%ROWCOUNT);
    close cur_with_para;
END;

--CURSOR WITH LOOP
declare
     CURSOR loop_cursor IS
     SELECT first_name,last_name from employee1
     where employee_id>2;
begin
     for l_indx IN loop_cursor
       loop
          dbms_output.put_line(l_indx.first_name||' '||l_indx.last_name);
       end loop;
end;


--ROWTYPE USE
DECLARE
  v_employee employee1%ROWTYPE;
BEGIN
  -- Assign values to the record variable
  v_employee.employee_id := 6;
  v_employee.first_name := 'Ajeet';
  v_employee.last_name := 'Mishra';
  v_employee.salary := 3000;
  
  -- Use the record variable in SQL statements
  INSERT INTO employee1 VALUES v_employee;
  
END;


      