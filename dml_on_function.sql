CREATE TABLE bank (
  accountno integer PRIMARY KEY,
  balance numeric,
  account_holder varchar(100)
);

INSERT INTO bank (accountno, balance, account_holder)VALUES(1, 1000.0, 'John Doe');
INSERT INTO bank (accountno, balance, account_holder) VALUES (2, 500.0, 'Jane Smith');
INSERT INTO bank (accountno, balance, account_holder) VALUES  (3, 2000.0, 'Alice Johnson');

select * from bank;

CREATE or replace FUNCTION tf1(accountno_in integer, debit numeric)return number is
account_balance number;
BEGIN
    UPDATE bank
    SET balance = balance - debit
    WHERE accountno = accountno_in;
    
    SELECT balance INTO account_balance FROM bank WHERE accountno = accountno_in;
    RETURN account_balance;
END;
/

CREATE OR REPLACE FUNCTION insert_into_bank(accountno IN INTEGER, balance IN NUMBER, account_holder IN VARCHAR2)
RETURN NUMBER
IS
BEGIN
    INSERT INTO bank (accountno, balance, account_holder)
    VALUES (accountno, balance, account_holder);

    RETURN 1; -- Indicate successful insertion
END;
/
--insert
BEGIN
    DBMS_OUTPUT.PUT_LINE(insert_into_bank(5, 1500.0, 'Jaimin Johnson'));
END;
/

CREATE OR REPLACE FUNCTION delete_from_bank(accountno IN INTEGER)
RETURN NUMBER IS
BEGIN
    DELETE FROM bank WHERE accountno = delete_from_bank.accountno;
    RETURN 1;
    COMMIT; -- Commit the changes
END;
/
--delete
BEGIN
    delete_from_bank(3);
    DBMS_OUTPUT.PUT_LINE('Deletion successful.');
END;
/


--update
set SERVEROUTPUT on;
declare
   result number;
begin
result := tf1(1, 200.0);
dbms_output.put_line(result);
end;
/

