create table transaction_demo(
  transaction_id INT,
  transaction_type VARCHAR2(10),
  amount INT,
  tran_date DATE
);

create UNIQUE INDEX idx_tran_id ON transaction_demo(transaction_id);
SELECT * FROM transaction_demo;

INSERT INTO transaction_demo
select ROWNUM,'CREDIT',
FLOOR(DBMS_RANDOM.VALUE(9,900)),
TRUNC(SYSDATE)-FLOOR(DBMS_RANDOM.VALUE(9,900))
FROM DUAL
CONNECT BY LEVEL<=1000000;

SELECT * FROM transaction_demo;
SELECT segment_name,blocks,segment_type,bytes/1024/1024 as MB 
from user_segments where segment_name = 'TRANSACTION_DEMO';


