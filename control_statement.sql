--------------------SIMPLE LOOP---------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE 
     v_counter NUMBER :=0;
     v_result NUMBER;
BEGIN
     LOOP
        v_counter :=v_counter+1;
        v_result := 19*v_counter;
        DBMS_OUTPUT.PUT_LINE('19'||'x'||v_counter||' = ' ||v_result);
        IF v_counter>=10 THEN
          EXIT;
        END IF;
     END LOOP;
END;

----------WHILE LOOP----------------------------------------------
DECLARE 
       v_counter NUMBER :=1;
       v_result NUMBER;
BEGIN
     WHILE v_counter<=10 LOOP
       v_result := 19*v_counter;
       DBMS_OUTPUT.PUT_LINE('19'||'x'||v_counter||' = ' ||v_result);
       v_counter := v_counter+1;
     END LOOP;
END;

-------------BOOLEAN----------------------------------
DECLARE 
     v_test BOOLEAN := TRUE;
     v_counter NUMBER := 0;
BEGIN
     WHILE v_test LOOP
     v_counter := v_counter+1;
        DBMS_OUTPUT.PUT_LINE(v_counter);
        IF v_counter=10 THEN
           v_test:=FALSE;
        END IF;
      END LOOP;
END;

------------------FOR LOOP---------------------------------------
DECLARE
     v_result NUMBER;
BEGIN
     FOR v_counter IN 1 .. 10 LOOP
         v_result := 19*v_counter;
         DBMS_OUTPUT.PUT_LINE('19'||'x'||v_counter||' = ' ||v_result);
     END LOOP;
END;