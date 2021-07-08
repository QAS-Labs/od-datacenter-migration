\encoding UTF8

\set ON_ERROR_STOP on

\set clientid 10699,25502

set application_name to dba;

set work_mem='16GB';

\set AUTOCOMMIT on

\timing on

-- ANALYZE; -- for better execution plans

-- manual for insights

update insights.client_user_landing_page a
set userid = z.id
from public.users z
where z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.userid = z.fromid
and z.id != z.fromid;

update insights.defect_severities a
set projectids = tmp.projectids
from (
  select t.clientid, t.entrynumber, array_agg(z.id) as projectids
  from (select clientid, entrynumber, unnest(projectids) as projectid
    from insights.defect_severities
    where clientid IN (:clientid)) t
  inner join public.projects z on t.projectid = z.fromid
  where z.clientid IN (:clientid)
  and t.clientid = z.clientid
  and z.id != z.fromid
  group by t.clientid, t.entrynumber) tmp
where a.clientid = tmp.clientid
and a.entrynumber = tmp.entrynumber
and a.clientid IN (:clientid);

update insights.portfolio_unlinked_defect_projects a
set projectid = z.id
from public.projects z
where z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.projectid = z.fromid
and z.id != z.fromid;

update insights.client_colors a
set projectcts = tmp.projectcts
from (
  select t.clientid, array_agg(z.id) as projectcts
  from (select clientid, unnest(projectcts) as projectid
    from insights.client_colors
    where clientid IN (:clientid)) t
  inner join public.projects z on t.projectid = z.fromid
  where z.clientid IN (:clientid)
  and t.clientid = z.clientid
  and z.id != z.fromid
  group by t.clientid) tmp
where a.clientid = tmp.clientid
and a.clientid IN (:clientid);

update insights.portfolios a
set sitefieldid = z.id
from public.custom_fields z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.sitefieldid = z.fromid
and z.id != z.fromid;

update insights.portfolios a
set datefieldid = z.id
from public.custom_fields z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.datefieldid = z.fromid
and z.id != z.fromid;

update insights.report_lookup_t a
set projectid = z.id
from public.projects z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.projectid = z.fromid
and z.id != z.fromid;

update insights.report_lookup_t a
set customfieldid = z.id
from public.custom_fields z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.customfieldid = z.fromid
and z.id != z.fromid;

update insights.report_lookup_updates a
set projectid = z.id
from public.projects z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.projectid = z.fromid
and z.id != z.fromid;

update insights.report_lookup_updates a
set customfieldid = z.id
from public.custom_fields z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.customfieldid = z.fromid
and z.id != z.fromid;

update insights.defect_statuses a
set projectids = tmp.projectids
from (
  select t.clientid, t.entrynumber, array_agg(z.id) as projectids
  from (select clientid, entrynumber, unnest(projectids) as projectid
    from insights.defect_statuses
    where clientid IN (:clientid)) t
  inner join public.projects z on t.projectid = z.fromid
  where z.clientid IN (:clientid)
  and t.clientid = z.clientid
  and z.id != z.fromid
  group by t.clientid, t.entrynumber) tmp
where a.clientid = tmp.clientid
and a.entrynumber = tmp.entrynumber
and a.clientid IN (:clientid);

update insights.portfolio_thresholds a
set portfolioid = z.id
from insights.portfolios z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.portfolioid = z.fromid
and z.id != z.fromid;

update insights.portfolio_unlinked_defects a
set portfolioid = z.id
from insights.portfolios z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.portfolioid = z.fromid
and z.id != z.fromid;

update insights.portfolio_unlinked_defect_projects a
set portfoliounlinkeddefectid = z.id
from insights.portfolio_unlinked_defects z
where z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.portfoliounlinkeddefectid = z.fromid
and z.id != z.fromid;

update insights.rapiddashboardtasks a
set userid = z.id
from public.users z
where z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.userid = z.fromid
and z.id != z.fromid;

update insights.jira_report_fields a
set projectid = z.id
from public.projects z
where z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.projectid = z.fromid
and z.id != z.fromid;

update insights.user_banners a
set userid = z.id
from public.users z
where z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and a.userid = z.fromid
and z.id != z.fromid;

-- generated for insights
/*
select format('update insights.%s a
set %s = z.id
from insights.%s z
where a.%s = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid);',
tc.table_name,
kcu.column_name,
ccu.table_name,
kcu.column_name
)
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
where
constraint_type = 'FOREIGN KEY'
and tc.table_schema='insights'
and ccu.constraint_schema='insights'
and ccu.table_schema='insights'
and kcu.table_schema='insights'
and kcu.column_name!='clientid'
and tc.table_name not in ('dummy')
and exists (select 1 from information_schema.columns where table_schema='insights' and column_name='fromid' and table_name=ccu.table_name)
;
*/

-- NO FK


-- manual

update acl_object_identity a
set object_id_identity = z.id
from projects z
where a.object_id_identity = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;



-- copy to after update custom_fields (end of file)
/*
-- should run after custom_fields
update custom_field_configurations a
set valueid = z.id
from lookup z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and z.id != z.fromid;

-- inherrit case
update custom_field_configurations a
set valueid = z.id
from custom_fields z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and z.id != z.fromid;

update custom_field_configurations a
set value = z.id
from lookup z,
custom_fields cf
where a.value = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'defaultValue'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and z.id != z.fromid;

update custom_field_configurations a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from lookup z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and z.id != z.fromid;

-- inherit case
update custom_field_configurations a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from custom_fields z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and z.id != z.fromid;

update custom_field_configurations a
set value = regexp_replace(a.value,'^(.+):[[:digit:]]+$',concat('\1:',z.id))
from projects z,
custom_fields cf
where substring(a.value,'.+:([[:digit:]]+)$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and z.id != z.fromid;
*/

update clients a
set licenseblobid = z.id
from license_blob_handles z
where a.licenseblobid = z.fromid
and z.id != z.fromid
and a.id IN (:clientid)
and z.fromclientid IN (:clientid)
and a.id = z.fromclientid
;


create index if not exists idx_tmp_revision_info_fromid_id on revision_info(fromid, id) where fromid != id;
create index if not exists idx_tmp_users_fromid_id on users(fromid, id) where fromclientid IN (:clientid) and fromid != id;


update clients_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.id IN (:clientid)
and z.fromclientid IN (:clientid)
and a.id = z.fromclientid;

update test_cases a
set latestrunresultid = z.id
from test_case_run z
where a.latestrunresultid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_case_run_projectid on test_case_run(projectid) where fromclientid IN (:clientid);

create index if not exists idx_tmp_projects_fromid_id on projects(fromid,id) where fromid != id;

update test_case_run a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update defects a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.id != z.fromid
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_case_results_customfieldvalues on test_case_results(id,customfieldvalues) where clientid IN (:clientid) and customfieldvalues is not null;
drop table if exists ztmpclientmigration.test_case_results_customfieldvalues_mig1069925502;
create table ztmpclientmigration.test_case_results_customfieldvalues_mig1069925502 as
select tcr.id, concat('{',string_agg(concat_ws(':',concat('"',cf.id::text,'"'), json_data.value::text),','),'}') AS newvalue
from test_case_results tcr, json_each(tcr.customfieldvalues::json) AS json_data 
inner join custom_fields cf on cf.fromid = json_data.key::bigint
where
cf.clientid IN (:clientid)
and cf.fromclientid IN (:clientid)
and tcr.clientid IN (:clientid)
and cf.fromclientid = tcr.fromclientid
and tcr.customfieldvalues is not null
group by tcr.id;

drop index if exists idx_tmp_test_case_results_customfieldvalues;

update test_case_results
set customfieldvalues = t.newvalue
from ztmpclientmigration.test_case_results_customfieldvalues_mig1069925502 t
where
test_case_results.id = t.id
and test_case_results.clientid IN (:clientid);

