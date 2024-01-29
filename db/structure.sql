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

--
-- Name: ulid; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ulid WITH SCHEMA public;


--
-- Name: EXTENSION ulid; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION ulid IS 'ulid type and methods';


--
-- Name: item_level; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_level AS ENUM (
    'debug',
    'info',
    'warning',
    'error',
    'critical'
);


--
-- Name: item_state; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_state AS ENUM (
    'active',
    'resolved',
    'muted'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) with time zone NOT NULL,
    updated_at timestamp(6) with time zone NOT NULL
);


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id public.ulid DEFAULT public.gen_ulid() NOT NULL,
    project_id public.ulid NOT NULL,
    library character varying,
    revision character varying,
    status public.item_state DEFAULT 'active'::public.item_state NOT NULL,
    read boolean DEFAULT false NOT NULL,
    level public.item_level DEFAULT 'error'::public.item_level NOT NULL,
    type character varying,
    message character varying,
    stack_trace text,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE items; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.items IS 'Itens';


--
-- Name: COLUMN items.project_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.project_id IS 'Projeto relacionado';


--
-- Name: COLUMN items.library; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.library IS 'Biblioteca ou integração que reportou o item';


--
-- Name: COLUMN items.revision; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.revision IS 'Versão ou git commit SHA';


--
-- Name: COLUMN items.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.status IS 'Status do item';


--
-- Name: COLUMN items.read; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.read IS 'Indica se o item foi lido ou não';


--
-- Name: COLUMN items.level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.level IS 'Nível de gravidade do item';


--
-- Name: COLUMN items.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.type IS 'Tipo ou categoria do item (NoMethodError, SyntaxError, etc.)';


--
-- Name: COLUMN items.message; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.message IS 'Mensagem associada ao item';


--
-- Name: COLUMN items.stack_trace; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.items.stack_trace IS 'Stack trace associado ao item';


--
-- Name: project_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_memberships (
    id bigint NOT NULL,
    project_id public.ulid NOT NULL,
    user_id public.ulid NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE project_memberships; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.project_memberships IS 'Associação entre usuários e projetos';


--
-- Name: project_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.project_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.project_memberships_id_seq OWNED BY public.project_memberships.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id public.ulid DEFAULT public.gen_ulid() NOT NULL,
    owner_id public.ulid NOT NULL,
    name character varying NOT NULL,
    token character varying NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE projects; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.projects IS 'Projetos';


--
-- Name: COLUMN projects.owner_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.projects.owner_id IS 'Usuário proprietário do projeto';


--
-- Name: COLUMN projects.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.projects.name IS 'Nome do projeto';


--
-- Name: COLUMN projects.token; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.projects.token IS 'Token utilizado para vincular eventos ao projeto';


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id public.ulid DEFAULT public.gen_ulid() NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    provider character varying NOT NULL,
    uid uuid NOT NULL
);


--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.users IS 'Usuários';


--
-- Name: COLUMN users.first_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.first_name IS 'Primeiro nome do usuário';


--
-- Name: COLUMN users.last_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.last_name IS 'Sobrenome do usuário';


--
-- Name: COLUMN users.email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.email IS 'Endereço de e-mail, único para cada usuário';


--
-- Name: COLUMN users.provider; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.provider IS 'Provedor de autenticação OAuth';


--
-- Name: COLUMN users.uid; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.uid IS 'ID do usuário fornecido pelo provedor OAuth';


--
-- Name: project_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_memberships ALTER COLUMN id SET DEFAULT nextval('public.project_memberships_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: project_memberships project_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT project_memberships_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_items_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_project_id ON public.items USING btree (project_id);


--
-- Name: index_items_on_project_id_and_revision; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_project_id_and_revision ON public.items USING btree (project_id, revision);


--
-- Name: index_project_memberships_on_project_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_project_memberships_on_project_id_and_user_id ON public.project_memberships USING btree (project_id, user_id);


--
-- Name: index_projects_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_owner_id ON public.projects USING btree (owner_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_provider_and_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_provider_and_uid ON public.users USING btree (provider, uid);


--
-- Name: project_memberships fk_rails_18b611e244; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT fk_rails_18b611e244 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: projects fk_rails_219ef9bf7d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_219ef9bf7d FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: project_memberships fk_rails_86b046ec96; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT fk_rails_86b046ec96 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: items fk_rails_f6abf55b81; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT fk_rails_f6abf55b81 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20231219003009'),
('20231219002544'),
('20231219001802'),
('20231218215840'),
('20231218210447'),
('20231218210446');

