create table trainer(
  trainer_name VARCHAR(20)
);
CREATE TABLE subject(
  subject_name VARCHAR(20)
);

CREATE or replace VIEW trainer_view
as
select trainer_name,subject_name from trainer,subject;

insert into trainer_view values('manish','SQL');
insert into trainer_view values('John','Oracle');
insert into trainer_view values('Ajeet','JavaScript');


create or replace trigger insert_in_view
INSTEAD OF INSERT ON trainer_view
FOR EACH ROW
BEGIN
    INSERT INTO trainer(trainer_name) VALUES(:NEW.trainer_name);
    INSERT INTO subject(subject_name) VALUES(:NEW.subject_name);
END;

SELECT * FROM trainer_view;
select * from trainer;
select * from subject;

-------------------instead-of-update trigger on view--------------------------------------------------------
create or replace trigger update_view_trigger
instead of update on trainer_view
for each row
begin
    update trainer set trainer_name = :new.trainer_name where trainer_name = :old.trainer_name;
    update subject set subject_name = :new.subject_name where subject_name = :old.subject_name;
end;

update trainer_view set trainer_name = 'Abhishek' where trainer_name = 'manish';

-------------------instead-of-delete on view----------------------------------------------------------------
create or replace trigger delete_view_trigger
instead of delete on trainer_view
for each row
begin
     delete from trainer where trainer_name = :old.trainer_name;
end;

delete from trainer_view where trainer_name = 'Abhishek';
