CREATE TABLE sales (
	id integer
);

CREATE TABLE sales (
	id integer,
	descritpion text
);
--Nie dokona zmian na naszej tabeli
CREATE TABLE IF NOT EXISTS sales (
	id integer,
	descritpion text
);
DROP TABLE IF EXISTS sales;