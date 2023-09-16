CREATE TABLE Sales (
   sale_id INT PRIMARY KEY NOT NULL,
   product_name VARCHAR(50),
   categorys VARCHAR(20),
   price DECIMAL(10, 2),
   quantity_sold INT,
   slae_date TIMESTAMP
);

INSERT INTO Sales(sale_id,product_name,categorys,price,quantity_sold,slae_date)
VALUES(1,'ProductA','Electronics',99.999,5, TO_DATE('17-04-2023','DD-MM-YYYY'));
INSERT INTO Sales(sale_id,product_name,categorys,price,quantity_sold,slae_date)
VALUES(2,'ProductB','Clothing',49.99,2, TO_DATE('18-05-2023','DD-MM-YYYY'));
INSERT INTO Sales(sale_id,product_name,categorys,price,quantity_sold,slae_date)
VALUES(3,'ProductC','Furniture',79.99,4, TO_DATE('19-06-2023','DD-MM-YYYY'));
INSERT INTO Sales(sale_id,product_name,categorys,price,quantity_sold,slae_date)
VALUES(4,'ProductD','Clothing',35.999,3, TO_DATE('20-07-2023','DD-MM-YYYY'));
INSERT INTO Sales(sale_id,product_name,categorys,price,quantity_sold,slae_date)
VALUES(5,'ProductE','Electronics',42.999,6, TO_DATE('22-08-2023','DD-MM-YYYY'));

TRUNCATE TABLE Sales;
SELECT * FROM Sales;
--To get the total sales quantity for each category
--SELECT categorys,SUM(quantity_sold)AS total_sales_quantity FROM Sales GROUP BY categorys

SELECT categorys,SUM(quantity_sold) 
AS total_sales_quantity FROM Sales WHERE categorys = 'Electronics'
GROUP BY categorys
HAVING SUM(quantity_sold)>10

--cannot use group function with where clause
--SELECT job_id,SUM(salary)
--FROM employee WHERE department_id IN(20,30)
--GROUP BY job_id
--HAVING SUM(salary)>500
--ORDER BY 2



CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(200)
);
INSERT INTO Customers (customer_id, name, email, address)
VALUES (1, 'John Smith', 'john@example.com', '123 Main St');
INSERT INTO Customers (customer_id, name, email, address)
VALUES(2, 'Jane Doe', 'jane@example.com', '456 Elm St');
INSERT INTO Customers (customer_id, name, email, address)
VALUES(3, 'Mike Johnson', 'mike@example.com', '789 Oak Ave');
INSERT INTO Customers (customer_id, name, email, address)
VALUES(4, 'Jaimeet Patel', 'jaimeet@example.com', '520 Deoria');
INSERT INTO Customers (customer_id, name, email, address)
VALUES(5, 'Manish Patel', 'manish@example.com', '423 Gorakhpur');

SELECT * FROM Customers;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date, order_amount)
VALUES (1, 1, TO_DATE('10-05-2023','DD-MM-YYYY'), 100.00);
INSERT INTO Orders (order_id, customer_id, order_date, order_amount)
VALUES(2, 2, TO_DATE('2023-05-11','YYYY-MM-DD'), 150.00);
INSERT INTO Orders (order_id, customer_id, order_date, order_amount)
VALUES(3, 1, TO_DATE('2023-05-11','YYYY-MM-DD'), 200.00);

SELECT * FROM Orders;

--Suppose we want to retrieve the names of customers who 
--have placed orders with an order amount greater 
--than the average order amount
SELECT name FROM Customers WHERE customer_id 
IN(SELECT customer_id FROM Orders WHERE 
order_amount>(SELECT AVG(NVL(order_amount,0)) FROM Orders))




create table departments
(
	dept_id		int ,
	dept_name	varchar(50) PRIMARY KEY,
	location	varchar(100)
);
insert into departments values (1, 'Admin', 'Bangalore');
insert into departments values (2, 'HR', 'Bangalore');
insert into departments values (3, 'IT', 'Bangalore');
insert into departments values (4, 'Finance', 'Mumbai');
insert into departments values (5, 'Marketing', 'Bangalore');
insert into departments values (6, 'Sales', 'Mumbai');

