-- ANY / SOME / ALL / IN / NOT IN 
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
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 11.11, '12/12/2020')
;

--IN
SELECT *
FROM products
WHERE product_code IN ('PRD1', 'PRD3');
--NOT IN
SELECT *
FROM products
WHERE product_code NOT IN ('PRD1', 'PRD3');
--WE don't GET NULL

--COALESCE
SELECT *
FROM products
WHERE COALESCE (product_code, '') IN ('PRD1', 'PRD3');

SELECT *
FROM products
WHERE COALESCE (product_code, '') NOT IN ('PRD1', 'PRD3');

--ANY
SELECT *
FROM products
WHERE COALESCE (product_code, '') 
		= ANY(SELECT DISTINCT product_code
				FROM products);
				
SELECT *
FROM products
WHERE COALESCE (product_code, '') 
		= ANY(SELECT DISTINCT COALESCE (product_code, '')
				FROM products);
				
--ALL
SELECT *
FROM products
WHERE COALESCE (product_code, '') 
		= ALL(SELECT DISTINCT product_code
				FROM products);	
				
SELECT *
FROM products
WHERE COALESCE (product_code, '') 
		= ALL(SELECT DISTINCT product_code
				FROM products
				WHERE product_name = 'Product 2');	
				
SELECT *
FROM products
WHERE 15.00
	< ALL(SELECT DISTINCT product_quantity
			FROM products);