--partition
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_discount NUMERIC (10,2),
	added_by TEXT DEFAULT 'Admin',
	created_date TIMESTAMP DEFAULT now()
) PARTITION BY RANGE (sal_date);


CREATE TABLE sales_y2018 PARTITION OF sales
    FOR VALUES FROM ('2018-01-01') TO ('2018-12-31');

CREATE TABLE sales_y2019 PARTITION OF sales
    FOR VALUES FROM ('2019-01-01') TO ('2019-12-31');
   
CREATE TABLE sales_y2020 PARTITION OF sales
    FOR VALUES FROM ('2020-01-01') TO ('2020-12-31');
    
CREATE INDEX ON sales (sal_date);

SET DATESTYLE TO 'DMY';
-- OK
INSERT INTO sales (sal_description, sal_date, 
				   sal_value, sal_discount)
  	 VALUES ('201901_sale', '12/12/2019', 1000, 90),
  	  	    ('201902_sale', '24/06/2019', 10000, 190),
      	    ('201801_sale', '05/04/2018', 5630, 102),
      	    ('202001_sale', '07/04/2020', 7230, 0);

-- FAIL
INSERT INTO sales (sal_description, sal_date, 
				   sal_value, sal_discount)      	   
     VALUES ('202101_sale', '06/01/2021', 5000, 0);

SELECT * FROM sales;    

EXPLAIN ANALYZE 
SELECT * FROM sales;    

EXPLAIN ANALYZE
SELECT * 
  FROM sales 
 WHERE sal_date BETWEEN '01/01/2019' AND '31/12/2019';    

-- FAST BUT ...     
DROP TABLE sales_y2020;    

--- BETTER
ALTER TABLE sales DETACH PARTITION sales_y2019;