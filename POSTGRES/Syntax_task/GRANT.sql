---SUPERUSER
CREATE ROLE accountanter WITH LOGIN PASSWORD 'acc$1Passw0r4';
GRANT ALL PRIVILEGES ON DATABASE postgres TO accountanter;
GRANT ALL PRIVILEGES ON SCHEMA PUBLIC TO accountanter;

DROP ROLE accountanter;

REASSIGN OWNED BY accountanter TO postgres;
DROP OWNED BY accountanter;
DROP ROLE accountanter;

CREATE ROLE accountant WITH LOGIN PASSWORD 'acc$1Passw0r4';
REVOKE ALL PRIVILEGES ON SCHEMA public FROM PUBLIC;

CREATE ROLE readonly_accountants;
GRANT CONNECT ON DATABASE postgres TO readonly_accountants;

CREATE SCHEMA accountants;
CREATE TABLE accountants.test(id integer);

GRANT USAGE ON SCHEMA accountants TO readonly_accountants;
GRANT SELECT ON TABLE accountants.test TO readonly_accountants;

GRANT readonly_accountants TO accountant;

--test FOR accountant
CREATE TABLE public.test (id integer);
CREATE SCHEMA accountant;

SELECT * FROM accountants.test t ;