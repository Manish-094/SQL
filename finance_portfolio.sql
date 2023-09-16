--table customer
CREATE TABLE Customer (
  CustomerID NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100) UNIQUE,
  CONSTRAINT check_customer_id_positive CHECK (CustomerID > 0)
);

--table FinanceCategory
create table FinanceCategory(
  category_id NUMBER PRIMARY KEY,
  category_name VARCHAR2(50)
);

--table EquityShares
CREATE TABLE EquityShares (
  ShareID NUMBER PRIMARY KEY,
  equity_category_id NUMBER NOT NULL,
  CompanyName VARCHAR2(100),
  Quantity NUMBER,
  purchase_price DECIMAL(10,2),
  PurchaseDate DATE,
  FOREIGN KEY (equity_category_id) REFERENCES FinanceCategory(category_id),
  CONSTRAINT check_quantity_positive CHECK (Quantity >= 0),
  CONSTRAINT check_purchase_price_positive CHECK (purchase_price >= 0)
);

--table EquityRates
CREATE TABLE EquityRates (
  RateID NUMBER PRIMARY KEY,
  ShareID NUMBER,
  Rate NUMBER,
  RateDate DATE,
  closing_price DECIMAL(10,2),
  FOREIGN KEY (ShareID) REFERENCES EquityShares(ShareID)
);

--table MFMaster
CREATE TABLE MFMaster (
  MfID NUMBER PRIMARY KEY,
  mf_category_id NUMBER,
  MFName VARCHAR2(100),
  FOREIGN KEY (mf_category_id) REFERENCES FinanceCategory(category_id)
);

--table MFRates
CREATE TABLE MFRates (
  RateID NUMBER PRIMARY KEY,
  MfID NUMBER,
  Rate NUMBER,
  RateDate DATE,
  FOREIGN KEY (MfID) REFERENCES MFMaster(MfID) on delete CASCADE
);

--table InsuranceMaster
CREATE TABLE InsuranceMaster (
  InsuranceID NUMBER PRIMARY KEY,
  policy_number VARCHAR2(50) UNIQUE NOT NULL,
  CustomerID NUMBER,
  insurance_type VARCHAR2(50),
  premium_amount DECIMAL(10,2) NOT NULL,
  start_date DATE,
  end_date DATE,
  InsuranceCompanyName VARCHAR2(100),
  CONSTRAINT check_premium_amount_positive CHECK (premium_amount > 0)
);

--table Transaction
CREATE TABLE Transaction (
  TransactionID NUMBER PRIMARY KEY,
  transaction_date DATE NOT NULL,
  CustomerID NUMBER,
  ShareID NUMBER,
  MfID NUMBER,
  InsuranceID NUMBER,
  FinanceType VARCHAR2(50),
  amount DECIMAL(10,2),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (ShareID) REFERENCES EquityShares(ShareID),
  FOREIGN KEY (MfID) REFERENCES MFMaster(MfID),
  FOREIGN KEY (InsuranceID) REFERENCES InsuranceMaster(InsuranceID),
  CONSTRAINT check_amount_positive CHECK (amount > 0)
);

select * from Customer;
select * from EquityShares;
select * from EquityRates;
select * from MFMaster;
select * from MFRates;
select * from InsuranceMaster;
select * from Transaction;
drop procedure ManageCustomer;
--procedure  ManageCustomer
CREATE OR REPLACE PROCEDURE ManageCustomer (
  p_Action IN VARCHAR2,
  p_CustomerData IN Customer%ROWTYPE
)
AS
BEGIN
  IF p_Action = 'INSERT' THEN
    INSERT INTO Customer
    VALUES p_CustomerData;
  ELSIF p_Action = 'UPDATE' THEN
    UPDATE Customer
    SET customer_name = p_CustomerData.customer_name
    WHERE CustomerID = p_CustomerData.CustomerID;
  ELSIF p_Action = 'DELETE' THEN
    DELETE FROM Customer
    WHERE CustomerID = p_CustomerData.CustomerID;
  END IF;
  COMMIT;
END;
/


create sequence customer_seq start with 1 increment by 1;
drop sequence customer_seq;

--calling procedure to insert customer data
DECLARE
  v_CustomerData Customer%ROWTYPE;
BEGIN
  v_CustomerData.CustomerID := customer_seq.nextval;
  v_CustomerData.customer_name := 'John Doe';
  ManageCustomer('INSERT', v_CustomerData);
END;
/
--calling procedure to update customer data
DECLARE
  v_CustomerData Customer%ROWTYPE;
BEGIN
  v_CustomerData.CustomerID := 1;
  v_CustomerData.customer_name := 'Manish Patel';
  ManageCustomer('UPDATE', v_CustomerData);
END;
/
--calling procedure to delete customer data
DECLARE
  v_CustomerData Customer%ROWTYPE;
BEGIN
  v_CustomerData.CustomerID := 2;
  ManageCustomer('DELETE', v_CustomerData);
END;
/



    

























drop procedure UpdateCustomer;
--UPDATE procedure for Customer table:
CREATE OR REPLACE PROCEDURE UpdateCustomer (
  p_customer IN Customer%ROWTYPE
) AS
BEGIN
  UPDATE Customer
  SET Name = p_customer.Name, FinanceCategory = p_customer.FinanceCategory
  WHERE CustomerID = p_customer.CustomerID;
  COMMIT;
END;
/
--calling InsertCustomer procedure 
DECLARE
  customer_data Customer%ROWTYPE;
BEGIN
  customer_data.CustomerID := 11;
  customer_data.Name := 'Manish';
  customer_data.FinanceCategory := 'PF';
  InsertCustomer(customer_data);
END;
/
--calling UpdateCustomer procedure
DECLARE
  customer_data Customer%ROWTYPE;
BEGIN
  customer_data.CustomerID := 1;
  customer_data.Name := 'Ajeet';
  customer_data.FinanceCategory := 'PF';
  UpdateCustomer(customer_data);
END;
/


SELECT t.TransactionID, t.CustomerID, t.FinanceType,
       c.Name AS PreviousCustomerName,
       t.PurchaseDate, t.PurchaseAmount, t.SalesDate, t.SalesAmount,
       c_new.Name AS UpdatedCustomerName FROM Transaction t join Customer c ON t.CustomerID = c.CustomerID
JOIN Customer c ON t.CustomerID = c.CustomerID
LEFT JOIN Transaction t_prev ON t_prev.CustomerID = t.CustomerID
                            AND t_prev.PurchaseDate < t.PurchaseDate
LEFT JOIN Customer c_new ON c_new.CustomerID = t.CustomerID
WHERE t_prev.TransactionID IS NULL OR t_prev.SalesDate < t.PurchaseDate;
