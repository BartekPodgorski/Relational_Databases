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

-- INSERT
INSERT INTO products (id, product_name, product_code, 
			product_quantity, manufactured_date, added_by, created_date) 
			VALUES (1, 'Product 1', 'PRD1', 100, '20.11.2019', NULL, '21.9.2020 14:56:25');
SET DATESTYLE TO 'DMY';     
SELECT * FROM products;    

-- INSERT 2 - SQL STYLE + WRONG DATE FORMAT
INSERT INTO products (id, product_name, product_code, 
					  product_quantity, manufactured_date, 
					  added_by, created_date) 
	 VALUES (1, 'Product 1', 'PRD1', 100, 
	 		 '11.20.2019', NULL, '21.9.2020 2:56:25 PM');
	 		 
SHOW datestyle;	 		

-- WIECEJ: https://www.postgresql.org/docs/12/datatype-datetime.html

-- INSERT 3 - DATE / TIMESTAMP FORMAT
INSERT INTO products (id, product_name, product_code, 
					  product_quantity, manufactured_date, 
					  added_by, created_date) 
	 VALUES (1, 'Product 1', 'PRD1', 100, 
	 		 '20/11/2019', NULL, '21.9.2020 2:56:25 PM');
	 		 
-- INSERT 4 (ADDED_BY + VARCHAR)
INSERT INTO products (id, product_name, product_code, 
					  product_quantity, manufactured_date, 
					  added_by, created_date) 
	 VALUES (1, 'Product 1', 'PRD12345678', 100.25, 
	 		 '20/11/2019', 'kbury', '21.9.2020 2:56:25 PM');	

-- INSERT 5 -- ERROR
INSERT INTO products  VALUES ('Product 1', 'PRD12345678', 100.25, '20/11/2019', 'kbury', '21.9.2020 2:56:25 PM');
INSERT INTO products  VALUES (1, 'Product 1', 'PRD1', 100.25, '20/11/2019', 'kbury', '21.9.2020 2:56:25 PM');

-- INSERT 6 -- VALUES
INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)					    
 	 VALUES ('Product 1', 'PRD1', 100.25, '20/11/2019'),
 	 		('Product 2', 'PRD2', 12.25, '1/11/2019'),
 	 		('Product 3', 'PRD3', 25.25, '2/11/2019'),
 	 		('Product 4', 'PRD4', 68.25, '3/11/2019')
; 					  