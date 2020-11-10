
CREATE TABLE sales (
	id integer NOT NULL,
	description TEXT UNIQUE
);

INSERT INTO sales VALUES(1,'ABC');
INSERT INTO sales VALUES(2,NULL);
INSERT INTO sales VALUES(3,NULL);
INSERT INTO sales VALUES(4,'ABC');
 
CREATE TABLE products(
	id integer NOT NULL,
	product_short_code varchar(10),
	product_no varchar(5),
	UNIQUE(product_short_code, product_no)
);