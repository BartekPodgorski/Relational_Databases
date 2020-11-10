CREATE TABLE sales (id integer);

DROP SCHEMA training;

DROP SCHEMA training CASCADE;

CREATE TABLE products (id integer PRIMARY KEY);
CREATE TABLE sales (id integer PRIMARY KEY, 
				    product_is integer REFERENCES products);

INSERT INTO products VALUES (1);
INSERT INTO sales VALUES (1,1), (2,1);

DROP TABLE products;

---

DROP TABLE products CASCADE;