SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE my_job_proc AS
BEGIN
  -- PL/SQL statements to be executed as part of the job
  DBMS_OUTPUT.PUT_LINE('Job executed successfully!');
END;
/

--Step 1: Define the program:
BEGIN
  DBMS_SCHEDULER.CREATE_PROGRAM (
    program_name   => 'MY_PROGRAM',
    program_type   => 'PLSQL_BLOCK',
    program_action => 'BEGIN my_job_proc; END;'
  );
END;
/

--Step 2: Define the schedule:
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE (
    schedule_name => 'MY_SCHEDULE',
    start_date    => SYSTIMESTAMP,
    repeat_interval => 'FREQ=MINUTELY; INTERVAL=1'
  );
END;
/

--Step 3: Create the job:
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name       => 'MY_JOB',
    program_name   => 'MY_PROGRAM',
    schedule_name  => 'MY_SCHEDULE',
    enabled        => TRUE
  );
END;
/

BEGIN
  DBMS_SCHEDULER.drop_schedule (schedule_name => 'MY_SCHEDULE');
END;
/

 -- Run job synchronously.
 BEGIN
  DBMS_SCHEDULER.run_job (job_name=> 'MY_JOB',use_current_session => TRUE);
END;

--run the job
begin
    DBMS_SCHEDULER.RUN_JOB('MY_JOB');
END;
/
select  job_name, repeat_interval from user_scheduler_jobs;

BEGIN
  DBMS_SCHEDULER.ENABLE('C##TEST_USER1.MY_PROGRAM');
END;
/
SELECT * FROM user_SCHEDULER_JOB_RUN_DETAILS WHERE JOB_NAME = 'MY_JOB';
BEGIN
  DBMS_SCHEDULER.STOP_JOB('MY_JOB', force => TRUE);
END;
/
-- Display the program details.
SELECT  * FROM user_scheduler_programs;

BEGIN
  my_job_proc;
END;


BEGIN
   DBMS_SCHEDULER.disable('MY_JOB',force=>true);
END;
/




----------------------------------########################-------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;
--PLSQL_BLOCK
create table user_count(
  number_of_users NUMBER(4),
  time_of_day TIMESTAMP
);

--PROCEDURE
CREATE OR REPLACE PROCEDURE insert_user_count AS
  v_user_count NUMBER(4);
  initial_count NUMBER := 1;
BEGIN
   v_user_count := initial_count;
  INSERT INTO user_count VALUES (v_user_count, systimestamp);
  initial_count := initial_count+1;
  COMMIT;
END;
/
--create the program
BEGIN
     DBMS_SCHEDULER.CREATE_PROGRAM(
       program_name => 'PROG_INSERT_USER_COUNT',
       program_action => 'INSERT_USER_COUNT',
       program_type => 'STORED_PROCEDURE');
END;
/
--CREATE THE SCHEDULER
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
       schedule_name => 'my_weekend_1min_schedule',
       start_date => SYSTIMESTAMP,
       repeat_interval => 'FREQ=MINUTELY; INTERVAL=1',
       end_date => NULL,
       comments => 'Every 1 minute');
END;
/
--CREATE THE JOB
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
       job_name => 'my_user_count_job',
       program_name => 'prog_insert_user_count',
       schedule_name => 'my_weekend_1min_schedule',
       enabled => true);
END;
/

EXECUTE dbms_scheduler.enable('my_user_count_job');

select * from user_count;

select job_name, status, run_duration, cpu_used
from USER_SCHEDULER_JOB_RUN_DETAILS
where job_name = UPPER('my_user_count_job');



SELECT * FROM user_SCHEDULER_JOB_RUN_DETAILS WHERE JOB_NAME = UPPER('my_user_count_job');

BEGIN
   DBMS_SCHEDULER.DROP_PROGRAM(program_name => 'PROG_INSERT_USER_COUNT', force => TRUE);
END;
/
BEGIN
  DBMS_SCHEDULER.drop_schedule (schedule_name => 'my_weekend_1min_schedule', force => TRUE);
END;
/
begin
 DBMS_SCHEDULER.drop_job (job_name => 'my_user_count_job');
end;
/
BEGIN
   DBMS_SCHEDULER.disable('my_user_count_job');
END;
/

BEGIN
  -- Run job synchronously.
  DBMS_SCHEDULER.run_job (job_name=> 'my_user_count_job',use_current_session => TRUE);
END;
/
begin
   --Stop jobs.
   DBMS_SCHEDULER.stop_job (job_name => 'my_user_count_job');
end;
/
-- Display job details.
SELECT owner, job_name, enabled FROM all_scheduler_jobs;