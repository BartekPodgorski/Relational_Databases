--INTERSECT / EXCEPT
DROP TABLE IF EXISTS products, products_old_system;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE products_old_system (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	manufactured_date DATE
);

SET DATESTYLE TO 'DMY';

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2020'),
 	 		('Product 4', 'PRD4', 68.25, NULL)
;

INSERT INTO products_old_system (product_name, product_code, manufactured_date)					    
 	 VALUES ('Product Best Seller', 'PRD1', '20/11/2006'),
 	 		('Product Most Important', 'PRD2', '1/11/2009'),
 	 		('Product Most Important', 'PRD2', '1/11/2007'),
 	 		('Product World Class', 'PRD3', '1/11/2008');
;
--Intersect 1 -error
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
		INTERSECT
SELECT product_name, product_code, manufactured_date 
	FROM products_old_system;

--INTERSECT 2
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
		INTERSECT
SELECT product_name, product_code, manufactured_date, NULL AS product_quantity 
	FROM products_old_system;

--INTERSECT 3
SELECT product_code
	FROM products
		INTERSECT ALL
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;

--INTERSECT 4
SELECT product_code
	FROM products
		INTERSECT 
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;

--EXCEPT	
SELECT product_code
	FROM products
		EXCEPT ALL 
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;
	
SELECT product_code
	FROM products
		EXCEPT 
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;