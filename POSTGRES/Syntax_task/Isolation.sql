--Isolations
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

--TURN OFF AUTOCOMMIT
DELETE FROM products;

SELECT * FROM products; --EMPTY TABLE 
COMMIT;

UPDATE products SET product_code = 'PRD1';

DELETE FROM products WHERE product_code = 'PRD1';

--SECOND USER
SELECT * FROM products; --All products are
SET DATESTYLE TO 'DMY';
INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
	VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019');
COMMIT;
UPDATE products
	SET product_code = 'PRD10'
	WHERE product_code = 'PRD1'
;
