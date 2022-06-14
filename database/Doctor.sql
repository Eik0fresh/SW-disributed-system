SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA doctor_db;

SET default_table_access_method = heap;

CREATE TABLE doctor_db.doctor (
    d_id      integer NOT NULL PRIMARY KEY,
    firstname text    NOT NULL,
    surname   text    NOT NULL,
    email     text    NOT NULL,    
    UNIQUE (firstname, surname)
);

ALTER TABLE doctor_db.doctor ALTER COLUMN d_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doctor_db.doctor_d_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE doctor_db.center (
    c_id      integer NOT NULL PRIMARY KEY,
    name      text    NOT NULL,
    location  text    NOT NULL
);

ALTER TABLE doctor_db.center ALTER COLUMN c_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doctor_db.center_c_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
); -- number of center is limited, maybe no need to set this identity, primary key should be enough

CREATE TABLE doctor_db.work (
    w_id  integer NOT NULL PRIMARY KEY,
    d_id  integer NOT NULL,
    c_id  integer NOT NULL
);

ALTER TABLE doctor_db.work ALTER COLUMN w_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME doctor_db.work_w_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY doctor_db.work
    ADD CONSTRAINT work_d_id_fkey FOREIGN KEY (d_id) REFERENCES doctor_db.doctor(d_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ONLY doctor_db.work
    ADD CONSTRAINT work_c_id_fkey FOREIGN KEY (c_id) REFERENCES doctor_db.center(c_id) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO doctor_db.doctor (firstname, surname, email)
VALUES  ('Max', 'Mustermann', 'Max@Muster.com'),
         ('Andrea', 'Musterfrau', 'Andrea@Muster.com'),
         ('Anton','Mustermann','Anton@Muster.com'),
         ('Tina','Musterfrau','Tina@Muster.com');


INSERT INTO doctor_db.center ("name", "location") 
VALUES ('Mitte', 'Luisenstraße'),
        ('Wedding', 'Amrumer Straße');

INSERT INTO doctor_db.work (d_id, c_id)values (0,0), (0,1),(1,0),(2,0), (3,1);
