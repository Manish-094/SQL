EXECUTE pr_by_products('samsung',2);
select * from product;
select * from sales;



create table sales 
(
  order_id int primary key,
  product_code varchar(20),
  quantity int , 
  price number
 );
 

 alter table sales drop column order_id;

insert into sales values (3,'p1',25,30000);

create table product (
  product_code varchar(20) primary key,
  product_name varchar(20),
  price int , 
  quantity_remaining int,
  quantity_sold int
  );

insert into product values ('p1','iphone',1000,5,175);
insert into product values ('p2','samsung',1000,10,100);


