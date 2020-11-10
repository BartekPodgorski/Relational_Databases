SELECT * FROM products;
ALTER TABLE products
	DROP description;

DROP TABLE sales;
CREATE TABLE sales(
	id integer PRIMARY KEY,
	product_id integer REFERENCES products
)
CREATE TABLE sales_2019(
	id integer,
	product_id integer,
	FOREIGN KEY (product_id) REFERENCES products
)
CREATE TABLE sales_2020(
	id integer,
	product_id integer
)
ALTER TABLE sales_2020 ADD CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products
ALTER TABLE sales_2020 ADD FOREIGN KEY (product_id) REFERENCES products
ALTER TABLE sales_2020 DROP CONSTRAINT fk_products

CREATE TABLE sales_2021 (
	id integer,
	product_id integer REFERENCES products ON DELETE CASCADE
);

INSERT INTO sales_2020 VALUES (1, NULL);

INSERT INTO products VALUES (1),(2),(3);
INSERT INTO sales_2021 VALUES (1, 1);
INSERT INTO sales_2021 VALUES (2, 1);

/*
CREATE TABLE products(
	id integer,
	description TEXT,
	PRIMARY KEY (id)
);

CREATE TABLE sales (
	id integer PRIMARY KEY,
	description TEXT
);

CREATE TABLE customers (
	id integer,
	name TEXT
);
INSERT INTO customers VALUES (NULL,'Customer 1'),(1,'Customer 2');
SELECT * FROM customers;
ALTER TABLE customers ADD CONSTRAINT pk_customers PRIMARY KEY (id);
ALTER TABLE customers ADD PRIMARY KEY (id);
ALTER TABLE customers DROP CONSTRAINT customers_pkey;

CREATE SCHEMA trainig;
ALTER SCHEMA trainig RENAME TO training;
CREATE TABLE new_table (id integer);
ALTER TABLE new_table RENAME TO newer_table;
ALTER TABLE newer_table
	ADD COLUMN description TEXT;
ALTER TABLE newer_table
	RENAME description TO descr;

ALTER TABLE newer_table 
	DROP descr;

ALTER TABLE newer_table 
	DROP id;

CREATE DATABASE test
	WITH ENCODING 'WIN1250'
		TEMPLATE=template0;

CREATE SCHEMA training;

CREATE TABLE test_tbl(
	id integer
);

CREATE TABLE training.test_tbl(
	id integer
);
DROP TABLE test_tbl;
DROP TABLE training.test_tbl;
CREATE TABLE training.test_tbl(
	id integer,
	description text
);
DROP SCHEMA training;
CREATE TABLE test (id integer);
CREATE TABLE test2 (id integer);

DROP TABLE test,test2 ;
DROP DATABASE test;
*/