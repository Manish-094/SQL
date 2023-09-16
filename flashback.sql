create table dept2
as
select emp_id,first_name from c##hr.employee
where emp_id in(4,5,6);

select systimestamp from dual;
--16-MAY-23 06.24.57.113000000 PM +05:30
update dept2 set first_name = 'MANISH' where emp_id = 4;

commit;
select * from dept2
as of timestamp to_timestamp('16-MAY-23 06.24.57.113000000 PM','DD-MON-YY HH.MI.SS.FF PM');

select * from dept2
versions between timestamp to_timestamp('16-MAY-23 06.24.57.113000000 PM','DD-MON-YY HH.MI.SS.FF PM')
and systimestamp;

--flashback table data
alter table dept2 enable row movement;
flashback table dept2
to TIMESTAMP TO_TIMESTAMP('16-MAY-23 06.24.57.113000000 PM','DD-MON-YY HH.MI.SS.FF PM');
select * from dept2;

select original_name,operation,droptime from recyclebin;

