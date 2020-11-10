SHOW search_path;

SELECT * FROM pg_catalog.pg_roles;
SELECT * FROM pg_catalog.pg_user;
SELECT * FROM pg_catalog.pg_group;

CREATE ROLE training_user WITH SUPERUSER PASSWORD 'tuser$1';
DROP ROLE training_user;
CREATE ROLE training_user WITH LOGIN SUPERUSER PASSWORD 'tuser$1';

CREATE ROLE app_reporting_ro WITH LOGIN PASSWORD 'appReporting#0';
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE postgres FROM PUBLIC;

GRANT CONNECT ON DATABASE postgres TO PUBLIC;

CREATE TABLE test(id integer);
