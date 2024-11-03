--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.8

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.channels (
    id_channel integer NOT NULL,
    name text NOT NULL,
    description text,
    image_channel text,
    status_channel boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.channels OWNER TO postgres;

--
-- Name: channels_id_channel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.channels_id_channel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.channels_id_channel_seq OWNER TO postgres;

--
-- Name: channels_id_channel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.channels_id_channel_seq OWNED BY public.channels.id_channel;


--
-- Name: direct_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direct_message (
    id_direct_message integer NOT NULL,
    send_id text NOT NULL,
    recipient_id text NOT NULL,
    content text NOT NULL,
    url_file text,
    type_message text DEFAULT 'message'::text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.direct_message OWNER TO postgres;

--
-- Name: direct_message_id_direct_message_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.direct_message_id_direct_message_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.direct_message_id_direct_message_seq OWNER TO postgres;

--
-- Name: direct_message_id_direct_message_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.direct_message_id_direct_message_seq OWNED BY public.direct_message.id_direct_message;


--
-- Name: history_maintenances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history_maintenances (
    id_history_maintenance integer NOT NULL,
    user_id text NOT NULL,
    date_maintenance timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.history_maintenances OWNER TO postgres;

--
-- Name: history_maintenances_id_history_maintenance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.history_maintenances_id_history_maintenance_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_maintenances_id_history_maintenance_seq OWNER TO postgres;

--
-- Name: history_maintenances_id_history_maintenance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.history_maintenances_id_history_maintenance_seq OWNED BY public.history_maintenances.id_history_maintenance;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id_message integer NOT NULL,
    user_id text NOT NULL,
    channel_id integer NOT NULL,
    content text NOT NULL,
    url_file text,
    type_message text DEFAULT 'message'::text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_message_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_message_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_message_seq OWNER TO postgres;

--
-- Name: messages_id_message_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_message_seq OWNED BY public.messages.id_message;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id_permission integer NOT NULL,
    name text NOT NULL,
    status_permission boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_permission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_permission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_permission_seq OWNER TO postgres;

--
-- Name: permissions_id_permission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_permission_seq OWNED BY public.permissions.id_permission;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_role integer NOT NULL,
    name text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_role_seq OWNER TO postgres;

--
-- Name: roles_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_role_seq OWNED BY public.roles.id_role;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    id_token integer NOT NULL,
    token text NOT NULL,
    user_id text NOT NULL,
    status_token boolean DEFAULT true NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- Name: tokens_id_token_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tokens_id_token_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_token_seq OWNER TO postgres;

--
-- Name: tokens_id_token_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tokens_id_token_seq OWNED BY public.tokens.id_token;


--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    id_user_permission integer NOT NULL,
    permission_id integer NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- Name: user_permissions_id_user_permission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_permissions_id_user_permission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_permissions_id_user_permission_seq OWNER TO postgres;

--
-- Name: user_permissions_id_user_permission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_permissions_id_user_permission_seq OWNED BY public.user_permissions.id_user_permission;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user text NOT NULL,
    network_user text NOT NULL,
    full_name text NOT NULL,
    photo_url text,
    dominio text,
    password text NOT NULL,
    status_user boolean DEFAULT true NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_channels (
    id_user_channel integer NOT NULL,
    user_id text NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.users_channels OWNER TO postgres;

--
-- Name: users_channels_id_user_channel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_channels_id_user_channel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_channels_id_user_channel_seq OWNER TO postgres;

--
-- Name: users_channels_id_user_channel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_channels_id_user_channel_seq OWNED BY public.users_channels.id_user_channel;


--
-- Name: vulgar_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vulgar_words (
    id_vulgar_words integer NOT NULL,
    word text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.vulgar_words OWNER TO postgres;

--
-- Name: vulgar_words_id_vulgar_words_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vulgar_words_id_vulgar_words_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vulgar_words_id_vulgar_words_seq OWNER TO postgres;

--
-- Name: vulgar_words_id_vulgar_words_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vulgar_words_id_vulgar_words_seq OWNED BY public.vulgar_words.id_vulgar_words;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    id bigint NOT NULL,
    topic text NOT NULL,
    extension text NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE SEQUENCE realtime.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE realtime.messages_id_seq OWNER TO supabase_realtime_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER SEQUENCE realtime.messages_id_seq OWNED BY realtime.messages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER TABLE vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: channels id_channel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.channels ALTER COLUMN id_channel SET DEFAULT nextval('public.channels_id_channel_seq'::regclass);


--
-- Name: direct_message id_direct_message; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direct_message ALTER COLUMN id_direct_message SET DEFAULT nextval('public.direct_message_id_direct_message_seq'::regclass);


--
-- Name: history_maintenances id_history_maintenance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_maintenances ALTER COLUMN id_history_maintenance SET DEFAULT nextval('public.history_maintenances_id_history_maintenance_seq'::regclass);


--
-- Name: messages id_message; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id_message SET DEFAULT nextval('public.messages_id_message_seq'::regclass);


--
-- Name: permissions id_permission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id_permission SET DEFAULT nextval('public.permissions_id_permission_seq'::regclass);


--
-- Name: roles id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_role SET DEFAULT nextval('public.roles_id_role_seq'::regclass);


--
-- Name: tokens id_token; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id_token SET DEFAULT nextval('public.tokens_id_token_seq'::regclass);


--
-- Name: user_permissions id_user_permission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions ALTER COLUMN id_user_permission SET DEFAULT nextval('public.user_permissions_id_user_permission_seq'::regclass);


--
-- Name: users_channels id_user_channel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_channels ALTER COLUMN id_user_channel SET DEFAULT nextval('public.users_channels_id_user_channel_seq'::regclass);


--
-- Name: vulgar_words id_vulgar_words; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vulgar_words ALTER COLUMN id_vulgar_words SET DEFAULT nextval('public.vulgar_words_id_vulgar_words_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages ALTER COLUMN id SET DEFAULT nextval('realtime.messages_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	839a028c-1ad2-47e9-87ae-8090f77bc027	{"action":"user_invited","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"supabase_admin","actor_via_sso":false,"log_type":"team","traits":{"user_email":"midnight3424@gmail.com","user_id":"74c99eab-1d02-4cd8-add0-bbbfbb9da52f"}}	2024-07-09 13:40:34.678787+00	
00000000-0000-0000-0000-000000000000	4bebd4e6-54a4-4449-80cc-ea26c51f6d36	{"action":"user_signedup","actor_id":"74c99eab-1d02-4cd8-add0-bbbfbb9da52f","actor_username":"midnight3424@gmail.com","actor_via_sso":false,"log_type":"team"}	2024-07-09 13:41:33.593408+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
74c99eab-1d02-4cd8-add0-bbbfbb9da52f	74c99eab-1d02-4cd8-add0-bbbfbb9da52f	{"sub": "74c99eab-1d02-4cd8-add0-bbbfbb9da52f", "email": "midnight3424@gmail.com", "email_verified": false, "phone_verified": false}	email	2024-07-09 13:40:34.67296+00	2024-07-09 13:40:34.67302+00	2024-07-09 13:40:34.67302+00	0a9adce8-6d84-4f71-aecb-a3fb87166eb5
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
c912c8bc-84c6-4969-bcdf-5bca775608df	2024-07-09 13:41:33.610114+00	2024-07-09 13:41:33.610114+00	otp	4d93fe94-0eb8-4526-88fb-dc0ce6d7000f
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	em0-bz0qiIeHezhahhRkAA	74c99eab-1d02-4cd8-add0-bbbfbb9da52f	f	2024-07-09 13:41:33.603249+00	2024-07-09 13:41:33.603249+00	\N	c912c8bc-84c6-4969-bcdf-5bca775608df
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
c912c8bc-84c6-4969-bcdf-5bca775608df	74c99eab-1d02-4cd8-add0-bbbfbb9da52f	2024-07-09 13:41:33.598638+00	2024-07-09 13:41:33.598638+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Mobile Safari/537.36	191.95.38.24	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	74c99eab-1d02-4cd8-add0-bbbfbb9da52f	authenticated	authenticated	midnight3424@gmail.com		2024-07-09 13:41:33.594227+00	2024-07-09 13:40:34.683176+00		2024-07-09 13:40:34.683176+00		\N			\N	2024-07-09 13:41:33.598571+00	{"provider": "email", "providers": ["email"]}	{}	\N	2024-07-09 13:40:34.65909+00	2024-07-09 13:41:33.609616+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.channels (id_channel, name, description, image_channel, status_channel, created_at, updated_at) FROM stdin;
1	Grupo 1	\N	https://static.wikia.nocookie.net/6099e51f-24b5-412e-ab3f-53931e23854b/scale-to-width/755	t	2024-09-27 07:57:20.947	2024-09-27 12:57:21.081
\.


--
-- Data for Name: direct_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direct_message (id_direct_message, send_id, recipient_id, content, url_file, type_message, created_at, updated_at) FROM stdin;
3	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	hola	\N	message	2024-09-30 10:25:44.754	2024-09-30 15:25:45.936
4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	sisas pai	\N	message	2024-09-30 10:26:11.356	2024-09-30 15:26:13.846
5	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	j	\N	message	2024-10-01 08:43:32.165	2024-10-01 13:43:32.624
6	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	10:35am	\N	message	2024-10-01 10:35:45.005	2024-10-01 15:35:47.695
7	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	aaa	\N	message	2024-10-02 08:21:06.038	2024-10-02 13:21:06.499
8	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	paco	\N	message	2024-10-02 08:21:28.096	2024-10-02 13:21:28.56
9	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	che	\N	message	2024-10-02 08:21:29.196	2024-10-02 13:21:29.659
10	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	le	\N	message	2024-10-02 08:21:30.367	2024-10-02 13:21:30.827
11	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	le	\N	message	2024-10-02 08:21:31.574	2024-10-02 13:21:32.172
12	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	le	\N	message	2024-10-02 08:21:32.713	2024-10-02 13:21:33.173
13	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asdiyasgdubqawd	\N	message	2024-10-02 08:27:56.731	2024-10-02 13:27:57.191
14	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	pppp+	\N	message	2024-10-02 08:28:16.943	2024-10-02 13:28:17.441
15	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	si	\N	message	2024-10-02 12:44:44.424	2024-10-02 17:44:44.874
16	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	no	\N	message	2024-10-02 12:44:46.631	2024-10-02 17:44:47.095
17	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	hola	\N	message	2024-10-02 12:46:33.459	2024-10-02 17:46:33.817
18	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	a	\N	message	2024-10-03 07:43:20.836	2024-10-03 12:43:21.289
19	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	HOLA	\N	message	2024-10-03 07:55:38.484	2024-10-03 12:55:38.933
20	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	AAA	\N	message	2024-10-03 07:57:15.258	2024-10-03 12:57:15.713
21	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	SSSS	\N	message	2024-10-03 08:00:12.955	2024-10-03 13:00:13.436
22	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	S	\N	message	2024-10-03 08:00:13.397	2024-10-03 13:00:13.831
23	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	aa	\N	message	2024-10-03 08:09:21.64	2024-10-03 13:09:22.108
24	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	aaaaa	\N	message	2024-10-03 08:09:42.465	2024-10-03 13:09:42.919
25	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asdasd	\N	message	2024-10-03 08:18:12.338	2024-10-03 13:18:12.82
26	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	hello	\N	message	2024-10-03 08:20:23.029	2024-10-03 13:20:23.494
27	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	paco	\N	message	2024-10-03 08:21:01.892	2024-10-03 13:21:02.372
28	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	pacoelpe	\N	message	2024-10-03 08:22:22.721	2024-10-03 13:22:23.204
29	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	aaaaa	\N	message	2024-10-03 08:29:33.712	2024-10-03 13:29:34.178
30	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	sisas los caramelos	\N	message	2024-10-03 08:29:55.85	2024-10-03 13:29:58.073
31	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	lalalalalalalalal	\N	message	2024-10-03 08:38:07.646	2024-10-03 13:38:08.091
32	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asssdad	\N	message	2024-10-03 08:43:36.738	2024-10-03 13:43:37.224
33	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	mensaje para editar 	\N	message	2024-10-03 08:43:56.945	2024-10-03 13:43:57.383
34	429b6007-39f9-4796-96f2-0bf635a8f8a	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	quien sos vos	\N	message	2024-10-03 08:50:10.114	2024-10-03 13:50:12.352
35	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	paco 	\N	message	2024-10-03 08:51:21.75	2024-10-03 13:51:22.193
36	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	paco	\N	message	2024-10-03 08:51:49.869	2024-10-03 13:51:50.31
37	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	paco	\N	message	2024-10-03 08:54:01.032	2024-10-03 13:54:01.468
38	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	paco el che +	\N	message	2024-10-03 10:06:14.193	2024-10-03 15:06:14.639
39	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	a	\N	message	2024-10-03 10:11:36.6	2024-10-03 15:11:37.056
40	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	aaa	\N	message	2024-10-03 10:12:37.975	2024-10-03 15:12:38.42
50	429b6007-39f9-4796-96f2-0bf635a8f8a	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	no se edita	\N	message	2024-10-04 13:34:39.454	2024-10-04 18:34:39.909
41	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	hola adios	\N	message	2024-10-03 10:35:46.888	2024-10-03 15:35:49.143
51	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	paco	\N	message	2024-10-07 08:32:26.962	2024-10-07 13:32:27.391
42	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ssssinoahlo	\N	message	2024-10-03 11:00:45.273	2024-10-03 16:00:47.725
43	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	si	\N	message	2024-10-03 11:02:50.477	2024-10-03 16:02:52.992
44	429b6007-39f9-4796-96f2-0bf635a8f8a	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	hola linda	\N	message	2024-10-03 11:03:39.108	2024-10-03 16:03:41.591
45	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	si	\N	message	2024-10-03 11:04:47.55	2024-10-03 16:04:50.005
46	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	hola	\N	message	2024-10-04 13:25:20.921	2024-10-04 18:25:21.394
47	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	etse es un mensaje para editar	\N	message	2024-10-04 13:29:11.245	2024-10-04 18:29:11.7
48	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	este mensaje esta en true 	\N	message	2024-10-04 13:32:11.909	2024-10-04 18:32:12.363
49	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	mensaje nuevo 	\N	message	2024-10-04 13:32:52.482	2024-10-04 18:32:52.941
52	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	a	\N	message	2024-10-07 08:56:41.084	2024-10-07 13:56:41.544
53	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	aa	\N	message	2024-10-07 09:21:41.257	2024-10-07 14:21:41.715
54	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	s	\N	message	2024-10-07 09:30:29.601	2024-10-07 14:30:32.3
55	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	aa	\N	message	2024-10-07 09:52:47.572	2024-10-07 14:52:48.04
56	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	kñklñ	\N	message	2024-10-07 10:14:35.419	2024-10-07 15:14:35.903
57	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ghhjgh	\N	message	2024-10-07 11:07:19.732	2024-10-07 16:07:20.219
58	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	hhjh	\N	message	2024-10-07 11:07:59.503	2024-10-07 16:07:59.976
59	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ddd88	\N	message	2024-10-08 07:47:30.419	2024-10-08 12:47:32.992
62	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	da	\N	message	2024-10-08 08:12:05.067	2024-10-08 13:12:10.426
63	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ad	\N	message	2024-10-08 08:12:05.385	2024-10-08 13:12:09.275
64	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ad	\N	message	2024-10-08 08:12:05.498	2024-10-08 13:12:10.26
65	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asd	\N	message	2024-10-08 08:12:06.043	2024-10-08 13:12:14.844
66	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ad	\N	message	2024-10-08 08:12:05.92	2024-10-08 13:12:18.045
67	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	da	\N	message	2024-10-08 08:12:15.089	2024-10-08 13:12:19.504
68	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	}	\N	message	2024-10-08 08:12:16.43	2024-10-08 13:12:21.114
69	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ad	\N	message	2024-10-08 08:12:20.04	2024-10-08 13:12:23.478
73	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	a	\N	message	2024-10-08 10:26:47.45	2024-10-08 15:26:50.093
74	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	a	\N	message	2024-10-08 10:30:46.935	2024-10-08 15:30:49.393
76	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	429b6007-39f9-4796-96f2-0bf635a8f8a	caaaa	\N	message	2024-10-08 10:30:49.05	2024-10-08 15:30:51.499
77	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	paco	\N	message	2024-10-09 09:44:24.838	2024-10-09 14:44:28.224
111	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	10	\N	message	2024-10-10 08:30:54.728	2024-10-10 13:30:56.955
112	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	8	\N	message	2024-10-10 08:30:54.461	2024-10-10 13:30:57.08
80	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	s	\N	message	2024-10-09 09:55:15.709	2024-10-09 14:55:19.397
81	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	a	\N	message	2024-10-09 09:55:16.116	2024-10-09 14:55:19.806
82	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	nuevo	\N	message	2024-10-10 07:34:25.151	2024-10-10 12:34:28.612
83	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	nuevo	\N	message	2024-10-10 07:34:37.004	2024-10-10 12:34:40.74
84	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	larry	\N	message	2024-10-10 07:34:47.137	2024-10-10 12:34:50.114
113	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	9	\N	message	2024-10-10 08:30:54.758	2024-10-10 13:30:57.416
86	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	ad	\N	message	2024-10-10 08:30:19.279	2024-10-10 13:30:23.485
87	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	da	\N	message	2024-10-10 08:30:19.251	2024-10-10 13:30:23.483
88	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asd	\N	message	2024-10-10 08:30:19.915	2024-10-10 13:30:23.572
89	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asd	\N	message	2024-10-10 08:30:19.579	2024-10-10 13:30:23.929
90	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asd	\N	message	2024-10-10 08:30:19.939	2024-10-10 13:30:24.127
91	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	asdd	\N	message	2024-10-10 08:30:20.102	2024-10-10 13:30:24.536
92	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	qeqpoip	\N	message	2024-10-10 08:30:27.487	2024-10-10 13:30:30.122
93	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	2	\N	message	2024-10-10 08:30:28.059	2024-10-10 13:30:30.516
94	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	1	\N	message	2024-10-10 08:30:27.91	2024-10-10 13:30:30.633
95	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	3.	\N	message	2024-10-10 08:30:28.351	2024-10-10 13:30:30.991
96	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	5	\N	message	2024-10-10 08:30:28.552	2024-10-10 13:30:31.016
97	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	4	\N	message	2024-10-10 08:30:28.593	2024-10-10 13:30:31.289
98	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	6	\N	message	2024-10-10 08:30:32.64	2024-10-10 13:30:34.815
99	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	7	\N	message	2024-10-10 08:30:33.1	2024-10-10 13:30:35.329
100	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	10	\N	message	2024-10-10 08:30:33.819	2024-10-10 13:30:36.243
101	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	9	\N	message	2024-10-10 08:30:33.821	2024-10-10 13:30:36.265
102	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	8	\N	message	2024-10-10 08:30:33.651	2024-10-10 13:30:36.256
103	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	.	\N	message	2024-10-10 08:30:44.997	2024-10-10 13:30:48.575
104	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	1	\N	message	2024-10-10 08:30:46.029	2024-10-10 13:30:50.216
105	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	3	\N	message	2024-10-10 08:30:47.302	2024-10-10 13:30:51.274
106	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	2	\N	message	2024-10-10 08:30:47.154	2024-10-10 13:30:51.582
107	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	4	\N	message	2024-10-10 08:30:47.742	2024-10-10 13:30:52.265
108	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	5	\N	message	2024-10-10 08:30:48.844	2024-10-10 13:30:53.284
109	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	6	\N	message	2024-10-10 08:30:52.762	2024-10-10 13:30:54.94
110	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	7	\N	message	2024-10-10 08:30:53.68	2024-10-10 13:30:56.103
114	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	hola	\N	message	2024-10-11 07:40:59.976	2024-10-11 12:41:02.244
115	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	hola	\N	message	2024-10-11 07:41:05.373	2024-10-11 12:41:08.194
116	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	adios	\N	message	2024-10-11 07:41:09.25	2024-10-11 12:41:12.125
117	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	chao	\N	message	2024-10-11 13:06:59.194	2024-10-11 18:06:59.651
\.


--
-- Data for Name: history_maintenances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.history_maintenances (id_history_maintenance, user_id, date_maintenance, description) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id_message, user_id, channel_id, content, url_file, type_message, created_at, updated_at) FROM stdin;
1	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hola grupo	\N	message	2024-09-27 13:05:08.042	2024-09-27 13:05:08.042
6	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	peddro AAA	\N	message	2024-09-30 09:00:26.653	2024-09-30 14:00:26.877
54	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hola mundo	\N	message	2024-10-03 07:42:29.142	2024-10-03 12:42:29.378
20	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	nuevo mensaje	\N	message	2024-09-30 13:21:41.467	2024-09-30 18:21:41.706
21	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	pp	\N	message	2024-09-30 14:00:44.756	2024-09-30 19:00:45.002
22	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hola	\N	message	2024-09-30 14:02:32.844	2024-09-30 19:02:33.086
2	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	Mensaje para editaraa	\N	message	2024-09-30 08:39:16.624	2024-09-30 13:39:16.895
4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	mensaje para editar 	\N	message	2024-09-30 08:48:38.279	2024-09-30 13:48:38.523
5	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hol	\N	message	2024-09-30 08:59:15.761	2024-09-30 13:59:15.99
24	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	PACO LALA	\N	message	2024-09-30 14:05:40.705	2024-09-30 19:05:40.946
25	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	NUEVO	\N	message	2024-09-30 14:06:23.33	2024-09-30 19:06:23.569
26	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	nuevo	\N	message	2024-10-01 07:30:19.128	2024-10-01 12:30:19.387
27	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	nuevo	\N	message	2024-10-01 07:30:25.156	2024-10-01 12:30:25.395
28	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hola	\N	message	2024-10-01 07:31:27.631	2024-10-01 12:31:27.872
29	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	a	\N	message	2024-10-01 07:32:45.016	2024-10-01 12:32:45.257
30	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	asas	\N	message	2024-10-01 07:49:58.379	2024-10-01 12:49:58.647
31	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	xdfvdf	\N	message	2024-10-01 07:50:06.62	2024-10-01 12:50:06.878
32	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaaaaaaaaa	\N	message	2024-10-01 07:50:26.407	2024-10-01 12:50:26.675
33	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaa	\N	message	2024-10-01 07:50:28.993	2024-10-01 12:50:29.262
34	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaa	\N	message	2024-10-01 07:50:31.305	2024-10-01 12:50:31.689
35	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aa	\N	message	2024-10-01 07:50:34.427	2024-10-01 12:50:34.683
36	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	a	\N	message	2024-10-01 07:50:36.151	2024-10-01 12:50:36.405
37	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	dsdsdsd	\N	message	2024-10-01 07:54:49.55	2024-10-01 12:54:49.804
38	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sddssd	\N	message	2024-10-01 07:54:51.719	2024-10-01 12:54:51.978
39	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	dsds	\N	message	2024-10-01 07:54:55.39	2024-10-01 12:54:55.652
40	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	10:35am	\N	message	2024-10-01 10:35:33.459	2024-10-01 15:35:34.753
41	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	hola	\N	message	2024-10-01 17:21:33.935	2024-10-01 22:21:34.19
42	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	pa	\N	message	2024-10-01 17:21:37.283	2024-10-01 22:21:37.521
43	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	pe	\N	message	2024-10-01 17:21:39.517	2024-10-01 22:21:39.755
44	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	pi	\N	message	2024-10-01 17:21:42.024	2024-10-01 22:21:42.261
45	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	po	\N	message	2024-10-01 17:21:44.354	2024-10-01 22:21:44.612
46	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	pu	\N	message	2024-10-01 17:21:46.025	2024-10-01 22:21:46.259
47	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	paco	\N	message	2024-10-02 07:47:02.439	2024-10-02 12:47:02.679
48	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	jolalalaSS	\N	message	2024-10-02 07:50:05.975	2024-10-02 12:50:06.206
92	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	a	\N	message	2024-10-08 10:30:08.163	2024-10-08 15:30:09.557
50	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaadsasdasda	\N	message	2024-10-02 08:27:05.982	2024-10-02 13:27:06.224
55	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	AAAS	\N	message	2024-10-03 07:53:28.4	2024-10-03 12:53:28.642
49	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaaaasdadas	\N	message	2024-10-02 08:20:50.698	2024-10-02 13:20:50.941
51	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	si	\N	message	2024-10-02 12:44:53.878	2024-10-02 17:44:54.126
52	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	puede ser	\N	message	2024-10-02 12:44:55.498	2024-10-02 17:44:55.741
65	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sssddd	\N	message	2024-10-03 10:49:54.443	2024-10-03 15:49:55.744
56	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	AAA	\N	message	2024-10-03 07:58:19.941	2024-10-03 12:58:20.182
66	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	dddddasasqe	\N	message	2024-10-03 11:00:24.356	2024-10-03 16:00:25.667
67	429b6007-39f9-4796-96f2-0bf635a8f8a	1	adios a todos	\N	message	2024-10-03 11:04:05.924	2024-10-03 16:04:07.258
57	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	AO+SSSss	\N	message	2024-10-03 07:58:50.052	2024-10-03 12:58:50.334
68	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	este es un menaje para editar lo que es oara edityaer 	\N	message	2024-10-04 13:26:06.548	2024-10-04 18:26:06.791
78	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	dasd	\N	message	2024-10-08 08:04:01.564	2024-10-08 13:04:03.029
70	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	paco	\N	message	2024-10-07 08:28:12.673	2024-10-07 13:28:12.906
58	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sisas los melos	\N	message	2024-10-03 08:22:10.692	2024-10-03 13:22:10.945
72	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	j	\N	message	2024-10-07 09:12:37.651	2024-10-07 14:12:37.901
59	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sdd+dd	\N	message	2024-10-03 08:39:00.614	2024-10-03 13:39:00.847
60	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	aaa	\N	message	2024-10-03 08:47:29.397	2024-10-03 13:47:29.627
61	429b6007-39f9-4796-96f2-0bf635a8f8a	1	hola grupos	\N	message	2024-10-03 08:50:22.322	2024-10-03 13:50:23.517
79	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	dasdas	\N	message	2024-10-08 08:04:02.261	2024-10-08 13:04:03.712
73	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	ssss	\N	message	2024-10-07 09:38:51.25	2024-10-07 14:38:51.486
74	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	yyyy kkk	\N	message	2024-10-07 10:03:57.366	2024-10-07 15:03:57.608
80	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	da	\N	message	2024-10-08 08:04:03.707	2024-10-08 13:04:05.052
81	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	das	\N	message	2024-10-08 08:04:03.624	2024-10-08 13:04:05.088
83	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	asd	\N	message	2024-10-08 08:04:04.287	2024-10-08 13:04:05.754
86	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	paco	\N	message	2024-10-08 08:44:34.571	2024-10-08 13:44:34.815
87	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sdsad	\N	message	2024-10-08 08:44:38.49	2024-10-08 13:44:38.732
88	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	paco	\N	message	2024-10-08 08:49:48.385	2024-10-08 13:49:48.628
89	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	a	\N	message	2024-10-08 08:49:50.315	2024-10-08 13:49:50.559
91	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	oaaa	\N	message	2024-10-08 10:23:53.064	2024-10-08 15:23:54.476
94	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	cdd	\N	message	2024-10-08 10:30:10.938	2024-10-08 15:30:12.226
95	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	probando 	\N	message	2024-10-09 10:22:30.721	2024-10-09 15:22:32.614
96	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	probando 1	\N	message	2024-10-09 10:22:42.196	2024-10-09 15:22:43.577
97	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	sigo probando 	\N	message	2024-10-09 10:49:54.71	2024-10-09 15:49:56.554
102	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	de nuevi	\N	message	2024-10-09 10:57:14.486	2024-10-09 15:57:16.404
103	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	otra vez	\N	message	2024-10-09 10:57:17.44	2024-10-09 15:57:19.13
105	429b6007-39f9-4796-96f2-0bf635a8f8a	1	nuevo mensaje 	\N	message	2024-10-09 11:09:18.193	2024-10-09 16:09:19.936
104	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	otro mas jjss	\N	message	2024-10-09 10:57:24.248	2024-10-09 15:57:26.299
106	429b6007-39f9-4796-96f2-0bf635a8f8a	1	nuevo sssaa	\N	message	2024-10-09 11:09:21.825	2024-10-09 16:09:23.52
109	429b6007-39f9-4796-96f2-0bf635a8f8a	1	holassd nuevo mendaje 	\N	message	2024-10-09 11:31:08.828	2024-10-09 16:31:10.473
110	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1	<template>     <section>         <ToolTip triggerIcon="Settings" tooltipContent="Ajustes de usuario" :outline="true" :pill="true" :square="true"             @click="isOpen = true" />         <div v-if="isOpen"             class="fixed inset-0 bg-black bg-opacity-50 dark:bg-opacity-70 flex items-center justify-center z-50">             <div class="bg-white dark:bg-gray-800 rounded-lg shadow-xl w-full max-w-6xl h-[90vh] overflow-y-auto">                 <div class="container mx-auto py-5 px-9">                     <div class="flex justify-between items-center mb-6">                         <h2 class="text-3xl font-bold text-gray-900 dark:text-white">{{ headerTitle }}</h2>                         <button @click="isOpen = false"                             class="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 focus:outline-none">                             <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"                                 stroke="currentColor">                                 <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"                                     d="M6 18L18 6M6 6l12 12" />                             </svg>                             <span class="sr-only">Cerrar</span>                         </button>                     </div>                      <!-- Aquí dividimos en dos columnas -->                     <div v-if="user" class="flex gap-6">                         <!-- Columna izquierda (información principal) -->                         <div class="space-y-6 flex-1">                             <div class="flex items-center space-x-4">                                 <!-- Avatar -->                                 <span                                     class="h-24 w-24 rounded-full bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-gray-500 dark:text-gray-300 text-2xl font-bold">                                     <ImageLoader                                          v-if="currentContentPhoto"                                          :message="{ photo_url: currentContentPhoto }"                                         class="aspect-square h-full w-full"                                      />                                     <CircleUserRound v-else size="32" class="aspect-square h-full w-full" />                                 </span>                                 <!-- Nombre -->                                 <div class="space-y-2 flex-1">                                     <label for="name"                                         class="block text-sm font-medium text-gray-700 dark:text-gray-300">Nombre</label>                                     <input id="name" v-model="currentContentName" type="text" disabled                                         class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50 dark:bg-gray-700 dark:text-white" />                                 </div>                             </div>                              <!-- Cantidad de mensajes -->                             <div class="space-y-2">                                 <label for="type"                                     class="block text-sm font-medium text-gray-700 dark:text-gray-300">Cantidad de                                     mensajes</label>                                 <input id="messageCount" v-model="currentContentMessage" type="text" disabled                                     class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50 dark:bg-gray-700 dark:text-white" />                             </div>                              <!-- Cantidad de Integrantes -->                             <div class="space-y-2">                                 <label for="memberCount"                                     class="block text-sm font-medium text-gray-700 dark:text-gray-300">Cantidad de                                     Integrantes</label>                                 <input id="memberCount" :value="totalIntegrantes" type="text" disabled                                     class="mt-1 block w-full rounded-md border-gray-300 dark:border-gray-600 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50 dark:bg-gray-700 dark:text-white" />                             </div>                              <!-- Botón Limpiar Chat solo para canales -->                             <div v-if="currentContentType === 'Channel'" class="space-y-2">                                 <button                                     class="mt-4 w-full bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600"                                     @click="clearChat">                                     Limpiar Chat                                 </button>                             </div>                         </div>                          <!-- Columna derecha (lista de usuarios) -->                         <div class="flex-1 space-y-4">                             <h3 class="text-xl font-semibold text-gray-900 dark:text-white">Usuarios</h3>                             <div v-if="currentContentStore.loading" class="text-center">                                 <p>Cargando usuarios...</p>                             </div>                             <ul v-else class="space-y-2">                                 <li v-for="(user, index) in uniqueUsers" :key="index"                                     class="p-3 bg-gray-100 dark:bg-gray-700 rounded-md shadow-sm dark:text-white">                                     {{ user.users.full_name }}                                 </li>                             </ul>                         </div>                     </div>                 </div>             </div>         </div>     </section> </template>  <script setup> import { ref, watchEffect, computed } from 'vue'; import ToolTip from '@components/common/ToolTip.vue'; import { useAuthStore } from '@stores/auth'; import { useCurrentContentStore } from '@stores/messages/contentStore'; import { storeToRefs } from 'pinia'; import ImageLoader from '@components/common/AvatarLoader.vue'; import { CircleUserRound } from 'lucide-vue-next';  const authStore = useAuthStore(); const currentContentStore = useCurrentContentStore();  const { user } = storeToRefs(authStore); const { currentContentName, currentContentPhoto, currentContentMessage, currentContentType, currentContentChannelId, currentContentUsers } = storeToRefs(currentContentStore);  const isOpen = ref(false);  const totalIntegrantes = computed(() => {     return currentContentType.value === 'Conversation' ? 2 : currentContentMessage.value; });  const headerTitle = computed(() => {     return currentContentType.value === 'Conversation' ? 'Información de la conversación' : 'Información del canal'; });  function clearChat() {     console.log('Limpia el chat'); }  const uniqueUsers = computed(() => {     const userMap = new Map();     currentContentUsers.value.forEach(user => {         if (!userMap.has(user.users.id_user)) {             userMap.set(user.users.id_user, user);         }     });     return Array.from(userMap.values()); });  watchEffect(() => {     if (isOpen.value && currentContentType.value === 'Channel' && currentContentChannelId.value) {         currentContentStore.getUsersChannel(currentContentChannelId.value).catch((error) => {             console.error('Error fetching channel users:', error);         });     } }); </script>	\N	message	2024-10-15 11:05:16.02	2024-10-15 16:05:17.318
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id_permission, name, status_permission, created_at, updated_at) FROM stdin;
1	LEER	t	2024-09-27 12:40:52.594	2024-09-27 12:40:52.594
2	ENVIAR_MENSAJE	t	2024-09-27 12:40:53.241	2024-09-27 12:40:53.241
3	EDITAR_MENSAJE	t	2024-09-27 12:40:53.884	2024-09-27 12:40:53.884
4	ELIMINAR_MENSAJE	t	2024-09-27 12:40:54.528	2024-09-27 12:40:54.528
5	ENVIAR_DOCUMENTO	t	2024-09-27 12:40:55.174	2024-09-27 12:40:55.174
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_role, name, created_at, updated_at) FROM stdin;
1	SUPERADMIN	2024-09-27 12:40:50.655	2024-09-27 12:40:50.655
2	ADMIN	2024-09-27 12:40:51.305	2024-09-27 12:40:51.305
3	AGENTE	2024-09-27 12:40:51.949	2024-09-27 12:40:51.949
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tokens (id_token, token, user_id, status_token, created_at, updated_at) FROM stdin;
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjc0NDE4MjIsImV4cCI6MTcyNzQ0MjI0Mn0.08swIzYzT8XTz7HPwDsqpwpvP2Ubs2P9ZzznkWQWrtc	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-09-27 12:57:02.462	2024-09-27 12:57:02.462
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3MTA1NTksImV4cCI6MTcyNzcxMDk3OX0._qALn8tGF2a11KR6VXg6G4F4-CL5iC0k3zZGkkmzuDc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-09-30 15:15:01.827	2024-09-30 15:15:01.827
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc0NDIzNDUsImV4cCI6MTcyNzQ0Mjc2NX0.VTNpYcCQ2KUxrodxqCoBJB8m4iJTyvugctJLyvRJc4Q	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-09-27 13:05:45.35	2024-09-27 13:05:45.35
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc4OTEwODMsImV4cCI6MTcyNzg5MTUwM30.P8N3HUmumAGkyk-ubdDQ7xQOSkbC6SqZCZ8q0BS4YOA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-02 17:40:45.918	2024-10-02 17:40:45.918
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3OTgzNjUsImV4cCI6MTcyNzc5ODc4NX0.oE437snoZUpMvGZ5gGXi4jLIMth4bowJggdnKwWIPLs	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 15:35:22.344	2024-10-01 15:35:22.344
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3MjQxNDksImV4cCI6MTcyNzcyNDU2OX0.ggtJuRMdoNUexxh8l0AjL0tukw-MYtvtmOhZky_zdTQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-09-30 19:00:32.649	2024-09-30 19:00:32.649
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3MDYxNTYsImV4cCI6MTcyNzcwNjU3Nn0.MO7KxDgEBH4aqpNjHGCy_oPpJ8N4zkCumqz1bP9p_to	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-09-30 13:48:14.052	2024-09-30 13:48:14.052
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3MDgwMDEsImV4cCI6MTcyNzcwODQyMX0.0bEEmmPrdyvDg-iEPi-H-x1E3XP2qWyWOsa9t-1ET6I	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-09-30 14:47:46.752	2024-09-30 14:47:46.752
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3ODU5NjAsImV4cCI6MTcyNzc4NjM4MH0.gyUSQ4kG7XHsz9pvRru8rxBZ9GqZLgw-e4vb--PSOjg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 12:27:45.104	2024-10-01 12:27:45.104
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3MjgwNjY4NzEsImV4cCI6MTcyODA2NzI5MX0.md7pJqluJp8DlICVlBiGJVMYj3kW8uIuSjP4YYa8f4w	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-04 18:34:31.416	2024-10-04 18:34:31.416
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc4MzE4NzEsImV4cCI6MTcyNzgzMjI5MX0.RSYvDHFWr6habze825DkxNKAczbdfjjdzQ-iTgTONGc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 22:21:20.647	2024-10-01 22:21:20.647
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjc5NjM1MjcsImV4cCI6MTcyNzk2Mzk0N30.Ot2TXZNw2sliXHFZt6C9vEsivZsB_UfcfE0gNDmhVY0	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-03 13:49:59.316	2024-10-03 13:49:59.316
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3OTAwMTcsImV4cCI6MTcyNzc5MDQzN30.HjeSvX7wQfptQ-dPSAIwsVtksl2Eu-JdV6DhiWoRtRA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 12:54:00.515	2024-10-01 12:54:00.515
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc4NzMwODUsImV4cCI6MTcyNzg3MzUwNX0.7PT-bi1SC7ihJ_DmRtL12jlemjd-MHmWJ3ACXqVNNWU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-02 12:24:11.67	2024-10-02 12:24:11.67
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3OTAzNjksImV4cCI6MTcyNzc5MDc4OX0.dO4U9btXCT75JloaY5h29kSoRX_E-2-vSlpdBPUDNOE	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 13:00:57.043	2024-10-01 13:00:57.043
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc3OTY4MDAsImV4cCI6MTcyNzc5NzIyMH0.1gfIVB8hzK0ORuSbWupMbC-u62FUQ7p4otJ7qKH7jQc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-01 13:51:58.544	2024-10-01 13:51:58.544
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc4NzUzNjYsImV4cCI6MTcyNzg3NTc4Nn0.wgaJhp48ItZNdmlijnYRKJF9Za2OeQryva4MF6FwlPQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-02 13:19:54.279	2024-10-02 13:19:54.279
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc5Njk1NzEsImV4cCI6MTcyNzk2OTk5MX0.ksX4wIe-VFfq75ljbxJJLdkUbuWnxvhk2sQ-lOIDJBk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-03 15:26:45.665	2024-10-03 15:26:45.665
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc5NjIyOTEsImV4cCI6MTcyNzk2MjcxMX0.AB8WVm5xiE62zPeLKlB90k_C6G_JVXvcmlp39WsXFTM	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-03 13:26:39.634	2024-10-03 13:26:39.634
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc5MTAxNTUsImV4cCI6MTcyNzkxMDU3NX0.9WVWasFc1lSjEbjQuAPQOIrqqVl8_hED4Yxq2xZaeRg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-02 22:15:00.882	2024-10-02 22:15:00.882
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc5NTgyOTgsImV4cCI6MTcyNzk1ODcxOH0.HnC0pFtD27xzjmtFvYNqVHgvN6SHWx0kMTvBgHegkRc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-03 12:24:58.308	2024-10-03 12:24:58.308
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjc5NzEzOTcsImV4cCI6MTcyNzk3MTgxN30.aVCK4JHFBMqS9rzN4Kvtz2G5XavvzM0eLdZa3Ppd8gA	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-03 16:03:17.994	2024-10-03 16:03:17.994
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjc5Njg1NzAsImV4cCI6MTcyNzk2ODk5MH0.B6jIyLM-JoN1lL8uJ_B4saNLLlOM4y8xgW92ANQKOOc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-03 13:29:27.816	2024-10-03 13:29:27.816
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjc5Njg2MTYsImV4cCI6MTcyNzk2OTAzNn0.YeSFemewnLwXEQvB9RoCN4DW0u1SmLpnZzmx2jdicFc	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-03 13:55:57.677	2024-10-03 13:55:57.677
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgwNjY3MzEsImV4cCI6MTcyODA2NzE1MX0.gaOj7439dq6wWjWSqO5947IBgKkOc2jysC41dVgp3Fo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-04 18:25:06.509	2024-10-04 18:25:06.509
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzMDc0ODYsImV4cCI6MTcyODMwNzkwNn0.JGkrhGeq4zRgwQJegyn1p-tt2O4I8sh7R0vefQkivVw	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-07 13:20:17.704	2024-10-07 13:20:17.704
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzMTA4MjEsImV4cCI6MTcyODMxMTI0MX0.vjVXWYEkJu9sBtMdIgxZrCqBpd4d8by-t6nqxVP2mg0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-07 13:53:06.417	2024-10-07 13:53:06.417
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTQ3NzEsImV4cCI6MTcyODM5NTE5MX0.omEeTKTheIzKfId5iEH4OKDlok5itqe_TRvhpX0fwtw	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:39:31.618	2024-10-08 13:39:31.618
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTUwNjAsImV4cCI6MTcyODM5NTQ4MH0.VYdgZXtOb16KKdYD-dGYtqxWhLlD3abhQmqCUfkGPKg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:38:58.105	2024-10-08 13:38:58.105
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MDMyNDksImV4cCI6MTcyODQwMzY2OX0.6oo_ae6TyFflrCA9klMtisNbGAqnSrwjYB5G6dQ0kdI	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 16:00:49.466	2024-10-08 16:00:49.466
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTUzNzIsImV4cCI6MTcyODM5NTc5Mn0.TrKYUEV_lS-huTsK9Mr2G3TA9OQOXgaZwlO6ILiasww	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:44:26.504	2024-10-08 13:44:26.504
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MzM4ODUsImV4cCI6MTcyODQzNDMwNX0.4pDXSiZhi6KrwC4PQW_U_rIBaJ914uxuPMsOQN2OO5c	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 00:31:25.428	2024-10-09 00:31:25.428
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTk2MDYsImV4cCI6MTcyODQwMDAyNn0.H96m0XGbj1Za7FIMAozINEaSoAk9h4gjdaULCLAQsKo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:40:00.817	2024-10-08 13:40:00.817
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzNDg5NjgsImV4cCI6MTcyODM0OTM4OH0.jWY-Q6GyFdwW66bAC7JScCm1i7C54X0uFr3Uoo_MKDo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 00:05:55.056	2024-10-08 00:05:55.056
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTExODksImV4cCI6MTcyODQxMjc4OX0.u5OlubsmNvZ3ZLaURlb-iR4QWrAUvGzESHDDt1WgduU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 12:39:49.085	2024-10-08 12:39:49.085
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MDM1OTUsImV4cCI6MTcyODQwNDAxNX0.YBvKPmDtvilPL3BiFBp2x2Wb-mamjJBamUDMJ5wyxxg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 16:01:55.765	2024-10-08 16:01:55.765
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MjY3MDQsImV4cCI6MTcyODQyNzEyNH0.k9k8dyQBm374bsD2z-dvz3nebcpQoGZLyQKqlJLlX-Q	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 22:31:44.572	2024-10-08 22:31:44.572
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzMTUxMDgsImV4cCI6MTcyODMzNjcwOH0.zjXmWwqRphYpmKqUUvPD8twgaE6_0oOGu8dzTNTldLg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-07 15:31:48.656	2024-10-07 15:31:48.656
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzMTUyNDEsImV4cCI6MTcyODMzNjg0MX0.Nn0JJN8u8eCCX2OjXW96M3SwbIZx7i5s7m3eiinwVII	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-07 15:34:01.066	2024-10-07 15:34:01.066
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTIyNTksImV4cCI6MTcyODM5MjY3OX0.JAaPJez4v_kGERsDcTgHX59GJHJksq7o8Ct9c8j_Y4o	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 12:46:53.601	2024-10-08 12:46:53.601
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzMTU1NzIsImV4cCI6MTcyODMxNTk5Mn0.aNbWvNM5Qh-dauq2xTfpWFvb4INBP4dmghyJ_wkmyuY	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-07 14:05:02.223	2024-10-07 14:05:02.223
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTQ1NDksImV4cCI6MTcyODM5NDk2OX0.XCHns2CcIZWducsdKCQfNk72MWdxJv-z_VoA-m2yJ_0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:35:49.751	2024-10-08 13:35:49.751
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjgzOTQ1NzAsImV4cCI6MTcyODM5NDk5MH0.i91VFxXATfveyp_pKo8OqOpEw0r5IGUwmd_48_KBpRg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 13:36:10.611	2024-10-08 13:36:10.611
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODYxMzQsImV4cCI6MTcyODQ4NjU1NH0.HSOAUAV6dGORHvqtuk7z_7JSw8CfoTRLxpx5V917-tY	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 14:56:12.011	2024-10-09 14:56:12.011
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MDIzOTIsImV4cCI6MTcyODQwMjgxMn0.g69qTlbEbivapW6IooFcqp7PZnx5S0viMXlE5gXPMKI	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 15:23:30.766	2024-10-08 15:23:30.766
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MDMyMDEsImV4cCI6MTcyODQwMzYyMX0.TU3upnmzC2nZ-YZdC8W0t2xS3icbMTuxpsIYzGCsViQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-08 15:57:16.028	2024-10-08 15:57:16.028
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODcxNjQsImV4cCI6MTcyODQ4NzU4NH0.VQSveiRFpMpMNtZklChD93_-5IUDyEDXYPZZvSSEZTU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 15:19:24.224	2024-10-09 15:19:24.224
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0MzM3MTUsImV4cCI6MTcyODQzNDEzNX0.5O5zFHR0nBviri8adqNXNyJxRdcxfWk0Z6JOY3FgqMI	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 00:28:35.678	2024-10-09 00:28:35.678
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODU3MTIsImV4cCI6MTcyODQ4NjEzMn0.ZyqgrSoy-lDNfDHOHH4UO1TjFEglme_UFUERRO1vPxE	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 14:44:02.966	2024-10-09 14:44:02.966
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODkyNDYsImV4cCI6MTcyODQ4OTY2Nn0.zoIisvHnaAfzIrwWpolfun-_d9aUzEpfs-4jBBzVbXg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 15:20:33.337	2024-10-09 15:20:33.337
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk3OTAsImV4cCI6MTcyODQ5MDIxMH0.LrWIjlyFOYc_DeejuyXNNiVYEb0w6rsDdoWVCFsGJEQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:03:10.505	2024-10-09 16:03:10.505
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk4MDcsImV4cCI6MTcyODQ5MDIyN30.ms3fHxNWiY_v9y04ybTadBsqtKDD0f1Vg6MAYB80T50	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:03:27.18	2024-10-09 16:03:27.18
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk3NjAsImV4cCI6MTcyODQ5MDE4MH0.C0Ui5ZgBUaOjfojEKnsdSVdkxv_KEpiK4X8i00xRTkI	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:02:40.252	2024-10-09 16:02:40.252
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk4MjYsImV4cCI6MTcyODQ5MDI0Nn0.YLAAxHXWSI8-4bkeoKeBeOtMw82u9usfSNtbFRh-6jc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:03:46.733	2024-10-09 16:03:46.733
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk4NDIsImV4cCI6MTcyODQ5MDI2Mn0.I2DWJ46jpN9Ilha3IPvNTk2TfmSKPozuWByWFqnos0g	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:04:02.508	2024-10-09 16:04:02.508
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk5NDAsImV4cCI6MTcyODQ5MDM2MH0.B2HhqtkYsAeWgjdCe9qeFUyZeYQK0uVzt1LCv9aE5D4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:05:40.194	2024-10-09 16:05:40.194
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg1MDM2MjIsImV4cCI6MTcyODUwNDA0Mn0.S57ZWUIQDBtqyff_y4xEJYLT2YeXBS1ZuQv0l28LsCE	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 15:30:30.13	2024-10-09 15:30:30.13
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk4ODAsImV4cCI6MTcyODQ5MDMwMH0.yh2zWyYHWFjoPTInyieFeNxthOi8jjSiHKseBNM-srw	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:04:40.703	2024-10-09 16:04:40.703
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0ODk5NzMsImV4cCI6MTcyODQ5MDM5M30.WAOwEyCM7hAPM6t-R6d2JzOntixS0F64ateFSF9JZFw	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:06:13.71	2024-10-09 16:06:13.71
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg0ODk5ODIsImV4cCI6MTcyODQ5MDQwMn0.9gCqnWzifjKxJ2xlu1yHCNrM0FtmmCJjBRpRPWsjXkY	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-09 16:06:22.274	2024-10-09 16:06:22.274
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0OTAwMDYsImV4cCI6MTcyODQ5MDQyNn0.9M5RivokiSb9-rVAOsTY1RLUtLcVMB7Z4lBx72zRx88	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:06:46.241	2024-10-09 16:06:46.241
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0OTAwMzAsImV4cCI6MTcyODQ5MDQ1MH0.Lonug36JeaqvA2iE7sNNYMUWcNUmlU5OBVwJiDptdZU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:07:10.279	2024-10-09 16:07:10.279
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg0OTAwODgsImV4cCI6MTcyODQ5MDUwOH0.W4OpRXOy7vn4SZUPgbr0PG6FMelsKyKIDuEW6BVSk7M	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-09 16:08:08.193	2024-10-09 16:08:08.193
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NDkwNTAsImV4cCI6MTcyODY0OTQ3MH0.nbMQvwv6RmqkjSl95eelWgHVhAHS7aVDpFHQQx21XJ8	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 12:06:41.909	2024-10-11 12:06:41.909
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTA0MDIsImV4cCI6MTcyODY1MDgyMn0.vSStHuZHgpqUKdXZ2zgpdpAL88qYJhqocfkK0EUVwQg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 12:38:00.356	2024-10-11 12:38:00.356
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg0OTE0NDQsImV4cCI6MTcyODQ5MTg2NH0.wNA0te_qQ9OF7bfGHicEdUQ67vY6P24D8Ax3tnGgPkA	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-09 16:08:34.085	2024-10-09 16:08:34.085
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg1NzQxMjgsImV4cCI6MTcyODU3NDU0OH0.B58t4it686Iyly4koGUbFowhBIUa3Y8129J7iBXo1cc	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-10 12:33:28.004	2024-10-10 12:33:28.004
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTE0NTIsImV4cCI6MTcyODY1MTg3Mn0.9ijMHfl2BLR2nKcXvSXMDYIgCepS2JVOcJCb7J5WQSs	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 12:40:12.059	2024-10-11 12:40:12.059
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg1NzQ5MDksImV4cCI6MTcyODU3NTMyOX0._n8Z8orc8iDZ50B1p2A3IluEDoXQgd3Q4i0zzV9SKF0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-10 15:12:29.017	2024-10-10 15:12:29.017
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg1NjY3MDUsImV4cCI6MTcyODU2NzEyNX0.CmiW5IzDC1gxGpDy0syb2dSrDq8D57_-8zFscujUS-0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-10 13:20:47.39	2024-10-10 13:20:47.39
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg1NzQ5NTksImV4cCI6MTcyODU3NTM3OX0.j9MYwQAEfGDzgf8GcNGL3QD2pHGFpAjfyQmk_qiUM1E	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-10 15:34:38.265	2024-10-10 15:34:38.265
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTQwMjEsImV4cCI6MTcyODY1NDQ0MX0.9lFnu6xbPRWOnH1hYsQ54McdBZCqAx6B0L5rBMVcQnE	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 13:40:21.208	2024-10-11 13:40:21.208
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTQwMjksImV4cCI6MTcyODY1NDQ0OX0.LfGcR26xyrMtMpJnj4oE6wrGSL0OxfCLBcaGNgqz5ow	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 13:40:29.223	2024-10-11 13:40:29.223
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTQwMzksImV4cCI6MTcyODY1NDQ1OX0.CWK9UHnUXEFeczHUQgRljwqrJgra2JY4_EPz9JV66EA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 13:06:19.339	2024-10-11 13:06:19.339
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTQyNjEsImV4cCI6MTcyODY1NDY4MX0.hrJGlbX4dglN8JkpVq39ySlrNMBFOz9aFVtAxokJlMo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 13:41:01.228	2024-10-11 13:41:01.228
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTU0NjAsImV4cCI6MTcyODY1NTg4MH0.wvY_7Kngz8OOCYjTL0mTARZjyAND2L8H9nbustk7kc4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 13:46:17.543	2024-10-11 13:46:17.543
124	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTY1NzEsImV4cCI6MTcyODY1Njk5MX0.zO-eh-vnIec0Strs9i61jGmxJGzWGe22McS4xh50X2E	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:15:12.291	2024-10-11 14:15:12.291
119	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTYwNjIsImV4cCI6MTcyODY1NjQ4Mn0.wCU43wTkySMdtvVz4EgqNGAhLNcCSH_MEYgrQ75X32k	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:06:36.549	2024-10-11 14:06:36.549
120	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTU4ODEsImV4cCI6MTcyODY1NjMwMX0.ruDGuaXljp6U2mH4T3qNB8podnD8SRa_Re3d5r6YdKo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:11:21.843	2024-10-11 14:11:21.843
128	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTcxODIsImV4cCI6MTcyODY1NzYwMn0.qZDE9YnYrEhrrJIEc_iXnKk9JbFYjKxSSEHizQFhsdA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:27:48.652	2024-10-11 14:27:48.652
130	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTc2MzMsImV4cCI6MTcyODY1ODA1M30.gueF_82rHNk6VNBkgf2plydFM1PeW7QhY81YJnGAssA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:34:23.419	2024-10-11 14:34:23.419
133	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTg2OTksImV4cCI6MTcyODY1OTExOX0.m4BwfypAwYMRp8UJ8F1lAUaQrJ-fOKRFecdvO_Ollv4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:58:19.025	2024-10-11 14:58:19.025
132	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTgzOTQsImV4cCI6MTcyODY1ODgxNH0.bYRNbsiTZZfL-Z7Dy2N2FcxpAD3oE2a1l2lIPc9Jsfg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:47:34.482	2024-10-11 14:47:34.482
134	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NTk0MTIsImV4cCI6MTcyODY1OTgzMn0.jMjmMnWJ9C3YqTLkjGsbNhGGavN_QPG1chcyzC4deHU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 14:59:04.014	2024-10-11 14:59:04.014
149	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NjkyMDgsImV4cCI6MTcyODY2OTYyOH0.Jj9r4Hhq21aXt2TK-6xwWjG4xGluGy_aKH8jbW3G7QU	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 17:53:28.308	2024-10-11 17:53:28.308
135	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NjAyMTEsImV4cCI6MTcyODY2MDYzMX0.ofv5kUpk8YSlTpFs2fO-Hw7BieUzxa4iFHmBlvnh3DI	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 15:11:04.123	2024-10-11 15:11:04.123
137	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NjA3NzksImV4cCI6MTcyODY2MTE5OX0.L6pVtIY9Bq_xwzPqNDGttp0J1hK4xgdHWE-P6yGD24M	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 15:32:59.846	2024-10-11 15:32:59.846
138	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NjA4MTgsImV4cCI6MTcyODY2MTIzOH0.RfBhvJpoBmVnpGqIY61d81aQANArZQ3CkjR9bm6Xw5Y	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 15:33:38.325	2024-10-11 15:33:38.325
154	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzI1NzYsImV4cCI6MTcyODY3Mjk5Nn0.aLDJakPU3LXAaFjVucNlmRJB3lyi_U53-gmC_zwURo0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 18:41:12.707	2024-10-11 18:41:12.707
156	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2NzM0ODQsImV4cCI6MTcyODY3MzkwNH0.imm2D73B_7QVNHvpddJbsfm305f7rg_NyOErF_8o7aw	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 18:59:19.177	2024-10-11 18:59:19.177
145	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2Njc0NjcsImV4cCI6MTcyODY2Nzg4N30.inDxewoytibaHFKLPrj0oWpP6-xm0CSLBCmsBEtQOCk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 17:21:09.695	2024-10-11 17:21:09.695
144	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2Njc5NDgsImV4cCI6MTcyODY2ODM2OH0.xztwmil031DBBu6FJBP0vN7C3ylEtsvwaXAAGUcW-eA	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 17:11:54.005	2024-10-11 17:11:54.005
160	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzM3MTgsImV4cCI6MTcyODY3NDEzOH0.s105W16toybPzLEePlsxPTH2DDuu0__cpVIWfFVwXss	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 19:08:38.905	2024-10-11 19:08:38.905
146	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NjgzMzksImV4cCI6MTcyODY2ODc1OX0.N6OyMzmj79MTYTe7dK6BYsSxH3dfywRz2TxFayTWV6A	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 17:38:59.708	2024-10-11 17:38:59.708
151	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzIwMDIsImV4cCI6MTcyODY3MjQyMn0.EQCYjRkJErZtQnB4js2-WjcZ4IvVkk7HOujyBNsVlVk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 18:40:02.809	2024-10-11 18:40:02.809
148	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2Njg2NDEsImV4cCI6MTcyODY2OTA2MX0.cYSEN4y6av7f5oF2dQVzReM0UOwKnFGOU8G1WOPNHeI	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 17:40:50.442	2024-10-11 17:40:50.442
152	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzIwMTEsImV4cCI6MTcyODY3MjQzMX0.ZVp9eZ-B2cL_wYKRnkjdV91cvVoxoXWsyMnTLH1T6b0	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 18:40:11.304	2024-10-11 18:40:11.304
147	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2Njg4OTAsImV4cCI6MTcyODY2OTMxMH0.8CE6XwPDXpZZSxp-aeVF-FTtv8l6bD5G2VQTGYgQB0M	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 17:39:12.397	2024-10-11 17:39:12.397
161	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzM3NjQsImV4cCI6MTcyODY3NDE4NH0.lr4EXl9078RqQa_Oj0UmQAgDoxhJMJtBWzbolU_1IcY	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 19:09:24.51	2024-10-11 19:09:24.51
155	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzMyOTQsImV4cCI6MTcyODY3MzcxNH0._e1CsjRtRqtaeGfqY__BKeN36ah28E4qPb6WV5ceqfg	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 18:50:04.497	2024-10-11 18:50:04.497
170	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2NzYwMTksImV4cCI6MTcyODY3NjQzOX0.AChvR_fRPyEg0hcIaQgGO0MWyZIH7g81LJ9oiFpnSNM	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 19:42:05.84	2024-10-11 19:42:05.84
169	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzYzMzcsImV4cCI6MTcyODY3Njc1N30.Z-jp2B5JsN8d2-05rnsGyBCd4BwBn_4Wh-edjVpjgJY	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 19:41:19.706	2024-10-11 19:41:19.706
172	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzcxODYsImV4cCI6MTcyODY3NzYwNn0.iS0wJGHThyoD6tCiIETyF4uz735QkFH7oK0HBMwFaIo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 19:55:59.668	2024-10-11 19:55:59.668
165	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2NzUxNjIsImV4cCI6MTcyODY3NTU4Mn0.DumPZot1dkEZlH6aNIKNX2FsVWiQgar1FFM5AMOjrbA	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 19:16:57.134	2024-10-11 19:16:57.134
167	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzU0NTgsImV4cCI6MTcyODY3NTg3OH0.lplrwRVqOMaUNdommmk5METlqOXGTK3un2OHM-QBAH4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 19:37:38.006	2024-10-11 19:37:38.006
173	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2NzcyOTQsImV4cCI6MTcyODY3NzcxNH0.CaNNeOznS1PzVjHmm162YM2TCSej6-CCv7u2ld5iydk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 20:08:14.217	2024-10-11 20:08:14.217
180	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2ODAxOTQsImV4cCI6MTcyODY4MDYxNH0.85Xg_jxqvRQo5czqyBFwgu1XQgw5SxOI66qnQ35jqR4	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 20:32:43.717	2024-10-11 20:32:43.717
184	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg2ODEwNzUsImV4cCI6MTcyODY4MTQ5NX0.50TVZCohGw7V0NUkzpHoaQOkyZ0r9AifSXdwwktEKec	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-11 20:42:43.492	2024-10-11 20:42:43.492
185	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg2ODE5MjIsImV4cCI6MTcyODY4MjM0Mn0.HeoBjnp93x6bK9n2A9CZ8hUwcItroTUz5Oz15AFyhxQ	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-11 21:16:53.817	2024-10-11 21:16:53.817
210	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiNDI5YjYwMDctMzlmOS00Nzk2LTk2ZjItMGJmNjM1YThmOGEiLCJpYXQiOjE3Mjg5OTgwNzQsImV4cCI6MTcyOTAwMTY3NH0.HZ8rdoplSPrcuKz6xkV0lnr_Pgz_4R5KFKrvTvebxj4	429b6007-39f9-4796-96f2-0bf635a8f8a	t	2024-10-15 13:14:34.708	2024-10-15 13:14:34.708
213	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg5OTkwNTcsImV4cCI6MTcyOTAwMjY1N30.0PkVHyrVOrVluphK5Qi25i_109G5AsbT6BfX0krvof8	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 13:30:57.479	2024-10-15 13:30:57.479
215	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg5OTkwNzMsImV4cCI6MTcyOTAwMjY3M30.AMury8RYa2pjY0JmkI0rSKuqblrxUkvCtl19ScM_k0c	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 13:31:13.592	2024-10-15 13:31:13.592
217	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3Mjg5OTk5NzgsImV4cCI6MTcyOTAwMzU3OH0.nApEXMssMqP1xu1expoeToMT0J1GTvnsRUewQwT67Es	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 13:46:18.385	2024-10-15 13:46:18.385
218	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMDAwMzUsImV4cCI6MTcyOTAwMzYzNX0.BA043jaBLyQlvcuqlJiRcux4eOL0cq6puX53qO6jaoo	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 13:47:15.579	2024-10-15 13:47:15.579
220	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMDM0ODgsImV4cCI6MTcyOTAwNzA4OH0.Sqx_FVstkn1ORJ-7vvbrrNQb-k_ceVKF_RK-c7hyEwQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 14:44:48.575	2024-10-15 14:44:48.575
233	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkxMjEzMzMsImV4cCI6MTcyOTEyNDkzM30.zHcIW6DZ7Wr-O1bv0ghjz8QIFAb5SOPrrtAE8_pFvzk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-16 23:28:53.783	2024-10-16 23:28:53.783
222	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMDU5NjMsImV4cCI6MTcyOTAwOTU2M30.q-9ikbUqYB6Fno-h2wAPW68_BRfNFS4rqx1nYcJI53Q	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 15:26:03.117	2024-10-15 15:26:03.117
225	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTUzMjksImV4cCI6MTcyOTAxODkyOX0.WLQH1Hq8Sn4Uzd00wiLkTTfsIRKhCal1cVQC7v60uI4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 18:02:09.568	2024-10-15 18:02:09.568
226	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTUzMzQsImV4cCI6MTcyOTAxODkzNH0.owpbL-Jr9wgAFPh_j1VLKyJTAY_Wu09bOF4Su99l_Hs	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 18:02:14.467	2024-10-15 18:02:14.467
227	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTUzNDEsImV4cCI6MTcyOTAxODk0MX0.NooxV6PwEiSjZUl_qymY9r348corA8fTTJUEqNdilks	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 18:02:21.944	2024-10-15 18:02:21.944
221	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTU0MDgsImV4cCI6MTcyOTAxOTAwOH0.yevsT6Irjfujz2SV3XYjN6q80s_XCMWxt-4jlZOE1ro	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 15:09:01.069	2024-10-15 15:09:01.069
228	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTU1NzAsImV4cCI6MTcyOTAxOTE3MH0.FkjRzTSf1QF818J6ZwXFA1Sgtlih3v2DFTpJQPtx-tQ	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 18:06:10.428	2024-10-15 18:06:10.428
229	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZF91c2VyIjoiZDdmNGJmNDMtYzFmOC00MTBlLTg5YzItMTViOGIxYmMyMWQiLCJpYXQiOjE3MjkwMTU1ODAsImV4cCI6MTcyOTAxOTE4MH0.8K2e2o06pjrYQ7X6XI_EqwlWM0haRJW6xIX_tpZyAsk	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	t	2024-10-15 18:06:20.178	2024-10-15 18:06:20.178
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permissions (id_user_permission, permission_id, user_id) FROM stdin;
1	1	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d
2	4	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d
3	3	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d
4	2	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d
5	3	429b6007-39f9-4796-96f2-0bf635a8f8a
6	4	429b6007-39f9-4796-96f2-0bf635a8f8a
7	2	429b6007-39f9-4796-96f2-0bf635a8f8a
8	1	sjhkdgfdwjsf-dsfgdwjhfewd-dffgdsf564gf6754-fd74gf
9	1	a1e12e33-83c5-4833-a77e-8cc9b253223
19	1	c3750162-c14f-490b-be21-0bc749b8721
20	1	eb21a84d-bf04-41b4-8dc8-dab7f95f137
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, network_user, full_name, photo_url, dominio, password, status_user, role_id) FROM stdin;
572d7e43-c531-4225-b61a-582a896c837	BB7772	Cornelius Breitenberg	https://avatars.githubusercontent.com/u/99617379	acidic-fun.com	$2b$10$wfHVX7CvjEoE3Fk.Tx.N0OhgNvFm2Y5e3hkTNccUFTJqLYkNf9LH.	f	1
ca525e5e-d9b2-4d50-a0ea-791b96cfe27	BB9364	Cory Smith I	https://avatars.githubusercontent.com/u/91241063	whirlwind-pigsty.biz	$2b$10$3EyVZMKkUQktvycIt6sT/.ynD001z9AzPdtOaz/rtYxKRUr91bGdi	f	1
491bba25-9c9e-4418-a50c-9dd40f5796c	BB1432	Tiffany Stark	https://avatars.githubusercontent.com/u/37972505	hungry-repeat.net	$2b$10$AXZ3y3ODTCCZ40PktJfCIeLmj1yAOBdGOl3v3A2AvficRXcVATl3y	f	1
3c371d1a-a323-434c-ab38-0d76eb03e6a	BB7580	Sherry Tremblay	https://avatars.githubusercontent.com/u/45660730	neglected-hydrocarbon.name	$2b$10$mdZ2UnkQn7DuC02AOzELauXkV6QOwsGGL0yx3agnusTnueADrt.y2	f	2
9ccd3e5b-06a4-413a-bc28-86573f20d01	BB0462	Miss Ashley Kling-Hilll	https://avatars.githubusercontent.com/u/20651626	delirious-hepatitis.org	$2b$10$rUo6jTCPMURE367PuG4SSuf8Y3X39Y0M3gC8cbf4T/vSogQWV2J.y	f	2
d50966d7-9357-43e4-a361-10c6737d6ad	BB6380	Wendell Robel	https://avatars.githubusercontent.com/u/67238308	jam-packed-drive.info	$2b$10$e2ow3bvzUeTRxyjHmJ5T2OSpzmbG0SCRIpxVCpEjBvB8ao7lqZBjO	f	2
b8dd070a-a3c2-4539-9046-337a921b525	BB1606	Maurice Mertz	https://avatars.githubusercontent.com/u/63701939	impossible-discourse.biz	$2b$10$pIzh9DNhjoZ50n2BbZKHP.ZcCToyEBiO3k4B7b4FyaNnMKgV9DcJ2	t	2
c55833ba-16d8-4eff-ade7-d773513b3a4	BB4043	Claire Mertz	https://avatars.githubusercontent.com/u/549374	agreeable-hutch.name	$2b$10$JlXGE.NyU6T0cPCwA5fbButyoAbF0b.ILChnYX2ocO3mHzi2TFEIK	t	2
a1e12e33-83c5-4833-a77e-8cc9b253223	BB2648	Johnnie Ullrich	https://avatars.githubusercontent.com/u/74420929	doting-armchair.com	$2b$10$3ZCFRgodDUGkVS2HE7GNg.ImXSbitgO5Fb9ZEAjeLcSrfjkL6vMd6	t	3
9bcdd9a9-0e60-4d34-9b60-c96ba4a8bb9	BB9463	Derrick Bosco DVM	https://avatars.githubusercontent.com/u/38135600	instructive-shore.net	$2b$10$lkZjpfMcVciTmfpcdX/0VeEmwswhti86x0t/9BKWQiHsmRxDhCck.	f	3
60451ad0-4106-41bb-8969-6247951d19c	BB7953	Jacob Balistreri-Lowe	https://avatars.githubusercontent.com/u/20113574	buttery-wombat.com	$2b$10$fGHj9G0jVEFex2UwKDr7ZOYUf3xxucFNS4eC3zYmGZHXjJBPpD6oW	f	3
98db7a15-1f7b-4b72-9356-edfd06959fe	BB7999	Mr. Johnnie Purdy	https://avatars.githubusercontent.com/u/35543636	merry-ectoderm.com	$2b$10$JiSHm4MWoTcaY2eGkCnPQOBC3eZFkPtbSz2N3y6FpqRLAzhSv4Rq2	t	3
1069cb26-5abc-4f9b-808d-d6a74ad7188	BB2117	Corey Lynch	https://avatars.githubusercontent.com/u/24765287	vibrant-orchid.biz	$2b$10$is7GjsJHIfYugmxk34b0nOarRZEt1TPfCUbPU0lXUWQUH5zPBiA0G	t	3
11d10c54-a30e-4e98-8f8f-72296ee8fe9	BB7603	Dr. Allison Fahey Jr.	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/default.png	impeccable-printer.biz	$2b$10$xZsxdlBiXFo5b.cSHKa/kOlU4YbfUe2gxyb8152.mEtj6kNPPUFy2	f	3
0b379bd8-4183-4f9a-82a0-b614ce46c6f	BB1202	Deborah Haley	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/default.png	unwilling-blossom.info	$2b$10$ZibIeVgQL88VMoXCBBO7X.jsYXup9ZBwjN7EvGKMMf6rt0RRaC85G	f	3
sjhkdgfdwjsf-dsfgdwjhfewd-dffgdsf564gf6754-fd74gf	Xiomy	Android Phone	https://i.imgflip.com/6fh6ed.jpg	\N	$2b$10$nSZ7gYf0suy56ajxmEGWFedyGvI3OX73Nb4TL2fy2zM4uH1mUrgx6	t	3
370859b3-9b79-4182-ba94-e2a6fe71523	BB1854	Beverly Welch I	https://avatars.githubusercontent.com/u/47865444	intrepid-gallery.info	$2b$10$u/08toKoGXUMojEmGRPBruLOSNF0uhT4n5VMZ4GLlL8B2VFFidVrq	t	3
63131dd1-a52e-44a5-85ce-00ca76038f4	BB7956	Sophie Crist	https://avatars.githubusercontent.com/u/38007550	comfortable-lifestyle.com	$2b$10$j.tYXs4BNRFqsmce6zBUDuTaiTNZikXkhdKWnAQ0m8JngsETtsnzC	t	3
f9282d52-8cc5-4bde-b3c2-5f61909a1bf	BB4654	Clifford Kulas	https://avatars.githubusercontent.com/u/48285183	sunny-suspension.com	$2b$10$xaBYUgkE8owj.re7ARJqI.LMXgL10XVgDwGjIZoMSSeFJcwd0hCB.	t	3
fbfc54a0-b8bc-46ee-ba62-28f0aaaef56	BB2550	Jermaine Block Jr.	https://avatars.githubusercontent.com/u/13927568	watery-fort.name	$2b$10$V.HaGXNpt6yq6cWgwX1scuqJDGCAlIjHVIY3IeWMx0BlXp6FUdroW	f	3
232a2980-6f4a-4cbf-8923-052c09c5613	BB7050	Blanca Kling	https://avatars.githubusercontent.com/u/70095905	skeletal-provision.com	$2b$10$dRSBT0RLHkqsjSoZzQnZ0eunbN5K/Y83.CfgnxNdvEq2hDVhIhiWa	t	3
36139b2a-0e26-4cb3-9c73-6783c4c3d52	BB5731	Terry Hessel	https://avatars.githubusercontent.com/u/4193407	incomparable-tackle.name	$2b$10$IKdg86JiTZLJSX1SvUBNveYT1H/RV89bXQf5kYHlmpvOb/hT4E6jy	f	3
a006ec36-7495-4f11-a71d-b3536ac18c6	BB8994	Dustin Funk	https://avatars.githubusercontent.com/u/63473716	shabby-hyphenation.name	$2b$10$eH1YB7G0lHaOIf71Z0R7MO3veiVge5Mm4ctLIliqJ.vDACYviMqSe	f	3
54937925-8092-49ff-8700-0277a5c0d74	BB5091	Lorraine Langosh	https://avatars.githubusercontent.com/u/99863969	brisk-verve.biz	$2b$10$maByqlURZEtO2aVOaXHt7ONc43MefxMqMO1vqJedSIh/z2t/cBK02	t	3
e7dade29-b50f-47e2-8a1a-4a9b616f557	BB7209	Taylor Spencer	https://avatars.githubusercontent.com/u/23895260	junior-coil.biz	$2b$10$IBnMaXp7kGbSoRHQ4RM5bO5A9DePxKo1JemmO8WusaAFj6958p7d6	f	3
85aa3660-fb0d-4bc4-aace-caf51f08067	BB6410	Silvia Cole	https://avatars.githubusercontent.com/u/77261345	both-markup.net	$2b$10$.vIXo8hdjtQSjmRL/lRu1OYrAmOtIAw6gwIb5jRWUEMFLiiymrSD.	t	3
37dbf84e-dcfb-49e8-bbfd-76f71c80498	BB5729	Jan Sauer	https://avatars.githubusercontent.com/u/41435280	quarrelsome-pillow.com	$2b$10$wP2gPdVXB/6OXxO7m3cMMut1WM8u4iP8tCB5JUHM0UVSQDsnkRNWO	t	3
9d214a26-d78d-4f09-8ff8-4d29db84612	BB0106	Bill Macejkovic PhD	https://avatars.githubusercontent.com/u/26702173	oily-celsius.biz	$2b$10$CVteiWJbRAV0YJAMObZrOu2VGK1D1JkQCiDpCtyvbPq55N5TpHP4q	f	3
a8bc87d5-b527-484f-b1e1-ccac637834b	BB0507	Mr. Jeremy Lowe	https://avatars.githubusercontent.com/u/30482176	kaleidoscopic-cope.org	$2b$10$/v4gQLGymcyXhflWr1e4Luw.2PEbhRZMNFpcUhu2N0ojmc4Kn61VG	t	3
8353e384-839f-4eca-90bc-cda35eb3d55	BB6060	Allison VonRueden	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/default.png	definite-tributary.org	$2b$10$tG9K4puL6HCIMfiq5f/T..yM4PfxK6Lq0DUBMylgccW8VJUPbnJ0S	f	3
429b6007-39f9-4796-96f2-0bf635a8f8a	braulio	braulio osorio	https://static.wikia.nocookie.net/6099e51f-24b5-412e-ab3f-53931e23854b/scale-to-width/755	\N	$2b$10$nSZ7gYf0suy56ajxmEGWFedyGvI3OX73Nb4TL2fy2zM4uH1mUrgx6	t	2
0fb36d7d-ad15-4603-88bb-446197da07a	BB3736	Miguel Klocko	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/default.png	stable-embarrassment.biz	$2b$10$aJ/GoKjvO3Evk7LdKOVLFe.FngZ55sWVi/tsyRFFus.0XW1KMBhkq	f	3
690dd0b5-0787-46cb-9475-4506617248b	BB2832	Elvira Harvey	https://avatars.githubusercontent.com/u/72581468	pitiful-pension.org	$2b$10$yIXYKVKRG0alBzKBKM.cPe2Q4Cl0xg8ormamBFJPNKscGifBNRshi	f	3
920c64e5-6dce-4e27-ab81-b2da6caf96a	BB1241	Betty Willms	https://avatars.githubusercontent.com/u/15254954	wobbly-reservation.name	$2b$10$P1FDsm/mA3eQgm8qkr2lXeLs2EvXHw7dGNmk9ytbwpLszBbAscdVm	f	3
8f99e0e7-78cf-4c90-aa2b-6e853ff8913	BB8152	Sam Heaney	https://avatars.githubusercontent.com/u/54068263	awful-impostor.name	$2b$10$M27fFkDgsErEOG3oR33IGeSBI4F7urm0yFjHE.ByRBMgTYJX9rFE.	t	3
ae9e85f9-481e-4554-abf5-2797ef1853f	BB4751	Mr. Roger Veum-Orn	https://avatars.githubusercontent.com/u/53723121	webbed-alligator.biz	$2b$10$VsjBWwKMCsNZY03XFkwe2.9VADzN1VsFZ/eL5uw8oeAFO8ve00TpW	t	3
1f26d0e2-8b01-40e0-ab88-0b2fd4f6d65	BB9504	Conrad Mueller	https://avatars.githubusercontent.com/u/15580499	severe-secrecy.name	$2b$10$dghV.Ue./otrMulqP2ntxe4PYOZ8j8EjOFCfj1E2yQtJEifEuDzYW	f	3
ed9ca826-9b01-41f4-b23f-9afc7b14a79	BB2466	Larry Bartell	https://avatars.githubusercontent.com/u/52306198	worthy-dwell.com	$2b$10$qUSuviigKX31uT.pQJ8Ha.uRk8k/f6GDegUQqMVdEb6LyMuSvTAci	t	3
bb18e91d-d48a-48dc-be62-3dd5e57e55a	BB9886	Martha Reilly	https://avatars.githubusercontent.com/u/16271956	extra-large-depot.net	$2b$10$8kWQL2t5C71QclbIiQ7rP.fxnvVLUFbfaRXooZMAV7Vxx9uLbXQi.	f	3
a81babc0-32bb-4dc9-bbfb-7ef3f9c84d4	BB8470	Darnell Wolf DDS	https://avatars.githubusercontent.com/u/83914249	defensive-descendant.info	$2b$10$lesq1IRdBV87rnacepkKGON.dz2RRlJoGNpeMZJuYVgz4lY.bXqfi	f	3
7a2002f4-e621-4af4-b147-927e94ceb07	BB9966	Tamara Koss	https://avatars.githubusercontent.com/u/37047289	zesty-lava.biz	$2b$10$woPD6CQaIbtAhf9r501Xaun796OPNkiCTcmpOdNQ1wuci5pSQWVxC	f	3
3104fd44-14bc-4dfb-847a-5464c5ebe03	BB9533	Patricia Koss	https://avatars.githubusercontent.com/u/59876813	glass-jump.org	$2b$10$KICd4oBTyGTeTOoKbCbNleHYbZi98Op.Fs4IdYiMiBLk.EdwfnjPe	f	3
d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	sofi	 Sofia Mespi	https://pbs.twimg.com/profile_images/1741493705884749825/tFPuUQW-_400x400.jpg	\N	$2b$10$nSZ7gYf0suy56ajxmEGWFedyGvI3OX73Nb4TL2fy2zM4uH1mUrgx6	t	1
e0be4dc5-ec81-45d2-888e-d0350983e83	BB1000	Julian Vasquez	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/11051bb8-6c66-47d0-b0c3-e838c5a1276b+355348169_584982913840876_7381158039702250435_n.jpg	\N	$2b$10$.DJw.1YnmAdU2f50VSEHBe8ij7bnnIlqIo6JIiOhkQTm9k/2F2c/6	t	1
14cc4bd6-cb37-4af8-92b5-243c8d5ca5c	winder	Carlos Astaneatada	https://scontent.fppn2-1.fna.fbcdn.net/v/t39.30808-6/307701870_427074886190189_3834607431241211302_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=MtwzCiyBsjYQ7kNvgF8C_zS&_nc_ht=scontent.fppn2-1.fna&_nc_gid=Aln_QHSYliZA1vzYcF3aKTL&oh=00_AYBGcyftFRpPchznTpFiSs0DiBf_m1NgLXQdlI_iUqSVpQ&oe=670BA3B1	\N	$2b$10$nSZ7gYf0suy56ajxmEGWFedyGvI3OX73Nb4TL2fy2zM4uH1mUrgx6	t	2
c3750162-c14f-490b-be21-0bc749b8721	BB99999	John Doe	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/default.png	\N	$2b$10$OBi/yNQrxxnPBfa3o37kyOSIezTYZOgBE2dGICcgmziNziSTVeLZ.	t	3
eb21a84d-bf04-41b4-8dc8-dab7f95f137	BB5555	voce	https://oaywoxchdfphlozkwgwx.supabase.co/storage/v1/object/public/Storage%20Chat%20Internal/1e7fae21-e95a-4382-aac1-0920446ccba2+1000172426.jpg	\N	$2b$10$XHElqZKZR05Vb64Fr9z8bu2wJAcTzS3viguiub7qQ4rL0aJhqpvAW	t	3
\.


--
-- Data for Name: users_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_channels (id_user_channel, user_id, channel_id) FROM stdin;
1	429b6007-39f9-4796-96f2-0bf635a8f8a	1
2	d7f4bf43-c1f8-410e-89c2-15b8b1bc21d	1
3	sjhkdgfdwjsf-dsfgdwjhfewd-dffgdsf564gf6754-fd74gf	1
\.


--
-- Data for Name: vulgar_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vulgar_words (id_vulgar_words, word, created_at) FROM stdin;
1	gonorrea	2024-09-27 13:16:14.031
2	gonorreas	2024-09-27 13:16:14.031
3	hijueputa	2024-09-27 13:16:14.031
4	hijueputas	2024-09-27 13:16:14.031
5	marica	2024-09-27 13:16:14.031
6	maricas	2024-09-27 13:16:14.031
7	maricón	2024-09-27 13:16:14.031
8	maricones	2024-09-27 13:16:14.031
9	malparido	2024-09-27 13:16:14.031
10	malparida	2024-09-27 13:16:14.031
11	malparidos	2024-09-27 13:16:14.031
12	malparidas	2024-09-27 13:16:14.031
13	carechimba	2024-09-27 13:16:14.031
14	carechimbas	2024-09-27 13:16:14.031
15	guevón	2024-09-27 13:16:14.031
16	guevona	2024-09-27 13:16:14.031
17	guevones	2024-09-27 13:16:14.031
18	guevonas	2024-09-27 13:16:14.031
19	pirobo	2024-09-27 13:16:14.031
20	piroba	2024-09-27 13:16:14.031
21	pirobos	2024-09-27 13:16:14.031
22	pirobas	2024-09-27 13:16:14.031
23	cacorro	2024-09-27 13:16:14.031
24	cacorra	2024-09-27 13:16:14.031
25	cacorros	2024-09-27 13:16:14.031
26	cacorras	2024-09-27 13:16:14.031
27	culicagado	2024-09-27 13:16:14.031
28	culicagada	2024-09-27 13:16:14.031
29	culicagados	2024-09-27 13:16:14.031
30	culicagadas	2024-09-27 13:16:14.031
31	monda	2024-09-27 13:16:14.031
32	mondas	2024-09-27 13:16:14.031
33	verga	2024-09-27 13:16:14.031
34	vergas	2024-09-27 13:16:14.031
35	chimba	2024-09-27 13:16:14.031
36	chimbas	2024-09-27 13:16:14.031
37	huevón	2024-09-27 13:16:14.031
38	huevona	2024-09-27 13:16:14.031
39	huevones	2024-09-27 13:16:14.031
40	huevonas	2024-09-27 13:16:14.031
41	ñero	2024-09-27 13:16:14.031
42	ñera	2024-09-27 13:16:14.031
43	ñeros	2024-09-27 13:16:14.031
44	ñeras	2024-09-27 13:16:14.031
45	mamerto	2024-09-27 13:16:14.031
46	mamerta	2024-09-27 13:16:14.031
47	mamertos	2024-09-27 13:16:14.031
48	mamertas	2024-09-27 13:16:14.031
49	zunga	2024-09-27 13:16:14.031
50	zungas	2024-09-27 13:16:14.031
51	berraco	2024-09-27 13:16:14.031
52	berraca	2024-09-27 13:16:14.031
53	berracos	2024-09-27 13:16:14.031
54	berracas	2024-09-27 13:16:14.031
55	pendejo	2024-09-27 13:16:14.031
56	pendeja	2024-09-27 13:16:14.031
57	pendejos	2024-09-27 13:16:14.031
58	pendejas	2024-09-27 13:16:14.031
59	jarto	2024-09-27 13:16:14.031
60	jarta	2024-09-27 13:16:14.031
61	jartos	2024-09-27 13:16:14.031
62	jartas	2024-09-27 13:16:14.031
63	perra	2024-09-27 13:16:14.031
64	perras	2024-09-27 13:16:14.031
65	zorro	2024-09-27 13:16:14.031
66	zorra	2024-09-27 13:16:14.031
67	zorros	2024-09-27 13:16:14.031
68	zorras	2024-09-27 13:16:14.031
69	sapo	2024-09-27 13:16:14.031
70	sapa	2024-09-27 13:16:14.031
71	sapos	2024-09-27 13:16:14.031
72	sapas	2024-09-27 13:16:14.031
73	mariquita	2024-09-27 13:16:14.031
74	mariquitas	2024-09-27 13:16:14.031
75	cagado	2024-09-27 13:16:14.031
76	cagada	2024-09-27 13:16:14.031
77	cagados	2024-09-27 13:16:14.031
78	cagadas	2024-09-27 13:16:14.031
79	culión	2024-09-27 13:16:14.031
80	culiona	2024-09-27 13:16:14.031
81	culiones	2024-09-27 13:16:14.031
82	culionas	2024-09-27 13:16:14.031
83	mocoso	2024-09-27 13:16:14.031
84	mocosa	2024-09-27 13:16:14.031
85	mocosos	2024-09-27 13:16:14.031
86	pene	2024-09-27 13:16:14.031
87	vagina	2024-09-27 13:16:14.031
88	penes	2024-09-27 13:16:14.031
89	vaginas	2024-09-27 13:16:14.031
90	semen	2024-09-27 13:16:14.031
91	puta	2024-09-27 13:16:14.031
92	putas	2024-09-27 13:16:14.031
93	pvta	2024-09-27 13:16:14.031
94	pvtas	2024-09-27 13:16:14.031
95	hpta	2024-09-27 13:16:14.031
96	hptas	2024-09-27 13:16:14.031
97	vrga	2024-09-27 13:16:14.031
98	vrgas	2024-09-27 13:16:14.031
99	gnrr	2024-09-27 13:16:14.031
100	prb	2024-09-27 13:16:14.031
101	catrechimbo	2024-09-27 13:16:14.031
102	catrechimbos	2024-09-27 13:16:14.031
103	mocosas	2024-09-27 13:16:14.031
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.messages (id, topic, extension, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2024-07-02 01:18:20
20211116045059	2024-07-02 01:18:20
20211116050929	2024-07-02 01:18:20
20211116051442	2024-07-02 01:18:20
20211116212300	2024-07-02 01:18:20
20211116213355	2024-07-02 01:18:20
20211116213934	2024-07-02 01:18:21
20211116214523	2024-07-02 01:18:21
20211122062447	2024-07-02 01:18:21
20211124070109	2024-07-02 01:18:21
20211202204204	2024-07-02 01:18:21
20211202204605	2024-07-02 01:18:21
20211210212804	2024-07-02 01:18:21
20211228014915	2024-07-02 01:18:21
20220107221237	2024-07-02 01:18:21
20220228202821	2024-07-02 01:18:21
20220312004840	2024-07-02 01:18:21
20220603231003	2024-07-02 01:18:21
20220603232444	2024-07-02 01:18:21
20220615214548	2024-07-02 01:18:21
20220712093339	2024-07-02 01:18:21
20220908172859	2024-07-02 01:18:21
20220916233421	2024-07-02 01:18:21
20230119133233	2024-07-02 01:18:21
20230128025114	2024-07-02 01:18:21
20230128025212	2024-07-02 01:18:21
20230227211149	2024-07-02 01:18:21
20230228184745	2024-07-02 01:18:21
20230308225145	2024-07-02 01:18:21
20230328144023	2024-07-02 01:18:21
20231018144023	2024-07-02 01:18:21
20231204144023	2024-07-02 01:18:21
20231204144024	2024-07-02 01:18:21
20231204144025	2024-07-02 01:18:21
20240108234812	2024-07-02 01:18:21
20240109165339	2024-07-02 01:18:21
20240227174441	2024-07-02 01:18:21
20240311171622	2024-07-02 01:18:21
20240321100241	2024-07-02 01:18:21
20240401105812	2024-07-02 01:18:21
20240418121054	2024-07-02 01:18:21
20240523004032	2024-07-02 01:18:22
20240618124746	2024-07-02 01:18:22
20240801235015	2024-08-08 12:08:31
20240805133720	2024-08-08 12:08:31
20240827160934	2024-09-09 11:52:56
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
Storage Chat Internal	Storage Chat Internal	\N	2024-08-08 14:56:27.000568+00	2024-08-08 14:56:27.000568+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2024-05-10 16:19:22.574261
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2024-05-10 16:19:22.633006
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2024-05-10 16:19:22.6844
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2024-05-10 16:19:22.76848
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2024-05-10 16:19:22.817582
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2024-05-10 16:19:22.871846
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2024-05-10 16:19:22.920945
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2024-05-10 16:19:22.936559
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2024-05-10 16:19:22.988089
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2024-05-10 16:19:23.040389
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2024-05-10 16:19:23.049094
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2024-05-10 16:19:23.057716
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2024-05-10 16:19:23.109783
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2024-05-10 16:19:23.121156
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2024-05-10 16:19:23.180908
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2024-05-10 16:19:23.26323
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2024-05-10 16:19:23.313136
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2024-05-10 16:19:23.480762
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2024-05-10 16:19:23.532301
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2024-05-10 16:19:23.584494
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2024-05-10 16:19:23.63651
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2024-05-10 16:19:23.69233
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2024-05-10 16:19:23.780653
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2024-05-10 16:19:23.844866
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2024-07-02 01:18:47.179318
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2024-08-20 12:12:19.176955
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
8913b9b5-927b-4855-bd8a-ca4a53158ab0	Storage Chat Internal	default.png	\N	2024-09-27 12:42:36.362719+00	2024-09-27 12:42:36.362719+00	2024-09-27 12:42:36.362719+00	{"eTag": "\\"c945c608d5282b85f9dfe70a355488ce-1\\"", "size": 4650, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-09-27T12:42:36.000Z", "contentLength": 4650, "httpStatusCode": 200}	9b37f5f0-e7f1-4891-9b7c-346d00225a0c	\N	\N
70dc44b2-85b5-4f51-a5b1-72a89bd666c8	Storage Chat Internal	1e7fae21-e95a-4382-aac1-0920446ccba2+1000172426.jpg	\N	2024-10-15 18:15:44.317633+00	2024-10-15 18:15:44.317633+00	2024-10-15 18:15:44.317633+00	{"eTag": "\\"cf3cd8a9e805355f77af3d566c67e67c\\"", "size": 247276, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-10-15T18:15:45.000Z", "contentLength": 247276, "httpStatusCode": 200}	071921ea-768a-46a9-9a72-8dca8f9e4152	\N	{}
a8315ef5-86eb-4712-b511-3e1e73d6456e	Storage Chat Internal	8c9130ad-1329-48c0-b8aa-55d7d969ec5f+355348169_584982913840876_7381158039702250435_n.jpg	\N	2024-10-12 01:09:32.676043+00	2024-10-12 01:09:32.676043+00	2024-10-12 01:09:32.676043+00	{"eTag": "\\"caaf78dc91fbf4745c36f8f21a24912b\\"", "size": 29303, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-10-12T01:09:33.000Z", "contentLength": 29303, "httpStatusCode": 200}	c24f8046-50b2-4938-b631-cc6ac2bd3886	\N	{}
7495e4f7-fc11-4c0a-bbf6-76e347504a65	Storage Chat Internal	5c7c296a-98b6-4148-9596-9c6998c711de+355348169_584982913840876_7381158039702250435_n.jpg	\N	2024-10-12 01:11:07.955533+00	2024-10-12 01:11:07.955533+00	2024-10-12 01:11:07.955533+00	{"eTag": "\\"caaf78dc91fbf4745c36f8f21a24912b\\"", "size": 29303, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-10-12T01:11:08.000Z", "contentLength": 29303, "httpStatusCode": 200}	68be4fb3-8dc5-42a4-afe3-71983f7a0847	\N	{}
d95b4603-b3e3-4a87-bea1-21e1d0e2f78c	Storage Chat Internal	fd42c75e-30a0-4f06-b2e5-8a6f7d415aa2+355348169_584982913840876_7381158039702250435_n.jpg	\N	2024-10-12 01:12:06.139693+00	2024-10-12 01:12:06.139693+00	2024-10-12 01:12:06.139693+00	{"eTag": "\\"caaf78dc91fbf4745c36f8f21a24912b\\"", "size": 29303, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-10-12T01:12:07.000Z", "contentLength": 29303, "httpStatusCode": 200}	e4d3353e-aa60-43bc-971e-2bea9d7489f3	\N	{}
7b70d76a-28ea-4762-8b18-799701c1e56a	Storage Chat Internal	11051bb8-6c66-47d0-b0c3-e838c5a1276b+355348169_584982913840876_7381158039702250435_n.jpg	\N	2024-10-12 01:14:58.844697+00	2024-10-12 01:14:58.844697+00	2024-10-12 01:14:58.844697+00	{"eTag": "\\"caaf78dc91fbf4745c36f8f21a24912b\\"", "size": 29303, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-10-12T01:14:59.000Z", "contentLength": 29303, "httpStatusCode": 200}	2c908386-59f8-4259-9808-c90c6d0c5ce6	\N	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: channels_id_channel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.channels_id_channel_seq', 1, true);


--
-- Name: direct_message_id_direct_message_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.direct_message_id_direct_message_seq', 117, true);


--
-- Name: history_maintenances_id_history_maintenance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.history_maintenances_id_history_maintenance_seq', 1, false);


--
-- Name: messages_id_message_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_message_seq', 110, true);


--
-- Name: permissions_id_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_permission_seq', 20, true);


--
-- Name: roles_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_role_seq', 12, true);


--
-- Name: tokens_id_token_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tokens_id_token_seq', 233, true);


--
-- Name: user_permissions_id_user_permission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_permissions_id_user_permission_seq', 20, true);


--
-- Name: users_channels_id_user_channel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_channels_id_user_channel_seq', 3, true);


--
-- Name: vulgar_words_id_vulgar_words_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vulgar_words_id_vulgar_words_seq', 103, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.messages_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id_channel);


--
-- Name: direct_message direct_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direct_message
    ADD CONSTRAINT direct_message_pkey PRIMARY KEY (id_direct_message);


--
-- Name: history_maintenances history_maintenances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_maintenances
    ADD CONSTRAINT history_maintenances_pkey PRIMARY KEY (id_history_maintenance);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id_message);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id_permission);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_role);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id_token);


--
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id_user_permission);


--
-- Name: users_channels users_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_channels
    ADD CONSTRAINT users_channels_pkey PRIMARY KEY (id_user_channel);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: vulgar_words vulgar_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vulgar_words
    ADD CONSTRAINT vulgar_words_pkey PRIMARY KEY (id_vulgar_words);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: users_network_user_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_network_user_key ON public.users USING btree (network_user);


--
-- Name: vulgar_words_word_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vulgar_words_word_key ON public.vulgar_words USING btree (word);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING hash (entity);


--
-- Name: messages_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_topic_index ON realtime.messages USING btree (topic);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: direct_message direct_message_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direct_message
    ADD CONSTRAINT direct_message_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES public.users(id_user);


--
-- Name: direct_message direct_message_send_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direct_message
    ADD CONSTRAINT direct_message_send_id_fkey FOREIGN KEY (send_id) REFERENCES public.users(id_user);


--
-- Name: history_maintenances history_maintenances_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_maintenances
    ADD CONSTRAINT history_maintenances_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: messages messages_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id_channel) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tokens tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_permissions user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(id_permission) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_permissions user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users_channels users_channels_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_channels
    ADD CONSTRAINT users_channels_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.channels(id_channel) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users_channels users_channels_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_channels
    ADD CONSTRAINT users_channels_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id_role) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: supabase_realtime users; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.users;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION lo_export(oid, text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_export(oid, text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_export(oid, text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text) TO supabase_admin;


--
-- Name: FUNCTION lo_import(text, oid); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pg_catalog.lo_import(text, oid) FROM postgres;
GRANT ALL ON FUNCTION pg_catalog.lo_import(text, oid) TO supabase_admin;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: SEQUENCE messages_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.messages_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.messages_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.messages_id_seq TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

