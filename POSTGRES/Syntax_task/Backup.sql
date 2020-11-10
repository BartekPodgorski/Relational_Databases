DROP TABLE IF EXISTS sales cascade;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date date,
	sal_value NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);

INSERT INTO sales (sal_description,sal_date,sal_value)
	SELECT left(md5(i::text),10),
	NOW() + (random() * (INTERVAL '90 days')) + '30 days',
	random() * 10 + 1
	FROM generate_series(1,20000) s(i);

SELECT count(*) FROM sales;
TRUNCATE TABLE sales RESTART IDENTITY;

pg_dump --host localhost ^
        --port 5432 ^
        --username postgres ^
        --format d ^
        --file "C:\Users\user\Desktop\SQL\db_postgres_dump" ^
        --table public.sales ^
        postgres

pg_dump --host localhost ^
        --port 5432 ^
        --username postgres ^
        --format plain ^
        --file "C:\Users\user\Desktop\SQL\public_sales_bp.sql" ^
        --table public.sales ^
        postgres

pg_restore --host localhost ^
           --port 5432 ^
           --username postgres ^
           --dbname postgres ^
           --clean ^
           --"C:\Users\user\Desktop\SQL\db_postgres_dump"    

psql -U postgres -p 5432 -h localhost -d postgres -f "C:\Users\user\Desktop\SQL\public_sales_bp.sql"