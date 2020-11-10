--PREPARE DATA AND TABLES
DROP TABLE IF EXISTS products CASCADE ; 
DROP TABLE IF EXISTS sales CASCADE ; 

CREATE TABLE products (
	id serial,
	product_id varchar(100) PRIMARY KEY,
	product_name varchar(500),
	product_category varchar(250),
	random_desc text
);

CREATE TABLE IF NOT EXISTS sales (
	id serial,
	sales_date TIMESTAMP,
	sales_amount NUMERIC(38,2),
	sales_qty INTEGER,
	discount NUMERIC(38,2),
	product_id varchar(100),
	CONSTRAINT fk_sales_product_product_id
		FOREIGN KEY (product_id) REFERENCES products(product_id)
);

DROP SEQUENCE IF EXISTS products_insert;
CREATE TEMP SEQUENCE products_insert MINVALUE 0 START WITH 0;

INSERT INTO products (product_id, product_name, product_category, random_desc)
SELECT nextval('products_insert')::TEXT,
       'Product '||floor(random() * 10 + 1)::int,
       'Category '||floor(random() * 10 + 1)::int,
       left(md5(i::text), 15)
  FROM generate_series(1, 100) s(i);

INSERT INTO sales (sales_date, sales_amount, sales_qty, product_id)
 SELECT NOW() + (random() * (interval '90 days')) + '30 days',
        random() * 10 + 1,
        floor(random() * 10 + 1)::int,
        floor(random() * 100)::int
   FROM generate_series(1, 10000) s(i);
   
--SELECT

WITH prepared_sales AS ( --COMMON TABLE EXPRESSION
	SELECT extract(YEAR FROM sales_date)::numeric AS sales_year,
		   s.*
	  FROM sales s
)
SELECT sales_grouped.*,
	   ps.*,
	   p.*
  FROM prepared_sales ps
  JOIN (
	  	SELECT extract(YEAR FROM sales_date)::numeric AS sales_year,
	  		   sum(sales_amount) AS sum_sales,
	  		   sum(sales_qty) AS sum_sales_qty
	   	  FROM (SELECT s.* 
	   	          FROM sales s
	   	         WHERE s.sales_qty > 2) sales_with_qty_sold_over_2
	  GROUP BY 1
  ) sales_grouped ON ps.sales_year = sales_grouped.sales_year
  JOIN products p ON p.product_id = ps.product_id;  