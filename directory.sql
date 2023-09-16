create or replace directory DIR2 AS 'C:\USER_DIR\';

DECLARE
     F1 UTL_FILE.FILE_TYPE;
BEGIN
         F1:=UTL_FILE.FOPEN('DIR2','HELLO.TXT','W');
         UTL_FILE.PUT_LINE(F1,'HELLO HOW ARE YOU PUT_LINE !');
         UTL_FILE.PUTF(F1,'HEYY I AM\n THE FORMATTER\n');
         UTL_FILE.PUT(F1,'HELLO SQL HOW ARE\n YOU !');
         UTL_FILE.FCLOSE(F1);
         DBMS_OUTPUT.PUT_LINE('FILE CREATED');
         EXCEPTION
             WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR'||TO_CHAR(SQLCODE)||SQLERRM);
END;


--------------open and write into the file------------------------------------------------------------------------------------------------------

DECLARE
  F1 UTL_FILE.FILE_TYPE;
BEGIN
  F1 := UTL_FILE.FOPEN('DIR2', 'HELLO.TXT', 'W');
  DBMS_OUTPUT.PUT_LINE('File opened successfully.');

  UTL_FILE.PUT_LINE(F1, 'HELLO HOW ARE YOU PUT_LINE !');
  UTL_FILE.PUTF(F1, 'HEYY I AM' || CHR(10) || 'THE FORMATTER' || CHR(10));
  UTL_FILE.PUT(F1, 'HELLO SQL HOW ARE' || CHR(10) || 'YOU !');
  DBMS_OUTPUT.PUT_LINE('Data written successfully.');

  UTL_FILE.FCLOSE(F1);
  DBMS_OUTPUT.PUT_LINE('File closed successfully.');
EXCEPTION
  WHEN UTL_FILE.INVALID_OPERATION THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
  WHEN UTL_FILE.INVALID_PATH THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file path.');
  WHEN UTL_FILE.ACCESS_DENIED THEN
    DBMS_OUTPUT.PUT_LINE('Access denied to the file or directory.');
  WHEN UTL_FILE.INVALID_MODE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
  WHEN UTL_FILE.INTERNAL_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
  WHEN UTL_FILE.WRITE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred while writing to the file.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLCODE || ' - ' || SQLERRM);
END;

-----------open file and read the csv file----------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
  v1 VARCHAR2(20000);
  F1 UTL_FILE.FILE_TYPE;
   line_number NUMBER := 1;
BEGIN
  F1 := UTL_FILE.FOPEN('DIR2', 'Training Points - SQL Training Points.CSV', 'R');
  DBMS_OUTPUT.PUT_LINE('FILE OPEN SUCCESSFULLY !');
  LOOP
    BEGIN
      UTL_FILE.GET_LINE(F1, v1);
--      DBMS_OUTPUT.PUT_LINE(v1);
 -- Output the line number and the line content
      DBMS_OUTPUT.PUT_LINE('Line ' || line_number || ': ' || v1);
      
      line_number := line_number + 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        EXIT;
      WHEN UTL_FILE.INVALID_OPERATION THEN
        DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
        EXIT;
      WHEN UTL_FILE.INVALID_FILEHANDLE THEN
        DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
        EXIT;
      WHEN UTL_FILE.INVALID_MODE THEN
        DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
        EXIT;
      WHEN UTL_FILE.INVALID_PATH THEN
        DBMS_OUTPUT.PUT_LINE('Invalid file path.');
        EXIT;
      WHEN UTL_FILE.ACCESS_DENIED THEN
        DBMS_OUTPUT.PUT_LINE('Access denied to the file or directory.');
        EXIT;
      WHEN UTL_FILE.INTERNAL_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
        EXIT;
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLCODE || ' - ' || SQLERRM);
        EXIT;
    END;
  END LOOP;
  UTL_FILE.FCLOSE(F1);
EXCEPTION
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
  WHEN UTL_FILE.INTERNAL_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLCODE || ' - ' || SQLERRM);
END;


--------------write table data into flat file (csv file)-------------------------------------------------------
DECLARE
     F1 UTL_FILE.FILE_TYPE;
     
BEGIN
     F1 := UTL_FILE.FOPEN('DIR2','data2.csv','w');
     FOR I IN (SELECT * FROM Employee)
     LOOP
        UTL_FILE.PUT_LINE(F1,I.emp_id||','||I.first_name||','||I.last_name||
        ','||I.birth_day||','||I.sex||','||I.salary||','||I.super_id||','||I.branch_id);
     END LOOP;
     UTL_FILE.FCLOSE(F1);
END;

----------------writing table data into the file using cursor---------------------------------------
DECLARE
   F1 UTL_FILE.FILE_TYPE;
   CURSOR C1 IS SELECT * FROM Employee;
   I C1%ROWTYPE;