/* temporarily skip for performance
create index if not exists idx_tmp_test_case_results_aud_customfieldvalues on test_case_results_aud(id,customfieldvalues) where clientid IN (:clientid) and customfieldvalues is not null;
drop table if exists ztmpclientmigration.test_case_results_aud_customfieldvalues_mig1069925502;
create table ztmpclientmigration.test_case_results_aud_customfieldvalues_mig1069925502 as
select tcr.id, tcr.rev, concat('{',string_agg(concat_ws(':',concat('"',cf.id::text,'"'), json_data.value::text),','),'}') AS newvalue
from test_case_results_aud tcr, json_each(tcr.customfieldvalues::json) AS json_data 
inner join custom_fields cf on cf.fromid = json_data.key::bigint
where
cf.clientid IN (:clientid)
and cf.fromclientid IN (:clientid)
and tcr.clientid IN (:clientid)
and cf.fromclientid = tcr.fromclientid
and tcr.customfieldvalues is not null
group by tcr.id, tcr.rev;

update test_case_results_aud
set customfieldvalues = t.newvalue
from ztmpclientmigration.test_case_results_aud_customfieldvalues_mig1069925502 t
where
test_case_results_aud.id = t.id and test_case_results_aud.rev = t.rev
and test_case_results_aud.clientid IN (:clientid);

drop index if exists idx_tmp_test_case_results_aud_customfieldvalues;
*/

/*
select concat('--', c.table_name, ', ', c.column_name),  c.table_name, c.column_name from information_schema.columns c
inner join information_schema.tables t on t.table_name = c.table_name
where c.table_schema = 'public' and t.table_schema = 'public'
  and column_name like '%id' and c.data_type = 'bigint'
    and t.table_name not like 'ztmp_%'
    and t.table_name not like 'sd_%'
    and t.table_name not like 'removed_%'
    and t.table_name not like 'stats_%'
    and t.table_type = 'BASE TABLE'
and  (c.table_name, c.column_name) not in (
select tc.table_name, kcu.column_name
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
where
constraint_type = 'FOREIGN KEY'
and tc.table_schema='public'
and kcu.table_schema='public'
)
and c.column_name not in ('trxid','oldid','pid','fromid','fromclientid','id','clientid')
order by table_name, column_name
*/

--across_report_field_mapping, objectid
--audit_log, objectid appname explorer_sessions,insights,parameters,pulse
--audit_log, projectid

update audit_log a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--audit_log, userid
update audit_log a
set userid = z.id
from users z
where a.userid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--automation_agents, clientagentid NONUPDATE
--automation_cancelled_executions, agentid
update automation_cancelled_executions a
set agentid = z.id
from automation_agents z
where a.agentid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--automation_cancelled_executions, objectid NULL
--automation_execution_results, agentid
update automation_execution_results a
set agentid = z.id
from automation_agents z
where a.agentid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--automation_execution_results, scheduleid
--automation_schedule_execution_maps, objectid 14
update automation_schedule_execution_maps a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttype = 14
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--automation_schedules, agentid
update automation_schedules a
set agentid = z.id
from automation_agents z
where a.agentid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--automation_status_mapping, projectid
update automation_status_mapping a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--blob_handles, minetypeid
--blob_handles, objectid

/*
  public static final String TEST_CASE_OBJECT_TYPE_ID = "1";
  public static final String REQUIREMENT_OBJECT_TYPE_ID = "2";
  public static final String DEFECT_OBJECT_TYPE_ID = "3";
  public static final String USER_OBJECT_TYPE_ID = "4";
  public static final String CLIENT_OBJECT_TYPE_ID = "5";
  public static final String TEST_STEP_OBJECT_TYPE_ID = "6";
  public static final String BUILD_OBJECT_TYPE_ID = "7";
  public static final String RELEASE_OBJECT_TYPE_ID = "8";
  public static final String MODULE_OBJECT_TYPE_ID = "9";
  public static final String TEST_CASE_RESULT_OBJECT_TYPE_ID = "10";
  public static final String TEST_CASE_IMPORT_TYPE_ID = "11";
  public static final String TEST_SUITE_OBJECT_TYPE_ID = "12";
  public static final String EXTERNAL_DEFECT_OBJECT_TYPE_ID = "13";
  public static final String TEST_CASE_RUN_OBJECT_TYPE_ID = "14";
  public static final String DEFECT_QUERY_OBJECT_TYPE_ID = "15";
  public static final String DATA_QUERY_OBJECT_TYPE_ID = "16";
  public static final String TEST_CYCLE_OBJECT_TYPE_ID = "17";
  public static final String LICENSE_OBJECT_TYPE_ID = "18";
  public static final String REQUIREMENT_IMPORT_TYPE_ID = "19";
  public static final String TEST_STEP_RESULT_OBJECT_TYPE_ID = "20";
  public static final String DEFECT_IMPORT_TYPE_ID = "21";
  public static final String AUTOMATION_EXECUTION_OBJECT_TYPE_ID = "30";
  public static final String SSO_IDP_METADATA_FILE_OBJECT_TYPE_ID = "31";
  public static final String REPORT_OBJECT_TYPE_ID = "69";
  public static final String SITE_CLIENT_BLOB_HANDLE_OBJECT_TYPE_ID = "70";
*/
create index if not exists idx_tmp_lookup_fromid_id on lookup(fromid, id) where clientid IN (:clientid) and fromid != id;

update blob_handles a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from defects z
where a.objectid = z.fromid
and a.objecttypeid = 3
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from test_steps z
where a.objectid = z.fromid
and a.objecttypeid = 6
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from builds z
where a.objectid = z.fromid
and a.objecttypeid = 7
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from releases z
where a.objectid = z.fromid
and a.objecttypeid = 8
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles a
set objectid = z.id
from test_case_results z
where a.objectid = z.fromid
and a.objecttypeid = 10
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--blob_handles, refreshid NOUPDATE
--blob_handles_aud, minetypeid
--blob_handles_aud, objectid
update blob_handles_aud a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from defects z
where a.objectid = z.fromid
and a.objecttypeid = 3
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from test_steps z
where a.objectid = z.fromid
and a.objecttypeid = 6
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from builds z
where a.objectid = z.fromid
and a.objecttypeid = 7
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from releases z
where a.objectid = z.fromid
and a.objecttypeid = 8
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update blob_handles_aud a
set objectid = z.id
from test_case_results z
where a.objectid = z.fromid
and a.objecttypeid = 10
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--blob_handles_aud, objecttypeid NOUPDATE
--blob_handles_aud, projectid
update blob_handles_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--blob_handles_aud, trxcreateduserid NOUPDATE
--blob_handles_aud, userid
update blob_handles_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--browser_hit_track, userid
update browser_hit_track a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--builds, buildstatusid NOUPDATE
--builds_aud, buildstatusid NOUPDATE
--builds_aud, creatorid
update builds_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--builds_aud, lastmodifieduserid
update builds_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--builds_aud, projectid
update builds_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--builds_aud, releaseid
update builds_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--builds_aud, trxcreateduserid NOUPDATE
--builds_aud, userid
update builds_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--ci_project_details, environment_id NOUPDATE
--ci_project_details, object_id NOUPDATE
--ci_project_details, test_suite_id NOUPDATE
--ci_project_suites, test_suite_id NOUPDATE
--client_jira_connection, systemid NOUPDATE
--client_licenses_aud, licensetypeid NOUPDATE
--combined_parameter_values, locationid?
--combined_parameter_values, locationtypeid?
--cron_log, refreshid NOUPDATE
--custom_field_configurations_aud, createduserid
update custom_field_configurations_aud a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_configurations_aud, customfieldid
update custom_field_configurations_aud a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_configurations_aud, projectid
update custom_field_configurations_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_configurations_aud, sitefieldconfigurationid
update custom_field_configurations_aud a
set sitefieldconfigurationid = z.id
from custom_field_configurations z
where a.sitefieldconfigurationid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
--custom_field_configurations_aud, trxcreateduserid NOUPDATE
--custom_field_configurations_aud, valueid
update custom_field_configurations_aud a
set valueid = z.id
from lookup z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
-- inherrit case
update custom_field_configurations_aud a
set valueid = z.id
from custom_fields z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_configurations_aud a
set value = z.id
from lookup z,
custom_fields cf
where a.value = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'defaultValue'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_configurations_aud a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from lookup z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
-- inherit case
update custom_field_configurations_aud a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from custom_fields z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, createduserid
update custom_fields_aud a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, datatypeid
update custom_fields_aud a
set datatypeid = z.id
from custom_field_data_types z
where a.datatypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, defecttrackingconnectionid
update custom_fields_aud a
set defecttrackingconnectionid = z.id
from defect_tracking_connection z
where a.defecttrackingconnectionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, integrationdefectfieldid
create index if not exists idx_tmp_custom_fields_aud_integrationdefectfieldid on custom_fields_aud(integrationdefectfieldid) where clientid IN (:clientid);
create index if not exists idx_tmp_integration_defect_fields_fromid_id on integration_defect_fields(fromid,id) where fromclientid IN (:clientid) and fromid != id;

