create table mv_table(
  id INT,
  name VARCHAR(20),
  age INT,
  salary NUMBER
);
/ 

-- PL/SQL block to insert 10 records with different names
BEGIN
  FOR i IN 1..100000 LOOP
    INSERT INTO mv_table (id, name, age, salary)
    VALUES (i, DBMS_RANDOM.string('U', 10), 20 + i, 1000 * i);
  END LOOP;
  COMMIT;
END;
/
create materialized view log on mv_table;
/*The REFRESH FAST ON DEMAND clause specifies that 
the materialized view should be refreshed quickly 
when requested and can be refreshed explicitly 
using the DBMS_MVIEW.REFRESH procedure.*/
CREATE  MATERIALIZED VIEW your_materialized_view
REFRESH FAST ON commit
AS
SELECT count(*)
FROM mv_table;
/

delete from mv_table where ID = 30128;
select count(*) from your_materialized_view;
select * from your_materialized_view;
EXEC DBMS_MVIEW.REFRESH('your_materialized_view','f');
