----------ATER LOGON-----------------------------------
CREATE TABLE test_user_event_audit(
  event_type VARCHAR2(20),
  logon_date DATE,
  logon_time VARCHAR2(15),
  logof_date DATE,
  logof_time VARCHAR2(15)
);

CREATE OR REPLACE TRIGGER user_logon_audit
AFTER LOGON ON SCHEMA
BEGIN
    INSERT INTO test_user_event_audit VALUES
    (ora_sysevent,
    sysdate,
    TO_CHAR(sysdate,'hh24:mi:ss'),
    null,
    null);
    COMMIT;
END;

select * from test_user_event_audit;

-----------BEFORE LOGOFF----------------------------------------

CREATE OR REPLACE TRIGGER log_off_audit
BEFORE LOGOFF ON SCHEMA
BEGIN
    INSERT INTO test_user_event_audit VALUES(
     ora_sysevent,
     NULL,
     NULL,
     SYSDATE,
     TO_CHAR(sysdate,'hh24:mi:ss'));
COMMIT;
END;

SELECT * FROM test_user_event_audit;
     