update custom_fields_aud a
set integrationdefectfieldid = z.id
from integration_defect_fields z
where a.integrationdefectfieldid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, objecttypeid NOUPDATE
--custom_fields_aud, projectid
update custom_fields_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, sitefieldid
update custom_fields_aud a
set sitefieldid = z.id
from custom_fields z
where a.sitefieldid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_fields_aud, trxcreateduserid NOUPDATE
--custom_field_values, objectid
update custom_field_values a
set objectid = z.id
from test_cases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 1
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from requirements z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 2
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from defects z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 3
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from test_steps z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 6
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from builds z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 7
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from releases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 8
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values a
set objectid = z.id
from test_case_results z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 10
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_values_aud, objectid
update custom_field_values_aud a
set objectid = z.id
from test_cases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 1
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from requirements z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 2
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from defects z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 3
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from test_steps z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 6
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from builds z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 7
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from releases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 8
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_values_aud a
set objectid = z.id
from test_case_results z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 10
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_values_aud, customfieldid
update custom_field_values_aud a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_values_aud, projectid
update custom_field_values_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_values_aud, trxcreateduserid NOUPDATE
--custom_field_values_aud, userid
update custom_field_values_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and z.fromclientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--data_grid_views, objectid?
--defect_queries, createduserid
update defect_queries a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_queries, projectid
update defect_queries a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_query_clauses, projectid
update defect_query_clauses a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, affectedreleaseid
update defects a
set affectedreleaseid = z.id
from releases z
where a.affectedreleaseid = z.fromid
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, browserid NOUPDATE
--defects, categoryid
update defects a
set categoryid = z.id
from lookup z
where a.categoryid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, connectionid
update defects a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, environmentid
update defects a
set environmentid = z.id
from test_beds z
where a.environmentid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, envotherid NOUPDATE
--defects, fixedbuildid
update defects a
set fixedbuildid = z.id
from builds z
where a.fixedbuildid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, fixedreleaseid
update defects a
set fixedreleaseid = z.id
from releases z
where a.fixedreleaseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, osid NOUPDATE
--defects, previousstatusid
update defects a
set previousstatusid = z.id
from lookup z
where a.previousstatusid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, priorityid
update defects a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, projectid
update defects a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, reasonid
update defects a
set reasonid = z.id
from lookup z
where a.reasonid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, rootcauseid
update defects a
set rootcauseid = z.id
from lookup z
where a.rootcauseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, serverid NOUPDATE
--defects, severityid
update defects a
set severityid = z.id
from lookup z
where a.severityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, sourcedefectid
create index if not exists idx_tmp_defects_fromid_id on defects(fromid, id) where clientid IN (:clientid) and fromid != id;
create index if not exists idx_tmp_defects_sourcedefectid on defects(sourcedefectid) where clientid IN (:clientid);

update defects a
set sourcedefectid = z.id
from defects z
where a.sourcedefectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, statusid
update defects a
set statusid = z.id
from lookup z
where a.statusid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, targetbuildid
update defects a
set targetbuildid = z.id
from builds z
where a.targetbuildid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, targetreleaseid
update defects a
set targetreleaseid = z.id
from releases z
where a.targetreleaseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects, typeid
update defects a
set typeid = z.id
from lookup z
where a.typeid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, affectedbuildid
update defects a
set affectedbuildid = z.id
from builds z
where a.affectedbuildid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, affectedreleaseid
update defects_aud a
set affectedreleaseid = z.id
from releases z
where a.affectedreleaseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, assigneduserid
update defects_aud a
set assigneduserid = z.id
from users z
where a.assigneduserid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, browserid NOUPDATE
--defects_aud, categoryid
update defects_aud a
set categoryid = z.id
from lookup z
where a.categoryid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, connectionid
update defects_aud a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, createduserid
update defects_aud a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, creatorid
update defects_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, environmentid?
--defects_aud, envotherid NOUPDATE
--defects_aud, fixedbuildid
update defects_aud a
set fixedbuildid = z.id
from builds z
where a.fixedbuildid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, fixedreleaseid
update defects_aud a
set fixedreleaseid = z.id
from releases z
where a.fixedreleaseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, lastmodifieduserid
update defects_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, osid NOUPDATE
--defects_aud, previousstatusid
update defects_aud a
set previousstatusid = z.id
from lookup z
where a.previousstatusid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, priorityid
update defects_aud a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, projectid
update defects_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, projectmoduleid
create index if not exists idx_tmp_defects_aud_projectmoduleid on defects_aud(projectmoduleid) where clientid IN (:clientid);
create index if not exists idx_tmp_project_modules_fromid_id on project_modules(fromid, id) where clientid IN (:clientid) and fromid != id;

update defects_aud a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, reasonid
update defects_aud a
set reasonid = z.id
from lookup z
where a.reasonid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, rootcauseid
update defects_aud a
set rootcauseid = z.id
from lookup z
where a.rootcauseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, serverid NOUPDATE
--defects_aud, severityid
update defects_aud a
set severityid = z.id
from lookup z
where a.severityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;



create index if not exists idx_tmp_defects_aud_fromid_id on defects_aud(fromid, id) where clientid IN (:clientid) and fromid != id;
create index if not exists idx_tmp_defects_aud_sourcedefectid on defects_aud(sourcedefectid) where clientid IN (:clientid);

--defects_aud, sourcedefectid
update defects_aud a
set sourcedefectid = z.id
from defects z
where a.sourcedefectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, statusid
update defects_aud a
set statusid = z.id
from lookup z
where a.statusid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, targetbuildid
update defects_aud a
set targetbuildid = z.id
from builds z
where a.targetbuildid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, targetreleaseid
update defects_aud a
set targetreleaseid = z.id
from releases z
where a.targetreleaseid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, trxcreateduserid NOUPDATE
--defects_aud, typeid
update defects_aud a
set typeid = z.id
from lookup z
where a.typeid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defects_aud, userid
update defects_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_connection, defecttrackingsystemid NOUPDATE
--defect_tracking_connection, projectid
update defect_tracking_connection a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_connection_test, projectid
update defect_tracking_connection_test a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_field, projectid
update defect_tracking_field a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_project, projectid
update defect_tracking_project a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_type, projectid
update defect_tracking_type a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--defect_tracking_usage, projectid
update defect_tracking_usage a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--incidents, systemid NOUPDATE
--integration_defect_fields, integrationtypemapid
update integration_defect_fields a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.fromclientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
/*
--integration_issue_data_aud, integrationissuerequirementmapid
update integration_issue_data_aud a
set integrationissuerequirementmapid = z.id
from integration_issue_requirement_maps z
where a.integrationissuerequirementmapid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.id != z.fromid;
*/
--integration_issue_test_case_run_maps, connectionid
update integration_issue_test_case_run_maps a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_issue_test_case_run_maps, projectid
update integration_issue_test_case_run_maps a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_issue_test_case_run_maps, testrunid
update integration_issue_test_case_run_maps a
set testrunid = z.id
from test_case_run z
where a.testrunid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_jira_instance, featuretypeid NOUPDATE
--integration_sync_requirement_tracker, moduleid
update integration_sync_requirement_tracker a
set moduleid = z.id
from project_modules z
where a.moduleid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_sync_requirement_tracker, parentmoduleid
update integration_sync_requirement_tracker a
set parentmoduleid = z.id
from project_modules z
where a.parentmoduleid = z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_sync_requirement_tracker, projectid
update integration_sync_requirement_tracker a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_sync_requirement_tracker, requirementid
update integration_sync_requirement_tracker a
set requirementid = z.id
from requirements z
where a.requirementid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--integration_type_maps, qtesttypeid NOUPDATE
--lookup, projectid
update lookup a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--lookup_types, projectid
update lookup_types a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments, objectid
-- objectypeid 1,2,9,12,14 
update object_assignments a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments a
set objectid = z.id
from project_modules z
where a.objectid = z.fromid
and a.objecttypeid = 9
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments a
set objectid = z.id
from test_suites z
where a.objectid = z.fromid
and a.objecttypeid = 12
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

