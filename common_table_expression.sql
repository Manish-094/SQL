CREATE TABLE Stores(
  store_id INT,
  store_name VARCHAR2(20),
  product VARCHAR2(20),
  quantity NUMBER,
  cost NUMBER
);

insert into Stores values(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000);
insert into Stores values(1, 'Apple Originals 1','MacBook pro 13', 3, 2000);
insert into Stores values(1, 'Apple Originals 1','AirPods Pro', 2, 280);
insert into Stores values(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000);
insert into Stores values(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000);
insert into Stores values(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000);
insert into Stores values(3, 'Apple Originals 3','MacBook pro 13', 1, 2000);
insert into Stores values(3, 'Apple Originals 3','MacBook Air', 4, 1100);
insert into Stores values(3, 'Apple Originals 3','iPhone 12', 2, 1000);
insert into Stores values(3, 'Apple Originals 3','AirPods Pro', 3, 280);
insert into Stores values(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000);
insert into Stores values(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from Stores;

-- QUESTION  :Find stores who's sales where better than the average sales accross all stores

-- Find total sales per each store
select s.store_id,sum(cost) as total_sales_per_store
from Stores s group by s.store_id;

-- Find average sales with respect to all stores
select cast(avg(total_sales_per_store)as int) as avg_sale_for_all_store
from (select s.store_id,sum(cost) as total_sales_per_store
from Stores s group by s.store_id) x;

-- Find stores who's sales where better than the average sales accross all stores
select * from 
       (select cast(avg(total_sales_per_store)as int) as avg_sale_for_all_store
            from (select s.store_id,sum(cost) as total_sales_per_store
                from Stores s group by s.store_id) x) avg_sales
 join
      (select s.store_id,sum(cost) as total_sales_per_store
             from Stores s group by s.store_id) total_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;



---------------------------same query using with clause--------------------------------------------------------

with Total_Sales (store_id,total_sales_per_store) AS
       (select s.store_id,sum(cost) as total_sales_per_store
          from Stores s group by s.store_id),
        
     avg_Sales (avg_sale_for_all_store) as 
           (select cast(avg(total_sales_per_store)as int) as avg_sale_for_all_store
            from Total_Sales)
            
select * from Total_Sales ts
join avg_Sales av
on ts.total_sales_per_store>av.avg_sale_for_all_store;
