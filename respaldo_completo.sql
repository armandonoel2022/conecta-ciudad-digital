--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.13 (Homebrew)

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
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

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



--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--



--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--



--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--



--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--



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
-- Name: app_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.app_role AS ENUM (
    'admin',
    'community_leader',
    'community_user'
);


ALTER TYPE public.app_role OWNER TO postgres;

--
-- Name: report_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.report_category AS ENUM (
    'basura',
    'iluminacion',
    'baches',
    'seguridad',
    'otros'
);


ALTER TYPE public.report_category OWNER TO postgres;

--
-- Name: report_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.report_status AS ENUM (
    'pendiente',
    'en_proceso',
    'resuelto',
    'rechazado'
);


ALTER TYPE public.report_status OWNER TO postgres;

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
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
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
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
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
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: assign_default_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.assign_default_role() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Asignar rol community_user por defecto a usuarios nuevos
  INSERT INTO public.user_roles (user_id, role, is_active)
  VALUES (NEW.id, 'community_user', true);
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.assign_default_role() OWNER TO postgres;

--
-- Name: check_message_limit_trigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_message_limit_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Check if user has role to send messages
  IF NOT (has_role(NEW.created_by, 'community_leader'::app_role) OR is_admin(NEW.created_by)) THEN
    RAISE EXCEPTION 'User does not have permission to send community messages';
  END IF;
  
  -- Check weekly limit (admins are exempt)
  IF NOT is_admin(NEW.created_by) AND NOT check_weekly_message_limit(NEW.created_by) THEN
    RAISE EXCEPTION 'Weekly message limit exceeded. Maximum 3 messages per week allowed.';
  END IF;
  
  -- Increment the weekly count
  PERFORM increment_weekly_message_count(NEW.created_by);
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_message_limit_trigger() OWNER TO postgres;

--
-- Name: check_weekly_message_limit(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_weekly_message_limit(_user_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_week_start DATE;
  message_count INTEGER;
BEGIN
  -- Calculate the start of the current week (Monday)
  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;
  
  -- Get the current week's message count
  SELECT COALESCE(message_count, 0) INTO message_count
  FROM public.message_weekly_limits
  WHERE user_id = _user_id AND week_start = current_week_start;
  
  -- Return true if under the limit (3 messages per week)
  RETURN COALESCE(message_count, 0) < 3;
END;
$$;


ALTER FUNCTION public.check_weekly_message_limit(_user_id uuid) OWNER TO postgres;

--
-- Name: deactivate_expired_panic_alerts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deactivate_expired_panic_alerts() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE public.panic_alerts 
  SET is_active = false 
  WHERE is_active = true 
  AND expires_at < now();
END;
$$;


ALTER FUNCTION public.deactivate_expired_panic_alerts() OWNER TO postgres;

--
-- Name: deactivate_expired_test_notifications(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deactivate_expired_test_notifications() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE public.global_test_notifications 
  SET is_active = false 
  WHERE is_active = true 
  AND expires_at < now();
END;
$$;


ALTER FUNCTION public.deactivate_expired_test_notifications() OWNER TO postgres;

--
-- Name: delete_user_completely(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_user_completely(user_id_to_delete uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_user_id uuid;
BEGIN
  -- Get the current user ID
  current_user_id := auth.uid();
  
  -- Check if current user is admin
  IF NOT is_admin(current_user_id) THEN
    RAISE EXCEPTION 'Only admins can delete users';
  END IF;
  
  -- Check if trying to delete yourself
  IF current_user_id = user_id_to_delete THEN
    RAISE EXCEPTION 'Cannot delete your own account';
  END IF;
  
  -- Delete user data in order (respecting foreign key constraints)
  DELETE FROM public.garbage_payments WHERE user_id = user_id_to_delete;
  DELETE FROM public.garbage_bills WHERE user_id = user_id_to_delete;
  DELETE FROM public.help_messages WHERE user_id = user_id_to_delete;
  DELETE FROM public.job_applications WHERE user_id = user_id_to_delete;
  DELETE FROM public.message_recipients WHERE user_id = user_id_to_delete;
  DELETE FROM public.message_weekly_limits WHERE user_id = user_id_to_delete;
  DELETE FROM public.community_messages WHERE created_by = user_id_to_delete;
  DELETE FROM public.before_after_videos WHERE user_id = user_id_to_delete;
  DELETE FROM public.amber_alerts WHERE user_id = user_id_to_delete;
  DELETE FROM public.panic_alerts WHERE user_id = user_id_to_delete;
  DELETE FROM public.reports WHERE user_id = user_id_to_delete;
  DELETE FROM public.generated_reports WHERE generated_by = user_id_to_delete;
  DELETE FROM public.report_schedules WHERE created_by = user_id_to_delete;
  DELETE FROM public.global_test_notifications WHERE triggered_by = user_id_to_delete;
  
  -- Delete user roles
  DELETE FROM public.user_roles WHERE user_id = user_id_to_delete;
  
  -- Delete profile
  DELETE FROM public.profiles WHERE id = user_id_to_delete;
  
  -- Delete from auth.users (this will cascade to other auth-related tables)
  DELETE FROM auth.users WHERE id = user_id_to_delete;
  
  RETURN true;
END;
$$;


ALTER FUNCTION public.delete_user_completely(user_id_to_delete uuid) OWNER TO postgres;

--
-- Name: generate_bill_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_bill_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
  current_year TEXT;
  sequence_num TEXT;
BEGIN
  current_year := EXTRACT(YEAR FROM NOW())::TEXT;
  sequence_num := LPAD((SELECT COALESCE(MAX(CAST(SUBSTRING(bill_number FROM 6) AS INTEGER)), 0) + 1 
                       FROM garbage_bills 
                       WHERE bill_number LIKE current_year || '-%'), 6, '0');
  RETURN current_year || '-' || sequence_num;
END;
$$;


ALTER FUNCTION public.generate_bill_number() OWNER TO postgres;

--
-- Name: generate_monthly_bills(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_monthly_bills() RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
  user_record RECORD;
  bills_generated INTEGER := 0;
  current_month_start DATE;
  current_month_end DATE;
  due_date DATE;
  base_amount INTEGER := 150000; -- $1,500 pesos en centavos
BEGIN
  -- Calcular fechas del mes actual
  current_month_start := DATE_TRUNC('month', CURRENT_DATE);
  current_month_end := (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::DATE;
  due_date := current_month_end + INTERVAL '15 days';
  
  -- Generar facturas para usuarios que no tienen factura del mes actual
  FOR user_record IN 
    SELECT DISTINCT p.id 
    FROM profiles p
    WHERE p.first_name IS NOT NULL 
    AND p.last_name IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM garbage_bills gb 
      WHERE gb.user_id = p.id 
      AND gb.billing_period_start = current_month_start
    )
  LOOP
    INSERT INTO garbage_bills (
      user_id,
      billing_period_start,
      billing_period_end,
      amount_due,
      due_date,
      status
    ) VALUES (
      user_record.id,
      current_month_start,
      current_month_end,
      base_amount + (RANDOM() * 50000)::INTEGER, -- Variación de ±$500
      due_date,
      'pending'
    );
    
    bills_generated := bills_generated + 1;
  END LOOP;
  
  RETURN bills_generated;
END;
$_$;


ALTER FUNCTION public.generate_monthly_bills() OWNER TO postgres;

--
-- Name: generate_scheduled_reports(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_scheduled_reports() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    schedule_record RECORD;
    reports_generated INTEGER := 0;
BEGIN
    -- Buscar reportes programados que necesitan ser generados
    FOR schedule_record IN 
        SELECT * FROM public.report_schedules
        WHERE is_active = true 
        AND (next_generation_at IS NULL OR next_generation_at <= now())
    LOOP
        -- Crear un nuevo reporte basado en la programación
        INSERT INTO public.generated_reports (
            title,
            description,
            report_type,
            generated_by,
            date_range_start,
            date_range_end,
            filters,
            status
        ) VALUES (
            schedule_record.name || ' - ' || to_char(now(), 'DD/MM/YYYY'),
            'Reporte generado automáticamente',
            schedule_record.report_type,
            schedule_record.created_by,
            CASE 
                WHEN schedule_record.frequency = 'daily' THEN current_date - interval '1 day'
                WHEN schedule_record.frequency = 'weekly' THEN current_date - interval '1 week'
                WHEN schedule_record.frequency = 'monthly' THEN current_date - interval '1 month'
            END,
            current_date,
            schedule_record.filters,
            'generating'
        );
        
        -- Actualizar las fechas de la programación
        UPDATE public.report_schedules
        SET 
            last_generated_at = now(),
            next_generation_at = CASE 
                WHEN frequency = 'daily' THEN now() + interval '1 day'
                WHEN frequency = 'weekly' THEN now() + interval '1 week'
                WHEN frequency = 'monthly' THEN now() + interval '1 month'
            END,
            updated_at = now()
        WHERE id = schedule_record.id;
        
        reports_generated := reports_generated + 1;
    END LOOP;
    
    RETURN reports_generated;
END;
$$;


ALTER FUNCTION public.generate_scheduled_reports() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, first_name, last_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    NEW.raw_user_meta_data->>'first_name',
    NEW.raw_user_meta_data->>'last_name'
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: has_role(uuid, public.app_role); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.has_role(_user_id uuid, _role public.app_role) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
      AND is_active = true
  )
$$;


ALTER FUNCTION public.has_role(_user_id uuid, _role public.app_role) OWNER TO postgres;

--
-- Name: increment_weekly_message_count(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.increment_weekly_message_count(_user_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  current_week_start DATE;
BEGIN
  -- Calculate the start of the current week (Monday)
  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;
  
  -- Insert or update the weekly count
  INSERT INTO public.message_weekly_limits (user_id, week_start, message_count)
  VALUES (_user_id, current_week_start, 1)
  ON CONFLICT (user_id, week_start)
  DO UPDATE SET 
    message_count = message_weekly_limits.message_count + 1,
    updated_at = now();
END;
$$;


ALTER FUNCTION public.increment_weekly_message_count(_user_id uuid) OWNER TO postgres;

--
-- Name: is_admin(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_admin(_user_id uuid) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT public.has_role(_user_id, 'admin')
$$;


ALTER FUNCTION public.is_admin(_user_id uuid) OWNER TO postgres;

--
-- Name: reset_user_password_with_temp(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reset_user_password_with_temp(user_email text, temp_password text) RETURNS json
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  user_id UUID;
  result JSON;
BEGIN
  -- Find user by email
  SELECT id INTO user_id 
  FROM auth.users 
  WHERE email = user_email;
  
  IF user_id IS NULL THEN
    RETURN JSON_BUILD_OBJECT('success', false, 'error', 'Usuario no encontrado');
  END IF;
  
  -- Update user password in auth.users
  UPDATE auth.users 
  SET 
    encrypted_password = crypt(temp_password, gen_salt('bf')),
    updated_at = now()
  WHERE id = user_id;
  
  -- Mark user as needing password change
  INSERT INTO public.profiles (id, must_change_password)
  VALUES (user_id, true)
  ON CONFLICT (id) 
  DO UPDATE SET 
    must_change_password = true,
    updated_at = now();
  
  RETURN JSON_BUILD_OBJECT('success', true, 'message', 'Contraseña temporal establecida');
END;
$$;


ALTER FUNCTION public.reset_user_password_with_temp(user_email text, temp_password text) OWNER TO postgres;

--
-- Name: set_bill_number(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_bill_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.bill_number IS NULL OR NEW.bill_number = '' THEN
    NEW.bill_number := generate_bill_number();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_bill_number() OWNER TO postgres;

--
-- Name: update_community_messages_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_community_messages_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_community_messages_updated_at() OWNER TO postgres;

--
-- Name: update_garbage_alert_configs_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_garbage_alert_configs_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_garbage_alert_configs_updated_at() OWNER TO postgres;

--
-- Name: update_user_2fa_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user_2fa_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_user_2fa_updated_at() OWNER TO postgres;

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
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

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
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

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
    otp_code text,
    web_authn_session_data jsonb
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
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
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
-- Name: amber_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.amber_alerts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    child_full_name text NOT NULL,
    child_nickname text,
    child_photo_url text,
    last_seen_location text NOT NULL,
    disappearance_time timestamp with time zone NOT NULL,
    medical_conditions text,
    contact_number text NOT NULL,
    additional_details text,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    resolved_at timestamp with time zone,
    resolved_by uuid
);

ALTER TABLE ONLY public.amber_alerts REPLICA IDENTITY FULL;


ALTER TABLE public.amber_alerts OWNER TO postgres;

--
-- Name: before_after_videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.before_after_videos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    description text,
    video_url text NOT NULL,
    file_name text NOT NULL,
    file_size integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.before_after_videos OWNER TO postgres;

--
-- Name: community_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_by uuid NOT NULL,
    title text NOT NULL,
    message text NOT NULL,
    image_url text,
    sector text,
    municipality text NOT NULL,
    province text NOT NULL,
    scheduled_at timestamp with time zone,
    sent_at timestamp with time zone,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.community_messages OWNER TO postgres;

--
-- Name: garbage_alert_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garbage_alert_configs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sector text NOT NULL,
    municipality text DEFAULT 'Santo Domingo'::text NOT NULL,
    province text DEFAULT 'Distrito Nacional'::text NOT NULL,
    days_of_week integer[] DEFAULT '{1,3,5}'::integer[] NOT NULL,
    frequency_hours integer DEFAULT 3 NOT NULL,
    start_hour integer DEFAULT 6 NOT NULL,
    end_hour integer DEFAULT 18 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid
);


ALTER TABLE public.garbage_alert_configs OWNER TO postgres;

--
-- Name: garbage_bills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garbage_bills (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    bill_number text NOT NULL,
    billing_period_start date NOT NULL,
    billing_period_end date NOT NULL,
    amount_due integer NOT NULL,
    due_date date NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT garbage_bills_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'paid'::text, 'overdue'::text, 'cancelled'::text])))
);


ALTER TABLE public.garbage_bills OWNER TO postgres;

--
-- Name: garbage_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garbage_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    bill_id uuid NOT NULL,
    stripe_session_id text,
    amount_paid integer NOT NULL,
    payment_method text DEFAULT 'stripe'::text,
    payment_status text DEFAULT 'pending'::text NOT NULL,
    payment_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT garbage_payments_payment_status_check CHECK ((payment_status = ANY (ARRAY['pending'::text, 'completed'::text, 'failed'::text, 'refunded'::text])))
);


ALTER TABLE public.garbage_payments OWNER TO postgres;

--
-- Name: generated_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.generated_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    report_type character varying(50) NOT NULL,
    generated_by uuid,
    date_range_start date,
    date_range_end date,
    filters jsonb,
    google_sheets_url text,
    google_chart_url text,
    pdf_url text,
    status character varying(20) DEFAULT 'generating'::character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.generated_reports OWNER TO postgres;

--
-- Name: global_test_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_test_notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    notification_type text NOT NULL,
    triggered_by uuid NOT NULL,
    triggered_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:00:30'::interval) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    message text
);

ALTER TABLE ONLY public.global_test_notifications REPLICA IDENTITY FULL;


ALTER TABLE public.global_test_notifications OWNER TO postgres;

--
-- Name: help_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.help_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    subject text NOT NULL,
    message text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    priority text DEFAULT 'normal'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    resolved_at timestamp with time zone,
    admin_response text,
    user_email text NOT NULL,
    user_full_name text NOT NULL
);


ALTER TABLE public.help_messages OWNER TO postgres;

--
-- Name: job_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_applications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    full_name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    address text,
    birth_date date,
    document_type text,
    document_number text,
    education_level text NOT NULL,
    institution_name text,
    career_field text,
    graduation_year integer,
    additional_courses text,
    work_experience text,
    skills text,
    availability text,
    expected_salary text,
    cv_file_url text,
    cv_file_name text,
    status text DEFAULT 'pending'::text NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.job_applications OWNER TO postgres;

--
-- Name: message_recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_recipients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    message_id uuid NOT NULL,
    user_id uuid NOT NULL,
    delivered_at timestamp with time zone,
    read_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.message_recipients OWNER TO postgres;

--
-- Name: message_weekly_limits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_weekly_limits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    week_start date NOT NULL,
    message_count integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.message_weekly_limits OWNER TO postgres;

--
-- Name: panic_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.panic_alerts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    user_full_name text NOT NULL,
    latitude numeric,
    longitude numeric,
    address text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:01:00'::interval) NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);

ALTER TABLE ONLY public.panic_alerts REPLICA IDENTITY FULL;


ALTER TABLE public.panic_alerts OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    full_name text,
    phone text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    first_name text,
    last_name text,
    document_type text,
    document_number text,
    address text,
    neighborhood text,
    city text DEFAULT 'Medellín'::text,
    birth_date date,
    gender text,
    must_change_password boolean DEFAULT false,
    CONSTRAINT profiles_document_type_check CHECK ((document_type = ANY (ARRAY['cedula'::text, 'pasaporte'::text, 'tarjeta_identidad'::text]))),
    CONSTRAINT profiles_gender_check CHECK ((gender = ANY (ARRAY['masculino'::text, 'femenino'::text, 'otro'::text, 'prefiero_no_decir'::text])))
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: report_metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_metrics (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    report_id uuid,
    metric_name character varying(100) NOT NULL,
    metric_value numeric,
    metric_type character varying(50),
    category character varying(100),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.report_metrics OWNER TO postgres;

--
-- Name: report_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_schedules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    report_type character varying(50) NOT NULL,
    frequency character varying(20) NOT NULL,
    filters jsonb,
    created_by uuid,
    is_active boolean DEFAULT true,
    last_generated_at timestamp with time zone,
    next_generation_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.report_schedules OWNER TO postgres;

--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    category public.report_category NOT NULL,
    status public.report_status DEFAULT 'pendiente'::public.report_status,
    latitude numeric(10,8),
    longitude numeric(11,8),
    image_url text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    address text,
    neighborhood text,
    priority text DEFAULT 'media'::text,
    resolved_at timestamp with time zone,
    assigned_to uuid,
    resolution_notes text,
    citizen_satisfaction integer,
    CONSTRAINT reports_citizen_satisfaction_check CHECK (((citizen_satisfaction >= 1) AND (citizen_satisfaction <= 5))),
    CONSTRAINT reports_priority_check CHECK ((priority = ANY (ARRAY['baja'::text, 'media'::text, 'alta'::text, 'critica'::text])))
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- Name: user_2fa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_2fa (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    secret text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    backup_codes text[],
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE public.user_2fa OWNER TO postgres;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role public.app_role NOT NULL,
    assigned_by uuid,
    assigned_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2025_07_09; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_09 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_09 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_10; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_10 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_10 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_11; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_11 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_11 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_12; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_12 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_12 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_13; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_13 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_13 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_14; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_14 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_14 OWNER TO supabase_admin;

--
-- Name: messages_2025_07_15; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_15 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_15 OWNER TO supabase_admin;

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
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2025_07_09; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_09 FOR VALUES FROM ('2025-07-09 00:00:00') TO ('2025-07-10 00:00:00');


--
-- Name: messages_2025_07_10; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_10 FOR VALUES FROM ('2025-07-10 00:00:00') TO ('2025-07-11 00:00:00');


--
-- Name: messages_2025_07_11; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_11 FOR VALUES FROM ('2025-07-11 00:00:00') TO ('2025-07-12 00:00:00');


--
-- Name: messages_2025_07_12; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_12 FOR VALUES FROM ('2025-07-12 00:00:00') TO ('2025-07-13 00:00:00');


--
-- Name: messages_2025_07_13; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_13 FOR VALUES FROM ('2025-07-13 00:00:00') TO ('2025-07-14 00:00:00');


--
-- Name: messages_2025_07_14; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_14 FOR VALUES FROM ('2025-07-14 00:00:00') TO ('2025-07-15 00:00:00');


--
-- Name: messages_2025_07_15; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_15 FOR VALUES FROM ('2025-07-15 00:00:00') TO ('2025-07-16 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	68824ad7-fa9f-45ff-85f2-b491672c28e6	{"action":"user_confirmation_requested","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-06-15 01:55:41.077371+00	
00000000-0000-0000-0000-000000000000	3e99d331-c750-4045-a177-04bde912dcf1	{"action":"user_signedup","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"team"}	2025-06-15 01:58:13.625811+00	
00000000-0000-0000-0000-000000000000	7829cbe0-eb46-4db3-a8d2-c7b27957df8b	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 02:00:10.070432+00	
00000000-0000-0000-0000-000000000000	a00acb47-060b-407e-9294-d59304192666	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 02:58:42.55877+00	
00000000-0000-0000-0000-000000000000	9ec5fc62-0f67-4313-a159-609f9a2c6f61	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 02:58:42.560351+00	
00000000-0000-0000-0000-000000000000	540ab793-8b8e-4417-be81-7b3c8d0e3168	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 03:18:30.313201+00	
00000000-0000-0000-0000-000000000000	4d4a28fe-89a8-4d9f-af77-fa7572bab8dd	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 03:19:38.656372+00	
00000000-0000-0000-0000-000000000000	eb86ff44-2e6a-455a-a4f8-1000732d42a2	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 03:35:42.188256+00	
00000000-0000-0000-0000-000000000000	f26879fa-b725-4536-bf45-35a5cc3312ee	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 03:35:51.797848+00	
00000000-0000-0000-0000-000000000000	aac9cca8-7b3b-4c62-aad8-3eefe8dea10b	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 04:03:14.067683+00	
00000000-0000-0000-0000-000000000000	6e42c447-9be2-4043-89dc-4bb63c9ea664	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 04:03:29.582125+00	
00000000-0000-0000-0000-000000000000	62ffd942-63c3-4bbb-8519-d04860100471	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 04:05:08.949488+00	
00000000-0000-0000-0000-000000000000	379e75ac-70bc-4181-bb0f-164a7647d883	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 05:01:44.530402+00	
00000000-0000-0000-0000-000000000000	2c84547f-88ce-4da4-a1ff-6ecc424fc7de	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 05:01:44.531325+00	
00000000-0000-0000-0000-000000000000	e09c2f5d-3f2f-4829-82cc-22112710dfbc	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 05:03:13.325713+00	
00000000-0000-0000-0000-000000000000	9edb6a89-051f-4830-801f-55d48e608f22	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 05:03:13.33002+00	
00000000-0000-0000-0000-000000000000	0051e640-0b16-43a9-af0e-986513ab2ffe	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 05:31:18.463955+00	
00000000-0000-0000-0000-000000000000	e26db965-8f32-4afd-8b7b-74e7c07d566c	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 13:52:43.141626+00	
00000000-0000-0000-0000-000000000000	04744d15-bd47-4d23-84cb-5e8ff64ec45f	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 14:11:33.28343+00	
00000000-0000-0000-0000-000000000000	ef3d9083-97de-40af-9e6d-2cffb6441ab6	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 14:51:14.252271+00	
00000000-0000-0000-0000-000000000000	5c798c60-73f3-430d-a0f6-4785096fb7c9	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 14:51:14.254066+00	
00000000-0000-0000-0000-000000000000	debd38eb-297e-4330-add7-0c5135a8bd60	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 15:09:52.165042+00	
00000000-0000-0000-0000-000000000000	ff35b6bc-cb63-4128-ba1b-46efba0ae554	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 15:09:52.167205+00	
00000000-0000-0000-0000-000000000000	d1fc6ae2-9de1-4b9b-97ce-4f7af629dce2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 15:53:57.654767+00	
00000000-0000-0000-0000-000000000000	81200f46-b9a8-428f-a8e5-2ce596c8249d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 15:53:57.655899+00	
00000000-0000-0000-0000-000000000000	65057150-a638-4905-a927-0f3a5f88fbbb	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 16:08:02.03632+00	
00000000-0000-0000-0000-000000000000	eb666220-79d7-4721-a209-8d011e88207d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 16:08:02.038745+00	
00000000-0000-0000-0000-000000000000	cc915657-e0f6-4bae-b5c6-a07afed5295d	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 16:20:15.733339+00	
00000000-0000-0000-0000-000000000000	a94e8dd8-872c-4e08-85f2-ccc2649fee67	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 16:20:28.587389+00	
00000000-0000-0000-0000-000000000000	53da6e62-8b8a-4dee-bd21-5ab8ad3c18fd	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 16:21:13.44492+00	
00000000-0000-0000-0000-000000000000	beabbede-97f7-48f4-a0ed-51feb9a69bf5	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 16:21:26.399385+00	
00000000-0000-0000-0000-000000000000	f0ca2643-329f-4799-9806-a8ad76a8a663	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 16:31:04.407386+00	
00000000-0000-0000-0000-000000000000	ac385d6b-68e7-49b7-9c1c-392490dc945b	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 16:31:12.725025+00	
00000000-0000-0000-0000-000000000000	dbbdf0e6-8d7a-4d56-8df8-91bf5be0c67e	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 17:28:49.011376+00	
00000000-0000-0000-0000-000000000000	9b778f56-fbaa-480c-9518-543aea94c705	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 17:29:47.205616+00	
00000000-0000-0000-0000-000000000000	e71dcc93-a63f-4a2d-aa54-27b03bb61ffa	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 17:29:47.20624+00	
00000000-0000-0000-0000-000000000000	b10a34c1-aa9e-46fb-b29a-8acd7c21d419	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 18:27:11.066433+00	
00000000-0000-0000-0000-000000000000	847521a3-4116-4cc1-b292-8682ebc3bb52	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 18:27:11.068061+00	
00000000-0000-0000-0000-000000000000	73289b49-c4c6-47c8-ad2f-fd242f582770	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 18:28:16.43049+00	
00000000-0000-0000-0000-000000000000	84d5e338-6758-4a8d-a0ce-eff5d77dc812	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 18:28:16.431455+00	
00000000-0000-0000-0000-000000000000	5250ab27-2da5-4228-b988-b5489c684365	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 19:55:09.407095+00	
00000000-0000-0000-0000-000000000000	ee9521e6-67d3-4a2f-870d-ac5b162998cf	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 19:55:09.408722+00	
00000000-0000-0000-0000-000000000000	de50172a-efbb-4a9f-8f51-4cac3a70bee2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 19:55:53.619051+00	
00000000-0000-0000-0000-000000000000	85265006-dd02-45f8-a63f-3e722433af17	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 19:55:53.620476+00	
00000000-0000-0000-0000-000000000000	2b3f9a8c-4cfd-4e6b-a524-82130183c3a4	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-06-15 20:06:26.149003+00	
00000000-0000-0000-0000-000000000000	19b7aee0-5542-44bd-a425-2e2461cfc450	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 20:06:35.844329+00	
00000000-0000-0000-0000-000000000000	37d42ef1-6d44-4794-82a4-37c2e5807bae	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-06-15 20:13:29.704703+00	
00000000-0000-0000-0000-000000000000	4990ba97-f438-4386-9f86-c632f914c000	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 22:21:42.136774+00	
00000000-0000-0000-0000-000000000000	3223c83e-9cba-4106-a0f2-95f3e7977649	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-15 22:21:42.138563+00	
00000000-0000-0000-0000-000000000000	04b21ce7-9b46-487b-ad6d-9aced560a537	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 00:16:08.919222+00	
00000000-0000-0000-0000-000000000000	62ac9684-6aed-4efc-93fe-b39af2b873d7	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 00:16:08.92951+00	
00000000-0000-0000-0000-000000000000	a6318bb5-3c2b-4ab4-84a2-9a0443e1f88f	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 01:14:37.319849+00	
00000000-0000-0000-0000-000000000000	08d73338-f18d-4a5f-8f6a-a22a212e348c	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 01:14:37.321489+00	
00000000-0000-0000-0000-000000000000	5445f2ce-c3da-40d8-8a33-37f81c00326d	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 03:59:53.955251+00	
00000000-0000-0000-0000-000000000000	ae2d23a4-2fcd-4cee-9491-2442d0afd2d6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 03:59:53.963435+00	
00000000-0000-0000-0000-000000000000	f8469749-31f0-45d2-84bf-15c710f84607	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 13:17:14.24506+00	
00000000-0000-0000-0000-000000000000	d80a2509-99e6-47ab-bf75-bf93653839b6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 13:17:14.249519+00	
00000000-0000-0000-0000-000000000000	ddc3bb3d-6678-4675-9831-12ce9ddbc542	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 16:15:19.053732+00	
00000000-0000-0000-0000-000000000000	009e187c-b6a4-4a37-8262-7375cc1e10cd	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 16:15:19.058831+00	
00000000-0000-0000-0000-000000000000	1ced1ccb-08de-4edb-8832-99d1bdb395fe	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 17:15:54.776732+00	
00000000-0000-0000-0000-000000000000	aa0aac82-7f89-48fa-a095-87b63e1b4e4c	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 17:15:54.779868+00	
00000000-0000-0000-0000-000000000000	2f592293-8253-465a-af90-836e2f403e34	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 18:33:19.09716+00	
00000000-0000-0000-0000-000000000000	14113acf-b0d9-482b-9a94-256f3bd07ff6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-16 18:33:19.099325+00	
00000000-0000-0000-0000-000000000000	928f7130-fa27-43a3-93e0-2c2c6ff98211	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 18:33:32.655236+00	
00000000-0000-0000-0000-000000000000	43207476-254a-4bf2-93e0-27dd09487157	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-17 18:33:32.661358+00	
00000000-0000-0000-0000-000000000000	5ac4d882-d7e5-4a32-a959-4093eb63eb82	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 01:08:10.452891+00	
00000000-0000-0000-0000-000000000000	ac796730-565d-44dc-8fc4-ee88ed8714a0	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 01:08:10.457124+00	
00000000-0000-0000-0000-000000000000	3bb7e207-f4dd-4a1b-bbdb-3848d23a5810	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 02:04:05.66097+00	
00000000-0000-0000-0000-000000000000	5525d15c-99cb-4a74-b2fd-b78ff8029813	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 02:04:05.661849+00	
00000000-0000-0000-0000-000000000000	05b1fd15-1985-4cbd-9b6d-a895c43c15ef	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 02:09:34.44384+00	
00000000-0000-0000-0000-000000000000	287d39b3-a6ae-43d2-b093-9201851324fc	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 02:09:34.44748+00	
00000000-0000-0000-0000-000000000000	3aab0a9d-7139-47cd-b906-2ab1f896e2de	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 07:13:40.889849+00	
00000000-0000-0000-0000-000000000000	b3de5157-cb28-4b13-af86-f6c00498fc37	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 07:13:40.899564+00	
00000000-0000-0000-0000-000000000000	db086a83-d5fa-45b9-a222-f4f4e3c1f9bc	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 09:38:17.166838+00	
00000000-0000-0000-0000-000000000000	e40e6ba5-1aa9-49f9-8823-f4890c2db4f6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 09:38:17.176376+00	
00000000-0000-0000-0000-000000000000	f5ef8706-7907-4baf-89f4-55068b8d58ee	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 22:56:44.643926+00	
00000000-0000-0000-0000-000000000000	4673aa17-0a8c-4447-946f-cb5e7283b46a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-18 22:56:44.652428+00	
00000000-0000-0000-0000-000000000000	0659c67c-bed2-482e-960e-b0568cff7e7a	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 07:43:30.243985+00	
00000000-0000-0000-0000-000000000000	8d3d1e15-f57f-47b3-91ee-acf1ebc1326e	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 07:43:30.247209+00	
00000000-0000-0000-0000-000000000000	3e0950e6-3720-47c6-a432-3e0303c9cbaa	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 08:44:37.582674+00	
00000000-0000-0000-0000-000000000000	5023ee63-60e6-42de-bae9-f60fdd9919ff	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 08:44:37.585391+00	
00000000-0000-0000-0000-000000000000	1e2e363a-bbf4-4841-b0eb-97348d47c1f3	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 10:07:10.576684+00	
00000000-0000-0000-0000-000000000000	b044863b-06ea-4743-9084-2a4be0074965	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 10:07:10.578872+00	
00000000-0000-0000-0000-000000000000	6436913e-5125-496a-a6fc-41ff4fca3e2b	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 12:00:40.091548+00	
00000000-0000-0000-0000-000000000000	e9d2ecf3-7cb3-4ac8-9b42-28a0e7e1542d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 12:00:40.094877+00	
00000000-0000-0000-0000-000000000000	2109e7b9-e494-4bfe-a123-6b51a82815c5	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 18:01:28.762276+00	
00000000-0000-0000-0000-000000000000	95e86111-c779-4eb9-bbce-0c0658d48c22	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 18:01:28.766359+00	
00000000-0000-0000-0000-000000000000	7fcee6f4-e275-4bb9-8100-3049640285aa	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 19:35:10.474198+00	
00000000-0000-0000-0000-000000000000	f8e5f8f5-fe62-41a6-9d21-d204df735fb1	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-06-19 19:35:10.478171+00	
00000000-0000-0000-0000-000000000000	992d2214-bcd9-4583-a057-7902f26f84fd	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-04 12:35:16.428667+00	
00000000-0000-0000-0000-000000000000	2672bc61-ad06-4ead-a04e-2b3ed6cf0441	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-04 12:38:33.670078+00	
00000000-0000-0000-0000-000000000000	042c02de-8e53-46c4-b0a0-f4ab1c30b3b7	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 13:33:23.268072+00	
00000000-0000-0000-0000-000000000000	5b642bd3-d663-4aba-9647-5533d20f8d02	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 13:33:23.272273+00	
00000000-0000-0000-0000-000000000000	b16eb83e-872f-4b03-bf38-e7409b8af65f	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 13:36:37.445676+00	
00000000-0000-0000-0000-000000000000	6d6e0ce7-a1bb-4205-9e62-f2049fbf08ac	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 13:36:37.447226+00	
00000000-0000-0000-0000-000000000000	99631f0f-1801-49b8-be1b-2a0634cedb56	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 14:31:42.203171+00	
00000000-0000-0000-0000-000000000000	f68969a2-377b-403a-b14d-787dbf2b69e1	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 14:31:42.205091+00	
00000000-0000-0000-0000-000000000000	085b2491-6329-4d60-86bd-79ec02c001f1	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 14:34:44.515491+00	
00000000-0000-0000-0000-000000000000	6272dd6d-6408-4b9e-a334-0d57a1dc9b00	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 14:34:44.516416+00	
00000000-0000-0000-0000-000000000000	484ec282-1d6a-4352-8b5e-f12a91d12cf1	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 15:54:15.399802+00	
00000000-0000-0000-0000-000000000000	9c138740-ad58-4aa8-8a08-47ec1ebca4af	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 15:54:15.402486+00	
00000000-0000-0000-0000-000000000000	47956ca5-7670-476f-9598-331ad03c8386	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 15:54:40.088835+00	
00000000-0000-0000-0000-000000000000	fa42cd98-3b15-4923-8804-708fb9951012	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 15:54:40.089516+00	
00000000-0000-0000-0000-000000000000	5d2df85b-bfe5-473d-abe9-d594948e2792	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 16:52:27.014457+00	
00000000-0000-0000-0000-000000000000	cfc688eb-6e74-4f90-87ba-113fd8857fa3	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 16:52:27.015325+00	
00000000-0000-0000-0000-000000000000	2912a028-22d0-406a-9be9-3788f5fb48e1	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 16:55:41.429137+00	
00000000-0000-0000-0000-000000000000	a03a8b5b-5cf3-4119-af47-45caabbb2252	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 16:55:41.431243+00	
00000000-0000-0000-0000-000000000000	a6b46af8-5678-4b98-bbac-f95d6704bd57	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-04 17:44:54.156128+00	
00000000-0000-0000-0000-000000000000	7ddaf363-69c3-44c6-a4eb-856ed0c60e6d	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 18:26:45.082634+00	
00000000-0000-0000-0000-000000000000	7adbb61a-0443-4208-9cad-de1bd6b320b8	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-04 19:37:23.763263+00	
00000000-0000-0000-0000-000000000000	7e83a78f-2e46-40bb-a4da-d18c5efce5e6	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 20:35:56.121093+00	
00000000-0000-0000-0000-000000000000	207906bb-4ae6-424b-b0e5-f8b15c6fbd1b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 20:35:56.123484+00	
00000000-0000-0000-0000-000000000000	a5d28b17-c875-427a-a3b0-91a8a5af7f96	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 23:53:16.37063+00	
00000000-0000-0000-0000-000000000000	cc3915b3-87df-4a30-9ae5-84f11b6c5f39	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 23:53:16.372354+00	
00000000-0000-0000-0000-000000000000	9de3fd16-ddfd-40df-a283-f87566bf31f0	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 01:07:58.037786+00	
00000000-0000-0000-0000-000000000000	76ed25b7-a69a-4bbd-b112-ad1ed99f1134	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 01:17:15.639175+00	
00000000-0000-0000-0000-000000000000	dfb95b96-31c6-45b3-a6c3-076401c50d5e	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 01:17:15.640694+00	
00000000-0000-0000-0000-000000000000	46e7d20d-a00f-4962-b16c-8bf435fce0cd	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 01:33:43.717108+00	
00000000-0000-0000-0000-000000000000	a1865e85-7938-4a7a-8cb7-d18a42215db3	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 01:41:15.676606+00	
00000000-0000-0000-0000-000000000000	bd8fddca-cdaa-439e-a5f8-4858dce254dd	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:06:30.895885+00	
00000000-0000-0000-0000-000000000000	7943f4ae-33b0-4f3d-8568-9fa2f2a63b6f	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:06:30.897414+00	
00000000-0000-0000-0000-000000000000	bf55cd25-561c-46c2-a9f3-11ecb5a93537	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:26:53.080573+00	
00000000-0000-0000-0000-000000000000	8feb506d-32d4-4484-9ade-ded36cee3029	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:26:53.08146+00	
00000000-0000-0000-0000-000000000000	92d7fb02-e65e-4d51-b61f-fff8fa399967	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:41:25.829938+00	
00000000-0000-0000-0000-000000000000	806eb168-c0e6-4212-9710-71126d0641a1	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 02:41:25.831494+00	
00000000-0000-0000-0000-000000000000	18666a28-c959-4fd5-a4fb-390de0b90393	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 03:30:11.478227+00	
00000000-0000-0000-0000-000000000000	ba4bc808-21f0-4f78-a6ee-0f8e5596a492	{"action":"user_confirmation_requested","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-05 03:31:12.170465+00	
00000000-0000-0000-0000-000000000000	5c92662d-b64b-487a-8f43-4a7d7b004878	{"action":"user_signedup","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-05 03:32:34.05407+00	
00000000-0000-0000-0000-000000000000	0e5e125e-bdbc-42a7-94ab-ff2ab0414308	{"action":"login","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 03:32:40.177322+00	
00000000-0000-0000-0000-000000000000	92ca09b4-fb08-40c3-a99f-6d00988a3ec0	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-05 03:45:39.317332+00	
00000000-0000-0000-0000-000000000000	3be4e480-5658-40b8-a1d4-a9de9f94874b	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 03:45:47.666831+00	
00000000-0000-0000-0000-000000000000	951f450e-40cd-488b-8c62-8b338ced89a1	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 04:00:31.581859+00	
00000000-0000-0000-0000-000000000000	579aa401-085b-404d-a3fd-5188b962b88a	{"action":"login","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 04:00:50.982595+00	
00000000-0000-0000-0000-000000000000	64732395-5ea2-4ff4-8ef0-395d466309b6	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 04:02:29.080027+00	
00000000-0000-0000-0000-000000000000	5ff7982d-7b52-42f1-93ac-81876c53bc47	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 04:17:34.341847+00	
00000000-0000-0000-0000-000000000000	8ac52a16-d3df-4199-a1d3-78f6fe184645	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 04:18:41.366795+00	
00000000-0000-0000-0000-000000000000	d69e93cb-bc89-4e53-82c1-c255ef98f041	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 06:55:11.666243+00	
00000000-0000-0000-0000-000000000000	c2df80ca-1841-4350-baf9-63e2185dd61b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 06:55:11.670843+00	
00000000-0000-0000-0000-000000000000	d902ad8f-3c8b-47f9-974a-3c20638550f5	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 12:10:44.814068+00	
00000000-0000-0000-0000-000000000000	f68ba29d-09af-49a8-b2e4-b712b872d7b6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 12:10:44.816239+00	
00000000-0000-0000-0000-000000000000	0b67af67-e044-40e6-a03c-83ac925a6b44	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 12:13:56.248391+00	
00000000-0000-0000-0000-000000000000	fd756e24-28c6-4b80-bc2e-e3d4beef7bfd	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 12:13:56.250782+00	
00000000-0000-0000-0000-000000000000	342e00a9-0c8f-42b6-88fa-899dd238b97a	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 13:49:16.270564+00	
00000000-0000-0000-0000-000000000000	f9984b2e-42c3-4bb3-9b36-91529022daec	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 13:49:16.275269+00	
00000000-0000-0000-0000-000000000000	d5e7af0c-fa25-4c08-984e-92f5abd4fba6	{"action":"user_confirmation_requested","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-05 14:24:02.560244+00	
00000000-0000-0000-0000-000000000000	51cf5a46-196f-4c10-a1fb-18928b05dccc	{"action":"user_signedup","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-05 14:24:19.444805+00	
00000000-0000-0000-0000-000000000000	4f14c13d-fcc7-425c-9a31-7d443ea5438c	{"action":"login","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 14:24:48.536924+00	
00000000-0000-0000-0000-000000000000	396eb81b-8844-4bb7-8daf-be88f5e8b80d	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:25:03.386852+00	
00000000-0000-0000-0000-000000000000	2a697b78-6377-4e69-9505-dd60e718e38b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:25:03.387444+00	
00000000-0000-0000-0000-000000000000	b893ccd8-d2a2-4d0d-ab5d-813a9e3e8963	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:48:02.327178+00	
00000000-0000-0000-0000-000000000000	2042bb82-0b73-4307-809a-1bb9498ad48c	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:48:02.329921+00	
00000000-0000-0000-0000-000000000000	761de016-a496-44a7-91f9-b0832df94272	{"action":"token_refreshed","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 15:35:52.902218+00	
00000000-0000-0000-0000-000000000000	943291a5-c4b1-4795-8437-4d0638893a7a	{"action":"token_revoked","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 15:35:52.904334+00	
00000000-0000-0000-0000-000000000000	9da9ce43-cafa-4afc-84b1-758e06e20265	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 15:46:51.453002+00	
00000000-0000-0000-0000-000000000000	95aa4026-65da-4c2d-b3e7-8dce3699115d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 15:46:51.455875+00	
00000000-0000-0000-0000-000000000000	8b0d660c-0318-4ad3-9d54-899de5e74a73	{"action":"token_refreshed","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 17:16:18.499055+00	
00000000-0000-0000-0000-000000000000	955bb517-cd88-4fbf-8738-8509a071044e	{"action":"token_revoked","actor_id":"e294a283-3655-4b93-a207-04f486438f37","actor_name":"Federico Montero","actor_username":"federicomontero.e@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 17:16:18.501818+00	
00000000-0000-0000-0000-000000000000	de3c7de2-dbec-408f-aa7c-c2d31164c62c	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:39:45.338125+00	
00000000-0000-0000-0000-000000000000	49766ebc-4280-45ba-b0e8-fc51376eb602	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:39:45.340125+00	
00000000-0000-0000-0000-000000000000	0f0ff70a-3a35-4984-a8ee-d18526cb36cd	{"action":"user_confirmation_requested","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-05 21:49:07.24473+00	
00000000-0000-0000-0000-000000000000	88618f0b-6d53-41af-a94a-441c00e21efc	{"action":"user_signedup","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-05 21:49:31.675636+00	
00000000-0000-0000-0000-000000000000	2809457a-1e8c-463e-9d9e-9b65a230ca44	{"action":"login","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 21:49:43.8222+00	
00000000-0000-0000-0000-000000000000	e8822b54-a38a-4087-99db-d91a928f8983	{"action":"token_refreshed","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:48:25.377027+00	
00000000-0000-0000-0000-000000000000	b45fd637-e4fe-412c-9dfa-5017961f3931	{"action":"token_revoked","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:48:25.378566+00	
00000000-0000-0000-0000-000000000000	8a84ec52-9606-4060-95af-9ed19b454a7b	{"action":"token_refreshed","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:47:25.354716+00	
00000000-0000-0000-0000-000000000000	61ae9c4e-2f11-4000-b99c-1a67a4042dc5	{"action":"token_revoked","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:47:25.355575+00	
00000000-0000-0000-0000-000000000000	9b5ccec2-c2e6-48c3-8641-d366a39acf1f	{"action":"token_refreshed","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:46:21.37577+00	
00000000-0000-0000-0000-000000000000	327cfca0-4e9e-4a8c-8507-0c979c68a028	{"action":"token_revoked","actor_id":"99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92","actor_name":"Josias Perez","actor_username":"josias.arturo.perez@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:46:21.377321+00	
00000000-0000-0000-0000-000000000000	26013c87-b95b-4d79-b0c1-c781fd9af110	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 01:13:29.866592+00	
00000000-0000-0000-0000-000000000000	b5db1e53-f853-4995-87a2-b61a10bfee53	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 01:19:27.578884+00	
00000000-0000-0000-0000-000000000000	c5b645d2-2625-4e76-8c80-52387df64131	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 01:19:27.584048+00	
00000000-0000-0000-0000-000000000000	d3148185-5107-4072-804e-e6b53b60300b	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 02:11:45.960826+00	
00000000-0000-0000-0000-000000000000	2074d3c4-d5dd-4a02-bbb4-4666fcab1704	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 02:11:45.961792+00	
00000000-0000-0000-0000-000000000000	6c8464a5-ca54-45d2-a233-5cd2573869a0	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 02:20:57.910522+00	
00000000-0000-0000-0000-000000000000	669be1f3-3416-46b3-90c5-ab9b063dad8b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 02:20:57.915767+00	
00000000-0000-0000-0000-000000000000	9c401165-38af-4636-8527-59b06c7c3cfd	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 03:10:13.440195+00	
00000000-0000-0000-0000-000000000000	7cfaffe4-d19b-47de-b122-d4ba1942aa0b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 03:10:13.442304+00	
00000000-0000-0000-0000-000000000000	e393398e-92bc-4ae1-af41-0891e24fbe85	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 03:11:22.605283+00	
00000000-0000-0000-0000-000000000000	6cfcbe47-d380-4a60-b5a5-12573f34f47f	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 03:21:32.902608+00	
00000000-0000-0000-0000-000000000000	1f5f681b-c228-4c97-b06d-0ebad59b328a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 03:21:32.906241+00	
00000000-0000-0000-0000-000000000000	3b8ee3c7-c251-4b22-be9f-c6ae970985fc	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 03:55:27.207458+00	
00000000-0000-0000-0000-000000000000	f79761ea-6f38-441d-8ab0-431e8922891b	{"action":"login","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 03:57:11.297362+00	
00000000-0000-0000-0000-000000000000	e4747b37-9655-4d30-b200-398f59c41f26	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 03:57:18.337876+00	
00000000-0000-0000-0000-000000000000	84f3dabb-7a2a-471e-9447-995a5dd45ffb	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:04:29.715862+00	
00000000-0000-0000-0000-000000000000	b54ea148-612f-4645-b2fc-95c449b823d3	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:04:29.722147+00	
00000000-0000-0000-0000-000000000000	2f27915d-46bd-4487-9e2f-80031ee149c0	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:52:17.67886+00	
00000000-0000-0000-0000-000000000000	e06b7be1-0d99-4165-9306-e825a6087e27	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:52:17.681594+00	
00000000-0000-0000-0000-000000000000	c4ccf332-25a6-4196-a2be-de07e76e6230	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 12:35:06.62572+00	
00000000-0000-0000-0000-000000000000	60ce6404-1046-488c-8f18-f36e17c8d3e6	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:05:29.883383+00	
00000000-0000-0000-0000-000000000000	08eac890-1814-49e6-b14b-683691d9f299	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:05:29.886837+00	
00000000-0000-0000-0000-000000000000	f9bd3214-d47a-4e46-a053-a261050721bc	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:07:11.098867+00	
00000000-0000-0000-0000-000000000000	9e9b0e55-8de2-4560-8223-fedefc636d22	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:07:11.10329+00	
00000000-0000-0000-0000-000000000000	5a0eea4f-b5db-45a2-bbc9-85c9dc071a99	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:36:20.266703+00	
00000000-0000-0000-0000-000000000000	65c60d6a-2e02-4c59-8a2a-d0f42418cd59	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 15:36:20.26926+00	
00000000-0000-0000-0000-000000000000	774af80b-f1db-4997-a5b8-d25d5e36e8a3	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:05:20.655701+00	
00000000-0000-0000-0000-000000000000	86953738-33cd-42db-a817-7ab01f3f046d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:05:20.657859+00	
00000000-0000-0000-0000-000000000000	7a107ad5-bae8-4478-9100-6a72e60f7824	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 16:44:30.032016+00	
00000000-0000-0000-0000-000000000000	01a57ce3-25e7-493e-9cf2-4c2cbf237e6d	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 16:47:24.261189+00	
00000000-0000-0000-0000-000000000000	8ef9dde8-0cb8-4a1c-844d-07ccbadcedaa	{"action":"login","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 16:56:39.370516+00	
00000000-0000-0000-0000-000000000000	8ccef071-9b18-4f0f-911c-614d02176cb8	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:23:59.417523+00	
00000000-0000-0000-0000-000000000000	15c66958-5e8c-46ee-a344-e1cbc16c95ba	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:23:59.41922+00	
00000000-0000-0000-0000-000000000000	c4a0e970-fe24-4e21-8b88-788fd7d96e69	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:27:06.685424+00	
00000000-0000-0000-0000-000000000000	63f2e43c-0fd2-4a60-b35f-2dbec6768c4a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:27:06.686956+00	
00000000-0000-0000-0000-000000000000	91a81fbf-ae2f-42b0-97d9-2820942a74b5	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:43:45.15648+00	
00000000-0000-0000-0000-000000000000	3a13e4f8-79c4-45b5-b7f1-53d4976f39e6	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:43:45.158919+00	
00000000-0000-0000-0000-000000000000	f174e9e4-5165-4b3a-a2d7-9ce087e33276	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:46:59.353601+00	
00000000-0000-0000-0000-000000000000	fa3116ad-14de-479d-ae0c-d3c5bd80b5c4	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:46:59.356181+00	
00000000-0000-0000-0000-000000000000	e8648a98-761a-4959-8e9c-8d6775f595c3	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 18:04:49.325471+00	
00000000-0000-0000-0000-000000000000	05e60c73-b77e-44d5-a6cb-825a5ad6e849	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 18:04:49.328246+00	
00000000-0000-0000-0000-000000000000	d80f2c08-0cc9-4659-bf11-78e079b4901e	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 18:05:27.087827+00	
00000000-0000-0000-0000-000000000000	7acf3fef-b842-4878-846f-a818ebb5ea61	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 20:41:30.641843+00	
00000000-0000-0000-0000-000000000000	215e8152-4a68-48be-88cc-81cd309121f8	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 20:41:30.644207+00	
00000000-0000-0000-0000-000000000000	1e0124e5-1fe3-474e-8321-fa493591cc23	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:39:46.380316+00	
00000000-0000-0000-0000-000000000000	4dcab186-fdc0-4553-a7d2-40ae8bee0be5	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:39:46.384908+00	
00000000-0000-0000-0000-000000000000	9a95dc06-c993-4daf-ab32-e8ab7e832d91	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:41:14.423204+00	
00000000-0000-0000-0000-000000000000	81583d12-3281-4b4d-b379-7ca9acba3b9b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:41:14.423985+00	
00000000-0000-0000-0000-000000000000	a0a00eea-6ec7-47e4-b473-fb97985c8de5	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:41:30.198813+00	
00000000-0000-0000-0000-000000000000	c687ef4d-6f31-4c62-9408-d961a624eb9e	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:41:30.200213+00	
00000000-0000-0000-0000-000000000000	a27db39d-7fc2-43f1-9596-c5c4c5296c6f	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:54:29.071942+00	
00000000-0000-0000-0000-000000000000	3d6727fe-b286-4142-9712-07ced4b56ae3	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:54:29.075665+00	
00000000-0000-0000-0000-000000000000	42c5571f-26ed-4138-a130-0743371da291	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 23:44:46.866809+00	
00000000-0000-0000-0000-000000000000	daa5ab7f-13ff-4575-a08d-82a3c5bb08e5	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 23:44:46.87082+00	
00000000-0000-0000-0000-000000000000	705c1e8e-3ee4-4e3c-bd68-e064d211cedd	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 23:44:46.871652+00	
00000000-0000-0000-0000-000000000000	b3b22db0-a3e7-496a-9b33-691a76d099be	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 23:44:46.873728+00	
00000000-0000-0000-0000-000000000000	23a586ff-cd7a-4c42-bc8d-576958fb31b7	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 02:03:04.837335+00	
00000000-0000-0000-0000-000000000000	f4f07b5a-70c1-4a0c-93ff-eeb2e02a533b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 02:03:04.844694+00	
00000000-0000-0000-0000-000000000000	97b8768d-17ff-44ff-b18b-5196767ce450	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 02:03:09.350657+00	
00000000-0000-0000-0000-000000000000	c44307ec-254d-40ad-bdc8-f99d7bede229	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 02:06:06.407146+00	
00000000-0000-0000-0000-000000000000	33d7ccd9-65b6-485d-a198-8848957aed67	{"action":"user_confirmation_requested","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-07 02:57:33.525609+00	
00000000-0000-0000-0000-000000000000	c5aedaba-8964-4ae7-9972-36d77a4c613e	{"action":"user_confirmation_requested","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-07 02:58:33.70265+00	
00000000-0000-0000-0000-000000000000	d54ca2c8-0bb6-4c1c-bc19-2caa36bc3c11	{"action":"user_confirmation_requested","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-07 03:01:25.444864+00	
00000000-0000-0000-0000-000000000000	42e61446-6493-4e5d-a394-1b634caa2dfa	{"action":"user_signedup","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-07 03:01:43.037722+00	
00000000-0000-0000-0000-000000000000	f85d60a7-ad56-4ae0-ad61-f0f0d09dc576	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 03:02:22.407768+00	
00000000-0000-0000-0000-000000000000	37fd4255-a189-4027-81ba-b68cd3239cf7	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 03:02:22.408408+00	
00000000-0000-0000-0000-000000000000	e62268c1-649d-4276-9c39-3b8dfe0b2ccd	{"action":"login","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 03:02:31.253633+00	
00000000-0000-0000-0000-000000000000	ea4a5008-34ad-41c8-a1c0-4d2c800d4b07	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 03:04:10.414094+00	
00000000-0000-0000-0000-000000000000	f90d4f56-e918-4dd3-b67d-fb8351619694	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 03:04:10.415636+00	
00000000-0000-0000-0000-000000000000	80b1fc95-ab14-4a1c-81c6-f6b2fb7b23cf	{"action":"logout","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-07 03:13:13.407567+00	
00000000-0000-0000-0000-000000000000	967deb8e-08d3-4684-bc75-00cdc6f181f5	{"action":"login","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 03:13:17.962281+00	
00000000-0000-0000-0000-000000000000	38a45be2-8d3b-4175-93df-2610f12a7455	{"action":"logout","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-07 03:18:15.529476+00	
00000000-0000-0000-0000-000000000000	de8917f1-8f8c-432d-9123-81c29f20b79f	{"action":"login","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 03:18:23.365357+00	
00000000-0000-0000-0000-000000000000	17f80730-573e-43d5-86a1-2504d1b02252	{"action":"logout","actor_id":"a09cd383-3c5a-4f9f-8c5a-036761a96873","actor_name":"Joan Karl","actor_username":"jccontin@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-07 03:36:42.294799+00	
00000000-0000-0000-0000-000000000000	e976cd58-0a22-4060-ade3-4bb852543da4	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:01:11.244836+00	
00000000-0000-0000-0000-000000000000	edbd0cd4-6e93-47e9-be60-8cd60f31ef12	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:01:11.246322+00	
00000000-0000-0000-0000-000000000000	e8059458-b4d4-4bf6-bdc3-b9cf6f640b2c	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:23:59.968622+00	
00000000-0000-0000-0000-000000000000	62db4d86-9e2f-460c-9855-4217d088075e	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:23:59.971767+00	
00000000-0000-0000-0000-000000000000	00a9efbd-b440-4684-9d12-02929d847e5c	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:24:17.837126+00	
00000000-0000-0000-0000-000000000000	5cfdd983-a6d4-4b72-af21-5ffedc07c134	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 04:24:17.837836+00	
00000000-0000-0000-0000-000000000000	69971a71-d0d5-46b9-800d-27d0b8085888	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 04:37:05.261268+00	
00000000-0000-0000-0000-000000000000	14b2301e-9201-46b1-87f5-70f0de5d012b	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 05:16:41.902801+00	
00000000-0000-0000-0000-000000000000	51664b6e-a4ba-47f1-af02-2cb0426d0402	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 05:16:41.904477+00	
00000000-0000-0000-0000-000000000000	400b37fd-fba2-4114-8062-168f68e76715	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:55:21.092406+00	
00000000-0000-0000-0000-000000000000	7e6016ea-0f13-47aa-8310-c444f41df47f	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:55:21.109866+00	
00000000-0000-0000-0000-000000000000	21d26c5f-8f3f-44f2-a6bc-9b6b3a27d810	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 15:54:04.451854+00	
00000000-0000-0000-0000-000000000000	096ccb15-b7b6-4fc8-9792-49ff7cb0d682	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 15:54:04.457299+00	
00000000-0000-0000-0000-000000000000	e3ef86d1-a3ab-42aa-b4ae-25e72662ea05	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 17:07:03.117025+00	
00000000-0000-0000-0000-000000000000	e5a3090d-b394-4ea7-b8ad-bc2d2b9f664a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 17:07:03.120294+00	
00000000-0000-0000-0000-000000000000	bfd60a9d-0302-480f-a34e-0a12a1d0fd39	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:10:58.686032+00	
00000000-0000-0000-0000-000000000000	0ce3d706-2a63-45c3-8b81-bb975f4df87a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:10:58.689353+00	
00000000-0000-0000-0000-000000000000	691494af-59a1-42e1-948f-980c93a54510	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 19:09:49.733991+00	
00000000-0000-0000-0000-000000000000	63b29e2d-98d8-447b-a056-92a29fb65777	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 19:09:49.737056+00	
00000000-0000-0000-0000-000000000000	522838ee-f492-4cd6-ad43-cba931cd2b7a	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:15:16.687567+00	
00000000-0000-0000-0000-000000000000	a27bbe2a-7080-49d5-b477-b4f1606ded1a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:15:16.691006+00	
00000000-0000-0000-0000-000000000000	c6b1efc1-7b1f-40cd-badf-27b2801e22db	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 21:16:31.135871+00	
00000000-0000-0000-0000-000000000000	ec4646ce-2559-4f3f-a855-29ad9a40122a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 21:16:31.138104+00	
00000000-0000-0000-0000-000000000000	207f2f35-847e-4a8f-8a1a-a60d498f3c10	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:15:30.028408+00	
00000000-0000-0000-0000-000000000000	df8b3050-06f3-4a4f-9a7c-a458dbf6739a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:15:30.031854+00	
00000000-0000-0000-0000-000000000000	3e676413-d084-4b19-8f22-507e2cda1989	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:39:31.05801+00	
00000000-0000-0000-0000-000000000000	c687a339-d8ac-4004-9208-88e1b697a49f	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:39:31.062172+00	
00000000-0000-0000-0000-000000000000	abf558fa-6f39-4155-9ca4-8bd9a35ffeaa	{"action":"login","actor_id":"e953b9ba-10a2-4efe-a8c6-f89590cbda92","actor_name":"Ruth Esther Santana de Noel","actor_username":"ruth5525@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-07 23:43:21.705545+00	
00000000-0000-0000-0000-000000000000	0f3548e1-8acc-458e-8516-b402c3ec4e3a	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:57:30.323694+00	
00000000-0000-0000-0000-000000000000	1164378d-4a5f-407a-aab5-7c1093092613	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:57:30.326637+00	
00000000-0000-0000-0000-000000000000	fbb610bf-9529-43eb-84b9-e5bbf84285aa	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 00:38:08.318176+00	
00000000-0000-0000-0000-000000000000	1f500b1d-7142-4fb4-9d46-ae7aa8288f95	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 00:38:08.321202+00	
00000000-0000-0000-0000-000000000000	56b1e7e9-4803-49e2-8c9c-5490ba3626e2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 01:36:44.969332+00	
00000000-0000-0000-0000-000000000000	a47c4662-cdb5-410d-b096-9dd9f7c252ed	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 01:36:44.972808+00	
00000000-0000-0000-0000-000000000000	e1c4ccaf-453c-4bed-8555-9ca112b4a413	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 02:47:35.473567+00	
00000000-0000-0000-0000-000000000000	876ed951-057d-4352-bf4d-e390640d8e35	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 02:47:35.480284+00	
00000000-0000-0000-0000-000000000000	068e8111-9c00-4d44-825c-daec3f58c033	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 03:46:29.963355+00	
00000000-0000-0000-0000-000000000000	cccfbe7a-d02c-4255-9bf7-69048dfc558f	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 03:46:29.967927+00	
00000000-0000-0000-0000-000000000000	8f211d31-31cb-423a-83b6-bd6396fa11bf	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 06:24:27.589035+00	
00000000-0000-0000-0000-000000000000	32cd6655-4485-4c6d-9332-dcbbdcc62c7b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 06:24:27.592522+00	
00000000-0000-0000-0000-000000000000	813722aa-11c0-4a53-a15b-83fd47012818	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 08:11:56.541062+00	
00000000-0000-0000-0000-000000000000	67b6d964-4b5f-42da-bda6-518db35083bc	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 08:11:56.547201+00	
00000000-0000-0000-0000-000000000000	4c6a9bb1-ee6a-411c-a2fd-0d3979e471c6	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:30:00.209437+00	
00000000-0000-0000-0000-000000000000	164f4f56-12fb-4c9e-9f3d-1aef74eee4f4	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:30:00.23923+00	
00000000-0000-0000-0000-000000000000	d782b57a-3a51-402b-affd-8ae43fe42fec	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:30:17.407104+00	
00000000-0000-0000-0000-000000000000	e26c18bb-d186-4123-a914-766d0209447d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:30:17.40771+00	
00000000-0000-0000-0000-000000000000	ba07ac4d-333c-468b-9551-ffae6eb31fda	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:34:42.119466+00	
00000000-0000-0000-0000-000000000000	fa5f59bc-b6c7-4a94-a74d-0239091f3486	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 20:34:42.124473+00	
00000000-0000-0000-0000-000000000000	167a5228-77f5-4f1b-aba3-d3563b724584	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 22:34:13.668603+00	
00000000-0000-0000-0000-000000000000	c9eed7dc-1b5d-41d5-b72b-fb1fdd109efc	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 22:34:13.67257+00	
00000000-0000-0000-0000-000000000000	1f3ae953-cc86-4a7d-9224-387a7a6f1e23	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 00:54:14.486136+00	
00000000-0000-0000-0000-000000000000	d00f1de0-8c55-4820-b445-7402b1d8441d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 00:54:14.493934+00	
00000000-0000-0000-0000-000000000000	10cc58fb-84fc-49fe-8491-c9f2a9fb5a31	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 01:59:00.812521+00	
00000000-0000-0000-0000-000000000000	911c4e9a-4d99-4ddc-b7d4-227652a98881	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 01:59:00.814224+00	
00000000-0000-0000-0000-000000000000	dff4aec6-265d-40be-9afd-ea3e205244f2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 02:17:22.360851+00	
00000000-0000-0000-0000-000000000000	abbe5bbf-84d8-429b-81f9-a6dc9691160d	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 02:17:22.365275+00	
00000000-0000-0000-0000-000000000000	7af3d9a6-17c9-4f85-ab64-95ce002ab69b	{"action":"user_confirmation_requested","actor_id":"131c625c-8329-48ce-9b74-67991bd070fd","actor_name":"Franklin Moises Alcantara Miranda","actor_username":"f.alcantara2103@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-09 02:28:40.592344+00	
00000000-0000-0000-0000-000000000000	3f1b036d-fb9a-4a70-9e3d-a107113fb044	{"action":"user_signedup","actor_id":"131c625c-8329-48ce-9b74-67991bd070fd","actor_name":"Franklin Moises Alcantara Miranda","actor_username":"f.alcantara2103@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-09 02:28:54.972366+00	
00000000-0000-0000-0000-000000000000	1cef8d38-b610-47fa-93ad-4a5c621d2119	{"action":"login","actor_id":"131c625c-8329-48ce-9b74-67991bd070fd","actor_name":"Franklin Moises Alcantara Miranda","actor_username":"f.alcantara2103@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 02:29:09.323022+00	
00000000-0000-0000-0000-000000000000	61ae771c-9cf3-4148-a129-5ec8ea3d5f20	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-09 02:57:45.627607+00	
00000000-0000-0000-0000-000000000000	ddd3f31d-19e2-49e9-8977-15304214c365	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 02:57:52.30611+00	
00000000-0000-0000-0000-000000000000	43a50076-05e7-4117-81db-720eb0ad1a94	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 13:23:59.94264+00	
00000000-0000-0000-0000-000000000000	4b17c7fa-3b8a-4f8f-986a-638bc2a3b453	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 21:24:07.321504+00	
00000000-0000-0000-0000-000000000000	842a2335-af34-4e1a-b197-f7f9852d95ed	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 21:24:07.33563+00	
00000000-0000-0000-0000-000000000000	f7d80bb7-bbaa-4db1-9ce4-58156b2870ac	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 23:16:25.249068+00	
00000000-0000-0000-0000-000000000000	cdec47d9-1043-4df0-9bbc-d48319e4287a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 23:16:25.254878+00	
00000000-0000-0000-0000-000000000000	026f2838-6190-47ca-a7ce-80ad0e3beaf1	{"action":"user_confirmation_requested","actor_id":"1b74f74e-07fb-492f-87e3-c90f2f64a4fe","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-10 14:28:24.329418+00	
00000000-0000-0000-0000-000000000000	5197652f-db09-4972-9f60-9abf6f703d4c	{"action":"user_signedup","actor_id":"1b74f74e-07fb-492f-87e3-c90f2f64a4fe","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-10 14:28:46.879989+00	
00000000-0000-0000-0000-000000000000	276e09a9-e6b7-4015-a6dc-e2072f42ab19	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 14:36:52.5055+00	
00000000-0000-0000-0000-000000000000	acc171a2-f2e2-4bb7-bcd9-3e9e06d32df4	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 14:50:23.895848+00	
00000000-0000-0000-0000-000000000000	9965b2a7-2b92-45ee-9cc6-07eefcebe91e	{"action":"user_confirmation_requested","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-10 14:50:48.346065+00	
00000000-0000-0000-0000-000000000000	7d61d600-c7c7-4fd5-9ce7-85d9cdf398b2	{"action":"user_signedup","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-10 14:51:19.430715+00	
00000000-0000-0000-0000-000000000000	35080b58-2cc5-4ac1-a87d-4a08ed663616	{"action":"user_recovery_requested","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-10 14:53:58.375696+00	
00000000-0000-0000-0000-000000000000	1b805d78-bdd2-45fc-8964-ae0c383314d0	{"action":"login","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 14:54:33.682696+00	
00000000-0000-0000-0000-000000000000	4d1c37fa-144d-4c92-a529-7ee118c0ca6d	{"action":"user_recovery_requested","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-10 14:59:32.635569+00	
00000000-0000-0000-0000-000000000000	fc46d59b-ce05-445f-a332-695f9b30c6ee	{"action":"login","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 15:00:05.570925+00	
00000000-0000-0000-0000-000000000000	ec6c2dec-c3b2-4a9e-961f-05bffb6a34d2	{"action":"login","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 15:19:21.085439+00	
00000000-0000-0000-0000-000000000000	47df8d55-01fa-4a6d-b4a1-f190f06da7b2	{"action":"user_updated_password","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-10 15:19:46.761893+00	
00000000-0000-0000-0000-000000000000	933bcb9e-21a3-41e9-8d29-6255af5b6136	{"action":"user_modified","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-10 15:19:46.762569+00	
00000000-0000-0000-0000-000000000000	b328f203-188f-4b50-afb0-4f8c156f154d	{"action":"logout","actor_id":"90c55ddd-5f1c-46d1-a7a3-1e5fe82e484e","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 15:20:51.46196+00	
00000000-0000-0000-0000-000000000000	902aba29-e06a-43cc-9552-dfc0d4bead09	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 15:23:54.965898+00	
00000000-0000-0000-0000-000000000000	539b6355-bbf1-45fe-a243-98bbe6ba8cbb	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 15:38:19.649505+00	
00000000-0000-0000-0000-000000000000	2a044700-0c2d-498c-b98b-45d164cc39be	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 15:42:32.529442+00	
00000000-0000-0000-0000-000000000000	18d939fb-b68a-4264-9e7e-d2c483111c04	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 15:45:59.926145+00	
00000000-0000-0000-0000-000000000000	dc0c9ae9-70ce-4b29-a5e6-2dca2eda8641	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 15:47:14.635081+00	
00000000-0000-0000-0000-000000000000	2a80ba58-0b1a-47d4-aa96-2afca2f16413	{"action":"user_confirmation_requested","actor_id":"a49c84ef-bb13-4e11-8bc5-e40a20403635","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-10 15:47:39.292642+00	
00000000-0000-0000-0000-000000000000	908123e1-f28b-4b83-a282-a24c661368da	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"armandonoel01@gmail.com","user_id":"a49c84ef-bb13-4e11-8bc5-e40a20403635","user_phone":""}}	2025-07-10 16:10:37.237393+00	
00000000-0000-0000-0000-000000000000	ea4871a7-f699-48fd-b4bb-a475c751cfdd	{"action":"user_signedup","actor_id":"ba58b1a4-2308-4cc9-a741-3a0c579d6b86","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-10 16:10:54.885287+00	
00000000-0000-0000-0000-000000000000	ffb5894c-1e50-47ad-9eca-cec617b045a3	{"action":"login","actor_id":"ba58b1a4-2308-4cc9-a741-3a0c579d6b86","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 16:10:54.888982+00	
00000000-0000-0000-0000-000000000000	795d3667-d1dc-48ae-af10-00ffa66dd129	{"action":"login","actor_id":"ba58b1a4-2308-4cc9-a741-3a0c579d6b86","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 16:11:09.151001+00	
00000000-0000-0000-0000-000000000000	cacb5c06-2487-46d6-88b8-dfe808a821ed	{"action":"logout","actor_id":"ba58b1a4-2308-4cc9-a741-3a0c579d6b86","actor_name":"Armando Noel","actor_username":"armandonoel01@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-10 16:12:58.324555+00	
00000000-0000-0000-0000-000000000000	ccf73b1e-25df-4f01-93f5-a787c6128107	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-10 16:13:08.224195+00	
00000000-0000-0000-0000-000000000000	17218f2f-e7ae-49bd-aa27-4b739d39e4a2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 17:30:42.733001+00	
00000000-0000-0000-0000-000000000000	25e615ad-7226-4bab-a906-62551591596a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 17:30:42.737137+00	
00000000-0000-0000-0000-000000000000	2ba134c2-9d12-46af-80c9-9f905278cf3a	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 18:52:33.5824+00	
00000000-0000-0000-0000-000000000000	f2536b92-8366-4fdb-b547-d0b42f3f6112	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 18:52:33.586179+00	
00000000-0000-0000-0000-000000000000	3bc1e451-1b00-4337-95ac-dfaf2966e253	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-11 03:05:48.487213+00	
00000000-0000-0000-0000-000000000000	8fb3b85b-9e3a-4b31-9d01-bc34e96121b6	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 03:22:02.712961+00	
00000000-0000-0000-0000-000000000000	bcdd16fb-f514-464f-8318-86360974d8b1	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 03:22:02.716221+00	
00000000-0000-0000-0000-000000000000	62508f3d-0149-4067-a094-1ab5f17d6862	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 04:04:06.669363+00	
00000000-0000-0000-0000-000000000000	0f6c228f-4afa-443b-9cf7-556815511e05	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 04:04:06.674175+00	
00000000-0000-0000-0000-000000000000	139ddde2-3788-4d48-ae99-4ffa78fdf47c	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 04:20:04.778706+00	
00000000-0000-0000-0000-000000000000	a7724c13-ff9e-44f0-8c0e-158f8a199e46	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 04:20:04.780868+00	
00000000-0000-0000-0000-000000000000	7ab1d745-75e9-4c0c-9e4e-d1cae743e043	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 06:45:28.103156+00	
00000000-0000-0000-0000-000000000000	63e3dc73-1c43-48d1-9fd4-737212ea1caa	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 06:45:28.112713+00	
00000000-0000-0000-0000-000000000000	c223e1e2-c0fd-4d47-ba70-6059a3cbe3fa	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 12:12:18.655285+00	
00000000-0000-0000-0000-000000000000	cd06e04d-7ae2-4e6c-a04d-7593a904c7f5	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 12:12:18.658765+00	
00000000-0000-0000-0000-000000000000	101f2c9c-9def-4cd5-8e9c-e23bee4a50da	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 12:15:09.368117+00	
00000000-0000-0000-0000-000000000000	99da147e-9505-4675-bfc1-9bf5fd7e8ad8	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 12:15:09.37251+00	
00000000-0000-0000-0000-000000000000	20ffb0a6-333b-4cf2-9698-cec102e60a48	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:36:34.925436+00	
00000000-0000-0000-0000-000000000000	27690e0a-9e3b-43e4-9607-efacb31e9cd4	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:36:34.932932+00	
00000000-0000-0000-0000-000000000000	73d7b7d0-2059-4d43-803a-7d6677734902	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:50:45.834692+00	
00000000-0000-0000-0000-000000000000	e9f8b69f-bb93-46e8-883e-8d9dc3868d8f	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:50:45.837674+00	
00000000-0000-0000-0000-000000000000	3bcf0f95-435d-4f30-a424-b40aab4fe7f5	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:43:13.629134+00	
00000000-0000-0000-0000-000000000000	602babe4-c150-4f73-b011-1d0ef521419e	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:43:13.632512+00	
00000000-0000-0000-0000-000000000000	284b0bd4-490c-4e42-b129-63b4861edbdb	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 01:58:49.957089+00	
00000000-0000-0000-0000-000000000000	a4c96d3b-438b-42a7-8aaa-3489f9201c0a	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 01:58:49.960402+00	
00000000-0000-0000-0000-000000000000	886bf38b-8829-408e-bdda-5d5892438cf2	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 01:59:12.313319+00	
00000000-0000-0000-0000-000000000000	16927310-0f86-4b22-afce-b2f8434d51c8	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 01:59:12.313989+00	
00000000-0000-0000-0000-000000000000	6cc4c8d2-5aaa-4552-af06-beb4e733cf2b	{"action":"logout","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account"}	2025-07-12 02:13:43.87053+00	
00000000-0000-0000-0000-000000000000	90940417-fc98-4101-a4d7-70007089652b	{"action":"login","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 02:15:05.579611+00	
00000000-0000-0000-0000-000000000000	86c72555-f61d-4e2b-a985-72fdddfde48f	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:02:32.534327+00	
00000000-0000-0000-0000-000000000000	21e46422-fb9c-4351-9bfe-c01900f69b1b	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:02:32.542783+00	
00000000-0000-0000-0000-000000000000	dd3f9239-5493-4079-8c5d-9a412658de60	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 15:36:06.744897+00	
00000000-0000-0000-0000-000000000000	dd99e946-766f-41f5-841d-87fcd5c259a3	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 15:36:06.750364+00	
00000000-0000-0000-0000-000000000000	8f1cadee-01bf-4234-9107-eb24e14e537e	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 16:34:17.003284+00	
00000000-0000-0000-0000-000000000000	ac5d78e3-ebe6-486d-944a-86596f5e72c9	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 16:34:17.01075+00	
00000000-0000-0000-0000-000000000000	8e69a733-f03e-4802-a9b0-32a9c8e38fe4	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 17:41:47.976781+00	
00000000-0000-0000-0000-000000000000	afbf009e-db93-4f30-aa90-879e6c95a144	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 17:41:47.9808+00	
00000000-0000-0000-0000-000000000000	a6c736b7-6385-44ee-8dab-12c1146d2523	{"action":"token_refreshed","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 18:57:01.047224+00	
00000000-0000-0000-0000-000000000000	b97bc9bf-ad38-4a4a-b5e4-681f1348e2f4	{"action":"token_revoked","actor_id":"51d869f4-fa16-4633-9121-561817fce43d","actor_name":"Armando Noel Charle","actor_username":"armandonoel@outlook.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 18:57:01.050286+00	
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
51d869f4-fa16-4633-9121-561817fce43d	51d869f4-fa16-4633-9121-561817fce43d	{"sub": "51d869f4-fa16-4633-9121-561817fce43d", "email": "armandonoel@outlook.com", "phone": "8298026640", "full_name": "Armando Noel Charle", "email_verified": true, "phone_verified": false}	email	2025-06-15 01:55:41.072979+00	2025-06-15 01:55:41.073041+00	2025-06-15 01:55:41.073041+00	9a7a28b0-3ad2-4b6b-97f7-823dcd15499c
e953b9ba-10a2-4efe-a8c6-f89590cbda92	e953b9ba-10a2-4efe-a8c6-f89590cbda92	{"sub": "e953b9ba-10a2-4efe-a8c6-f89590cbda92", "email": "ruth5525@gmail.com", "phone": "8492128259", "full_name": "Ruth Esther Santana de Noel", "email_verified": true, "phone_verified": false}	email	2025-07-05 03:31:12.163346+00	2025-07-05 03:31:12.16341+00	2025-07-05 03:31:12.16341+00	b42dcba8-b3ff-428d-95a7-9531af9d782a
e294a283-3655-4b93-a207-04f486438f37	e294a283-3655-4b93-a207-04f486438f37	{"sub": "e294a283-3655-4b93-a207-04f486438f37", "email": "federicomontero.e@gmail.com", "phone": "8099198851", "full_name": "Federico Montero", "email_verified": true, "phone_verified": false}	email	2025-07-05 14:24:02.554828+00	2025-07-05 14:24:02.554882+00	2025-07-05 14:24:02.554882+00	bc9baf97-b644-4466-aa89-82ac55ae4da9
99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	{"sub": "99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92", "email": "josias.arturo.perez@gmail.com", "phone": "8098028341", "full_name": "Josias Perez", "email_verified": true, "phone_verified": false}	email	2025-07-05 21:49:07.237921+00	2025-07-05 21:49:07.237984+00	2025-07-05 21:49:07.237984+00	f5c7e801-5a12-498e-9c22-4157a9251e52
a09cd383-3c5a-4f9f-8c5a-036761a96873	a09cd383-3c5a-4f9f-8c5a-036761a96873	{"sub": "a09cd383-3c5a-4f9f-8c5a-036761a96873", "email": "jccontin@gmail.com", "phone": "", "full_name": "Joan Karl", "email_verified": true, "phone_verified": false}	email	2025-07-07 02:57:33.519892+00	2025-07-07 02:57:33.519945+00	2025-07-07 02:57:33.519945+00	6b9d7791-698a-4227-835c-44d6966d7ca8
131c625c-8329-48ce-9b74-67991bd070fd	131c625c-8329-48ce-9b74-67991bd070fd	{"sub": "131c625c-8329-48ce-9b74-67991bd070fd", "email": "f.alcantara2103@gmail.com", "phone": "8493570321", "full_name": "Franklin Moises Alcantara Miranda", "email_verified": true, "phone_verified": false}	email	2025-07-09 02:28:40.58677+00	2025-07-09 02:28:40.58683+00	2025-07-09 02:28:40.58683+00	f1021d88-f517-4103-80e3-729773b92ce2
ba58b1a4-2308-4cc9-a741-3a0c579d6b86	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	{"sub": "ba58b1a4-2308-4cc9-a741-3a0c579d6b86", "email": "armandonoel01@gmail.com", "phone": "8099990000", "full_name": "Armando Noel", "email_verified": false, "phone_verified": false}	email	2025-07-10 16:10:54.881502+00	2025-07-10 16:10:54.881558+00	2025-07-10 16:10:54.881558+00	9e5fc3a0-1086-465a-a3cf-018c29bc1188
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
239dd0c0-1cb3-4f92-a926-d2aef82d654e	2025-07-05 03:32:34.063761+00	2025-07-05 03:32:34.063761+00	otp	a93fe950-b56b-4f98-903b-02bb5d3064e2
de536db3-9e81-4820-a66b-579171acd07f	2025-07-05 03:32:40.180034+00	2025-07-05 03:32:40.180034+00	password	a7820cac-4025-405a-8b5c-089b3d722462
b157f07e-4ba2-4a7e-bf00-10d54a13e174	2025-07-05 04:00:50.990662+00	2025-07-05 04:00:50.990662+00	password	c2462ebc-265e-434e-8d8a-5e73d299ad59
41abdb35-68bc-47b4-83d3-cde60c7220a0	2025-07-05 14:24:19.45347+00	2025-07-05 14:24:19.45347+00	otp	441ca531-aaf4-4510-933b-f0986c32e3a8
c6bb9cad-4060-4090-8170-ba009e7f6d10	2025-07-05 14:24:48.540603+00	2025-07-05 14:24:48.540603+00	password	fd2f5912-447c-4db4-b2d7-7a9b42b49f59
4a03d6d2-8f14-448a-b3b2-8d432a83f808	2025-07-05 21:49:31.700983+00	2025-07-05 21:49:31.700983+00	otp	70897f06-a248-4f2d-8a1a-00b21c56585d
06a65e41-0d82-456d-b2e4-8dd9387ed063	2025-07-05 21:49:43.825601+00	2025-07-05 21:49:43.825601+00	password	1cc96493-b9a9-404a-9b7c-3f1e061deea5
dc8c9881-a930-4d67-803f-79b881b208b1	2025-07-06 03:57:11.306498+00	2025-07-06 03:57:11.306498+00	password	5cd25661-c093-4eac-bfbe-b863fb6ff48d
b8ae971a-46db-4df3-aef5-7ebe38989282	2025-07-06 16:56:39.38163+00	2025-07-06 16:56:39.38163+00	password	edcd6634-8f32-465d-956f-2bfc189d1ea9
d0f69537-b0bd-44d8-905c-670fc9097d46	2025-07-07 23:43:21.732627+00	2025-07-07 23:43:21.732627+00	password	c6b1fd6e-6712-4902-9160-7cd278483c69
61db16e4-3d85-44b3-abe2-174eeb57b1e9	2025-07-09 02:28:54.989315+00	2025-07-09 02:28:54.989315+00	otp	780faa04-fa60-4f66-a71a-ef001d7fac1c
8289e546-f5ae-43c4-8154-341af8de1bfd	2025-07-09 02:29:09.326445+00	2025-07-09 02:29:09.326445+00	password	0200ac4c-f7c1-4939-81fa-ff3f224c7f72
934596ee-99b1-4197-9c24-ce1356f308af	2025-07-12 02:15:05.593022+00	2025-07-12 02:15:05.593022+00	password	2d3ae660-9d5d-42ba-abd6-b3fd1d6849fe
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
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
00000000-0000-0000-0000-000000000000	75	3uatjh6dmekg	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-05 04:00:50.98923+00	2025-07-05 04:00:50.98923+00	\N	b157f07e-4ba2-4a7e-bf00-10d54a13e174
00000000-0000-0000-0000-000000000000	83	4unwdxiaqxhg	e294a283-3655-4b93-a207-04f486438f37	f	2025-07-05 14:24:19.451604+00	2025-07-05 14:24:19.451604+00	\N	41abdb35-68bc-47b4-83d3-cde60c7220a0
00000000-0000-0000-0000-000000000000	84	fcwmyctzfmg4	e294a283-3655-4b93-a207-04f486438f37	t	2025-07-05 14:24:48.538576+00	2025-07-05 15:35:52.90486+00	\N	c6bb9cad-4060-4090-8170-ba009e7f6d10
00000000-0000-0000-0000-000000000000	87	yrwsdwbsfrlj	e294a283-3655-4b93-a207-04f486438f37	t	2025-07-05 15:35:52.906198+00	2025-07-05 17:16:18.502398+00	fcwmyctzfmg4	c6bb9cad-4060-4090-8170-ba009e7f6d10
00000000-0000-0000-0000-000000000000	89	3bdos2jdrzid	e294a283-3655-4b93-a207-04f486438f37	f	2025-07-05 17:16:18.50424+00	2025-07-05 17:16:18.50424+00	yrwsdwbsfrlj	c6bb9cad-4060-4090-8170-ba009e7f6d10
00000000-0000-0000-0000-000000000000	91	tgg5lb5rf4tq	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	f	2025-07-05 21:49:31.689171+00	2025-07-05 21:49:31.689171+00	\N	4a03d6d2-8f14-448a-b3b2-8d432a83f808
00000000-0000-0000-0000-000000000000	92	st3ceibu3pjo	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	t	2025-07-05 21:49:43.824427+00	2025-07-05 22:48:25.379129+00	\N	06a65e41-0d82-456d-b2e4-8dd9387ed063
00000000-0000-0000-0000-000000000000	199	beclx7kc2ofg	51d869f4-fa16-4633-9121-561817fce43d	t	2025-07-12 13:02:32.551973+00	2025-07-12 15:36:06.750927+00	zr7tjq57dpkq	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	93	nqkpapbaslt3	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	t	2025-07-05 22:48:25.381928+00	2025-07-05 23:47:25.356205+00	st3ceibu3pjo	06a65e41-0d82-456d-b2e4-8dd9387ed063
00000000-0000-0000-0000-000000000000	94	ithpg2bwch4v	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	t	2025-07-05 23:47:25.357627+00	2025-07-06 00:46:21.377913+00	nqkpapbaslt3	06a65e41-0d82-456d-b2e4-8dd9387ed063
00000000-0000-0000-0000-000000000000	95	hkd5u6wmzi6h	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	f	2025-07-06 00:46:21.378597+00	2025-07-06 00:46:21.378597+00	ithpg2bwch4v	06a65e41-0d82-456d-b2e4-8dd9387ed063
00000000-0000-0000-0000-000000000000	201	lbfncmrmm7pw	51d869f4-fa16-4633-9121-561817fce43d	t	2025-07-12 16:34:17.016342+00	2025-07-12 17:41:47.981452+00	kxtm6sddinqz	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	203	2rpqcf6sbzee	51d869f4-fa16-4633-9121-561817fce43d	f	2025-07-12 18:57:01.052656+00	2025-07-12 18:57:01.052656+00	2f55mvby555y	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	104	5ma26vtjinb4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-06 03:57:11.303056+00	2025-07-06 03:57:11.303056+00	\N	dc8c9881-a930-4d67-803f-79b881b208b1
00000000-0000-0000-0000-000000000000	71	tnscg2iff5qf	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-05 03:32:34.061779+00	2025-07-05 03:32:34.061779+00	\N	239dd0c0-1cb3-4f92-a926-d2aef82d654e
00000000-0000-0000-0000-000000000000	72	xki3jwwjpmu3	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-05 03:32:40.178852+00	2025-07-05 03:32:40.178852+00	\N	de536db3-9e81-4820-a66b-579171acd07f
00000000-0000-0000-0000-000000000000	115	jr4vws6lfl5g	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-06 16:56:39.377517+00	2025-07-06 16:56:39.377517+00	\N	b8ae971a-46db-4df3-aef5-7ebe38989282
00000000-0000-0000-0000-000000000000	166	d3qexytq64qi	131c625c-8329-48ce-9b74-67991bd070fd	f	2025-07-09 02:28:54.984587+00	2025-07-09 02:28:54.984587+00	\N	61db16e4-3d85-44b3-abe2-174eeb57b1e9
00000000-0000-0000-0000-000000000000	167	z5w7r4w6rnry	131c625c-8329-48ce-9b74-67991bd070fd	f	2025-07-09 02:29:09.325165+00	2025-07-09 02:29:09.325165+00	\N	8289e546-f5ae-43c4-8154-341af8de1bfd
00000000-0000-0000-0000-000000000000	198	zr7tjq57dpkq	51d869f4-fa16-4633-9121-561817fce43d	t	2025-07-12 02:15:05.589894+00	2025-07-12 13:02:32.54579+00	\N	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	200	kxtm6sddinqz	51d869f4-fa16-4633-9121-561817fce43d	t	2025-07-12 15:36:06.756104+00	2025-07-12 16:34:17.01261+00	beclx7kc2ofg	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	202	2f55mvby555y	51d869f4-fa16-4633-9121-561817fce43d	t	2025-07-12 17:41:47.983461+00	2025-07-12 18:57:01.051044+00	lbfncmrmm7pw	934596ee-99b1-4197-9c24-ce1356f308af
00000000-0000-0000-0000-000000000000	151	facjdycxdem3	e953b9ba-10a2-4efe-a8c6-f89590cbda92	f	2025-07-07 23:43:21.72442+00	2025-07-07 23:43:21.72442+00	\N	d0f69537-b0bd-44d8-905c-670fc9097d46
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
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
934596ee-99b1-4197-9c24-ce1356f308af	51d869f4-fa16-4633-9121-561817fce43d	2025-07-12 02:15:05.588044+00	2025-07-12 18:57:01.060496+00	\N	aal1	\N	2025-07-12 18:57:01.059763	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0	190.166.100.41	\N
dc8c9881-a930-4d67-803f-79b881b208b1	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-06 03:57:11.300239+00	2025-07-06 03:57:11.300239+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	179.53.75.190	\N
41abdb35-68bc-47b4-83d3-cde60c7220a0	e294a283-3655-4b93-a207-04f486438f37	2025-07-05 14:24:19.449485+00	2025-07-05 14:24:19.449485+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15	104.28.32.57	\N
c6bb9cad-4060-4090-8170-ba009e7f6d10	e294a283-3655-4b93-a207-04f486438f37	2025-07-05 14:24:48.537802+00	2025-07-05 17:16:18.507539+00	\N	aal1	\N	2025-07-05 17:16:18.507466	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15	104.28.32.57	\N
4a03d6d2-8f14-448a-b3b2-8d432a83f808	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	2025-07-05 21:49:31.682838+00	2025-07-05 21:49:31.682838+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0	152.166.28.168	\N
239dd0c0-1cb3-4f92-a926-d2aef82d654e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-05 03:32:34.060183+00	2025-07-05 03:32:34.060183+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/138.0.7204.119 Mobile/15E148 Safari/604.1	152.166.149.83	\N
de536db3-9e81-4820-a66b-579171acd07f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-05 03:32:40.17809+00	2025-07-05 03:32:40.17809+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	152.166.149.83	\N
b157f07e-4ba2-4a7e-bf00-10d54a13e174	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-05 04:00:50.984195+00	2025-07-05 04:00:50.984195+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	152.166.149.83	\N
06a65e41-0d82-456d-b2e4-8dd9387ed063	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	2025-07-05 21:49:43.823746+00	2025-07-06 00:46:21.382907+00	\N	aal1	\N	2025-07-06 00:46:21.382836	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0	152.166.28.168	\N
61db16e4-3d85-44b3-abe2-174eeb57b1e9	131c625c-8329-48ce-9b74-67991bd070fd	2025-07-09 02:28:54.977906+00	2025-07-09 02:28:54.977906+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	152.0.24.239	\N
b8ae971a-46db-4df3-aef5-7ebe38989282	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-06 16:56:39.373799+00	2025-07-06 16:56:39.373799+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	179.53.75.190	\N
8289e546-f5ae-43c4-8154-341af8de1bfd	131c625c-8329-48ce-9b74-67991bd070fd	2025-07-09 02:29:09.324437+00	2025-07-09 02:29:09.324437+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	152.0.24.239	\N
d0f69537-b0bd-44d8-905c-670fc9097d46	e953b9ba-10a2-4efe-a8c6-f89590cbda92	2025-07-07 23:43:21.717984+00	2025-07-07 23:43:21.717984+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	181.36.113.229	\N
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
00000000-0000-0000-0000-000000000000	e294a283-3655-4b93-a207-04f486438f37	authenticated	authenticated	federicomontero.e@gmail.com	$2a$10$45H717NLAwPrGhOF1OyfkODCI4Wkg1msOjN9oftXbQqSqPgFVyWfa	2025-07-05 14:24:19.446095+00	\N		2025-07-05 14:24:02.564779+00		\N			\N	2025-07-05 14:24:48.537691+00	{"provider": "email", "providers": ["email"]}	{"sub": "e294a283-3655-4b93-a207-04f486438f37", "email": "federicomontero.e@gmail.com", "phone": "8099198851", "full_name": "Federico Montero", "email_verified": true, "phone_verified": false}	\N	2025-07-05 14:24:02.533545+00	2025-07-05 17:16:18.505411+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	131c625c-8329-48ce-9b74-67991bd070fd	authenticated	authenticated	f.alcantara2103@gmail.com	$2a$10$1Qc9wqn9EnDDp4uaqxVluOIfks.NJAicspNrfSX0Md5VvYc/ao7T.	2025-07-09 02:28:54.973017+00	\N		2025-07-09 02:28:40.596844+00		\N			\N	2025-07-09 02:29:09.324359+00	{"provider": "email", "providers": ["email"]}	{"sub": "131c625c-8329-48ce-9b74-67991bd070fd", "email": "f.alcantara2103@gmail.com", "phone": "8493570321", "full_name": "Franklin Moises Alcantara Miranda", "email_verified": true, "phone_verified": false}	\N	2025-07-09 02:28:40.556161+00	2025-07-09 02:29:09.326061+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	authenticated	authenticated	josias.arturo.perez@gmail.com	$2a$10$XvmKt0Onc3J8iRNnNfelfedod3GXgkGfR4ha.0ZhM6vxQVPSm1Uxm	2025-07-05 21:49:31.676232+00	\N		2025-07-05 21:49:07.250144+00		\N			\N	2025-07-05 21:49:43.823671+00	{"provider": "email", "providers": ["email"]}	{"sub": "99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92", "email": "josias.arturo.perez@gmail.com", "phone": "8098028341", "full_name": "Josias Perez", "email_verified": true, "phone_verified": false}	\N	2025-07-05 21:49:07.204257+00	2025-07-06 00:46:21.380563+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a09cd383-3c5a-4f9f-8c5a-036761a96873	authenticated	authenticated	jccontin@gmail.com	$2a$10$AH6UxPLs0yLhZ0xi3P3RrukUMW2QSFtvCBei4gg4EtLqa22aGqgBW	2025-07-07 03:01:43.038322+00	\N		2025-07-07 03:01:25.447782+00		\N			\N	2025-07-07 03:18:23.366077+00	{"provider": "email", "providers": ["email"]}	{"sub": "a09cd383-3c5a-4f9f-8c5a-036761a96873", "email": "jccontin@gmail.com", "phone": "", "full_name": "Joan Karl", "email_verified": true, "phone_verified": false}	\N	2025-07-07 02:57:33.491128+00	2025-07-07 03:18:23.371209+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e953b9ba-10a2-4efe-a8c6-f89590cbda92	authenticated	authenticated	ruth5525@gmail.com	$2a$06$uvXeL7HTk2JFkrSB.zP48.d8gwxG6KSee9kSYPBqF51WT2NhfUaTS	2025-07-05 03:32:34.054729+00	\N		2025-07-05 03:31:12.174103+00		\N			\N	2025-07-07 23:43:21.717307+00	{"provider": "email", "providers": ["email"]}	{"sub": "e953b9ba-10a2-4efe-a8c6-f89590cbda92", "email": "ruth5525@gmail.com", "phone": "8492128259", "full_name": "Ruth Esther Santana de Noel", "email_verified": true, "phone_verified": false}	\N	2025-07-05 03:31:12.143047+00	2025-07-11 02:52:06.110793+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	authenticated	authenticated	armandonoel01@gmail.com	$2a$10$0ePuUi3LS5o/1uNKfDPiZeyEkwdEBd5FeAwrvApISQtl9U4ujM6nu	2025-07-10 16:10:54.885805+00	\N		\N		\N			\N	2025-07-10 16:11:09.151706+00	{"provider": "email", "providers": ["email"]}	{"sub": "ba58b1a4-2308-4cc9-a741-3a0c579d6b86", "email": "armandonoel01@gmail.com", "phone": "8099990000", "full_name": "Armando Noel", "email_verified": true, "phone_verified": false}	\N	2025-07-10 16:10:54.869543+00	2025-07-10 16:11:09.153397+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	51d869f4-fa16-4633-9121-561817fce43d	authenticated	authenticated	armandonoel@outlook.com	$2a$10$C/TUbWWXFCZFIHLB/jTkH.07O9LoN/XA3JwriJaUJ6CqRv7fJ0RC6	2025-06-15 01:58:13.626971+00	\N		2025-06-15 01:55:41.079665+00		\N			\N	2025-07-12 02:15:05.587958+00	{"provider": "email", "providers": ["email"]}	{"sub": "51d869f4-fa16-4633-9121-561817fce43d", "email": "armandonoel@outlook.com", "phone": "8298026640", "full_name": "Armando Noel Charle", "email_verified": true, "phone_verified": false}	\N	2025-06-15 01:55:41.053582+00	2025-07-12 18:57:01.057384+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: amber_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.amber_alerts (id, user_id, child_full_name, child_nickname, child_photo_url, last_seen_location, disappearance_time, medical_conditions, contact_number, additional_details, is_active, created_at, resolved_at, resolved_by) FROM stdin;
5728d483-4183-4e56-9376-5ef99fc279cc	51d869f4-fa16-4633-9121-561817fce43d	Prueba1_2025	Prueba1	\N	Prueba	2025-06-14 04:01:00+00	Ninguno	8090000000		f	2025-06-15 19:00:36.099375+00	2025-06-15 19:06:08.154+00	51d869f4-fa16-4633-9121-561817fce43d
cf76f5ce-a5fd-424b-9fa3-3c50f8c9a41a	51d869f4-fa16-4633-9121-561817fce43d	Prueba1_2025	Prueba1	\N	Prueba	2025-06-15 00:37:00+00		8090000000		f	2025-06-16 18:37:47.820849+00	2025-06-16 18:38:17.93+00	51d869f4-fa16-4633-9121-561817fce43d
b523e9bf-1b66-42d6-a14d-ea99a5fb564f	51d869f4-fa16-4633-9121-561817fce43d	Prueba1_2025	Prueba1	\N	Prueba	2025-07-06 11:33:00+00		8090000000		f	2025-07-06 15:33:54.657217+00	2025-07-06 15:34:10.454+00	51d869f4-fa16-4633-9121-561817fce43d
8ccd0ae1-dab3-404d-92e8-0cd6bb205de3	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	https://xgsxivotekaxeustofls.supabase.co/storage/v1/object/public/amber-alert-photos/amber-photos/1751816391414.jpeg	Parque del Italia	2025-07-04 17:30:00+00		8090000000	Edad: 8 años\nSexo: Masculino\nEstatura: 1.25 metros\nPeso: 28 kg\nColor de piel: Morena clara\nColor de ojos: Marrón oscuro\nColor de cabello: Castaño claro, corto y lacio\nSeñas particulares:\n•⁠  ⁠Cicatriz pequeña en la ceja izquierda\n•⁠  ⁠Lunar en el antebrazo derecho\n\nRopa que vestía al momento de la desaparición:\n•⁠  ⁠Camiseta roja con estampado de dinosaurio\n•⁠  ⁠Pantalón de mezclilla azul\n•⁠  ⁠Tenis blancos con detalles verdes\n•⁠  ⁠Mochila azul con parches de superhéroes\n\nComportamiento o estado emocional:\n•⁠  ⁠Niño tranquilo, algo tímido con desconocidos\n•⁠  ⁠Puede mostrarse nervioso si se siente perdido\n\nPosible acompañante o sospechoso:\n•⁠  ⁠Hombre adulto, aproximadamente 35 años\n•⁠  ⁠Vestía sudadera gris con capucha y jeans\n•⁠  ⁠Fue visto caminando con el menor hacia la salida del parque\n	f	2025-07-06 15:39:52.418018+00	2025-07-06 15:59:29.867+00	51d869f4-fa16-4633-9121-561817fce43d
d1dce037-0605-4d77-bdf0-ee72040678d3	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 15:59:45.059+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 15:59:45.164774+00	2025-07-06 16:02:30.084+00	51d869f4-fa16-4633-9121-561817fce43d
7c6f1b97-673c-4c6c-b2c4-826f93964822	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 15:59:32.748+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 15:59:32.924427+00	2025-07-06 16:02:44.212+00	51d869f4-fa16-4633-9121-561817fce43d
7e8969ff-1696-4a29-9918-3946b807d08c	e294a283-3655-4b93-a207-04f486438f37	Pedro Rodríguez	\N	\N	Villa Agrippina, Santo Domingo	2025-03-19 01:24:23.941+00	Diabetes	8094076767	Menor desaparecido en zona de Gazcue	f	2025-03-19 01:24:23.941+00	\N	\N
50d8718d-c604-4762-b163-174c5ea6db79	131c625c-8329-48ce-9b74-67991bd070fd	Ramón Martín	\N	\N	Villa Consuelo, Santo Domingo	2025-05-31 11:12:56.935+00	\N	8093897687	Menor desaparecido en zona de Villa Agrippina	f	2025-05-31 11:12:56.935+00	2025-06-01 18:02:30.149+00	\N
67d5db85-4896-4707-a37e-12bad6c52210	131c625c-8329-48ce-9b74-67991bd070fd	Rosa Ramos	\N	\N	Los Ríos, Santo Domingo	2025-07-06 05:58:42.504+00	\N	8095721952	Menor desaparecido en zona de Ensanche Ozama	f	2025-07-06 05:58:42.504+00	\N	\N
97bd580e-46f8-4872-81bf-0c20e7776ef6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Teresa Gómez	Chico	\N	Piantini, Santo Domingo	2025-06-05 21:12:12.931+00	\N	8098337109	Menor desaparecido en zona de Villa Agrippina	f	2025-06-05 21:12:12.931+00	\N	\N
0697e161-39db-4a71-b72f-aad1a97a4052	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Carmen Gil	Chico	\N	Los Minas, Santo Domingo	2025-01-30 15:14:20.329+00	\N	8097280331	Menor desaparecido en zona de Bella Vista	f	2025-01-30 15:14:20.329+00	\N	\N
d1c71948-86e2-46e3-9bbf-517dfcbcb017	51d869f4-fa16-4633-9121-561817fce43d	Ramón Jiménez	\N	\N	Villa Juana, Santo Domingo	2025-03-02 15:04:59.63+00	\N	8092056428	Menor desaparecido en zona de Villa Duarte	f	2025-03-02 15:04:59.63+00	2025-07-11 03:39:27.96+00	\N
2059dfb4-4351-4818-a55a-438e62d100fe	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Rafael Blanco	\N	\N	Villa Francisca, Santo Domingo	2025-06-22 21:49:36.672+00	\N	8095074590	Menor desaparecido en zona de Los Cacicazgos	f	2025-06-22 21:49:36.672+00	2025-07-11 03:39:27.96+00	\N
7d3888f3-e84c-49df-878d-6a0f48194821	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 15:59:37.857+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 15:59:37.971033+00	2025-07-06 16:02:34.754+00	51d869f4-fa16-4633-9121-561817fce43d
a7fe864d-7a27-43c7-826a-14f46886e36e	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:02:51.259+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:02:51.432395+00	2025-07-06 16:04:40.664+00	51d869f4-fa16-4633-9121-561817fce43d
cbefce1e-4bfd-43dc-a94d-a3b827eecf6d	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:18:57.966+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:18:58.175458+00	2025-07-06 16:19:11.156+00	51d869f4-fa16-4633-9121-561817fce43d
0c41ffd3-3623-4081-a43e-39eb2e0553b4	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:22:25.528+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:22:25.70467+00	2025-07-06 16:22:41.162+00	51d869f4-fa16-4633-9121-561817fce43d
db73f60a-e631-434f-9f0d-e1661315c97a	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:26:42.495+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:26:42.81401+00	2025-07-06 16:26:55.07+00	51d869f4-fa16-4633-9121-561817fce43d
4b288536-0f26-4818-8136-8d5a2473faad	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:33:19.979+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:33:20.142106+00	2025-07-06 16:33:33.472+00	51d869f4-fa16-4633-9121-561817fce43d
993add7a-35fe-40d1-b0be-7a19ec4044ec	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ana Alonso	\N	\N	Naco, Santo Domingo	2025-04-19 12:36:04.793+00	\N	8093118619	Menor desaparecido en zona de Villa Agrippina	f	2025-04-19 12:36:04.793+00	2025-07-11 03:39:27.96+00	\N
e77dd8e8-3257-404a-b10d-186dad58669f	e294a283-3655-4b93-a207-04f486438f37	Lucía Martínez	Bebe	\N	Villa Francisca, Santo Domingo	2025-05-21 20:40:50.126+00	TDAH	8095627149	Menor desaparecido en zona de Los Minas	f	2025-05-21 20:40:50.126+00	2025-07-11 03:39:27.96+00	\N
329fe78b-6670-4fcb-a231-4ece6afca2cc	e294a283-3655-4b93-a207-04f486438f37	Teresa Blanco	Negrito	\N	Alma Rosa, Santo Domingo	2025-06-28 12:23:49.137+00	\N	8097748744	Menor desaparecido en zona de Los Minas	f	2025-06-28 12:23:49.137+00	2025-07-11 03:39:27.96+00	\N
343112f7-9273-4441-ac0a-7749cb00dde9	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Rafael Gutiérrez	\N	\N	Los Ríos, Santo Domingo	2025-03-12 05:32:47.517+00	\N	8097676905	Menor desaparecido en zona de Villa Francisca	f	2025-03-12 05:32:47.517+00	2025-07-11 03:39:27.96+00	\N
8c0c87dc-d7e4-4dd2-8d8f-14072acf12b0	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:33:37.533+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:33:37.705384+00	2025-07-06 16:33:59.054+00	51d869f4-fa16-4633-9121-561817fce43d
5868debd-6e49-494b-a208-56c274c836bb	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:44:39.35+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:44:39.592527+00	2025-07-06 16:44:51.249+00	51d869f4-fa16-4633-9121-561817fce43d
b0d42551-18bd-4991-b264-0cb1cc8de73c	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 16:48:14.403+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 16:48:14.533704+00	2025-07-06 16:48:25.372+00	51d869f4-fa16-4633-9121-561817fce43d
8691dbb1-5efc-4e8c-8044-782c335a9272	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	https://xgsxivotekaxeustofls.supabase.co/storage/v1/object/public/amber-alert-photos/amber-photos/1751822310226.jpeg	Parque del Italia	2025-07-04 17:30:00+00		8298026640	*Edad:* 8 años\n*Sexo:* Masculino\n*Estatura:* 1.25 metros\n*Peso:* 28 kg\n*Color de piel:* Morena clara\n*Color de ojos:* Marrón oscuro\n*Color de cabello:* Castaño claro, corto y lacio\n*Señas particulares:*\n- Cicatriz pequeña en la ceja izquierda\n- Lunar en el antebrazo derecho\n\n*Ropa que vestía al momento de la desaparición:*\n- Camiseta roja con estampado de dinosaurio\n- Pantalón de mezclilla azul\n- Tenis blancos con detalles verdes\n- Mochila azul con parches de superhéroes\n\n*Comportamiento o estado emocional:*\n- Niño tranquilo, algo tímido con desconocidos\n- Puede mostrarse nervioso si se siente perdido\n\n*Posible acompañante o sospechoso:*\n- Hombre adulto, aproximadamente 35 años\n- Vestía sudadera gris con capucha y jeans\n- Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 17:18:31.662046+00	2025-07-06 17:19:28.709+00	51d869f4-fa16-4633-9121-561817fce43d
ad806f1f-7003-4047-9a31-4a6c30d3e76a	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-06 22:40:22.388+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-06 22:40:22.559773+00	2025-07-06 22:40:34.07+00	51d869f4-fa16-4633-9121-561817fce43d
f986ad12-ec72-44c6-a363-c3a623a59d91	51d869f4-fa16-4633-9121-561817fce43d	Mateo Ramírez Torres	Mateito	\N	Parque del Italia	2025-07-09 03:21:33.136+00	Niño tranquilo, algo tímido con desconocidos. Puede mostrarse nervioso si se siente perdido.	+573001234567	Edad: 8 años Sexo: Masculino Estatura: 1.25 metros Peso: 28 kg Color de piel: Morena clara Color de ojos: Marrón oscuro Color de cabello: Castaño claro, corto y lacio Señas particulares: • Cicatriz pequeña en la ceja izquierda • Lunar en el antebrazo derecho Ropa que vestía al momento de la desaparición: • Camiseta roja con estampado de dinosaurio • Pantalón de mezclilla azul • Tenis blancos con detalles verdes • Mochila azul con parches de superhéroes Comportamiento o estado emocional: • Niño tranquilo, algo tímido con desconocidos • Puede mostrarse nervioso si se siente perdido Posible acompañante o sospechoso: • Hombre adulto, aproximadamente 35 años • Vestía sudadera gris con capucha y jeans • Fue visto caminando con el menor hacia la salida del parque	f	2025-07-09 03:21:33.295435+00	2025-07-09 03:21:43.624+00	51d869f4-fa16-4633-9121-561817fce43d
c54a402c-fe48-4fda-b926-451ef14d440e	e294a283-3655-4b93-a207-04f486438f37	Esperanza López	\N	\N	Villa Francisca, Santo Domingo	2025-02-16 02:13:14.438+00	\N	8098612578	Menor desaparecido en zona de Villa Consuelo	f	2025-02-16 02:13:14.438+00	2025-02-16 19:35:21.068+00	\N
72663e9d-b2fb-47dd-9914-ce6c3d7ee54a	e294a283-3655-4b93-a207-04f486438f37	Ana Martín	Chico	\N	Villa Duarte, Santo Domingo	2025-02-02 10:03:09.346+00	\N	8099549603	Menor desaparecido en zona de Villa Francisca	f	2025-02-02 10:03:09.346+00	\N	\N
108c1a8a-7372-4c94-a85b-d7c9bcd53348	51d869f4-fa16-4633-9121-561817fce43d	Ramón Díaz	\N	\N	San Carlos, Santo Domingo	2025-03-30 23:28:07.809+00	\N	8091808575	Menor desaparecido en zona de Piantini	f	2025-03-30 23:28:07.809+00	2025-03-31 06:06:24.648+00	\N
f70b662d-1476-422f-9a87-96aba26df6ab	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Antonio González	Bebe	\N	Bella Vista, Santo Domingo	2025-06-04 02:55:53.168+00	\N	8098339500	Menor desaparecido en zona de La Esperilla	f	2025-06-04 02:55:53.168+00	\N	\N
\.


--
-- Data for Name: before_after_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.before_after_videos (id, user_id, title, description, video_url, file_name, file_size, created_at, updated_at) FROM stdin;
88db4aa3-8a18-4b3e-b11d-0139f40a10f3	51d869f4-fa16-4633-9121-561817fce43d	Remozamiento Parque Simonico	En el Parque Simonico, un espacio que antes estaba en abandono, hoy vuelve a recibir a las familias con areas limpias, bancas arregladas y zonas verdes cuidadas.\n\nEl alcalde explica en el video que se trata de recuperar areas para que las familias puedan disfrutar de ellas. Estan sembrando arboles como el roble amarillo y trinitarias que florecen y no danan el piso. 	https://xgsxivotekaxeustofls.supabase.co/storage/v1/object/public/before-after-videos/51d869f4-fa16-4633-9121-561817fce43d/1749998850738-b267a99f08734a44bcf956c5b305f461.MP4	b267a99f08734a44bcf956c5b305f461.MP4	44914976	2025-06-15 14:47:49.329016+00	2025-06-15 14:47:49.329016+00
\.


--
-- Data for Name: community_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_messages (id, created_by, title, message, image_url, sector, municipality, province, scheduled_at, sent_at, is_active, created_at, updated_at) FROM stdin;
91e7e3bc-fb4b-4cb3-90e1-b66562c45ca7	51d869f4-fa16-4633-9121-561817fce43d	Cierre de calles por Fiestas	ESTAREMOS CERRANDO EL TRAMO DE LA AVENIDA SAN VICENTE DE PAUL QUE VA DESDE LA CARRETERA MELLA HASTA LA COSTA RICA Y LA CALLE COSTA RICA COMPLETA	https://xgsxivotekaxeustofls.supabase.co/storage/v1/object/public/community-messages/messages/1751818172038.png	Alma Rosa	santo-domingo-este	santo-domingo	2025-07-08 00:00:00+00	\N	t	2025-07-06 16:09:33.826003+00	2025-07-06 16:09:33.826003+00
\.


--
-- Data for Name: garbage_alert_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garbage_alert_configs (id, sector, municipality, province, days_of_week, frequency_hours, start_hour, end_hour, is_active, created_at, updated_at, created_by) FROM stdin;
3befa87c-21a9-4fee-8532-d046fffdd611	General	Santo Domingo	Distrito Nacional	{1,3,5}	3	6	18	t	2025-07-11 12:17:06.967173+00	2025-07-12 01:59:03.861427+00	\N
\.


--
-- Data for Name: garbage_bills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garbage_bills (id, user_id, bill_number, billing_period_start, billing_period_end, amount_due, due_date, status, created_at, updated_at) FROM stdin;
a2429a06-f6a5-46ef-8534-a2680d338dc8	51d869f4-fa16-4633-9121-561817fce43d	TEST-1751771436939	2025-06-01	2025-06-30	32500	2025-07-05	paid	2025-07-06 03:10:36.994536+00	2025-07-06 03:10:36.994536+00
2937b66f-6e7a-4f72-a247-7ada59df7aaf	51d869f4-fa16-4633-9121-561817fce43d	TEST-1752285688701	2025-06-01	2025-06-30	32500	2025-07-05	pending	2025-07-12 02:01:28.754106+00	2025-07-12 02:01:28.754106+00
\.


--
-- Data for Name: garbage_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garbage_payments (id, user_id, bill_id, stripe_session_id, amount_paid, payment_method, payment_status, payment_date, created_at, updated_at) FROM stdin;
74994ce6-8f2d-4084-8198-52380579c1a4	51d869f4-fa16-4633-9121-561817fce43d	a2429a06-f6a5-46ef-8534-a2680d338dc8	cs_test_a1Hl7OkZfpQgTKJzSV3rBwlGf5jaXHBi3MPIeQ93QY0ZFK5OymVAXn3f7M	32500	stripe	completed	2025-07-06 03:17:32.436+00	2025-07-06 03:17:32.488138+00	2025-07-06 03:17:32.488138+00
\.


--
-- Data for Name: generated_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generated_reports (id, title, description, report_type, generated_by, date_range_start, date_range_end, filters, google_sheets_url, google_chart_url, pdf_url, status, created_at, updated_at) FROM stdin;
d5bf140c-c645-42a2-b81e-609ae745456e	Reporte en Proceso	Este reporte está siendo generado actualmente	custom	\N	2025-01-01	2025-01-15	\N	\N	\N	\N	generating	2025-06-15 17:32:38.816426+00	2025-06-15 17:32:38.816426+00
6d657a5e-5d0d-4b06-ad93-18df172c2b1c	Reporte Mensual de Incidencias - Enero 2025	Resumen de todas las incidencias reportadas durante enero 2025	monthly	\N	2025-01-01	2025-01-31	\N	\N	\N	\N	completed	2025-06-15 17:32:38.816426+00	2025-06-15 17:32:38.816426+00
3158a248-3a32-446e-b7c9-927d9ee30162	Reporte Semanal de Limpieza - Semana 3	Análisis de servicios de limpieza y recolección de basura	weekly	\N	2025-01-15	2025-01-21	\N	\N	\N	\N	completed	2025-06-15 17:32:38.816426+00	2025-06-15 17:32:38.816426+00
a4e736da-3dbb-43dd-af8b-8a64f2bef09b	Reporte de Prueba con Enlaces Funcionales	Este reporte tiene enlaces reales para probar la funcionalidad	monthly	51d869f4-fa16-4633-9121-561817fce43d	2025-01-01	2025-01-31	\N	https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit	https://docs.google.com/presentation/d/1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXhPSx4XY9xEpJM/edit	https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf	completed	2025-06-15 17:43:26.854137+00	2025-06-15 17:43:26.854137+00
0bce2843-f306-4d35-85f2-2c79ad909585	Reporte Semanal - Datos Actualizados	Reporte con métricas de la semana pasada	weekly	51d869f4-fa16-4633-9121-561817fce43d	2025-06-08	2025-06-14	\N	https://docs.google.com/spreadsheets/d/1mHIWnDvW9cALRMq9OdNfzOxGtb0zDQtJgDr8f5F6H7G/edit	https://docs.google.com/presentation/d/1FBZl29XEjKH-aq_1xMn4DtgRj_k9fYiQTx5YZ0yFrKN/edit	https://www.orimi.com/pdf-test.pdf	completed	2025-06-15 17:43:26.854137+00	2025-06-15 17:43:26.854137+00
205f7f87-10a9-4016-a445-0c631ceefaec	Análisis de Incidencias - Q2 2025	Resumen trimestral de todas las incidencias reportadas	incident_summary	51d869f4-fa16-4633-9121-561817fce43d	2025-04-01	2025-06-30	\N	https://docs.google.com/spreadsheets/d/1nJKLaRSTuVwXyZ2aB3cDeF4gH5iJ6kL7mN8oP9qR0sT/edit	https://docs.google.com/presentation/d/1GCam30YFkLI-br_2yNo5EuhSk_l0gZjRUy6Za1zGsLO/edit	https://www.clickdimensions.com/links/TestPDFfile.pdf	completed	2025-06-15 17:43:26.854137+00	2025-06-15 17:43:26.854137+00
\.


--
-- Data for Name: global_test_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_test_notifications (id, notification_type, triggered_by, triggered_at, expires_at, is_active, message) FROM stdin;
e1a95ae3-22f7-4a79-97ae-0edd6f3b1b9c	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-05 04:31:14.010438+00	2025-07-05 04:31:44.010438+00	f	Prueba de alerta de recolección de basura
ffeccba5-618d-4bf0-a920-bd3be1a1df60	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-05 04:31:17.39072+00	2025-07-05 04:31:47.39072+00	f	Prueba de alerta de recolección de basura
dfc44855-585f-4501-9ade-2a619cf64e49	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-05 04:31:28.77982+00	2025-07-05 04:31:58.77982+00	f	Prueba de alerta de recolección de basura
dadf604d-e007-4440-849e-49c5d0728d4a	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-05 04:35:32.221723+00	2025-07-05 04:36:02.221723+00	f	Prueba de alerta de recolección de basura
29bb84a8-f158-4c3d-a364-abc84fe7b072	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:13:34.113211+00	2025-07-06 01:14:04.113211+00	f	Prueba de alerta de recolección de basura
fcfcae04-6aef-4edc-b404-072b5e7ab6e5	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 03:18:18.494778+00	2025-07-06 03:18:48.494778+00	f	Prueba de alerta de recolección de basura
c462fbb2-af68-412f-8a85-9860885a6c1d	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 03:58:16.662664+00	2025-07-06 03:58:46.662664+00	f	Prueba de alerta de recolección de basura
74f8e9aa-410c-49a4-9457-a324365db159	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 04:02:53.839499+00	2025-07-06 04:03:23.839499+00	f	Prueba de alerta de recolección de basura
bb6b2513-9134-4df1-96fc-ded9535e63c0	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 04:29:59.405059+00	2025-07-06 04:30:29.405059+00	f	Prueba de alerta de recolección de basura
589a359d-16e0-4790-8977-5a1728a8c852	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 10:23:47.370572+00	2025-07-06 10:24:17.370572+00	f	Prueba de alerta de recolección de basura
ba104bf2-46de-430d-bb0a-83997e586096	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 15:59:40.183046+00	2025-07-06 16:00:10.183046+00	f	Prueba de alerta de recolección de basura
472d4335-7fd6-42cc-bd10-241d1e3b20ad	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 16:22:11.444146+00	2025-07-06 16:22:41.444146+00	f	Prueba de alerta de recolección de basura
2432341c-2253-4664-8143-a889b3b709f6	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 16:44:35.499016+00	2025-07-06 16:45:05.499016+00	f	Prueba de alerta de recolección de basura
2bcbc1de-7010-43eb-adbb-cf00644a7d5d	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 16:47:32.709182+00	2025-07-06 16:48:02.709182+00	f	Prueba de alerta de recolección de basura
b5f292e5-fdf7-4dfe-89db-3ef914a1a953	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 17:24:27.028604+00	2025-07-06 17:24:57.028604+00	f	Prueba de alerta de recolección de basura
34d723d0-3d83-47b5-88e9-4eb17f83e701	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 22:40:18.979117+00	2025-07-06 22:40:48.979117+00	f	Prueba de alerta de recolección de basura
ad2353bd-64e7-4a7d-874a-16d562135c34	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-07 02:06:11.675229+00	2025-07-07 02:06:41.675229+00	f	Prueba de alerta de recolección de basura
eb694cb0-b661-4569-851d-af0e2f84521f	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-07 03:04:42.51731+00	2025-07-07 03:05:12.51731+00	f	Prueba de alerta de recolección de basura
6084da66-0ab8-43a4-a041-5c126d197b1a	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-07 03:05:53.681904+00	2025-07-07 03:06:23.681904+00	f	Prueba de alerta de recolección de basura
55a316a2-a686-409a-8123-ae21883dfdd7	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-07 03:06:08.182503+00	2025-07-07 03:06:38.182503+00	f	Prueba de alerta de recolección de basura
d6c65469-4b74-4dbb-93a9-f4b1e6b8e3d0	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-08 20:35:41.636327+00	2025-07-08 20:36:11.636327+00	f	Prueba de alerta de recolección de basura
a06dab85-bb46-47ed-82a2-579f4329af2d	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-09 02:34:11.390122+00	2025-07-09 02:34:41.390122+00	f	Prueba de alerta de recolección de basura
bac29457-9a7e-4e35-bcbc-bdf83b892ed3	garbage_alert	51d869f4-fa16-4633-9121-561817fce43d	2025-07-09 03:21:29.890267+00	2025-07-09 03:21:59.890267+00	f	Prueba de alerta de recolección de basura
\.


--
-- Data for Name: help_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.help_messages (id, user_id, subject, message, status, priority, created_at, updated_at, resolved_at, admin_response, user_email, user_full_name) FROM stdin;
\.


--
-- Data for Name: job_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_applications (id, user_id, full_name, email, phone, address, birth_date, document_type, document_number, education_level, institution_name, career_field, graduation_year, additional_courses, work_experience, skills, availability, expected_salary, cv_file_url, cv_file_name, status, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: message_recipients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_recipients (id, message_id, user_id, delivered_at, read_at, created_at) FROM stdin;
\.


--
-- Data for Name: message_weekly_limits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_weekly_limits (id, user_id, week_start, message_count, created_at, updated_at) FROM stdin;
7f4123ae-a88b-4968-a3e2-9e904b95d87d	51d869f4-fa16-4633-9121-561817fce43d	2025-06-30	1	2025-07-06 16:09:33.826003+00	2025-07-06 16:09:33.826003+00
\.


--
-- Data for Name: panic_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.panic_alerts (id, user_id, user_full_name, latitude, longitude, address, created_at, expires_at, is_active) FROM stdin;
bc8989bf-ad8f-477b-b9d8-a5a989dfdac5	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.549178613237206	-69.99088408099517	Los Ríos, Santo Domingo	2025-05-23 00:31:33.176+00	2025-05-23 01:31:33.176+00	f
c15f0c8a-e8d0-4c91-9ec6-18675ac9b4bc	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.42727680862777	-70.00181836954756	Villa Consuelo, Santo Domingo	2025-06-17 04:45:31.884+00	2025-06-17 05:45:31.884+00	f
0f8daf50-6df2-4592-ab6d-af2d3f7becd6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	18.442260730104515	-69.97692242295491	Los Ríos, Santo Domingo	2025-07-07 04:56:16.29+00	2025-07-07 05:56:16.29+00	f
e08e08ad-0fc4-483d-bb1d-1083e4f4eff0	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.517439217171027	-69.86132545875579	Villa Agrippina, Santo Domingo	2025-06-25 13:28:28.82+00	2025-06-25 14:28:28.82+00	f
301fe3b3-baad-4e3e-8b22-cc9eea08bff1	a09cd383-3c5a-4f9f-8c5a-036761a96873	Joan Karl	18.44967617567212	-69.93264665156885	Mirador Sur, Santo Domingo	2025-07-08 04:04:20.834+00	2025-07-08 05:04:20.834+00	f
19653c47-2e16-4e2e-85dd-36745bcaa82e	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.463638335274265	-69.96267236620034	Villa Duarte, Santo Domingo	2025-05-01 07:30:32.869+00	2025-05-01 08:30:32.869+00	f
7d172b1a-fd3e-4f6a-8ecb-d42edf771299	131c625c-8329-48ce-9b74-67991bd070fd	Franklin Moises Alcantara Miranda	18.47503353916626	-69.92951017654903	Villa Consuelo, Santo Domingo	2025-05-08 13:08:31.49+00	2025-05-08 14:08:31.49+00	f
55ccb5d0-2cf5-4844-9256-22b1ebb05c01	131c625c-8329-48ce-9b74-67991bd070fd	Franklin Moises Alcantara Miranda	18.507992105954674	-69.85642610153926	Bella Vista, Santo Domingo	2025-07-03 09:30:29.833+00	2025-07-03 10:30:29.833+00	f
abe51619-e66f-40c6-8716-54db46b9a7c5	131c625c-8329-48ce-9b74-67991bd070fd	Franklin Moises Alcantara Miranda	18.546966941996445	-69.92736586893328	Los Cacicazgos, Santo Domingo	2025-04-16 12:13:26.285+00	2025-04-16 13:13:26.285+00	f
54f88f54-1acf-4876-9cdb-b932bd2fe04b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Josias Perez	18.425226681051743	-69.92834512735642	Piantini, Santo Domingo	2025-05-17 19:30:23.009+00	2025-05-17 20:30:23.009+00	f
969d6caa-3250-4777-a2dd-2cb40d24a217	a09cd383-3c5a-4f9f-8c5a-036761a96873	Joan Karl	18.53233865192161	-69.96232875549332	Ensanche Ozama, Santo Domingo	2025-05-25 13:56:16.305+00	2025-05-25 14:56:16.305+00	f
dd49a3cf-7e04-498f-a10c-cbf3bfb47cfd	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.475348303584614	-69.8954131935642	Alma Rosa, Santo Domingo	2025-06-19 06:58:46.923+00	2025-06-19 07:58:46.923+00	f
00bc130c-d634-4471-960f-faa58d309cef	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.454802969877257	-69.87994939769288	San Carlos, Santo Domingo	2025-06-07 15:49:52.714+00	2025-06-07 16:49:52.714+00	f
64b40f3f-a856-4284-b8c8-a7d3c1b20569	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.45902069790479	-69.89310951309365	Villa Duarte, Santo Domingo	2025-05-15 07:52:11.633+00	2025-05-15 08:52:11.633+00	f
da604d66-d48a-4705-957e-bbc381e727d2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	18.418130306686365	-69.8846678494091	Villa Duarte, Santo Domingo	2025-06-16 19:13:20.421+00	2025-06-16 20:13:20.421+00	f
e7ecb459-0d8b-45da-b400-287841b5bf1d	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.460957825651754	-69.97897917404268	Ensanche Julieta, Santo Domingo	2025-07-10 01:02:39.856+00	2025-07-10 02:02:39.856+00	f
77c5bdd5-b286-416d-bf3e-6530193ba091	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.54860530467577	-69.93984498865527	Gualey, Santo Domingo	2025-06-25 23:52:02.075+00	2025-06-26 00:52:02.075+00	f
4749ed13-ab5d-46a4-8ba3-cb261572c61b	131c625c-8329-48ce-9b74-67991bd070fd	Franklin Moises Alcantara Miranda	18.546390439685823	-69.9386811882485	Los Cacicazgos, Santo Domingo	2025-06-27 03:21:24.613+00	2025-06-27 04:21:24.613+00	f
dcdf8c03-de15-46f8-9ae8-8d07a602f0d3	a09cd383-3c5a-4f9f-8c5a-036761a96873	Joan Karl	18.55731887638324	-69.8986368891998	Ensanche Ozama, Santo Domingo	2025-05-28 21:07:20.224+00	2025-05-28 22:07:20.224+00	f
1e115ae9-637f-48c5-8e04-7ae1b911b2a2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	18.45545409117117	-69.88116308412967	Mirador Sur, Santo Domingo	2025-06-01 21:18:25.086+00	2025-06-01 22:18:25.086+00	f
0c78c99f-240b-4ad2-bdfe-491992b804e6	a09cd383-3c5a-4f9f-8c5a-036761a96873	Joan Karl	18.441386718590874	-69.92993748603672	Mirador Sur, Santo Domingo	2025-07-06 16:03:13.72+00	2025-07-06 17:03:13.72+00	f
14bfbf20-8bfb-466c-9b8f-2877da3980d4	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:05:37.96319+00	2025-06-15 16:06:37.96319+00	f
7d555f3d-14e2-4cd9-96e6-f707753fa258	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:09:02.004799+00	2025-06-15 16:10:02.004799+00	f
8e3eebc0-6d47-4da7-a943-49a21079b8b9	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:09:06.071881+00	2025-06-15 16:10:06.071881+00	f
8b2205a8-fe18-4b98-bb0e-6887f6004e31	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:09:12.531927+00	2025-06-15 16:10:12.531927+00	f
9f099e88-3e8b-4be2-98f2-57471a2585d2	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:13:01.443082+00	2025-06-15 16:14:01.443082+00	f
8bea1a0d-438a-4048-a4b4-d7b5a65b735a	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:13:08.926477+00	2025-06-15 16:14:08.926477+00	f
0e7270f0-381b-4c2b-9343-9a42eb399c1d	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:13:35.47626+00	2025-06-15 16:14:35.47626+00	f
cff7b786-1d7a-4e81-8bf3-18b84f21bb6d	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 16:30:53.982916+00	2025-06-15 16:31:53.982916+00	f
a568aeea-98a3-4c38-9f94-a17806d0bf61	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 18:53:12.526992+00	2025-06-15 18:54:12.526992+00	f
cea0f46a-48a5-4c9d-9c79-cad2ec0402bb	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 18:57:18.490672+00	2025-06-15 18:58:18.490672+00	f
76e05758-214c-4408-9572-fc5318eb244b	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 18:57:22.969213+00	2025-06-15 18:58:22.969213+00	f
2516872e-68a7-4ec3-bf2a-df0e561a654c	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 20:09:05.988686+00	2025-06-15 20:10:05.988686+00	f
12c6aa12-e29f-476b-9750-d802fd2e79f4	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-15 20:17:35.769805+00	2025-06-15 20:18:35.769805+00	f
e08de56e-3877-43bd-baa6-7481e830e996	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-16 01:15:40.112921+00	2025-06-16 01:16:40.112921+00	f
6e420d2f-74f4-4059-a972-a355cbbf6b70	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-06-16 18:35:13.049677+00	2025-06-16 18:36:13.049677+00	f
a12558d8-733f-41f0-8d06-93e9f90b24f1	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.5128469	-69.8276342	\N	2025-07-04 14:06:00.070245+00	2025-07-04 14:07:00.070245+00	f
ec96abb9-3e15-468f-b444-acdc57fb965c	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.5128469	-69.8276342	\N	2025-07-04 14:08:33.26651+00	2025-07-04 14:09:33.26651+00	f
ce65fc60-5040-4a27-9234-e7b6ce40f03f	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.5128469	-69.8276342	\N	2025-07-04 14:12:33.776823+00	2025-07-04 14:13:33.776823+00	f
e1e626a1-1bc9-4bdb-b0ba-40ee3d8b91f4	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.5128469	-69.8276342	\N	2025-07-04 14:36:03.364713+00	2025-07-04 14:37:03.364713+00	f
c3cb8c87-8bfb-4b8a-bd74-33895f284059	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.5128483	-69.827634	\N	2025-07-04 16:46:42.021663+00	2025-07-04 16:47:42.021663+00	f
d5156599-2f93-4c37-8d29-e5d76e8b1bbe	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo, 7, Urb. Los Trinitarios II	2025-07-05 03:33:29.602578+00	2025-07-05 03:34:29.602578+00	f
27f23825-8e3b-4970-8eaa-d3f649e74161	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.512790269432838	-69.82765242038326	\N	2025-07-05 04:02:53.297843+00	2025-07-05 04:03:53.297843+00	f
feb8549c-6956-4b11-a86c-a28f389c33fb	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.51279428701081	-69.82764510652343	\N	2025-07-06 03:59:40.963435+00	2025-07-06 04:00:40.963435+00	f
6371e984-f513-46de-9dcd-f6280e2c390e	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.51279428701081	-69.82764510652343	\N	2025-07-06 04:00:46.963792+00	2025-07-06 04:01:46.963792+00	f
377a1191-2435-44f2-897e-0cf9078e5c49	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.51279428701081	-69.82764510652343	\N	2025-07-06 10:24:02.723365+00	2025-07-06 10:25:02.723365+00	f
8163b885-b341-4eb9-87bc-b2a0f5dbba9e	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.507238782396264	-69.86904170618816	\N	2025-07-06 12:30:45.091883+00	2025-07-06 12:31:45.091883+00	f
c37aa8b2-2a8b-4164-83e0-15accf122e46	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-07-06 16:11:44.649346+00	2025-07-06 16:12:44.649346+00	f
c7d2ea4c-05a7-445c-b03e-9a6c038290d7	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-07-06 16:16:07.397121+00	2025-07-06 16:17:07.397121+00	f
bb09045f-174f-40c0-b13e-9a833cb14c27	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-07-06 16:19:20.478171+00	2025-07-06 16:20:20.478171+00	f
d0dd4d70-967d-47c3-a0c5-395990b63583	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	\N	\N	Calle Caonabo #7	2025-07-06 16:21:49.976607+00	2025-07-06 16:22:49.976607+00	f
93d8f7db-7d23-4057-ad71-313690935722	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-06 16:32:52.461117+00	2025-07-06 16:33:52.461117+00	f
f9c60f43-e1b8-4a1b-8f62-7c75917e63ac	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-06 16:44:55.352944+00	2025-07-06 16:45:55.352944+00	f
0fb74d81-0e77-44c6-84a8-3754aa3f69a7	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-06 16:47:36.928181+00	2025-07-06 16:48:36.928181+00	f
6d7eb88c-5936-4f9e-bd51-8e4260e83a97	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-06 20:42:50.208418+00	2025-07-06 20:43:50.208418+00	f
11884f39-2a81-491b-8d52-d54b06b22869	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.512786317367397	-69.82768184557243	\N	2025-07-07 03:06:37.135666+00	2025-07-07 03:07:37.135666+00	f
60ecf118-818c-4ddc-bc99-884d7b33352a	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.463077940642158	-69.93000906776555	\N	2025-07-08 20:35:03.259117+00	2025-07-08 20:36:03.259117+00	f
375a4b2a-5ca0-4b4c-85cd-aca22a6a1a59	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.512788965491737	-69.82767397573802	\N	2025-07-09 02:34:58.966725+00	2025-07-09 02:35:58.966725+00	f
642a4fc6-0450-4d61-848b-4c50e5c8d1fb	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-09 03:21:50.467911+00	2025-07-09 03:22:50.467911+00	f
fcca83da-5494-4a96-82c2-0369fe608a04	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-09 21:25:41.200041+00	2025-07-09 21:26:41.200041+00	f
f51ab5d9-dc21-4f6e-96ea-0cc497fcd07c	e294a283-3655-4b93-a207-04f486438f37	Federico Montero	18.44077570343886	-69.89437879370051	Naco, Santo Domingo	2025-06-21 13:43:49.97+00	2025-06-21 14:43:49.97+00	f
7982de03-e483-4ce2-b421-83e0c0089011	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Josias Perez	18.469274754597905	-69.88374991273221	La Esperilla, Santo Domingo	2025-04-21 04:29:50.153+00	2025-04-21 05:29:50.153+00	f
baac197e-fd1a-442f-83fc-1b10d384b22b	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	18.45727694927127	-69.90485950616048	Villa Consuelo, Santo Domingo	2025-04-18 14:54:41.087+00	2025-04-18 15:54:41.087+00	f
1bf60fcc-e5dc-412f-a064-5e9177a36b1f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	18.49734397584549	-69.89415950569577	Piantini, Santo Domingo	2025-06-18 09:20:14.517+00	2025-06-18 10:20:14.517+00	f
58c4fa5f-3ceb-4df8-bbbe-fea0bc272de8	51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	18.4647	-69.9302	Calle Pedro Henríquez Ureña #123, Santiago de los Caballeros, República Dominicana	2025-07-11 04:25:15.881718+00	2025-07-11 04:26:15.881718+00	t
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, full_name, phone, created_at, updated_at, first_name, last_name, document_type, document_number, address, neighborhood, city, birth_date, gender, must_change_password) FROM stdin;
51d869f4-fa16-4633-9121-561817fce43d	Armando Noel Charle	+18298026640	2025-06-15 01:55:41.052582+00	2025-06-15 02:49:16.777+00	Armando	Noel Charle	cedula	223-0018154-6	Calle Caonabo #7	Los Trinitarios II	Medellín	1985-08-15	masculino	f
e294a283-3655-4b93-a207-04f486438f37	Federico Montero	+18099198851	2025-07-05 14:24:02.533189+00	2025-07-05 14:26:17.745+00	Federico	Montero	cedula	001-0304340-3	Club de Leones	Alma Rosa I	Medellín	1984-11-07	masculino	f
99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Josias Perez	+18098028341	2025-07-05 21:49:07.200448+00	2025-07-05 21:51:07.695+00	Josias	Perez	cedula	001-1853302-5	13300 Luxbury Loop	bellavista	Medellín	1989-06-19	masculino	f
a09cd383-3c5a-4f9f-8c5a-036761a96873	Joan Karl	+18095082307	2025-07-07 02:57:33.490802+00	2025-07-07 03:04:08.657+00	Joan	Karl	pasaporte	123-4567899-9	Carretera Independencia # 1	Gascue	Medellín	1970-01-01	masculino	f
131c625c-8329-48ce-9b74-67991bd070fd	Franklin Alcantara	+18493570321	2025-07-09 02:28:40.55583+00	2025-07-09 01:36:00.226+00	Franklin	Alcantara	cedula	402-1887748-4	Winston Arnaud Esq Guarocuya	El Millon	Medellín	2001-03-21	masculino	f
ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Armando Noel	+18099990000	2025-07-10 16:10:54.869207+00	2025-07-10 16:11:59.484+00	Armando	Noel	cedula	223-0000000-0	Calle Caonabo #7	Los Trinitarios II	Medellín	1985-08-15	masculino	f
e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruth Esther Santana de Noel	+18492128259	2025-07-05 03:31:12.142715+00	2025-07-11 02:52:06.110793+00	Ruth Esther	Santana de Noel	cedula	223-0058772-6	Calle Caonabo no. 7b	Lo trinitarios 2	Medellín	1987-09-08	femenino	t
\.


--
-- Data for Name: report_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_metrics (id, report_id, metric_name, metric_value, metric_type, category, created_at) FROM stdin;
\.


--
-- Data for Name: report_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_schedules (id, name, report_type, frequency, filters, created_by, is_active, last_generated_at, next_generation_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, user_id, title, description, category, status, latitude, longitude, image_url, created_at, updated_at, address, neighborhood, priority, resolved_at, assigned_to, resolution_notes, citizen_satisfaction) FROM stdin;
89de7c06-a038-4939-8a4e-2ae5b5fdd233	51d869f4-fa16-4633-9121-561817fce43d	El camion no pasa por mi calle	El camion de basura no pasa por mi calle y tengo que llevar la basura a los contenedores.	basura	pendiente	\N	\N	\N	2025-06-15 02:21:21.73749+00	2025-06-15 02:21:21.73749+00	Calle Caonabo #7	Los Trinitarios II	media	\N	\N	\N	\N
e706f63f-50b0-4e2f-ab73-d2bc4f8f4545	51d869f4-fa16-4633-9121-561817fce43d	El camion no pasa por mi calle	El camion de basura no pasa por mi calle. A veces dicen que no entran porque hay un baden muy profundo en una de las calles, y por otra de sus entradas hay unos cables electricos muy bajos.	basura	pendiente	\N	\N	\N	2025-06-15 17:28:23.136171+00	2025-06-15 17:28:23.136171+00	Calle Caonabo #7	Los Trinitarios II	media	\N	\N	\N	\N
782d9a94-cd85-4a0d-a862-9b89deeaf7f0	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en la esquina de mi calle	Falta una bombilla en la esquina de mi casa que es una esquina muy oscura y es una esquina en la que hemos tenido varios atracos.	iluminacion	pendiente	18.51284980	-69.82763360	\N	2025-07-04 16:13:42.754139+00	2025-07-04 16:13:42.754139+00	Calle Caonabo #7	Los Trinitarios II	media	\N	\N	\N	\N
e2568242-bef1-49d7-980a-6cffb2c0cd58	51d869f4-fa16-4633-9121-561817fce43d	Hoyos en la calle	En nuestra entrada hay un hoyo muy grande que hace que los vehículos no puedan pasar bien y muchos han dejado el bumper ahí. Favor atender a eso.	baches	pendiente	\N	\N	\N	2025-07-05 00:13:37.748994+00	2025-07-05 00:13:37.748994+00	Manzana 4703	Invivienda	media	\N	\N	\N	\N
edd8cc94-5f78-45e8-bd81-84e7c39d3988	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.43454296	-69.89451513	\N	2025-04-30 20:30:11.694+00	2025-04-30 20:30:11.694+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	\N	\N	\N	\N
928de736-5508-4b2a-a735-74a4e4d61287	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2025-03-07 06:15:59.571+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-04-02 05:52:59.982+00	\N	\N	\N
e889f81c-7978-4824-8a3f-32c42df3374b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2024-09-19 19:38:58.433+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
94326bc0-1885-4d0b-8b91-5ae9f2d98115	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.50000000	-69.98300000	\N	2025-04-12 06:21:25.933+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-05-06 01:57:39.009+00	\N	\N	\N
8881ec82-8938-4f3b-8cc8-ee1697276f0d	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.50000000	-69.98300000	\N	2025-08-02 11:24:04.878+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
f700999f-ff33-4af9-95b6-5cd855d7cb2b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Ensanche Julieta. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.41341451	-69.95107899	\N	2024-10-06 22:52:39.22+00	2024-10-06 22:52:39.22+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-11-03 06:38:33.944+00	\N	\N	\N
184bceee-b1f3-47d0-bf94-7bfd7b43c3d5	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Villa Francisca	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48014042	-70.00592115	\N	2024-07-30 21:16:37.045+00	2024-07-30 21:16:37.045+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	\N	\N	\N	\N
fd3c62b5-7830-47e9-8904-2588cc6340a3	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en parque de Ensanche Julieta	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.41667922	-69.88931965	\N	2025-08-21 08:18:12.755+00	2025-08-21 08:18:12.755+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	alta	2025-08-31 21:43:05.386+00	\N	\N	\N
833b2fd8-79b1-42bb-9ec7-dadbb2bfc9d8	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46533358	-69.99201835	\N	2024-08-04 13:34:33.186+00	2024-08-04 13:34:33.186+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-08-19 15:15:35.413+00	\N	\N	\N
9bef0456-fa5f-4739-b47c-a6af178f229b	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.55782586	-69.89685782	\N	2025-09-20 13:11:01.804+00	2025-09-20 13:11:01.804+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	\N	\N	\N	\N
b5ed7450-543b-45ff-aecf-4ea9dc78bd1b	e294a283-3655-4b93-a207-04f486438f37	Daños en pavimento cerca de Los Cacicazgos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2024-10-21 16:08:32.511+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
654d0c41-d300-42fc-9707-668a7f233ff0	e294a283-3655-4b93-a207-04f486438f37	Calle intransitable por hoyos	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.50000000	-69.98300000	\N	2025-09-11 06:43:33.622+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
6fba44ca-2d7b-4044-a913-a5f6b75c8143	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Zona muy oscura por las noches	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-08-08 16:58:14.879+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-08-31 03:26:42.911+00	\N	\N	\N
c8116613-098c-4b8b-96c0-ce342acdb967	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47900000	-69.93300000	\N	2024-09-22 11:49:35.148+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
2e4283b7-5a59-4019-84aa-0751295b6de9	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 32	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.55774433	-69.91906664	\N	2024-08-18 00:53:32.022+00	2024-08-18 00:53:32.022+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-09-16 04:04:09.195+00	\N	\N	\N
e00ea748-9152-475e-a614-7196426dd0ef	131c625c-8329-48ce-9b74-67991bd070fd	Calle intransitable por hoyos	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.42095139	-69.88929197	\N	2024-10-09 10:03:55.882+00	2024-10-09 10:03:55.882+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-10-20 19:24:50.09+00	\N	\N	\N
ca3c278c-7784-4446-8f02-f60e4250dcf0	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 43	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2024-07-25 07:40:35.328+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
28d9a528-51ce-4932-9fc1-a7ba006ad7e3	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Villa Francisca	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47362251	-69.99286399	\N	2024-11-06 18:26:21.268+00	2024-11-06 18:26:21.268+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-11-17 15:18:25.456+00	\N	\N	\N
7f4e2795-d717-4fcf-9f5b-775e1c2c3568	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.55002554	-69.87183823	\N	2024-11-22 22:29:11.872+00	2024-11-22 22:29:11.872+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	2024-12-05 07:35:02.978+00	\N	\N	\N
4d85b128-3150-42b8-9e0b-a50960351bde	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Acumulación de basura en la esquina de Calle 42	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.51638095	-69.90687359	\N	2024-10-24 19:55:23.18+00	2024-10-24 19:55:23.18+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	\N	\N	\N	\N
fdc3d240-1b94-4a6b-8097-b9688c8f4efc	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruido excesivo en las noches	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47829365	-69.91172378	\N	2024-11-04 03:41:31.784+00	2024-11-04 03:41:31.784+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
668cf127-1928-484e-bb92-5f13e54fb6d0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50687188	-69.91491155	\N	2024-12-29 16:57:42.94+00	2024-12-29 16:57:42.94+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
76483091-3045-43c4-a43b-2a9b55733db2	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 23	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46700000	-69.86700000	\N	2025-08-14 19:52:10.445+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
3667a3b7-887f-4cc1-8d77-762c2d250434	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.43843177	-69.95246677	\N	2024-07-12 13:50:03.016+00	2024-07-12 13:50:03.016+00	Naco, Santo Domingo	Naco	alta	2024-07-22 07:25:06.796+00	\N	\N	\N
14bd1d29-4086-4784-8f6c-b478d5474d1e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Ensanche Julieta	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.49302938	-69.87692320	\N	2025-05-05 18:22:02.726+00	2025-05-05 18:22:02.726+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	\N	\N	\N	\N
068d85ba-7e81-4316-8a0a-e4bee4d8ae62	e294a283-3655-4b93-a207-04f486438f37	Falta de vigilancia en Villa Francisca	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.44608792	-69.92928061	\N	2025-01-02 07:45:40.13+00	2025-01-02 07:45:40.13+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-01-11 13:44:12.702+00	\N	\N	\N
cc41b85c-e5a9-4344-a9eb-c6860cd0c9be	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en pavimento cerca de Piantini	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.50000000	-69.98300000	\N	2025-09-16 06:11:50.227+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
2c5f78f9-0767-4d60-9f5f-e603e0a20bc6	131c625c-8329-48ce-9b74-67991bd070fd	Postes de luz averiados en Calle 40	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2024-08-14 12:30:35.211+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	\N	\N	\N	\N
8d874ef9-730b-4893-81e4-7696d663ddcd	e294a283-3655-4b93-a207-04f486438f37	Contenedores desbordados en Gazcue	Se reporta acumulación de basura en el sector Gazcue. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47900000	-69.93300000	\N	2024-08-31 02:50:07.153+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2024-09-03 14:07:46.519+00	\N	\N	\N
9e3b711a-1ccf-4f2a-8698-8a348e1791f2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Ruido excesivo en las noches	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47900000	-69.93300000	\N	2025-02-24 03:32:53.233+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
d60939bd-45cc-43bf-a59e-786a8362b7e0	51d869f4-fa16-4633-9121-561817fce43d	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.52137290	-69.99119554	\N	2025-06-03 15:23:53.882+00	2025-06-03 15:23:53.882+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
553d7163-c274-4c09-995e-48b87f39fab9	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48462222	-69.95209868	\N	2024-07-19 16:08:24.777+00	2024-07-19 16:08:24.777+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
e2343ebb-4ce0-431e-b056-8ef919788e6c	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 25	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.43441359	-69.92148046	\N	2024-12-08 12:45:54.519+00	2024-12-08 12:45:54.519+00	Villa Francisca, Santo Domingo	Villa Francisca	media	\N	\N	\N	\N
5e99915d-24c5-4364-92fe-8891b286c1c9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46676909	-69.96196877	\N	2024-12-01 02:47:41.572+00	2024-12-01 02:47:41.572+00	Villa Francisca, Santo Domingo	Villa Francisca	media	\N	\N	\N	\N
e919a394-b405-48f8-9126-62219e16c5a7	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46700000	-69.86700000	\N	2025-03-04 09:14:22.431+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-03-14 16:36:06.8+00	\N	\N	\N
a7d05059-eb30-40e0-9adc-a3e986001b8f	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2025-02-17 17:17:38.032+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
3358ce76-4746-4dc7-9c8a-292cbc99ad69	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.50000000	-69.98300000	\N	2024-07-29 03:58:59.851+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2024-07-30 14:56:39.809+00	\N	\N	\N
3606f824-8d64-4839-826d-8b1e61109ed5	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.55206695	-69.99493857	\N	2025-07-08 19:22:13.137+00	2025-07-08 19:22:13.137+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	\N	\N	\N	\N
213b6b3a-803c-44a8-b895-8b58424b778a	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46700000	-69.86700000	\N	2025-05-31 20:45:57.104+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2025-06-24 11:57:51.722+00	\N	\N	\N
eff40be1-b12e-427d-b149-e87b54ec6ea9	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 47	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.50000000	-69.98300000	\N	2025-06-28 02:26:18.656+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-07-11 15:07:20.813+00	\N	\N	\N
62a9687f-b6e1-4e4d-a3e1-dcfbcbe8b2c7	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2024-09-10 12:57:23.981+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-10-07 22:26:30.692+00	\N	\N	\N
1c778fb4-0903-4f17-827e-8fa080a20be3	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de iluminación en parque de Piantini	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2024-08-30 04:52:03.015+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-09-28 03:50:45.585+00	\N	\N	\N
3ac6f2c8-ef60-4b81-8656-0737894026ad	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Ensanche Julieta. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.49423557	-69.94049577	\N	2024-10-24 10:00:49.43+00	2024-10-24 10:00:49.43+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-10-24 23:08:14.656+00	\N	\N	\N
6ed93ede-560b-4d68-9e7e-506e3bd20981	e294a283-3655-4b93-a207-04f486438f37	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.41529278	-69.95137726	\N	2025-02-19 19:00:30.985+00	2025-02-19 19:00:30.985+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-03-17 01:17:28.977+00	\N	\N	\N
1e2bbaf9-31ac-42ee-b3b4-01630734e215	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48954483	-69.87087446	\N	2025-03-18 15:12:01.325+00	2025-03-18 15:12:01.325+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-04-01 09:09:46.638+00	\N	\N	\N
98efbc72-5c89-4e09-95a0-c0a0ffb79db7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.49372269	-69.95079090	\N	2025-01-01 09:52:45.635+00	2025-01-01 09:52:45.635+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-01-06 14:26:40.561+00	\N	\N	\N
391de510-dccb-4911-8d3d-4064da83afb3	51d869f4-fa16-4633-9121-561817fce43d	Contenedores desbordados en Naco	Se reporta acumulación de basura en el sector Naco. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.52544831	-69.86919364	\N	2025-01-20 01:13:27.318+00	2025-01-20 01:13:27.318+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
c97b0e8b-9595-4d1d-824b-6ccb5e5399c2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Animales callejeros en Ensanche Julieta	Problema general reportado en Ensanche Julieta que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47898386	-69.87742029	\N	2024-11-02 22:19:47.15+00	2024-11-02 22:19:47.15+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	alta	2024-11-16 07:54:42.623+00	\N	\N	\N
24de7c64-e8ec-4f6f-8da9-d6f91afb9d6a	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.46700000	-69.86700000	\N	2025-02-16 16:19:46.821+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-03-10 03:57:30.516+00	\N	\N	\N
646b7b5c-a4bd-4717-8b59-0b9f020800db	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.51693506	-69.90635991	\N	2024-12-09 02:39:33.325+00	2024-12-09 02:39:33.325+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	\N	\N	\N	\N
814a4ef3-8463-42d0-958e-423c9733a2d7	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.42618481	-69.88969640	\N	2024-12-17 22:59:37.672+00	2024-12-17 22:59:37.672+00	Villa Francisca, Santo Domingo	Villa Francisca	baja	2025-01-13 08:32:47.627+00	\N	\N	\N
a46b1b12-b99e-4943-b5e8-9528b26967bf	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Villa Consuelo	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.52144873	-69.86727625	\N	2024-08-09 15:56:36.723+00	2024-08-09 15:56:36.723+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-08-28 07:58:50.693+00	\N	\N	\N
d7727013-5848-4927-beb2-4c22c164506e	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.52054489	-69.89195294	\N	2025-06-23 08:45:14.958+00	2025-06-23 08:45:14.958+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
501157d8-808d-4da9-9d5a-cf2b27f0b6df	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46700000	-69.86700000	\N	2025-06-01 08:21:49.516+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	\N	\N	\N	\N
74634404-5e4f-43c8-b485-9b598821dff3	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-11-16 20:29:09.281+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	baja	\N	\N	\N	\N
100e7e78-91f9-41f9-b765-461b3b8ec308	a09cd383-3c5a-4f9f-8c5a-036761a96873	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.50000000	-69.98300000	\N	2024-12-04 21:23:19.278+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-01-03 14:31:46.322+00	\N	\N	\N
587f89f4-d726-41aa-be5b-4784bd52a29a	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en Ensanche Julieta que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.49126757	-69.93817487	\N	2024-12-03 12:11:14.168+00	2024-12-03 12:11:14.168+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-12-18 11:28:41.028+00	\N	\N	\N
f7d7cac6-1166-478a-be60-81005cfcb4b2	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Ensanche Julieta. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.55564392	-69.99139785	\N	2025-02-03 01:18:01.317+00	2025-02-03 01:18:01.317+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2025-02-17 07:11:25.231+00	\N	\N	\N
761f60ce-781c-4e4e-a777-53880ddbe6dc	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Postes de luz averiados en Calle 18	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.41742225	-69.90218496	\N	2025-04-22 18:33:41.814+00	2025-04-22 18:33:41.814+00	Naco, Santo Domingo	Naco	media	2025-05-03 12:54:44.039+00	\N	\N	\N
dc4d89d2-99d7-453d-bc13-0428c2a5c369	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 3	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.54921946	-69.92973497	\N	2024-12-04 01:53:38.587+00	2024-12-04 01:53:38.587+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	2024-12-20 00:20:09.256+00	\N	\N	\N
488e0c24-f47a-4a4c-98bf-c1c0407008e3	a09cd383-3c5a-4f9f-8c5a-036761a96873	Contenedores desbordados en Naco	Se reporta acumulación de basura en el sector Naco. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.44180297	-69.99313678	\N	2024-12-14 04:40:30.182+00	2024-12-14 04:40:30.182+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
eb27ed0e-1a58-4410-842d-534504c801c3	51d869f4-fa16-4633-9121-561817fce43d	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46700000	-69.86700000	\N	2025-08-27 01:44:07.117+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
b989dc8d-871a-4b82-9217-0c93b6a02b41	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en parque de Villa Duarte	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46700000	-69.86700000	\N	2024-09-12 11:13:18.468+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
044bac4b-25dd-46ef-b6f7-ce94b896d86d	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Ensanche Julieta. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.43993316	-69.89490944	\N	2024-09-07 23:50:26.926+00	2024-09-07 23:50:26.926+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	2024-09-30 03:56:32.628+00	\N	\N	\N
0ffa7936-5967-43e5-aa0d-70a365d3a105	a09cd383-3c5a-4f9f-8c5a-036761a96873	Urgente reparación de vía principal	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.53891568	-69.95214763	\N	2024-07-19 11:15:47.105+00	2024-07-19 11:15:47.105+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-07-23 12:16:38.873+00	\N	\N	\N
d81cfd21-485b-4d6e-bac0-f86697583584	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.55866024	-70.00225994	\N	2024-12-19 11:29:01.337+00	2024-12-19 11:29:01.337+00	Villa Francisca, Santo Domingo	Villa Francisca	media	\N	\N	\N	\N
4d71e0bc-4570-40a3-9445-64d60c4a9c6a	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.41922379	-69.97637003	\N	2025-11-11 07:16:26.136+00	2025-11-11 07:16:26.136+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-12-04 08:10:44.29+00	\N	\N	\N
6d636680-4889-4cf1-883b-3aebe4e8df55	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Postes de luz averiados en Calle 5	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46700000	-69.86700000	\N	2024-11-19 21:29:28.199+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2024-12-11 01:24:13.952+00	\N	\N	\N
88513592-7857-4261-bb9f-423ae17452b4	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46700000	-69.86700000	\N	2024-08-03 16:52:16.55+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-08-28 07:31:30.106+00	\N	\N	\N
71c0a2df-d9c5-4f47-a766-5adf691c61e4	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.55313055	-69.93375380	\N	2024-12-24 05:56:04.147+00	2024-12-24 05:56:04.147+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	2025-01-05 22:08:01.491+00	\N	\N	\N
fb789ced-cff2-40a1-8541-78bab3310dc1	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46513122	-69.86447039	\N	2024-10-15 20:21:09.648+00	2024-10-15 20:21:09.648+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-11-14 17:45:05.703+00	\N	\N	\N
29b35c12-fb83-48d2-bd92-bb2c43b36c68	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46767137	-69.86423822	\N	2025-05-02 01:35:23.599+00	2025-05-02 01:35:23.599+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-05-24 14:30:22.646+00	\N	\N	\N
bf86d543-e6d8-4639-b8da-c008623f06c2	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 22	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47163131	-69.86172858	\N	2024-12-08 17:08:40.819+00	2024-12-08 17:08:40.819+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	\N	\N	\N	\N
74cd90b8-e473-4636-be62-46b627cc2b16	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Piantini	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.50000000	-69.98300000	\N	2024-07-17 13:45:39.545+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	2024-08-02 01:21:07.163+00	\N	\N	\N
d1fd55ed-d4ae-4530-97ce-910852f5d017	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 33	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47900000	-69.93300000	\N	2025-06-02 02:19:37.877+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
40c558c2-2c4b-4cef-a817-dd2c46ee054f	131c625c-8329-48ce-9b74-67991bd070fd	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47500000	-69.92500000	\N	2025-08-31 03:55:46.673+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2025-08-31 14:50:54.97+00	\N	\N	\N
adf8e938-cf21-463c-bbbb-901d7b656541	51d869f4-fa16-4633-9121-561817fce43d	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47200000	-69.92800000	\N	2025-05-09 18:52:45.883+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-05-19 07:31:44.159+00	\N	\N	\N
cbd4c49f-f4cb-4d73-856d-e7d3e6d387ce	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Postes de luz averiados en Calle 41	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.43131324	-69.93819383	\N	2024-09-26 11:30:05.428+00	2024-09-26 11:30:05.428+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	\N	\N	\N	\N
1320ddcc-3206-44a8-ac24-ad1b40ae1323	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50789685	-69.93624732	\N	2024-12-11 23:35:04.936+00	2024-12-11 23:35:04.936+00	Villa Francisca, Santo Domingo	Villa Francisca	media	\N	\N	\N	\N
4cc34ac7-f4e7-41fb-a132-a74e2107b377	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Villa Consuelo	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.52244097	-69.90194226	\N	2025-02-09 01:48:14.027+00	2025-02-09 01:48:14.027+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	\N	\N	\N	\N
a59f6e20-abb0-495c-8b1b-0dc59f3b43c5	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46700000	-69.86700000	\N	2024-09-26 01:57:50.17+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-10-06 18:20:03.827+00	\N	\N	\N
f0d3df6f-842e-4592-8d86-172712098c87	a09cd383-3c5a-4f9f-8c5a-036761a96873	Área insegura durante la noche	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46700000	-69.86700000	\N	2024-09-08 06:45:07.128+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	\N	\N	\N	\N
46b31e2d-ce51-4ccc-9778-723b05c5d2f4	e294a283-3655-4b93-a207-04f486438f37	Baches profundos en Calle 3	Deterioro significativo del pavimento en Villa Francisca debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46540001	-69.96498257	\N	2024-12-19 10:12:43.583+00	2024-12-19 10:12:43.583+00	Villa Francisca, Santo Domingo	Villa Francisca	baja	2025-01-02 04:12:58.577+00	\N	\N	\N
9396d47d-6bdd-4479-8ec4-393f63898bd8	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46700000	-69.86700000	\N	2024-11-13 19:44:44.027+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	2024-11-25 09:38:01.842+00	\N	\N	\N
b2136fc4-6cbc-4933-ac08-3046a489d193	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46700000	-69.86700000	\N	2024-08-14 01:14:11.317+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	\N	\N	\N	\N
e523c64d-77fb-47c8-a707-85b0904b8cb0	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de iluminación en parque de Naco	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48519003	-69.89061040	\N	2024-08-22 16:49:45.06+00	2024-08-22 16:49:45.06+00	Naco, Santo Domingo	Naco	baja	\N	\N	\N	\N
32869cdf-d398-4290-b293-d8c5c1cba2f3	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.54464879	-70.00428242	\N	2024-10-14 04:21:56.206+00	2024-10-14 04:21:56.206+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	\N	\N	\N	\N
076dffcb-bd3c-4921-b973-0e664e5dd255	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Consuelo. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.52723366	-69.98139579	\N	2025-05-15 02:06:39.447+00	2025-05-15 02:06:39.447+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
9c8739fc-ebb9-474b-ad32-5eb8b2c62321	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.55522676	-69.91738563	\N	2024-08-09 18:13:37.048+00	2024-08-09 18:13:37.048+00	Villa Francisca, Santo Domingo	Villa Francisca	baja	\N	\N	\N	\N
e7107bc5-a0ed-4d40-a2e0-436d84f7d829	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Ensanche Julieta que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.44201770	-69.90108711	\N	2024-09-22 00:31:56.509+00	2024-09-22 00:31:56.509+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-10-12 05:47:51.511+00	\N	\N	\N
42acde3a-742c-47e6-9096-bfcc093a7ed9	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 25	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46700000	-69.86700000	\N	2024-10-23 09:43:33.834+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
619aefa2-0f03-493c-8c8a-ce77b7bd2e4e	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46700000	-69.86700000	\N	2024-10-28 03:03:02.459+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2024-11-05 21:20:11.039+00	\N	\N	\N
85f59f2a-29d5-460c-a1ab-bdf98d5601e8	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2024-07-14 02:18:30.111+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	baja	\N	\N	\N	\N
ba3d47a0-151b-4a51-a324-99703a37c4d9	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2024-09-10 04:11:58.432+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2024-09-27 05:34:30.305+00	\N	\N	\N
2fe47d86-b8e5-42c5-976c-e8241f14ea9d	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 48	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.44065001	-69.88640099	\N	2024-10-22 13:13:59.224+00	2024-10-22 13:13:59.224+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-10-23 04:29:29.518+00	\N	\N	\N
8a54f3c5-8c05-4715-96af-5e4f5e9d56a7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.53016472	-69.94810196	\N	2024-09-19 22:07:15.601+00	2024-09-19 22:07:15.601+00	Villa Francisca, Santo Domingo	Villa Francisca	baja	2024-10-07 16:52:23.596+00	\N	\N	\N
06ab3322-f3de-409d-bde6-37cb90a04f2c	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48069870	-69.97760745	\N	2024-12-22 12:47:19.46+00	2024-12-22 12:47:19.46+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-01-01 14:25:39.074+00	\N	\N	\N
c0df1991-8719-4387-9f1e-5e1740c0474f	e294a283-3655-4b93-a207-04f486438f37	Área insegura durante la noche	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46700000	-69.86700000	\N	2025-05-16 14:20:16.449+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	\N	\N	\N	\N
50ce436f-2447-4233-8482-af4b289ae792	a09cd383-3c5a-4f9f-8c5a-036761a96873	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.46700000	-69.86700000	\N	2025-03-29 22:19:44.629+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
e77cdc12-2ed8-4bbc-bd2e-3fbbe8c247df	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Área insegura durante la noche	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46700000	-69.86700000	\N	2025-04-22 04:46:18.551+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-05-14 08:56:10.168+00	\N	\N	\N
ff15040d-31ae-4248-9b05-ce7fc77acd3b	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Naco	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.42655811	-69.98335525	\N	2025-04-11 14:59:41.186+00	2025-04-11 14:59:41.186+00	Naco, Santo Domingo	Naco	baja	\N	\N	\N	\N
2fcac589-699f-4ceb-820e-44ac33f5a415	51d869f4-fa16-4633-9121-561817fce43d	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.50899382	-69.93360537	\N	2025-03-19 20:46:13.044+00	2025-03-19 20:46:13.044+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
f29efc96-8568-405f-89b2-aabd7752b521	51d869f4-fa16-4633-9121-561817fce43d	Urgente reparación de vía principal	Deterioro significativo del pavimento en Naco debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46474306	-69.93190419	\N	2025-06-06 21:58:16.993+00	2025-06-06 21:58:16.993+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
8f5eca97-a3ea-4a4f-8a08-c981856c7b9d	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de mejoras en parque	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46700000	-69.86700000	\N	2025-04-29 06:39:41.641+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	\N	\N	\N	\N
fe3aa5da-0240-424b-acb1-862a514a01c3	131c625c-8329-48ce-9b74-67991bd070fd	Robos frecuentes en la zona	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.50000000	-69.98300000	\N	2024-08-28 00:53:51.589+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-09-11 12:12:05.023+00	\N	\N	\N
4e269f4c-335a-4c59-938b-e05711267819	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Naco	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50640482	-69.95318209	\N	2025-04-06 21:12:51.051+00	2025-04-06 21:12:51.051+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
ac0f3c04-75e9-4d1b-9a95-8375706d79da	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.51889274	-70.00032481	\N	2024-08-30 22:07:14.744+00	2024-08-30 22:07:14.744+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-09-09 17:46:14.357+00	\N	\N	\N
c772eeca-5361-4e33-b886-4b7f796e629d	131c625c-8329-48ce-9b74-67991bd070fd	Falta de vigilancia en Los Cacicazgos	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2025-01-20 16:40:25.061+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-02-09 13:46:49.17+00	\N	\N	\N
727099fa-f77f-4797-86a5-5430b3885a5a	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-08-21 17:28:28.795+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2025-08-22 15:38:03.452+00	\N	\N	\N
e5f01bbf-3ddd-4396-921a-443085d0bbd2	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Gualey	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.47500000	-69.92500000	\N	2025-02-19 18:39:31.614+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2025-03-02 19:18:38.236+00	\N	\N	\N
09c1d7b0-3b6d-4497-9663-9e96bc6df286	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47500000	-69.92500000	\N	2024-09-23 15:22:53.211+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-10-03 14:32:26.473+00	\N	\N	\N
46483019-74ad-4037-9ff2-19006a093882	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en Naco debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.55579372	-69.97459831	\N	2025-08-13 05:27:18.288+00	2025-08-13 05:27:18.288+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
d0ff8f30-f4e1-4d0b-9651-4a49f2c684c4	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.43401425	-69.93775428	\N	2025-03-03 13:44:03.604+00	2025-03-03 13:44:03.604+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-03-22 16:50:11.217+00	\N	\N	\N
34803fd5-8592-4154-911e-816cfca31e28	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Baches profundos en Calle 9	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.49420786	-69.91918067	\N	2025-04-25 08:34:12.037+00	2025-04-25 08:34:12.037+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2025-05-08 07:52:38.836+00	\N	\N	\N
77b8ba84-b33e-4d80-9bab-ae1617b21ca4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Robos frecuentes en la zona	Situación de inseguridad reportada en Ensanche Julieta. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.52016633	-69.92373028	\N	2024-10-19 15:19:07.764+00	2024-10-19 15:19:07.764+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-10-27 09:21:12.068+00	\N	\N	\N
ad067734-8aa5-435d-aefb-17d31918b657	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2024-09-27 17:13:49.849+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-10-16 03:29:29.429+00	\N	\N	\N
a5c508bb-37e2-4c37-8ce1-d115b4811fe5	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Los Cacicazgos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2024-10-08 02:32:06.285+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	baja	\N	\N	\N	\N
ee376415-5d41-41a9-9b17-ad312b8de90c	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.50000000	-69.98300000	\N	2025-04-04 16:55:59.925+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
bc494e7c-61b1-4a83-9eff-a862820d20aa	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.50000000	-69.98300000	\N	2024-12-27 07:41:33.698+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-01-07 12:33:47.674+00	\N	\N	\N
e4627cce-0eb7-4de0-b72a-bfab748cc757	e294a283-3655-4b93-a207-04f486438f37	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.41733103	-69.87478756	\N	2025-04-03 21:45:42.885+00	2025-04-03 21:45:42.885+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-04-13 01:10:19.153+00	\N	\N	\N
63f71761-90db-4a34-9249-bf1f407c92f4	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48250363	-69.93546962	\N	2024-08-22 22:18:22.023+00	2024-08-22 22:18:22.023+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-08-26 22:13:27.999+00	\N	\N	\N
07f5795d-fda0-4769-89dc-e92721d351fd	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de mejoras en parque	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.43124364	-69.88801568	\N	2025-05-12 08:11:36.84+00	2025-05-12 08:11:36.84+00	Naco, Santo Domingo	Naco	media	2025-05-15 07:45:57.738+00	\N	\N	\N
fd29eb7d-96d2-47dc-976f-deb000f04da8	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Villa Duarte	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46700000	-69.86700000	\N	2025-04-12 08:55:54.257+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
3a677f84-2d42-4fac-b6e1-422fc0b3a65e	51d869f4-fa16-4633-9121-561817fce43d	Acumulación de basura en la esquina de Calle 47	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46700000	-69.86700000	\N	2024-12-24 21:38:17.443+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-01-23 18:07:27.083+00	\N	\N	\N
474f7cb4-d1d1-4494-a655-94ea86c58b46	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2025-02-21 17:23:50.498+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-03-04 02:34:02.898+00	\N	\N	\N
21a739ae-e0d2-4942-ba3f-cc7016f2342d	131c625c-8329-48ce-9b74-67991bd070fd	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.50000000	-69.98300000	\N	2025-09-19 03:08:19.927+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
288678e6-f875-4109-ba4a-a01e8f223246	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Naco	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.55984640	-69.86429617	\N	2025-02-14 03:41:14.255+00	2025-02-14 03:41:14.255+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
284fb4f9-7086-46d6-a530-f6ca14d2c69a	a09cd383-3c5a-4f9f-8c5a-036761a96873	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.43107015	-69.96508214	\N	2025-12-02 17:16:02.448+00	2025-12-02 17:16:02.448+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-12-26 01:30:47.426+00	\N	\N	\N
a8afbdcd-9bab-4e75-b55b-1c330f69589a	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48934825	-69.87672702	\N	2025-05-12 09:05:58.66+00	2025-05-12 09:05:58.66+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	\N	\N	\N	\N
9929dcf7-1f94-4854-b004-535fb66c222f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en pavimento cerca de Ensanche Julieta	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46510973	-69.90938005	\N	2024-10-09 01:50:57.998+00	2024-10-09 01:50:57.998+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-10-17 20:10:41.266+00	\N	\N	\N
f0499ba9-d4b6-4162-b990-19869347742c	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.52941390	-69.86577769	\N	2025-10-05 00:58:56.564+00	2025-10-05 00:58:56.564+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-10-27 01:43:59.991+00	\N	\N	\N
d909907a-bdf0-4c1f-b4a7-f468fb7b26cf	131c625c-8329-48ce-9b74-67991bd070fd	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46700000	-69.86700000	\N	2024-10-02 06:26:40.963+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-10-21 11:02:58.251+00	\N	\N	\N
b750e1e1-71eb-42ea-8ac9-8a9ac882b093	51d869f4-fa16-4633-9121-561817fce43d	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46700000	-69.86700000	\N	2024-10-31 11:12:15.877+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-11-30 07:00:20.561+00	\N	\N	\N
53d42e69-1d92-4f6f-bf20-8a5996b99048	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Acumulación de basura en la esquina de Calle 27	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46700000	-69.86700000	\N	2025-02-12 06:55:43.899+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
8a8443c2-987d-4218-ac89-b82417d7a19f	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de vigilancia en Villa Consuelo	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.53656441	-69.94938953	\N	2024-08-01 14:23:28.722+00	2024-08-01 14:23:28.722+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-08-05 08:17:17.136+00	\N	\N	\N
2400f795-2b74-414d-96eb-77d970369353	131c625c-8329-48ce-9b74-67991bd070fd	Bombillas fundidas en varias calles	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.42238355	-69.94160316	\N	2025-06-01 12:07:08.276+00	2025-06-01 12:07:08.276+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
53594e1d-274e-4b3d-ba9c-8f1a2cf03949	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.51908714	-69.98494389	\N	2025-09-25 19:26:55.177+00	2025-09-25 19:26:55.177+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2025-09-27 20:27:44.517+00	\N	\N	\N
e5f2b1c2-ed31-43ab-8127-29c7a5631df3	51d869f4-fa16-4633-9121-561817fce43d	Área insegura durante la noche	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.47981632	-69.96655733	\N	2025-03-23 19:05:36.029+00	2025-03-23 19:05:36.029+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-04-10 08:58:04.757+00	\N	\N	\N
6324595b-231b-4ad0-af5d-31c0443d98ef	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Villa Consuelo	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.53457617	-69.90782979	\N	2025-06-14 17:23:15.435+00	2025-06-14 17:23:15.435+00	Villa Consuelo, Santo Domingo	Villa Consuelo	baja	\N	\N	\N	\N
c840c5d6-dbfb-4c3d-9a61-bde4914df8e5	51d869f4-fa16-4633-9121-561817fce43d	Ruido excesivo en las noches	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46700000	-69.86700000	\N	2024-11-22 21:20:29.858+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	2024-12-01 07:32:21.84+00	\N	\N	\N
e82e10cb-788a-4072-a343-a06eff1fb6b7	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Baches profundos en Calle 46	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.50000000	-69.98300000	\N	2025-05-04 01:07:37.568+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	\N	\N	\N	\N
4d6939c5-c0e2-4008-a22f-7fe8b9db350e	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 20	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-12-10 20:11:33.959+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-12-30 11:27:27.296+00	\N	\N	\N
e6ba247a-cd82-4726-b90b-4a1e3e91f92e	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2025-02-14 18:21:06.443+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	2025-02-17 02:41:36.529+00	\N	\N	\N
cc201c2c-521c-49cf-82ab-9ee9615f23ad	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.45972022	-69.91593738	\N	2025-04-19 05:06:33.068+00	2025-04-19 05:06:33.068+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	2025-05-15 07:12:45.772+00	\N	\N	\N
95cb1e9e-ece7-4126-be7e-6acf0b260a08	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46852581	-69.98779579	\N	2024-12-11 08:45:48.437+00	2024-12-11 08:45:48.437+00	Naco, Santo Domingo	Naco	baja	2025-01-07 00:58:14.072+00	\N	\N	\N
4482216f-5616-4fff-9dcf-fae0d19ca646	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Animales callejeros en Villa Duarte	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46700000	-69.86700000	\N	2025-06-11 22:12:52.187+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	\N	\N	\N	\N
c77bd1d8-56c2-4d02-81d2-9bc0d7e36f23	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.46700000	-69.86700000	\N	2024-09-15 20:55:26.047+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	\N	\N	\N	\N
cb0fbec8-5c42-4165-9703-13e15319c25f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-07-11 14:08:26.173+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-07-12 00:32:29.08+00	\N	\N	\N
81df0291-469c-4610-bbac-c738734e9366	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Gazcue. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.47900000	-69.93300000	\N	2024-10-19 04:28:59.953+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2024-10-22 17:28:48.67+00	\N	\N	\N
547e5d61-4012-41bc-b9f4-1c0f719bc1c7	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 11	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.42160472	-69.95291665	\N	2024-07-28 19:42:26.313+00	2024-07-28 19:42:26.313+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-08-23 15:02:09.144+00	\N	\N	\N
09663d8f-90d3-4ba1-ac4d-3b6773db42be	e294a283-3655-4b93-a207-04f486438f37	Falta de vigilancia en Naco	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48047537	-69.86497245	\N	2025-01-04 04:22:29.381+00	2025-01-04 04:22:29.381+00	Naco, Santo Domingo	Naco	alta	\N	\N	\N	\N
3e20edde-d842-4632-bbfe-d3c3a2ddcd4f	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46803180	-69.98863379	\N	2025-07-22 03:35:59.677+00	2025-07-22 03:35:59.677+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	\N	\N	\N	\N
686cf2ac-ac71-4266-ad5a-7adae1d18735	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48233619	-69.85982286	\N	2024-08-09 23:36:00.927+00	2024-08-09 23:36:00.927+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	alta	2024-08-24 22:27:45.931+00	\N	\N	\N
0527e943-4365-43f9-aa63-b946bc59237c	e294a283-3655-4b93-a207-04f486438f37	Contenedores desbordados en Ensanche Julieta	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.51137641	-69.87013458	\N	2024-11-22 12:38:54.146+00	2024-11-22 12:38:54.146+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-12-11 12:04:34.093+00	\N	\N	\N
42a6b09f-5da9-4dde-b407-46bc6441ae9b	131c625c-8329-48ce-9b74-67991bd070fd	Postes de luz averiados en Calle 50	Falta de iluminación pública en Villa Francisca crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.43974010	-69.98073012	\N	2024-10-29 16:56:33.404+00	2024-10-29 16:56:33.404+00	Villa Francisca, Santo Domingo	Villa Francisca	baja	\N	\N	\N	\N
85e64f96-f366-436a-a78e-ffda57e91d97	e294a283-3655-4b93-a207-04f486438f37	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2025-05-17 00:57:19.144+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	2025-05-30 08:25:04.011+00	\N	\N	\N
967c41f2-2f55-48f9-a569-a1ffad61dbbd	51d869f4-fa16-4633-9121-561817fce43d	Zona muy oscura por las noches	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2025-07-12 13:32:30.966+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
fdefe140-b2d9-4a9f-8090-052112afab59	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 39	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.55262375	-69.86002906	\N	2024-10-17 16:08:20.845+00	2024-10-17 16:08:20.845+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-11-04 17:00:21.227+00	\N	\N	\N
6d549ee9-e9f9-4f4d-b01c-62c8b26f2da2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de mejoras en parque	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.55281183	-69.98121365	\N	2024-10-01 02:28:01.851+00	2024-10-01 02:28:01.851+00	Naco, Santo Domingo	Naco	baja	2024-10-04 20:11:45.185+00	\N	\N	\N
5464bd4e-6332-46bd-b96f-4fb6bc57ab69	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Francisca. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48161270	-69.90912102	\N	2025-03-14 06:43:57.364+00	2025-03-14 06:43:57.364+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-03-17 04:47:55.485+00	\N	\N	\N
428feece-c658-4e55-99b0-6547cb801b78	a09cd383-3c5a-4f9f-8c5a-036761a96873	Acumulación de basura en la esquina de Calle 14	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2025-01-04 05:33:11.201+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-01-29 00:32:21.173+00	\N	\N	\N
4bf90397-e31c-4074-ad6c-1741faa46156	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.51664095	-69.92222173	\N	2024-08-31 10:44:31.001+00	2024-08-31 10:44:31.001+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-09-18 21:22:54.032+00	\N	\N	\N
01b5f2f5-e226-45f0-beaa-6f1fb9028b03	131c625c-8329-48ce-9b74-67991bd070fd	Calle intransitable por hoyos	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.45616671	-69.97855411	\N	2025-10-15 07:45:03.76+00	2025-10-15 07:45:03.76+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2025-11-04 08:14:42.605+00	\N	\N	\N
c69ca396-3354-4001-b3f1-094c63160a76	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.41666763	-69.96567493	\N	2024-07-19 00:38:54.785+00	2024-07-19 00:38:54.785+00	Naco, Santo Domingo	Naco	media	2024-07-20 21:37:45.477+00	\N	\N	\N
7eed095b-23dd-48bc-91bb-cc69b454c3a0	131c625c-8329-48ce-9b74-67991bd070fd	Contenedores desbordados en Villa Francisca	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.55766236	-69.99554586	\N	2024-07-21 14:52:32.947+00	2024-07-21 14:52:32.947+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	2024-08-16 10:53:54.656+00	\N	\N	\N
20e9ba6d-7547-4bbe-93d6-2e55a10b6f1e	e294a283-3655-4b93-a207-04f486438f37	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46700000	-69.86700000	\N	2024-08-25 06:12:01.388+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2024-09-03 04:55:07.857+00	\N	\N	\N
110be05b-3d92-464a-bcb7-0dec6dd7b84c	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46700000	-69.86700000	\N	2024-12-12 06:27:59.752+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-12-16 09:48:33.295+00	\N	\N	\N
f427bb85-fa24-46a1-b00d-8ecfd74c722b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Zona muy oscura por las noches	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2025-02-24 16:28:00.666+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-03-09 12:24:55.383+00	\N	\N	\N
b4ecbb6f-3c11-40dc-91f5-d2c623d57900	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2025-05-13 00:18:33.743+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-05-21 15:35:41.747+00	\N	\N	\N
402575b6-c7da-43e9-94a9-2be457242552	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Gualey	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47500000	-69.92500000	\N	2025-07-04 09:37:04.18+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-07-28 19:59:59.154+00	\N	\N	\N
1a5d450e-ed1a-4f99-a25a-26685bf09e50	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.44691665	-69.89534996	\N	2025-03-04 10:00:02.663+00	2025-03-04 10:00:02.663+00	Naco, Santo Domingo	Naco	alta	2025-03-25 01:38:23.287+00	\N	\N	\N
45d34ac1-d3c3-449a-82d0-32b488b68935	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de vigilancia en Villa Duarte	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46700000	-69.86700000	\N	2024-07-21 19:29:33.884+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
5040260a-cb55-40d0-a500-4c8722c98c9b	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46700000	-69.86700000	\N	2024-10-30 01:11:59.131+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	2024-11-20 15:15:51.122+00	\N	\N	\N
b5f87db2-715f-4e10-8642-11ce0886305b	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 21	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.50000000	-69.98300000	\N	2024-07-15 12:15:21.953+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
24d8b484-ff63-4f8a-9b3e-edba2db199bb	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2025-05-06 01:53:43.015+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
65cab909-facf-4066-ae8e-d6325407a69a	131c625c-8329-48ce-9b74-67991bd070fd	Problemas con el suministro de agua	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.42317315	-69.92333265	\N	2025-01-10 06:17:39.853+00	2025-01-10 06:17:39.853+00	Naco, Santo Domingo	Naco	media	2025-01-11 07:09:35.605+00	\N	\N	\N
3f14cd07-4a38-4060-8d6a-332500837ad7	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de mejoras en parque	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46205033	-69.94309259	\N	2024-10-20 21:24:11.999+00	2024-10-20 21:24:11.999+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	2024-11-17 14:09:34.865+00	\N	\N	\N
d3a9998e-1226-4800-8ed0-0ce4922c2d61	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46700000	-69.86700000	\N	2025-08-22 12:29:35.978+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2025-09-09 13:41:33.21+00	\N	\N	\N
37a39009-5bac-446b-8833-7d1aae052ea8	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2025-05-08 10:19:07.611+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	\N	\N	\N	\N
0c221c24-5ed0-4e10-913b-460e9be03218	e294a283-3655-4b93-a207-04f486438f37	Animales callejeros en Los Cacicazgos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2025-04-02 07:49:47.723+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-04-30 15:23:54.137+00	\N	\N	\N
680c444b-ad13-42c8-9828-8178a0dae254	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Cableado eléctrico en mal estado	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.50000000	-69.98300000	\N	2025-09-29 01:58:22.905+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2025-10-21 21:49:36.621+00	\N	\N	\N
2a4473e8-f81b-4c0a-9173-adeb2f6b7d94	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.50000000	-69.98300000	\N	2024-10-27 05:56:48.766+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-11-26 05:24:58.989+00	\N	\N	\N
9996d270-0cf2-4e55-8f4c-67fef85cc581	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Urgente reparación de vía principal	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47900000	-69.93300000	\N	2024-10-23 16:29:32.05+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
824bfea2-ed58-4344-b434-12e85950f303	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46800000	-69.94000000	\N	2025-08-25 13:19:17.65+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	2025-09-17 05:33:55.922+00	\N	\N	\N
b55aba08-7996-4e21-b936-2ba6d7704e28	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Ensanche Julieta debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.55526995	-69.89692100	\N	2025-03-06 22:07:35.065+00	2025-03-06 22:07:35.065+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	\N	\N	\N	\N
220adbb5-572e-46f7-9df9-03a528d316c5	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Villa Consuelo	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47004006	-69.96433961	\N	2025-09-05 11:46:34.789+00	2025-09-05 11:46:34.789+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
4d0e157b-ac89-486a-9837-6d639398b119	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Consuelo. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.53799423	-69.99073564	\N	2024-09-01 00:21:03.097+00	2024-09-01 00:21:03.097+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2024-09-11 20:37:53.924+00	\N	\N	\N
fddc6d49-25b6-4910-b4bf-dd5cdd1191bb	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 39	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.53107237	-69.96453313	\N	2025-02-16 14:56:33.325+00	2025-02-16 14:56:33.325+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	alta	2025-03-14 10:19:35.551+00	\N	\N	\N
e18616ae-54fd-4c23-9e00-101613903ac8	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Julieta. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.53941596	-69.95761772	\N	2024-07-31 03:27:39.091+00	2024-07-31 03:27:39.091+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	baja	2024-08-23 23:56:31.203+00	\N	\N	\N
1a08cfe8-58d6-410c-a70f-01c2f6766c73	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Naco	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.41197505	-69.94800306	\N	2025-01-11 17:07:07+00	2025-01-11 17:07:07+00	Naco, Santo Domingo	Naco	media	2025-01-31 18:16:45.17+00	\N	\N	\N
7defadfd-1cb4-4dbb-a74b-8c0bae1c558b	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Villa Consuelo. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.42006680	-69.91626558	\N	2025-01-10 12:04:29.727+00	2025-01-10 12:04:29.727+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	\N	\N	\N	\N
427094fb-2ae9-4d0c-9904-d8ba959eba51	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Los Cacicazgos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2024-09-25 19:26:18.196+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-09-26 08:00:49.32+00	\N	\N	\N
595eb815-a2ae-476e-89a6-8e8e8f2c9efa	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 50	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2025-10-19 23:04:58.81+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-11-13 09:52:47.183+00	\N	\N	\N
5d4bbb85-f6ff-4086-8b84-92a0cbc2e6ac	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Contenedores desbordados en Gualey	Se reporta acumulación de basura en el sector Gualey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47500000	-69.92500000	\N	2025-01-11 13:56:27.734+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-02-04 20:52:50.413+00	\N	\N	\N
fd2c4a39-fb82-4223-9309-11db11543dec	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Bella Vista	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47200000	-69.92800000	\N	2025-04-15 06:34:46.965+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
c0fa107d-5c06-4a56-82fa-20e3c4b88f59	131c625c-8329-48ce-9b74-67991bd070fd	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.50112590	-69.86695812	\N	2025-02-04 14:14:37.153+00	2025-02-04 14:14:37.153+00	Villa Consuelo, Santo Domingo	Villa Consuelo	baja	2025-02-06 08:32:34.244+00	\N	\N	\N
bf0211a3-ce81-40d7-bcad-2606d222c9db	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47043971	-69.88267612	\N	2024-09-24 11:55:44.125+00	2024-09-24 11:55:44.125+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2024-10-15 09:03:13.133+00	\N	\N	\N
8bb401c3-6a40-4a23-9263-49d3cedc28d6	131c625c-8329-48ce-9b74-67991bd070fd	Falta de iluminación en parque de Ensanche Julieta	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.45838118	-69.91310757	\N	2024-10-28 20:10:00.362+00	2024-10-28 20:10:00.362+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-11-04 20:17:36.81+00	\N	\N	\N
22497f33-8c60-4f5f-8e1c-c9c9f4d70066	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46700000	-69.86700000	\N	2024-09-27 14:25:12.925+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
f11ed9a0-86b9-4478-b844-fc337c0c9c9d	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2024-07-23 08:10:42.529+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
53c3aad1-d844-49fe-b1cd-a01f99a2e5d9	e294a283-3655-4b93-a207-04f486438f37	Falta de iluminación en parque de Piantini	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.50000000	-69.98300000	\N	2025-08-21 10:51:13.006+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2025-09-10 23:30:36.248+00	\N	\N	\N
72d9c18c-bb9a-4c30-aa3c-a3099f89a7c3	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Consuelo crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.45545168	-69.98456821	\N	2025-08-20 13:31:45.846+00	2025-08-20 13:31:45.846+00	Villa Consuelo, Santo Domingo	Villa Consuelo	baja	\N	\N	\N	\N
a3cbf8fc-100c-48c8-8e10-c9290b89b039	e294a283-3655-4b93-a207-04f486438f37	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.51242735	-69.92478608	\N	2025-05-06 01:36:36.376+00	2025-05-06 01:36:36.376+00	Naco, Santo Domingo	Naco	media	2025-05-29 01:53:38.906+00	\N	\N	\N
c51a7a03-c7d8-42d9-89ef-8d8ebab82c94	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.44065895	-69.98664823	\N	2025-05-11 12:26:52.65+00	2025-05-11 12:26:52.65+00	Naco, Santo Domingo	Naco	media	2025-05-17 22:48:54.828+00	\N	\N	\N
09beae78-b499-41b9-ab24-fcc3839f9c9e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Contenedores desbordados en Villa Francisca	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.54368883	-69.87029185	\N	2025-06-23 06:00:38.23+00	2025-06-23 06:00:38.23+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	\N	\N	\N	\N
9c8b8d25-9d0b-44f3-8303-5f128e61ca0d	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.46700000	-69.86700000	\N	2025-01-24 07:59:36.091+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
2be906b6-657a-4f13-9213-4174b9679293	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ruido excesivo en las noches	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.44703405	-69.91649060	\N	2024-07-28 14:40:45.872+00	2024-07-28 14:40:45.872+00	Villa Francisca, Santo Domingo	Villa Francisca	media	\N	\N	\N	\N
83d8f09e-b568-44b1-ae17-00bb4a6c498e	51d869f4-fa16-4633-9121-561817fce43d	Área insegura durante la noche	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.49532476	-69.97905090	\N	2025-05-16 04:51:11.628+00	2025-05-16 04:51:11.628+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-06-04 18:26:23.175+00	\N	\N	\N
1cffb127-0e38-4284-8ec4-87cf6ada9876	51d869f4-fa16-4633-9121-561817fce43d	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Consuelo. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.51484836	-70.00283920	\N	2025-03-22 04:01:16.805+00	2025-03-22 04:01:16.805+00	Villa Consuelo, Santo Domingo	Villa Consuelo	baja	2025-04-11 13:01:17.022+00	\N	\N	\N
95a5ac8e-e04a-481f-8be8-34b016d6eff3	51d869f4-fa16-4633-9121-561817fce43d	Postes de luz averiados en Calle 35	Falta de iluminación pública en Naco crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48804502	-69.99977275	\N	2025-03-06 02:21:09.864+00	2025-03-06 02:21:09.864+00	Naco, Santo Domingo	Naco	alta	2025-03-28 16:37:49.847+00	\N	\N	\N
0acd1597-2209-4762-8cc9-0e45e8c406c3	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.52720840	-69.98517436	\N	2025-05-27 15:47:43.139+00	2025-05-27 15:47:43.139+00	Villa Consuelo, Santo Domingo	Villa Consuelo	alta	2025-06-20 10:10:05.534+00	\N	\N	\N
4dff5ad2-efc5-43b2-a9e7-7937f3e28ad9	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46700000	-69.86700000	\N	2024-09-26 16:50:25.962+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	\N	\N	\N	\N
04a0da98-ed70-4b8c-89fb-6971576af9a0	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46700000	-69.86700000	\N	2024-10-05 10:54:40.711+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-10-28 19:51:36.583+00	\N	\N	\N
c99b4cc5-bf04-4bf8-81e0-365d893789d3	51d869f4-fa16-4633-9121-561817fce43d	Robos frecuentes en la zona	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.50000000	-69.98300000	\N	2024-09-25 21:09:26.961+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-10-13 09:10:16.974+00	\N	\N	\N
0aa0ba10-27c5-449c-b364-ca45ff83f6e6	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en Ensanche Julieta	Problema general reportado en Ensanche Julieta que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.42698248	-69.99828575	\N	2024-07-28 19:20:03.128+00	2024-07-28 19:20:03.128+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-08-15 08:37:59.015+00	\N	\N	\N
b1bd9e6f-3659-4f02-996b-a7d25936dc85	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Francisca. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.42454337	-69.99352664	\N	2025-02-21 23:03:03.43+00	2025-02-21 23:03:03.43+00	Villa Francisca, Santo Domingo	Villa Francisca	alta	2025-03-11 12:38:30.473+00	\N	\N	\N
d3be0120-7829-40fc-8cdc-2298e02dcc95	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.53709412	-69.88092047	\N	2024-10-06 17:59:42.428+00	2024-10-06 17:59:42.428+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-10-18 01:32:03.263+00	\N	\N	\N
654baad1-f335-4024-a410-9ca275e40a6d	a09cd383-3c5a-4f9f-8c5a-036761a96873	Postes de luz averiados en Calle 25	Falta de iluminación pública en Ensanche Julieta crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.55636186	-69.97439216	\N	2024-07-25 02:01:13.155+00	2024-07-25 02:01:13.155+00	Ensanche Julieta, Santo Domingo	Ensanche Julieta	media	2024-08-16 10:38:56.616+00	\N	\N	\N
ef80a69e-c3c2-48c3-b766-a310de2b46e2	a09cd383-3c5a-4f9f-8c5a-036761a96873	Calle intransitable por hoyos	Deterioro significativo del pavimento en Villa Consuelo debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.54327452	-69.96652074	\N	2025-10-03 01:18:33.899+00	2025-10-03 01:18:33.899+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-10-24 20:08:48.184+00	\N	\N	\N
a65fc4dd-283e-477b-bad6-8b46ebe11ae2	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46700000	-69.86700000	\N	2024-08-31 21:07:32.861+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
24c83c8d-8609-4ace-87e7-5182cb0f1408	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en pavimento cerca de Los Cacicazgos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-06-27 02:15:42.523+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-07-03 18:33:06.555+00	\N	\N	\N
0bba6551-6aa7-40df-92c0-4a54813229d9	51d869f4-fa16-4633-9121-561817fce43d	Ruido excesivo en las noches	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47900000	-69.93300000	\N	2024-07-11 09:55:11.152+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	2024-07-22 17:44:01.419+00	\N	\N	\N
12fe65dc-b89c-4801-affd-6ab9c95028fb	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Gazcue. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47900000	-69.93300000	\N	2025-08-27 06:36:01.443+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2025-09-19 17:21:32.664+00	\N	\N	\N
cef219de-b077-4e60-bc84-1b59b416accd	a09cd383-3c5a-4f9f-8c5a-036761a96873	Calle intransitable por hoyos	Deterioro significativo del pavimento en Naco debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47195491	-69.91701098	\N	2025-11-11 14:51:43.05+00	2025-11-11 14:51:43.05+00	Naco, Santo Domingo	Naco	media	2025-12-07 19:02:43.291+00	\N	\N	\N
f412e49c-bbb3-4172-92de-a17c8eae45dd	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Naco que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.53381867	-69.99724586	\N	2024-09-12 03:00:04.132+00	2024-09-12 03:00:04.132+00	Naco, Santo Domingo	Naco	baja	2024-09-21 15:58:45.179+00	\N	\N	\N
7ad01398-49f7-477d-bfdb-add65a33cfeb	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Ruido excesivo en las noches	Problema general reportado en Villa Consuelo que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47903068	-69.94848424	\N	2025-03-30 04:36:09.745+00	2025-03-30 04:36:09.745+00	Villa Consuelo, Santo Domingo	Villa Consuelo	media	2025-04-28 23:45:37.605+00	\N	\N	\N
0acd659c-50dc-4454-8df3-7cd6b2b5cd34	a09cd383-3c5a-4f9f-8c5a-036761a96873	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Naco. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.42808354	-69.92686727	\N	2025-01-25 14:07:07.604+00	2025-01-25 14:07:07.604+00	Naco, Santo Domingo	Naco	media	\N	\N	\N	\N
f5f6a2c5-24ea-4f3b-8e48-755faf228717	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en Villa Francisca que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.48391948	-69.95680534	\N	2025-01-24 18:44:53.17+00	2025-01-24 18:44:53.17+00	Villa Francisca, Santo Domingo	Villa Francisca	media	2025-02-15 20:25:10.605+00	\N	\N	\N
b87022e6-988b-4aaf-a1a9-2aef478655ad	51d869f4-fa16-4633-9121-561817fce43d	Daños en pavimento cerca de Naco	Deterioro significativo del pavimento en Naco debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46549226	-69.85671984	\N	2025-03-22 10:26:34.099+00	2025-03-22 10:26:34.099+00	Naco, Santo Domingo	Naco	alta	\N	\N	\N	\N
046e842a-c092-4831-a1f2-7206bf1c511e	131c625c-8329-48ce-9b74-67991bd070fd	Daños en aceras y bordillos	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46700000	-69.86700000	\N	2025-03-05 16:05:03.081+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
b322e50a-3ad8-4c8b-9646-c1a48a822bab	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.85600000	\N	2025-01-21 04:28:03.905+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
652f54a2-095a-4211-97d2-ad733f8754af	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 40	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48500000	-69.85600000	\N	2024-11-14 16:33:26.185+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-12-04 19:29:13.202+00	\N	\N	\N
a765752b-fd72-4032-b8e1-073713b2c600	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.85600000	\N	2024-11-05 13:05:59.644+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-11-19 06:52:05.829+00	\N	\N	\N
becf2c82-0eb9-4523-a710-5dcaa7affc43	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47200000	-69.92800000	\N	2025-01-25 00:41:42.808+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-02-07 08:51:50.327+00	\N	\N	\N
7ef760d9-c518-4254-b7fe-b7299fa8b9cd	a09cd383-3c5a-4f9f-8c5a-036761a96873	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.48500000	-69.85600000	\N	2024-12-04 02:44:02.05+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
9b89d048-7c06-4aeb-8e59-491ad63a183d	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.85600000	\N	2024-10-01 20:47:48.008+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
8882b2a5-c91e-4f76-b1ee-30069121de4b	51d869f4-fa16-4633-9121-561817fce43d	Atraco	Acabo de ver que atracaron a una señora 	seguridad	pendiente	18.48500000	-69.87300000	\N	2025-07-05 12:28:13.135941+00	2025-07-11 04:15:42.255791+00	Calle Puerto Rico	Alma Rosa II	media	\N	\N	\N	\N
3ee2463d-c931-49f1-9247-51fc448e986f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Postes de luz averiados en Calle 5	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46700000	-69.86700000	\N	2024-10-07 14:32:39.466+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2024-10-29 07:45:18.393+00	\N	\N	\N
85cfcc5e-9501-4544-b6c9-46c82bc71d6c	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Villa Duarte	Situación de inseguridad reportada en Villa Duarte. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46700000	-69.86700000	\N	2024-09-28 20:31:27.054+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	2024-10-09 19:07:02.138+00	\N	\N	\N
9e29b5af-a7f6-479e-aace-171b5298d678	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 5	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2025-10-23 03:43:10.427+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
e27af522-83f7-4a31-be9c-d39575c5be0f	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 43	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2025-10-23 21:34:15.964+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-10-28 20:45:40.711+00	\N	\N	\N
fc79513c-c1d8-4b75-923d-34d90e2f59e5	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en pavimento cerca de Villa Duarte	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46700000	-69.86700000	\N	2024-08-22 16:24:54.718+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
1541e615-02d3-44f6-b4ff-bcaec9234a63	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Villa Duarte crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46700000	-69.86700000	\N	2025-04-29 13:47:15.228+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-05-18 11:25:14.095+00	\N	\N	\N
34bfc940-aa42-4fec-8248-741ed05c8ec0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Urgente reparación de vía principal	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2025-11-22 21:39:56.416+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	2025-12-16 17:03:06.048+00	\N	\N	\N
6e23d72f-4060-403f-b751-8da1e485afbe	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 20	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46700000	-69.86700000	\N	2026-01-07 08:01:57.073+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	baja	2026-01-30 06:31:05.718+00	\N	\N	\N
c78925be-cf69-4810-9391-d787126294f1	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en Villa Duarte	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46700000	-69.86700000	\N	2025-04-07 20:38:39.065+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
060af195-d796-460c-978a-3a0ceb0c2932	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 8	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2025-03-04 01:45:57.239+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	\N	\N	\N	\N
4492a07d-42c9-483a-ac2c-e30b85c9b0da	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Duarte. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46700000	-69.86700000	\N	2025-08-21 21:32:59.341+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	alta	\N	\N	\N	\N
4fb1ae2a-3194-45b8-8355-bef288cd52f1	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46700000	-69.86700000	\N	2024-07-21 21:03:46.225+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
da487749-e22c-425d-b9bf-ae1653875f77	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Baches profundos en Calle 10	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46700000	-69.86700000	\N	2025-12-17 14:09:03.363+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2025-12-30 02:49:25.941+00	\N	\N	\N
fc7f32c1-f936-437a-96f1-773b866101b9	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Animales callejeros en Villa Duarte	Problema general reportado en Villa Duarte que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46700000	-69.86700000	\N	2024-12-20 18:24:22.775+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	2024-12-30 07:19:10.197+00	\N	\N	\N
e5ffcb82-1013-4f1f-b1b1-a323f361f9aa	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Baches profundos en Calle 43	Deterioro significativo del pavimento en Villa Duarte debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46700000	-69.86700000	\N	2024-11-18 08:46:13.007+00	2025-07-11 04:15:42.255791+00	Villa Duarte, Santo Domingo	Villa Duarte	media	\N	\N	\N	\N
e85176aa-9b66-44c7-8be6-a120ef0dbb2d	e294a283-3655-4b93-a207-04f486438f37	Daños en aceras y bordillos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2025-05-20 18:30:25.287+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
7eb6a585-853a-46c1-a724-5dc33581fe19	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2024-08-31 00:24:02.354+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-09-15 03:48:35.434+00	\N	\N	\N
3890b8bb-20f7-4546-87f3-ba93dc194ac6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2025-05-31 14:17:52.665+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	baja	2025-06-09 20:28:42.152+00	\N	\N	\N
295c5dde-0f73-4187-969c-2b1833d01576	131c625c-8329-48ce-9b74-67991bd070fd	Postes de luz averiados en Calle 14	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2024-10-02 08:03:40.828+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-10-20 09:26:45.318+00	\N	\N	\N
515747a0-7568-4349-a1e6-223f34420975	131c625c-8329-48ce-9b74-67991bd070fd	Daños en aceras y bordillos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2024-07-18 04:57:43.586+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-08-10 12:38:54.609+00	\N	\N	\N
452727c6-39c2-4587-8100-a08a9ff63515	e294a283-3655-4b93-a207-04f486438f37	Ruido excesivo en las noches	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2025-01-01 02:56:37.535+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-01-07 00:21:38.543+00	\N	\N	\N
bf313059-649a-4a1a-85ee-d3a318dec676	a09cd383-3c5a-4f9f-8c5a-036761a96873	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.50000000	-69.98300000	\N	2024-08-23 12:32:49.229+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-09-19 06:26:58.063+00	\N	\N	\N
8954fe87-cbea-4c86-b093-33c3d0db764c	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de Los Cacicazgos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.50000000	-69.98300000	\N	2025-07-26 01:00:24.886+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
a20643a5-6a89-471b-8bcf-e7b80774645c	e294a283-3655-4b93-a207-04f486438f37	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-06-20 20:55:27.367+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	\N	\N	\N	\N
70b6e4e0-b4ef-415d-bebd-2b8960c15672	51d869f4-fa16-4633-9121-561817fce43d	Contenedores desbordados en Los Cacicazgos	Se reporta acumulación de basura en el sector Los Cacicazgos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.50000000	-69.98300000	\N	2025-01-30 22:02:20.093+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-01-31 19:27:09.646+00	\N	\N	\N
be22193d-079a-4f7f-b498-610a71c4dd98	a09cd383-3c5a-4f9f-8c5a-036761a96873	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-05-15 05:08:01.567+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-06-04 04:03:28.023+00	\N	\N	\N
e0b9bb51-4be3-4c46-a2ec-e55a70b458df	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en pavimento cerca de Los Cacicazgos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.50000000	-69.98300000	\N	2024-12-31 08:14:46.422+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
b66af06c-4d8b-46bd-bfde-bd0debae978d	131c625c-8329-48ce-9b74-67991bd070fd	Daños en aceras y bordillos	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2025-06-09 04:48:39.952+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2025-06-18 14:28:11.078+00	\N	\N	\N
1779224d-d6f9-456f-a652-e569f7b467de	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2024-07-26 15:03:34.855+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
a709ae73-9116-47df-ace1-ef39ea3fd1fd	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Los Cacicazgos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2024-09-13 01:43:47.434+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
72e14c35-addf-49ee-b277-d8f0a308910f	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Cacicazgos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2024-12-06 18:10:20.845+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	baja	\N	\N	\N	\N
6221b7b9-6348-43bf-a920-de48f1ea542d	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2025-10-10 14:34:04.773+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	\N	\N	\N	\N
a8df733c-63b4-446c-a483-d3e9b75f91d1	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en Los Cacicazgos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2024-09-24 17:53:55.845+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	media	2024-10-09 21:49:54.903+00	\N	\N	\N
5baeae26-5d0f-407f-985d-ecca4cd954ce	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de iluminación en parque de Los Cacicazgos	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2024-07-14 09:21:53.407+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	\N	\N	\N	\N
ae24d3eb-f8e9-4e4e-a426-b1ec6e236f49	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Los Cacicazgos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2025-04-29 09:39:03.156+00	2025-07-11 04:15:42.255791+00	Los Cacicazgos, Santo Domingo	Los Cacicazgos	alta	\N	\N	\N	\N
6d1d62a5-ebbc-4aba-b36e-6b0f76e30eea	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 2	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2025-03-14 15:24:41.682+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	\N	\N	\N	\N
3f191424-cfae-4294-94e5-018eaa7c51d4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.50000000	-69.98300000	\N	2024-12-16 02:46:58.231+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
00b015dd-6f49-4500-860d-27e38be75220	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Urgente reparación de vía principal	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2024-11-13 04:46:00.572+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
53a5704b-8e88-4aec-8787-e9c3c64d6bb7	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.50000000	-69.98300000	\N	2025-03-26 06:10:30.453+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-04-17 00:31:43.285+00	\N	\N	\N
127b8f04-acb2-4c1d-ae59-37c37343e348	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2025-06-25 06:52:05.226+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	\N	\N	\N	\N
ba8d93c3-aeae-407d-b246-0e782a110b89	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Problemas con el suministro de agua	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2024-10-16 13:02:58.709+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
7d4a6917-2363-464b-952c-8652620a3c1a	51d869f4-fa16-4633-9121-561817fce43d	Ruido excesivo en las noches	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2025-03-22 00:31:22.692+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-03-27 19:01:40.87+00	\N	\N	\N
f7cc2192-9755-4244-a484-8cea1f457b7e	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Acumulación de basura en la esquina de Calle 25	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.50000000	-69.98300000	\N	2024-08-25 02:38:03.893+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
5486558d-18cb-48ec-8340-15f720ae7ff9	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de vigilancia en Piantini	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.50000000	-69.98300000	\N	2024-11-29 15:11:38.525+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2024-12-22 11:09:42.688+00	\N	\N	\N
ba7f7d46-64be-4ee3-a3e0-6e83d1f089f1	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Piantini crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.50000000	-69.98300000	\N	2025-04-13 04:10:04.55+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	2025-04-29 07:20:48.119+00	\N	\N	\N
095983d4-0918-44bc-985b-91540a1688d0	51d869f4-fa16-4633-9121-561817fce43d	Daños en pavimento cerca de Piantini	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.50000000	-69.98300000	\N	2025-05-19 18:55:29.308+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	\N	\N	\N	\N
2971e1cb-07a2-44ba-8674-736785cf11dd	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en aceras y bordillos	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.50000000	-69.98300000	\N	2025-06-22 05:34:46.728+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	2025-06-25 00:31:56.461+00	\N	\N	\N
d95b4d4e-6da3-44dd-9449-26a7864aeaf6	e294a283-3655-4b93-a207-04f486438f37	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.50000000	-69.98300000	\N	2024-11-14 21:45:09.137+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-11-23 07:05:26.751+00	\N	\N	\N
199c0733-9709-4365-a671-deb8bb7b1f65	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2024-12-24 09:45:54.52+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
08b22c55-ddc5-47ea-8253-8b9001473543	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.50000000	-69.98300000	\N	2024-08-12 15:53:13.26+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-09-04 20:57:49.726+00	\N	\N	\N
f7f317d6-dc3a-4a8b-94f3-4764fe694aec	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Piantini. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.50000000	-69.98300000	\N	2025-02-04 14:27:14.067+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	2025-02-17 09:10:04.455+00	\N	\N	\N
e3598944-33b3-45fb-a7fc-3e383f0061ac	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2024-12-15 08:13:15.767+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-01-10 05:21:00.141+00	\N	\N	\N
9d972f23-ae4e-4dc8-9f6b-955ff06cd514	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Baches profundos en Calle 20	Deterioro significativo del pavimento en Piantini debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.50000000	-69.98300000	\N	2025-06-19 07:29:00.396+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
62f92ad0-8411-4797-8b80-8f9926bb13b7	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2025-01-09 09:38:06.061+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	baja	\N	\N	\N	\N
815224d0-4f11-427e-af4a-2975216c1f67	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de mejoras en parque	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.50000000	-69.98300000	\N	2025-05-30 12:27:59.707+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2025-06-03 04:17:00.817+00	\N	\N	\N
ec1930a6-825b-45d7-a56b-f9fd5256ec4c	e294a283-3655-4b93-a207-04f486438f37	Robos frecuentes en la zona	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.50000000	-69.98300000	\N	2025-05-13 07:25:57.122+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
2fc53fc6-c56b-43d4-9f86-6853eea1202f	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Piantini	Situación de inseguridad reportada en Piantini. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.50000000	-69.98300000	\N	2024-12-18 02:59:05.283+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	2024-12-27 23:30:53.208+00	\N	\N	\N
2d88118d-78ae-4060-ac4d-57452580bae9	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de mejoras en parque	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2024-10-30 01:16:50.871+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	media	\N	\N	\N	\N
d7cfd3f2-8a1f-400e-9f5b-8872da5ce039	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en aceras y bordillos	Problema general reportado en Piantini que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.50000000	-69.98300000	\N	2024-10-27 21:14:26.383+00	2025-07-11 04:15:42.255791+00	Piantini, Santo Domingo	Piantini	alta	\N	\N	\N	\N
cabb4ea0-5d4e-42db-9b67-5850510c4f59	51d869f4-fa16-4633-9121-561817fce43d	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47900000	-69.93300000	\N	2025-05-25 07:04:53.28+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-06-19 13:02:15.167+00	\N	\N	\N
9bca129a-10dd-461a-9d46-9ccea08d1706	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en aceras y bordillos	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-06-20 05:07:09.859+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-07-01 21:26:39.339+00	\N	\N	\N
65ed7485-50d0-4e71-b69a-dc944753ecd7	51d869f4-fa16-4633-9121-561817fce43d	Cableado eléctrico en mal estado	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-03-08 01:52:21.587+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
f31fabe1-142f-4f33-b36f-34d94afe55e5	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-05-07 11:40:54.493+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
f25f37bf-71fc-4e39-92db-73ab3e179ffc	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-02-01 14:58:15.508+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
7611fba8-65fb-43b2-81d9-21557aac1332	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Robos frecuentes en la zona	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47900000	-69.93300000	\N	2025-04-28 05:38:06.507+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	\N	\N	\N	\N
c73e56e9-d3b7-4d75-bf01-8f24ece08de9	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Cableado eléctrico en mal estado	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47900000	-69.93300000	\N	2025-07-10 15:31:00.547+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
f0f85166-11ca-4ca1-9748-60cd9b679647	e294a283-3655-4b93-a207-04f486438f37	Falta de vigilancia en Gazcue	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47900000	-69.93300000	\N	2025-03-06 23:30:11.982+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	\N	\N	\N	\N
b0816352-2994-4b0a-bc27-164d2e3d4ad4	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47900000	-69.93300000	\N	2025-02-24 10:07:38.716+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-03-20 06:46:02.843+00	\N	\N	\N
d6ec0431-5fce-4478-ab47-5d5d48c5e5d2	51d869f4-fa16-4633-9121-561817fce43d	Zona muy oscura por las noches	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47900000	-69.93300000	\N	2024-09-16 00:46:44.754+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-09-19 10:02:21.37+00	\N	\N	\N
a957c5c6-cf64-482e-90a5-7362c3f909f1	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Robos frecuentes en la zona	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2024-10-05 02:32:46.322+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
2def299c-2c3e-462b-b356-efc79edcd2cb	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de Gazcue	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47900000	-69.93300000	\N	2025-05-06 02:00:19.487+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-05-28 12:52:28.927+00	\N	\N	\N
9cbd9547-211e-4237-bc72-8157aaa76fde	e294a283-3655-4b93-a207-04f486438f37	Área insegura durante la noche	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2024-08-05 03:03:04.364+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-08-08 23:47:39.942+00	\N	\N	\N
3438492d-0759-4484-b1a9-12e9bf12d398	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2025-01-01 23:38:50.826+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
3a4cbba4-c729-4f33-96fe-3f813023eeeb	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-06-18 11:57:15.899+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
ba1b353a-8540-464c-be49-824879c9cabd	131c625c-8329-48ce-9b74-67991bd070fd	Área insegura durante la noche	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47900000	-69.93300000	\N	2024-07-19 02:04:10.193+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
2e5e589e-9784-41c7-98f5-c711ea3e8a5f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Ruido excesivo en las noches	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2024-10-23 15:31:30.149+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-11-17 19:52:39.215+00	\N	\N	\N
607a6693-d96f-435c-9d78-376cf6117794	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-05-18 15:17:03.474+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-06-02 00:42:50.054+00	\N	\N	\N
fc8afa4e-a038-457f-98ac-28cb3dfe742a	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Acumulación de basura en la esquina de Calle 15	Se reporta acumulación de basura en el sector Gazcue. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47900000	-69.93300000	\N	2024-07-20 16:42:21.05+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2024-08-07 03:47:55.608+00	\N	\N	\N
6b204b63-0e22-44bb-bcf7-06023859d985	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47900000	-69.93300000	\N	2024-09-10 19:41:22.048+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-09-27 06:02:47.929+00	\N	\N	\N
0d8372c5-8915-4ee5-affe-2f94b435d2d9	a09cd383-3c5a-4f9f-8c5a-036761a96873	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47900000	-69.93300000	\N	2025-06-07 23:25:20.466+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
7e285274-b905-4e1f-9526-8e49abc2846a	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en Gazcue	Se reporta acumulación de basura en el sector Gazcue. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47900000	-69.93300000	\N	2024-10-22 15:08:52.47+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	2024-10-28 09:33:09.925+00	\N	\N	\N
395ca416-9e87-4d91-b5ab-e59adad83a94	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2025-06-12 13:35:12.595+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	2025-06-19 17:15:37.755+00	\N	\N	\N
9c4cc86c-c0dd-44df-a21c-8ed716207a13	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47900000	-69.93300000	\N	2024-07-26 15:16:26.766+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
63a6cc00-d2bc-4d66-9507-4f8486e1afe6	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2024-08-27 07:20:42.773+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
425b9a37-f195-49c7-863e-9194c82e3aa1	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de iluminación en parque de Gazcue	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2024-10-14 14:55:04.726+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-10-25 07:15:10.883+00	\N	\N	\N
df2d30c6-ea78-41f5-a861-0579cd9c2629	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-03-09 23:47:26.912+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
d30c8ed9-c30e-44c1-b9bc-6af75d6c3877	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2025-01-19 17:31:14.235+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
531fcec5-858b-43fd-8139-e092be9d44a3	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2024-10-26 20:57:01.251+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
75d1a3d8-534e-4739-a10b-e530785ce77f	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en pavimento cerca de Gazcue	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47900000	-69.93300000	\N	2024-12-22 19:18:59.135+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	\N	\N	\N	\N
d4f3c04c-788d-4d07-9840-916923e9c447	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47900000	-69.93300000	\N	2024-12-07 23:58:06.732+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	2024-12-17 08:25:32.773+00	\N	\N	\N
356e0175-2a3a-4d1f-87e7-a77eda5c35f6	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-05-17 10:22:41.998+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
939ffaee-4aa8-4720-b7fe-c197de9d67b4	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Gazcue que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47900000	-69.93300000	\N	2025-06-01 20:10:14.108+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	alta	\N	\N	\N	\N
4bb5dd48-5c79-4496-8f3c-00a50909783b	131c625c-8329-48ce-9b74-67991bd070fd	Robos frecuentes en la zona	Situación de inseguridad reportada en Gazcue. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47900000	-69.93300000	\N	2024-08-15 14:23:01.979+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
9cf8e140-9b68-45a5-8006-47997ff00ef5	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Zona muy oscura por las noches	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47900000	-69.93300000	\N	2025-07-12 02:41:27.126+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	\N	\N	\N	\N
6ef8e181-a114-44ad-8345-db54dee4cb7a	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47900000	-69.93300000	\N	2025-04-11 20:17:54.928+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2025-04-24 21:21:45.505+00	\N	\N	\N
5cde123c-4dd4-4a33-9c41-0a849cc43789	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Gazcue crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47900000	-69.93300000	\N	2025-04-22 20:15:38.5+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	baja	2025-05-15 00:46:43.139+00	\N	\N	\N
44348c1d-af9c-4628-8f28-56c3677b2143	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Gazcue debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47900000	-69.93300000	\N	2024-09-03 16:42:06.7+00	2025-07-11 04:15:42.255791+00	Gazcue, Santo Domingo	Gazcue	media	2024-10-01 13:10:52.148+00	\N	\N	\N
aa97f98e-9b72-4bd7-8b02-6f020ea960ed	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 45	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2025-04-22 03:02:50.235+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
628d9342-8d79-45fc-a78e-b945e87600a8	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48500000	-69.87300000	\N	2025-10-27 17:09:03.156+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
99d6b2fe-37bc-433f-8a83-f4fb3f97b233	e294a283-3655-4b93-a207-04f486438f37	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.87300000	\N	2025-02-10 19:50:13.212+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
cd4db92e-683d-44c8-9680-36d168bda0f4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48500000	-69.87300000	\N	2025-05-14 20:11:01.897+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
360ebae7-b64f-49b4-a502-e77e7e8085a7	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48500000	-69.87300000	\N	2025-07-09 14:01:26.838+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2025-08-05 11:54:52.264+00	\N	\N	\N
fa38cb16-9385-4ac2-86c3-4185e2b383c6	a09cd383-3c5a-4f9f-8c5a-036761a96873	Calle intransitable por hoyos	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48500000	-69.87300000	\N	2024-11-15 05:35:42.42+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
0e727e8d-3193-4be7-b2bb-e6ab8ba4b1b7	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.87300000	\N	2025-01-04 05:02:21.56+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
3da9f7ac-1e13-452a-8b7a-b4093eaa9bf6	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48500000	-69.87300000	\N	2024-09-26 03:45:40.495+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2024-09-29 00:23:27.412+00	\N	\N	\N
ca453baa-c621-4ddb-be9e-6cf75eee4c8e	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 17	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48500000	-69.87300000	\N	2025-06-13 08:44:33.004+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
fa6ee3d2-a7db-4f8a-89e3-0ac468249a6a	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 37	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48500000	-69.87300000	\N	2025-05-19 01:02:48.096+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
65c7aa9e-ce5f-409f-9456-071f941d33ad	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en aceras y bordillos	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.87300000	\N	2025-01-31 14:44:14.235+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
901b7d4a-4d21-482f-bac9-0dfc0f8df3e7	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.87300000	\N	2025-01-12 05:40:58.662+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-01-20 12:56:49.647+00	\N	\N	\N
3205254e-d183-4bac-81a0-528a375d5027	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48500000	-69.87300000	\N	2025-06-14 14:52:20.573+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
512989a7-0e53-4be9-bbe9-d4bb8e170cb8	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2025-07-02 20:53:25.411+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-07-19 05:48:42.19+00	\N	\N	\N
596bb8cc-4f84-4549-bb9b-cde82482acbf	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en Alma Rosa	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.48500000	-69.87300000	\N	2025-04-19 03:09:51.836+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2025-04-19 21:09:17.571+00	\N	\N	\N
7c535e97-952c-4817-b0af-b593ad71dcf5	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.48500000	-69.87300000	\N	2024-08-26 09:57:45.461+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
60dd1d6c-0288-4613-a542-5de060440476	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Problemas con el suministro de agua	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.87300000	\N	2024-11-21 16:53:48.423+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2024-12-09 11:10:30.569+00	\N	\N	\N
3f6b0afc-d7fa-4ab3-b452-29ade01f2053	131c625c-8329-48ce-9b74-67991bd070fd	Área insegura durante la noche	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48500000	-69.87300000	\N	2025-05-21 14:13:36.35+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-05-24 14:07:19.061+00	\N	\N	\N
17c3b7fd-2e1c-474f-b9da-8929f456a903	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2025-05-10 01:34:29.683+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2025-06-03 02:53:02.512+00	\N	\N	\N
adadeb88-d814-49b8-8e1c-6fa28e7a49f5	131c625c-8329-48ce-9b74-67991bd070fd	Robos frecuentes en la zona	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.87300000	\N	2024-11-07 16:45:50.742+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2024-11-11 16:28:13.818+00	\N	\N	\N
92eaab19-a95b-46dc-a3d6-14ca2acb709f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en aceras y bordillos	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.87300000	\N	2025-03-30 16:31:47.647+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
5f8bd884-c0c7-4692-adab-02be80310165	e294a283-3655-4b93-a207-04f486438f37	Robos frecuentes en la zona	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.87300000	\N	2024-11-22 02:47:53.011+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2024-11-23 21:11:45.172+00	\N	\N	\N
cec5ae29-d406-4d80-a504-bc75b758c31d	e294a283-3655-4b93-a207-04f486438f37	Daños en pavimento cerca de Alma Rosa	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48500000	-69.87300000	\N	2025-05-12 19:00:58.836+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-06-05 12:03:46.347+00	\N	\N	\N
ea297585-758f-40de-b727-bfd2ec57045c	e294a283-3655-4b93-a207-04f486438f37	Baches profundos en Calle 21	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2025-11-29 03:56:15.377+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-12-13 16:15:17.921+00	\N	\N	\N
b65dc96a-6d19-488d-9872-f25914abe942	e294a283-3655-4b93-a207-04f486438f37	Baches profundos en Calle 34	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48500000	-69.87300000	\N	2024-07-25 03:17:30.856+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
8c739002-cc3f-444a-80be-45e8b3b486bc	131c625c-8329-48ce-9b74-67991bd070fd	Cableado eléctrico en mal estado	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48500000	-69.87300000	\N	2025-05-20 12:14:54.624+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2025-05-27 09:15:20.568+00	\N	\N	\N
23b67edb-92cb-46b6-9a00-e9bb9a18e849	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2025-05-11 19:22:18.721+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-05-29 08:33:38.488+00	\N	\N	\N
01d218cb-72bf-46ec-99f6-0d17b2fc10e7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Zona muy oscura por las noches	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2024-09-16 10:46:45.716+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
b10165aa-a2bc-41ff-8d19-dd91559eaef0	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48500000	-69.87300000	\N	2024-11-14 23:27:22.904+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
7b372a67-661d-4787-b121-513f381ef4ad	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de mejoras en parque	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.87300000	\N	2024-07-31 11:46:14.432+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2024-08-04 02:05:34.001+00	\N	\N	\N
3875254b-66c6-495e-b7f9-a1776e780b3d	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48500000	-69.87300000	\N	2025-07-15 16:47:50.445+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-08-08 04:57:26.41+00	\N	\N	\N
b503ced8-2ef6-45c1-b379-1bb76c68ab68	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2025-11-17 13:16:35.38+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
afe52b43-1f64-488d-8a3c-97ddfd1cd689	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48500000	-69.87300000	\N	2024-08-21 06:12:43.593+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2024-09-07 01:37:03.754+00	\N	\N	\N
9d9446b9-6119-4674-8013-b6691db54e33	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.48500000	-69.87300000	\N	2025-04-11 03:41:47.898+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
1ebc9d3f-48c3-4710-b7a9-7a46e53ccb5e	e294a283-3655-4b93-a207-04f486438f37	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48500000	-69.87300000	\N	2025-07-17 06:51:13.447+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
d29d8ed8-c531-4844-89ab-a8a8b25fc418	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2025-06-23 21:58:53.651+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	\N	\N	\N	\N
89915f7b-d92d-4c1b-8257-d1092480aa11	a09cd383-3c5a-4f9f-8c5a-036761a96873	Urgente reparación de vía principal	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2024-09-04 04:06:23.564+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2024-09-23 11:40:57.568+00	\N	\N	\N
581ff877-76a2-4b69-98ee-02d9cf8a8a49	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Ruido excesivo en las noches	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.87300000	\N	2024-08-25 15:59:38.864+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
0d1571ff-842f-410e-938b-cd918e05f5fe	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.87300000	\N	2024-09-03 14:30:13.724+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	\N	\N	\N	\N
10ac6a28-0f88-4eaa-894c-fd000a6aef8d	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de mejoras en parque	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48500000	-69.87300000	\N	2025-05-24 17:52:03.788+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-06-19 05:26:49.712+00	\N	\N	\N
5a6725ec-64fe-41b3-9ab5-d14997443ea9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48500000	-69.87300000	\N	2025-06-08 00:06:09.081+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
36f1e107-4f00-49f5-8bc6-81ed0b29467a	51d869f4-fa16-4633-9121-561817fce43d	Área insegura durante la noche	Situación de inseguridad reportada en Alma Rosa. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48500000	-69.87300000	\N	2025-02-27 22:05:59.902+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-03-03 14:37:49.354+00	\N	\N	\N
49604807-f854-4faa-b8ba-9442c3aca5bd	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48500000	-69.87300000	\N	2024-12-28 08:59:04.091+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2025-01-18 15:27:00.099+00	\N	\N	\N
5afc9cde-bf65-4d12-8b9c-a554aab8eb66	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48500000	-69.87300000	\N	2024-07-14 08:26:59.449+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2024-08-09 17:58:46.359+00	\N	\N	\N
0f39036c-e51c-4ce9-b7aa-bb27b82ae887	51d869f4-fa16-4633-9121-561817fce43d	Postes de luz averiados en Calle 14	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2025-07-14 08:14:54.049+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	2025-07-31 19:23:59.342+00	\N	\N	\N
c95271ce-9039-4644-8192-453a87ee67bd	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48500000	-69.87300000	\N	2024-07-30 22:43:06.887+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
25651725-61ab-4b93-9f05-7b6fc9cafef6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Baches profundos en Calle 5	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2024-10-13 07:06:28.736+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2024-10-27 12:15:53.378+00	\N	\N	\N
5dccd3b0-eb66-4664-870f-ee17d60c5709	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Alma Rosa debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.87300000	\N	2024-12-16 20:33:08.925+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	\N	\N	\N	\N
3e445812-188b-42d7-9f90-444127f55102	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Alma Rosa. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48500000	-69.87300000	\N	2024-11-24 14:20:09.029+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	alta	\N	\N	\N	\N
a46b804d-a85c-471a-9704-754969c593d1	51d869f4-fa16-4633-9121-561817fce43d	Postes de luz averiados en Calle 26	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48500000	-69.87300000	\N	2025-06-28 11:29:37.242+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-07-16 20:34:53.592+00	\N	\N	\N
d7bafd25-8a10-4d56-96b1-d3519d6f52d2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Postes de luz averiados en Calle 41	Falta de iluminación pública en Alma Rosa crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48500000	-69.87300000	\N	2025-04-27 15:58:23.714+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	media	2025-05-21 03:00:47.443+00	\N	\N	\N
e6e5b882-08f1-4784-b59c-5f8d1377c87e	e294a283-3655-4b93-a207-04f486438f37	Animales callejeros en Alma Rosa	Problema general reportado en Alma Rosa que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.87300000	\N	2024-10-07 21:31:22.105+00	2025-07-11 04:15:42.255791+00	Alma Rosa, Santo Domingo	Alma Rosa	baja	2024-11-06 04:06:41.528+00	\N	\N	\N
7177dd7f-8f1c-4fcc-b0ff-5557e54e5913	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.85600000	\N	2025-05-31 01:22:30.91+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-06-04 20:57:02.803+00	\N	\N	\N
51a43898-dced-4378-b8f0-6410c97910d1	e294a283-3655-4b93-a207-04f486438f37	Falta de vigilancia en Los Minas	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.48500000	-69.85600000	\N	2025-03-29 20:04:00.965+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	baja	\N	\N	\N	\N
0d53944e-16bb-4e4c-a78d-8f80e6388951	131c625c-8329-48ce-9b74-67991bd070fd	Cableado eléctrico en mal estado	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48500000	-69.85600000	\N	2025-06-17 05:25:29.678+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
6930e1ee-3399-4c61-8760-071d19239430	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en aceras y bordillos	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.85600000	\N	2024-10-14 20:52:46.988+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	baja	\N	\N	\N	\N
2ec268ea-a484-4939-b824-4a431a0f673b	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Los Minas. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48500000	-69.85600000	\N	2025-01-17 10:59:32.98+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
19d6864d-5f67-471e-baa8-c7e9286f96e9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48500000	-69.85600000	\N	2025-06-02 03:55:42.595+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	\N	\N	\N	\N
8240964f-2eaa-41da-b517-eb628e2346d0	e294a283-3655-4b93-a207-04f486438f37	Daños en aceras y bordillos	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.85600000	\N	2025-02-11 01:50:10.534+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-02-22 14:10:52.714+00	\N	\N	\N
56f2eff0-fd5f-4ab7-8c42-eab6d3f608d1	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48500000	-69.85600000	\N	2024-09-03 18:32:26.701+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-09-10 19:40:56.154+00	\N	\N	\N
f825502c-eb3e-47b8-89a4-fc47e435dc15	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Acumulación de basura en la esquina de Calle 38	Se reporta acumulación de basura en el sector Los Minas. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48500000	-69.85600000	\N	2025-06-14 18:16:07.33+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	2025-07-04 14:13:38.302+00	\N	\N	\N
296420cc-a84b-4eb0-906d-827c84050041	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Los Minas	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48500000	-69.85600000	\N	2025-04-24 13:39:14.019+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-05-09 14:22:16.44+00	\N	\N	\N
9b3ff3d0-bf1d-424f-a77c-6605f548d043	51d869f4-fa16-4633-9121-561817fce43d	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Los Minas. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48500000	-69.85600000	\N	2024-11-01 22:18:28.272+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
16544879-5b0c-44b3-93cf-3a9388f6fc53	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 27	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.48500000	-69.85600000	\N	2025-08-23 14:13:50.2+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-09-16 19:03:29.695+00	\N	\N	\N
3acf347e-4e5d-4f5c-ba8e-5d5403da2801	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en parque de Los Minas	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.48500000	-69.85600000	\N	2025-09-02 19:50:06.326+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-09-11 03:34:46.074+00	\N	\N	\N
e7bbaeda-8f59-4d79-a847-56d70eaeb49c	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Los Minas	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48500000	-69.85600000	\N	2024-12-28 14:38:14.514+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	\N	\N	\N	\N
3ead674c-f158-4cb0-ad95-5941380fd1ce	51d869f4-fa16-4633-9121-561817fce43d	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Minas. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.48500000	-69.85600000	\N	2024-11-08 23:31:21.267+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-11-16 02:35:01.167+00	\N	\N	\N
2c702e97-727e-4c71-a727-e2bf50d5e66f	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48500000	-69.85600000	\N	2024-10-15 04:09:28.623+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
16869104-c419-4cda-bbef-59107fadb610	e294a283-3655-4b93-a207-04f486438f37	Falta de iluminación en parque de Los Minas	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48500000	-69.85600000	\N	2025-10-24 10:00:18.541+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	baja	\N	\N	\N	\N
169de49d-6e99-4a49-9c8d-38f529e23082	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48500000	-69.85600000	\N	2025-02-11 12:39:05.28+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-02-14 13:15:56.053+00	\N	\N	\N
2fcbb539-ea3e-41a3-8dee-ff339f9fc396	51d869f4-fa16-4633-9121-561817fce43d	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Los Minas. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48500000	-69.85600000	\N	2025-04-23 02:37:37.572+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	baja	\N	\N	\N	\N
ebb9d039-606b-4c0b-a55f-e3130c17ff01	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Postes de luz averiados en Calle 15	Falta de iluminación pública en Los Minas crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48500000	-69.85600000	\N	2025-05-20 14:50:23.603+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	\N	\N	\N	\N
00ad2a81-4301-403a-b50e-d9308801c28c	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.85600000	\N	2024-07-31 10:02:55.96+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	2024-08-01 11:08:18.216+00	\N	\N	\N
f19f9125-e68a-4bc8-b6fb-fbe8d4f43752	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Problemas con el suministro de agua	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48500000	-69.85600000	\N	2024-10-19 13:03:05.272+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	\N	\N	\N	\N
b2e694bd-ec05-433d-aeec-04d0be768ffa	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Problemas con el suministro de agua	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48500000	-69.85600000	\N	2025-07-10 06:06:05.032+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-07-21 22:48:19.73+00	\N	\N	\N
767a5599-6e1f-4601-b9bb-9c3b462c3102	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Minas. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48500000	-69.85600000	\N	2025-09-10 02:00:49.696+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	alta	2025-09-11 08:43:17.295+00	\N	\N	\N
f187be7e-28bb-4d57-a978-3f8c2c83b2f6	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Los Minas que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48500000	-69.85600000	\N	2024-07-26 06:35:31.602+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-08-04 21:08:00.263+00	\N	\N	\N
955e5068-b70f-43b4-a6e4-dd3b29b9d7f0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.85600000	\N	2025-07-26 04:07:00.178+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2025-08-10 16:45:43.229+00	\N	\N	\N
4488e7b0-a4df-4228-9664-b6dd71d9b0c6	a09cd383-3c5a-4f9f-8c5a-036761a96873	Baches profundos en Calle 5	Deterioro significativo del pavimento en Los Minas debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48500000	-69.85600000	\N	2024-10-06 20:24:41.77+00	2025-07-11 04:15:42.255791+00	Los Minas, Santo Domingo	Los Minas	media	2024-10-13 21:50:30.379+00	\N	\N	\N
2508c039-130b-4918-920c-b431d1cc449b	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47500000	-69.92500000	\N	2025-07-08 19:40:25.519+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2025-08-05 10:24:39.912+00	\N	\N	\N
0fe11447-0afc-4977-98fd-5c6b115e4441	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47500000	-69.92500000	\N	2025-05-23 06:54:24.391+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	\N	\N	\N	\N
963208ed-1aa9-4170-a149-2cb59f437698	131c625c-8329-48ce-9b74-67991bd070fd	Área insegura durante la noche	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47500000	-69.92500000	\N	2025-04-20 19:57:16.202+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-05-12 23:37:15.717+00	\N	\N	\N
e0431837-d215-4250-a0eb-7e2975f2ff80	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47500000	-69.92500000	\N	2025-08-07 07:07:03.743+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-09-04 07:27:20.615+00	\N	\N	\N
ff880a41-4acc-4d48-8fb8-aa2f024e848f	131c625c-8329-48ce-9b74-67991bd070fd	Urgente reparación de vía principal	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47500000	-69.92500000	\N	2025-09-30 11:45:26.928+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
9c99a806-f571-49ec-b833-7b0b12a0dbf3	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47500000	-69.92500000	\N	2025-02-13 19:56:30.856+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
d7eb1613-c594-4ff7-bef6-82693fba8e7c	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47500000	-69.92500000	\N	2025-01-22 03:03:59.357+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2025-02-06 07:20:00.366+00	\N	\N	\N
a1b5e575-4e88-4b1d-98c9-de46b97f3bbd	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Gualey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47500000	-69.92500000	\N	2024-10-09 13:36:21.727+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	alta	2024-10-16 07:25:47.161+00	\N	\N	\N
1c2f62aa-490d-427a-9e81-217a3b08b537	a09cd383-3c5a-4f9f-8c5a-036761a96873	Baches profundos en Calle 22	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2025-01-21 18:33:51.849+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
5b73271d-0d13-443b-92ea-f3c1a6d9b202	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47500000	-69.92500000	\N	2024-10-21 12:28:17.218+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-11-14 17:05:39.153+00	\N	\N	\N
7016e7de-a77f-4c9c-946f-9d3a99e022d3	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 6	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47500000	-69.92500000	\N	2025-05-15 09:44:42.824+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
e043dc18-3144-4d06-8abb-dd08ef9b92ec	a09cd383-3c5a-4f9f-8c5a-036761a96873	Área insegura durante la noche	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47500000	-69.92500000	\N	2024-11-09 17:07:52.763+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	alta	\N	\N	\N	\N
73579903-abb9-4044-964d-440435d7839f	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47500000	-69.92500000	\N	2025-04-23 21:53:40.1+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
de3effcd-b72f-4509-85cf-69d9b47897ea	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2024-11-04 15:41:09.875+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	alta	\N	\N	\N	\N
00d9d259-e778-4420-8e72-07e93d935ca4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2025-04-16 16:15:05.769+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-04-24 17:43:44.667+00	\N	\N	\N
94008966-2a79-4c19-86d1-e84e61ffe1c5	a09cd383-3c5a-4f9f-8c5a-036761a96873	Baches profundos en Calle 13	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47500000	-69.92500000	\N	2025-04-25 10:15:05.221+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-05-06 09:48:57.563+00	\N	\N	\N
b15d8b97-6f57-4fbd-b55c-180cae0de119	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47500000	-69.92500000	\N	2025-06-21 10:58:12.464+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
c87817d3-3bb6-4525-a7fa-d99753325571	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2025-06-06 05:04:51.025+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-06-28 01:26:43.853+00	\N	\N	\N
3057d769-877c-4f26-9652-0410c76c1cf1	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47500000	-69.92500000	\N	2024-11-02 00:28:11.708+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-11-19 05:43:31.507+00	\N	\N	\N
b2df952b-257c-4fe7-b261-f6b914c1c9e0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Bombillas fundidas en varias calles	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47500000	-69.92500000	\N	2025-10-09 09:21:47.369+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-11-04 22:08:24.39+00	\N	\N	\N
a2c55b06-2333-4709-b9f1-4a0b9ec85438	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ruido excesivo en las noches	Problema general reportado en Gualey que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47500000	-69.92500000	\N	2025-02-20 13:46:28.533+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-03-18 03:30:22.09+00	\N	\N	\N
932fc258-5624-4175-a144-8fecf8387036	51d869f4-fa16-4633-9121-561817fce43d	Daños en pavimento cerca de Gualey	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47500000	-69.92500000	\N	2024-12-08 16:28:47.578+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2024-12-28 16:30:51.607+00	\N	\N	\N
f0cbbe75-d851-49a8-a18a-7f5fa902e8be	131c625c-8329-48ce-9b74-67991bd070fd	Cableado eléctrico en mal estado	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47500000	-69.92500000	\N	2025-09-07 04:52:30.466+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-09-13 08:01:59.357+00	\N	\N	\N
7898dd1a-91be-4507-82f2-579c788df656	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47500000	-69.92500000	\N	2024-09-09 09:37:49.015+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-10-01 16:56:32.861+00	\N	\N	\N
1ef7dfe1-ad63-415c-9f24-490af845701a	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de mejoras en parque	Problema general reportado en Gualey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47500000	-69.92500000	\N	2024-09-22 10:25:33.49+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-10-03 19:16:44.319+00	\N	\N	\N
68cc945d-64ea-4153-8a45-074bc1efae56	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Cableado eléctrico en mal estado	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47500000	-69.92500000	\N	2025-08-11 11:05:37.188+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-08-14 11:54:30.055+00	\N	\N	\N
90efd478-ec5e-4cff-8874-6fff38c7424e	51d869f4-fa16-4633-9121-561817fce43d	Ruido excesivo en las noches	Problema general reportado en Gualey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47500000	-69.92500000	\N	2024-09-11 07:49:10.712+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	alta	2024-09-13 12:02:28.615+00	\N	\N	\N
5a91feaa-2291-4900-8929-a8e8fe7a3db7	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Gualey	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47500000	-69.92500000	\N	2024-11-28 04:28:28.944+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
d82db0df-ca11-4f0d-93aa-27178156c886	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47500000	-69.92500000	\N	2024-08-23 15:05:49.483+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-08-29 01:51:28.024+00	\N	\N	\N
7ae7aaec-ea34-4747-9f11-d151ca47f004	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Gualey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47500000	-69.92500000	\N	2024-09-21 13:45:15.596+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-09-29 01:00:13.407+00	\N	\N	\N
7093cf12-4cc4-45ca-9856-8f8d3e51adbd	a09cd383-3c5a-4f9f-8c5a-036761a96873	Zona muy oscura por las noches	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47500000	-69.92500000	\N	2025-08-13 08:08:22.136+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-08-23 16:27:46.095+00	\N	\N	\N
317e6a83-6870-43aa-af42-4f4db152f5aa	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47500000	-69.92500000	\N	2024-09-02 00:30:02.338+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	2024-09-17 00:42:18.269+00	\N	\N	\N
edcf2afd-ae71-422f-ac40-f8f8560be8e1	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Gualey	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47500000	-69.92500000	\N	2024-09-22 22:43:55.168+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
5661b053-a143-4b20-a9ce-466efcceb06c	131c625c-8329-48ce-9b74-67991bd070fd	Baches profundos en Calle 3	Deterioro significativo del pavimento en Gualey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47500000	-69.92500000	\N	2025-07-10 15:46:17.405+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2025-07-14 14:23:00.637+00	\N	\N	\N
c7be6e77-d2c3-41b0-9cc1-1399eec59824	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de iluminación en parque de Gualey	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47500000	-69.92500000	\N	2024-08-19 09:22:10.614+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-09-16 13:49:35.45+00	\N	\N	\N
39a28449-bf94-454e-8f64-51fe6192205c	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en Gualey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47500000	-69.92500000	\N	2025-02-02 03:32:20.038+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
4bfd932f-f97f-40ac-818b-81880e209d25	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Gualey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47500000	-69.92500000	\N	2025-05-17 05:36:43.598+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	baja	\N	\N	\N	\N
58d6200a-1d6c-4357-a321-78a425274e54	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Gualey que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47500000	-69.92500000	\N	2024-11-08 17:31:32.448+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	2024-11-11 17:23:30.067+00	\N	\N	\N
58d8c403-fa48-45ee-9332-15e339d93edf	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de mejoras en parque	Problema general reportado en Gualey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47500000	-69.92500000	\N	2025-04-14 04:31:51.204+00	2025-07-11 04:15:42.255791+00	Gualey, Santo Domingo	Gualey	media	\N	\N	\N	\N
eb2df337-c4cf-4bdc-9049-5c4ecf6e8efb	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47200000	-69.92800000	\N	2025-04-05 07:51:39.482+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2025-05-04 09:00:16.155+00	\N	\N	\N
a266f945-3d63-442d-a04e-aca0c5a202ad	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47200000	-69.92800000	\N	2024-08-15 10:59:26.623+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2024-08-17 10:39:03.415+00	\N	\N	\N
11c6b2a8-adb1-44c3-acf0-da558b89f19e	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47200000	-69.92800000	\N	2024-12-15 14:53:40.328+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-01-09 08:48:41.46+00	\N	\N	\N
75a9f5c9-6351-45b2-adba-8a6ae6268096	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47200000	-69.92800000	\N	2025-07-17 19:55:00.934+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
403480e8-4739-4409-8890-6e51cf91fd59	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en Bella Vista	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2025-07-01 06:41:07.926+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	2025-07-03 17:02:34.445+00	\N	\N	\N
9a6eebc3-ad47-4ffc-b50a-dbc7e948218e	a09cd383-3c5a-4f9f-8c5a-036761a96873	Robos frecuentes en la zona	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47200000	-69.92800000	\N	2025-06-28 10:02:21.788+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-07-26 11:10:07.759+00	\N	\N	\N
a0a52618-ecea-46db-b2b8-d8b064aa10bd	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47200000	-69.92800000	\N	2025-07-01 02:35:20.254+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
87eb668a-5a32-478d-bb14-b4f426baa10e	51d869f4-fa16-4633-9121-561817fce43d	Robos frecuentes en la zona	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47200000	-69.92800000	\N	2025-03-17 20:05:51.466+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	2025-03-29 16:05:17.038+00	\N	\N	\N
adc57283-1e0b-4782-8c07-7629e98390d0	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47200000	-69.92800000	\N	2025-01-18 16:37:37.679+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-01-22 20:33:21.582+00	\N	\N	\N
0511e719-cde6-423c-bcfe-b6aba5a58668	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Bella Vista	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47200000	-69.92800000	\N	2025-09-19 19:37:28.073+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
53e2070b-4f5c-4e92-ad64-11a5d124b65d	51d869f4-fa16-4633-9121-561817fce43d	Daños en aceras y bordillos	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2025-04-02 21:19:53.666+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
30aacb1e-931c-4c42-b6a7-be1d7a6acf4d	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47200000	-69.92800000	\N	2025-02-19 23:52:37.848+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-02-20 09:26:49.254+00	\N	\N	\N
b701e4d2-31a9-4ca2-9e79-215bf3309d8f	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47200000	-69.92800000	\N	2025-04-13 06:08:34.115+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	2025-05-08 03:06:42.374+00	\N	\N	\N
dd4b4348-c6c3-4ded-b50f-db0e0821621c	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47200000	-69.92800000	\N	2024-07-16 10:22:24.328+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-07-29 03:34:32.33+00	\N	\N	\N
ca9cefc1-8b83-4d46-bef8-e2c4d758d334	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de mejoras en parque	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2025-02-13 02:55:59.142+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-03-12 07:03:58.9+00	\N	\N	\N
21d85842-45a3-4ceb-92c9-04910ab102f3	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de Bella Vista	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.47200000	-69.92800000	\N	2025-06-07 21:59:16.986+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	\N	\N	\N	\N
27ac273c-ca45-4ea9-b204-3a1eb1c871ea	131c625c-8329-48ce-9b74-67991bd070fd	Acumulación de basura en la esquina de Calle 2	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47200000	-69.92800000	\N	2025-02-17 07:17:34.4+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
4dccc3ea-1a14-441f-b1b7-d0114b3fa126	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en aceras y bordillos	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2024-07-15 11:55:53.766+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2024-07-23 18:48:09.831+00	\N	\N	\N
c20d23cd-44bf-4459-9b34-1708e36a3bac	e294a283-3655-4b93-a207-04f486438f37	Falta de iluminación en parque de Bella Vista	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47200000	-69.92800000	\N	2025-03-20 16:16:02.344+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2025-04-04 06:56:33.503+00	\N	\N	\N
4c434e7b-b2d0-421d-9ac4-d730e885ac6e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47200000	-69.92800000	\N	2025-01-03 14:47:26.28+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2025-01-28 19:50:43.76+00	\N	\N	\N
a2b2d408-cc7b-46f3-bc9a-134081b544d4	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47200000	-69.92800000	\N	2025-09-06 22:54:47.433+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2025-09-17 10:36:00.879+00	\N	\N	\N
b595b469-e923-4cbc-a8b9-1a550d903a85	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47200000	-69.92800000	\N	2024-08-22 20:57:41.127+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	\N	\N	\N	\N
65459701-020c-4a54-b902-726099f45ad8	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2025-02-27 06:51:11.299+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-02-28 12:00:51.025+00	\N	\N	\N
c6083fa8-3258-4c52-9c9d-7f82b2e431a4	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47200000	-69.92800000	\N	2025-06-17 01:06:39.853+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	\N	\N	\N	\N
b124a549-dbcc-4e93-9052-0ed79adae72d	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Urgente reparación de vía principal	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47200000	-69.92800000	\N	2025-04-25 05:28:44.996+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
698533e5-6374-451d-bdbb-23f191239c38	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47200000	-69.92800000	\N	2025-04-30 05:57:18.282+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-05-25 22:32:16.948+00	\N	\N	\N
cdeb7b0c-3a81-4261-86f6-4c7b8788e20c	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47200000	-69.92800000	\N	2025-10-01 08:38:09.981+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-10-20 16:25:03.182+00	\N	\N	\N
f9a89140-ce1c-41fa-9254-8dc0cb9783d3	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de vigilancia en Bella Vista	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47200000	-69.92800000	\N	2024-09-19 12:15:17.731+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-10-18 15:31:18.014+00	\N	\N	\N
4eb3656a-5ef3-4094-9b64-88c10462bdd5	e294a283-3655-4b93-a207-04f486438f37	Animales callejeros en Bella Vista	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47200000	-69.92800000	\N	2024-09-03 23:50:38.335+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2024-09-06 08:44:04.414+00	\N	\N	\N
dbb938f5-7468-4baa-886f-db5b6a261937	a09cd383-3c5a-4f9f-8c5a-036761a96873	Robos frecuentes en la zona	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47200000	-69.92800000	\N	2024-10-05 00:26:05.453+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-10-09 11:25:47.259+00	\N	\N	\N
f8cd0524-69f1-41ee-a106-fb3721d52039	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Bella Vista	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47200000	-69.92800000	\N	2025-05-28 18:07:47.072+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	baja	\N	\N	\N	\N
416a92f4-ec0b-4619-b64a-50fb59046d6b	131c625c-8329-48ce-9b74-67991bd070fd	Problemas con el suministro de agua	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47200000	-69.92800000	\N	2024-07-15 16:08:44.526+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	2024-08-11 10:35:43.47+00	\N	\N	\N
d7de8fe0-ad56-400e-a56f-58dd772be83d	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 34	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47200000	-69.92800000	\N	2024-09-01 04:32:48.656+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	alta	\N	\N	\N	\N
8a9053d3-9e13-4ebc-a323-61bff01c78f0	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47200000	-69.92800000	\N	2024-07-17 13:29:10.542+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-07-17 14:27:36.221+00	\N	\N	\N
0ec90474-2e37-444d-890e-09dc60572d74	51d869f4-fa16-4633-9121-561817fce43d	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Bella Vista debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47200000	-69.92800000	\N	2025-05-20 02:55:15.84+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-05-28 10:25:18.007+00	\N	\N	\N
3e87217c-b2cf-4c21-a243-6d0fcca513b0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Bella Vista. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47200000	-69.92800000	\N	2025-06-19 07:52:32.158+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-07-06 10:22:06.244+00	\N	\N	\N
210c2783-3c68-4cfb-9524-e001f79ba57a	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Bella Vista que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47200000	-69.92800000	\N	2024-09-22 11:34:37.647+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-10-04 01:30:24.382+00	\N	\N	\N
1a335e50-4df4-4d75-919b-3a2644c9f0d6	a09cd383-3c5a-4f9f-8c5a-036761a96873	Área insegura durante la noche	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47200000	-69.92800000	\N	2024-09-10 22:24:17.257+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
0a9c2895-1661-467d-826a-aacbc76e52ac	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Bella Vista. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47200000	-69.92800000	\N	2025-02-12 22:10:24.204+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	\N	\N	\N	\N
29842528-037a-4c62-80b8-510d7caf2620	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Cableado eléctrico en mal estado	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.47200000	-69.92800000	\N	2025-01-17 15:32:23.445+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2025-01-24 19:16:00.769+00	\N	\N	\N
d8a90f29-9fe5-4584-8a81-8eea4484940e	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en Bella Vista crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47200000	-69.92800000	\N	2024-11-14 20:43:22.135+00	2025-07-11 04:15:42.255791+00	Bella Vista, Santo Domingo	Bella Vista	media	2024-11-30 21:51:56.741+00	\N	\N	\N
f219452f-1ff6-464c-b042-a772f05e5a7e	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46800000	-69.94000000	\N	2025-05-13 17:21:21.83+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
035bcbb1-09c8-42e1-a2e1-93085702f776	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Zona muy oscura por las noches	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46800000	-69.94000000	\N	2025-06-18 14:43:38.011+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-07-07 20:03:45.989+00	\N	\N	\N
19576dad-950c-466f-bf2c-0a94a42f1257	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46800000	-69.94000000	\N	2024-11-09 09:00:49.166+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
db79f7ef-fee9-49c7-a2f7-948f2d3e1ed7	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Área insegura durante la noche	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46800000	-69.94000000	\N	2025-04-21 03:33:47.21+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
9dbcbf44-a411-49e6-9f4c-0a56e5fb3cb9	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Villa Agrippina	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46800000	-69.94000000	\N	2025-02-21 14:44:53.476+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-03-21 15:39:02.052+00	\N	\N	\N
4ebef907-0917-4509-8fa9-99bbc0dc9266	a09cd383-3c5a-4f9f-8c5a-036761a96873	Baches profundos en Calle 48	Deterioro significativo del pavimento en Villa Agrippina debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46800000	-69.94000000	\N	2025-02-03 11:39:25.885+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	2025-03-01 13:46:43.207+00	\N	\N	\N
b3f7269c-f877-4e70-8381-c3097f93feff	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46800000	-69.94000000	\N	2025-07-30 10:45:44.145+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	2025-08-18 09:07:39.79+00	\N	\N	\N
650272d1-b904-444d-8e43-0769c0d352b2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46800000	-69.94000000	\N	2025-01-04 14:41:32.117+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
921af214-bbed-4eb8-a6e9-41f8ce18661e	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Animales callejeros en Villa Agrippina	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46800000	-69.94000000	\N	2025-05-24 00:47:24.612+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	2025-05-26 04:54:10.158+00	\N	\N	\N
8f822ed4-2045-4294-97e5-189504744265	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Área insegura durante la noche	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46800000	-69.94000000	\N	2025-07-02 08:51:31.24+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	\N	\N	\N	\N
f7d13ac3-7d91-4a90-a607-3b5adefddb20	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 10	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46800000	-69.94000000	\N	2025-10-22 09:42:44.342+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	\N	\N	\N	\N
8d74b2b5-bb10-4e2b-b962-311bdedf3859	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.46800000	-69.94000000	\N	2025-04-03 05:31:20.489+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
1431af55-d814-4355-9c22-44652c974d8d	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Área insegura durante la noche	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46800000	-69.94000000	\N	2025-02-04 23:13:34.888+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-02-18 14:56:55.809+00	\N	\N	\N
fb7542e4-ef35-4895-8063-8ef36ad3ae1c	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ruido excesivo en las noches	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46800000	-69.94000000	\N	2025-03-06 09:56:37.203+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
f70cc9b9-8109-4ff5-9917-d22ded2c9a6c	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46800000	-69.94000000	\N	2024-07-20 08:46:26.608+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
5a198995-0c38-432d-994c-a312e11a552d	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Área insegura durante la noche	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46800000	-69.94000000	\N	2025-05-16 17:01:39.419+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-06-06 16:52:58.142+00	\N	\N	\N
7fc08a1a-36a6-4d89-94e9-14162436a4be	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en aceras y bordillos	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46800000	-69.94000000	\N	2024-12-03 02:57:53.972+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
dcf08f8e-91bd-43ca-963a-a401cc4ddd97	131c625c-8329-48ce-9b74-67991bd070fd	Postes de luz averiados en Calle 23	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46800000	-69.94000000	\N	2024-10-15 07:41:22.614+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
d6b257c2-aa55-4677-95bf-a0a758538a8e	131c625c-8329-48ce-9b74-67991bd070fd	Postes de luz averiados en Calle 4	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46800000	-69.94000000	\N	2024-10-06 04:04:06.455+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-10-23 12:23:00.838+00	\N	\N	\N
bdaf54d3-9815-44f6-8697-41452c5f3a9c	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 23	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46800000	-69.94000000	\N	2024-08-28 21:04:49.534+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-08-31 15:31:38.453+00	\N	\N	\N
eec5b0a1-9676-45dc-ac1b-f9ea975b1b4a	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46800000	-69.94000000	\N	2024-12-08 10:40:09.821+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	\N	\N	\N	\N
940ed44e-4655-4b99-8ad2-c280e3efb411	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Villa Agrippina	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46800000	-69.94000000	\N	2025-03-16 16:36:26.266+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	2025-03-18 15:51:09.621+00	\N	\N	\N
a7b394fa-a9fa-4342-a56d-b8abb0516650	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de vigilancia en Villa Agrippina	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46800000	-69.94000000	\N	2025-07-02 21:02:15.76+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	2025-07-13 17:46:30.212+00	\N	\N	\N
4b2effb1-a784-409c-9b60-b97c37e35f68	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Villa Agrippina debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46800000	-69.94000000	\N	2024-12-22 13:29:42.845+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	2025-01-17 11:45:06.555+00	\N	\N	\N
e6975446-6626-4700-949c-5d5d27953304	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46800000	-69.94000000	\N	2025-05-24 00:36:09.905+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	\N	\N	\N	\N
96b1aa23-0b69-432e-b38a-2d0a34da96d0	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Villa Agrippina	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46800000	-69.94000000	\N	2024-09-30 12:43:44.618+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
9a20b922-f03a-48cd-9221-e4f5417096ab	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Villa Agrippina	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46800000	-69.94000000	\N	2024-07-12 07:46:55.872+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-08-02 02:07:57.14+00	\N	\N	\N
f22f54b1-bf66-4a9a-9b39-e302dd291908	131c625c-8329-48ce-9b74-67991bd070fd	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46800000	-69.94000000	\N	2024-08-06 00:40:12.228+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
f43d6c4f-983e-41c7-9f1f-a40b699c2d26	131c625c-8329-48ce-9b74-67991bd070fd	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46800000	-69.94000000	\N	2024-09-09 14:35:55.622+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
1c84f3f5-0f4b-4a09-b995-ddfae5301475	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Animales callejeros en Villa Agrippina	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46800000	-69.94000000	\N	2025-02-03 14:48:58.84+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
7e5999e2-f6a1-484a-a477-4272c3720c70	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46800000	-69.94000000	\N	2025-04-22 19:00:40.446+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
90a8dc4a-02c3-41a0-b431-bbc65a24b88f	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46800000	-69.94000000	\N	2024-09-07 04:34:39.695+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-09-10 23:42:46.98+00	\N	\N	\N
48ba71ee-e3f5-433c-b40a-d45dc32ac7cb	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46800000	-69.94000000	\N	2025-07-05 11:49:09.4+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-07-16 00:27:24.956+00	\N	\N	\N
ed88ddd4-ee40-4ac2-bbf1-e1bf76107220	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46800000	-69.94000000	\N	2024-07-30 15:02:05.813+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-08-23 04:34:09.608+00	\N	\N	\N
a37efc8b-8d5e-49e3-8498-37c06b870dbc	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46800000	-69.94000000	\N	2025-02-03 07:45:42.739+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
23215e52-1499-43c0-8c01-f6a72af0bd02	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de iluminación en parque de Villa Agrippina	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46800000	-69.94000000	\N	2024-09-20 07:21:02.953+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	alta	\N	\N	\N	\N
9a99fe9d-3d81-48b7-8757-5224243142db	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46800000	-69.94000000	\N	2025-02-17 10:50:49.239+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2025-03-10 20:35:45.496+00	\N	\N	\N
1fe3f1a0-551c-4aab-be82-77f7a8da9273	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en Villa Agrippina	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46800000	-69.94000000	\N	2024-12-16 22:46:03.909+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-12-21 15:48:16.632+00	\N	\N	\N
8a387454-c8e3-46c6-92b9-da9b2c913638	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Agrippina crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46800000	-69.94000000	\N	2025-05-02 21:59:16.537+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	baja	\N	\N	\N	\N
e38c1e23-4eb8-4b37-90a0-0bdec8449c3d	51d869f4-fa16-4633-9121-561817fce43d	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Agrippina. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46800000	-69.94000000	\N	2024-07-25 03:23:32.34+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-08-23 15:55:13.439+00	\N	\N	\N
cb2dbc48-f303-46ed-abaf-cfcb24635415	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Agrippina que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46800000	-69.94000000	\N	2025-04-26 06:59:52.91+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	\N	\N	\N	\N
581792c2-6b0e-4289-a291-6d182ea24ee3	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Villa Agrippina. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46800000	-69.94000000	\N	2024-12-16 22:04:11.832+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-12-18 22:14:16.881+00	\N	\N	\N
ff457649-27ab-4481-a9a6-77fc99366b61	131c625c-8329-48ce-9b74-67991bd070fd	Urgente reparación de vía principal	Deterioro significativo del pavimento en Villa Agrippina debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46800000	-69.94000000	\N	2024-07-28 18:32:58.978+00	2025-07-11 04:15:42.255791+00	Villa Agrippina, Santo Domingo	Villa Agrippina	media	2024-08-27 13:30:31.357+00	\N	\N	\N
764e630f-51cc-46e0-900b-01b5e1e35678	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en La Esperilla	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47600000	-69.93000000	\N	2025-03-03 11:42:35.535+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-03-07 19:44:27.953+00	\N	\N	\N
61c0f9df-4f53-4f70-a817-ae7a8da26eae	51d869f4-fa16-4633-9121-561817fce43d	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47600000	-69.93000000	\N	2025-08-01 03:26:09.745+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	2025-08-22 04:42:56.575+00	\N	\N	\N
aceb8f66-f98e-4861-8dc4-5d611d84a8f0	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de La Esperilla	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47600000	-69.93000000	\N	2025-02-08 00:52:22.327+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-02-16 15:19:11.139+00	\N	\N	\N
c3aa66c1-5fae-429f-8039-205fe412cf68	51d869f4-fa16-4633-9121-561817fce43d	Urgente reparación de vía principal	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47600000	-69.93000000	\N	2025-01-22 09:41:50.857+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-02-21 07:18:11.536+00	\N	\N	\N
622b0147-7648-4d11-9b38-9b354bcb5f3b	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47600000	-69.93000000	\N	2025-05-27 08:21:50.466+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
11f27450-851d-498f-a034-8d1f058de69e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47600000	-69.93000000	\N	2025-12-08 11:52:57.353+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
cdf4eb1e-a0fb-44fd-ae42-b862072016cc	e294a283-3655-4b93-a207-04f486438f37	Contenedores desbordados en La Esperilla	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47600000	-69.93000000	\N	2025-04-20 23:07:14.229+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
622b4843-da4f-47df-a3e1-a117e763b857	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en pavimento cerca de La Esperilla	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47600000	-69.93000000	\N	2025-12-02 16:13:15.722+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
a8ea63d5-36c9-44f2-a76f-28c2532a3be7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Contenedores desbordados en La Esperilla	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47600000	-69.93000000	\N	2024-08-26 14:52:07.056+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	\N	\N	\N	\N
91dbb7ac-af74-4f91-a774-94bdf5b5f19f	131c625c-8329-48ce-9b74-67991bd070fd	Robos frecuentes en la zona	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47600000	-69.93000000	\N	2025-04-28 20:29:23.998+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-05-06 10:16:13.89+00	\N	\N	\N
4744d264-4998-49d1-b045-3f3dcaa960bd	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Zona muy oscura por las noches	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47600000	-69.93000000	\N	2025-03-03 05:54:13.078+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-03-18 08:30:42.147+00	\N	\N	\N
b008dd9e-d34b-4125-8c0f-566c17b2cbf4	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de vigilancia en La Esperilla	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47600000	-69.93000000	\N	2025-02-28 09:52:33.503+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-03-20 12:32:15.911+00	\N	\N	\N
e0a9ee7b-ba38-4b47-8350-5858d3ffd6af	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Calle intransitable por hoyos	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47600000	-69.93000000	\N	2025-10-03 05:57:57.37+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
6277ae86-cb4a-4645-8c5c-6cb9a8e29119	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47600000	-69.93000000	\N	2024-08-31 19:18:00.683+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-09-28 21:44:43.166+00	\N	\N	\N
aa426513-75c0-498c-a299-768fafedb58f	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ruido excesivo en las noches	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47600000	-69.93000000	\N	2024-09-23 13:29:22.118+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-10-15 01:44:34.98+00	\N	\N	\N
7c037204-91da-428b-bb1f-2473af083e3f	e294a283-3655-4b93-a207-04f486438f37	Zona muy oscura por las noches	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47600000	-69.93000000	\N	2025-01-08 01:36:28.051+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2025-02-06 10:40:09.465+00	\N	\N	\N
4590a89a-3757-45c0-81bb-fd4426f59889	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.47600000	-69.93000000	\N	2025-08-17 23:50:23.64+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-09-16 22:25:47.287+00	\N	\N	\N
52872f66-cead-4344-ac90-79b09d0c09c8	51d869f4-fa16-4633-9121-561817fce43d	Robos frecuentes en la zona	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47600000	-69.93000000	\N	2024-07-28 21:10:38.784+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2024-08-04 06:50:40.885+00	\N	\N	\N
16eb99fd-3468-4f1a-987c-4e7d293ef91b	e294a283-3655-4b93-a207-04f486438f37	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47600000	-69.93000000	\N	2024-09-05 17:26:27.087+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-09-23 05:36:42.017+00	\N	\N	\N
3a915340-2abc-4f9a-a315-ab16249bcad8	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47600000	-69.93000000	\N	2024-12-23 17:48:07.766+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-01-22 10:58:04.846+00	\N	\N	\N
d559921c-80b4-4eeb-ae66-6797ca120704	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47600000	-69.93000000	\N	2025-10-13 07:35:10.956+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	\N	\N	\N	\N
4ae69e12-9c5c-4008-b7ff-c33fcf441dba	e294a283-3655-4b93-a207-04f486438f37	Área insegura durante la noche	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47600000	-69.93000000	\N	2024-11-05 07:49:52.802+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-11-11 03:11:12.743+00	\N	\N	\N
dca8999e-63cf-481a-a21c-522f774625d0	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Cableado eléctrico en mal estado	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47600000	-69.93000000	\N	2024-10-31 08:06:03.579+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
9fc5a887-b802-4497-b52f-0a1a3bcb2bf7	a09cd383-3c5a-4f9f-8c5a-036761a96873	Contenedores desbordados en La Esperilla	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47600000	-69.93000000	\N	2024-07-17 06:27:41.486+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2024-08-14 08:43:29.326+00	\N	\N	\N
bf915e79-27a3-492a-99a3-c3eebe314d27	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en La Esperilla	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47600000	-69.93000000	\N	2025-07-05 09:10:02.668+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-08-01 03:37:00.43+00	\N	\N	\N
178c89a1-cca8-4d07-bf2a-1d392d2b29fb	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en parque de La Esperilla	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47600000	-69.93000000	\N	2025-02-13 15:05:36.929+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	\N	\N	\N	\N
ef6a3aeb-732f-4df5-bbe6-e43e5dedae17	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47600000	-69.93000000	\N	2024-11-19 19:31:56.531+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
9d63ec5a-8559-4019-b41b-2354f9bc2258	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47600000	-69.93000000	\N	2024-07-16 11:23:38.241+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2024-07-31 15:07:01.083+00	\N	\N	\N
abde3721-1c86-41c6-b0c0-2492616e2026	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 3	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47600000	-69.93000000	\N	2025-03-12 18:15:36.702+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	\N	\N	\N	\N
601c8b77-d1ad-493c-86cd-933345894333	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Problemas con el suministro de agua	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.47600000	-69.93000000	\N	2025-03-17 11:32:44.286+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2025-04-13 20:37:38.98+00	\N	\N	\N
0659f1d0-5ff1-404c-ac15-13b117205d05	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en pavimento cerca de La Esperilla	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47600000	-69.93000000	\N	2025-09-25 19:25:35.957+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-10-01 06:31:47.59+00	\N	\N	\N
e928649a-0e10-4456-ac4e-498d625ea7c6	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en La Esperilla debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47600000	-69.93000000	\N	2024-10-07 01:40:55.573+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2024-10-21 09:22:06.144+00	\N	\N	\N
4bd3130d-ce1c-4571-8c1f-1d12ff130a92	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 35	Falta de iluminación pública en La Esperilla crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47600000	-69.93000000	\N	2025-02-08 14:28:11.924+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	2025-02-19 19:45:56.172+00	\N	\N	\N
a1d075b8-8418-4132-8261-29c4a0c452e0	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47600000	-69.93000000	\N	2025-06-23 16:33:06.562+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
8a794bb2-482d-40f2-90d4-0cd0fc26a987	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47600000	-69.93000000	\N	2025-08-04 00:55:49.436+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2025-08-07 00:21:21.996+00	\N	\N	\N
c1d7a0b6-bd3f-4bb6-9cb6-a18a27adb6ce	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47600000	-69.93000000	\N	2024-09-02 21:46:50.894+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
06a6989c-7430-4711-956a-97cb589b709c	51d869f4-fa16-4633-9121-561817fce43d	Área insegura durante la noche	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47600000	-69.93000000	\N	2024-10-31 00:12:29.434+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-11-28 20:07:24.903+00	\N	\N	\N
dd60c5f4-25de-4f84-92bc-a456bf9944de	e294a283-3655-4b93-a207-04f486438f37	Solicitud de mejoras en parque	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47600000	-69.93000000	\N	2024-12-05 21:01:40.919+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	2025-01-03 03:43:32.492+00	\N	\N	\N
c4ef12d2-c220-4fac-bb4b-e216913ca297	e294a283-3655-4b93-a207-04f486438f37	Daños en aceras y bordillos	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47600000	-69.93000000	\N	2024-09-10 21:18:49.251+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	baja	2024-09-11 10:19:33.911+00	\N	\N	\N
bef9d839-ff56-4996-b8be-85be270581d2	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector La Esperilla. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47600000	-69.93000000	\N	2025-02-25 03:19:01.857+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	\N	\N	\N	\N
9b64aab0-5ea5-4330-b3fc-3e2b05c7272f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en La Esperilla. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47600000	-69.93000000	\N	2024-10-02 03:10:38.711+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	media	2024-10-31 13:30:31.586+00	\N	\N	\N
4b434da8-6b19-4776-bbd6-7376536d768f	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en La Esperilla que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47600000	-69.93000000	\N	2025-03-14 01:31:26.521+00	2025-07-11 04:15:42.255791+00	La Esperilla, Santo Domingo	La Esperilla	alta	2025-03-17 12:15:45.422+00	\N	\N	\N
df6c428e-4dd1-42fe-912e-1fd8472a095b	131c625c-8329-48ce-9b74-67991bd070fd	Falta de vigilancia en Ensanche Ozama	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48000000	-69.88000000	\N	2025-05-24 17:34:54.568+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	2025-05-27 14:13:35.937+00	\N	\N	\N
1c1f8447-44d3-499e-b889-e07600ce8bb1	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48000000	-69.88000000	\N	2025-06-15 05:56:01.394+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2025-07-04 09:56:24.785+00	\N	\N	\N
5f303326-66cb-43f9-9dc6-3a0cd779cfcc	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48000000	-69.88000000	\N	2024-12-22 19:00:21.875+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-12-27 13:40:04.082+00	\N	\N	\N
7d8bbe2a-fba2-4a6c-b6c2-5afaeabaae6b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48000000	-69.88000000	\N	2024-07-23 08:03:12.551+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	\N	\N	\N	\N
485026e0-6896-4b75-88f4-3176ec3ddf2e	51d869f4-fa16-4633-9121-561817fce43d	Daños en pavimento cerca de Ensanche Ozama	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48000000	-69.88000000	\N	2025-10-08 18:21:51.006+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2025-10-24 05:41:52.02+00	\N	\N	\N
65b5b6d0-4d49-4586-9b57-8bc8bd797557	131c625c-8329-48ce-9b74-67991bd070fd	Acumulación de basura en la esquina de Calle 35	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48000000	-69.88000000	\N	2024-09-12 21:03:32.825+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	\N	\N	\N	\N
bde537b8-f0c0-48c8-827f-59d6429212c9	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de iluminación en parque de Ensanche Ozama	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48000000	-69.88000000	\N	2025-08-21 04:36:34.815+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2025-09-15 18:33:51.763+00	\N	\N	\N
4b45732c-5307-41a8-89cc-273817a520c0	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en Ensanche Ozama	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48000000	-69.88000000	\N	2025-07-06 11:24:24.686+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2025-08-02 09:22:46.137+00	\N	\N	\N
501496c0-9268-4df2-bf45-08a243f59b91	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de Ensanche Ozama	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.48000000	-69.88000000	\N	2024-12-27 17:52:21.768+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
1cc6e76e-46b5-4b90-9c0e-60c1c447faa3	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.48000000	-69.88000000	\N	2024-09-17 00:07:12.492+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
23a66d53-6510-477d-8f68-ea5aca92cd98	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en Ensanche Ozama	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48000000	-69.88000000	\N	2024-07-24 19:25:04.834+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-07-27 18:10:00.98+00	\N	\N	\N
bf984b60-3521-49ea-9426-04a8a3b3b525	131c625c-8329-48ce-9b74-67991bd070fd	Problemas con el suministro de agua	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48000000	-69.88000000	\N	2025-05-28 21:56:29.397+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2025-06-22 04:51:41.277+00	\N	\N	\N
1f0c3d30-6847-47ac-a61c-273adf693f0c	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.48000000	-69.88000000	\N	2025-10-27 13:35:54.174+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	\N	\N	\N	\N
b6d0b6a7-dccb-47c4-b5fd-fb0f53d43907	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en Ensanche Ozama	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2025-06-01 06:31:43.684+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	\N	\N	\N	\N
96f4450a-8a03-4368-a10f-6ba34a2c2d9d	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2024-11-06 07:29:41.517+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2024-12-01 03:30:15.461+00	\N	\N	\N
ae819790-e06e-4159-a8b3-d1c6daf335ba	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.48000000	-69.88000000	\N	2024-11-04 02:58:50.401+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2024-11-25 15:28:53.699+00	\N	\N	\N
2d80723d-af20-4121-9255-6a9858c7e964	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Ensanche Ozama	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.48000000	-69.88000000	\N	2025-03-07 15:16:46.205+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
64b4e498-7109-460d-8fa4-7ce67e3a4299	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2025-01-22 02:43:32.675+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	\N	\N	\N	\N
5c32e3c8-5877-409f-b755-add950639d0c	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48000000	-69.88000000	\N	2024-08-12 20:11:57.392+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-09-04 08:23:46.246+00	\N	\N	\N
d8b1abe8-ca92-4569-a0c1-21f37b740134	e294a283-3655-4b93-a207-04f486438f37	Contenedores desbordados en Ensanche Ozama	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2024-09-24 11:22:14.187+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
61276f51-2801-4b5b-9592-69bb8b13f182	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48000000	-69.88000000	\N	2024-08-31 03:23:54.473+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
c685bcae-753b-4a2e-bc04-cbef38efd80f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2024-08-04 14:29:42.023+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-08-08 10:23:37.633+00	\N	\N	\N
7097d954-f456-46a5-bf40-26253ad45d41	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Postes de luz averiados en Calle 34	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48000000	-69.88000000	\N	2025-02-23 00:09:33.856+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2025-02-25 04:08:23.996+00	\N	\N	\N
f51142fb-c922-4f1f-8d5a-34792bc454f1	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2025-04-26 22:09:24.663+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	2025-05-25 16:48:36.707+00	\N	\N	\N
28ad825e-eaa9-46bf-9794-832b27d1fbae	131c625c-8329-48ce-9b74-67991bd070fd	Problemas con el suministro de agua	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.48000000	-69.88000000	\N	2024-12-03 11:52:14.535+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2024-12-19 01:01:47.539+00	\N	\N	\N
62103121-04c3-490b-8489-0d1cddeeaba8	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Baches profundos en Calle 8	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.48000000	-69.88000000	\N	2024-07-13 06:03:09.442+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	\N	\N	\N	\N
3e98f948-d4d7-4a4e-90f0-6aaf78b2644c	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Área insegura durante la noche	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48000000	-69.88000000	\N	2025-05-21 20:38:59.447+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	2025-05-23 02:52:36.462+00	\N	\N	\N
67bb537c-eccd-4007-a8ea-61f7c0de3fc8	a09cd383-3c5a-4f9f-8c5a-036761a96873	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48000000	-69.88000000	\N	2025-09-14 13:47:42.764+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2025-10-05 19:52:21.043+00	\N	\N	\N
207931d1-caed-4a28-9316-791292e0a849	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en pavimento cerca de Ensanche Ozama	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48000000	-69.88000000	\N	2025-05-31 16:10:46.618+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	2025-06-30 08:20:26.193+00	\N	\N	\N
cebfeee0-814a-4e6d-8850-c521220b8228	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48000000	-69.88000000	\N	2024-10-19 03:57:49.373+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-11-07 09:45:17.596+00	\N	\N	\N
1490c9f0-840e-4be3-8578-ebb2e81d1c8b	131c625c-8329-48ce-9b74-67991bd070fd	Contenedores desbordados en Ensanche Ozama	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.48000000	-69.88000000	\N	2024-11-16 01:21:51.558+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-11-22 09:44:02.031+00	\N	\N	\N
8b785148-8c2f-478f-8855-b87a573bfdd3	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de mejoras en parque	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48000000	-69.88000000	\N	2025-04-12 03:26:37.302+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	\N	\N	\N	\N
048e0889-3731-4459-8878-e41740204a65	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.48000000	-69.88000000	\N	2025-09-06 02:38:57.272+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2025-09-08 15:19:56.209+00	\N	\N	\N
6488ef17-dea9-4c0a-9ade-412e02512689	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.48000000	-69.88000000	\N	2025-01-01 19:33:20.594+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2025-01-11 17:09:11.851+00	\N	\N	\N
00658045-848a-4455-a297-bdbf1d2e743e	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.48000000	-69.88000000	\N	2025-03-03 09:17:46.189+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
014f3a7b-00d1-4ef7-8f10-972554ea6d94	51d869f4-fa16-4633-9121-561817fce43d	Acumulación de basura en la esquina de Calle 18	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.48000000	-69.88000000	\N	2025-07-10 19:18:25.969+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
d4bd2a1c-d26e-4581-87e1-309119e7d50f	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Ensanche Ozama. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.48000000	-69.88000000	\N	2024-12-30 07:22:44.666+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	baja	\N	\N	\N	\N
dfad1f46-5e45-425a-bb34-2062776262c9	e294a283-3655-4b93-a207-04f486438f37	Falta de iluminación en parque de Ensanche Ozama	Falta de iluminación pública en Ensanche Ozama crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.48000000	-69.88000000	\N	2024-07-19 17:28:57.603+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	\N	\N	\N	\N
c3800dd7-0ae4-4f84-bf29-04f1c15570ec	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Problemas con el suministro de agua	Problema general reportado en Ensanche Ozama que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.48000000	-69.88000000	\N	2025-03-05 02:42:28.326+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	\N	\N	\N	\N
a672bbd5-9d03-4d01-8dd0-e1841fed1648	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en Ensanche Ozama debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.48000000	-69.88000000	\N	2024-08-01 15:41:29.834+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	media	2024-08-07 14:49:21.244+00	\N	\N	\N
b89ddd8d-6f7c-4aa0-9cfc-d7bbbef84950	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Ensanche Ozama. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.48000000	-69.88000000	\N	2024-09-25 07:02:03.792+00	2025-07-11 04:15:42.255791+00	Ensanche Ozama, Santo Domingo	Ensanche Ozama	alta	2024-09-28 02:21:39.332+00	\N	\N	\N
6d9b16ea-d19b-4dd4-9ec3-96731dd1c596	131c625c-8329-48ce-9b74-67991bd070fd	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47400000	-69.93500000	\N	2025-01-19 13:03:01.995+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-02-09 03:44:09.209+00	\N	\N	\N
b849d25b-ea5b-4fd7-93db-8ef4c24264a8	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Robos frecuentes en la zona	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47400000	-69.93500000	\N	2025-05-31 15:06:16.195+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
8182a201-bfda-4874-997b-2ed51461ad6d	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47400000	-69.93500000	\N	2024-08-13 14:41:28.511+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2024-09-01 23:37:54.621+00	\N	\N	\N
3ac648f7-3c8d-4913-bea3-b7be34c984df	131c625c-8329-48ce-9b74-67991bd070fd	Área insegura durante la noche	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47400000	-69.93500000	\N	2024-08-02 07:24:38.647+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2024-08-27 06:26:12.474+00	\N	\N	\N
01416e04-0990-4730-867e-5371b51dc01f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Baches profundos en Calle 6	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47400000	-69.93500000	\N	2025-04-17 05:38:17.486+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	\N	\N	\N	\N
2022f5f3-429a-4760-ad93-87267202f128	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47400000	-69.93500000	\N	2024-08-20 22:14:12.187+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
0f6db62f-94c5-4bcc-896a-5052f3801a8e	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47400000	-69.93500000	\N	2025-01-19 12:23:22.139+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
fab43c64-06f0-41be-9220-7582edbf2066	a09cd383-3c5a-4f9f-8c5a-036761a96873	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47400000	-69.93500000	\N	2024-10-04 05:16:53.214+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2024-10-29 08:17:45.069+00	\N	\N	\N
52cfade2-7a18-4583-ab90-f1ffebc3637c	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en San Carlos	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47400000	-69.93500000	\N	2025-04-29 11:01:09.605+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	\N	\N	\N	\N
f5e838c6-3a0d-41ca-bea1-5809e64bcce4	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47400000	-69.93500000	\N	2025-01-20 10:28:00.702+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-01-24 22:47:29.745+00	\N	\N	\N
6d7cddb7-0e1a-4132-a94c-5b6aaf1db8a9	131c625c-8329-48ce-9b74-67991bd070fd	Falta de iluminación en parque de San Carlos	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47400000	-69.93500000	\N	2025-08-02 05:10:14.418+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-08-21 22:01:46.496+00	\N	\N	\N
675c38ca-7c19-4a72-ad65-cd54bb7ca2b9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en pavimento cerca de San Carlos	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47400000	-69.93500000	\N	2025-05-15 00:24:09.089+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-05-19 12:59:24.41+00	\N	\N	\N
71e5b20f-e14b-42c7-81d3-f1c52b242c1f	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de mejoras en parque	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47400000	-69.93500000	\N	2025-02-13 12:46:55.474+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-03-09 23:10:04.504+00	\N	\N	\N
bb564c54-99cd-4075-b710-1f2f74b54e0f	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47400000	-69.93500000	\N	2025-03-14 08:57:23.84+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
a98c1bd1-87b1-4bb3-80ff-832de9f405d2	131c625c-8329-48ce-9b74-67991bd070fd	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47400000	-69.93500000	\N	2025-01-14 22:53:26.066+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	\N	\N	\N	\N
c350ad61-e328-4175-8c93-7e2ea31ef310	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47400000	-69.93500000	\N	2025-06-05 18:37:39.618+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-06-23 23:14:01.163+00	\N	\N	\N
707a2da0-3931-4717-afb6-116e1fae50fd	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47400000	-69.93500000	\N	2025-04-05 02:52:17.231+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
5d016b44-68c8-48d1-a86a-e9ee8644f164	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47400000	-69.93500000	\N	2025-01-18 18:11:32.78+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-01-21 14:29:54.319+00	\N	\N	\N
6e7100f2-7de2-4045-8d29-0b56790fec8c	51d869f4-fa16-4633-9121-561817fce43d	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47400000	-69.93500000	\N	2025-01-09 19:32:59.991+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	2025-02-01 17:41:35.661+00	\N	\N	\N
5c9c0a96-cbba-4fab-a623-ef5dfdea3ca1	a09cd383-3c5a-4f9f-8c5a-036761a96873	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47400000	-69.93500000	\N	2025-08-23 18:13:55.635+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-09-03 04:40:42.5+00	\N	\N	\N
f81880a1-ce35-4999-88e1-acba0f918bce	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Postes de luz averiados en Calle 3	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47400000	-69.93500000	\N	2025-01-26 03:21:47.529+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	\N	\N	\N	\N
e85e0f6c-9e47-42d4-89fa-eabb4725d173	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47400000	-69.93500000	\N	2025-02-24 19:46:15.783+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	\N	\N	\N	\N
e0d2b202-4e53-42d3-8542-96180fb5cd34	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.47400000	-69.93500000	\N	2025-03-10 10:36:45.92+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-04-03 17:43:01.709+00	\N	\N	\N
5bc02e0e-93ea-4db3-bcf6-b0e5354f1843	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Acumulación de basura en la esquina de Calle 21	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47400000	-69.93500000	\N	2025-07-14 07:59:28.083+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-07-14 09:05:17.872+00	\N	\N	\N
bb41b8c9-0ade-4729-b55d-0c419d985581	51d869f4-fa16-4633-9121-561817fce43d	Problemas con el suministro de agua	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47400000	-69.93500000	\N	2025-02-17 03:29:42.155+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	2025-03-05 21:15:06.627+00	\N	\N	\N
e4c293a9-922d-4cf2-b4fb-c66d35fe62a1	e294a283-3655-4b93-a207-04f486438f37	Daños en pavimento cerca de San Carlos	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47400000	-69.93500000	\N	2024-12-13 02:04:31.586+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
fd683e14-f626-4d10-aa67-706e691772ec	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47400000	-69.93500000	\N	2024-12-23 00:27:51.351+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	\N	\N	\N	\N
c7ff6528-b338-46e7-8572-89128a9ebcd2	51d869f4-fa16-4633-9121-561817fce43d	Animales callejeros en San Carlos	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47400000	-69.93500000	\N	2024-09-18 04:10:09.563+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2024-09-28 12:05:01.328+00	\N	\N	\N
91ff8425-c09d-45e7-8ae0-4ea1637e141d	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47400000	-69.93500000	\N	2025-07-07 11:57:55.922+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	2025-07-13 07:20:15.916+00	\N	\N	\N
5c0abc4a-074c-4124-9af1-778c85f4be93	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de mejoras en parque	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47400000	-69.93500000	\N	2024-08-27 12:02:39.44+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2024-09-02 12:00:32.604+00	\N	\N	\N
0f625fee-eca2-4bfe-b4a6-959411e79f70	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Postes de luz averiados en Calle 26	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47400000	-69.93500000	\N	2025-10-10 10:59:37.788+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-10-28 04:44:33.643+00	\N	\N	\N
1ad64320-9098-46f3-82da-4a0be1ccbfb3	e294a283-3655-4b93-a207-04f486438f37	Urgente reparación de vía principal	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.47400000	-69.93500000	\N	2025-03-15 23:38:53.422+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	alta	\N	\N	\N	\N
c4df34d7-7ae3-4f74-b386-b22823e6cf17	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en San Carlos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47400000	-69.93500000	\N	2025-08-10 22:47:56.289+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-08-26 23:39:48.793+00	\N	\N	\N
4b713978-3701-4e1c-8b01-8862df25bc71	51d869f4-fa16-4633-9121-561817fce43d	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector San Carlos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47400000	-69.93500000	\N	2025-06-29 10:50:52.498+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	baja	2025-07-06 20:25:49.292+00	\N	\N	\N
ae25932c-5ad8-4efc-8453-28cb2d2fe577	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en San Carlos que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47400000	-69.93500000	\N	2025-02-27 16:26:13.457+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
c0715c70-4e90-4c1b-b229-3c245d9a54db	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47400000	-69.93500000	\N	2025-02-10 06:07:15.959+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-02-17 17:50:42.436+00	\N	\N	\N
d08f573e-cd1d-482a-9d54-fd886e098ac3	51d869f4-fa16-4633-9121-561817fce43d	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en San Carlos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47400000	-69.93500000	\N	2025-02-05 08:12:33.161+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	\N	\N	\N	\N
d50078da-ee24-4d93-bbea-75233cf9966a	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Zona muy oscura por las noches	Falta de iluminación pública en San Carlos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47400000	-69.93500000	\N	2025-02-06 08:28:44.476+00	2025-07-11 04:15:42.255791+00	San Carlos, Santo Domingo	San Carlos	media	2025-02-14 05:11:40.731+00	\N	\N	\N
217d113c-7eb2-459a-8cdf-c6ec1a232d1d	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.46500000	-69.92500000	\N	2024-09-03 22:12:59.911+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
23a946be-4402-477c-94a2-1b3b712574de	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 49	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.92500000	\N	2025-06-17 18:31:37.571+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-07-14 00:31:15.498+00	\N	\N	\N
f3493b1b-fc48-4b99-968e-7ea7a7488048	51d869f4-fa16-4633-9121-561817fce43d	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.92500000	\N	2025-01-25 04:47:42.853+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	\N	\N	\N	\N
6c25e146-6b84-4d7a-86ce-a1192f315fbd	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.92500000	\N	2024-10-25 10:04:56.125+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	\N	\N	\N	\N
555bc0f9-3523-4ee4-abaa-87648ae8f9e9	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46500000	-69.92500000	\N	2025-07-02 22:00:07.815+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
a286f4aa-9e73-4d5e-b49e-b1721ca6a84c	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Postes de luz averiados en Calle 27	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.92500000	\N	2025-09-25 12:08:38.934+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
61a74076-349f-4ac2-80ee-faa62437a3c7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.92500000	\N	2024-10-18 17:06:42.3+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-11-08 20:31:01.413+00	\N	\N	\N
229b2812-a544-48e3-809d-4aee5de05eb0	a09cd383-3c5a-4f9f-8c5a-036761a96873	Contenedores desbordados en Villa Juana	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.92500000	\N	2025-02-01 23:40:05.88+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-02-19 23:33:40.353+00	\N	\N	\N
1785fbf5-f761-46e8-ab3a-c7980f6e92e8	e294a283-3655-4b93-a207-04f486438f37	Animales callejeros en Villa Juana	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46500000	-69.92500000	\N	2024-12-24 14:17:54.404+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-01-01 14:39:34.949+00	\N	\N	\N
aed87155-8d6b-48b2-a962-0938685543cb	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46500000	-69.92500000	\N	2025-08-26 07:50:16.096+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	baja	\N	\N	\N	\N
70ecc32c-1c91-4725-bd88-60b242318ac5	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Baches profundos en Calle 30	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46500000	-69.92500000	\N	2024-11-24 04:03:06.47+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	baja	2024-11-25 15:24:15.392+00	\N	\N	\N
64ec06bc-438f-4fe6-9b8f-bad7c3a5af0d	e294a283-3655-4b93-a207-04f486438f37	Animales callejeros en Villa Juana	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46500000	-69.92500000	\N	2025-04-30 16:36:41.838+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	baja	2025-05-04 19:23:21.337+00	\N	\N	\N
3d9400a0-8d5b-4ac0-8944-2f5a26b0c7f0	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Urgente reparación de vía principal	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.92500000	\N	2024-12-10 05:23:42.585+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-12-23 10:08:41.922+00	\N	\N	\N
78fa3097-d95b-43c0-acf7-98d5851aebed	a09cd383-3c5a-4f9f-8c5a-036761a96873	Bombillas fundidas en varias calles	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46500000	-69.92500000	\N	2025-05-14 06:35:32.979+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-05-28 21:48:50.988+00	\N	\N	\N
f0b4f120-a190-4e12-8896-68509769067a	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.92500000	\N	2024-10-06 02:36:07.061+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
79d5f2b3-c2a2-414a-84d5-aad6b4e16e5c	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.92500000	\N	2024-12-08 19:44:13.301+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
94db207b-5d14-4ab3-a962-2778869307ea	51d869f4-fa16-4633-9121-561817fce43d	Zona muy oscura por las noches	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46500000	-69.92500000	\N	2025-04-21 23:48:50.425+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-05-10 23:32:17.664+00	\N	\N	\N
84fdab95-2a8b-4afa-8d91-c60b05aa4fcd	51d869f4-fa16-4633-9121-561817fce43d	Falta de vigilancia en Villa Juana	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.92500000	\N	2024-12-12 02:24:53.283+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-01-08 10:37:12.605+00	\N	\N	\N
c2706d86-eac3-478a-9a7e-8d5795a1ce00	51d869f4-fa16-4633-9121-561817fce43d	Baches profundos en Calle 37	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46500000	-69.92500000	\N	2025-10-09 08:02:26.707+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
14c86b96-5682-40c1-9ed0-8bf85b31deb4	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Villa Juana	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.92500000	\N	2024-08-17 12:41:46.997+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-08-30 13:45:11.63+00	\N	\N	\N
887c91a2-4044-4494-8998-bab9e2d7b4ad	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.92500000	\N	2024-12-15 21:02:04.21+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
d3ff8798-de25-4135-a561-65e92a01dfd9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Animales callejeros en Villa Juana	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.92500000	\N	2024-10-08 13:40:30.937+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-10-28 09:24:08.554+00	\N	\N	\N
ad7f5cb7-9d88-43e9-81f6-6fa21ac99cb6	e294a283-3655-4b93-a207-04f486438f37	Ruido excesivo en las noches	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46500000	-69.92500000	\N	2024-09-26 04:05:56.033+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	2024-10-05 13:07:41.754+00	\N	\N	\N
5def6050-463b-4dc4-afc3-978a113c56cb	131c625c-8329-48ce-9b74-67991bd070fd	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.92500000	\N	2025-02-19 08:48:14.808+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-03-12 12:16:42.603+00	\N	\N	\N
cc02d6ba-d2a8-4f5d-9591-6b30178fe778	51d869f4-fa16-4633-9121-561817fce43d	Ruido excesivo en las noches	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46500000	-69.92500000	\N	2025-06-04 17:13:27.398+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
81906ab6-c64a-465d-93a7-400abc269588	e294a283-3655-4b93-a207-04f486438f37	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46500000	-69.92500000	\N	2024-10-01 21:15:39.174+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	2024-10-07 08:41:00.494+00	\N	\N	\N
32c2c8fa-4a03-4b90-b979-ab75ac56bf83	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 6	Se reporta acumulación de basura en el sector Villa Juana. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.92500000	\N	2025-06-02 00:54:00.522+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	baja	2025-06-09 01:23:56.17+00	\N	\N	\N
c74a8345-9fdd-4991-87b5-d62df5f4800c	e294a283-3655-4b93-a207-04f486438f37	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.92500000	\N	2024-08-28 02:55:09.634+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
2de27471-8d4b-4831-bab7-744be6200b6e	a09cd383-3c5a-4f9f-8c5a-036761a96873	Robos frecuentes en la zona	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46500000	-69.92500000	\N	2025-05-01 13:44:27.689+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-05-19 07:14:02.803+00	\N	\N	\N
00a3f732-b02c-49f9-acfb-eb42bee99612	e294a283-3655-4b93-a207-04f486438f37	Problemas con el suministro de agua	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46500000	-69.92500000	\N	2024-12-26 20:37:56.594+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-12-27 06:59:36.336+00	\N	\N	\N
236c826e-4fb3-4f0b-9fe1-c5343200c8d1	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Villa Juana	Situación de inseguridad reportada en Villa Juana. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.46500000	-69.92500000	\N	2025-01-22 09:01:03.064+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-01-24 11:17:42.496+00	\N	\N	\N
6de5cb7e-9e23-4b74-aea0-6c2edf719eac	51d869f4-fa16-4633-9121-561817fce43d	Daños en pavimento cerca de Villa Juana	Deterioro significativo del pavimento en Villa Juana debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.92500000	\N	2025-08-21 12:39:53.661+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
bb083515-b355-44e2-993e-eb814db074c0	131c625c-8329-48ce-9b74-67991bd070fd	Daños en aceras y bordillos	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.92500000	\N	2024-10-28 02:24:57.556+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2024-11-14 16:42:27.401+00	\N	\N	\N
bb129b8c-583b-4803-bc27-8af969f731f7	131c625c-8329-48ce-9b74-67991bd070fd	Falta de iluminación en parque de Villa Juana	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46500000	-69.92500000	\N	2025-08-17 07:27:25.951+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	\N	\N	\N	\N
616e3b6b-f11c-452f-b63f-2e8008153881	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Villa Juana crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.92500000	\N	2025-09-24 19:37:09.109+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-10-05 18:18:45.294+00	\N	\N	\N
f9e16fc9-8e79-4223-91cc-671b6da00917	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en aceras y bordillos	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46500000	-69.92500000	\N	2024-10-02 03:45:20.531+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	\N	\N	\N	\N
3ebf6fc8-cecd-4b46-8f8e-c539a7644c6e	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46500000	-69.92500000	\N	2025-01-18 14:56:51.972+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	media	2025-02-17 04:53:58.19+00	\N	\N	\N
61e27001-99a1-4bf5-a1d9-92362c12b254	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de mejoras en parque	Problema general reportado en Villa Juana que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46500000	-69.92500000	\N	2024-12-25 11:16:41.895+00	2025-07-11 04:15:42.255791+00	Villa Juana, Santo Domingo	Villa Juana	alta	\N	\N	\N	\N
aafe5089-18cb-4f33-8bf8-3654e515d9cf	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Mirador Sur. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	rechazado	18.46000000	-69.94000000	\N	2025-02-21 03:11:55.571+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-03-18 17:31:34.695+00	\N	\N	\N
e79cf4d6-8ceb-46c4-ac2a-d9b3bfc37504	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Bombillas fundidas en varias calles	Falta de iluminación pública en Mirador Sur crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46000000	-69.94000000	\N	2025-01-10 16:19:04.709+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
59541268-3537-4c47-8cd5-b2eb39378867	51d869f4-fa16-4633-9121-561817fce43d	Acumulación de basura en la esquina de Calle 2	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2024-09-10 14:06:42.528+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	\N	\N	\N	\N
b3155135-ac77-41c6-acf2-668bc361f2ae	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Mirador Sur crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46000000	-69.94000000	\N	2024-09-27 03:03:48.299+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
428d051c-8bd6-4879-bafd-e1ada192b3de	131c625c-8329-48ce-9b74-67991bd070fd	Animales callejeros en Mirador Sur	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46000000	-69.94000000	\N	2025-03-23 00:21:09.765+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-04-07 04:03:50.903+00	\N	\N	\N
d97377b6-629b-49c0-9d8f-20dbad9bf4ff	131c625c-8329-48ce-9b74-67991bd070fd	Ruido excesivo en las noches	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46000000	-69.94000000	\N	2024-09-26 23:39:00.956+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
120ecb7f-6793-4f81-9b0f-1d99329aaaf2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Acumulación de basura en la esquina de Calle 35	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-05-02 12:25:02.172+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
d672eb9e-700f-4ea9-81e7-10f1e9a6da1b	a09cd383-3c5a-4f9f-8c5a-036761a96873	Animales callejeros en Mirador Sur	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46000000	-69.94000000	\N	2025-06-03 23:53:49.467+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-06-24 02:36:35.964+00	\N	\N	\N
d84ece94-b39e-4d94-8568-0c045debe7a7	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Daños en pavimento cerca de Mirador Sur	Deterioro significativo del pavimento en Mirador Sur debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46000000	-69.94000000	\N	2025-08-26 02:21:13.109+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
91e53ff3-2860-4018-94e9-c796b0b9b49e	a09cd383-3c5a-4f9f-8c5a-036761a96873	Contenedores desbordados en Mirador Sur	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46000000	-69.94000000	\N	2024-08-26 13:56:06.093+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	baja	\N	\N	\N	\N
f53f67ac-5b98-4c48-9332-61b0383419c9	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Daños en pavimento cerca de Mirador Sur	Deterioro significativo del pavimento en Mirador Sur debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46000000	-69.94000000	\N	2025-01-02 05:57:48.125+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-01-11 23:45:34.249+00	\N	\N	\N
1bc249c6-1152-421b-b986-1886bdc46ff8	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Cableado eléctrico en mal estado	Falta de iluminación pública en Mirador Sur crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46000000	-69.94000000	\N	2024-11-11 02:06:04.957+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	baja	\N	\N	\N	\N
36c133dc-d882-49a5-b27b-f747383dfe26	a09cd383-3c5a-4f9f-8c5a-036761a96873	Área insegura durante la noche	Situación de inseguridad reportada en Mirador Sur. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46000000	-69.94000000	\N	2025-02-13 06:11:33.4+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	2025-02-20 21:44:41.398+00	\N	\N	\N
5bd0560f-17dd-4904-ae20-2c7128e7485f	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Mirador Sur debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46000000	-69.94000000	\N	2025-05-28 12:10:17.145+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	2025-05-30 01:54:02.627+00	\N	\N	\N
17656aa1-d3ca-4c81-9e76-3b6e4b005fb7	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46000000	-69.94000000	\N	2024-10-06 04:33:54.015+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2024-11-01 16:28:20.528+00	\N	\N	\N
e9ee5890-1ec1-4dfb-86b9-3c8a334a1f40	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46000000	-69.94000000	\N	2025-04-13 13:40:58.79+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-05-06 03:45:16.544+00	\N	\N	\N
808d669d-d6fa-4e0b-aa86-62aeb2367887	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-01-27 01:37:18.697+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	2025-02-04 11:41:41.327+00	\N	\N	\N
ab6288d2-9b23-43a0-800b-c5023aa7db76	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Mirador Sur. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46000000	-69.94000000	\N	2025-06-02 15:50:34.174+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-07-01 12:37:24.174+00	\N	\N	\N
e1f00f45-dc8c-41c5-a975-f16753230c25	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Acumulación de basura en la esquina de Calle 29	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46000000	-69.94000000	\N	2024-09-22 03:35:19.233+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2024-09-23 23:29:58.312+00	\N	\N	\N
749c4c01-1700-4c73-9a9a-3cce70109cd6	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46000000	-69.94000000	\N	2025-06-01 14:49:02.003+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-06-17 12:38:55.257+00	\N	\N	\N
fa79de95-5406-4d04-aec7-8eee13d9ffd0	131c625c-8329-48ce-9b74-67991bd070fd	Daños en aceras y bordillos	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46000000	-69.94000000	\N	2025-05-22 19:31:39.65+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-05-23 03:56:48.162+00	\N	\N	\N
f50c7e32-6fa8-4d68-a272-348df99acba2	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Animales callejeros en Mirador Sur	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46000000	-69.94000000	\N	2024-07-28 01:26:17.37+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2024-07-31 22:04:04.217+00	\N	\N	\N
2c85063c-942e-4f57-83bc-3bb9402741ca	51d869f4-fa16-4633-9121-561817fce43d	Acumulación de basura en la esquina de Calle 12	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-01-01 13:03:33.032+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-01-09 11:42:57.197+00	\N	\N	\N
1139b259-779d-4323-8384-f74df4696be3	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-05-13 22:40:16.924+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
efe99f64-310e-4c85-86d4-adf938ad1a3a	131c625c-8329-48ce-9b74-67991bd070fd	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Mirador Sur. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46000000	-69.94000000	\N	2025-03-02 22:49:30.769+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-03-27 18:08:33.719+00	\N	\N	\N
3a3daafa-099f-4896-9ca2-938f1cb0228e	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Zona muy oscura por las noches	Falta de iluminación pública en Mirador Sur crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46000000	-69.94000000	\N	2025-04-26 11:17:34.404+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	\N	\N	\N	\N
ebd672b2-b2ce-462f-9576-302e31ff52b1	e294a283-3655-4b93-a207-04f486438f37	Daños en pavimento cerca de Mirador Sur	Deterioro significativo del pavimento en Mirador Sur debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46000000	-69.94000000	\N	2025-05-16 03:49:43.059+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-06-04 15:26:04.802+00	\N	\N	\N
08a0a930-825d-43e1-aae7-13d956d201d4	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Postes de luz averiados en Calle 1	Falta de iluminación pública en Mirador Sur crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46000000	-69.94000000	\N	2025-04-02 22:39:28.258+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-04-28 22:13:05.209+00	\N	\N	\N
9220f208-030b-44e4-902f-276cb5502e0f	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Baches profundos en Calle 48	Deterioro significativo del pavimento en Mirador Sur debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46000000	-69.94000000	\N	2025-03-15 08:28:20.486+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-03-23 16:12:31.956+00	\N	\N	\N
a4749f78-0bc5-40ee-8586-29c3221fa263	a09cd383-3c5a-4f9f-8c5a-036761a96873	Solicitud de mejoras en parque	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.46000000	-69.94000000	\N	2025-04-03 23:17:39.237+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-04-27 10:28:29.865+00	\N	\N	\N
45d85a53-37b2-4145-a715-7cc6bc00f14f	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 38	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-04-30 16:18:02.256+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-05-15 21:33:35.438+00	\N	\N	\N
715ce3c9-6a0d-4980-9efe-625409bdddcb	51d869f4-fa16-4633-9121-561817fce43d	Acumulación de basura en la esquina de Calle 11	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46000000	-69.94000000	\N	2025-08-15 02:44:53.297+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	2025-08-21 18:06:48.454+00	\N	\N	\N
284aaa21-6337-403f-9034-f2e9608998a8	e294a283-3655-4b93-a207-04f486438f37	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46000000	-69.94000000	\N	2025-07-04 05:45:14.41+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	baja	\N	\N	\N	\N
765b3173-7a73-4ce6-9529-dc04cfa2eba2	51d869f4-fa16-4633-9121-561817fce43d	Contenedores desbordados en Mirador Sur	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2025-03-28 10:41:56.262+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	baja	\N	\N	\N	\N
f278fd9d-9fa4-46e1-88e1-35edad939b43	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Animales callejeros en Mirador Sur	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.46000000	-69.94000000	\N	2025-05-24 05:07:03.58+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	2025-06-07 04:47:01.338+00	\N	\N	\N
7f1d140a-2bea-4f28-bb2a-0ecd5cebd444	131c625c-8329-48ce-9b74-67991bd070fd	Basura dispersa después del día de recolección	Se reporta acumulación de basura en el sector Mirador Sur. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46000000	-69.94000000	\N	2024-12-28 23:27:49.698+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	alta	\N	\N	\N	\N
7457dc63-ba96-420b-a6fa-fb8505fa1780	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Ruido excesivo en las noches	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.46000000	-69.94000000	\N	2025-01-24 01:31:06.028+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
ea5f82c8-4ad0-4276-8c59-a54b497c79b8	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en aceras y bordillos	Problema general reportado en Mirador Sur que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.46000000	-69.94000000	\N	2024-10-26 22:55:11.716+00	2025-07-11 04:15:42.255791+00	Mirador Sur, Santo Domingo	Mirador Sur	media	\N	\N	\N	\N
38c89fb1-11e1-4828-ac73-4f5c1e02c0bd	a09cd383-3c5a-4f9f-8c5a-036761a96873	Problemas con el suministro de agua	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	en_proceso	18.47000000	-69.95000000	\N	2025-01-23 19:00:25.878+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2025-01-24 11:27:25.851+00	\N	\N	\N
f9662957-aa90-498f-91c9-863d17097757	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de mejoras en parque	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47000000	-69.95000000	\N	2025-06-28 05:39:14.496+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-07-13 05:56:19.704+00	\N	\N	\N
acac7f2b-48db-40db-8d5c-05e9388b68d7	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47000000	-69.95000000	\N	2024-09-26 07:56:25.349+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
cc74b17b-4ca6-4c9b-87b6-86ea54ee7d67	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47000000	-69.95000000	\N	2025-03-14 08:49:00.103+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-03-17 20:34:44.12+00	\N	\N	\N
6192202c-e3fd-4c85-b8a7-38991b628fa7	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Animales callejeros en Cristo Rey	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47000000	-69.95000000	\N	2024-08-18 14:12:56.108+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	\N	\N	\N	\N
61715e62-f53f-49f5-9913-157a8906cf55	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Deterioro del asfalto por lluvias	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47000000	-69.95000000	\N	2024-08-08 10:40:51.178+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2024-08-27 13:30:37.518+00	\N	\N	\N
eb06fe47-3563-4bfb-a6ba-27fb1b6d3c6b	e294a283-3655-4b93-a207-04f486438f37	Robos frecuentes en la zona	Situación de inseguridad reportada en Cristo Rey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47000000	-69.95000000	\N	2024-12-01 07:48:04.778+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
f248678c-2d17-4bcc-bc7f-ec43e1f434e4	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Cristo Rey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.47000000	-69.95000000	\N	2024-10-31 08:07:22.484+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2024-11-24 06:26:42.493+00	\N	\N	\N
7b659bf0-4780-4ee7-b0a1-7396ca68fa77	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47000000	-69.95000000	\N	2025-03-20 01:11:00.936+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-04-02 13:40:17.567+00	\N	\N	\N
22861837-43f9-40a3-a6b8-5dc4b4921706	a09cd383-3c5a-4f9f-8c5a-036761a96873	Postes de luz averiados en Calle 24	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47000000	-69.95000000	\N	2024-12-16 16:31:23.878+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
c7df89f4-6552-401a-ae21-038b483aa772	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Zona muy oscura por las noches	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47000000	-69.95000000	\N	2024-10-13 11:45:32.168+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
066bb9ee-b1c0-4cd0-9d1d-6609d1125118	e294a283-3655-4b93-a207-04f486438f37	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47000000	-69.95000000	\N	2025-02-28 05:50:44.723+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	\N	\N	\N	\N
a9e5a01e-3e59-4610-8c84-d7c75302b82d	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Cableado eléctrico en mal estado	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47000000	-69.95000000	\N	2024-11-20 19:00:27.415+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2024-12-03 10:30:39.144+00	\N	\N	\N
d3d9c005-2bb5-4828-8251-837ce6ee7194	e294a283-3655-4b93-a207-04f486438f37	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Cristo Rey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47000000	-69.95000000	\N	2025-01-23 15:33:04.475+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-01-29 18:09:26.344+00	\N	\N	\N
3768cb2f-e4d9-4950-a5ab-99c3a2d386c5	e294a283-3655-4b93-a207-04f486438f37	Bombillas fundidas en varias calles	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47000000	-69.95000000	\N	2025-06-24 12:58:19.212+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-07-10 05:28:19.202+00	\N	\N	\N
43560ab0-8331-4f3f-9ad4-24bdc133eaea	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 13	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.47000000	-69.95000000	\N	2024-10-09 21:10:49.999+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2024-10-16 11:51:03.232+00	\N	\N	\N
cc7e1b12-5e90-4b79-ab5f-ab46d09d23ad	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Calle intransitable por hoyos	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47000000	-69.95000000	\N	2025-12-19 04:50:53.396+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2026-01-10 06:37:58.287+00	\N	\N	\N
aead11c3-ce32-4c10-bc7f-b1d7a50df29e	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Cristo Rey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	pendiente	18.47000000	-69.95000000	\N	2025-04-17 05:52:06.134+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
c0b5c585-7e41-41e7-b2d5-3d70e39981d6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Calle intransitable por hoyos	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.47000000	-69.95000000	\N	2025-08-22 23:16:19.975+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-09-18 04:49:36.574+00	\N	\N	\N
64ebeec3-d227-42a9-a688-093cc5bf5e4d	131c625c-8329-48ce-9b74-67991bd070fd	Zona muy oscura por las noches	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47000000	-69.95000000	\N	2024-12-30 00:15:00.574+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
ddc44405-a31b-4f92-be5d-6f6ebb5656f6	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	rechazado	18.47000000	-69.95000000	\N	2024-11-08 07:46:26.402+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	baja	2024-11-26 13:48:49.049+00	\N	\N	\N
1d1edd38-17ae-45d8-9b1f-2086d1846548	51d869f4-fa16-4633-9121-561817fce43d	Postes de luz averiados en Calle 7	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47000000	-69.95000000	\N	2025-10-02 01:08:31.951+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
1d11cbd7-d058-40c4-ae8e-e00e9fafe972	e294a283-3655-4b93-a207-04f486438f37	Postes de luz averiados en Calle 7	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.47000000	-69.95000000	\N	2024-12-10 20:25:26.061+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	baja	2024-12-28 12:23:35.997+00	\N	\N	\N
92d10898-7cf5-419b-af0c-b7b981b2fd47	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Baches profundos en Calle 16	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.47000000	-69.95000000	\N	2025-02-03 11:22:47.799+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
44c09077-2f5f-44cd-adc6-b5833565597d	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47000000	-69.95000000	\N	2025-10-31 14:17:28.157+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	baja	\N	\N	\N	\N
5c245ab8-b1a3-416f-bd87-9a5e391427e4	a09cd383-3c5a-4f9f-8c5a-036761a96873	Acumulación de basura en la esquina de Calle 16	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47000000	-69.95000000	\N	2024-11-07 22:22:44.841+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2024-11-22 22:28:55.653+00	\N	\N	\N
0253bd7d-a22d-4862-995e-c31f8515441f	131c625c-8329-48ce-9b74-67991bd070fd	Daños en pavimento cerca de Cristo Rey	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47000000	-69.95000000	\N	2025-09-21 10:36:37.512+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	baja	2025-10-13 17:25:47.106+00	\N	\N	\N
97fc4593-423e-466e-bec5-ab49e03cc699	131c625c-8329-48ce-9b74-67991bd070fd	Problemas con el suministro de agua	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	pendiente	18.47000000	-69.95000000	\N	2024-08-02 03:55:31.763+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
829542fa-4855-43aa-9226-9d5b71068619	51d869f4-fa16-4633-9121-561817fce43d	Falta de iluminación en parque de Cristo Rey	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.47000000	-69.95000000	\N	2025-06-22 11:29:43.589+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	baja	\N	\N	\N	\N
28610289-53c0-41c2-918b-b69124b06017	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Bombillas fundidas en varias calles	Falta de iluminación pública en Cristo Rey crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.47000000	-69.95000000	\N	2025-01-07 01:13:23.952+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-01-12 23:52:01.958+00	\N	\N	\N
5c05226d-c81e-49be-9afd-080489c695f5	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Solicitud de mejoras en parque	Problema general reportado en Cristo Rey que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.47000000	-69.95000000	\N	2024-11-19 01:40:37.211+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	\N	\N	\N	\N
0bfe9c90-5bb7-4ac3-90ac-3a502f03ef8d	51d869f4-fa16-4633-9121-561817fce43d	Calle intransitable por hoyos	Deterioro significativo del pavimento en Cristo Rey debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.47000000	-69.95000000	\N	2025-06-18 02:13:37.134+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	alta	2025-07-11 12:13:41.318+00	\N	\N	\N
c9f7ff8b-022c-4ad8-b4b9-45166ceb4d64	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Robos frecuentes en la zona	Situación de inseguridad reportada en Cristo Rey. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.47000000	-69.95000000	\N	2025-05-16 19:23:04.766+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-06-02 06:55:21.69+00	\N	\N	\N
0b70492b-4884-4967-a1ee-3a2ccf5af406	131c625c-8329-48ce-9b74-67991bd070fd	Vertedero improvisado en área verde	Se reporta acumulación de basura en el sector Cristo Rey. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.47000000	-69.95000000	\N	2025-01-06 23:45:14.129+00	2025-07-11 04:15:42.255791+00	Cristo Rey, Santo Domingo	Cristo Rey	media	2025-01-27 08:16:06.544+00	\N	\N	\N
bf209651-7372-49d0-a4f6-d2f094d90d2b	131c625c-8329-48ce-9b74-67991bd070fd	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46500000	-69.89000000	\N	2025-01-17 08:36:27.644+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
3e8dd1bd-afa5-4718-b17a-ee61938a4a0f	51d869f4-fa16-4633-9121-561817fce43d	Urgente reparación de vía principal	Deterioro significativo del pavimento en Los Ríos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	rechazado	18.46500000	-69.89000000	\N	2024-10-02 20:53:31.958+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
b7fc577e-024e-42f5-a7a3-594b0d85afb9	51d869f4-fa16-4633-9121-561817fce43d	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46500000	-69.89000000	\N	2025-06-17 22:12:08.773+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
10daa183-3ae3-42c6-a351-cd46affc6351	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.89000000	\N	2024-10-17 06:20:11.119+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	2024-10-30 11:13:12.056+00	\N	\N	\N
d020d5cd-3ca7-4a12-8fe1-e26174a143e6	131c625c-8329-48ce-9b74-67991bd070fd	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.89000000	\N	2024-09-15 22:16:51.111+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-09-25 00:10:32.7+00	\N	\N	\N
8065ef13-c6ad-4dbb-b520-b7aa8073b2aa	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de vigilancia en Los Ríos	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.89000000	\N	2025-01-22 21:16:24.881+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
c8d86c93-7acd-409a-bd44-e3c2e3f51e1d	a09cd383-3c5a-4f9f-8c5a-036761a96873	Cableado eléctrico en mal estado	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.89000000	\N	2025-03-29 22:43:40.092+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
8ce5a067-5331-4112-bc35-9f72aca4888c	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Daños en aceras y bordillos	Problema general reportado en Los Ríos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.89000000	\N	2025-01-12 06:08:29.42+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	baja	2025-02-02 13:26:24.789+00	\N	\N	\N
e7a68361-aa54-41b2-8484-3987d2564731	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	Solicitud de mejoras en parque	Problema general reportado en Los Ríos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.89000000	\N	2025-02-16 21:48:05.157+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
5a22f613-5e77-46bb-b7be-6e5939baab7f	e294a283-3655-4b93-a207-04f486438f37	Falta de iluminación en parque de Los Ríos	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46500000	-69.89000000	\N	2025-08-30 06:24:01.925+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
a6506bc4-1a4a-4e67-9682-fbfb5d146879	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Falta de contenedores en la zona	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46500000	-69.89000000	\N	2025-05-03 04:58:53.028+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	2025-05-08 03:23:01.996+00	\N	\N	\N
8481c9a9-f80d-4a48-a9a0-8a093af546b6	51d869f4-fa16-4633-9121-561817fce43d	Contenedores desbordados en Los Ríos	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.89000000	\N	2024-07-12 20:08:19.033+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	baja	2024-07-28 00:07:39.893+00	\N	\N	\N
97e8e1ed-9235-46a3-92b5-f4e82f887f40	a09cd383-3c5a-4f9f-8c5a-036761a96873	Urgente reparación de vía principal	Deterioro significativo del pavimento en Los Ríos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.89000000	\N	2025-05-01 17:20:37.927+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
f86e75e0-72b8-41ee-a1a6-1082c690ecb5	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Postes de luz averiados en Calle 39	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.89000000	\N	2025-08-20 01:13:07.993+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	2025-09-10 02:22:45.964+00	\N	\N	\N
a2261f94-65ea-4af9-a7e4-75f8db99bd66	51d869f4-fa16-4633-9121-561817fce43d	Zona muy oscura por las noches	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46500000	-69.89000000	\N	2024-10-28 13:27:45.368+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
603ab025-abe1-49bd-a76b-66e1a9808368	a09cd383-3c5a-4f9f-8c5a-036761a96873	Daños en pavimento cerca de Los Ríos	Deterioro significativo del pavimento en Los Ríos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	pendiente	18.46500000	-69.89000000	\N	2025-11-03 23:06:32.899+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	2025-11-24 16:41:26.426+00	\N	\N	\N
2081c8a8-3a66-46df-9bad-f78c27965620	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.89000000	\N	2024-12-30 11:35:34.208+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-01-03 04:18:50.849+00	\N	\N	\N
09d24a32-3e97-4e41-8e13-496c6d627068	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Contenedores desbordados en Los Ríos	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	pendiente	18.46500000	-69.89000000	\N	2025-03-11 23:57:30.118+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
40ab96c9-f4d0-4adf-bc02-f7ef81e0256b	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Falta de iluminación en parque de Los Ríos	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	rechazado	18.46500000	-69.89000000	\N	2025-03-14 04:41:00.375+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-03-26 00:52:31.068+00	\N	\N	\N
18ac0252-b6ed-4621-8a17-be437788ad62	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Solicitud de cámaras de seguridad	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.89000000	\N	2025-05-10 13:12:40.147+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-06-06 08:07:04.387+00	\N	\N	\N
0f742145-8a98-4518-b87a-ce5ea6bd232b	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Contenedores desbordados en Los Ríos	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	rechazado	18.46500000	-69.89000000	\N	2025-02-05 01:13:43.311+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-02-14 03:08:57.116+00	\N	\N	\N
51e89ab1-84b4-4bd7-9552-2d664b2626f2	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.89000000	\N	2024-11-06 21:51:57.419+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-11-19 09:51:01.19+00	\N	\N	\N
f273d11d-58a3-4a5e-bce5-15af09627752	e294a283-3655-4b93-a207-04f486438f37	Baches profundos en Calle 18	Deterioro significativo del pavimento en Los Ríos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	en_proceso	18.46500000	-69.89000000	\N	2025-08-01 06:02:05.878+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-08-15 15:48:36.123+00	\N	\N	\N
9c94fae0-2bd4-47cf-88c6-bab50a70ec08	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Urgente reparación de vía principal	Deterioro significativo del pavimento en Los Ríos debido a las lluvias recientes. Los baches representan un peligro para vehículos y peatones.	baches	resuelto	18.46500000	-69.89000000	\N	2024-07-17 06:42:46.521+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	2024-08-11 14:48:24.023+00	\N	\N	\N
9b95d3be-db37-4b6c-b6c0-741ef026a441	51d869f4-fa16-4633-9121-561817fce43d	Bombillas fundidas en varias calles	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	en_proceso	18.46500000	-69.89000000	\N	2025-07-21 19:44:58.673+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-07-28 22:22:29.358+00	\N	\N	\N
f573c599-654b-40a0-8def-7e2db5a68c89	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Área insegura durante la noche	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	en_proceso	18.46500000	-69.89000000	\N	2025-01-08 05:37:55.021+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
502df1eb-67e3-46e6-abff-7cd479498a40	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Problemas con el suministro de agua	Problema general reportado en Los Ríos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.89000000	\N	2025-01-11 10:53:14.564+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	\N	\N	\N	\N
5e355b90-fb56-4302-a658-59d866cc3a68	a09cd383-3c5a-4f9f-8c5a-036761a96873	Ruido excesivo en las noches	Problema general reportado en Los Ríos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.89000000	\N	2024-07-18 20:48:24.108+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-07-31 05:11:02.64+00	\N	\N	\N
ac0520c4-3f04-4f96-9a05-0fc8eb1135f6	e294a283-3655-4b93-a207-04f486438f37	Daños en aceras y bordillos	Problema general reportado en Los Ríos que requiere atención de las autoridades municipales correspondientes.	otros	resuelto	18.46500000	-69.89000000	\N	2024-07-31 12:48:05.809+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-08-16 07:31:05.62+00	\N	\N	\N
58c7dffd-0e32-4f8f-86b0-da5bade1096e	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 47	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	resuelto	18.46500000	-69.89000000	\N	2025-04-05 09:24:23.583+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	alta	\N	\N	\N	\N
02d216e8-f914-4e57-85a7-6d64ed07eef9	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	Zona muy oscura por las noches	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	resuelto	18.46500000	-69.89000000	\N	2024-10-12 12:30:58.713+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-10-19 17:28:59.928+00	\N	\N	\N
f23e64d5-2c73-4385-8980-7fa6fbe56130	e294a283-3655-4b93-a207-04f486438f37	Acumulación de basura en la esquina de Calle 49	Se reporta acumulación de basura en el sector Los Ríos. La situación afecta la salubridad del área y requiere atención inmediata del servicio de limpieza municipal.	basura	en_proceso	18.46500000	-69.89000000	\N	2025-01-19 20:59:25.75+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2025-01-27 16:02:40.532+00	\N	\N	\N
3622ab9e-2248-42c7-9a02-5429bdba05d3	e953b9ba-10a2-4efe-a8c6-f89590cbda92	Necesidad de más patrullaje policial	Situación de inseguridad reportada en Los Ríos. Se requiere mayor presencia policial y medidas de seguridad preventivas.	seguridad	resuelto	18.46500000	-69.89000000	\N	2024-12-17 14:49:51.893+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-12-26 10:22:00.716+00	\N	\N	\N
83116beb-8fb2-43e9-9583-debaa17d3759	a09cd383-3c5a-4f9f-8c5a-036761a96873	Falta de iluminación en parque de Los Ríos	Falta de iluminación pública en Los Ríos crea inseguridad para los residentes. Se solicita reparación urgente del alumbrado público.	iluminacion	pendiente	18.46500000	-69.89000000	\N	2024-09-28 02:10:54.582+00	2025-07-11 04:15:42.255791+00	Los Ríos, Santo Domingo	Los Ríos	media	2024-10-24 06:13:56.432+00	\N	\N	\N
\.


--
-- Data for Name: user_2fa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_2fa (id, user_id, secret, enabled, backup_codes, created_at, updated_at, last_used_at) FROM stdin;
d3c9c9bd-94b0-4da7-bd6a-e2eadc7465d5	51d869f4-fa16-4633-9121-561817fce43d	YXNJBYQI4YYEGLRSBCPZ3JJU4YAGE3VR	t	{TS8R8W0E,JBRAQALD,ZUF3YZ2M,Z1NVIQIB,COD7RAKL,4RN16Y8Y,61WGP8E2,K1T8SKOQ,JWDPDVF5,D077203E}	2025-07-10 15:42:45.055976+00	2025-07-12 02:15:37.826934+00	2025-07-12 02:15:37.61+00
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, user_id, role, assigned_by, assigned_at, is_active) FROM stdin;
2a618e25-a9bd-4074-b88e-835192fc82e3	51d869f4-fa16-4633-9121-561817fce43d	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-06-15 17:06:22.358036+00	t
61cd0e3a-a269-4f95-bad9-2c648443a409	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	community_user	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:32:23.008076+00	f
e13f0fe0-e721-4f66-ad2a-ed9b23595540	e953b9ba-10a2-4efe-a8c6-f89590cbda92	community_leader	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:44:57.058967+00	f
7e15bd79-a7e9-49bb-96b6-032c3617a9e6	e294a283-3655-4b93-a207-04f486438f37	community_leader	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:52:28.869608+00	f
5bf9bf55-29f4-4b89-a0d3-5fe8f65428e3	e294a283-3655-4b93-a207-04f486438f37	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:40:59.641367+00	t
cfc0999c-63a0-47ca-a266-df682e7a54c4	e294a283-3655-4b93-a207-04f486438f37	community_user	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:32:23.008076+00	f
7baad731-b7d1-475f-8d1c-4c587a5574cb	e953b9ba-10a2-4efe-a8c6-f89590cbda92	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:56:22.685533+00	t
6ed7fd95-d6ab-4505-8486-e8b9893c5eb6	e953b9ba-10a2-4efe-a8c6-f89590cbda92	community_user	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:32:23.008076+00	f
bce50be2-8ef7-4002-b1e8-f9e2787845e5	99d6a30e-a9ee-4b82-a9a7-b51c2eb19e92	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 01:43:24.665493+00	t
44896288-7609-4cae-b6bd-1c4b1fe897ad	a09cd383-3c5a-4f9f-8c5a-036761a96873	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-07-07 03:17:41.500743+00	t
11f34000-3c2e-4cee-a33f-1c2f3f9a7848	a09cd383-3c5a-4f9f-8c5a-036761a96873	community_user	\N	2025-07-07 02:57:33.490802+00	f
d5fe08aa-228d-440f-af42-b8e97c2da6fa	ba58b1a4-2308-4cc9-a741-3a0c579d6b86	community_user	\N	2025-07-10 16:10:54.869207+00	t
afe5f450-b326-461c-91da-fa21fb7ef99b	131c625c-8329-48ce-9b74-67991bd070fd	community_user	51d869f4-fa16-4633-9121-561817fce43d	2025-07-09 02:28:40.55583+00	t
9ef0c6aa-f30a-46c1-ba03-94ab60a448e1	131c625c-8329-48ce-9b74-67991bd070fd	admin	51d869f4-fa16-4633-9121-561817fce43d	2025-07-09 02:40:39.465157+00	f
\.


--
-- Data for Name: messages_2025_07_09; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_09 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_10; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_10 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_11; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_11 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_12; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_12 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_13; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_13 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_14; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_14 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_07_15; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_15 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-06-15 01:36:34
20211116045059	2025-06-15 01:36:36
20211116050929	2025-06-15 01:36:38
20211116051442	2025-06-15 01:36:40
20211116212300	2025-06-15 01:36:43
20211116213355	2025-06-15 01:36:45
20211116213934	2025-06-15 01:36:47
20211116214523	2025-06-15 01:36:50
20211122062447	2025-06-15 01:36:52
20211124070109	2025-06-15 01:36:54
20211202204204	2025-06-15 01:36:56
20211202204605	2025-06-15 01:36:58
20211210212804	2025-06-15 01:37:04
20211228014915	2025-06-15 01:37:06
20220107221237	2025-06-15 01:37:08
20220228202821	2025-06-15 01:37:10
20220312004840	2025-06-15 01:37:12
20220603231003	2025-06-15 01:37:16
20220603232444	2025-06-15 01:37:18
20220615214548	2025-06-15 01:37:20
20220712093339	2025-06-15 01:37:22
20220908172859	2025-06-15 01:37:24
20220916233421	2025-06-15 01:37:26
20230119133233	2025-06-15 01:37:28
20230128025114	2025-06-15 01:37:31
20230128025212	2025-06-15 01:37:33
20230227211149	2025-06-15 01:37:35
20230228184745	2025-06-15 01:37:37
20230308225145	2025-06-15 01:37:39
20230328144023	2025-06-15 01:37:41
20231018144023	2025-06-15 01:37:43
20231204144023	2025-06-15 01:37:47
20231204144024	2025-06-15 01:37:49
20231204144025	2025-06-15 01:37:51
20240108234812	2025-06-15 01:37:53
20240109165339	2025-06-15 01:37:55
20240227174441	2025-06-15 01:37:58
20240311171622	2025-06-15 01:38:01
20240321100241	2025-06-15 01:38:06
20240401105812	2025-06-15 01:38:11
20240418121054	2025-06-15 01:38:14
20240523004032	2025-06-15 01:38:21
20240618124746	2025-06-15 01:38:23
20240801235015	2025-06-15 01:38:25
20240805133720	2025-06-15 01:38:27
20240827160934	2025-06-15 01:38:29
20240919163303	2025-06-15 01:38:32
20240919163305	2025-06-15 01:38:34
20241019105805	2025-06-15 01:38:36
20241030150047	2025-06-15 01:38:44
20241108114728	2025-06-15 01:38:47
20241121104152	2025-06-15 01:38:49
20241130184212	2025-06-15 01:38:51
20241220035512	2025-06-15 01:38:53
20241220123912	2025-06-15 01:38:55
20241224161212	2025-06-15 01:38:57
20250107150512	2025-06-15 01:38:59
20250110162412	2025-06-15 01:39:01
20250123174212	2025-06-15 01:39:03
20250128220012	2025-06-15 01:39:05
20250506224012	2025-06-15 01:39:07
20250523164012	2025-06-15 01:39:09
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
amber-alert-photos	amber-alert-photos	\N	2025-06-15 03:14:54.660399+00	2025-06-15 03:14:54.660399+00	t	f	\N	\N	\N
cv-files	cv-files	\N	2025-06-15 03:53:02.340672+00	2025-06-15 03:53:02.340672+00	f	f	\N	\N	\N
before-after-videos	before-after-videos	\N	2025-06-15 14:42:10.134091+00	2025-06-15 14:42:10.134091+00	t	f	\N	\N	\N
community-messages	community-messages	\N	2025-07-06 15:54:42.496725+00	2025-07-06 15:54:42.496725+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-06-15 01:36:30.62798
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-06-15 01:36:30.635729
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-06-15 01:36:30.642609
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-06-15 01:36:30.666856
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-06-15 01:36:30.694773
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-06-15 01:36:30.701612
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-06-15 01:36:30.709077
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-06-15 01:36:30.716132
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-06-15 01:36:30.722877
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-06-15 01:36:30.729702
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-06-15 01:36:30.738833
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-06-15 01:36:30.745986
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-06-15 01:36:30.756115
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-06-15 01:36:30.763528
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-06-15 01:36:30.770494
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-06-15 01:36:30.805778
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-06-15 01:36:30.812757
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-06-15 01:36:30.82014
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-06-15 01:36:30.827815
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-06-15 01:36:30.835905
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-06-15 01:36:30.84289
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-06-15 01:36:30.855942
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-06-15 01:36:30.889092
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-06-15 01:36:30.921072
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-06-15 01:36:30.928865
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-06-15 01:36:30.936185
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
088ee173-2031-463e-b3a9-dacc7b7e14cf	before-after-videos	51d869f4-fa16-4633-9121-561817fce43d/1749998850738-b267a99f08734a44bcf956c5b305f461.MP4	51d869f4-fa16-4633-9121-561817fce43d	2025-06-15 14:47:49.085568+00	2025-06-15 14:47:49.085568+00	2025-06-15 14:47:49.085568+00	{"eTag": "\\"2d2f325dd724d4ec57ac9cd12dbe8418-9\\"", "size": 44914976, "mimetype": "video/mp4", "cacheControl": "max-age=3600", "lastModified": "2025-06-15T14:47:48.000Z", "contentLength": 44914976, "httpStatusCode": 200}	c4169c47-6209-486f-a384-f0822a01d6a3	51d869f4-fa16-4633-9121-561817fce43d	{}
a15a47f4-af53-4ee5-9f01-0612d4ad081b	amber-alert-photos	amber-photos/1751816391414.jpeg	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 15:39:52.103233+00	2025-07-06 15:39:52.103233+00	2025-07-06 15:39:52.103233+00	{"eTag": "\\"400ef49b1a13bbe30d4dc851b1fefaba\\"", "size": 188432, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-06T15:39:53.000Z", "contentLength": 188432, "httpStatusCode": 200}	290aba19-8609-44b3-82eb-2582e844bb4e	51d869f4-fa16-4633-9121-561817fce43d	{}
1f4c0369-1e64-4f7b-a63a-e948fdc8232c	community-messages	messages/1751818172038.png	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 16:09:33.424973+00	2025-07-06 16:09:33.424973+00	2025-07-06 16:09:33.424973+00	{"eTag": "\\"1f3da11a0160fce45e066e13197d6520\\"", "size": 1596936, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2025-07-06T16:09:34.000Z", "contentLength": 1596936, "httpStatusCode": 200}	63279979-b541-48c9-99a5-3389be1e8780	51d869f4-fa16-4633-9121-561817fce43d	{}
c9b67135-5382-4755-a889-d5f5a9fbf32d	amber-alert-photos	amber-photos/1751822310226.jpeg	51d869f4-fa16-4633-9121-561817fce43d	2025-07-06 17:18:31.439109+00	2025-07-06 17:18:31.439109+00	2025-07-06 17:18:31.439109+00	{"eTag": "\\"4744016d4f5054605a5c935074d3f4ed\\"", "size": 251533, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-07-06T17:18:32.000Z", "contentLength": 251533, "httpStatusCode": 200}	d06946d1-3ebe-424f-a256-b7803c22178e	51d869f4-fa16-4633-9121-561817fce43d	{}
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
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name, created_by, idempotency_key) FROM stdin;
20250615014850	{"\n-- Crear tabla de perfiles de usuarios\nCREATE TABLE public.profiles (\n  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,\n  full_name TEXT,\n  phone TEXT,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()\n);\n\n-- Crear enum para categorías de reportes\nCREATE TYPE public.report_category AS ENUM (\n  'basura',\n  'iluminacion', \n  'baches',\n  'seguridad',\n  'otros'\n);\n\n-- Crear enum para estado de reportes\nCREATE TYPE public.report_status AS ENUM (\n  'pendiente',\n  'en_proceso',\n  'resuelto',\n  'rechazado'\n);\n\n-- Crear tabla de reportes\nCREATE TABLE public.reports (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,\n  title TEXT NOT NULL,\n  description TEXT NOT NULL,\n  category report_category NOT NULL,\n  status report_status DEFAULT 'pendiente',\n  latitude DECIMAL(10, 8),\n  longitude DECIMAL(11, 8),\n  image_url TEXT,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()\n);\n\n-- Habilitar RLS en todas las tablas\nALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;\nALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;\n\n-- Políticas RLS para perfiles\nCREATE POLICY \\"Los usuarios pueden ver su propio perfil\\"\n  ON public.profiles FOR SELECT\n  USING (auth.uid() = id);\n\nCREATE POLICY \\"Los usuarios pueden actualizar su propio perfil\\"\n  ON public.profiles FOR UPDATE\n  USING (auth.uid() = id);\n\nCREATE POLICY \\"Los usuarios pueden insertar su propio perfil\\"\n  ON public.profiles FOR INSERT\n  WITH CHECK (auth.uid() = id);\n\n-- Políticas RLS para reportes\nCREATE POLICY \\"Los usuarios pueden ver todos los reportes\\"\n  ON public.reports FOR SELECT\n  TO authenticated\n  USING (true);\n\nCREATE POLICY \\"Los usuarios pueden crear sus propios reportes\\"\n  ON public.reports FOR INSERT\n  TO authenticated\n  WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Los usuarios pueden actualizar sus propios reportes\\"\n  ON public.reports FOR UPDATE\n  TO authenticated\n  USING (auth.uid() = user_id);\n\n-- Función para crear perfil automáticamente cuando se registra un usuario\nCREATE OR REPLACE FUNCTION public.handle_new_user()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nSECURITY DEFINER SET search_path = public\nAS $$\nBEGIN\n  INSERT INTO public.profiles (id, full_name)\n  VALUES (\n    NEW.id,\n    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email)\n  );\n  RETURN NEW;\nEND;\n$$;\n\n-- Trigger para crear perfil automáticamente\nCREATE TRIGGER on_auth_user_created\n  AFTER INSERT ON auth.users\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();\n"}	84f7b879-c9de-48a9-80e9-de99550493e3	armandonoel@outlook.com	\N
20250615021608	{"\n-- Agregar columnas separadas para nombres y apellidos\nALTER TABLE public.profiles \nADD COLUMN first_name TEXT,\nADD COLUMN last_name TEXT,\nADD COLUMN document_type TEXT CHECK (document_type IN ('cedula', 'pasaporte', 'tarjeta_identidad')),\nADD COLUMN document_number TEXT,\nADD COLUMN address TEXT,\nADD COLUMN neighborhood TEXT,\nADD COLUMN city TEXT DEFAULT 'Medellín',\nADD COLUMN birth_date DATE,\nADD COLUMN gender TEXT CHECK (gender IN ('masculino', 'femenino', 'otro', 'prefiero_no_decir'));\n\n-- Agregar campos adicionales a la tabla de reportes para mejor análisis\nALTER TABLE public.reports\nADD COLUMN address TEXT,\nADD COLUMN neighborhood TEXT,\nADD COLUMN priority TEXT CHECK (priority IN ('baja', 'media', 'alta', 'critica')) DEFAULT 'media',\nADD COLUMN resolved_at TIMESTAMP WITH TIME ZONE,\nADD COLUMN assigned_to UUID,\nADD COLUMN resolution_notes TEXT,\nADD COLUMN citizen_satisfaction INTEGER CHECK (citizen_satisfaction >= 1 AND citizen_satisfaction <= 5);\n\n-- Actualizar la función para manejar nombres separados\nCREATE OR REPLACE FUNCTION public.handle_new_user()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nSECURITY DEFINER SET search_path = public\nAS $$\nBEGIN\n  INSERT INTO public.profiles (id, full_name, first_name, last_name)\n  VALUES (\n    NEW.id,\n    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),\n    NEW.raw_user_meta_data->>'first_name',\n    NEW.raw_user_meta_data->>'last_name'\n  );\n  RETURN NEW;\nEND;\n$$;\n\n-- Crear índices para mejorar rendimiento en consultas de reportes\nCREATE INDEX IF NOT EXISTS idx_reports_category ON public.reports(category);\nCREATE INDEX IF NOT EXISTS idx_reports_status ON public.reports(status);\nCREATE INDEX IF NOT EXISTS idx_reports_created_at ON public.reports(created_at);\nCREATE INDEX IF NOT EXISTS idx_reports_neighborhood ON public.reports(neighborhood);\nCREATE INDEX IF NOT EXISTS idx_reports_priority ON public.reports(priority);\nCREATE INDEX IF NOT EXISTS idx_profiles_neighborhood ON public.profiles(neighborhood);\n"}	21248a8c-fed3-47f9-9f22-39253e026feb	armandonoel@outlook.com	\N
20250615023544	{"\n-- Actualizar el perfil del usuario con los nombres y apellidos separados\n-- Asumiendo que el usuario actual es el que necesita la actualización\nUPDATE public.profiles \nSET \n  first_name = 'Armando',\n  last_name = 'Noel Charle'\nWHERE full_name IS NOT NULL \n  AND first_name IS NULL \n  AND last_name IS NULL\n  AND full_name LIKE '%Armando%';\n\n-- Si no funciona el query anterior, podemos usar este más específico\n-- (ejecutar solo si el anterior no actualiza ningún registro)\nUPDATE public.profiles \nSET \n  first_name = 'Armando',\n  last_name = 'Noel Charle'\nWHERE id IN (\n  SELECT id \n  FROM profiles \n  WHERE first_name IS NULL \n  ORDER BY created_at DESC \n  LIMIT 1\n);\n"}	f60b964c-72a4-4f14-9982-693361dccd3a	armandonoel@outlook.com	\N
20250615025455	{"\n-- Crear tabla para facturas de basura\nCREATE TABLE public.garbage_bills (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  bill_number TEXT NOT NULL UNIQUE,\n  billing_period_start DATE NOT NULL,\n  billing_period_end DATE NOT NULL,\n  amount_due INTEGER NOT NULL, -- En centavos para evitar problemas de precisión\n  due_date DATE NOT NULL,\n  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue', 'cancelled')),\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Crear tabla para pagos de basura\nCREATE TABLE public.garbage_payments (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  bill_id UUID REFERENCES public.garbage_bills(id) NOT NULL,\n  stripe_session_id TEXT UNIQUE,\n  amount_paid INTEGER NOT NULL, -- En centavos\n  payment_method TEXT DEFAULT 'stripe',\n  payment_status TEXT NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),\n  payment_date TIMESTAMP WITH TIME ZONE,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Habilitar Row Level Security\nALTER TABLE public.garbage_bills ENABLE ROW LEVEL SECURITY;\nALTER TABLE public.garbage_payments ENABLE ROW LEVEL SECURITY;\n\n-- Políticas para facturas - usuarios solo pueden ver sus propias facturas\nCREATE POLICY \\"Users can view their own bills\\" \n  ON public.garbage_bills \n  FOR SELECT \n  USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Service can insert bills\\" \n  ON public.garbage_bills \n  FOR INSERT \n  WITH CHECK (true);\n\nCREATE POLICY \\"Service can update bills\\" \n  ON public.garbage_bills \n  FOR UPDATE \n  USING (true);\n\n-- Políticas para pagos - usuarios solo pueden ver sus propios pagos\nCREATE POLICY \\"Users can view their own payments\\" \n  ON public.garbage_payments \n  FOR SELECT \n  USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create their own payments\\" \n  ON public.garbage_payments \n  FOR INSERT \n  WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Service can update payments\\" \n  ON public.garbage_payments \n  FOR UPDATE \n  USING (true);\n\n-- Función para generar número de factura automático\nCREATE OR REPLACE FUNCTION generate_bill_number()\nRETURNS TEXT AS $$\nDECLARE\n  current_year TEXT;\n  sequence_num TEXT;\nBEGIN\n  current_year := EXTRACT(YEAR FROM NOW())::TEXT;\n  sequence_num := LPAD((SELECT COALESCE(MAX(CAST(SUBSTRING(bill_number FROM 6) AS INTEGER)), 0) + 1 \n                       FROM garbage_bills \n                       WHERE bill_number LIKE current_year || '-%'), 6, '0');\n  RETURN current_year || '-' || sequence_num;\nEND;\n$$ LANGUAGE plpgsql;\n\n-- Trigger para auto-generar número de factura\nCREATE OR REPLACE FUNCTION set_bill_number()\nRETURNS TRIGGER AS $$\nBEGIN\n  IF NEW.bill_number IS NULL OR NEW.bill_number = '' THEN\n    NEW.bill_number := generate_bill_number();\n  END IF;\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\nCREATE TRIGGER trigger_set_bill_number\n  BEFORE INSERT ON public.garbage_bills\n  FOR EACH ROW\n  EXECUTE FUNCTION set_bill_number();\n\n-- Función para generar facturas automáticamente (simulación)\nCREATE OR REPLACE FUNCTION generate_monthly_bills()\nRETURNS INTEGER AS $$\nDECLARE\n  user_record RECORD;\n  bills_generated INTEGER := 0;\n  current_month_start DATE;\n  current_month_end DATE;\n  due_date DATE;\n  base_amount INTEGER := 150000; -- $1,500 pesos en centavos\nBEGIN\n  -- Calcular fechas del mes actual\n  current_month_start := DATE_TRUNC('month', CURRENT_DATE);\n  current_month_end := (DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month - 1 day')::DATE;\n  due_date := current_month_end + INTERVAL '15 days';\n  \n  -- Generar facturas para usuarios que no tienen factura del mes actual\n  FOR user_record IN \n    SELECT DISTINCT p.id \n    FROM profiles p\n    WHERE p.first_name IS NOT NULL \n    AND p.last_name IS NOT NULL\n    AND NOT EXISTS (\n      SELECT 1 FROM garbage_bills gb \n      WHERE gb.user_id = p.id \n      AND gb.billing_period_start = current_month_start\n    )\n  LOOP\n    INSERT INTO garbage_bills (\n      user_id,\n      billing_period_start,\n      billing_period_end,\n      amount_due,\n      due_date,\n      status\n    ) VALUES (\n      user_record.id,\n      current_month_start,\n      current_month_end,\n      base_amount + (RANDOM() * 50000)::INTEGER, -- Variación de ±$500\n      due_date,\n      'pending'\n    );\n    \n    bills_generated := bills_generated + 1;\n  END LOOP;\n  \n  RETURN bills_generated;\nEND;\n$$ LANGUAGE plpgsql;\n"}	8a80c760-eed4-4d34-b7d7-677ac7e87ae8	armandonoel@outlook.com	\N
20250615030345	{"\n-- Crear tabla para las alertas de pánico\nCREATE TABLE public.panic_alerts (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,\n  user_full_name TEXT NOT NULL,\n  latitude DECIMAL(10, 8),\n  longitude DECIMAL(11, 8),\n  location_description TEXT,\n  is_active BOOLEAN DEFAULT true,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n  resolved_at TIMESTAMP WITH TIME ZONE,\n  resolved_by UUID REFERENCES auth.users(id)\n);\n\n-- Habilitar RLS\nALTER TABLE public.panic_alerts ENABLE ROW LEVEL SECURITY;\n\n-- Política para que todos los usuarios autenticados puedan ver las alertas activas\nCREATE POLICY \\"Usuarios pueden ver alertas activas de pánico\\"\n  ON public.panic_alerts FOR SELECT\n  TO authenticated\n  USING (is_active = true);\n\n-- Política para que los usuarios puedan crear sus propias alertas\nCREATE POLICY \\"Usuarios pueden crear alertas de pánico\\"\n  ON public.panic_alerts FOR INSERT\n  TO authenticated\n  WITH CHECK (auth.uid() = user_id);\n\n-- Política para que los usuarios puedan resolver alertas (marcarlas como no activas)\nCREATE POLICY \\"Usuarios pueden resolver alertas de pánico\\"\n  ON public.panic_alerts FOR UPDATE\n  TO authenticated\n  USING (true)\n  WITH CHECK (true);\n\n-- Habilitar realtime para esta tabla\nALTER TABLE public.panic_alerts REPLICA IDENTITY FULL;\nALTER PUBLICATION supabase_realtime ADD TABLE public.panic_alerts;\n"}	0c734d9b-7e27-40b3-9b84-c84deccaab7c	armandonoel@outlook.com	\N
20250615031454	{"\n-- Crear tabla para las alertas Amber\nCREATE TABLE public.amber_alerts (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,\n  child_full_name TEXT NOT NULL,\n  child_nickname TEXT,\n  child_photo_url TEXT,\n  last_seen_location TEXT NOT NULL,\n  disappearance_time TIMESTAMP WITH TIME ZONE NOT NULL,\n  medical_conditions TEXT,\n  contact_number TEXT NOT NULL,\n  additional_details TEXT,\n  is_active BOOLEAN DEFAULT true,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n  resolved_at TIMESTAMP WITH TIME ZONE,\n  resolved_by UUID REFERENCES auth.users(id)\n);\n\n-- Habilitar RLS\nALTER TABLE public.amber_alerts ENABLE ROW LEVEL SECURITY;\n\n-- Política para que todos los usuarios autenticados puedan ver las alertas activas\nCREATE POLICY \\"Usuarios pueden ver alertas Amber activas\\"\n  ON public.amber_alerts FOR SELECT\n  TO authenticated\n  USING (is_active = true);\n\n-- Política para que los usuarios puedan crear alertas Amber\nCREATE POLICY \\"Usuarios pueden crear alertas Amber\\"\n  ON public.amber_alerts FOR INSERT\n  TO authenticated\n  WITH CHECK (auth.uid() = user_id);\n\n-- Política para que los usuarios puedan resolver alertas Amber\nCREATE POLICY \\"Usuarios pueden resolver alertas Amber\\"\n  ON public.amber_alerts FOR UPDATE\n  TO authenticated\n  USING (true)\n  WITH CHECK (true);\n\n-- Habilitar realtime para esta tabla\nALTER TABLE public.amber_alerts REPLICA IDENTITY FULL;\nALTER PUBLICATION supabase_realtime ADD TABLE public.amber_alerts;\n\n-- Crear bucket para fotos de niños desaparecidos\nINSERT INTO storage.buckets (id, name, public)\nVALUES ('amber-alert-photos', 'amber-alert-photos', true);\n\n-- Políticas para el bucket de fotos\nCREATE POLICY \\"Usuarios pueden subir fotos para alertas Amber\\"\nON storage.objects FOR INSERT\nTO authenticated\nWITH CHECK (bucket_id = 'amber-alert-photos');\n\nCREATE POLICY \\"Usuarios pueden ver fotos de alertas Amber\\"\nON storage.objects FOR SELECT\nTO authenticated\nUSING (bucket_id = 'amber-alert-photos');\n"}	b1fa758d-f7c5-46e7-a127-7779c6d01458	armandonoel@outlook.com	\N
20250615035302	{"\n-- Create a table for job applications\nCREATE TABLE public.job_applications (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  \n  -- Personal Information\n  full_name TEXT NOT NULL,\n  email TEXT NOT NULL,\n  phone TEXT NOT NULL,\n  address TEXT,\n  birth_date DATE,\n  document_type TEXT,\n  document_number TEXT,\n  \n  -- Academic Information\n  education_level TEXT NOT NULL,\n  institution_name TEXT,\n  career_field TEXT,\n  graduation_year INTEGER,\n  additional_courses TEXT,\n  \n  -- Professional Information\n  work_experience TEXT,\n  skills TEXT,\n  availability TEXT,\n  expected_salary TEXT,\n  \n  -- CV Upload\n  cv_file_url TEXT,\n  cv_file_name TEXT,\n  \n  -- Application Status\n  status TEXT NOT NULL DEFAULT 'pending',\n  notes TEXT,\n  \n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Add Row Level Security (RLS)\nALTER TABLE public.job_applications ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for job applications\nCREATE POLICY \\"Users can view their own applications\\" \n  ON public.job_applications \n  FOR SELECT \n  USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create their own applications\\" \n  ON public.job_applications \n  FOR INSERT \n  WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update their own applications\\" \n  ON public.job_applications \n  FOR UPDATE \n  USING (auth.uid() = user_id);\n\n-- Create storage bucket for CV files\nINSERT INTO storage.buckets (id, name, public)\nVALUES ('cv-files', 'cv-files', false);\n\n-- Create storage policies for CV files\nCREATE POLICY \\"Users can upload their own CV files\\"\n  ON storage.objects FOR INSERT\n  WITH CHECK (\n    bucket_id = 'cv-files' AND\n    auth.uid()::text = (storage.foldername(name))[1]\n  );\n\nCREATE POLICY \\"Users can view their own CV files\\"\n  ON storage.objects FOR SELECT\n  USING (\n    bucket_id = 'cv-files' AND\n    auth.uid()::text = (storage.foldername(name))[1]\n  );\n\nCREATE POLICY \\"Users can update their own CV files\\"\n  ON storage.objects FOR UPDATE\n  USING (\n    bucket_id = 'cv-files' AND\n    auth.uid()::text = (storage.foldername(name))[1]\n  );\n\nCREATE POLICY \\"Users can delete their own CV files\\"\n  ON storage.objects FOR DELETE\n  USING (\n    bucket_id = 'cv-files' AND\n    auth.uid()::text = (storage.foldername(name))[1]\n  );\n"}	5a18c729-534c-4ee9-a97a-4226fde06878	armandonoel@outlook.com	\N
20250615044134	{"\n-- Eliminar la política restrictiva actual\nDROP POLICY IF EXISTS \\"Usuarios pueden resolver alertas de pánico\\" ON public.panic_alerts;\n\n-- Crear nueva política que permite a cualquier usuario autenticado resolver alertas activas\nCREATE POLICY \\"Cualquier usuario puede resolver alertas de pánico activas\\"\n  ON public.panic_alerts FOR UPDATE\n  TO authenticated\n  USING (is_active = true)\n  WITH CHECK (true);\n"}	10161cec-6346-4880-b5dc-7066f15f72fb	armandonoel@outlook.com	\N
20250615045807	{"\n-- Eliminar la política existente que está causando problemas\nDROP POLICY IF EXISTS \\"Cualquier usuario puede resolver alertas de pánico activas\\" ON public.panic_alerts;\n\n-- Crear una nueva política más permisiva para resolver alertas\nCREATE POLICY \\"Permitir resolver alertas activas\\"\n  ON public.panic_alerts FOR UPDATE\n  TO authenticated\n  USING (is_active = true)\n  WITH CHECK (\n    -- Permite marcar como inactiva (resolved) cualquier alerta activa\n    is_active = false OR \n    -- O permite actualizar otros campos si sigue activa\n    is_active = true\n  );\n"}	74bc47f9-bd84-4d8e-9cb6-3a52cbe64192	armandonoel@outlook.com	\N
20250615050616	{"\n-- Eliminar todas las políticas existentes para panic_alerts\nDROP POLICY IF EXISTS \\"Permitir resolver alertas activas\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Cualquier usuario puede resolver alertas de pánico activas\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Usuarios pueden resolver alertas de pánico\\" ON public.panic_alerts;\n\n-- Crear una política completamente permisiva para UPDATE\nCREATE POLICY \\"Usuarios autenticados pueden actualizar alertas\\"\n  ON public.panic_alerts FOR UPDATE\n  TO authenticated\n  USING (true)\n  WITH CHECK (true);\n"}	bc27e2c1-6664-4ba7-b99d-4a48de43e20c	armandonoel@outlook.com	\N
20250615052716	{"\n-- Eliminar todas las políticas RLS de la tabla panic_alerts\nDROP POLICY IF EXISTS \\"Usuarios pueden ver alertas activas de pánico\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Usuarios pueden crear alertas de pánico\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Usuarios pueden resolver alertas de pánico\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Permitir resolver alertas activas\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Cualquier usuario puede resolver alertas de pánico activas\\" ON public.panic_alerts;\nDROP POLICY IF EXISTS \\"Usuarios autenticados pueden actualizar alertas\\" ON public.panic_alerts;\n\n-- Remover la tabla de la publicación de realtime (sin IF EXISTS)\nALTER PUBLICATION supabase_realtime DROP TABLE public.panic_alerts;\n\n-- Eliminar la tabla de panic_alerts\nDROP TABLE IF EXISTS public.panic_alerts;\n"}	5f453a30-797a-4a9a-80e0-d5d5441d2d5b	armandonoel@outlook.com	\N
20250615024210	{"\n-- Crear bucket para videos de antes y después\nINSERT INTO storage.buckets (id, name, public)\nVALUES ('before-after-videos', 'before-after-videos', true);\n\n-- Crear políticas para el bucket de videos\nCREATE POLICY \\"Allow public access to before-after videos\\"\nON storage.objects FOR SELECT\nUSING (bucket_id = 'before-after-videos');\n\nCREATE POLICY \\"Allow authenticated users to upload before-after videos\\"\nON storage.objects FOR INSERT\nWITH CHECK (bucket_id = 'before-after-videos' AND auth.role() = 'authenticated');\n\nCREATE POLICY \\"Allow users to update their own before-after videos\\"\nON storage.objects FOR UPDATE\nUSING (bucket_id = 'before-after-videos' AND auth.uid()::text = (storage.foldername(name))[1]);\n\nCREATE POLICY \\"Allow users to delete their own before-after videos\\"\nON storage.objects FOR DELETE\nUSING (bucket_id = 'before-after-videos' AND auth.uid()::text = (storage.foldername(name))[1]);\n\n-- Crear tabla para almacenar información de los videos\nCREATE TABLE public.before_after_videos (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  title TEXT NOT NULL,\n  description TEXT,\n  video_url TEXT NOT NULL,\n  file_name TEXT NOT NULL,\n  file_size INTEGER,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Habilitar RLS en la tabla\nALTER TABLE public.before_after_videos ENABLE ROW LEVEL SECURITY;\n\n-- Crear políticas RLS\nCREATE POLICY \\"Users can view all before-after videos\\"\n  ON public.before_after_videos\n  FOR SELECT\n  USING (true);\n\nCREATE POLICY \\"Users can create their own before-after videos\\"\n  ON public.before_after_videos\n  FOR INSERT\n  WITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update their own before-after videos\\"\n  ON public.before_after_videos\n  FOR UPDATE\n  USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete their own before-after videos\\"\n  ON public.before_after_videos\n  FOR DELETE\n  USING (auth.uid() = user_id);\n"}	d19e5c1c-b165-4ebf-8e94-ed380a69d9ec	armandonoel@outlook.com	\N
20250615034226	{"\n-- Crear tabla para alertas de pánico\nCREATE TABLE public.panic_alerts (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID NOT NULL,\n  user_full_name TEXT NOT NULL,\n  latitude NUMERIC,\n  longitude NUMERIC,\n  address TEXT,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  expires_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() + INTERVAL '1 minute'),\n  is_active BOOLEAN NOT NULL DEFAULT true\n);\n\n-- Habilitar Row Level Security\nALTER TABLE public.panic_alerts ENABLE ROW LEVEL SECURITY;\n\n-- Política para que todos los usuarios autenticados puedan ver las alertas activas\nCREATE POLICY \\"All authenticated users can view active alerts\\" \n  ON public.panic_alerts \n  FOR SELECT \n  TO authenticated\n  USING (true);\n\n-- Política para que los usuarios puedan crear sus propias alertas\nCREATE POLICY \\"Users can create their own alerts\\" \n  ON public.panic_alerts \n  FOR INSERT \n  TO authenticated\n  WITH CHECK (auth.uid() = user_id);\n\n-- Habilitar realtime para actualizaciones en tiempo real\nALTER TABLE public.panic_alerts REPLICA IDENTITY FULL;\nALTER PUBLICATION supabase_realtime ADD TABLE public.panic_alerts;\n\n-- Función para desactivar alertas expiradas automáticamente\nCREATE OR REPLACE FUNCTION public.deactivate_expired_panic_alerts()\nRETURNS void\nLANGUAGE plpgsql\nAS $$\nBEGIN\n  UPDATE public.panic_alerts \n  SET is_active = false \n  WHERE is_active = true \n  AND expires_at < now();\nEND;\n$$;\n"}	32a681cb-9773-4b0c-9860-ec1ab0381bc8	armandonoel@outlook.com	\N
20250615041729	{"\n-- Create a table for help messages\nCREATE TABLE public.help_messages (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  subject TEXT NOT NULL,\n  message TEXT NOT NULL,\n  status TEXT NOT NULL DEFAULT 'pending',\n  priority TEXT NOT NULL DEFAULT 'normal',\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  resolved_at TIMESTAMP WITH TIME ZONE,\n  admin_response TEXT,\n  user_email TEXT NOT NULL,\n  user_full_name TEXT NOT NULL\n);\n\n-- Add Row Level Security (RLS)\nALTER TABLE public.help_messages ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for help messages\nCREATE POLICY \\"Users can view their own help messages\\" \n  ON public.help_messages \n  FOR SELECT \n  USING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can create help messages\\" \n  ON public.help_messages \n  FOR INSERT \n  WITH CHECK (auth.uid() = user_id);\n\n-- Create index for better performance\nCREATE INDEX idx_help_messages_user_id ON public.help_messages(user_id);\nCREATE INDEX idx_help_messages_status ON public.help_messages(status);\nCREATE INDEX idx_help_messages_created_at ON public.help_messages(created_at DESC);\n"}	e2c6a2aa-81ab-4854-a57d-1a2dc184d66e	armandonoel@outlook.com	\N
20250615050622	{"\n-- Crear el enum para los roles de la aplicación\nCREATE TYPE public.app_role AS ENUM ('admin', 'community_leader', 'community_user');\n\n-- Crear la tabla para asignar roles a los usuarios\nCREATE TABLE public.user_roles (\n    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,\n    role app_role NOT NULL,\n    assigned_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,\n    assigned_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n    is_active BOOLEAN NOT NULL DEFAULT true,\n    UNIQUE (user_id, role)\n);\n\n-- Habilitar Row Level Security\nALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;\n\n-- Crear función de seguridad para verificar roles sin recursividad\nCREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)\nRETURNS BOOLEAN\nLANGUAGE SQL\nSTABLE\nSECURITY DEFINER\nAS $$\n  SELECT EXISTS (\n    SELECT 1\n    FROM public.user_roles\n    WHERE user_id = _user_id\n      AND role = _role\n      AND is_active = true\n  )\n$$;\n\n-- Crear función para verificar si un usuario es admin\nCREATE OR REPLACE FUNCTION public.is_admin(_user_id UUID)\nRETURNS BOOLEAN\nLANGUAGE SQL\nSTABLE\nSECURITY DEFINER\nAS $$\n  SELECT public.has_role(_user_id, 'admin')\n$$;\n\n-- Políticas RLS para user_roles\n-- Los admins pueden ver todos los roles\nCREATE POLICY \\"Admins can view all user roles\\"\nON public.user_roles\nFOR SELECT\nTO authenticated\nUSING (public.is_admin(auth.uid()));\n\n-- Los usuarios pueden ver sus propios roles\nCREATE POLICY \\"Users can view their own roles\\"\nON public.user_roles\nFOR SELECT\nTO authenticated\nUSING (user_id = auth.uid());\n\n-- Solo los admins pueden insertar/actualizar roles\nCREATE POLICY \\"Only admins can manage user roles\\"\nON public.user_roles\nFOR ALL\nTO authenticated\nUSING (public.is_admin(auth.uid()))\nWITH CHECK (public.is_admin(auth.uid()));\n\n-- Asignar rol de admin al primer usuario (opcional - para facilitar desarrollo)\n-- Este INSERT se ejecutará solo si no hay usuarios con rol admin\nINSERT INTO public.user_roles (user_id, role, assigned_by)\nSELECT \n    (SELECT id FROM auth.users ORDER BY created_at LIMIT 1),\n    'admin'::app_role,\n    (SELECT id FROM auth.users ORDER BY created_at LIMIT 1)\nWHERE NOT EXISTS (\n    SELECT 1 FROM public.user_roles WHERE role = 'admin'::app_role AND is_active = true\n);\n"}	554c4d89-31fe-40dc-a87e-06e80ece1c0f	armandonoel@outlook.com	\N
20250615051630	{"\n-- Crear tabla para almacenar reportes generados\nCREATE TABLE public.generated_reports (\n    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n    title VARCHAR(255) NOT NULL,\n    description TEXT,\n    report_type VARCHAR(50) NOT NULL, -- 'monthly', 'weekly', 'custom', 'incident_summary'\n    generated_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,\n    date_range_start DATE,\n    date_range_end DATE,\n    filters JSONB, -- Para almacenar filtros aplicados (categorías, barrios, etc.)\n    google_sheets_url TEXT, -- URL del sheet de Google generado\n    google_chart_url TEXT, -- URL del gráfico de Google generado\n    pdf_url TEXT, -- URL del PDF generado\n    status VARCHAR(20) DEFAULT 'generating', -- 'generating', 'completed', 'failed'\n    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()\n);\n\n-- Crear tabla para configuraciones de reportes automáticos\nCREATE TABLE public.report_schedules (\n    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n    name VARCHAR(255) NOT NULL,\n    report_type VARCHAR(50) NOT NULL,\n    frequency VARCHAR(20) NOT NULL, -- 'daily', 'weekly', 'monthly'\n    filters JSONB,\n    created_by UUID REFERENCES auth.users(id) ON DELETE CASCADE,\n    is_active BOOLEAN DEFAULT true,\n    last_generated_at TIMESTAMP WITH TIME ZONE,\n    next_generation_at TIMESTAMP WITH TIME ZONE,\n    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),\n    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()\n);\n\n-- Crear tabla para métricas y estadísticas\nCREATE TABLE public.report_metrics (\n    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n    report_id UUID REFERENCES public.generated_reports(id) ON DELETE CASCADE,\n    metric_name VARCHAR(100) NOT NULL,\n    metric_value NUMERIC,\n    metric_type VARCHAR(50), -- 'count', 'percentage', 'average', 'total'\n    category VARCHAR(100), -- Para agrupar métricas\n    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()\n);\n\n-- Habilitar RLS en las nuevas tablas\nALTER TABLE public.generated_reports ENABLE ROW LEVEL SECURITY;\nALTER TABLE public.report_schedules ENABLE ROW LEVEL SECURITY;\nALTER TABLE public.report_metrics ENABLE ROW LEVEL SECURITY;\n\n-- Políticas RLS para generated_reports\n-- Admins pueden ver todos los reportes\nCREATE POLICY \\"Admins can view all generated reports\\"\nON public.generated_reports\nFOR SELECT\nTO authenticated\nUSING (public.is_admin(auth.uid()));\n\n-- Líderes comunitarios pueden ver reportes que ellos generaron\nCREATE POLICY \\"Community leaders can view their reports\\"\nON public.generated_reports\nFOR SELECT\nTO authenticated\nUSING (generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'));\n\n-- Solo admins y líderes comunitarios pueden crear reportes\nCREATE POLICY \\"Admins and leaders can create reports\\"\nON public.generated_reports\nFOR INSERT\nTO authenticated\nWITH CHECK (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Solo admins y líderes comunitarios pueden actualizar reportes\nCREATE POLICY \\"Admins and leaders can update reports\\"\nON public.generated_reports\nFOR UPDATE\nTO authenticated\nUSING (\n    public.is_admin(auth.uid()) OR \n    (generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))\n);\n\n-- Políticas RLS para report_schedules\nCREATE POLICY \\"Admins can manage all schedules\\"\nON public.report_schedules\nFOR ALL\nTO authenticated\nUSING (public.is_admin(auth.uid()))\nWITH CHECK (public.is_admin(auth.uid()));\n\nCREATE POLICY \\"Leaders can manage their schedules\\"\nON public.report_schedules\nFOR ALL\nTO authenticated\nUSING (created_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))\nWITH CHECK (created_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'));\n\n-- Políticas RLS para report_metrics\nCREATE POLICY \\"Users can view metrics of accessible reports\\"\nON public.report_metrics\nFOR SELECT\nTO authenticated\nUSING (\n    EXISTS (\n        SELECT 1 FROM public.generated_reports gr\n        WHERE gr.id = report_metrics.report_id\n        AND (\n            public.is_admin(auth.uid()) OR\n            (gr.generated_by = auth.uid() AND public.has_role(auth.uid(), 'community_leader'))\n        )\n    )\n);\n\nCREATE POLICY \\"Admins and leaders can create metrics\\"\nON public.report_metrics\nFOR INSERT\nTO authenticated\nWITH CHECK (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Crear función para generar reportes automáticos\nCREATE OR REPLACE FUNCTION public.generate_scheduled_reports()\nRETURNS INTEGER\nLANGUAGE plpgsql\nAS $$\nDECLARE\n    schedule_record RECORD;\n    reports_generated INTEGER := 0;\nBEGIN\n    -- Buscar reportes programados que necesitan ser generados\n    FOR schedule_record IN \n        SELECT * FROM public.report_schedules\n        WHERE is_active = true \n        AND (next_generation_at IS NULL OR next_generation_at <= now())\n    LOOP\n        -- Crear un nuevo reporte basado en la programación\n        INSERT INTO public.generated_reports (\n            title,\n            description,\n            report_type,\n            generated_by,\n            date_range_start,\n            date_range_end,\n            filters,\n            status\n        ) VALUES (\n            schedule_record.name || ' - ' || to_char(now(), 'DD/MM/YYYY'),\n            'Reporte generado automáticamente',\n            schedule_record.report_type,\n            schedule_record.created_by,\n            CASE \n                WHEN schedule_record.frequency = 'daily' THEN current_date - interval '1 day'\n                WHEN schedule_record.frequency = 'weekly' THEN current_date - interval '1 week'\n                WHEN schedule_record.frequency = 'monthly' THEN current_date - interval '1 month'\n            END,\n            current_date,\n            schedule_record.filters,\n            'generating'\n        );\n        \n        -- Actualizar las fechas de la programación\n        UPDATE public.report_schedules\n        SET \n            last_generated_at = now(),\n            next_generation_at = CASE \n                WHEN frequency = 'daily' THEN now() + interval '1 day'\n                WHEN frequency = 'weekly' THEN now() + interval '1 week'\n                WHEN frequency = 'monthly' THEN now() + interval '1 month'\n            END,\n            updated_at = now()\n        WHERE id = schedule_record.id;\n        \n        reports_generated := reports_generated + 1;\n    END LOOP;\n    \n    RETURN reports_generated;\nEND;\n$$;\n"}	8eda8274-8c0e-4533-b584-3d197c01350f	armandonoel@outlook.com	\N
20250615053238	{"\n-- Eliminar políticas existentes si existen\nDROP POLICY IF EXISTS \\"Admins can view all generated reports\\" ON public.generated_reports;\nDROP POLICY IF EXISTS \\"Community leaders can view their reports\\" ON public.generated_reports;\nDROP POLICY IF EXISTS \\"Admins and leaders can create reports\\" ON public.generated_reports;\nDROP POLICY IF EXISTS \\"Admins and leaders can update reports\\" ON public.generated_reports;\nDROP POLICY IF EXISTS \\"Users can view metrics of accessible reports\\" ON public.report_metrics;\nDROP POLICY IF EXISTS \\"Admins and leaders can create metrics\\" ON public.report_metrics;\n\n-- Crear políticas RLS mejoradas para generated_reports\n-- Los administradores pueden ver todos los reportes\nCREATE POLICY \\"Admins can view all generated reports\\"\nON public.generated_reports\nFOR SELECT\nTO authenticated\nUSING (public.is_admin(auth.uid()));\n\n-- Los líderes comunitarios pueden ver todos los reportes (no solo los suyos)\nCREATE POLICY \\"Community leaders can view all reports\\"\nON public.generated_reports\nFOR SELECT\nTO authenticated\nUSING (public.has_role(auth.uid(), 'community_leader'));\n\n-- Solo admins y líderes comunitarios pueden crear reportes\nCREATE POLICY \\"Admins and leaders can create reports\\"\nON public.generated_reports\nFOR INSERT\nTO authenticated\nWITH CHECK (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Solo admins y líderes comunitarios pueden actualizar reportes\nCREATE POLICY \\"Admins and leaders can update reports\\"\nON public.generated_reports\nFOR UPDATE\nTO authenticated\nUSING (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Solo admins y líderes comunitarios pueden eliminar reportes\nCREATE POLICY \\"Admins and leaders can delete reports\\"\nON public.generated_reports\nFOR DELETE\nTO authenticated\nUSING (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Actualizar políticas para report_metrics\nCREATE POLICY \\"Users can view metrics of accessible reports\\"\nON public.report_metrics\nFOR SELECT\nTO authenticated\nUSING (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\nCREATE POLICY \\"Admins and leaders can create metrics\\"\nON public.report_metrics\nFOR INSERT\nTO authenticated\nWITH CHECK (\n    public.is_admin(auth.uid()) OR \n    public.has_role(auth.uid(), 'community_leader')\n);\n\n-- Insertar algunos reportes de prueba para verificar que funciona\nINSERT INTO public.generated_reports (\n    title,\n    description,\n    report_type,\n    generated_by,\n    date_range_start,\n    date_range_end,\n    status,\n    google_sheets_url,\n    google_chart_url\n) VALUES \n(\n    'Reporte Mensual de Incidencias - Enero 2025',\n    'Resumen de todas las incidencias reportadas durante enero 2025',\n    'monthly',\n    auth.uid(),\n    '2025-01-01',\n    '2025-01-31',\n    'completed',\n    'https://docs.google.com/spreadsheets/d/example1',\n    'https://docs.google.com/presentation/d/example1'\n),\n(\n    'Reporte Semanal de Limpieza - Semana 3',\n    'Análisis de servicios de limpieza y recolección de basura',\n    'weekly',\n    auth.uid(),\n    '2025-01-15',\n    '2025-01-21',\n    'completed',\n    'https://docs.google.com/spreadsheets/d/example2',\n    'https://docs.google.com/presentation/d/example2'\n),\n(\n    'Reporte en Proceso',\n    'Este reporte está siendo generado actualmente',\n    'custom',\n    auth.uid(),\n    '2025-01-01',\n    '2025-01-15',\n    'generating',\n    null,\n    null\n);\n"}	df44397e-7226-41d2-87f1-9b8ba6e9e3fe	armandonoel@outlook.com	\N
20250615053903	{"\n-- Actualizar los reportes de prueba para remover las URLs de ejemplo y dejarlas como null\nUPDATE public.generated_reports \nSET \n  google_sheets_url = NULL,\n  google_chart_url = NULL,\n  pdf_url = NULL\nWHERE \n  google_sheets_url LIKE '%example%' OR \n  google_chart_url LIKE '%example%' OR\n  pdf_url LIKE '%example%';\n"}	9f0812b2-1c71-43f2-a4d3-47b3f0cc14e8	armandonoel@outlook.com	\N
20250615054326	{"\n-- Insertar reportes de prueba con URLs reales para demostrar la funcionalidad\nINSERT INTO public.generated_reports (\n    title,\n    description,\n    report_type,\n    generated_by,\n    date_range_start,\n    date_range_end,\n    status,\n    google_sheets_url,\n    google_chart_url,\n    pdf_url\n) VALUES \n(\n    'Reporte de Prueba con Enlaces Funcionales',\n    'Este reporte tiene enlaces reales para probar la funcionalidad',\n    'monthly',\n    (SELECT id FROM auth.users LIMIT 1),\n    '2025-01-01',\n    '2025-01-31',\n    'completed',\n    'https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit',\n    'https://docs.google.com/presentation/d/1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXhPSx4XY9xEpJM/edit',\n    'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'\n),\n(\n    'Reporte Semanal - Datos Actualizados',\n    'Reporte con métricas de la semana pasada',\n    'weekly',\n    (SELECT id FROM auth.users LIMIT 1),\n    '2025-06-08',\n    '2025-06-14',\n    'completed',\n    'https://docs.google.com/spreadsheets/d/1mHIWnDvW9cALRMq9OdNfzOxGtb0zDQtJgDr8f5F6H7G/edit',\n    'https://docs.google.com/presentation/d/1FBZl29XEjKH-aq_1xMn4DtgRj_k9fYiQTx5YZ0yFrKN/edit',\n    'https://www.orimi.com/pdf-test.pdf'\n),\n(\n    'Análisis de Incidencias - Q2 2025',\n    'Resumen trimestral de todas las incidencias reportadas',\n    'incident_summary',\n    (SELECT id FROM auth.users LIMIT 1),\n    '2025-04-01',\n    '2025-06-30',\n    'completed',\n    'https://docs.google.com/spreadsheets/d/1nJKLaRSTuVwXyZ2aB3cDeF4gH5iJ6kL7mN8oP9qR0sT/edit',\n    'https://docs.google.com/presentation/d/1GCam30YFkLI-br_2yNo5EuhSk_l0gZjRUy6Za1zGsLO/edit',\n    'https://www.clickdimensions.com/links/TestPDFfile.pdf'\n);\n"}	2ec2e1a6-e02d-4377-a379-4e593d570501	armandonoel@outlook.com	\N
20250615070531	{"\n-- Enable RLS on amber_alerts table\nALTER TABLE public.amber_alerts ENABLE ROW LEVEL SECURITY;\n\n-- Allow users to view all active amber alerts (public safety feature)\nCREATE POLICY \\"Anyone can view active amber alerts\\" \n  ON public.amber_alerts \n  FOR SELECT \n  USING (is_active = true);\n\n-- Allow users to create their own amber alerts\nCREATE POLICY \\"Users can create their own amber alerts\\" \n  ON public.amber_alerts \n  FOR INSERT \n  WITH CHECK (auth.uid() = user_id);\n\n-- Allow users to update their own amber alerts\nCREATE POLICY \\"Users can update their own amber alerts\\" \n  ON public.amber_alerts \n  FOR UPDATE \n  USING (auth.uid() = user_id);\n\n-- Allow users to view their own amber alerts (including resolved ones)\nCREATE POLICY \\"Users can view their own amber alerts\\" \n  ON public.amber_alerts \n  FOR SELECT \n  USING (auth.uid() = user_id);\n"}	5de71630-e09f-453d-b9d5-190f7b4060e6	armandonoel@outlook.com	\N
20250705042830	{"-- Crear tabla para notificaciones globales de prueba\nCREATE TABLE public.global_test_notifications (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  notification_type TEXT NOT NULL,\n  triggered_by UUID REFERENCES auth.users(id) NOT NULL,\n  triggered_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  expires_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT (now() + INTERVAL '30 seconds'),\n  is_active BOOLEAN NOT NULL DEFAULT true,\n  message TEXT\n);\n\n-- Habilitar RLS\nALTER TABLE public.global_test_notifications ENABLE ROW LEVEL SECURITY;\n\n-- Política para que todos puedan ver las notificaciones activas\nCREATE POLICY \\"Everyone can view active test notifications\\" \nON public.global_test_notifications \nFOR SELECT \nUSING (is_active = true AND expires_at > now());\n\n-- Política para que solo admins puedan crear notificaciones\nCREATE POLICY \\"Only admins can create test notifications\\" \nON public.global_test_notifications \nFOR INSERT \nWITH CHECK (public.has_role(auth.uid(), 'admin'));\n\n-- Habilitar realtime\nALTER TABLE public.global_test_notifications REPLICA IDENTITY FULL;\nALTER PUBLICATION supabase_realtime ADD TABLE public.global_test_notifications;\n\n-- Función para limpiar notificaciones expiradas\nCREATE OR REPLACE FUNCTION public.deactivate_expired_test_notifications()\nRETURNS void\nLANGUAGE plpgsql\nAS $$\nBEGIN\n  UPDATE public.global_test_notifications \n  SET is_active = false \n  WHERE is_active = true \n  AND expires_at < now();\nEND;\n$$;"}		armandonoel@outlook.com	\N
20250706013223	{"-- Primero, asignar el rol community_user a todos los usuarios existentes que no tienen roles\nINSERT INTO user_roles (user_id, role, assigned_by, is_active)\nSELECT \n  p.id,\n  'community_user'::app_role,\n  '51d869f4-fa16-4633-9121-561817fce43d', -- ID del admin actual\n  true\nFROM profiles p\nWHERE p.id NOT IN (\n  SELECT DISTINCT user_id \n  FROM user_roles \n  WHERE is_active = true\n);\n\n-- Crear función para asignar automáticamente rol community_user a usuarios nuevos\nCREATE OR REPLACE FUNCTION public.assign_default_role()\nRETURNS TRIGGER AS $$\nBEGIN\n  -- Asignar rol community_user por defecto a usuarios nuevos\n  INSERT INTO public.user_roles (user_id, role, is_active)\n  VALUES (NEW.id, 'community_user', true);\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Crear trigger para ejecutar la función cuando se crea un nuevo perfil\nCREATE OR REPLACE TRIGGER on_profile_created\n  AFTER INSERT ON public.profiles\n  FOR EACH ROW EXECUTE FUNCTION public.assign_default_role();"}		armandonoel@outlook.com	\N
20250706014009	{"-- Crear política para que los administradores puedan ver todos los perfiles\nCREATE POLICY \\"Admins can view all profiles\\" \nON public.profiles \nFOR SELECT \nUSING (is_admin(auth.uid()));\n\n-- Crear política para que los líderes comunitarios puedan ver todos los perfiles\nCREATE POLICY \\"Community leaders can view all profiles\\" \nON public.profiles \nFOR SELECT \nUSING (has_role(auth.uid(), 'community_leader'::app_role));"}		armandonoel@outlook.com	\N
20250706015402	{"-- Activar el rol de administrador existente para Ruth Esther Santana de Noel\nUPDATE public.user_roles \nSET is_active = true \nWHERE user_id = 'e953b9ba-10a2-4efe-a8c6-f89590cbda92' \nAND role = 'admin';"}		armandonoel@outlook.com	\N
20250706015622	{"-- Insertar rol de administrador para Ruth Esther Santana de Noel\nINSERT INTO public.user_roles (user_id, role, assigned_by, is_active)\nVALUES (\n    'e953b9ba-10a2-4efe-a8c6-f89590cbda92',\n    'admin',\n    '368be064-a35c-4b1b-9996-cf24dd021282',\n    true\n)\nON CONFLICT (user_id, role) \nDO UPDATE SET \n    is_active = true,\n    assigned_at = now();"}		armandonoel@outlook.com	\N
20250706035442	{"-- Create community messages table for leaders to send messages to their community\nCREATE TABLE public.community_messages (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  created_by UUID NOT NULL,\n  title TEXT NOT NULL,\n  message TEXT NOT NULL,\n  image_url TEXT,\n  sector TEXT,\n  municipality TEXT NOT NULL,\n  province TEXT NOT NULL,\n  scheduled_at TIMESTAMP WITH TIME ZONE,\n  sent_at TIMESTAMP WITH TIME ZONE,\n  is_active BOOLEAN NOT NULL DEFAULT true,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Enable RLS\nALTER TABLE public.community_messages ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for community messages\nCREATE POLICY \\"Community leaders can create messages\\" \nON public.community_messages \nFOR INSERT \nWITH CHECK (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid()));\n\nCREATE POLICY \\"Community leaders can view their own messages\\" \nON public.community_messages \nFOR SELECT \nUSING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));\n\nCREATE POLICY \\"Admins can view all messages\\" \nON public.community_messages \nFOR SELECT \nUSING (is_admin(auth.uid()));\n\nCREATE POLICY \\"Community leaders can update their own messages\\" \nON public.community_messages \nFOR UPDATE \nUSING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));\n\nCREATE POLICY \\"Admins can update all messages\\" \nON public.community_messages \nFOR UPDATE \nUSING (is_admin(auth.uid()));\n\nCREATE POLICY \\"Community leaders can delete their own messages\\" \nON public.community_messages \nFOR DELETE \nUSING (created_by = auth.uid() AND (has_role(auth.uid(), 'community_leader'::app_role) OR is_admin(auth.uid())));\n\nCREATE POLICY \\"Admins can delete all messages\\" \nON public.community_messages \nFOR DELETE \nUSING (is_admin(auth.uid()));\n\n-- Create message recipients table to track who receives the messages\nCREATE TABLE public.message_recipients (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  message_id UUID NOT NULL REFERENCES public.community_messages(id) ON DELETE CASCADE,\n  user_id UUID NOT NULL,\n  delivered_at TIMESTAMP WITH TIME ZONE,\n  read_at TIMESTAMP WITH TIME ZONE,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()\n);\n\n-- Enable RLS for message recipients\nALTER TABLE public.message_recipients ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for message recipients\nCREATE POLICY \\"Users can view messages sent to them\\" \nON public.message_recipients \nFOR SELECT \nUSING (auth.uid() = user_id);\n\nCREATE POLICY \\"System can insert message recipients\\" \nON public.message_recipients \nFOR INSERT \nWITH CHECK (true);\n\nCREATE POLICY \\"Users can update their own message status\\" \nON public.message_recipients \nFOR UPDATE \nUSING (auth.uid() = user_id);\n\n-- Create a table to track weekly message limits\nCREATE TABLE public.message_weekly_limits (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID NOT NULL,\n  week_start DATE NOT NULL,\n  message_count INTEGER NOT NULL DEFAULT 0,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  UNIQUE(user_id, week_start)\n);\n\n-- Enable RLS for weekly limits\nALTER TABLE public.message_weekly_limits ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for weekly limits\nCREATE POLICY \\"Users can view their own weekly limits\\" \nON public.message_weekly_limits \nFOR SELECT \nUSING (auth.uid() = user_id);\n\nCREATE POLICY \\"System can manage weekly limits\\" \nON public.message_weekly_limits \nFOR ALL \nUSING (true) \nWITH CHECK (true);\n\n-- Create function to check weekly message limit\nCREATE OR REPLACE FUNCTION public.check_weekly_message_limit(_user_id uuid)\nRETURNS boolean\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n  current_week_start DATE;\n  message_count INTEGER;\nBEGIN\n  -- Calculate the start of the current week (Monday)\n  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;\n  \n  -- Get the current week's message count\n  SELECT COALESCE(message_count, 0) INTO message_count\n  FROM public.message_weekly_limits\n  WHERE user_id = _user_id AND week_start = current_week_start;\n  \n  -- Return true if under the limit (3 messages per week)\n  RETURN COALESCE(message_count, 0) < 3;\nEND;\n$$;\n\n-- Create function to increment weekly message count\nCREATE OR REPLACE FUNCTION public.increment_weekly_message_count(_user_id uuid)\nRETURNS void\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n  current_week_start DATE;\nBEGIN\n  -- Calculate the start of the current week (Monday)\n  current_week_start := date_trunc('week', CURRENT_DATE)::DATE;\n  \n  -- Insert or update the weekly count\n  INSERT INTO public.message_weekly_limits (user_id, week_start, message_count)\n  VALUES (_user_id, current_week_start, 1)\n  ON CONFLICT (user_id, week_start)\n  DO UPDATE SET \n    message_count = message_weekly_limits.message_count + 1,\n    updated_at = now();\nEND;\n$$;\n\n-- Create trigger to check weekly limit before inserting messages\nCREATE OR REPLACE FUNCTION public.check_message_limit_trigger()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nAS $$\nBEGIN\n  -- Check if user has role to send messages\n  IF NOT (has_role(NEW.created_by, 'community_leader'::app_role) OR is_admin(NEW.created_by)) THEN\n    RAISE EXCEPTION 'User does not have permission to send community messages';\n  END IF;\n  \n  -- Check weekly limit (admins are exempt)\n  IF NOT is_admin(NEW.created_by) AND NOT check_weekly_message_limit(NEW.created_by) THEN\n    RAISE EXCEPTION 'Weekly message limit exceeded. Maximum 3 messages per week allowed.';\n  END IF;\n  \n  -- Increment the weekly count\n  PERFORM increment_weekly_message_count(NEW.created_by);\n  \n  RETURN NEW;\nEND;\n$$;\n\n-- Create the trigger\nCREATE TRIGGER check_community_message_limit\n  BEFORE INSERT ON public.community_messages\n  FOR EACH ROW\n  EXECUTE FUNCTION public.check_message_limit_trigger();\n\n-- Create function to update timestamps\nCREATE OR REPLACE FUNCTION public.update_community_messages_updated_at()\nRETURNS TRIGGER\nLANGUAGE plpgsql\nAS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$;\n\n-- Create trigger for updating timestamps\nCREATE TRIGGER update_community_messages_updated_at\n  BEFORE UPDATE ON public.community_messages\n  FOR EACH ROW\n  EXECUTE FUNCTION public.update_community_messages_updated_at();\n\n-- Create storage bucket for community message images\nINSERT INTO storage.buckets (id, name, public) VALUES ('community-messages', 'community-messages', true);\n\n-- Create storage policies for community message images\nCREATE POLICY \\"Community leaders can upload message images\\" \nON storage.objects \nFOR INSERT \nWITH CHECK (bucket_id = 'community-messages' AND (\n  EXISTS (\n    SELECT 1 FROM public.user_roles ur \n    WHERE ur.user_id = auth.uid() \n    AND ur.role IN ('community_leader', 'admin') \n    AND ur.is_active = true\n  )\n));\n\nCREATE POLICY \\"Community message images are publicly viewable\\" \nON storage.objects \nFOR SELECT \nUSING (bucket_id = 'community-messages');\n\nCREATE POLICY \\"Community leaders can update their message images\\" \nON storage.objects \nFOR UPDATE \nUSING (bucket_id = 'community-messages' AND (\n  EXISTS (\n    SELECT 1 FROM public.user_roles ur \n    WHERE ur.user_id = auth.uid() \n    AND ur.role IN ('community_leader', 'admin') \n    AND ur.is_active = true\n  )\n));\n\nCREATE POLICY \\"Community leaders can delete their message images\\" \nON storage.objects \nFOR DELETE \nUSING (bucket_id = 'community-messages' AND (\n  EXISTS (\n    SELECT 1 FROM public.user_roles ur \n    WHERE ur.user_id = auth.uid() \n    AND ur.role IN ('community_leader', 'admin') \n    AND ur.is_active = true\n  )\n));"}		armandonoel@outlook.com	\N
20250710024718	{"-- Allow admins to delete user profiles\n-- This will enable the delete functionality for admin users\n\n-- Create RLS policy for admins to delete profiles\nCREATE POLICY \\"Admins can delete profiles\\" \nON public.profiles \nFOR DELETE \nUSING (is_admin(auth.uid()));\n\n-- Create RLS policy for admins to delete user roles when deleting users\nCREATE POLICY \\"Admins can delete user roles\\" \nON public.user_roles \nFOR DELETE \nUSING (is_admin(auth.uid()));\n\n-- Create function to safely delete a user and all their data\nCREATE OR REPLACE FUNCTION public.delete_user_completely(user_id_to_delete uuid)\nRETURNS boolean\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n  current_user_id uuid;\nBEGIN\n  -- Get the current user ID\n  current_user_id := auth.uid();\n  \n  -- Check if current user is admin\n  IF NOT is_admin(current_user_id) THEN\n    RAISE EXCEPTION 'Only admins can delete users';\n  END IF;\n  \n  -- Check if trying to delete yourself\n  IF current_user_id = user_id_to_delete THEN\n    RAISE EXCEPTION 'Cannot delete your own account';\n  END IF;\n  \n  -- Delete user data in order (respecting foreign key constraints)\n  DELETE FROM public.garbage_payments WHERE user_id = user_id_to_delete;\n  DELETE FROM public.garbage_bills WHERE user_id = user_id_to_delete;\n  DELETE FROM public.help_messages WHERE user_id = user_id_to_delete;\n  DELETE FROM public.job_applications WHERE user_id = user_id_to_delete;\n  DELETE FROM public.message_recipients WHERE user_id = user_id_to_delete;\n  DELETE FROM public.message_weekly_limits WHERE user_id = user_id_to_delete;\n  DELETE FROM public.community_messages WHERE created_by = user_id_to_delete;\n  DELETE FROM public.before_after_videos WHERE user_id = user_id_to_delete;\n  DELETE FROM public.amber_alerts WHERE user_id = user_id_to_delete;\n  DELETE FROM public.panic_alerts WHERE user_id = user_id_to_delete;\n  DELETE FROM public.reports WHERE user_id = user_id_to_delete;\n  DELETE FROM public.generated_reports WHERE generated_by = user_id_to_delete;\n  DELETE FROM public.report_schedules WHERE created_by = user_id_to_delete;\n  DELETE FROM public.global_test_notifications WHERE triggered_by = user_id_to_delete;\n  \n  -- Delete user roles\n  DELETE FROM public.user_roles WHERE user_id = user_id_to_delete;\n  \n  -- Delete profile\n  DELETE FROM public.profiles WHERE id = user_id_to_delete;\n  \n  -- Delete from auth.users (this will cascade to other auth-related tables)\n  DELETE FROM auth.users WHERE id = user_id_to_delete;\n  \n  RETURN true;\nEND;\n$$;"}		armandonoel@outlook.com	\N
20250710031409	{"-- Add field to track if user needs to change password\nALTER TABLE public.profiles \nADD COLUMN must_change_password BOOLEAN DEFAULT FALSE;\n\n-- Create edge function to reset user password with temporary password\nCREATE OR REPLACE FUNCTION public.reset_user_password_with_temp(user_email TEXT, temp_password TEXT)\nRETURNS JSON\nLANGUAGE plpgsql\nSECURITY DEFINER\nAS $$\nDECLARE\n  user_id UUID;\n  result JSON;\nBEGIN\n  -- Find user by email\n  SELECT id INTO user_id \n  FROM auth.users \n  WHERE email = user_email;\n  \n  IF user_id IS NULL THEN\n    RETURN JSON_BUILD_OBJECT('success', false, 'error', 'Usuario no encontrado');\n  END IF;\n  \n  -- Update user password in auth.users\n  UPDATE auth.users \n  SET \n    encrypted_password = crypt(temp_password, gen_salt('bf')),\n    updated_at = now()\n  WHERE id = user_id;\n  \n  -- Mark user as needing password change\n  INSERT INTO public.profiles (id, must_change_password)\n  VALUES (user_id, true)\n  ON CONFLICT (id) \n  DO UPDATE SET \n    must_change_password = true,\n    updated_at = now();\n  \n  RETURN JSON_BUILD_OBJECT('success', true, 'message', 'Contraseña temporal establecida');\nEND;\n$$;"}		armandonoel@outlook.com	\N
20250710032701	{"-- Agregar restricciones de unicidad para prevenir registros duplicados\n-- Email ya tiene unicidad en auth.users por defecto\n\n-- Agregar restricción de unicidad para el teléfono (cuando no sea nulo)\nALTER TABLE public.profiles \nADD CONSTRAINT profiles_phone_unique \nUNIQUE (phone) DEFERRABLE INITIALLY DEFERRED;\n\n-- Agregar restricción de unicidad para el número de documento (cuando no sea nulo)  \nALTER TABLE public.profiles \nADD CONSTRAINT profiles_document_number_unique \nUNIQUE (document_number) DEFERRABLE INITIALLY DEFERRED;"}		armandonoel@outlook.com	\N
20250710033120	{"-- Crear tabla para almacenar configuración de 2FA\nCREATE TABLE public.user_2fa (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,\n  secret TEXT NOT NULL,\n  enabled BOOLEAN NOT NULL DEFAULT false,\n  backup_codes TEXT[], -- Códigos de respaldo\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  last_used_at TIMESTAMP WITH TIME ZONE,\n  \n  UNIQUE(user_id)\n);\n\n-- Habilitar RLS\nALTER TABLE public.user_2fa ENABLE ROW LEVEL SECURITY;\n\n-- Políticas de seguridad\nCREATE POLICY \\"Users can view their own 2FA config\\" \nON public.user_2fa \nFOR SELECT \nUSING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can insert their own 2FA config\\" \nON public.user_2fa \nFOR INSERT \nWITH CHECK (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can update their own 2FA config\\" \nON public.user_2fa \nFOR UPDATE \nUSING (auth.uid() = user_id);\n\nCREATE POLICY \\"Users can delete their own 2FA config\\" \nON public.user_2fa \nFOR DELETE \nUSING (auth.uid() = user_id);\n\n-- Función para actualizar updated_at\nCREATE OR REPLACE FUNCTION public.update_user_2fa_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\n-- Trigger para actualizar updated_at automáticamente\nCREATE TRIGGER update_user_2fa_updated_at\n  BEFORE UPDATE ON public.user_2fa\n  FOR EACH ROW\n  EXECUTE FUNCTION public.update_user_2fa_updated_at();"}		armandonoel@outlook.com	\N
20250711040211	{"-- Actualizar las coordenadas de Los Mina/Los Minas con las coordenadas correctas\n-- Los Mina: 18.4769° N, 69.8605° W\n\nUPDATE reports \nSET \n  latitude = 18.4769,\n  longitude = -69.8605,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';"}		armandonoel@outlook.com	\N
20250711040813	{"-- Actualizar coordenadas más precisas usando referencias específicas mencionadas por el usuario\n-- Los Mina: Hospital San Lorenzo de Los Mina como referencia\n-- Gazcue: Centro de Tecnología Universal (Centu) como referencia  \n-- Alma Rosa: SDM Sistemas como referencia\n\n-- Actualizar Los Mina con coordenadas más precisas del Hospital San Lorenzo\nUPDATE reports \nSET \n  latitude = 18.485,\n  longitude = -69.856,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';\n\n-- Actualizar Gazcue con coordenadas precisas de Wikipedia/Centu\nUPDATE reports \nSET \n  latitude = 18.500,\n  longitude = -69.983,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%gazcue%' OR address ILIKE '%gazcue%';\n\n-- Actualizar Alma Rosa con coordenadas estimadas del área\nUPDATE reports \nSET \n  latitude = 18.500,\n  longitude = -69.850,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%alma rosa%' OR address ILIKE '%alma rosa%';"}		armandonoel@outlook.com	\N
20250711041542	{"-- Corrección masiva de coordenadas de barrios de Santo Domingo\n-- Basado en datos oficiales de Wikipedia y fuentes verificadas\n\n-- Villa Duarte (18°28′N 69°52′W = 18.467, -69.867)\nUPDATE reports \nSET \n  latitude = 18.467,\n  longitude = -69.867,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%villa duarte%' OR address ILIKE '%villa duarte%';\n\n-- Los Cacicazgos (18°30′N 69°59′W = 18.500, -69.983)\nUPDATE reports \nSET \n  latitude = 18.500,\n  longitude = -69.983,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%cacicazgos%' OR address ILIKE '%cacicazgos%';\n\n-- Piantini (18°30′N 69°59′W = 18.500, -69.983)\nUPDATE reports \nSET \n  latitude = 18.500,\n  longitude = -69.983,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%piantini%' OR address ILIKE '%piantini%';\n\n-- Gazcue (coordenadas precisas del sector residencial)\nUPDATE reports \nSET \n  latitude = 18.479,\n  longitude = -69.933,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%gazcue%' OR address ILIKE '%gazcue%';\n\n-- Alma Rosa (sector este de Santo Domingo)\nUPDATE reports \nSET \n  latitude = 18.485,\n  longitude = -69.873,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%alma rosa%' OR address ILIKE '%alma rosa%';\n\n-- Los Mina/Minas (coordenadas del área residencial)\nUPDATE reports \nSET \n  latitude = 18.485,\n  longitude = -69.856,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%mina%' OR address ILIKE '%mina%';\n\n-- Gualey (sector central-norte)\nUPDATE reports \nSET \n  latitude = 18.475,\n  longitude = -69.925,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%gualey%' OR address ILIKE '%gualey%';\n\n-- Bella Vista (sector centro-sur)\nUPDATE reports \nSET \n  latitude = 18.472,\n  longitude = -69.928,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%bella vista%' OR address ILIKE '%bella vista%';\n\n-- Villa Agrippina (sector oeste)\nUPDATE reports \nSET \n  latitude = 18.468,\n  longitude = -69.940,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%villa agrippina%' OR address ILIKE '%villa agrippina%' OR neighborhood ILIKE '%agrippina%';\n\n-- La Esperilla (sector central)\nUPDATE reports \nSET \n  latitude = 18.476,\n  longitude = -69.930,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%esperilla%' OR address ILIKE '%esperilla%';\n\n-- Ensanche Ozama (sector este)\nUPDATE reports \nSET \n  latitude = 18.480,\n  longitude = -69.880,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%ensanche ozama%' OR address ILIKE '%ensanche ozama%' OR neighborhood ILIKE '%ozama%';\n\n-- San Carlos (sector central-oeste)\nUPDATE reports \nSET \n  latitude = 18.474,\n  longitude = -69.935,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%san carlos%' OR address ILIKE '%san carlos%';\n\n-- Villa Juana (sector sur)\nUPDATE reports \nSET \n  latitude = 18.465,\n  longitude = -69.925,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%villa juana%' OR address ILIKE '%villa juana%';\n\n-- Mirador Sur (sector sur residencial)\nUPDATE reports \nSET \n  latitude = 18.460,\n  longitude = -69.940,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%mirador sur%' OR address ILIKE '%mirador sur%';\n\n-- Cristo Rey (sector oeste)\nUPDATE reports \nSET \n  latitude = 18.470,\n  longitude = -69.950,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%cristo rey%' OR address ILIKE '%cristo rey%';\n\n-- Los Ríos (sector sur-este)\nUPDATE reports \nSET \n  latitude = 18.465,\n  longitude = -69.890,\n  updated_at = now()\nWHERE \n  neighborhood ILIKE '%los ríos%' OR address ILIKE '%los ríos%' OR neighborhood ILIKE '%los rios%';"}		armandonoel@outlook.com	\N
20250711121706	{"-- Crear tabla para configuración de alertas de basura\nCREATE TABLE public.garbage_alert_configs (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  sector TEXT NOT NULL,\n  municipality TEXT NOT NULL DEFAULT 'Medellín',\n  province TEXT NOT NULL DEFAULT 'Antioquia',\n  days_of_week INTEGER[] NOT NULL DEFAULT '{1,3,5}', -- Lunes, Miércoles, Viernes\n  frequency_hours INTEGER NOT NULL DEFAULT 3, -- Cada 3 horas\n  start_hour INTEGER NOT NULL DEFAULT 6, -- 6:00 AM\n  end_hour INTEGER NOT NULL DEFAULT 18, -- 6:00 PM\n  is_active BOOLEAN NOT NULL DEFAULT true,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  created_by UUID NULL\n);\n\n-- Enable RLS\nALTER TABLE public.garbage_alert_configs ENABLE ROW LEVEL SECURITY;\n\n-- Crear políticas RLS\nCREATE POLICY \\"Solo admins pueden gestionar configuraciones de alertas\\"\nON public.garbage_alert_configs\nFOR ALL\nUSING (is_admin(auth.uid()))\nWITH CHECK (is_admin(auth.uid()));\n\n-- Crear función para actualizar updated_at\nCREATE OR REPLACE FUNCTION public.update_garbage_alert_configs_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\n-- Crear trigger para actualizar timestamps\nCREATE TRIGGER update_garbage_alert_configs_updated_at\nBEFORE UPDATE ON public.garbage_alert_configs\nFOR EACH ROW\nEXECUTE FUNCTION public.update_garbage_alert_configs_updated_at();\n\n-- Insertar configuración por defecto\nINSERT INTO public.garbage_alert_configs (\n  sector,\n  municipality,\n  province,\n  days_of_week,\n  frequency_hours,\n  start_hour,\n  end_hour\n) VALUES (\n  'General',\n  'Medellín',\n  'Antioquia',\n  '{1,3,5}',\n  3,\n  6,\n  18\n);"}		armandonoel@outlook.com	\N
20250712015903	{"-- Actualizar los valores por defecto para República Dominicana\nALTER TABLE public.garbage_alert_configs \nALTER COLUMN municipality SET DEFAULT 'Santo Domingo';\n\nALTER TABLE public.garbage_alert_configs \nALTER COLUMN province SET DEFAULT 'Distrito Nacional';\n\n-- Actualizar cualquier configuración existente que tenga los valores de Colombia\nUPDATE public.garbage_alert_configs \nSET municipality = 'Santo Domingo', province = 'Distrito Nacional'\nWHERE municipality = 'Medellín' AND province = 'Antioquia';"}		armandonoel@outlook.com	\N
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 203, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 3690, true);


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
-- Name: amber_alerts amber_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amber_alerts
    ADD CONSTRAINT amber_alerts_pkey PRIMARY KEY (id);


--
-- Name: before_after_videos before_after_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.before_after_videos
    ADD CONSTRAINT before_after_videos_pkey PRIMARY KEY (id);


--
-- Name: community_messages community_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_messages
    ADD CONSTRAINT community_messages_pkey PRIMARY KEY (id);


--
-- Name: garbage_alert_configs garbage_alert_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_alert_configs
    ADD CONSTRAINT garbage_alert_configs_pkey PRIMARY KEY (id);


--
-- Name: garbage_bills garbage_bills_bill_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_bills
    ADD CONSTRAINT garbage_bills_bill_number_key UNIQUE (bill_number);


--
-- Name: garbage_bills garbage_bills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_bills
    ADD CONSTRAINT garbage_bills_pkey PRIMARY KEY (id);


--
-- Name: garbage_payments garbage_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_payments
    ADD CONSTRAINT garbage_payments_pkey PRIMARY KEY (id);


--
-- Name: garbage_payments garbage_payments_stripe_session_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_payments
    ADD CONSTRAINT garbage_payments_stripe_session_id_key UNIQUE (stripe_session_id);


--
-- Name: generated_reports generated_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generated_reports
    ADD CONSTRAINT generated_reports_pkey PRIMARY KEY (id);


--
-- Name: global_test_notifications global_test_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_test_notifications
    ADD CONSTRAINT global_test_notifications_pkey PRIMARY KEY (id);


--
-- Name: help_messages help_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.help_messages
    ADD CONSTRAINT help_messages_pkey PRIMARY KEY (id);


--
-- Name: job_applications job_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_pkey PRIMARY KEY (id);


--
-- Name: message_recipients message_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_pkey PRIMARY KEY (id);


--
-- Name: message_weekly_limits message_weekly_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_weekly_limits
    ADD CONSTRAINT message_weekly_limits_pkey PRIMARY KEY (id);


--
-- Name: message_weekly_limits message_weekly_limits_user_id_week_start_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_weekly_limits
    ADD CONSTRAINT message_weekly_limits_user_id_week_start_key UNIQUE (user_id, week_start);


--
-- Name: panic_alerts panic_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panic_alerts
    ADD CONSTRAINT panic_alerts_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_document_number_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_document_number_unique UNIQUE (document_number) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles profiles_phone_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_phone_unique UNIQUE (phone) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: report_metrics report_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_metrics
    ADD CONSTRAINT report_metrics_pkey PRIMARY KEY (id);


--
-- Name: report_schedules report_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: user_2fa user_2fa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_2fa
    ADD CONSTRAINT user_2fa_pkey PRIMARY KEY (id);


--
-- Name: user_2fa user_2fa_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_2fa
    ADD CONSTRAINT user_2fa_user_id_key UNIQUE (user_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_user_id_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_role_key UNIQUE (user_id, role);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_09 messages_2025_07_09_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_09
    ADD CONSTRAINT messages_2025_07_09_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_10 messages_2025_07_10_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_10
    ADD CONSTRAINT messages_2025_07_10_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_11 messages_2025_07_11_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_11
    ADD CONSTRAINT messages_2025_07_11_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_12 messages_2025_07_12_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_12
    ADD CONSTRAINT messages_2025_07_12_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_13 messages_2025_07_13_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_13
    ADD CONSTRAINT messages_2025_07_13_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_14 messages_2025_07_14_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_14
    ADD CONSTRAINT messages_2025_07_14_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2025_07_15 messages_2025_07_15_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_15
    ADD CONSTRAINT messages_2025_07_15_pkey PRIMARY KEY (id, inserted_at);


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
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


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
-- Name: idx_help_messages_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_help_messages_created_at ON public.help_messages USING btree (created_at DESC);


--
-- Name: idx_help_messages_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_help_messages_status ON public.help_messages USING btree (status);


--
-- Name: idx_help_messages_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_help_messages_user_id ON public.help_messages USING btree (user_id);


--
-- Name: idx_profiles_neighborhood; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_neighborhood ON public.profiles USING btree (neighborhood);


--
-- Name: idx_reports_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_category ON public.reports USING btree (category);


--
-- Name: idx_reports_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_created_at ON public.reports USING btree (created_at);


--
-- Name: idx_reports_neighborhood; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_neighborhood ON public.reports USING btree (neighborhood);


--
-- Name: idx_reports_priority; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_priority ON public.reports USING btree (priority);


--
-- Name: idx_reports_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_status ON public.reports USING btree (status);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


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
-- Name: messages_2025_07_09_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_09_pkey;


--
-- Name: messages_2025_07_10_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_10_pkey;


--
-- Name: messages_2025_07_11_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_11_pkey;


--
-- Name: messages_2025_07_12_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_12_pkey;


--
-- Name: messages_2025_07_13_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_13_pkey;


--
-- Name: messages_2025_07_14_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_14_pkey;


--
-- Name: messages_2025_07_15_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_15_pkey;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: community_messages check_community_message_limit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_community_message_limit BEFORE INSERT ON public.community_messages FOR EACH ROW EXECUTE FUNCTION public.check_message_limit_trigger();


--
-- Name: profiles on_profile_created; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER on_profile_created AFTER INSERT ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.assign_default_role();


--
-- Name: garbage_bills trigger_set_bill_number; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_set_bill_number BEFORE INSERT ON public.garbage_bills FOR EACH ROW EXECUTE FUNCTION public.set_bill_number();


--
-- Name: community_messages update_community_messages_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_community_messages_updated_at BEFORE UPDATE ON public.community_messages FOR EACH ROW EXECUTE FUNCTION public.update_community_messages_updated_at();


--
-- Name: garbage_alert_configs update_garbage_alert_configs_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_garbage_alert_configs_updated_at BEFORE UPDATE ON public.garbage_alert_configs FOR EACH ROW EXECUTE FUNCTION public.update_garbage_alert_configs_updated_at();


--
-- Name: user_2fa update_user_2fa_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_user_2fa_updated_at BEFORE UPDATE ON public.user_2fa FOR EACH ROW EXECUTE FUNCTION public.update_user_2fa_updated_at();


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
-- Name: amber_alerts amber_alerts_resolved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amber_alerts
    ADD CONSTRAINT amber_alerts_resolved_by_fkey FOREIGN KEY (resolved_by) REFERENCES auth.users(id);


--
-- Name: amber_alerts amber_alerts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amber_alerts
    ADD CONSTRAINT amber_alerts_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: before_after_videos before_after_videos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.before_after_videos
    ADD CONSTRAINT before_after_videos_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: garbage_bills garbage_bills_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_bills
    ADD CONSTRAINT garbage_bills_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: garbage_payments garbage_payments_bill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_payments
    ADD CONSTRAINT garbage_payments_bill_id_fkey FOREIGN KEY (bill_id) REFERENCES public.garbage_bills(id);


--
-- Name: garbage_payments garbage_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garbage_payments
    ADD CONSTRAINT garbage_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: generated_reports generated_reports_generated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.generated_reports
    ADD CONSTRAINT generated_reports_generated_by_fkey FOREIGN KEY (generated_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: global_test_notifications global_test_notifications_triggered_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_test_notifications
    ADD CONSTRAINT global_test_notifications_triggered_by_fkey FOREIGN KEY (triggered_by) REFERENCES auth.users(id);


--
-- Name: help_messages help_messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.help_messages
    ADD CONSTRAINT help_messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: job_applications job_applications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_applications
    ADD CONSTRAINT job_applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: message_recipients message_recipients_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_recipients
    ADD CONSTRAINT message_recipients_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.community_messages(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: report_metrics report_metrics_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_metrics
    ADD CONSTRAINT report_metrics_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.generated_reports(id) ON DELETE CASCADE;


--
-- Name: report_schedules report_schedules_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_schedules
    ADD CONSTRAINT report_schedules_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: reports reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: user_2fa user_2fa_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_2fa
    ADD CONSTRAINT user_2fa_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


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
-- Name: report_metrics Admins and leaders can create metrics; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and leaders can create metrics" ON public.report_metrics FOR INSERT TO authenticated WITH CHECK ((public.is_admin(auth.uid()) OR public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: generated_reports Admins and leaders can create reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and leaders can create reports" ON public.generated_reports FOR INSERT TO authenticated WITH CHECK ((public.is_admin(auth.uid()) OR public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: generated_reports Admins and leaders can delete reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and leaders can delete reports" ON public.generated_reports FOR DELETE TO authenticated USING ((public.is_admin(auth.uid()) OR public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: generated_reports Admins and leaders can update reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and leaders can update reports" ON public.generated_reports FOR UPDATE TO authenticated USING ((public.is_admin(auth.uid()) OR public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: community_messages Admins can delete all messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete all messages" ON public.community_messages FOR DELETE USING (public.is_admin(auth.uid()));


--
-- Name: profiles Admins can delete profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete profiles" ON public.profiles FOR DELETE USING (public.is_admin(auth.uid()));


--
-- Name: user_roles Admins can delete user roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete user roles" ON public.user_roles FOR DELETE USING (public.is_admin(auth.uid()));


--
-- Name: report_schedules Admins can manage all schedules; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all schedules" ON public.report_schedules TO authenticated USING (public.is_admin(auth.uid())) WITH CHECK (public.is_admin(auth.uid()));


--
-- Name: community_messages Admins can update all messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update all messages" ON public.community_messages FOR UPDATE USING (public.is_admin(auth.uid()));


--
-- Name: generated_reports Admins can view all generated reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all generated reports" ON public.generated_reports FOR SELECT TO authenticated USING (public.is_admin(auth.uid()));


--
-- Name: community_messages Admins can view all messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all messages" ON public.community_messages FOR SELECT USING (public.is_admin(auth.uid()));


--
-- Name: profiles Admins can view all profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all profiles" ON public.profiles FOR SELECT USING (public.is_admin(auth.uid()));


--
-- Name: user_roles Admins can view all user roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all user roles" ON public.user_roles FOR SELECT TO authenticated USING (public.is_admin(auth.uid()));


--
-- Name: panic_alerts All authenticated users can view active alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "All authenticated users can view active alerts" ON public.panic_alerts FOR SELECT TO authenticated USING (true);


--
-- Name: amber_alerts Anyone can view active amber alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view active amber alerts" ON public.amber_alerts FOR SELECT USING ((is_active = true));


--
-- Name: community_messages Community leaders can create messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can create messages" ON public.community_messages FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'community_leader'::public.app_role) OR public.is_admin(auth.uid())));


--
-- Name: community_messages Community leaders can delete their own messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can delete their own messages" ON public.community_messages FOR DELETE USING (((created_by = auth.uid()) AND (public.has_role(auth.uid(), 'community_leader'::public.app_role) OR public.is_admin(auth.uid()))));


--
-- Name: community_messages Community leaders can update their own messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can update their own messages" ON public.community_messages FOR UPDATE USING (((created_by = auth.uid()) AND (public.has_role(auth.uid(), 'community_leader'::public.app_role) OR public.is_admin(auth.uid()))));


--
-- Name: profiles Community leaders can view all profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can view all profiles" ON public.profiles FOR SELECT USING (public.has_role(auth.uid(), 'community_leader'::public.app_role));


--
-- Name: generated_reports Community leaders can view all reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can view all reports" ON public.generated_reports FOR SELECT TO authenticated USING (public.has_role(auth.uid(), 'community_leader'::public.app_role));


--
-- Name: community_messages Community leaders can view their own messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Community leaders can view their own messages" ON public.community_messages FOR SELECT USING (((created_by = auth.uid()) AND (public.has_role(auth.uid(), 'community_leader'::public.app_role) OR public.is_admin(auth.uid()))));


--
-- Name: global_test_notifications Everyone can view active test notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Everyone can view active test notifications" ON public.global_test_notifications FOR SELECT USING (((is_active = true) AND (expires_at > now())));


--
-- Name: report_schedules Leaders can manage their schedules; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Leaders can manage their schedules" ON public.report_schedules TO authenticated USING (((created_by = auth.uid()) AND public.has_role(auth.uid(), 'community_leader'::public.app_role))) WITH CHECK (((created_by = auth.uid()) AND public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: profiles Los usuarios pueden actualizar su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden actualizar su propio perfil" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: reports Los usuarios pueden actualizar sus propios reportes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden actualizar sus propios reportes" ON public.reports FOR UPDATE TO authenticated USING ((auth.uid() = user_id));


--
-- Name: reports Los usuarios pueden crear sus propios reportes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden crear sus propios reportes" ON public.reports FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Los usuarios pueden insertar su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden insertar su propio perfil" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: profiles Los usuarios pueden ver su propio perfil; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden ver su propio perfil" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: reports Los usuarios pueden ver todos los reportes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Los usuarios pueden ver todos los reportes" ON public.reports FOR SELECT TO authenticated USING (true);


--
-- Name: global_test_notifications Only admins can create test notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Only admins can create test notifications" ON public.global_test_notifications FOR INSERT WITH CHECK (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: user_roles Only admins can manage user roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Only admins can manage user roles" ON public.user_roles TO authenticated USING (public.is_admin(auth.uid())) WITH CHECK (public.is_admin(auth.uid()));


--
-- Name: garbage_bills Service can insert bills; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service can insert bills" ON public.garbage_bills FOR INSERT WITH CHECK (true);


--
-- Name: garbage_bills Service can update bills; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service can update bills" ON public.garbage_bills FOR UPDATE USING (true);


--
-- Name: garbage_payments Service can update payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service can update payments" ON public.garbage_payments FOR UPDATE USING (true);


--
-- Name: garbage_alert_configs Solo admins pueden gestionar configuraciones de alertas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Solo admins pueden gestionar configuraciones de alertas" ON public.garbage_alert_configs USING (public.is_admin(auth.uid())) WITH CHECK (public.is_admin(auth.uid()));


--
-- Name: message_recipients System can insert message recipients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can insert message recipients" ON public.message_recipients FOR INSERT WITH CHECK (true);


--
-- Name: message_weekly_limits System can manage weekly limits; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can manage weekly limits" ON public.message_weekly_limits USING (true) WITH CHECK (true);


--
-- Name: help_messages Users can create help messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create help messages" ON public.help_messages FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: panic_alerts Users can create their own alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own alerts" ON public.panic_alerts FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- Name: amber_alerts Users can create their own amber alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own amber alerts" ON public.amber_alerts FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: job_applications Users can create their own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own applications" ON public.job_applications FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: before_after_videos Users can create their own before-after videos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own before-after videos" ON public.before_after_videos FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: garbage_payments Users can create their own payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own payments" ON public.garbage_payments FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: user_2fa Users can delete their own 2FA config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own 2FA config" ON public.user_2fa FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: before_after_videos Users can delete their own before-after videos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own before-after videos" ON public.before_after_videos FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: user_2fa Users can insert their own 2FA config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own 2FA config" ON public.user_2fa FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: user_2fa Users can update their own 2FA config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own 2FA config" ON public.user_2fa FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: amber_alerts Users can update their own amber alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own amber alerts" ON public.amber_alerts FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: job_applications Users can update their own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own applications" ON public.job_applications FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: before_after_videos Users can update their own before-after videos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own before-after videos" ON public.before_after_videos FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: message_recipients Users can update their own message status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own message status" ON public.message_recipients FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: before_after_videos Users can view all before-after videos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view all before-after videos" ON public.before_after_videos FOR SELECT USING (true);


--
-- Name: message_recipients Users can view messages sent to them; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view messages sent to them" ON public.message_recipients FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: report_metrics Users can view metrics of accessible reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view metrics of accessible reports" ON public.report_metrics FOR SELECT TO authenticated USING ((public.is_admin(auth.uid()) OR public.has_role(auth.uid(), 'community_leader'::public.app_role)));


--
-- Name: user_2fa Users can view their own 2FA config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own 2FA config" ON public.user_2fa FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: amber_alerts Users can view their own amber alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own amber alerts" ON public.amber_alerts FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: job_applications Users can view their own applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own applications" ON public.job_applications FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: garbage_bills Users can view their own bills; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own bills" ON public.garbage_bills FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: help_messages Users can view their own help messages; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own help messages" ON public.help_messages FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: garbage_payments Users can view their own payments; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own payments" ON public.garbage_payments FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: user_roles Users can view their own roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own roles" ON public.user_roles FOR SELECT TO authenticated USING ((user_id = auth.uid()));


--
-- Name: message_weekly_limits Users can view their own weekly limits; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own weekly limits" ON public.message_weekly_limits FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: amber_alerts Usuarios pueden crear alertas Amber; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden crear alertas Amber" ON public.amber_alerts FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- Name: amber_alerts Usuarios pueden resolver alertas Amber; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden resolver alertas Amber" ON public.amber_alerts FOR UPDATE TO authenticated USING (true) WITH CHECK (true);


--
-- Name: amber_alerts Usuarios pueden ver alertas Amber activas; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Usuarios pueden ver alertas Amber activas" ON public.amber_alerts FOR SELECT TO authenticated USING ((is_active = true));


--
-- Name: amber_alerts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.amber_alerts ENABLE ROW LEVEL SECURITY;

--
-- Name: before_after_videos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.before_after_videos ENABLE ROW LEVEL SECURITY;

--
-- Name: community_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.community_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: garbage_alert_configs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.garbage_alert_configs ENABLE ROW LEVEL SECURITY;

--
-- Name: garbage_bills; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.garbage_bills ENABLE ROW LEVEL SECURITY;

--
-- Name: garbage_payments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.garbage_payments ENABLE ROW LEVEL SECURITY;

--
-- Name: generated_reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.generated_reports ENABLE ROW LEVEL SECURITY;

--
-- Name: global_test_notifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.global_test_notifications ENABLE ROW LEVEL SECURITY;

--
-- Name: help_messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.help_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: job_applications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.job_applications ENABLE ROW LEVEL SECURITY;

--
-- Name: message_recipients; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.message_recipients ENABLE ROW LEVEL SECURITY;

--
-- Name: message_weekly_limits; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.message_weekly_limits ENABLE ROW LEVEL SECURITY;

--
-- Name: panic_alerts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.panic_alerts ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: report_metrics; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.report_metrics ENABLE ROW LEVEL SECURITY;

--
-- Name: report_schedules; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.report_schedules ENABLE ROW LEVEL SECURITY;

--
-- Name: reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;

--
-- Name: user_2fa; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_2fa ENABLE ROW LEVEL SECURITY;

--
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Allow authenticated users to upload before-after videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated users to upload before-after videos" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'before-after-videos'::text) AND (auth.role() = 'authenticated'::text)));


--
-- Name: objects Allow public access to before-after videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow public access to before-after videos" ON storage.objects FOR SELECT USING ((bucket_id = 'before-after-videos'::text));


--
-- Name: objects Allow users to delete their own before-after videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to delete their own before-after videos" ON storage.objects FOR DELETE USING (((bucket_id = 'before-after-videos'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Allow users to update their own before-after videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to update their own before-after videos" ON storage.objects FOR UPDATE USING (((bucket_id = 'before-after-videos'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Community leaders can delete their message images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Community leaders can delete their message images" ON storage.objects FOR DELETE USING (((bucket_id = 'community-messages'::text) AND (EXISTS ( SELECT 1
   FROM public.user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = ANY (ARRAY['community_leader'::public.app_role, 'admin'::public.app_role])) AND (ur.is_active = true))))));


--
-- Name: objects Community leaders can update their message images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Community leaders can update their message images" ON storage.objects FOR UPDATE USING (((bucket_id = 'community-messages'::text) AND (EXISTS ( SELECT 1
   FROM public.user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = ANY (ARRAY['community_leader'::public.app_role, 'admin'::public.app_role])) AND (ur.is_active = true))))));


--
-- Name: objects Community leaders can upload message images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Community leaders can upload message images" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'community-messages'::text) AND (EXISTS ( SELECT 1
   FROM public.user_roles ur
  WHERE ((ur.user_id = auth.uid()) AND (ur.role = ANY (ARRAY['community_leader'::public.app_role, 'admin'::public.app_role])) AND (ur.is_active = true))))));


--
-- Name: objects Community message images are publicly viewable; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Community message images are publicly viewable" ON storage.objects FOR SELECT USING ((bucket_id = 'community-messages'::text));


--
-- Name: objects Users can delete their own CV files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can delete their own CV files" ON storage.objects FOR DELETE USING (((bucket_id = 'cv-files'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Users can update their own CV files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can update their own CV files" ON storage.objects FOR UPDATE USING (((bucket_id = 'cv-files'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Users can upload their own CV files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can upload their own CV files" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'cv-files'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Users can view their own CV files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can view their own CV files" ON storage.objects FOR SELECT USING (((bucket_id = 'cv-files'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- Name: objects Usuarios pueden subir fotos para alertas Amber; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Usuarios pueden subir fotos para alertas Amber" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'amber-alert-photos'::text));


--
-- Name: objects Usuarios pueden ver fotos de alertas Amber; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Usuarios pueden ver fotos de alertas Amber" ON storage.objects FOR SELECT TO authenticated USING ((bucket_id = 'amber-alert-photos'::text));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

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
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- Name: supabase_realtime amber_alerts; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.amber_alerts;


--
-- Name: supabase_realtime global_test_notifications; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.global_test_notifications;


--
-- Name: supabase_realtime panic_alerts; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.panic_alerts;


--
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


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

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


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
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;


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
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION assign_default_role(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.assign_default_role() TO anon;
GRANT ALL ON FUNCTION public.assign_default_role() TO authenticated;
GRANT ALL ON FUNCTION public.assign_default_role() TO service_role;


--
-- Name: FUNCTION check_message_limit_trigger(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_message_limit_trigger() TO anon;
GRANT ALL ON FUNCTION public.check_message_limit_trigger() TO authenticated;
GRANT ALL ON FUNCTION public.check_message_limit_trigger() TO service_role;


--
-- Name: FUNCTION check_weekly_message_limit(_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_weekly_message_limit(_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.check_weekly_message_limit(_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.check_weekly_message_limit(_user_id uuid) TO service_role;


--
-- Name: FUNCTION deactivate_expired_panic_alerts(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.deactivate_expired_panic_alerts() TO anon;
GRANT ALL ON FUNCTION public.deactivate_expired_panic_alerts() TO authenticated;
GRANT ALL ON FUNCTION public.deactivate_expired_panic_alerts() TO service_role;


--
-- Name: FUNCTION deactivate_expired_test_notifications(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.deactivate_expired_test_notifications() TO anon;
GRANT ALL ON FUNCTION public.deactivate_expired_test_notifications() TO authenticated;
GRANT ALL ON FUNCTION public.deactivate_expired_test_notifications() TO service_role;


--
-- Name: FUNCTION delete_user_completely(user_id_to_delete uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_user_completely(user_id_to_delete uuid) TO anon;
GRANT ALL ON FUNCTION public.delete_user_completely(user_id_to_delete uuid) TO authenticated;
GRANT ALL ON FUNCTION public.delete_user_completely(user_id_to_delete uuid) TO service_role;


--
-- Name: FUNCTION generate_bill_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_bill_number() TO anon;
GRANT ALL ON FUNCTION public.generate_bill_number() TO authenticated;
GRANT ALL ON FUNCTION public.generate_bill_number() TO service_role;


--
-- Name: FUNCTION generate_monthly_bills(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_monthly_bills() TO anon;
GRANT ALL ON FUNCTION public.generate_monthly_bills() TO authenticated;
GRANT ALL ON FUNCTION public.generate_monthly_bills() TO service_role;


--
-- Name: FUNCTION generate_scheduled_reports(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.generate_scheduled_reports() TO anon;
GRANT ALL ON FUNCTION public.generate_scheduled_reports() TO authenticated;
GRANT ALL ON FUNCTION public.generate_scheduled_reports() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION has_role(_user_id uuid, _role public.app_role); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO anon;
GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO authenticated;
GRANT ALL ON FUNCTION public.has_role(_user_id uuid, _role public.app_role) TO service_role;


--
-- Name: FUNCTION increment_weekly_message_count(_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.increment_weekly_message_count(_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.increment_weekly_message_count(_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.increment_weekly_message_count(_user_id uuid) TO service_role;


--
-- Name: FUNCTION is_admin(_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_admin(_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.is_admin(_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.is_admin(_user_id uuid) TO service_role;


--
-- Name: FUNCTION reset_user_password_with_temp(user_email text, temp_password text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.reset_user_password_with_temp(user_email text, temp_password text) TO anon;
GRANT ALL ON FUNCTION public.reset_user_password_with_temp(user_email text, temp_password text) TO authenticated;
GRANT ALL ON FUNCTION public.reset_user_password_with_temp(user_email text, temp_password text) TO service_role;


--
-- Name: FUNCTION set_bill_number(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_bill_number() TO anon;
GRANT ALL ON FUNCTION public.set_bill_number() TO authenticated;
GRANT ALL ON FUNCTION public.set_bill_number() TO service_role;


--
-- Name: FUNCTION update_community_messages_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_community_messages_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_community_messages_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_community_messages_updated_at() TO service_role;


--
-- Name: FUNCTION update_garbage_alert_configs_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_garbage_alert_configs_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_garbage_alert_configs_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_garbage_alert_configs_updated_at() TO service_role;


--
-- Name: FUNCTION update_user_2fa_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_user_2fa_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_user_2fa_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_user_2fa_updated_at() TO service_role;


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
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


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
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


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
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


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
-- Name: TABLE amber_alerts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.amber_alerts TO anon;
GRANT ALL ON TABLE public.amber_alerts TO authenticated;
GRANT ALL ON TABLE public.amber_alerts TO service_role;


--
-- Name: TABLE before_after_videos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.before_after_videos TO anon;
GRANT ALL ON TABLE public.before_after_videos TO authenticated;
GRANT ALL ON TABLE public.before_after_videos TO service_role;


--
-- Name: TABLE community_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.community_messages TO anon;
GRANT ALL ON TABLE public.community_messages TO authenticated;
GRANT ALL ON TABLE public.community_messages TO service_role;


--
-- Name: TABLE garbage_alert_configs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.garbage_alert_configs TO anon;
GRANT ALL ON TABLE public.garbage_alert_configs TO authenticated;
GRANT ALL ON TABLE public.garbage_alert_configs TO service_role;


--
-- Name: TABLE garbage_bills; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.garbage_bills TO anon;
GRANT ALL ON TABLE public.garbage_bills TO authenticated;
GRANT ALL ON TABLE public.garbage_bills TO service_role;


--
-- Name: TABLE garbage_payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.garbage_payments TO anon;
GRANT ALL ON TABLE public.garbage_payments TO authenticated;
GRANT ALL ON TABLE public.garbage_payments TO service_role;


--
-- Name: TABLE generated_reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.generated_reports TO anon;
GRANT ALL ON TABLE public.generated_reports TO authenticated;
GRANT ALL ON TABLE public.generated_reports TO service_role;


--
-- Name: TABLE global_test_notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.global_test_notifications TO anon;
GRANT ALL ON TABLE public.global_test_notifications TO authenticated;
GRANT ALL ON TABLE public.global_test_notifications TO service_role;


--
-- Name: TABLE help_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.help_messages TO anon;
GRANT ALL ON TABLE public.help_messages TO authenticated;
GRANT ALL ON TABLE public.help_messages TO service_role;


--
-- Name: TABLE job_applications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.job_applications TO anon;
GRANT ALL ON TABLE public.job_applications TO authenticated;
GRANT ALL ON TABLE public.job_applications TO service_role;


--
-- Name: TABLE message_recipients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.message_recipients TO anon;
GRANT ALL ON TABLE public.message_recipients TO authenticated;
GRANT ALL ON TABLE public.message_recipients TO service_role;


--
-- Name: TABLE message_weekly_limits; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.message_weekly_limits TO anon;
GRANT ALL ON TABLE public.message_weekly_limits TO authenticated;
GRANT ALL ON TABLE public.message_weekly_limits TO service_role;


--
-- Name: TABLE panic_alerts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.panic_alerts TO anon;
GRANT ALL ON TABLE public.panic_alerts TO authenticated;
GRANT ALL ON TABLE public.panic_alerts TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE report_metrics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.report_metrics TO anon;
GRANT ALL ON TABLE public.report_metrics TO authenticated;
GRANT ALL ON TABLE public.report_metrics TO service_role;


--
-- Name: TABLE report_schedules; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.report_schedules TO anon;
GRANT ALL ON TABLE public.report_schedules TO authenticated;
GRANT ALL ON TABLE public.report_schedules TO service_role;


--
-- Name: TABLE reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reports TO anon;
GRANT ALL ON TABLE public.reports TO authenticated;
GRANT ALL ON TABLE public.reports TO service_role;


--
-- Name: TABLE user_2fa; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_2fa TO anon;
GRANT ALL ON TABLE public.user_2fa TO authenticated;
GRANT ALL ON TABLE public.user_2fa TO service_role;


--
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO anon;
GRANT ALL ON TABLE public.user_roles TO authenticated;
GRANT ALL ON TABLE public.user_roles TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2025_07_09; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_09 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_09 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_10; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_10 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_10 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_11; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_11 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_11 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_12; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_12 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_12 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_13; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_13 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_13 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_14; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_14 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_14 TO dashboard_user;


--
-- Name: TABLE messages_2025_07_15; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_15 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_15 TO dashboard_user;


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
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


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
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


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
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


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
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

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