update object_assignments a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = 14
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments, priorityid
update object_assignments a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments_aud, objectid
-- objectypeid 1,2,9,12,14
update object_assignments_aud a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments_aud a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments_aud a
set objectid = z.id
from project_modules z
where a.objectid = z.fromid
and a.objecttypeid = 9
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments_aud a
set objectid = z.id
from test_suites z
where a.objectid = z.fromid
and a.objecttypeid = 12
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_assignments_aud a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = 14
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments_aud, objecttypeid NOUPDATE
--object_assignments_aud, priorityid
update object_assignments_aud a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments_aud, projectid
update object_assignments_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.clientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_assignments_aud, trxcreateduserid NOUPDATE
--object_assignments_aud, userid
update object_assignments_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and z.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_comments, objectid
-- objecttypeid 1,2,3,10,14
update object_comments a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments a
set objectid = z.id
from defects z
where a.objectid = z.fromid
and a.objecttypeid = 3
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments a
set objectid = z.id
from test_case_results z
where a.objectid = z.fromid
and a.objecttypeid = 10
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = 14
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_comments_aud, objectid
-- objecttypeid 1,2,3,10,14
update object_comments_aud a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = '1'
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments_aud a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = '2'
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments_aud a
set objectid = z.id
from defects z
where a.objectid = z.fromid
and a.objecttypeid = '3'
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments_aud a
set objectid = z.id
from test_case_results z
where a.objectid = z.fromid
and a.objecttypeid = '10'
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_comments_aud a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = '14'
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_comments_aud, projectid
update object_comments_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_comments_aud, trxcreateduserid NOUPDATE
--object_comments_aud, userid
update object_comments_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_links, aid ?
--object_links, bid ?
--object_subscribers, objectid
--objecttypeid 1,2,3,14
update object_subscribers a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_subscribers a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_subscribers a
set objectid = z.id
from defects z
where a.objectid = z.fromid
and a.objecttypeid = 3
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update object_subscribers a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = 14
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--object_tags, objectid NOUPDATE
--project_key_values, projectid
update project_key_values a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--project_modules_aud, creatorid
update project_modules_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--project_modules_aud, lastmodifieduserid
update project_modules_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--project_modules_aud, parentmoduleid
update project_modules_aud a
set parentmoduleid = z.id
from project_modules z
where a.parentmoduleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--project_modules_aud, projectid
update project_modules_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--project_modules_aud, trxcreateduserid NOUPDATE
--project_modules_aud, userid
update project_modules_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

/* not copied yet
update project_notification a
set actorid = z.id
from users z,
projects p
where a.actorid = z.fromid
and a.projectid = p.id
and p.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.id != z.fromid;*/
--project_notification, entityid ?
/*
0
1
2
3
4
5
8
9
13
14
17
*/

--projects, projectstatusid NOUPDATE
--projects, sourceprojectid
update projects a
set sourceprojectid = z.id
from projects z
where a.sourceprojectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--projects_aud, customfieldtemplateid
update projects_aud a
set customfieldtemplateid = z.id
from custom_field_templates z
where a.customfieldtemplateid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--projects_aud, projectstatusid NOUPDATE
--projects_aud, sourceprojectid
update projects_aud a
set sourceprojectid = z.id
from projects z
where a.sourceprojectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--projects_aud, trxcreateduserid NOUPDATE
--queue_event, projectid
update queue_event a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--queue_event, userid
update queue_event a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--recycle_actions, objectid
--objecttypeid 1 2 7 8 9 12 14 17
update recycle_actions a
set objectid = z.id
from test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from builds z
where a.objectid = z.fromid
and a.objecttypeid = 7
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from releases z
where a.objectid = z.fromid
and a.objecttypeid = 8
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from project_modules z
where a.objectid = z.fromid
and a.objecttypeid = 9
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from test_suites z
where a.objectid = z.fromid
and a.objecttypeid = 12
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from test_case_run z
where a.objectid = z.fromid
and a.objecttypeid = 14
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update recycle_actions a
set objectid = z.id
from test_cycles z
where a.objectid = z.fromid
and a.objecttypeid = 17
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--recycle_actions, projectid
update recycle_actions a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--recycle_related_actions, objectid
--objecttypeid 1 2 7 9 14 17
update recycle_related_actions a
set objectid = z.id
from test_cases z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 1
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;
update recycle_related_actions a
set objectid = z.id
from requirements z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 2
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;
update recycle_related_actions a
set objectid = z.id
from builds z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 7
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;
update recycle_related_actions a
set objectid = z.id
from project_modules z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 9
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;
update recycle_related_actions a
set objectid = z.id
from test_case_run z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 14
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;
update recycle_related_actions a
set objectid = z.id
from test_cycles z,
recycle_actions ra
where a.objectid = z.fromid
and a.parentactionid = ra.id
and a.objecttypeid = 17
and z.clientid IN (:clientid)
and ra.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
-- tmp and a.fromclientid IN (:clientid)
and z.id != z.fromid;

--releases, modifieduserid NOT USED -- lastmodifieduserid
-- select * from releases where modifieduserid is not null and modifieduserid > 2 and  modifieduserid != lastmodifieduserid
--releases_aud, lastmodifieduserid
update releases_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--releases_aud, modifieduserid -- lastmodifieduserid
--releases_aud, projectid
update releases_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--releases_aud, releasestatusid NOUPDATE
--releases_aud, trxcreateduserid NOUPDATE
--releases_aud, userid
update releases_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;


--request_execution_time, projectid
update request_execution_time a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--request_execution_time, userid
update request_execution_time a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data, projectid
update requirement_link_data a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data_aud, buildid
update requirement_link_data_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data_aud, projectid
update requirement_link_data_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data_aud, releaseid
update requirement_link_data_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data_aud, requirementid
update requirement_link_data_aud a
set requirementid = z.id
from requirements z
where a.requirementid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirement_link_data_aud, trxcreateduserid NOUPDATE
--requirements, buildid
--requirements, requirementpriorityid
create index if not exists idx_tmp_requirements_requirementpriorityid on requirements(requirementpriorityid) where clientid IN (:clientid);
update requirements a
set requirementpriorityid = z.id
from lookup z
where a.requirementpriorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements, requirementtypeid
update requirements a
set requirementtypeid = z.id
from lookup z
where a.requirementtypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements, statusid
update requirements a
set statusid = z.id
from lookup z
where a.statusid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, buildid
update requirements_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, creatorid
update requirements_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, lastmodifieduserid
update requirements_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, projectid
update requirements_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, projectmoduleid
update requirements_aud a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, releaseid
update requirements_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, requirementpriorityid
update requirements_aud a
set requirementpriorityid = z.id
from lookup z
where a.requirementpriorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, requirementtypeid
update requirements_aud a
set requirementtypeid = z.id
from lookup z
where a.requirementtypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, statusid
update requirements_aud a
set statusid = z.id
from lookup z
where a.statusid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--requirements_aud, trxcreateduserid NOUPDATE
--requirements_aud, userid
update requirements_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--revision_aware, objectid?
--revision_info, projectid
update revision_info a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--revision_info, userid
update revision_info a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--scenario_status_mapping, projectid
update scenario_status_mapping a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--search_tasks, objectid?
--task_execution_time, projectid
update task_execution_time a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--task_execution_time, userid
update task_execution_time a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_agents, agentid?
--test_case_agents, projectid
update test_case_agents a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
--test_case_agents, testcaseid
update test_case_agents a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
--test_case_result_defects, integrationconnectionid
update test_case_result_defects a
set integrationconnectionid = z.id
from defect_tracking_connection z
where a.integrationconnectionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_result_defects, projectid
update test_case_result_defects a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_result_defects, resultid
update test_case_result_defects a
set resultid = z.id
from test_case_results z
where a.resultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_result_defects, testcaseid
update test_case_result_defects a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_result_defects, testcaserunid
update test_case_result_defects a
set testcaserunid = z.id
from test_case_run z
where a.testcaserunid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_result_defects, testcaseversionid
update test_case_result_defects a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results, assigneduserid
update test_case_results a
set assigneduserid = z.id
from users z
where a.assigneduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results, configurationid
update test_case_results a
set configurationid = z.id
from test_case_versions z
where a.configurationid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results, executiontypeid NOUPDATE
--test_case_results, testcaseid
update test_case_results a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results, testexecutionresultid
update test_case_results a
set testexecutionresultid = z.id
from lookup z
where a.testexecutionresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results, userid
update test_case_results a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, assigneduserid
update test_case_results_aud a
set assigneduserid = z.id
from users z
where a.assigneduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, buildid
update test_case_results_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, configurationid
update test_case_results_aud a
set configurationid = z.id
from configurations z
where a.configurationid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, executiontypeid NOUPDATE
--test_case_results_aud, projectid
update test_case_results_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, releaseid
update test_case_results_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, testcaseid
update test_case_results_aud a
set testcaseid = z.id
from releases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

