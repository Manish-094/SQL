create table startup_audit(
  event_type VARCHAR2(30),
  event_date DATE,
  event_time VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER tr_startup_audit
AFTER STARTUP ON DATABASE
BEGIN
    INSERT INTO startup_audit VALUES(
    ora_sysevent,
    sysdate,
    TO_CHAR(SYSDATE,'hh24:mi:ss')
    );
commit;
END;
select * from startup_audit;
drop table startup_audit;
