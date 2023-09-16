create table emp2
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into emp2 values(101, 'Mohan', 'Admin', 4000);
insert into emp2 values(102, 'Rajkumar', 'HR', 3000);
insert into emp2 values(103, 'Akbar', 'IT', 4000);
insert into emp2 values(104, 'Dorvin', 'Finance', 6500);
insert into emp2 values(105, 'Rohit', 'HR', 3000);
insert into emp2 values(106, 'Rajesh',  'Finance', 5000);
insert into emp2 values(107, 'Preet', 'HR', 7000);
insert into emp2 values(108, 'Maryam', 'Admin', 4000);
insert into emp2 values(109, 'Sanjay', 'IT', 6500);
insert into emp2 values(110, 'Vasudha', 'IT', 7000);
insert into emp2 values(111, 'Melinda', 'IT', 8000);
insert into emp2 values(112, 'Komal', 'IT', 10000);
insert into emp2 values(113, 'Gautham', 'Admin', 2000);
insert into emp2 values(114, 'Manisha', 'HR', 3000);
insert into emp2 values(115, 'Chandni', 'IT', 4500);
insert into emp2 values(116, 'Satya', 'Finance', 6500);
insert into emp2 values(117, 'Adarsh', 'HR', 3500);
insert into emp2 values(118, 'Tejaswi', 'Finance', 5500);
insert into emp2 values(119, 'Cory', 'HR', 8000);
insert into emp2 values(120, 'Monica', 'Admin', 5000);
insert into emp2 values(121, 'Rosalin', 'IT', 6000);
insert into emp2 values(122, 'Ibrahim', 'IT', 8000);
insert into emp2 values(123, 'Vikram', 'IT', 8000);
insert into emp2 values(124, 'Dheeraj', 'IT', 11000);

select * from emp2;

-- Using Aggregate function as Window Function
-- Without window function, SQL will reduce the no of records.
select dept_name,max(salary) from emp2 group by dept_name;

select e.*,max(salary) over(partition by dept_name) as max_salary
from emp2 e;

--get first two employee from each department
select * from (
      select e.*,row_number() over(PARTITION BY dept_name  order by emp_id) as rn
        from emp2 e) x
where x.rn<3;

--fetch the top 3 employees in each department earning the max salary (rank skip the dublicate value)
select * from (
     select e.*,
    rank() over(partition by dept_name order by salary desc) as rnk
    from emp2 e)x
where x.rnk<4;

--dense rank (does not skip the dublicate value)
select * from (
     select e.*,
    dense_rank() over(partition by dept_name order by salary desc) as dense_rnk
    from emp2 e)x
where x.dense_rnk<4;

-----------------------------------------------
CREATE TABLE product_table
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);
INSERT INTO product_table VALUES ('Phone', 'Apple', 'iPhone 12 Pro Max', 1300);
INSERT INTO product_table VALUES ('Phone', 'Apple', 'iPhone 12 Pro', 1100);
INSERT INTO product_table VALUES ('Phone', 'Apple', 'iPhone 12', 1000);
INSERT INTO product_table VALUES ('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800);
INSERT INTO product_table VALUES ('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000);
INSERT INTO product_table VALUES ('Phone', 'Samsung', 'Galaxy Note 20', 1200);
INSERT INTO product_table VALUES ('Phone', 'Samsung', 'Galaxy S21', 1000);
INSERT INTO product_table VALUES ('Phone', 'OnePlus', 'OnePlus Nord', 300);
INSERT INTO product_table VALUES ('Phone', 'OnePlus', 'OnePlus 9', 800);
INSERT INTO product_table VALUES ('Phone', 'Google', 'Pixel 5', 600);
INSERT INTO product_table VALUES ('Laptop', 'Apple', 'MacBook Pro 13', 2000);
INSERT INTO product_table VALUES ('Laptop', 'Apple', 'MacBook Air', 1200);
INSERT INTO product_table VALUES ('Laptop', 'Microsoft', 'Surface Laptop 4', 2100);
INSERT INTO product_table VALUES ('Laptop', 'Dell', 'XPS 13', 2000);
INSERT INTO product_table VALUES ('Laptop', 'Dell', 'XPS 15', 2300);
INSERT INTO product_table VALUES ('Laptop', 'Dell', 'XPS 17', 2500);
INSERT INTO product_table VALUES ('Earphone', 'Apple', 'AirPods Pro', 280);
INSERT INTO product_table VALUES ('Earphone', 'Samsung', 'Galaxy Buds Pro', 220);
INSERT INTO product_table VALUES ('Earphone', 'Samsung', 'Galaxy Buds Live', 170);
INSERT INTO product_table VALUES ('Earphone', 'Sony', 'WF-1000XM4', 250);
INSERT INTO product_table VALUES ('Headphone', 'Sony', 'WH-1000XM4', 400);
INSERT INTO product_table VALUES ('Headphone', 'Apple', 'AirPods Max', 550);
INSERT INTO product_table VALUES ('Headphone', 'Microsoft', 'Surface Headphones 2', 250);
INSERT INTO product_table VALUES ('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000);
INSERT INTO product_table VALUES ('Smartwatch', 'Apple', 'Apple Watch SE', 400);
INSERT INTO product_table VALUES ('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600);
INSERT INTO product_table VALUES ('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
COMMIT;

select * from Product_table;
select product_category from Product_table group by product_category;

--first_value
--write a query to display most expensive product under each catogery
select e.*,
first_value(product_name) over(partition by product_category order by price desc) as most_exp_product,
last_value(product_name) over(partition by product_category order by 
price desc range between unbounded preceding and unbounded following) as least_exp_product 
from Product_table e;

--alternate way to write window function
select e.*,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product 
from Product_table e
window  w as(partition by product_category order by 
price desc range between unbounded preceding and unbounded following);

--Nth value
--Query to display 2nd most expensive product under each category
select e.*,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product ,
nth_value(product_name,2) over w as second_most_exp_product
from Product_table e
window  w as(partition by product_category order by 
price desc range between unbounded preceding and unbounded following);

--NTILE
--Write a query to segregate all the expensvie phones,mid range phones and the cheaper phones
select product_name,
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid range Phones'
     when x.buckets = 3 then 'Cheaper Phones' End phone_category
from (
     select e.*,
      ntile(3) over(order by price desc) as buckets
       from Product_table e
       where product_category = 'Phone') x;

--Query to fetch all products which are constituting the first
--30% of the data in products table based on price
--formula = current row number (or with value same as current row)/total no of rows

select product_name,(cume_dist_percentage || '%') as cume_dist_percentage
from (
      SELECT e.*,
            ROUND(cume_dist() OVER (ORDER BY price DESC) * 100, 2) AS cume_dist_percentage
       FROM Product_table e) x
where x.cume_dist_percentage<=30;

--query to identify how much percentage more expensive is 'Galaxy Z Fold 3' WHEN Compared to all products
--formula = current row-1/total no of rows -1
select product_name,per_rank||'%' as percent_more_exp_to_others
from(
      select e.*,
      round(percent_rank() over(order by price)*100,2) as per_rank
      from Product_table e) x
where product_name = 'Galaxy Z Fold 3';

commit;