--test_case_results_aud, testcaserunid
create index if not exists idx_tmp_test_case_run_fromid_id on test_case_run(fromid, id) where clientid IN (:clientid) and fromid != id;
create index if not exists idx_tmp_test_case_results_aud_testcaserunid on test_case_results_aud(testcaserunid) where clientid IN (:clientid);
update test_case_results_aud a
set testcaserunid = z.id
from test_case_run z
where a.testcaserunid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, testcaseversionid
update test_case_results_aud a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, testdatasetid
update test_case_results_aud a
set testdatasetid = z.id
from test_data_sets z
where a.testdatasetid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, testexecutionresultid
update test_case_results_aud a
set testexecutionresultid = z.id
from lookup z
where a.testexecutionresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_results_aud, trxcreateduserid NOUPDATE
--test_case_results_aud, userid
update test_case_results_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run, latesttestcaseresultid
update test_case_run a
set latesttestcaseresultid = z.id
from test_case_results z
where a.latesttestcaseresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run, priorityid
update test_case_run a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run, projectid
update test_case_run a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run, projecttesttypeid
update test_case_run a
set projecttesttypeid = z.id
from lookup z
where a.projecttesttypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run, userid
update test_case_run a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, buildid
update test_case_run_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, configurationid
update test_case_run_aud a
set configurationid = z.id
from configurations z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, creatorid
update test_case_run_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, lastmodifieduserid
update test_case_run_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, latesttestcaseresultid
update test_case_run_aud a
set latesttestcaseresultid = z.id
from test_case_results z
where a.latesttestcaseresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, latesttestexecutionresultid
update test_case_run_aud a
set latesttestexecutionresultid = z.id
from lookup z
where a.latesttestexecutionresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, priorityid
update test_case_run_aud a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, projectid
update test_case_run_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, projecttesttypeid
update test_case_run_aud a
set projecttesttypeid = z.id
from lookup z
where a.projecttesttypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, releaseid
update test_case_run_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, testbedid
update test_case_run_aud a
set testbedid = z.id
from test_beds z
where a.testbedid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, testcaseid
update test_case_run_aud a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, testcaseversionid
update test_case_run_aud a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, testcycleid
update test_case_run_aud a
set testcycleid = z.id
from test_cycles z
where a.testcycleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, testsuiteid
update test_case_run_aud a
set testsuiteid = z.id
from test_suites z
where a.testsuiteid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_run_aud, trxcreateduserid NOUPDATE
--test_case_run_aud, userid
update test_case_run_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases, automationid?
--test_cases, latestrunresultid
update test_cases a
set latestrunresultid = z.id
from test_case_results z
where a.latestrunresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases, latesttestcaseversionid
update test_cases a
set latesttestcaseversionid = z.id
from test_case_versions z
where a.latesttestcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases, priorityid
update test_cases a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases, testcasetypeid
update test_cases a
set testcasetypeid = z.id
from lookup z
where a.testcasetypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, automationid?
--test_cases_aud, creatorid
update test_cases_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, lastmodifieduserid
update test_cases_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, latesttestcaseversionid
update test_cases_aud a
set latesttestcaseversionid = z.id
from test_case_versions z
where a.latesttestcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, priorityid
update test_cases_aud a
set priorityid = z.id
from lookup z
where a.priorityid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, projectid
update test_cases_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, projectmoduleid
update test_cases_aud a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, testcasetypeid
update test_cases_aud a
set testcasetypeid = z.id
from lookup z
where a.testcasetypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cases_aud, trxcreateduserid NOUPDATE
--test_cases_aud, userid
update test_cases_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions, modifieduserid
update test_case_versions a
set modifieduserid = z.id
from users z
where a.modifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions, testcaseversionstatusid
update test_case_versions a
set testcaseversionstatusid = z.id
from lookup z
where a.testcaseversionstatusid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions_aud, projectid
update test_case_versions_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions_aud, testcaseid
update test_case_versions_aud a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions_aud, testcaseversionstatusid
update test_case_versions_aud a
set testcaseversionstatusid = z.id
from lookup z
where a.testcaseversionstatusid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_case_versions_aud, trxcreateduserid NOUPDATE
--test_case_versions_aud, userid
update test_case_versions_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles, parenttestcycleid
update test_cycles a
set parenttestcycleid = z.id
from test_cycles z
where a.parenttestcycleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, buildid
update test_cycles_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, creatorid
update test_cycles_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, lastmodifieduserid
update test_cycles_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, parenttestcycleid
update test_cycles_aud a
set parenttestcycleid = z.id
from test_cycles z
where a.parenttestcycleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, projectid
update test_cycles_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, releaseid
update test_cycles_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_cycles_aud, trxcreateduserid NOUPDATE
--test_cycles_aud, userid
update test_cycles_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_parameters_aud, teststepid
update test_step_parameters_aud a
set teststepid = z.id
from test_steps z
where a.teststepid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_parameters_aud, trxcreateduserid NOUPDATE
--test_step_result_defects, defecttrackingconnectionid
update test_step_result_defects a
set defecttrackingconnectionid = z.id
from defect_tracking_connection z
where a.defecttrackingconnectionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, calledtestcaseid
update test_step_results a
set calledtestcaseid = z.id
from test_cases z
where a.calledtestcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, testcaseid
update test_step_results a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, testcaserunid
update test_step_results a
set testcaserunid = z.id
from test_case_run z
where a.testcaserunid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, testcaseversionid
update test_step_results a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, testexecutionresultid
update test_step_results a
set testexecutionresultid = z.id
from lookup z
where a.testexecutionresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results, userid
update test_step_results a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, calledtestcaseid
update test_step_results_aud a
set calledtestcaseid = z.id
from test_cases z
where a.calledtestcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, testcaseid
update test_step_results_aud a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, testcaseresultid
update test_step_results_aud a
set testcaseresultid = z.id
from lookup z
where a.testcaseresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, testcaserunid
update test_step_results_aud a
set testcaserunid = z.id
from test_case_run z
where a.testcaserunid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, testcaseversionid
update test_step_results_aud a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, testexecutionresultid
update test_step_results_aud a
set testexecutionresultid = z.id
from lookup z
where a.testexecutionresultid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, teststepid
create index if not exists idx_tmp_test_step_results_aud_teststepid on test_step_results_aud(teststepid) where clientid IN (:clientid);

update test_step_results_aud a
set teststepid = z.id
from test_case_versions z
where a.teststepid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_step_results_aud, userid
update test_step_results_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_aud, projectid
update test_steps_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_aud, runtestcaseversionid
create index if not exists idx_tmp_test_steps_aud_runtestcaseversionid on test_steps_aud(runtestcaseversionid) where clientid IN (:clientid);

update test_steps_aud a
set runtestcaseversionid = z.id
from test_case_versions z
where a.runtestcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_aud, testcaseversionid
create index if not exists idx_tmp_test_steps_aud_testcaseversionid on test_steps_aud(testcaseversionid) where clientid IN (:clientid);

update test_steps_aud a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_aud, trxcreateduserid NOUPDATE
--test_steps_aud, userid
update test_steps_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_test_cases_aud, calledtestcaseid
update test_steps_test_cases_aud a
set calledtestcaseid = z.id
from test_cases z
where a.calledtestcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_test_cases_aud, projectid
update test_steps_test_cases_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_test_cases_aud, testcaseid
update test_steps_test_cases_aud a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_test_cases_aud, teststepid
update test_steps_test_cases_aud a
set teststepid = z.id
from test_steps z
where a.teststepid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_steps_test_cases_aud, trxcreateduserid NOUPDATE
--test_steps_test_cases_aud, userid
update test_steps_test_cases_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites, modifieduserid
update test_suites a
set modifieduserid = z.id
from users z
where a.modifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites, projecttesttypeid
update test_suites a
set projecttesttypeid = z.id
from lookup z
where a.projecttesttypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, buildid
update test_suites_aud a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, creatorid
update test_suites_aud a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, lastmodifieduserid
update test_suites_aud a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, projectid
update test_suites_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, projecttesttypeid
update test_suites_aud a
set projecttesttypeid = z.id
from lookup z
where a.projecttesttypeid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, releaseid
update test_suites_aud a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, testbedid
update test_suites_aud a
set testbedid = z.id
from test_beds z
where a.testbedid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, testcycleid
update test_suites_aud a
set testcycleid = z.id
from test_cycles z
where a.testcycleid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, testdatasetid
update test_suites_aud a
set testdatasetid = z.id
from test_data_sets z
where a.testdatasetid = z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--test_suites_aud, trxcreateduserid NOUPDATE
--test_suites_aud, userid
update test_suites_aud a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--user_ext, latestannouncementid?
--user_group_authorities_aud, authorityid NOUPDATE
--user_group_authorities_aud, usergroupid
update user_group_authorities_aud a
set usergroupid = z.id
from user_groups z
where a.usergroupid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
--user_group_members_aud, clientuserid
update user_group_members_aud a
set clientuserid = z.id
from client_users z
where a.clientuserid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
--user_group_members_aud, usergroupid
update user_group_members_aud a
set usergroupid = z.id
from user_groups z
where a.usergroupid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
--user_unique_id, projectid
update user_unique_id a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
--user_unique_id, userid
update user_unique_id a
set userid = z.id
from users z
where a.userid = z.fromid
and a.clientid IN (:clientid)
and z.fromclientid IN (:clientid)
and z.id != z.fromid
and a.fromclientid = z.fromclientid;

