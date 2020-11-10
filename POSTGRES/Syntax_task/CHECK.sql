CREATE SCHEMA checker
CREATE  TABLE sales (
	id integer,
	sales NUMERIC CHECK (sales > 1000)
);

CREATE  TABLE sales2 (
	id integer,
	sales NUMERIC CONSTRAINT sales_over1k CHECK (sales > 1000)
);

CREATE  TABLE sales3 (
	id integer,
	sales NUMERIC,
	CONSTRAINT sales_over1k CHECK (sales > 1000)
);

CREATE  TABLE sales4 (
	id integer,
	sales NUMERIC
);

ALTER TABLE sales4 ADD CONSTRAINT sales_over1k CHECK (sales > 1000);

CREATE  TABLE sales5 (
	id integer,
	discount NUMERIC,
	sales NUMERIC CHECK (discount < sales)
);

INSERT INTO sales5 VALUES(1,100,10);
INSERT INTO sales5 VALUES(1,10,100);

ALTER TABLE sales4 DROP CONSTRAINT sales_over1k;