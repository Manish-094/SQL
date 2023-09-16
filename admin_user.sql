create table temp1(
  id INT,
  name VARCHAR(20),
  age INT
);

insert into temp1 values(1,'John',22);
insert into temp1 values(2,'Manish',23);
insert into temp1 values(3,'Amit',24);
insert into temp1 values(4,'Smith',25);

select * from temp1;
show user;
commit;
delete from temp1 where id = 4;
select * from temp2;


-----------------deadlock test---------------------------------------------------------------------
update c##test_user1.deadlock_test set name = 'Ashok' where id = 2;
update  c##test_user1.deadlock_test set name = 'Manish' where id = 1;
commit;
select * from c##test_user1.deadlock_test;