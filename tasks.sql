CREATE TABLE Employe2 (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

create  UNIQUE INDEX emp_id
ON Employe2(EmployeeID);
select * from all_constraints where owner = 'C##TEST_USER1';
select * from all_tables where owner = 'C##TEST_USER1';

INSERT INTO Employe2 VALUES(1, 'John', 'Doe', 100);
INSERT INTO Employe2 VALUES(2, 'Jane', 'Smith', NULL);
INSERT INTO Employe2 VALUES(3, 'David', 'Johnson', NULL);
INSERT INTO Employe2 VALUES(NULL, 'Mark', 'Davis', NULL);
INSERT INTO Employe2 VALUES(NULL, 'Sarah', 'Wilson', 200);

select * from Employe2;



CREATE TABLE Customers (
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

INSERT INTO Customers VALUES (1, 'John', 'Doe');
INSERT INTO Customers VALUES (2, 'Jane', 'Smith');
INSERT INTO Customers VALUES (3, 'David', 'Johnson');

select * from Customers;
    
ALTER TABLE Customers
ADD CONSTRAINT UC_UniqueCustomerID UNIQUE (CustomerID);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);

INSERT INTO Orders VALUES (1, to_date('19-05-2023','dd-mm-yyyy'), 1);
INSERT INTO Orders VALUES (2, to_date('13-06-2023','dd-mm-yyyy'), 2);
INSERT INTO Orders VALUES (3, to_date('14-07-2023','dd-mm-yyyy'), 3);

select * from Orders;



-- Create Table 1
CREATE TABLE Table1 (
    column_A INT,
    column_B INT,
    CONSTRAINT PK_Table1 PRIMARY KEY (column_A, column_B)
);
drop table Table1;

-- Create Table 2 with foreign key reference to Table 1
CREATE TABLE Table2 (
    id INT,
    CONSTRAINT FK_Table2_Table1 FOREIGN KEY (id) REFERENCES Table1 (name)
);

-- Create Table 2 with composite foreign key reference to Table 1
CREATE TABLE Table2 (
    column_C INT,
    Column_D INT,
    CONSTRAINT FK_Table2_Table1 FOREIGN KEY (column_C, Column_D) 
    REFERENCES Table1 (column_A,column_B) ON DELETE CASCADE
);
DROP TABLE Table2;