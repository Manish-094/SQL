create table deadlock_test(
  id INT primary key,
  name varchar2(20)
);

drop table deadlock_test;
insert into deadlock_test values(1,'John');
insert into deadlock_test values(2,'Abhishek');
commit;

update deadlock_test set name = 'Ali' where id = 1;
update deadlock_test set name = 'Jaimeet' where id = 2;

commit;
select * from deadlock_test;
