show user
CREATE TABLE test_table(
 id INT,
 name VARCHAR(20)
);
drop table test_table;

GRANT create table,create session to c##test_user2;
GRANT SELECT ON c##hr.employee TO c##test_user2;
select * from c##hr.employee;

SELECT * FROM USER_ROLE_PRIVS; 

create table temp1(
  id int,
  name varchar(20)
);
insert into temp1 values(2,'manish');
update temp1 set name = 'ajeet' where id = 2;
delete temp1 where id = 2;
select * from temp1;