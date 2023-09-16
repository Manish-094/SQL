CREATE TABLE superheroes(
  sh_name VARCHAR2(20)
);

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER tr_superheroes
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
    v_user VARCHAR2(20);
BEGIN
     SELECT user INTO v_user FROM DUAL;
     IF INSERTING THEN
     DBMS_OUTPUT.PUT_LINE('One row Inserted by '||v_user);
     ELSIF DELETING THEN
     DBMS_OUTPUT.PUT_LINE('One row Deleted by '||v_user);
     ELSIF UPDATING THEN
     DBMS_OUTPUT.PUT_LINE('One row updated by '||v_user);
     END IF;
END;

INSERT INTO superheroes VALUES('MANISH');
update superheroes set sh_name = 'Ajeet' where sh_name = 'MANISH';
DELETE FROM superheroes WHERE sh_name = 'Ajeet';
DROP TABLE superheroes;
truncate table superheroes;

/*SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER bi_superheroes
BEFORE INSERT ON superheroes
FOR EACH ROW
ENABLE
DECLARE
   v_user VARCHAR2(20);
BEGIN
    SELECT user INTO v_user FROM dual;
    DBMS_OUTPUT.PUT_LINE('You just inserted A line Mr.'||v_user);
END;

insert into superheroes values('manish');*/


CREATE TABLE sh_audit(
  new_name VARCHAR2(30),
  old_name VARCHAR2(30),
  user_name VARCHAR2(30),
  entry_date VARCHAR2(30),
  operation  VARCHAR2(30)
);

CREATE OR REPLACE trigger superheroes_audit
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
      v_user VARCHAR2(30);
      v_date VARCHAR2(30);
BEGIN
    SELECT user,TO_CHAR(sysdate,'DD/MON/YYYY HH24:MI:SS') INTO v_user,v_date FROM DUAL;
    IF INSERTING THEN
          INSERT INTO sh_audit(new_name,old_name,user_name,entry_date,operation)
          VALUES (:NEW.sh_name,NULL,v_user,v_date,'INSERT');
    ELSIF DELETING THEN
           INSERT INTO sh_audit (new_name,old_name,user_name,entry_date,operation)
           VALUES (NULL,:OLD.sh_name,v_user,v_date,'DELETE');
    ELSIF UPDATING THEN
           INSERT INTO sh_audit (new_name,old_name,user_name,entry_date,operation)
           VALUES (:NEW.sh_name,:OLD.sh_name,v_user,v_date,'UPDATE');
    END IF;
END;

DROP TRIGGER superheroes_audit;
drop table sh_audit;

SELECT * FROM sh_audit;
INSERT INTO superheroes VALUES('BATMAN');
UPDATE superheroes SET sh_name = 'MANISH' WHERE sh_name = 'BATMAN';
DELETE FROM superheroes WHERE sh_name = 'SUPERMAN';

SELECT * FROM ALL_ERRORS WHERE NAME = 'TR_SUPERHEROES' AND TYPE = 'TRIGGER' AND OWNER = 'C##TEST_USER1';

SELECT * FROM superheroes;
ALTER TRIGGER C##TEST_USER1.TR_SUPERHEROES ENABLE;
DROP TRIGGER C##TEST_USER1.TR_SUPERHEROES;

--------------------------backup table------------------------------------------------------

desc superheroes;
create table superheroes_backup 
as select * from superheroes where 1 = 2;

CREATE OR REPLACE TRIGGER sh_backup
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
BEGIN
    IF INSERTING THEN
       INSERT INTO superheroes_backup(sh_name) VALUES(:NEW.sh_name);
    ELSIF DELETING THEN
        DELETE FROM superheroes_backup WHERE sh_name = :OLD.sh_name;
    ELSIF UPDATING THEN
         UPDATE superheroes_backup SET sh_name = :NEW.sh_name WHERE sh_name = :OLD.sh_name;
    END IF;
END;
select * from superheroes_backup;

SELECT * FROM superheroes;
INSERT INTO superheroes VALUES('BATMAN');
INSERT INTO superheroes VALUES('MANISH');
INSERT INTO superheroes VALUES('superman');

update superheroes set sh_name = 'SPIDERMAN' WHERE sh_name = 'MANISH';
DELETE FROM superheroes WHERE sh_name = 'SPIDERMAN';


SELECT * FROM ALL_TRIGGER_COLS;