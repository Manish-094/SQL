select * from all_db_links;

create database link admin_remote
connect  to c##admin identified by admin123
using ' (description = 
       (address=(protocol=tcp)(host=localhost)(port=1521))
       (CONNECT_DATA =
      (SID = ORCL))  
      )';

select * from temp1@admin_remote;
insert into temp1@admin_remote values(5,'allu arjun',45);
commit;
delete from temp1@admin_remote where id = 5;
update temp1@admin_remote set name = 'Pranshu' where id = 1;
-----------create synonyms---------------------------------------------------------------------------------
create synonym admin_data for temp1@admin_remote;
select * from admin_data;
----------------------------------------------------------------------------------------------------------------
create table temp2(id number,name varchar(20));
insert into temp2 values(1,'abhi');
select * from temp2;
commit;






















