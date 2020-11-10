-- INSERT INTO SELECT -> groups

DROP TABLE IF EXISTS sales, sales_2019;

CREATE TABLE sales (
	id SERIAL,
	sal_value NUMERIC(10,2),
	sal_date DATE
);

CREATE TABLE sales_2019 (
	id Serial,
	sal_value NUMERIC(10,2),
	sal_date DATE
);
SHOW DATESTYLE;
SET DATESTYLE TO 'DMY';
INSERT INTO sales(sal_value, sal_date)
	VALUES (1000, '20/11/2019'),
			(3000,'16/11/2018'),
			(2000,'4/11/2020'),
			(1000, '02/04/2019');
			
INSERT INTO sales_2019 
	SELECT *
	FROM sales 
	WHERE EXTRACT(YEAR FROM sal_date) = 2019;

SELECT *FROM sales_2019 ;

--fail
ALTER TABLE sales ADD COLUMN sal_desciption TEXT;
UPDATE sales SET sal_desciption = '<UNKNOWN>';
SELECT * FROM sales;

INSERT INTO sales_2019 (sal_value, sal_date)
	SELECT sal_value, sal_date
	FROM sales 
	WHERE EXTRACT(YEAR FROM sal_date) = 2019;