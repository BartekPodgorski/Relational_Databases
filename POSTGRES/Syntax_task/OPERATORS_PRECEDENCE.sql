-- OPERATORS PRECEDENCE
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
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020'),
 	 		('Product 4', 'PRD4', 68.25, NULL);
 	 	
SELECT *
FROM products p
WHERE p.product_name = 'PRD1';

SELECT *
FROM products p
WHERE p.product_code != 'PRD1'; 

SELECT *
FROM products p
WHERE p.product_code <> 'PRD1'; --SQL

SELECT *
FROM products p
WHERE p.product_code IN ('PRD1', 'PRD2');

SELECT *
FROM products p
WHERE p.product_code NOT IN ('PRD1');

SELECT *
FROM products p
WHERE p.manufactured_date IS NULL;

SELECT *
FROM products p
WHERE p.manufactured_date IS NOT NULL;

SELECT *
FROM products p
WHERE COALESCE(p.manufactured_date, '10/10/2020') = '10/10/2020';

SELECT *
FROM products p
WHERE p.product_quantity > 10;

SELECT *
FROM products p
WHERE p.product_quantity BETWEEN 12.25 AND 25.25 ;


