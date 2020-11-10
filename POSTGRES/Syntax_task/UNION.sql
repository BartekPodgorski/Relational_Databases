--UNION / UNION ALL
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
 	 		('Product World Class', 'PRD3', '1/11/2008');
 	 	
--Union 1 error not equal amount of columns
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
		UNION
SELECT product_name, product_code, manufactured_date 
	FROM products_old_system; 

--Union 2
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
		UNION
SELECT product_name, product_code, manufactured_date, NULL AS product_quantity 
	FROM products_old_system;

--UNION 3 error group by
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
	ORDER BY product_code
		UNION
SELECT product_name, product_code, manufactured_date, NULL AS product_quantity 
	FROM products_old_system;

--Union 4 order by on first select
SELECT *
	FROM (SELECT product_name, product_code, manufactured_date, product_quantity
		FROM products 
		ORDER BY product_code) sq
	UNION
SELECT product_name, product_code, manufactured_date, NULL AS product_quantity 
	FROM products_old_system;

--UNION 5 orden on all
SELECT product_name, product_code, manufactured_date, product_quantity
	FROM products 
		UNION
SELECT product_name, product_code, manufactured_date, NULL AS product_quantity 
	FROM products_old_system
	ORDER BY product_code;

--Union 6 
SELECT product_code
	FROM products
		UNION ALL
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;
--UNION 7
SELECT product_code
	FROM products
		UNION 
SELECT product_code 
	FROM products_old_system
	ORDER BY product_code;
