--PARTIONING BY RANGE
CREATE TABLE sales_table (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2)
)
PARTITION BY RANGE (sale_date) (
    PARTITION p1 VALUES LESS THAN (to_date('01-01-2022','dd-mm-yyyy')),
    PARTITION p2 VALUES LESS THAN (to_date('01-01-2023','dd-mm-yyyy')),
    PARTITION p3 VALUES LESS THAN(MAXVALUE) 
);

drop table sales_table;
INSERT INTO sales_table VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00);
INSERT INTO sales_table VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50);
INSERT INTO sales_table VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00);
INSERT INTO sales_table VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25);
INSERT INTO sales_table VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75);
INSERT INTO sales_table VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00);
INSERT INTO sales_table VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50);
INSERT INTO sales_table VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00);
INSERT INTO sales_table VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25);
INSERT INTO sales_table VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50);
INSERT INTO sales_table VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50);
INSERT INTO sales_table VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50);

select * from sales_table;
select * from sales_table partition (p1);
select * from sales_table partition (p2);
select * from sales_table partition (p3);

--PARTION BY LIST
CREATE TABLE sales_table2 (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    country VARCHAR(50)
)
PARTITION BY LIST (country)
(
    PARTITION p_usa VALUES  ('USA'),
    PARTITION p_uk VALUES  ('UK'),
    PARTITION p_other VALUES  (DEFAULT)
);


INSERT INTO sales_table2 VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00,'USA');
INSERT INTO sales_table2 VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50,'UK');
INSERT INTO sales_table2 VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00,'USA');
INSERT INTO sales_table2 VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25,'USA');
INSERT INTO sales_table2 VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75,'USA');
INSERT INTO sales_table2 VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00,'UK');
INSERT INTO sales_table2 VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50,'UK');
INSERT INTO sales_table2 VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00,'IND');
INSERT INTO sales_table2 VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25,'USA');
INSERT INTO sales_table2 VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50,'PAK');
INSERT INTO sales_table2 VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50,'UK');
INSERT INTO sales_table2 VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50,'USA');

SELECT * FROM sales_table2 partition(p_usa);
SELECT * FROM sales_table2 partition(p_uk);
SELECT * FROM sales_table2 partition(p_other


--PARTION BY HASH
CREATE TABLE sales_table3 (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    country VARCHAR(50)
)
PARTITION BY HASH (id)
PARTITIONS 4;

INSERT INTO sales_table3 VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00,'USA');
INSERT INTO sales_table3 VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50,'UK');
INSERT INTO sales_table3 VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00,'USA');
INSERT INTO sales_table3 VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25,'USA');
INSERT INTO sales_table3 VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75,'USA');
INSERT INTO sales_table3 VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00,'UK');
INSERT INTO sales_table3 VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50,'UK');
INSERT INTO sales_table3 VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00,'IND');
INSERT INTO sales_table3 VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25,'USA');
INSERT INTO sales_table3 VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50,'PAK');
INSERT INTO sales_table3 VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50,'UK');
INSERT INTO sales_table3 VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50,'USA');


select * from sales_table3;
SELECT *
FROM USER_TAB_PARTITIONS
WHERE TABLE_NAME = upper('sales_table3');


--COMPOSITE PARTITION (range and list)
CREATE TABLE sales_table4 (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    country VARCHAR(50)
)
PARTITION BY RANGE (sale_date)
SUBPARTITION BY LIST (country)
(
    PARTITION p2021 VALUES LESS THAN (TO_DATE('2022-01-01', 'YYYY-MM-DD'))
    (
        SUBPARTITION p2021_usa VALUES ('USA'),
        SUBPARTITION p2021_uk VALUES ('UK'),
        SUBPARTITION p2021_other VALUES (DEFAULT)
    ),
    PARTITION p2022 VALUES LESS THAN (TO_DATE('2023-01-01', 'YYYY-MM-DD'))
    (
        SUBPARTITION p2022_usa VALUES ('USA'),
        SUBPARTITION p2022_uk VALUES ('UK'),
        SUBPARTITION p2022_other VALUES (DEFAULT)
    ),
    PARTITION p_other VALUES LESS THAN (MAXVALUE)
    (
        SUBPARTITION p_other_usa VALUES ('USA'),
        SUBPARTITION p_other_uk VALUES ('UK'),
        SUBPARTITION p_other_other VALUES (DEFAULT)
    )
);


INSERT INTO sales_table4 VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00,'USA');
INSERT INTO sales_table4 VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50,'UK');
INSERT INTO sales_table4 VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00,'USA');
INSERT INTO sales_table4 VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25,'USA');
INSERT INTO sales_table4 VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75,'USA');
INSERT INTO sales_table4 VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00,'UK');
INSERT INTO sales_table4 VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50,'UK');
INSERT INTO sales_table4 VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00,'IND');
INSERT INTO sales_table4 VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25,'USA');
INSERT INTO sales_table4 VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50,'PAK');
INSERT INTO sales_table4 VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50,'UK');
INSERT INTO sales_table4 VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50,'USA');

