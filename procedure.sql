-- Enable DBMS_OUTPUT
--SET SERVEROUTPUT ON;
-----------add tow number ------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE add_two_num(
  A IN NUMBER,
  B IN NUMBER,
  C OUT NUMBER
)
AS
BEGIN
     C:= A+B;
END;

VARIABLE c NUMBER;

EXECUTE add_two_num(2, 3, :c);

PRINT c;


----------------concat two string ------------------------------------------------------
CREATE OR REPLACE PROCEDURE concats_string(
  str1 IN VARCHAR,
  str2 IN VARCHAR,
  res OUT VARCHAR
)
AS
BEGIN
      res:=CONCAT(str1,str2);
END;

VARIABLE result VARCHAR2(100);
EXECUTE concats_string('HELLO','SQL',:result);
PRINT result;

-----------------------------------------procedure without parameter----------------------
CREATE OR REPLACE PROCEDURE spGetEmpoloyee
AS
v_name varchar(20);
BEGIN
    select name into v_name from temp1;
    DBMS_OUTPUT.PUT_LINE(v_name);
END;

execute spGetEmpoloyee;


-------------------------procedure without parameter------------------------------------------------------------------
create or replace PROCEDURE pr_by_products
AS
   v_product_code VARCHAR(20);
   v_price FLOAT;
BEGIN
    SELECT product_code,price INTO v_product_code,v_price FROM product
        WHERE product_name='samsung';
        
    INSERT INTO sales(product_code,quantity,price) VALUES(v_product_code,1,(v_price*1));
    
    UPDATE product SET quantity_remaining = (quantity_remaining-1),
    quantity_sold = (quantity_sold+1)
    WHERE product_code = v_product_code;
    
    DBMS_OUTPUT.PUT_LINE('Product Sold !');
END;


--------------------------procedure with parameter-----------------------------------------------

create or replace PROCEDURE pr_by_products(p_product_name VARCHAR,p_quantity INT)
AS
   v_product_code VARCHAR(20);
   v_price FLOAT;
   v_count INT;
BEGIN
    SELECT COUNT(1) INTO v_count FROM product
    WHERE product_name = p_product_name
    AND quantity_remaining>=p_quantity;
    if v_count>0 THEN
    
        SELECT product_code,price INTO v_product_code,v_price FROM product
        WHERE product_name='samsung';
        
        INSERT INTO sales(product_code,quantity,price) VALUES(v_product_code,p_quantity,(v_price*p_quantity));
        
        UPDATE product SET quantity_remaining = (quantity_remaining-p_quantity),
        quantity_sold = (quantity_sold+1)
        WHERE product_code = v_product_code;
        
        DBMS_OUTPUT.PUT_LINE('Product Sold !');
    else
          DBMS_OUTPUT.PUT_LINE('Insufficient quantity !');
    end if;
END;


----------------procedure with loop without parameter--------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE loop_procedure AS
   v_counter NUMBER := 0;
   v_result NUMBER;
BEGIN
   FOR v_counter IN 1..10 LOOP
      v_result := 19 * v_counter;
      DBMS_OUTPUT.PUT_LINE('19 x ' || v_counter || ' = ' || v_result);
   END LOOP;
END;

execute loop_procedure;

BEGIN
-- Call the procedure
   loop_procedure; 
END;

-------------------procedure  loop with prarameter------------------------------------------------------
CREATE OR REPLACE PROCEDURE loop_procedure(p_limit NUMBER) AS
   v_counter NUMBER := 0;
   v_result NUMBER;
BEGIN
   FOR v_counter IN 1..p_limit LOOP
      v_result := 4 * v_counter;
      DBMS_OUTPUT.PUT_LINE('4 x ' || v_counter || ' = ' || v_result);
   END LOOP;
END;

BEGIN
   loop_procedure(p_limit=>10);
END;




--VARIABLE c NUMBER;
--
--EXECUTE add_two_num(2, 3, :c);
--
--PRINT c;
--
---- Declare variables and execute the procedure
--DECLARE
--  v_c NUMBER;
--BEGIN
--  add_two_num(2, 3, v_c);
--  DBMS_OUTPUT.PUT_LINE(v_c);
--END;
