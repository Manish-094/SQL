INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (1, 'John Doe', 'Equity');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (2, 'Jane Smith', 'MF');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (3, 'Michael Johnson', 'PF');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (4, 'Emily Davis', 'Insurance');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (5, 'David Wilson', 'PF');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (6, 'Sarah Brown', 'Equity');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (7, 'Christopher Lee', 'Equity');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (8, 'Olivia Taylor', 'PF');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (9, 'Matthew Anderson', 'Equity');

INSERT INTO Customer (CustomerID, Name, FinanceCategory)
VALUES (10, 'Sophia Martinez', 'MF');

-----------------------EquityShares-----------------------------------------------------------------
INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (1, 1, 'ABC Company', 100, 10.5, TO_DATE('2023-05-01', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (2, 2, 'XYZ Corporation', 50, 8.75, TO_DATE('2023-05-02', 'YYYY-MM-DD'));


INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (3, 3, 'DEF Industries', 200, 15.25, TO_DATE('2023-05-03', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (4, 4, 'GHI Limited', 150, 12.35, TO_DATE('2023-05-04', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (5, 5, 'JKL Group', 75, 9.8, TO_DATE('2023-05-05', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (6, 6, 'MNO Enterprises', 120, 11.2, TO_DATE('2023-05-06', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (7, 7, 'PQR Inc.', 90, 7.9, TO_DATE('2023-05-07', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (8, 8, 'STU Corporation', 180, 13.6, TO_DATE('2023-05-08', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (9, 9, 'VWX Industries', 220, 18.75, TO_DATE('2023-05-09', 'YYYY-MM-DD'));

INSERT INTO EquityShares (ShareID, CustomerID, CompanyName, Quantity, Cost, PurchaseDate)
VALUES (10, 10, 'YZ Company', 60, 6.5, TO_DATE('2023-05-10', 'YYYY-MM-DD'));
----------------------------EquityRates------------------------------------------------------------------
-- Insert record 1
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (1, 1, 10.8, TO_DATE('2023-05-01', 'YYYY-MM-DD'));

-- Insert record 2
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (2, 2, 9.5, TO_DATE('2023-05-02', 'YYYY-MM-DD'));

-- Insert record 3
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (3, 3, 14.2, TO_DATE('2023-05-03', 'YYYY-MM-DD'));

-- Insert record 4
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (4, 4, 12.9, TO_DATE('2023-05-04', 'YYYY-MM-DD'));

-- Insert record 5
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (5, 5, 8.7, TO_DATE('2023-05-05', 'YYYY-MM-DD'));

-- Insert record 6
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (6, 6, 11.5, TO_DATE('2023-05-06', 'YYYY-MM-DD'));

-- Insert record 7
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (7, 7, 7.9, TO_DATE('2023-05-07', 'YYYY-MM-DD'));

-- Insert record 8
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (8, 8, 13.2, TO_DATE('2023-05-08', 'YYYY-MM-DD'));

-- Insert record 9
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (9, 9, 17.6, TO_DATE('2023-05-09', 'YYYY-MM-DD'));

-- Insert record 10
INSERT INTO EquityRates (RateID, ShareID, Rate, RateDate)
VALUES (10, 10, 6.3, TO_DATE('2023-05-10', 'YYYY-MM-DD'));
------------------------------MFMaster-------------------------------------------------
-- Insert record 1
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (1, 1, 'ABC Mutual Fund');

-- Insert record 2
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (2, 2, 'XYZ Mutual Fund');

-- Insert record 3
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (3, 3, 'DEF Mutual Fund');

-- Insert record 4
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (4, 4, 'GHI Mutual Fund');

-- Insert record 5
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (5, 5, 'JKL Mutual Fund');

-- Insert record 6
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (6, 6, 'MNO Mutual Fund');

-- Insert record 7
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (7, 7, 'PQR Mutual Fund');

-- Insert record 8
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (8, 8, 'STU Mutual Fund');

-- Insert record 9
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (9, 9, 'VWX Mutual Fund');

-- Insert record 10
INSERT INTO MFMaster (MfID, CustomerID, MFName)
VALUES (10, 10, 'YZ Mutual Fund');
------------------------MFRates------------------------------------------------------
-- Insert record 1
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (1, 1, 8.5, TO_DATE('2023-05-01', 'YYYY-MM-DD'));

-- Insert record 2
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (2, 2, 7.2, TO_DATE('2023-05-02', 'YYYY-MM-DD'));

-- Insert record 3
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (3, 3, 9.1, TO_DATE('2023-05-03', 'YYYY-MM-DD'));

-- Insert record 4
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (4, 4, 6.8, TO_DATE('2023-05-04', 'YYYY-MM-DD'));

-- Insert record 5
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (5, 5, 7.9, TO_DATE('2023-05-05', 'YYYY-MM-DD'));

-- Insert record 6
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (6, 6, 8.2, TO_DATE('2023-05-06', 'YYYY-MM-DD'));

-- Insert record 7
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (7, 7, 9.5, TO_DATE('2023-05-07', 'YYYY-MM-DD'));

-- Insert record 8
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (8, 8, 7.6, TO_DATE('2023-05-08', 'YYYY-MM-DD'));

-- Insert record 9
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (9, 9, 8.9, TO_DATE('2023-05-09', 'YYYY-MM-DD'));

-- Insert record 10
INSERT INTO MFRates (RateID, MFID, Rate, RateDate)
VALUES (10, 10, 7.4, TO_DATE('2023-05-10', 'YYYY-MM-DD'));
-------------------------InsuranceMaster--------------------------------------------

-- Insert record 1
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (1, 1, 'ABC Insurance');

-- Insert record 2
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (2, 2, 'XYZ Insurance');

-- Insert record 3
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (3, 3, 'DEF Insurance');

-- Insert record 4
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (4, 4, 'GHI Insurance');

-- Insert record 5
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (5, 5, 'JKL Insurance');

-- Insert record 6
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (6, 6, 'MNO Insurance');

-- Insert record 7
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (7, 7, 'PQR Insurance');

-- Insert record 8
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (8, 8, 'STU Insurance');

-- Insert record 9
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (9, 9, 'VWX Insurance');

-- Insert record 10
INSERT INTO InsuranceMaster (InsuranceID, CustomerID, InsuranceCompanyName)
VALUES (10, 10, 'YZ Insurance');

-----------------------Transaction------------------------------------------------------------------
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (1, 1, 'Equity', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 5000, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 6000);

-- Insert record 2
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (2, 2, 'MF', TO_DATE('2023-01-02', 'YYYY-MM-DD'), 3000, TO_DATE('2023-01-06', 'YYYY-MM-DD'), 3500);

-- Insert record 3
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (3, 3, 'Insurance', TO_DATE('2023-01-03', 'YYYY-MM-DD'), 2000, TO_DATE('2023-01-07', 'YYYY-MM-DD'), 2500);

-- Insert record 4
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (4, 4, 'PF', TO_DATE('2023-01-04', 'YYYY-MM-DD'), 4000, TO_DATE('2023-01-08', 'YYYY-MM-DD'), 4500);

-- Insert record 5
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (5, 5, 'Equity', TO_DATE('2023-01-05', 'YYYY-MM-DD'), 2500, TO_DATE('2023-01-09', 'YYYY-MM-DD'), 3000);

-- Insert record 6
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (6, 6, 'MF', TO_DATE('2023-01-06', 'YYYY-MM-DD'), 3500, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 4000);

-- Insert record 7
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (7, 7, 'Insurance', TO_DATE('2023-01-07', 'YYYY-MM-DD'), 1500, TO_DATE('2023-01-11', 'YYYY-MM-DD'), 2000);

-- Insert record 8
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (8, 8, 'PF', TO_DATE('2023-01-08', 'YYYY-MM-DD'), 4500, TO_DATE('2023-01-12', 'YYYY-MM-DD'), 5000);

-- Insert record 9
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (9, 9, 'Equity', TO_DATE('2023-01-09', 'YYYY-MM-DD'), 6000, TO_DATE('2023-01-13', 'YYYY-MM-DD'), 6500);

-- Insert record 10
INSERT INTO Transaction (TransactionID, CustomerID, FinanceType, PurchaseDate, PurchaseAmount, SalesDate, SalesAmount)
VALUES (10, 10, 'MF', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 4000, TO_DATE('2023-01-14', 'YYYY-MM-DD'), 4500);

