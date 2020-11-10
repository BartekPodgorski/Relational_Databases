-- EXISTS
DROP TABLE IF EXISTS products, categories CASCADE;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_category varchar(25),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,	
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

CREATE TABLE categories (
	id SERIAL,
	category_name VARCHAR(25)
);
SET DATESTYLE TO 'DMY';
INSERT INTO products (product_name, product_code, product_category, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Food', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'Food', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'Tech', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'Tech', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'Books', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 'Books', 11.11, '12/12/2020')
;
INSERT INTO categories (category_name)
	VALUES ('Food'),('Tech'),('Misc');

SELECT p.*
	FROM products p 
	WHERE EXISTS (SELECT 1
				FROM categories c
				WHERE c.category_name = p.product_category);
