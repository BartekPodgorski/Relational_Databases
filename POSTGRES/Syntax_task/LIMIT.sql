--LIMIT I OFFSET 
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
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019');

SELECT p.product_name,
       p.product_code, 
       p.manufactured_date,
       p.product_quantity * 0.5 AS half_qty
  FROM products p 
 LIMIT 1 OFFSET 2;

UPDATE products SET product_code = 'PRD2.1' WHERE product_name = 'Product 2';

SELECT p.product_name,
       p.product_code, 
       p.manufactured_date,
       p.product_quantity * 0.5 AS half_qty
  FROM products p 
 LIMIT 1 OFFSET 2;
 
SELECT p.product_name,
       p.product_code, 
       p.manufactured_date,
       p.product_quantity * 0.5 AS half_qty
  FROM products p 
 LIMIT 1 OFFSET 6;