SELECT * FROM departments;
CREATE TABLE EMPLOYE
(
    EMP_ID      INT PRIMARY KEY,
    EMP_NAME    VARCHAR(50) NOT NULL,
    DEPT_NAME   VARCHAR(50) NOT NULL,
    SALARY      INT,
    constraint fk_emp foreign key(dept_name) references departments(dept_name)
);
insert into EMPLOYE values(101, 'Mohan', 'Admin', 4000);
insert into EMPLOYE values(102, 'Rajkumar', 'HR', 3000);
insert into EMPLOYE values(103, 'Akbar', 'IT', 4000);
insert into EMPLOYE values(104, 'Dorvin', 'Finance', 6500);
insert into EMPLOYE values(105, 'Rohit', 'HR', 3000);
insert into EMPLOYE values(106, 'Rajesh',  'Finance', 5000);
insert into EMPLOYE values(107, 'Preet', 'HR', 7000);
insert into EMPLOYE values(108, 'Maryam', 'Admin', 4000);
insert into EMPLOYE values(109, 'Sanjay', 'IT', 6500);
insert into EMPLOYE values(110, 'Vasudha', 'IT', 7000);
insert into EMPLOYE values(111, 'Melinda', 'IT', 8000);
insert into EMPLOYE values(112, 'Komal', 'IT', 10000);
insert into EMPLOYE values(113, 'Gautham', 'Admin', 2000);
insert into EMPLOYE values(114, 'Manisha', 'HR', 3000);
insert into EMPLOYE values(115, 'Chandni', 'IT', 4500);
insert into EMPLOYE values(116, 'Satya', 'Finance', 6500);
insert into EMPLOYE values(117, 'Adarsh', 'HR', 3500);
insert into EMPLOYE values(118, 'Tejaswi', 'Finance', 5500);
insert into EMPLOYE values(119, 'Cory', 'HR', 8000);
insert into EMPLOYE values(120, 'Monica', 'Admin', 5000);
insert into EMPLOYE values(121, 'Rosalin', 'IT', 6000);
insert into EMPLOYE values(122, 'Ibrahim', 'IT', 8000);
insert into EMPLOYE values(123, 'Vikram', 'IT', 8000);
insert into EMPLOYE values(124, 'Dheeraj', 'IT', 11000);

SELECT * FROM EMPLOYE;

--SCALER SUBQUERY
--RETURN SINGLE ROW AND SINGLE COLUMN
/* QUESTION: Find the employees who's salary 
is more than the average salary earned by all employees. */
SELECT * FROM EMPLOYE WHERE
SALARY>(SELECT AVG(SALARY) FROM EMPLOYE);

--------WITH CLAUSE CALLED COMMON TABLE EXPRESSION (CTE)-----------------------------------------------------
WITH avg_salary (avg_sal) as
        (select TRUNC(avg(salary),2) from EMPLOYE)
        
select * from EMPLOYE E1,avg_salary av WHERE E1.salary>av.avg_sal;

--MULTIPLE ROW SUBQUERY
/* QUESTION: Find the employees who earn the highest 
salary in each department */
--RETURN MULTIPLE ROW AND MULTIPLE COLUMN
SELECT * FROM EMPLOYE WHERE (DEPT_NAME,SALARY) 
IN(SELECT DEPT_NAME,MAX(SALARY) FROM EMPLOYE GROUP BY DEPT_NAME)

/* QUESTION: Find department who do not have any employee */
--return single column and multiple row
SELECT * FROM departments WHERE dept_name 
NOT IN(SELECT DISTINCT DEPT_NAME FROM EMPLOYE)



/*
CORRELATED SUBQUERY
A subqery which is related to outer query
QUESTION: Find the employee in each department 
who earn more than the average salary in that department*/
SELECT * FROM EMPLOYE E1 WHERE SALARY > 
(SELECT AVG(SALARY)FROM EMPLOYE E2 WHERE E2.DEPT_NAME = E1.DEPT_NAME)

create table Saless
(
	store_id  		int,
	store_name  	varchar(50),
	product_name	varchar(50),
	quantity		int,
	price	     	int
);

insert into Saless values
(1, 'Apple Store 1','iPhone 13 Pro', 1, 1000);
insert into Saless values
(1, 'Apple Store 1','MacBook pro 14', 3, 6000);
insert into Saless values
(1, 'Apple Store 1','AirPods Pro', 2, 500);
insert into Saless values
(2, 'Apple Store 2','iPhone 13 Pro', 2, 2000);
insert into Saless values
(3, 'Apple Store 3','iPhone 12 Pro', 1, 750);
insert into Saless values
(3, 'Apple Store 3','MacBook pro 14', 1, 2000);
insert into Saless values
(3, 'Apple Store 3','MacBook Air', 4, 4400);
insert into Saless values
(3, 'Apple Store 3','iPhone 13', 2, 1800);
insert into Saless values
(3, 'Apple Store 3','AirPods Pro', 3, 750);
insert into Saless values
(4, 'Apple Store 4','iPhone 12 Pro', 2, 1500);
insert into Saless values
(4, 'Apple Store 4','MacBook pro 16', 1, 3500);

SELECT * FROM Saless;
select object_name,object_type,created,status from user_objects;


desc user_objects;
