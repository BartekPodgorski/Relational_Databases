--LIKE/REGULAR EXPRESSION
DROP TABLE IF EXISTS products;

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

SET DATESTYLE TO 'DMY';

INSERT INTO products (product_name, product_code, product_category, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 'Food', 100.25, '20/11/2019'),
 	 		('Product 1', 'PRD2', 'Food', 92.25, '1/11/2019'),
 	 		('Product 2', 'PRD2', 'Tech', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 'Tech', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 'Books', 68.25, '3/11/2019'),
 	 		('Product 5', NULL, 'Books', 11.11, '12/12/2020')
;

SELECT p.*
FROM products p
WHERE product_name LIKE 'Pr%';

SELECT p.*
FROM products p
WHERE lower(product_name) LIKE 'pr%'; --empty

SELECT p.*
FROM products p
WHERE product_name ILIKE 'pr%';

SELECT p.*
FROM products p
WHERE product_code LIKE '%3';

SELECT p.*
FROM products p
WHERE product_code LIKE 'PRD_';

SELECT regexp_match('foobarbequebaz','bar.*que');
SELECT regexp_match('foobarbe123456quebaz','bar.*que');

SELECT regexp_match('foobarbe123456quebaz','[[:digit:]].*');
SELECT regexp_match('foobarbe123456quebaz','[0-9]+');