BEGIN
    F1 := UTL_FILE.FOPEN('DIR2','data6.txt','w');
    OPEN C1;
    LOOP
    FETCH C1 INTO I;
    EXIT WHEN C1%NOTFOUND;
     UTL_FILE.PUT_LINE(F1,I.emp_id||','||I.first_name||','||I.last_name||
        ','||I.birth_day||','||I.sex||','||I.salary||','||I.super_id||','||I.branch_id);
        
    END LOOP;
    CLOSE C1;
    UTL_FILE.FCLOSE(F1);
END;

---------copy file data from one directory to another,HERE I AM USING SAME DIRECTORY-------------------------------------------------------------

BEGIN
    UTL_FILE.FCOPY('DIR2','data2.csv','DIR2','employee1.csv');
END;

----------REMOVE FILE FROM EXISTING DIRECTORY--------------------------------------------------------------
BEGIN
    UTL_FILE.FREMOVE('DIR2','employee1.csv');
END;

---------------RENAME THE FILENAME----------------------------------------------------------------
BEGIN
   UTL_FILE.FRENAME('DIR2','data2.csv','DIR2','datas.csv',TRUE);
END;


------------------------FGETATTR--------------------------------------
DECLARE
     file_exist BOOLEAN;
     file_len NUMBER;
     block_size NUMBER;
BEGIN
     UTL_FILE.FGETATTR('DIR2','employee.csv',file_exist,file_len,block_size);
     IF file_exist THEN
       DBMS_OUTPUT.PUT_LINE('FILE EXIST');
     ELSE
        DBMS_OUTPUT.PUT_LINE('FILE DOES NOT EXIST');
     END IF;
     DBMS_OUTPUT.PUT_LINE('FILE LENGTH : '||TO_CHAR(file_len));
     DBMS_OUTPUT.PUT_LINE('BLOCK SIZE : '||TO_CHAR(block_size));
END;











---------------------------------------------------------------------------------------------------------------------------
DECLARE
  F1 UTL_FILE.FILE_TYPE;
BEGIN
  -- Attempt to open the file
  BEGIN
    F1 := UTL_FILE.FOPEN('DIR2', 'HELLO.TXT', 'W');
    DBMS_OUTPUT.PUT_LINE('File opened successfully.');
  EXCEPTION
    WHEN UTL_FILE.INVALID_OPERATION THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
    WHEN UTL_FILE.INVALID_PATH THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file path.');
    WHEN UTL_FILE.ACCESS_DENIED THEN
      DBMS_OUTPUT.PUT_LINE('Access denied to the file or directory.');
    WHEN UTL_FILE.INVALID_MODE THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
    WHEN UTL_FILE.INTERNAL_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unexpected error occurred while opening the file: ' || SQLCODE || ' - ' || SQLERRM);
  END;

  -- Write data to the file
  BEGIN
    UTL_FILE.PUT_LINE(F1, 'HELLO HOW ARE YOU PUT_LINE !');
    UTL_FILE.PUTF(F1, 'HEYY I AM' || CHR(10) || 'THE FORMATTER' || CHR(10));
    UTL_FILE.PUT(F1, 'HELLO SQL HOW ARE' || CHR(10) || 'YOU !');
    DBMS_OUTPUT.PUT_LINE('Data written successfully.');
  EXCEPTION
    WHEN UTL_FILE.WRITE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Error occurred while writing to the file.');
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
    WHEN UTL_FILE.INVALID_OPERATION THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file operation.');
    WHEN UTL_FILE.INVALID_MODE THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file mode.');
    WHEN UTL_FILE.INTERNAL_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unexpected error occurred while writing to the file: ' || SQLCODE || ' - ' || SQLERRM);
  END;

  -- Close the file
  BEGIN
    UTL_FILE.FCLOSE(F1);
    DBMS_OUTPUT.PUT_LINE('File closed successfully.');
  EXCEPTION
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      DBMS_OUTPUT.PUT_LINE('Invalid file handle.');
    WHEN UTL_FILE.INTERNAL_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('Internal error occurred.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unexpected error occurred while closing the file: ' || SQLCODE || ' - ' || SQLERRM);
  END;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLCODE || ' - ' || SQLERRM);
END;


------------------------External table fetching data from flat file----------------------------------------------
create or replace directory external_dir as 'D:\External';

create table External_table(
  v_num number(5),
  v_name varchar(20)
)
ORGANIZATION EXTERNAL(
TYPE ORACLE_LOADER
DEFAULT DIRECTORY external_dir
ACCESS PARAMETERS(
RECORDS DELIMITED BY NEWLINE
FIELDS TERMINATED BY ','
)
LOCATION ('Sample_file.txt')
);


select * from External_table;
-------------READ CSV FILE-------------------------------------------------------------------

set SERVEROUTPUT on;
CREATE TABLE External_table2 (
  v_num INT,
  v_name VARCHAR(20)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY external_dir
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
    ( 
      v_num CHAR(255),
      v_name CHAR(255)
    )
  )
  LOCATION ('data2.csv')
) 
PARALLEL 5 --This line specifies that parallel processing with a degree of 5 should be used when accessing the external table.
REJECT LIMIT UNLIMITED;


SELECT * FROM External_table2;

------------------create view using external table----------------------------------------------
create or replace view external_view
as
select * from External_table2;

select * from external_view;
