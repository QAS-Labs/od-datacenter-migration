\encoding UTF8

\set ON_ERROR_STOP on

\set AUTOCOMMIT on

-- manual 
-- generated
/*
select format('alter table public.%s add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;',table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='public'
    and table_type = 'BASE TABLE'
    and exists (    select 1 from information_schema.columns
                    where table_schema='public'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
alter table public.application_info add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.comment add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.coverage add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_view add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_query add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.explorer_token add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.ext_client add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.ext_system add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.note add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.pid_increment add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.plugin add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.resource add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.screen add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.screen_coverage add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.session add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.session_export add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.session_history add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.setting add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.system_info add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.timeline add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_setting add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;