\encoding UTF8

\set ON_ERROR_STOP on



-- manual

truncate table ztmpclientmigration.newid_projects cascade;
truncate table ztmpclientmigration.newid_test_cases cascade;
truncate table ztmpclientmigration.newid_requirements cascade;
truncate table ztmpclientmigration.newid_defects cascade;
truncate table ztmpclientmigration.newid_test_steps cascade;
truncate table ztmpclientmigration.newid_builds cascade;
truncate table ztmpclientmigration.newid_releases cascade;
truncate table ztmpclientmigration.newid_test_case_results cascade;
truncate table ztmpclientmigration.newid_test_case_run cascade;
truncate table ztmpclientmigration.newid_test_suites cascade;
truncate table ztmpclientmigration.newid_data_queries cascade;

truncate table ztmpclientmigration.application_info cascade;
truncate table ztmpclientmigration.comment cascade;
truncate table ztmpclientmigration.coverage cascade;
truncate table ztmpclientmigration.custom_view cascade;
truncate table ztmpclientmigration.data_query cascade;
truncate table ztmpclientmigration.explorer_token cascade;
truncate table ztmpclientmigration.ext_client cascade;
truncate table ztmpclientmigration.ext_system cascade;
truncate table ztmpclientmigration.note cascade;
truncate table ztmpclientmigration.pid_increment cascade;
truncate table ztmpclientmigration.plugin cascade;
truncate table ztmpclientmigration.resource cascade;
truncate table ztmpclientmigration.screen cascade;
truncate table ztmpclientmigration.screen_coverage cascade;
truncate table ztmpclientmigration.session cascade;
truncate table ztmpclientmigration.session_export cascade;
truncate table ztmpclientmigration.session_history cascade;
truncate table ztmpclientmigration.setting cascade;
truncate table ztmpclientmigration.system_info cascade;
truncate table ztmpclientmigration.timeline cascade;
truncate table ztmpclientmigration.user_setting cascade;