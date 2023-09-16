-- Create the table
CREATE TABLE exec_plan_table (
  id INT,
  name VARCHAR2(20),
  age INT,
  salary NUMBER
);

SELECT index_name, index_type
FROM all_indexes
WHERE table_name = 'ORDERS';

create index id_indx ON exec_plan_table(id);
-- Insert records into the table
BEGIN
    FOR i IN 10..1000 LOOP
      INSERT INTO exec_plan_table(id, name, age, salary) VALUES
      (i, DBMS_RANDOM.string('U', 10), 10 + i, 1000 * i);
    END LOOP;
    COMMIT;
END;
/

-- Generate the execution plan
EXPLAIN PLAN FOR
SELECT * FROM exec_plan_table where id = 283;

-- Display the execution plan
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(NULL, NULL, 'ALL'));


