--DISTINCT
DROP TABLE IF EXISTS products CASCADE ;

CREATE TABLE products(
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	manufactured_date DATE
);
SET DATESTYLE TO 'DMY';
INSERT INTO products 
	VALUES  ('Product 1','PRD1','10/11/2020'),
			('Product 1','PRD1','10/11/2020'),
			('Product 1','PRD1.1','10/11/2020');

SELECT * FROM products ; 

SELECT DISTINCT * FROM products ;

SELECT product_name,manufactured_date FROM products;

DROP TABLE IF EXISTS products CASCADE ;

CREATE TABLE products(
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	description TEXT,
	manufactured_date DATE,
	valid_from timestamp,
	valid_to timestamp
);

INSERT INTO products VALUES ('Product 1', 'PRD1', 'Product 1 - cool product.', '10/11/2018', '01/01/2018 00:00:00','31/12/2018 23:59:59');
INSERT INTO products VALUES ('Product 1', 'PRD1', 'Product 1 - product upgrade.', '10/11/2018', '01/01/2019 00:00:00', null);

SELECT product_name,
		product_code,
		manufactured_date
	FROM products;

SELECT DISTINCT product_name,
		product_code,
		manufactured_date
	FROM products;

-- lost of bussiness knowledge

SELECT  product_name,
		product_code,
		manufactured_date
	FROM products
	WHERE valid_to IS NULL;