select * from sales_table4 partition(p2021);
select * from sales_table4 partition(p2022);
select * from sales_table4 partition(p_other);

select *
FROM USER_TAB_PARTITIONS
WHERE TABLE_NAME = upper('sales_table4');

--COMPOSITE PARTITION(RANGE AND HASH PARTITION)
CREATE TABLE sales_table5 (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    country VARCHAR(50)
)
PARTITION BY RANGE (sale_date)
SUBPARTITION BY HASH (id)
SUBPARTITIONS 4
(
    PARTITION p2021 VALUES LESS THAN (TO_DATE('2022-01-01', 'YYYY-MM-DD'))
    (
        SUBPARTITION sp2021_1,
        SUBPARTITION sp2021_2,
        SUBPARTITION sp2021_3,
        SUBPARTITION sp2021_4
    ),
    PARTITION p2022 VALUES LESS THAN (TO_DATE('2023-01-01', 'YYYY-MM-DD'))
    (
        SUBPARTITION sp2022_1,
        SUBPARTITION sp2022_2,
        SUBPARTITION sp2022_3,
        SUBPARTITION sp2022_4
    ),
    PARTITION p_other VALUES LESS THAN (MAXVALUE)
    (
        SUBPARTITION sp_other_1,
        SUBPARTITION sp_other_2,
        SUBPARTITION sp_other_3,
        SUBPARTITION sp_other_4
    )
);

INSERT INTO sales_table5 VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00,'USA');
INSERT INTO sales_table5 VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50,'UK');
INSERT INTO sales_table5 VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00,'USA');
INSERT INTO sales_table5 VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25,'USA');
INSERT INTO sales_table5 VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75,'USA');
INSERT INTO sales_table5 VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00,'UK');
INSERT INTO sales_table5 VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50,'UK');
INSERT INTO sales_table5 VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00,'IND');
INSERT INTO sales_table5 VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25,'USA');
INSERT INTO sales_table5 VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50,'PAK');
INSERT INTO sales_table5 VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50,'UK');
INSERT INTO sales_table5 VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50,'USA');

select * from sales_table5 partition(p2021);
select * from sales_table5 partition(p2022);
select * from sales_table5 partition(p_other);

--COMPOSITE PARTITION (LIST AND HASH PARTITION)
CREATE TABLE sales_table6 (
    id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    country VARCHAR(50)
)
PARTITION BY LIST (country)
SUBPARTITION BY HASH (id)
SUBPARTITIONS 4
(
    PARTITION p_usa VALUES  ('USA')
    (
        SUBPARTITION sp_usa_1,
        SUBPARTITION sp_usa_2,
        SUBPARTITION sp_usa_3,
        SUBPARTITION sp_usa_4
    ),
    PARTITION p_uk VALUES  ('UK')
    (
        SUBPARTITION sp_uk_1,
        SUBPARTITION sp_uk_2,
        SUBPARTITION sp_uk_3,
        SUBPARTITION sp_uk_4
    ),
    PARTITION p_other VALUES  (DEFAULT)
    (
        SUBPARTITION sp_other_1,
        SUBPARTITION sp_other_2,
        SUBPARTITION sp_other_3,
        SUBPARTITION sp_other_4
    )
);

INSERT INTO sales_table6 VALUES(1, to_date('01-05-2021','dd-mm-yyyy'), 100.00,'USA');
INSERT INTO sales_table6 VALUES(2, to_date('02-05-2022','dd-mm-yyyy'), 75.50,'UK');
INSERT INTO sales_table6 VALUES(3, to_date('03-05-2021','dd-mm-yyyy'), 200.00,'USA');
INSERT INTO sales_table6 VALUES(4, to_date('04-05-2021','dd-mm-yyyy'), 150.25,'USA');
INSERT INTO sales_table6 VALUES(5, to_date('05-05-2022','dd-mm-yyyy'), 120.75,'USA');
INSERT INTO sales_table6 VALUES(6, to_date('06-05-2021','dd-mm-yyyy'), 90.00,'UK');
INSERT INTO sales_table6 VALUES(7, to_date('07-05-2022','dd-mm-yyyy'), 180.50,'UK');
INSERT INTO sales_table6 VALUES(8, to_date('08-05-2021','dd-mm-yyyy'), 250.00,'IND');
INSERT INTO sales_table6 VALUES(9, to_date('09-05-2022','dd-mm-yyyy'), 300.25,'USA');
INSERT INTO sales_table6 VALUES(10, to_date('10-05-2021','dd-mm-yyyy'), 150.50,'PAK');
INSERT INTO sales_table6 VALUES(11, to_date('11-05-2024','dd-mm-yyyy'), 150.50,'UK');
INSERT INTO sales_table6 VALUES(12, to_date('12-05-2024','dd-mm-yyyy'), 150.50,'USA');

SELECT * FROM sales_table6 PARTITION(p_usa);
SELECT * FROM sales_table6 PARTITION(p_uk);
SELECT * FROM sales_table6 PARTITION(p_other);


