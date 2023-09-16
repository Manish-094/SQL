CREATE DATABASE LINK destination_db_link_01
CONNECT TO C##TEST_USER3
IDENTIFIED BY user3
using ' (description = 
       (address=(protocol=tcp)(host=localhost)(port=1521))
       (CONNECT_DATA =
      (SID = ORCL))  
      )';
      
select * from ALL_DB_LINKS;
DROP DATABASE LINK destination_db_link_1;

/* Creating a message type: */
CREATE type Message_typ as object (
subject     VARCHAR2(30),
text        VARCHAR2(80));   


/* Creating a object type queue table and queue: */
BEGIN
  DBMS_AQADM.CREATE_QUEUE_TABLE (
    queue_table        => 'objmsgs80_qtab',
    queue_payload_type => 'Message_typ'
  );
END;
/

BEGIN 
   DBMS_AQADM.CREATE_QUEUE (
   queue_name         => 'msg_queue',
   queue_table        => 'objmsgs80_qtab'
   );
END;
/

BEGIN 
   DBMS_AQADM.START_QUEUE (
   queue_name         => 'msg_queue'
   );
END;
/

/* Enqueue to msg_queue: */
DECLARE
   enqueue_options     dbms_aq.enqueue_options_t;
   message_properties  dbms_aq.message_properties_t;
   message_handle      RAW(16);
   message             message_typ;

BEGIN
   message := message_typ('NORMAL MESSAGE',
   'enqueued to msg_queue first.');

   dbms_aq.enqueue(queue_name => 'msg_queue@destination_db_link',           
         enqueue_options      => enqueue_options,       
         message_properties   => message_properties,     
         payload              => message,               
         msgid                => message_handle);

   COMMIT;
END;
/

/* Dequeue from msg_queue: */
SET SERVEROUTPUT ON;
DECLARE
   dequeue_options     dbms_aq.dequeue_options_t;
   message_properties  dbms_aq.message_properties_t;
   message_handle      RAW(16);
   message             message_typ;

BEGIN
   DBMS_AQ.DEQUEUE(queue_name => 'C##TEST_USER3.msg_queue',
           dequeue_options    => dequeue_options,
           message_properties => message_properties,
           payload            => message,
           msgid              => message_handle);

   DBMS_OUTPUT.PUT_LINE ('Message: ' || message.subject ||
                                      ' ... ' || message.text );
   COMMIT;
END;
/




select  * from all_objects
where owner = upper('c##test_user3');
select * from all_queues;

BEGIN
  DBMS_AQADM.STOP_QUEUE(queue_name => 'msg_queue');
  DBMS_AQADM.DROP_QUEUE(queue_name => 'msg_queue');
  DBMS_AQADM.DROP_QUEUE_TABLE(queue_table => 'objmsgs80_qtab');
END;



commit;


create table temp2(id int,name varchar(20));
insert into temp2 values(1,'rfvfvb');
select * from temp2;