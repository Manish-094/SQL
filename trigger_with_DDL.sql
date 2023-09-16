CREATE TABLE schema_audit(
   ddl_date DATE,
   dll_user VARCHAR2(15),
   object_created VARCHAR2(15),
   object_name VARCHAR2(15),
   ddl_operation VARCHAR2(15)
);

 CREATE OR REPLACE TRIGGER test_user1_audit
 AfTER DDL ON SCHEMA
 BEGIN
     INSERT INTO schema_audit VALUES
     (sysdate,
     sys_context('USERENV','CURRENT_USER'),
     ora_dict_obj_type,
     ora_dict_obj_name,
     ora_sysevent);
END;

SELECT * FROM schema_audit;

create table rebellionRider(r_num NUMBER);
INSERT INTO rebellionRider values(8,'MANISH');
INSERT INTO rebellionRider values(2,'BATMAN');
select * from rebellionRider;
TRUNCATE TABLE rebellionRider;
DROP TABLE rebellionRider;
ALTER TABLE rebellionRider ADD(name VARCHAR(20));
alter table rebellionRider modify(name varchar2(30));

create table rebellion2(id NUMBER);