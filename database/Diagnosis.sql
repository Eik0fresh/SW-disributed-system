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

CREATE SCHEMA diagnosis_db;

SET default_table_access_method = heap;

CREATE TYPE diagnosis_db.priority AS ENUM ('Normal', 'Urgent', 'VeryUrgent');

CREATE TABLE diagnosis_db.patient (
    p_id      integer NOT NULL PRIMARY KEY,
    firstname text    NOT NULL,
    surname   text    NOT NULL,   
    UNIQUE (firstname, surname)
);

CREATE TABLE diagnosis_db.doctor (
    d_id      integer NOT NULL PRIMARY KEY,
    firstname text    NOT NULL,
    surname   text    NOT NULL,   
    UNIQUE (firstname, surname)
);

CREATE TABLE diagnosis_db.guidance (
    g_id      integer  NOT NULL PRIMARY KEY,
    dia_id    integer  NOT NULL,
    guidance  text     NOT NULL,
    priority  text     NOT NULL, -- data type should be double checked
    date      text     NOT NULL,
    done      boolean  NOT NULL
);

ALTER TABLE diagnosis_db.guidance ALTER COLUMN g_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME diagnosis_db.guidance_g_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE diagnosis_db.diagnosis (
    dia_id  integer NOT NULL PRIMARY KEY,
    --g_id    integer NOT NULL,
    p_id    integer NOT NULL,
    d_id    integer NOT NULL
);

-- not sure about whether dia_id should also increase automatically
-- ALTER TABLE diagnosis_db.diagnosis ALTER COLUMN dia_id ADD GENERATED ALWAYS AS IDENTITY (
--     SEQUENCE NAME diagnosis_db.diagnosis_dia_id
--     START WITH 0
--     INCREMENT BY 1
--     MINVALUE 0
--     NO MAXVALUE
--     CACHE 1
-- );

ALTER TABLE ONLY diagnosis_db.guidance
    ADD CONSTRAINT guidance_dia_id_fkey FOREIGN KEY (dia_id) REFERENCES diagnosis_db.diagnosis(dia_id) ON DELETE CASCADE ON UPDATE CASCADE;
--ALTER TABLE ONLY diagnosis_db.diagnosis
--    ADD CONSTRAINT diagnosis_g_id_fkey FOREIGN KEY (g_id) REFERENCES diagnosis_db.guidance(g_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ONLY diagnosis_db.diagnosis
    ADD CONSTRAINT diagnosis_p_id_fkey FOREIGN KEY (p_id) REFERENCES diagnosis_db.patient(p_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ONLY diagnosis_db.diagnosis
    ADD CONSTRAINT diagnosis_d_id_fkey FOREIGN KEY (d_id) REFERENCES diagnosis_db.doctor(d_id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE diagnosis_db.outbox (
    id UUID NOT NULL PRIMARY KEY,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    type text NOT NULL,
    payload text NOT NULL
);

ALTER TABLE diagnosis_db.outbox OWNER TO postgres;