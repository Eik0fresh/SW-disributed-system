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

CREATE SCHEMA feedback_db

SET default_table_access_method = heap;

CREATE TABLE feedback_db.question (
    q_id     integer NOT NULL PRIMARY KEY,
    a_id     integer NOT NULL,  -- also needed?
    question text    NOT NULL,  
    format   text    NOT NULL  -- data type need to be double checked 
);

ALTER TABLE feedback_db.question ALTER COLUMN q_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME feedback_db.question_q_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY feedback_db.question
    ADD CONSTRAINT question_a_id_fkey FOREIGN KEY (a_id) REFERENCES feedback_db.answer(a_id) ON DELETE CASCADE ON UPDATE CASCADE;
-- 1 question has many answers?

CREATE TABLE feedback_db.answer (
    a_id    integer NOT NULL PRIMARY KEY,
    q_id    integer NOT NULL,
    answer  text    NOT NULL,  -- data type should be double checked
    day     date    NOT NULL  
);

ALTER TABLE feedback_db.answer ALTER COLUMN a_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME feedback_db.answer_a_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY feedback_db.answer
    ADD CONSTRAINT answer_q_id_fkey FOREIGN KEY (q_id) REFERENCES feedback_db.question(q_id) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE feedback_db.guidance (
    g_id      integer  NOT NULL PRIMARY KEY,
    guidance  text     NOT NULL,
    priority  smallint NOT NULL,   -- data type should be double checked
    day       date     NOT NULL,
    done      boolean  NOT NULL
);

-- ALTER TABLE feedback_db.guidance ALTER COLUMN g_id ADD GENERATED ALWAYS AS IDENTITY (
--     SEQUENCE NAME feedback_db.guidance_g_id
--     START WITH 0
--     INCREMENT BY 1
--     MINVALUE 0
--     NO MAXVALUE
--     CACHE 1
-- );

CREATE TABLE feedback_db.feedback (
    f_id     integer NOT NULL PRIMARY KEY,
    g_id     integer NOT NULL,
    feedback text    NOT NULL,
    day      date    NOT NULL
);

ALTER TABLE feedback_db.feedback ALTER COLUMN f_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME feedback_db.feedback_f_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY feedback_db.feedback
    ADD CONSTRAINT feedback_g_id_fkey FOREIGN KEY (g_id) REFERENCES feedback_db.guidance(g_id) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE feedback_db.map_question_guidance (
    qg_id    integer NOT NULL PRIMARY KEY,
    g_id     integer NOT NULL,
    q_id     integer NOT NULL
);

ALTER TABLE feedback_db.map_question_guidance ALTER COLUMN qg_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME feedback_db.map_question_guidance_qg_id
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY feedback_db.map_question_guidance
    ADD CONSTRAINT map_question_guidance_g_id_fkey FOREIGN KEY (g_id) REFERENCES feedback_db.guidance(g_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ONLY feedback_db.map_question_guidance
    ADD CONSTRAINT map_question_guidance_q_id_fkey FOREIGN KEY (q_id) REFERENCES feedback_db.question(q_id) ON DELETE CASCADE ON UPDATE CASCADE;