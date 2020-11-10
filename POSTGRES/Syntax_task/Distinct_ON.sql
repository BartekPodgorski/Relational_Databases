--DISTINCT ON
DROP TABLE IF EXISTS products CASCADE ;

CREATE TABLE products(
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	manufactured_date DATE
);
SET DATESTYLE TO 'DMY';
INSERT INTO products 
	VALUES  ('Product 1','PRD1','10/11/2020'),
			('Product 1','PRD1','11/11/2020'),
			('Product 1','PRD1.1','10/11/2020');

SELECT * FROM products ; 

SELECT DISTINCT ON (product_code) *
	FROM products;
--FAIL -> lack of group
SELECT DISTINCT ON (product_code) *
	FROM products
ORDER BY manufactured_date;

SELECT DISTINCT ON (product_code) *
	FROM products
ORDER BY product_code, manufactured_date DESC;