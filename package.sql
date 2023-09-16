--package specification (declaration)
CREATE OR REPLACE PACKAGE getData
AS
    FUNCTION getSum(num1 NUMBER, num2 NUMBER) RETURN NUMBER;
    PROCEDURE getsTable(p_limit IN NUMBER);
END;

--package body (definition)
CREATE OR REPLACE PACKAGE BODY getData
AS
    --Function body code
    FUNCTION getSum(num1 NUMBER, num2 NUMBER) RETURN NUMBER
    IS
    BEGIN
        RETURN num1 + num2;
    END getSum;

    --Procedure body code
    PROCEDURE getsTable(p_limit IN NUMBER)
    AS
        v_counter NUMBER := 1;
        v_result NUMBER;
    BEGIN
        FOR v_counter IN 1..p_limit LOOP
            v_result := 4 * v_counter;
            DBMS_OUTPUT.PUT_LINE('4 x ' || v_counter || ' = ' || v_result);
        END LOOP;
    END getsTable;
END getData;


--getSum function calling
set serveroutput on;
DECLARE
    result NUMBER;
BEGIN
    result := getData.getSum(3, 5);
    DBMS_OUTPUT.PUT_LINE('Sum: ' || result);
END;

--getsTable procedure calling
BEGIN
    getData.getsTable(10);
END;

