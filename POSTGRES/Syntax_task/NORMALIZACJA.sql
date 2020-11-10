CREATE SCHEMA normalizations


CREATE TABLE contacts (
    name_surname TEXT,
	gender TEXT,
	city TEXT,
	country TEXT,
	id_company INTEGER,
	company TEXT,
	added_by TEXT,
	verified_by TEXT
);

INSERT INTO contacts 
	  VALUES ('Krzysztof Bury', 'M', 'Kraków', 'Polska', 1, 'Data Craze', 'admin', null),
	  		 ('Katarzyna Kowalska', 'F', 'Ateny', 'Polska', 2, 'ACME', 'admin', null);

--1 NF ->relacja i nie ma powtarzajacych sie grup
DELETE FROM contacts;
ALTER TABLE contacts DROP name_surname;
ALTER TABLE contacts ADD COLUMN name TEXT;
ALTER TABLE contacts ADD COLUMN surname TEXT PRIMARY KEY;

INSERT INTO contacts 
	VALUES ('M', 'Kraków', 'Polska', 1, 'Data Craze', 'admin', NULL, 'Krzysztof', 'Bury'),
		('F', 'Ateny', 'Polska', 2, 'ACME', 'admin', NULL,'Katarzyna','Kowalska' );
		
--2 NF -> 1 klucz kandydat - usuwamy wszystkie inne candidate (inne tabelki)
CREATE TABLE customer_gender (
	cust_surname TEXT,
	gender TEXT
);
INSERT INTO customer_gender VALUES ('Kowalska','F'),('Bury','M');
ALTER TABLE contacts DROP gender;
--3 NF - wszystko zalezy od klucza
CREATE TABLE company(
	id integer,
	company_name TEXT
);

INSERT INTO company VALUES (1,'Data Craze'),(2,'ACME');
ALTER TABLE contacts DROP company;
--Boyce Codd
CREATE TABLE city_country(
	city TEXT,
	country TEXT
);
INSERT INTO city_country VALUES ('Kraków','Polska'), ('Ateny','Polska');
ALTER TABLE contacts DROP country;
-- 4NF -> Unikamy wiele do wielu
CREATE TABLE contacts_verified_by (
	cust_surname TEXT,
	verified_by TEXT
);

CREATE TABLE contacts_added_by (
	cust_surname TEXT,
	added_by TEXT
);

INSERT INTO contacts_verified_by 
     VALUES ('Kowalska','admin'), 
  			('Bury','admin');

ALTER TABLE contacts DROP added_by;
ALTER TABLE contacts DROP verified_by;

SELECT * FROM contacts; 