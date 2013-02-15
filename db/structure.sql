--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    description text,
    starts_at timestamp without time zone,
    duration integer,
    slots integer DEFAULT 1 NOT NULL,
    slots_filled integer DEFAULT 0 NOT NULL,
    bench_count integer DEFAULT 0 NOT NULL,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying(255),
    deleted_at timestamp without time zone,
    platform_id integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants (
    id integer NOT NULL,
    event_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE participants_id_seq OWNED BY participants.id;


--
-- Name: platform_accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE platform_accounts (
    id integer NOT NULL,
    user_id integer,
    platform_id integer,
    username character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: platform_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE platform_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: platform_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE platform_accounts_id_seq OWNED BY platform_accounts.id;


--
-- Name: platforms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE platforms (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE platforms_id_seq OWNED BY platforms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying(255),
    time_zone character varying(255),
    avatar_url character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY participants ALTER COLUMN id SET DEFAULT nextval('participants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY platform_accounts ALTER COLUMN id SET DEFAULT nextval('platform_accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY platforms ALTER COLUMN id SET DEFAULT nextval('platforms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: platform_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY platform_accounts
    ADD CONSTRAINT platform_accounts_pkey PRIMARY KEY (id);


--
-- Name: platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY platforms
    ADD CONSTRAINT platforms_pkey PRIMARY KEY (id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_events_on_platform_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_platform_id ON events USING btree (platform_id);


--
-- Name: index_platform_accounts_on_platform_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_platform_accounts_on_platform_id ON platform_accounts USING btree (platform_id);


--
-- Name: index_platform_accounts_on_platform_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_platform_accounts_on_platform_id_and_user_id ON platform_accounts USING btree (platform_id, user_id);


--
-- Name: index_platform_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_platform_accounts_on_user_id ON platform_accounts USING btree (user_id);


--
-- Name: index_platforms_on_lowercase_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_platforms_on_lowercase_name ON platforms USING btree (lower((name)::text));


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121123181944');

INSERT INTO schema_migrations (version) VALUES ('20121123183111');

INSERT INTO schema_migrations (version) VALUES ('20121124174128');

INSERT INTO schema_migrations (version) VALUES ('20121124183327');

INSERT INTO schema_migrations (version) VALUES ('20121126160237');

INSERT INTO schema_migrations (version) VALUES ('20130201220238');

INSERT INTO schema_migrations (version) VALUES ('20130206210215');

INSERT INTO schema_migrations (version) VALUES ('20130212184523');

INSERT INTO schema_migrations (version) VALUES ('20130213205316');

INSERT INTO schema_migrations (version) VALUES ('20130213212011');

INSERT INTO schema_migrations (version) VALUES ('20130214180633');

INSERT INTO schema_migrations (version) VALUES ('20130214181752');

INSERT INTO schema_migrations (version) VALUES ('20130214182408');

INSERT INTO schema_migrations (version) VALUES ('20130215030548');

INSERT INTO schema_migrations (version) VALUES ('20130215031444');