--data_grid_view_fields, viewid
update data_grid_view_fields a
set viewid = z.id
from data_grid_views z
where a.viewid = z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

--data_grid_view_fields, fieldid
update data_grid_view_fields a
set fieldid = z.id
from custom_fields z
where a.fieldid = z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

-- generated 
/*
select format('update %s a
set %s = z.id
from %s z
where a.%s = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid);',
tc.table_name,
kcu.column_name,
ccu.table_name,
kcu.column_name
)
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
where
constraint_type = 'FOREIGN KEY'
and tc.table_schema='public'
and ccu.constraint_schema='public'
and ccu.table_schema='public'
and kcu.table_schema='public'
and kcu.column_name!='clientid'
and kcu.column_name not in ('username')
and tc.table_name not in ('clients','clients_aud','automation_execution_results','client_user_ext','automation_schedules','ci_project_details','configuration_label','configuration_variable_values','custom_field_validations','data_grid_view_fields','data_query_clauses','external_defect_lookup','feature_test_case_map','incident_fields','integration_issue_data_aud','oauth_access_tokens','oauth_refresh_tokens','password_history','project_notification','recipients','recipient_types','report_schedules','scenario_project','templates','test_case_sharings','time_tracking_settings')
and tc.table_name not like 'across_%'
and exists (select 1 from information_schema.columns where table_schema='public' and column_name='fromid' and table_name=ccu.table_name)
;
*/

create index if not exists idx_tmp_acl_entry_sid on acl_entry(sid) where fromclientid IN (:clientid);


update acl_entry a
set sid = z.id
from acl_sid z
where a.sid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_acl_object_identity_fromid_id on acl_object_identity(fromid, id) where fromclientid IN (:clientid) and fromid != id;
create index if not exists idx_tmp_acl_entry_acl_object_identity on acl_entry(acl_object_identity) where fromclientid IN (:clientid);

update acl_entry a
set acl_object_identity = z.id
from acl_object_identity z
where a.acl_object_identity = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update acl_object_identity a
set owner_sid = z.id
from acl_sid z
where a.owner_sid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update acl_object_identity a
set parent_object = z.id
from acl_object_identity z
where a.parent_object = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update automation_agents a
set hostid = z.id
from automation_hosts z
where a.hostid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update automation_agents a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update automation_parsers a
set parserblobhandleid = z.id
from blob_handles z
where a.parserblobhandleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update automation_upgrade_logs a
set hostid = z.id
from automation_hosts z
where a.hostid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update automation_upgrade_logs a
set upgradelogblobhandleid = z.id
from blob_handles z
where a.upgradelogblobhandleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update automation_upgrade_logs a
set scheduledby = z.id
from users z
where a.scheduledby = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update blob_handles a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update blob_handles a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_blob_handles_aud_rev on blob_handles_aud(rev) where fromclientid IN (:clientid);

update blob_handles_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update builds a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update builds a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update builds a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update builds a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update builds_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update client_licenses_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


update client_users a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update client_users a
set externalauthconfigid = z.id
from external_auth_system_config z
where a.externalauthconfigid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update client_user_sec_profiles a
set clientuserid = z.id
from client_users z
where a.clientuserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update client_user_sec_profiles a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update client_user_sec_profiles a
set securityprofileid = z.id
from security_profiles z
where a.securityprofileid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update client_user_settings a
set clientuserid = z.id
from client_users z
where a.clientuserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update combined_parameter_values a
set testrunid = z.id
from test_case_run z
where a.testrunid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update combined_parameter_values a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update combined_parameter_values a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update configurations a
set setid = z.id
from configuration_sets z
where a.setid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


update custom_field_configurations a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_field_configurations a
set sitefieldconfigurationid = z.id
from custom_field_configurations z
where a.sitefieldconfigurationid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_field_configurations_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_field_data_types a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields a
set integrationdefectfieldid = z.id
from integration_defect_fields z
where a.integrationdefectfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields a
set defecttrackingconnectionid = z.id
from defect_tracking_connection z
where a.defecttrackingconnectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields a
set sitefieldid = z.id
from custom_fields z
where a.sitefieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields a
set datatypeid = z.id
from custom_field_data_types z
where a.datatypeid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_fields_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_field_template_field_mapping a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update custom_field_template_field_mapping a
set templateid = z.id
from custom_field_templates z
where a.templateid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update custom_field_validators a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


