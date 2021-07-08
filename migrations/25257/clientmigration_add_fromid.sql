\encoding UTF8

\set ON_ERROR_STOP on

-- manual for insights

alter table insights.portfolio_unlinked_defect_projects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;

-- generated for insights
/*
select format('alter table insights.%s add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;',table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='insights'
    and table_type = 'BASE TABLE'
    and table_name not like 'project_module%'
    and table_name not in ('client_user_info','preferences','saved_report')
    and table_name not like 'test_cycle%'
    and exists (    select 1 from information_schema.columns
                    where table_schema='insights'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
alter table insights.client_colors add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.client_landing_page add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.client_user_landing_page add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.defect_severities add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.defect_severities_detail add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.defect_statuses add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.defect_statuses_detail add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.portfolios add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.portfolio_thresholds add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.portfolio_unlinked_defects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.rapiddashboardtasks add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.report_lookup_t add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.report_lookup_updates add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.schedule_tasks add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.jira_report_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table insights.user_banners add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;


-- manual
alter table public.users add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.oauth_authentications add column if not exists fromid bpchar(32) null, add column if not exists fromclientid int8 null;
alter table public.automation_upgrade_logs add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_cancelled_executions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_schedules add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_execution_results add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_schedule_execution_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.configurations add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_projects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_type_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_defect_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_issue_data add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_identifier_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_module_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_release_configuration add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_defect_field_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_release_data add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_requirement_field_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_configurations add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_values add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_parameters add column if not exists fromid varchar(25) null, add column if not exists fromclientid int8 null;
alter table public.user_ext add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.acl_sid add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.acl_object_identity add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.acl_entry add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.pid_increment add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.recycle_related_actions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_grid_view_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;




-- generated
/*
select format('alter table public.%s add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;',table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='public'
    and table_type = 'BASE TABLE'
    and table_name not like 'ztmp_%'
    and table_name not like 'sd_%'
    and table_name not like 'removed_%'
    and table_name not like 'stats_%'
    and table_name not like 'across_report_%'
    and table_name not in ('automation_upgrade_logs','test_case_agents','test_parameters','oauth_authentications')
    and exists (    select 1 from information_schema.columns
                    where table_schema='public'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
alter table public.app_url_config add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.audit_log add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_agents add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_hosts add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_parsers add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.automation_status_mapping add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.blob_handles add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.blob_handles_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.browser_hit_track add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.builds add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.builds_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_jira_connection add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_licenses add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_licenses_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_settings add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_users add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_user_sec_profiles add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.client_user_settings add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.combined_parameter_values add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.configuration_migration_tracking add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.configuration_sets add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.configuration_variables add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_configurations_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_data_types add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_fields add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_fields_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_template_field_mapping add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_templates add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_validators add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.custom_field_values_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_grid_views add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_queries add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_query_conditions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.data_query_operators add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_queries add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_query_clauses add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defects_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_connection add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_connection_test add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_field add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_project add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_type add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_tracking_usage add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_workflow_transition add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_workflow_transition_profile add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.defect_workflow_transition_status add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.external_auth_system_config add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.external_client_user add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.group_authorities add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.group_members add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.groups add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.incidents add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.insights_token add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_defect_issue_data add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_external_defect_issue_data add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_external_issues add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_external_issues_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_issue_release_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_issue_requirement_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_issue_test_case_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_issue_test_case_run_maps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_sync_requirement_tracker add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.integration_webhooks add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.launch_user_setting add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.ldap_configuration add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.license_blob_handles add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.lookup add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.lookup_types add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_assignments add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_assignments_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_comments add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_comments_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_links add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_subscribers add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.object_tags add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.project_default_permissions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.project_key_values add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.project_modules add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.project_modules_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.projects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.projects_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.project_settings add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.queue_event add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.queue_processing_state add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.recipient_types add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.recycle_actions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.releases add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.releases_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.reports add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.report_settings add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.request_execution_time add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.requirement_link_data add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.requirement_link_data_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.requirements add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.requirements_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.requirement_test_cases add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.revision_aware add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.revision_info add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.scenario_status_mapping add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.search_tasks add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.security_profiles add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.sso_idp_metadata_file add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.task_execution_time add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_beds add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_result_defects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_results add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_results_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_run add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_run_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_cases add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_cases_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_versions add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_case_versions_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_cycles add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_cycles_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_data_sets add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_parameters add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_parameters_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_parameter_values add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_result_defects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_results add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_step_results_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_steps add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_steps_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_steps_test_cases_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_suites add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.test_suites_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.tutorial_task_users add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_criteria add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_groups add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_groups_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_group_members add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_group_members_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_group_authorities add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_group_authorities_aud add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_projects add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;
alter table public.user_unique_id add column if not exists fromid int8 null, add column if not exists fromclientid int8 null;