\encoding UTF8

\set ON_ERROR_STOP on

\set AUTOCOMMIT on

-- manual 
/* export from migrated qtest manager db
\copy (SELECT clientid, id, fromid FROM projects WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_projects.dat'
\copy (SELECT clientid, id, fromid FROM test_cases WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_test_cases.dat'
\copy (SELECT clientid, id, fromid FROM requirements WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_requirements.dat'
\copy (SELECT clientid, id, fromid FROM defects WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_defects.dat'
\copy (SELECT clientid, id, fromid FROM test_steps WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_test_steps.dat'
\copy (SELECT clientid, id, fromid FROM builds WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_builds.dat'
\copy (SELECT clientid, id, fromid FROM releases WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_releases.dat'
\copy (SELECT clientid, id, fromid FROM test_case_run WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_test_case_run.dat'
\copy (SELECT clientid, id, fromid FROM test_case_results WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_test_case_results.dat'
\copy (SELECT clientid, id, fromid FROM test_suites WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_test_suites.dat'
\copy (SELECT clientid, id, fromid FROM data_queries WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_data_queries.dat'
*/
\copy ztmpclientmigration.newid_projects from 'newid_projects.dat'
\copy ztmpclientmigration.newid_test_cases from 'newid_test_cases.dat'
\copy ztmpclientmigration.newid_requirements from 'newid_requirements.dat'
\copy ztmpclientmigration.newid_defects from 'newid_defects.dat'
\copy ztmpclientmigration.newid_test_steps from 'newid_test_steps.dat'
\copy ztmpclientmigration.newid_builds from 'newid_builds.dat'
\copy ztmpclientmigration.newid_releases from 'newid_releases.dat'
\copy ztmpclientmigration.newid_test_case_results from 'newid_test_case_results.dat'
\copy ztmpclientmigration.newid_test_case_run from 'newid_test_case_run.dat'
\copy ztmpclientmigration.newid_test_suites from 'newid_test_suites.dat'
\copy ztmpclientmigration.newid_data_queries from 'newid_data_queries.dat'



-- generated 
/*
select format('\copy ztmpclientmigration.%s from ''%s.dat''',table_name,table_name)
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
\copy ztmpclientmigration.application_info from 'application_info.dat'
\copy ztmpclientmigration.comment from 'comment.dat'
\copy ztmpclientmigration.coverage from 'coverage.dat'
\copy ztmpclientmigration.custom_view from 'custom_view.dat'
\copy ztmpclientmigration.data_query from 'data_query.dat'
\copy ztmpclientmigration.explorer_token from 'explorer_token.dat'
\copy ztmpclientmigration.ext_client from 'ext_client.dat'
\copy ztmpclientmigration.ext_system from 'ext_system.dat'
\copy ztmpclientmigration.note from 'note.dat'
\copy ztmpclientmigration.pid_increment from 'pid_increment.dat'
\copy ztmpclientmigration.plugin from 'plugin.dat'
\copy ztmpclientmigration.resource from 'resource.dat'
\copy ztmpclientmigration.screen from 'screen.dat'
\copy ztmpclientmigration.screen_coverage from 'screen_coverage.dat'
\copy ztmpclientmigration.session from 'session.dat'
\copy ztmpclientmigration.session_export from 'session_export.dat'
\copy ztmpclientmigration.session_history from 'session_history.dat'
\copy ztmpclientmigration.setting from 'setting.dat'
\copy ztmpclientmigration.system_info from 'system_info.dat'
\copy ztmpclientmigration.timeline from 'timeline.dat'
\copy ztmpclientmigration.user_setting from 'user_setting.dat'