create index if not exists idx_tmp_custom_field_values_customfieldid on custom_field_values(customfieldid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_custom_fields_fromid_id on custom_fields(fromid,id) where fromid != id;

update custom_field_values a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_custom_field_values_fromid_id on custom_field_values(fromid,id) where fromid != id;

update custom_field_values_aud a
set id = z.id
from custom_field_values z
where a.id = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update data_grid_views a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update data_grid_views a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update data_queries a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update data_queries a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update data_query_conditions a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update data_query_operators a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_query_clauses a
set defectqueryid = z.id
from defect_queries z
where a.defectqueryid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_defects_projectmoduleid on defects(projectmoduleid) where fromclientid IN (:clientid);

update defects a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and z.clientid IN (:clientid)
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defects a
set assigneduserid = z.id
from users z
where a.assigneduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defects a
set createduserid = z.id
from users z
where a.createduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defects a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defects a
set affectedbuildid = z.id
from builds z
where a.affectedbuildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defects_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_connection a
set clientjiraconnectionid = z.id
from client_jira_connection z
where a.clientjiraconnectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_field a
set defecttrackingtypeid = z.id
from defect_tracking_type z
where a.defecttrackingtypeid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_field a
set defecttrackingprojectid = z.id
from defect_tracking_project z
where a.defecttrackingprojectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_project a
set defecttrackingconnectionid = z.id
from defect_tracking_connection z
where a.defecttrackingconnectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_type a
set defecttrackingconnectionid = z.id
from defect_tracking_connection z
where a.defecttrackingconnectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_tracking_type a
set integrationprojectid = z.id
from defect_tracking_project z
where a.integrationprojectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set transitionid = z.id
from defect_workflow_transition z
where a.transitionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_profile a
set userprofileid = z.id
from security_profiles z
where a.userprofileid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set tostatus = z.id
from lookup z
where a.tostatus = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set fromstatus = z.id
from lookup z
where a.fromstatus = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set transitionid = z.id
from defect_workflow_transition z
where a.transitionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update defect_workflow_transition_status a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update external_client_user a
set externalauthsystemconfigid = z.id
from external_auth_system_config z
where a.externalauthsystemconfigid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update external_client_user a
set mapto = z.id
from users z
where a.mapto = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


update group_authorities a
set groupid = z.id
from groups z
where a.groupid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update group_members a
set groupid = z.id
from groups z
where a.groupid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update group_members a
set clientuserid = z.id
from client_users z
where a.clientuserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update incidents a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update insights_token a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_defect_field_maps a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update custom_field_configurations a
set integrationcustomfieldconfigurationid = z.id
from integration_custom_field_configurations z
where a.integrationcustomfieldconfigurationid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.clientid;

update integration_custom_field_data_types a
set customfielddatatypeid = z.id
from custom_field_data_types z
where a.customfielddatatypeid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;

update integration_custom_fields a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
update integration_custom_fields a
set integrationdatatypeid = z.id
from integration_custom_field_data_types z
where a.integrationdatatypeid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
update integration_custom_fields a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;

update integration_custom_field_configurations a
set integrationcustomfieldid = z.id
from integration_custom_fields z
where a.integrationcustomfieldid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
--  valueid from Jira => no change

update custom_field_integration_values a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

--custom_field_integration_values, objectid
update custom_field_integration_values a
set objectid = z.id
from test_cases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 1
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from requirements z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 2
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from defects z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 3
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from test_steps z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 6
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from builds z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 7
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from releases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 8
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values a
set objectid = z.id
from test_case_results z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 10
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
--custom_field_values_aud, objectid
update custom_field_integration_values_aud a
set objectid = z.id
from test_cases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 1
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from requirements z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 2
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from defects z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 3
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from test_steps z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 6
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from builds z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 7
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from releases z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 8
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;
update custom_field_integration_values_aud a
set objectid = z.id
from test_case_results z,
custom_fields cf
where a.objectid = z.fromid
and a.customfieldid = cf.id
and cf.objecttypeid = 10
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

create index if not exists idx_tmp_integration_defect_issue_data_testcaseresultdefectid on integration_defect_issue_data(testcaseresultdefectid) where fromclientid IN (:clientid);

update integration_defect_issue_data a
set testcaseresultdefectid = z.id
from test_case_result_defects z
where a.testcaseresultdefectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_integration_defect_issue_data_projectid on integration_defect_issue_data(projectid) where fromclientid IN (:clientid);

update integration_defect_issue_data a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_integration_external_defect_issue_data_projectid on integration_external_defect_issue_data(projectid) where fromclientid IN (:clientid);

update integration_external_defect_issue_data a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_integration_external_defect_issue_data_defectid on integration_external_defect_issue_data(defectid) where fromclientid IN (:clientid);

update integration_external_defect_issue_data a
set defectid = z.id
from defects z
where a.defectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_external_issues a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_external_issues a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_external_issues_maps a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_external_issues_maps a
set toexternalissueid = z.id
from integration_external_issues z
where a.toexternalissueid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_external_issues_maps a
set fromexternalissueid = z.id
from integration_external_issues z
where a.fromexternalissueid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_identifier_fields a
set id = z.id
from defect_tracking_connection z
where a.id = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_integration_issue_data_integrationissuerequirementmapid on integration_issue_data(integrationissuerequirementmapid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_integration_issue_requirement_maps_fromid_id on integration_issue_requirement_maps(fromid,id) where fromid != id;

update integration_issue_data a
set integrationissuerequirementmapid = z.id
from integration_issue_requirement_maps z
where a.integrationissuerequirementmapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update integration_issue_release_maps a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_release_maps a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_release_maps a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_requirement_maps a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_integration_issue_requirement_maps_requirementid on integration_issue_requirement_maps(requirementid) where fromclientid IN (:clientid);


update integration_issue_requirement_maps a
set requirementid = z.id
from requirements z
where a.requirementid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_requirement_maps a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_test_case_maps a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_test_case_maps a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_issue_test_case_maps a
set externalissueid = z.id
from integration_external_issues z
where a.externalissueid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_module_fields a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_projects a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_release_configuration a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_release_data a
set integrationissuereleasemapid = z.id
from integration_issue_release_maps z
where a.integrationissuereleasemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_requirement_field_maps a
set integrationtypemapid = z.id
from integration_type_maps z
where a.integrationtypemapid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_type_maps a
set integrationprojectid = z.id
from integration_projects z
where a.integrationprojectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_webhooks a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update integration_webhooks a
set id = z.id
from defect_tracking_connection z
where a.id = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update lookup a
set lookuptypeid = z.id
from lookup_types z
where a.lookuptypeid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update oauth_authentications a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update object_assignments a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_assignments a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_assignments_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_comments a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_comments a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_comments_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_links a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_subscribers a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update object_subscribers a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


update project_modules a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update project_modules a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update project_modules a
set parentmoduleid = z.id
from project_modules z
where a.parentmoduleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update project_modules a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update project_modules_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update projects a
set customfieldtemplateid = z.id
from custom_field_templates z
where a.customfieldtemplateid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update projects_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update project_settings a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update queue_processing_state a
set createdby = z.id
from users z
where a.createdby = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update recycle_actions a
set deletedby = z.id
from users z
where a.deletedby = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update releases a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update releases a
set releasestatusid = z.id
from lookup z
where a.releasestatusid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update releases a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update releases a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update releases_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update report_settings a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update report_settings a
set reportid = z.id
from reports z
where a.reportid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirement_link_data a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirement_link_data a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirement_link_data a
set requirementid = z.id
from requirements z
where a.requirementid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirement_link_data_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_requirements_projectmoduleid on requirements(projectmoduleid) where fromclientid IN (:clientid);
update requirements a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and z.id != z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirements a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirements a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirements a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirements a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update requirements_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_requirement_test_cases_testcaseid on requirement_test_cases(testcaseid) where fromclientid IN (:clientid);

create index if not exists idx_tmp_requirements_fromid_id on requirements(fromid, id) where clientid IN (:clientid) and fromid != id;

update requirement_test_cases a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_requirement_test_cases_requirementid on requirement_test_cases(requirementid) where fromclientid IN (:clientid);

update requirement_test_cases a
set requirementid = z.id
from requirements z
where a.requirementid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update revision_aware a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update revision_aware a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update revision_aware a
set revid = z.id
from revision_info z
where a.revid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update search_tasks a
set customfieldid = z.id
from custom_fields z
where a.customfieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update search_tasks a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update test_beds a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_result_defects a
set defectid = z.id
from defects z
where a.defectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_case_results_testcaseversionid on test_case_results(testcaseversionid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_case_results_testcaserunid on test_case_results(testcaserunid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_case_versions_fromid_id on test_case_versions(fromid, id) where clientid IN (:clientid) and fromid != id;
create index if not exists idx_tmp_test_case_results_aud_rev on test_case_results_aud(rev) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_case_run_testcaseversionid on test_case_run(testcaseversionid) where fromclientid IN (:clientid);

update test_case_results a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update test_case_results a
set testdatasetid = z.id
from test_data_sets z
where a.testdatasetid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_results a
set testcaserunid = z.id
from test_case_run z
where a.testcaserunid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_results_releaseid on test_case_results(releaseid) where fromclientid IN (:clientid);

update test_case_results a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_results_buildid on test_case_results(buildid) where fromclientid IN (:clientid);

update test_case_results a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_results_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_case_run_testsuiteid on test_case_run(testsuiteid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_suites_fromid_id on test_suites(fromid,id) where fromid != id;

update test_case_run a
set testsuiteid = z.id
from test_suites z
where a.testsuiteid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_run_testcycleid on test_case_run(testcycleid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_cycles_fromid_id on test_cycles(fromid, id) where fromid != id;

update test_case_run a
set testcycleid = z.id
from test_cycles z
where a.testcycleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update test_case_run a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and z.id != z.fromid
and z.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_case_run_testcaseid on test_case_run(testcaseid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_cases_fromid_id on test_cases(fromid, id) where clientid IN (:clientid) and fromid != id;


update test_case_run a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_run a
set testbedid = z.id
from test_beds z
where a.testbedid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_run_releaseid on test_case_run(releaseid) where fromclientid IN (:clientid);

update test_case_run a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_run a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_run a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_run a
set configurationid = z.id
from configurations z
where a.configurationid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_run_buildid on test_case_run(buildid) where fromclientid IN (:clientid);
update test_case_run a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_run_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cases a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_cases_projectmoduleid on test_cases(projectmoduleid) where fromclientid IN (:clientid);
update test_cases a
set projectmoduleid = z.id
from project_modules z
where a.projectmoduleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update test_cases a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cases a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cases_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_case_versions_testcaseid on test_case_versions(testcaseid) where fromclientid IN (:clientid);


update test_case_versions a
set testcaseid = z.id
from test_cases z
where a.testcaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_case_versions_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_cycles_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_data_sets a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_parameters a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameters a
set teststepid = z.id
from test_steps z
where a.teststepid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameters a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameters_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameters_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameter_values a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameter_values a
set testrunid = z.id
from test_case_run z
where a.testrunid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_parameter_values a
set teststepparameterid = z.id
from test_step_parameters z
where a.teststepparameterid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_result_defects a
set teststepresultid = z.id
from test_step_results z
where a.teststepresultid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_step_result_defects a
set defectid = z.id
from defects z
where a.defectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_step_results_testcaseresultid on test_step_results(testcaseresultid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_case_results_fromid_id on test_case_results(fromid, id) where clientid IN (:clientid) and fromid != id;

update test_step_results a
set testcaseresultid = z.id
from test_case_results z
where a.testcaseresultid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_step_results_teststepid on test_step_results(teststepid) where fromclientid IN (:clientid);
create index if not exists idx_tmp_test_steps_fromid_id on test_steps(fromid, id) where clientid IN (:clientid) and fromid != id;

update test_step_results a
set teststepid = z.id
from test_steps z
where a.teststepid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_step_results_aud_rev on test_step_results_aud(rev) where fromclientid IN (:clientid);
update test_step_results_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
create index if not exists idx_tmp_test_steps_runtestcaseversionid on test_steps(runtestcaseversionid) where fromclientid IN (:clientid);

update test_steps a
set runtestcaseversionid = z.id
from test_case_versions z
where a.runtestcaseversionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_steps_testcaseversionid on test_steps(testcaseversionid) where fromclientid IN (:clientid);

update test_steps a
set testcaseversionid = z.id
from test_case_versions z
where a.testcaseversionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_test_steps_aud_rev on test_steps_aud(rev) where fromclientid IN (:clientid);
update test_steps_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update test_steps_test_cases_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set creatorid = z.id
from users z
where a.creatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set testdatasetid = z.id
from test_data_sets z
where a.testdatasetid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set testcycleid = z.id
from test_cycles z
where a.testcycleid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set testbedid = z.id
from test_beds z
where a.testbedid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set releaseid = z.id
from releases z
where a.releaseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set buildid = z.id
from builds z
where a.buildid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites a
set lastmodifieduserid = z.id
from users z
where a.lastmodifieduserid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update test_suites_aud a
set rev = z.id
from revision_info z
where a.rev = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update tutorial_task_users a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_criteria a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_group_members a
set clientuserid = z.id
from client_users z
where a.clientuserid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_group_members a
set usergroupid = z.id
from user_groups z
where a.usergroupid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_group_authorities a
set usergroupid = z.id
from user_groups z
where a.usergroupid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_ext a
set id = z.id
from users z
where a.id = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_projects a
set userid = z.id
from users z
where a.userid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;
update user_projects a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update pid_increment a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

update project_default_permissions a
set projectsecurityprofileid = z.id
from security_profiles z
where a.projectsecurityprofileid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;

create index if not exists idx_tmp_recycle_related_actions_parentactionid on recycle_related_actions(parentactionid) where fromclientid IN (:clientid);

update recycle_related_actions a
set parentactionid = z.id
from recycle_actions z
where a.parentactionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.fromclientid;


-- should run after custom_fields
update custom_field_configurations a
set valueid = z.id
from lookup z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

-- inherrit case
update custom_field_configurations a
set valueid = z.id
from custom_fields z,
custom_fields cf
where a.valueid = z.fromid
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

update custom_field_configurations a
set value = z.id
from lookup z,
custom_fields cf
where a.value = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'defaultValue'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

update custom_field_configurations a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from lookup z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'values'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

-- inherit case
update custom_field_configurations a
set value = regexp_replace(a.value,'^[[:digit:]]+:(.+)$',concat(z.id,':\1'))
from custom_fields z,
custom_fields cf
where substring(a.value,'^([[:digit:]]+):.+$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid) -- if system value (clientid is null), then it is already the same => no update
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

update custom_field_configurations a
set value = regexp_replace(a.value,'^(.+):[[:digit:]]+$',concat('\1:',z.id))
from projects z,
custom_fields cf
where substring(a.value,'.+:([[:digit:]]+)$') = z.fromid::text
and a.customfieldid = cf.id
and a.attribute = 'sourceField'
and cf.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and z.clientid IN (:clientid)
and a.fromclientid = z.fromclientid
and z.id != z.fromid;

update custom_field_configurations_aud a
set integrationcustomfieldconfigurationid = z.id
from integration_custom_field_configurations z
where a.integrationcustomfieldconfigurationid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (:clientid)
and a.fromclientid = z.clientid;
update integration_custom_fields_aud a
set projectid = z.id
from projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
update integration_custom_fields_aud a
set integrationdatatypeid = z.id
from integration_custom_field_data_types z
where a.integrationdatatypeid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
update integration_custom_fields_aud a
set connectionid = z.id
from defect_tracking_connection z
where a.connectionid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
update integration_custom_field_configurations_aud a
set integrationcustomfieldid = z.id
from integration_custom_fields z
where a.integrationcustomfieldid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.clientid = z.clientid;
--  valueid from Jira => no change

drop index if exists idx_tmp_lookup_fromid_id;
drop index if exists idx_tmp_requirements_requirementpriorityid;
drop index if exists idx_tmp_test_case_run_fromid_id;
drop index if exists idx_tmp_test_case_results_aud_testcaserunid;
drop index if exists idx_tmp_defects_aud_fromid_id;
drop index if exists idx_tmp_defects_aud_sourcedefectid;
drop index if exists idx_tmp_acl_object_identity_fromid_id;
drop index if exists idx_tmp_acl_entry_acl_object_identity;
drop index if exists idx_tmp_revision_info_fromid_id;
drop index if exists idx_tmp_blob_handles_aud_rev;
drop index if exists idx_tmp_custom_field_values_customfieldid;
drop index if exists idx_tmp_custom_fields_fromid_id;
drop index if exists idx_tmp_custom_field_values_fromid_id;
drop index if exists idx_tmp_requirement_test_cases_testcaseid;
drop index if exists idx_tmp_requirements_fromid_id;
drop index if exists idx_tmp_requirement_test_cases_requirementid;
drop index if exists idx_tmp_test_case_results_testcaseversionid;
drop index if exists idx_tmp_test_case_results_testcaserunid;
drop index if exists idx_tmp_test_case_versions_fromid_id;
drop index if exists idx_tmp_test_case_results_aud_rev;
drop index if exists idx_tmp_test_case_run_testcaseversionid;
drop index if exists idx_tmp_test_case_run_testcaseid;
drop index if exists idx_tmp_test_cases_fromid_id;
drop index if exists idx_tmp_test_step_results_testcaseresultid;
drop index if exists idx_tmp_test_case_results_fromid_id;
drop index if exists idx_tmp_test_step_results_aud_rev;
drop index if exists idx_tmp_test_step_results_teststepid;
drop index if exists idx_tmp_test_steps_fromid_id;
drop index if exists idx_tmp_test_steps_testcaseversionid;
drop index if exists idx_tmp_test_steps_aud_rev;
drop index if exists idx_tmp_test_case_run_projectid;
drop index if exists idx_tmp_projects_fromid_id;
drop index if exists idx_tmp_custom_fields_aud_integrationdefectfieldid;
drop index if exists idx_tmp_integration_defect_fields_fromid_id;
drop index if exists idx_tmp_users_fromid_id;
drop index if exists idx_tmp_defects_aud_projectmoduleid;
drop index if exists idx_tmp_defects_fromid_id;
drop index if exists idx_tmp_defects_sourcedefectid;
drop index if exists idx_tmp_test_cases_projectmoduleid;
drop index if exists idx_tmp_project_modules_fromid_id;
drop index if exists idx_tmp_integration_issue_data_integrationissuerequirementmapid;
drop index if exists idx_tmp_integration_issue_requirement_maps_fromid_id;
drop index if exists idx_tmp_integration_issue_requirement_maps_requirementid;
drop index if exists idx_tmp_test_case_results_releaseid;
drop index if exists idx_tmp_test_case_results_buildid;
drop index if exists idx_tmp_test_case_run_testsuiteid;
drop index if exists idx_tmp_test_case_run_testcycleid;
drop index if exists idx_tmp_test_suites_fromid_id;
drop index if exists idx_tmp_test_cycles_fromid_id;
drop index if exists idx_tmp_test_case_versions_testcaseid;
drop index if exists idx_tmp_recycle_related_actions_parentactionid;

-- VACUUM (VERBOSE, ANALYZE) custom_fields;

-- manual 
/* export from migrated session db
\copy (SELECT clientid as fromclientid, sessionid, fromid FROM session WHERE clientid IN (10699,25502) and fromid is not null and sessionid != fromid) to 'newid_session.dat'
-- import into qtest manager db
\copy ztmpclientmigration.newid_session(fromclientid,sessionid,fromid) from 'newid_session.dat'

update audit_log a
set objectid = z.sessionid
from ztmpclientmigration.newid_session z
where a.objectid = z.fromid
and a.clientid IN (10699,25502)
and a.fromclientid IN (10699,25502)
and a.fromclientid = z.fromclientid
and a.appname = 'explorer_sessions'
and (a.objectpid like 'SS-%' or a.objectpid = '');
*/
