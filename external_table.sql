CREATE DIRECTORY ext_dir AS 'D:\External_01\';

--DROP TABLE my_external_table;
--DROP DIRECTORY ext_dir;

CREATE DIRECTORY ext_dir AS 'D:\External_01\';

CREATE TABLE my_external_table (
    pizza_id VARCHAR2(20),
    order_id VARCHAR2(20),
    pizza_name_id VARCHAR2(50),
    quantity VARCHAR2(100),
    order_date VARCHAR2(20),
    order_time VARCHAR2(50),
    unit_price VARCHAR2(100),
    total_price VARCHAR2(100),
    pizza_size VARCHAR2(100),
    pizza_category VARCHAR2(50),
    pizza_ingredients varchar2(256),
    pizza_name VARCHAR2(100)
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
    )
    LOCATION ('pizza_sales.csv')
)
REJECT LIMIT UNLIMITED;

select * from my_external_table;

