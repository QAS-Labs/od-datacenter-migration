\encoding UTF8

\set ON_ERROR_STOP on

-- insights
truncate table ztmpclientmigration.insights_portfolio_unlinked_defect_projects cascade;
truncate table ztmpclientmigration.insights_client_colors cascade;
truncate table ztmpclientmigration.insights_client_landing_page cascade;
truncate table ztmpclientmigration.insights_client_user_landing_page cascade;
truncate table ztmpclientmigration.insights_defect_severities cascade;
truncate table ztmpclientmigration.insights_defect_severities_detail cascade;
truncate table ztmpclientmigration.insights_defect_statuses cascade;
truncate table ztmpclientmigration.insights_defect_statuses_detail cascade;
truncate table ztmpclientmigration.insights_portfolios cascade;
truncate table ztmpclientmigration.insights_portfolio_thresholds cascade;
truncate table ztmpclientmigration.insights_portfolio_unlinked_defects cascade;
truncate table ztmpclientmigration.insights_rapiddashboardtasks cascade;
truncate table ztmpclientmigration.insights_report_lookup_t cascade;
truncate table ztmpclientmigration.insights_report_lookup_updates cascade;
truncate table ztmpclientmigration.insights_schedule_tasks cascade;

-- manual
truncate table ztmpclientmigration.clients cascade;
truncate table ztmpclientmigration.clients_aud cascade;
truncate table ztmpclientmigration.client_ext cascade;
truncate table ztmpclientmigration.users cascade;
truncate table ztmpclientmigration.user_ext cascade;
truncate table ztmpclientmigration.custom_field_values cascade;
truncate table ztmpclientmigration.custom_field_configurations cascade;
truncate table ztmpclientmigration.configurations cascade;
truncate table ztmpclientmigration.integration_projects cascade;
truncate table ztmpclientmigration.integration_type_maps cascade;
truncate table ztmpclientmigration.integration_defect_fields cascade;
truncate table ztmpclientmigration.integration_identifier_fields cascade;
truncate table ztmpclientmigration.integration_requirement_field_maps cascade;
truncate table ztmpclientmigration.integration_defect_field_maps cascade;
truncate table ztmpclientmigration.integration_issue_data cascade;
truncate table ztmpclientmigration.integration_release_data cascade;
truncate table ztmpclientmigration.integration_module_fields cascade;
truncate table ztmpclientmigration.acl_sid cascade;
truncate table ztmpclientmigration.acl_object_identity cascade;
truncate table ztmpclientmigration.acl_entry cascade;
truncate table ztmpclientmigration.automation_cancelled_executions cascade;
truncate table ztmpclientmigration.automation_schedules cascade;
truncate table ztmpclientmigration.automation_execution_results cascade;
truncate table ztmpclientmigration.automation_schedule_execution_maps cascade;
truncate table ztmpclientmigration.client_licenses_aud cascade;
truncate table ztmpclientmigration.pid_increment cascade;
truncate table ztmpclientmigration.recycle_related_actions cascade;
truncate table ztmpclientmigration.newid_session cascade;

