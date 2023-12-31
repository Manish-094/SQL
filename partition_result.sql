--PARTIONING BY RANGE
--p1
1	01-MAY-21	100
3	03-MAY-21	200
4	04-MAY-21	150.25
6	06-MAY-21	90
8	08-MAY-21	250
10	10-MAY-21	150.532

--p2
2	02-MAY-22	75.5
5	05-MAY-22	120.75
7	07-MAY-22	180.5
9	09-MAY-22	300.25

--P3
11	11-MAY-24	150.5
12	12-MAY-24	150.5

--PARTION BY LIST
--p_usa

1	01-MAY-21	100	USA
3	03-MAY-21	200	USA
4	04-MAY-21	150.25	USA
5	05-MAY-22	120.75	USA
9	09-MAY-22	300.25	USA
12	12-MAY-24	150.5	USA

--p_uk
2	02-MAY-22	75.5	UK
6	06-MAY-21	90	UK
7	07-MAY-22	180.5	UK
11	11-MAY-24	150.5	UK

--p_other
8	08-MAY-21	250	IND
10	10-MAY-21	150.5	PAK


--COMPOSITE PARTITION(LIST AND RANGE)
--partition(p2021)
1	01-MAY-21	100	USA
3	03-MAY-21	200	USA
4	04-MAY-21	150.25	USA
6	06-MAY-21	90	UK
8	08-MAY-21	250	IND
10	10-MAY-21	150.5	PAK
--partition(p2022)
5	05-MAY-22	120.75	USA
9	09-MAY-22	300.25	USA
2	02-MAY-22	75.5	UK
7	07-MAY-22	180.5	UK
--partition(p_other)
12	12-MAY-24	150.5	USA
11	11-MAY-24	150.5	UK

--COMPOSITE PARTITION(RANGE AND HASH)
--partition(p2021)
6	06-MAY-21	90	UK
10	10-MAY-21	150.5	PAK
8	08-MAY-21	250	IND
1	01-MAY-21	100	USA
3	03-MAY-21	200	USA
4	04-MAY-21	150.25	USA
--partition(p2022)
9	09-MAY-22	300.25	USA
2	02-MAY-22	75.5	UK
5	05-MAY-22	120.75	USA
7	07-MAY-22	180.5	UK
--partition(p_other)
11	11-MAY-24	150.5	UK
12	12-MAY-24	150.5	USA

----COMPOSITE PARTITION(LIST AND HASH)
--PARTITION(p_usa)
9	09-MAY-22	300.25	USA
12	12-MAY-24	150.5	USA
5	05-MAY-22	120.75	USA
1	01-MAY-21	100	USA
3	03-MAY-21	200	USA
4	04-MAY-21	150.25	USA
--PARTITION(p_uk)
6	06-MAY-21	90	UK
11	11-MAY-24	150.5	UK
2	02-MAY-22	75.5	UK
7	07-MAY-22	180.5	UK
--PARTITION(p_other)
10	10-MAY-21	150.5	PAK
8	08-MAY-21	250	IND

