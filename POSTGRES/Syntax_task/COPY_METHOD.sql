--INSERT CORNER CASES
DROP TABLE IF EXISTS sales cascade;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date date,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

EXPLAIN ANALYZE
INSERT INTO sales (sal_description,sal_date,sal_value)
	SELECT left(md5(i::text),10),
	NOW() + (random() * (INTERVAL '90 days')) + '30 days',
	random() * 10 + 1
	FROM generate_series(1,20000) s(i);

SELECT count(*) FROM sales;


TRUNCATE sales RESTART IDENTITY;
SELECT pg_size_pretty(pg_total_relation_size('sales'));
-- Z copy
--COPY public.sales TO 'C:\Users\user\Desktop\SQL\first_copy.copy';
--COPY public.sales FROM 'C:\Users\user\Desktop\SQL\first_copy.copy';