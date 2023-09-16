 ---------------function--------------------------- 
create or replace FUNCTION GetSum(num1 NUMBER,num2 NUMBER) RETURN NUMBER
IS
    BEGIN
        RETURN num1+num2;
    END;

-------------------function calling------------------------------
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total is '|| GetSum(2,5));
END;


--procedure creating------------------------------
CREATE OR REPLACE PROCEDURE getTable(p_limit INT)
as
   v_counter NUMBER := 1;
   v_result NUMBER;
BEGIN
     FOR v_counter IN 1..p_limit LOOP
        v_result := 4*v_counter;
        DBMS_OUTPUT.PUT_LINE('4 x ' || v_counter || ' = ' || v_result);
     END LOOP;
END;

-------------calling procedure----------------------
BEGIN
   getTable(10);
END;


--prime number between range
set serveroutput on;
DECLARE
  lower_limit NUMBER := 1; -- Replace with your lower limit
  upper_limit NUMBER := 100; -- Replace with your upper limit
BEGIN
  FOR num IN lower_limit..upper_limit LOOP
    IF num > 1 THEN
      DECLARE
        is_prime BOOLEAN := TRUE;
      BEGIN
        FOR i IN 2..TRUNC(SQRT(num)) LOOP
          IF MOD(num, i) = 0 THEN
            is_prime := FALSE;
            EXIT;
          END IF;
        END LOOP;

        IF is_prime THEN
          DBMS_OUTPUT.PUT_LINE(num);
        END IF;
      END;
    END IF;
  END LOOP;
END;
/
