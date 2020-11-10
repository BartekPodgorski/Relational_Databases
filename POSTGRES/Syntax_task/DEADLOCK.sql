--lock
DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

SET DATESTYLE TO 'DMY';
INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019')
; 	
--Deadlock
UPDATE products 
	SET product_name = 'Product 2.1'
	WHERE product_code = 'PRD2';
	
UPDATE products 
	SET product_name = 'Product 4.1'
	WHERE product_code = 'PRD4';
	
--USER2 
UPDATE products 
	SET product_name = 'Product 2.99'
	WHERE product_code = 'PRD4';
	
UPDATE products 
	SET product_name = 'Product 4.99'
	WHERE product_code = 'PRD2';
	
--3 USER
SELECT pid,
		username,
		pg_blocking_pids(pid) AS blocked_by,
		query AS blocked_query
	FROM pg_catalog.pg_stat_activity 
	WHERE CARDINALITY(pg_blocking_pids(pid))>0;