-- generated
/*
select format('truncate table ztmpclientmigration.%s cascade;',table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='public'
    and table_type = 'BASE TABLE'
    and table_name not like 'ztmp_%'
    and table_name not like 'sd_%'
    and table_name not like 'removed_%'
    and table_name not like 'stats_%'
    and table_name not like 'across_report_%'
    and exists (    select 1 from information_schema.columns
                    where table_schema='public'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/

truncate table ztmpclientmigration.app_url_config cascade;
truncate table ztmpclientmigration.audit_log cascade;
truncate table ztmpclientmigration.automation_agents cascade;
truncate table ztmpclientmigration.automation_hosts cascade;
truncate table ztmpclientmigration.automation_parsers cascade;
truncate table ztmpclientmigration.automation_status_mapping cascade;
truncate table ztmpclientmigration.automation_upgrade_logs cascade;
truncate table ztmpclientmigration.blob_handles cascade;
truncate table ztmpclientmigration.blob_handles_aud cascade;
truncate table ztmpclientmigration.browser_hit_track cascade;
truncate table ztmpclientmigration.builds cascade;
truncate table ztmpclientmigration.builds_aud cascade;
truncate table ztmpclientmigration.client_jira_connection cascade;
truncate table ztmpclientmigration.client_licenses cascade;
truncate table ztmpclientmigration.client_licenses_aud cascade;
truncate table ztmpclientmigration.client_settings cascade;
truncate table ztmpclientmigration.client_users cascade;
truncate table ztmpclientmigration.client_user_sec_profiles cascade;
truncate table ztmpclientmigration.client_user_settings cascade;
truncate table ztmpclientmigration.combined_parameter_values cascade;
truncate table ztmpclientmigration.configuration_migration_tracking cascade;
truncate table ztmpclientmigration.configuration_sets cascade;
truncate table ztmpclientmigration.configuration_variables cascade;
truncate table ztmpclientmigration.custom_field_configurations_aud cascade;
truncate table ztmpclientmigration.custom_field_data_types cascade;
truncate table ztmpclientmigration.custom_fields cascade;
truncate table ztmpclientmigration.custom_fields_aud cascade;
truncate table ztmpclientmigration.custom_field_template_field_mapping cascade;
truncate table ztmpclientmigration.custom_field_templates cascade;
truncate table ztmpclientmigration.custom_field_validators cascade;
truncate table ztmpclientmigration.custom_field_values_aud cascade;
truncate table ztmpclientmigration.custom_field_integration_values cascade;
truncate table ztmpclientmigration.custom_field_integration_values_aud cascade;
truncate table ztmpclientmigration.integration_custom_field_configurations cascade;
truncate table ztmpclientmigration.integration_custom_field_configurations_aud cascade;
truncate table ztmpclientmigration.integration_custom_field_data_types cascade;
truncate table ztmpclientmigration.integration_custom_fields cascade;
truncate table ztmpclientmigration.integration_custom_fields_aud cascade;
truncate table ztmpclientmigration.data_grid_views cascade;
truncate table ztmpclientmigration.data_grid_view_fields cascade;
truncate table ztmpclientmigration.data_queries cascade;
truncate table ztmpclientmigration.data_query_conditions cascade;
truncate table ztmpclientmigration.data_query_operators cascade;
truncate table ztmpclientmigration.defect_queries cascade;
truncate table ztmpclientmigration.defect_query_clauses cascade;
truncate table ztmpclientmigration.defects cascade;
truncate table ztmpclientmigration.defects_aud cascade;
truncate table ztmpclientmigration.defect_tracking_connection cascade;
truncate table ztmpclientmigration.defect_tracking_connection_test cascade;
truncate table ztmpclientmigration.defect_tracking_field cascade;
truncate table ztmpclientmigration.defect_tracking_project cascade;
truncate table ztmpclientmigration.defect_tracking_type cascade;
truncate table ztmpclientmigration.defect_tracking_usage cascade;
truncate table ztmpclientmigration.defect_workflow_transition cascade;
truncate table ztmpclientmigration.defect_workflow_transition_profile cascade;
truncate table ztmpclientmigration.defect_workflow_transition_status cascade;
truncate table ztmpclientmigration.external_auth_system_config cascade;
truncate table ztmpclientmigration.external_client_user cascade;
truncate table ztmpclientmigration.group_authorities cascade;
truncate table ztmpclientmigration.group_members cascade;
truncate table ztmpclientmigration.groups cascade;
truncate table ztmpclientmigration.incidents cascade;
truncate table ztmpclientmigration.insights_token cascade;
truncate table ztmpclientmigration.integration_defect_issue_data cascade;
truncate table ztmpclientmigration.integration_external_defect_issue_data cascade;
truncate table ztmpclientmigration.integration_external_issues cascade;
truncate table ztmpclientmigration.integration_external_issues_maps cascade;
truncate table ztmpclientmigration.integration_issue_release_maps cascade;
truncate table ztmpclientmigration.integration_issue_requirement_maps cascade;
truncate table ztmpclientmigration.integration_issue_test_case_maps cascade;
truncate table ztmpclientmigration.integration_issue_test_case_run_maps cascade;
truncate table ztmpclientmigration.integration_sync_requirement_tracker cascade;
truncate table ztmpclientmigration.integration_webhooks cascade;
truncate table ztmpclientmigration.launch_user_setting cascade;
truncate table ztmpclientmigration.ldap_configuration cascade;
truncate table ztmpclientmigration.license_blob_handles cascade;
truncate table ztmpclientmigration.lookup cascade;
truncate table ztmpclientmigration.lookup_types cascade;
truncate table ztmpclientmigration.oauth_authentications cascade;
truncate table ztmpclientmigration.object_assignments cascade;
truncate table ztmpclientmigration.object_assignments_aud cascade;
truncate table ztmpclientmigration.object_comments cascade;
truncate table ztmpclientmigration.object_comments_aud cascade;
truncate table ztmpclientmigration.object_links cascade;
truncate table ztmpclientmigration.object_subscribers cascade;
truncate table ztmpclientmigration.object_tags cascade;
truncate table ztmpclientmigration.project_default_permissions cascade;
truncate table ztmpclientmigration.project_key_values cascade;
truncate table ztmpclientmigration.project_modules cascade;
truncate table ztmpclientmigration.project_modules_aud cascade;
truncate table ztmpclientmigration.projects cascade;
truncate table ztmpclientmigration.projects_aud cascade;
truncate table ztmpclientmigration.project_settings cascade;
truncate table ztmpclientmigration.queue_event cascade;
truncate table ztmpclientmigration.queue_processing_state cascade;
truncate table ztmpclientmigration.recipient_types cascade;
truncate table ztmpclientmigration.recycle_actions cascade;
truncate table ztmpclientmigration.releases cascade;
truncate table ztmpclientmigration.releases_aud cascade;
truncate table ztmpclientmigration.reports cascade;
truncate table ztmpclientmigration.report_settings cascade;
truncate table ztmpclientmigration.request_execution_time cascade;
truncate table ztmpclientmigration.requirement_link_data cascade;
truncate table ztmpclientmigration.requirement_link_data_aud cascade;
truncate table ztmpclientmigration.requirements cascade;
truncate table ztmpclientmigration.requirements_aud cascade;
truncate table ztmpclientmigration.requirement_test_cases cascade;
truncate table ztmpclientmigration.revision_aware cascade;
truncate table ztmpclientmigration.revision_info cascade;
truncate table ztmpclientmigration.scenario_status_mapping cascade;
truncate table ztmpclientmigration.security_profiles cascade;
truncate table ztmpclientmigration.sso_idp_metadata_file cascade;
truncate table ztmpclientmigration.task_execution_time cascade;
truncate table ztmpclientmigration.test_beds cascade;
truncate table ztmpclientmigration.test_case_agents cascade;
truncate table ztmpclientmigration.test_case_result_defects cascade;
truncate table ztmpclientmigration.test_case_results cascade;
truncate table ztmpclientmigration.test_case_results_aud cascade;
truncate table ztmpclientmigration.test_case_run cascade;
truncate table ztmpclientmigration.test_case_run_aud cascade;
truncate table ztmpclientmigration.test_cases cascade;
truncate table ztmpclientmigration.test_cases_aud cascade;
truncate table ztmpclientmigration.test_case_versions cascade;
truncate table ztmpclientmigration.test_case_versions_aud cascade;
truncate table ztmpclientmigration.test_cycles cascade;
truncate table ztmpclientmigration.test_cycles_aud cascade;
truncate table ztmpclientmigration.test_data_sets cascade;
truncate table ztmpclientmigration.test_parameters cascade;
truncate table ztmpclientmigration.test_step_parameters cascade;
truncate table ztmpclientmigration.test_step_parameters_aud cascade;
truncate table ztmpclientmigration.test_step_parameter_values cascade;
truncate table ztmpclientmigration.test_step_result_defects cascade;
truncate table ztmpclientmigration.test_step_results cascade;
truncate table ztmpclientmigration.test_step_results_aud cascade;
truncate table ztmpclientmigration.test_steps cascade;
truncate table ztmpclientmigration.test_steps_aud cascade;
truncate table ztmpclientmigration.test_steps_test_cases_aud cascade;
truncate table ztmpclientmigration.test_suites cascade;
truncate table ztmpclientmigration.test_suites_aud cascade;
truncate table ztmpclientmigration.tutorial_task_users cascade;
truncate table ztmpclientmigration.user_criteria cascade;
truncate table ztmpclientmigration.user_groups cascade;
truncate table ztmpclientmigration.user_group_members cascade;
truncate table ztmpclientmigration.user_group_authorities cascade;
truncate table ztmpclientmigration.user_projects cascade;
truncate table ztmpclientmigration.user_unique_id cascade;
truncate table ztmpclientmigration.null_revision_info cascade;
truncate table ztmpclientmigration.integration_release_configuration;