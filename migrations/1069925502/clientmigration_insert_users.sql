\encoding UTF8

\set ON_ERROR_STOP on

set application_name to dba;

set work_mem='4GB';

\timing on

-- manual for insights

insert into insights.client_colors (projectcts,colors,color,clientid,value,typeid,fromid,fromclientid)
select s.projectcts,s.colors,s.color,s.clientid,s.value,s.typeid,null,s.fromclientid from ztmpclientmigration.insights_client_colors s;
insert into insights.client_landing_page (clientid,landing_page,name,fromid,fromclientid)
select s.clientid,s.landing_page,s.name,s.id,s.fromclientid from ztmpclientmigration.insights_client_landing_page s;
insert into insights.client_user_landing_page (clientid,userid,landing_page,name,fromid,fromclientid)
select s.clientid,s.userid,s.landing_page,s.name,s.id,s.fromclientid from ztmpclientmigration.insights_client_user_landing_page s;
insert into insights.defect_severities (entrynumber,clientid,projectids,fieldname,fromid,fromclientid)
select s.entrynumber,s.clientid,s.projectids,s.fieldname,null,s.fromclientid from ztmpclientmigration.insights_defect_severities s;
insert into insights.defect_severities_detail (severityvalues,clientid,entrynumber,sequencenumber,severityname,chartcolor,fromid,fromclientid)
select s.severityvalues,s.clientid,s.entrynumber,s.sequencenumber,s.severityname,s.chartcolor,null,s.fromclientid from ztmpclientmigration.insights_defect_severities_detail s;
insert into insights.defect_statuses (projectids,clientid,entrynumber,fromid,fromclientid)
select s.projectids,s.clientid,s.entrynumber,null,s.fromclientid from ztmpclientmigration.insights_defect_statuses s;
insert into insights.defect_statuses_detail (statusvalues,clientid,entrynumber,sequencenumber,statusname,chartcolor,fromid,fromclientid)
select s.statusvalues,s.clientid,s.entrynumber,s.sequencenumber,s.statusname,s.chartcolor,null,s.fromclientid from ztmpclientmigration.insights_defect_statuses_detail s;
insert into insights.portfolio_thresholds (sqlexpression,portfolioid,entrynumber,clientid,color,expression,fields,fromid,fromclientid)
select s.sqlexpression,s.portfolioid,s.entrynumber,s.clientid,s.color,s.expression,s.fields,null,s.fromclientid from ztmpclientmigration.insights_portfolio_thresholds s;
insert into insights.schedule_tasks (taskid,clientid,receivers,insightsserverurl,bookmarkid,bookmarkcollection,isdisable,cronexpression,starttime,endtime,timezone,scheduleinfo,title,scheduledescription,isrunning,taskresult,timecreated,timemodified,timenextrun,timelastrun,creatorid,updaterid,fromid,fromclientid)
select s.taskid,s.clientid,s.receivers,s.insightsserverurl,s.bookmarkid,s.bookmarkcollection,s.isdisable,s.cronexpression,s.starttime,s.endtime,s.timezone,s.scheduleinfo,s.title,s.scheduledescription,s.isrunning,s.taskresult,s.timecreated,s.timemodified,s.timenextrun,s.timelastrun,s.creatorid,s.updaterid,s.taskid,s.fromclientid from ztmpclientmigration.insights_schedule_tasks s
left join insights.schedule_tasks d on s.taskid = d.taskid
where d.taskid is null;
select setval(pg_get_serial_sequence('insights.schedule_tasks', 'taskid'), coalesce(max(taskid),0) + 1, false) FROM insights.schedule_tasks;
insert into insights.schedule_tasks (fromid,clientid,receivers,insightsserverurl,bookmarkid,bookmarkcollection,isdisable,cronexpression,starttime,endtime,timezone,scheduleinfo,title,scheduledescription,isrunning,taskresult,timecreated,timemodified,timenextrun,timelastrun,creatorid,updaterid,fromclientid)
select s.taskid,s.clientid,s.receivers,s.insightsserverurl,s.bookmarkid,s.bookmarkcollection,s.isdisable,s.cronexpression,s.starttime,s.endtime,s.timezone,s.scheduleinfo,s.title,s.scheduledescription,s.isrunning,s.taskresult,s.timecreated,s.timemodified,s.timenextrun,s.timelastrun,s.creatorid,s.updaterid,s.fromclientid from ztmpclientmigration.insights_schedule_tasks s
inner join insights.schedule_tasks d on s.taskid = d.taskid
and (d.fromid is null or d.fromid is not null and d.fromid != d.taskid);

/* -- copy to after public.projects
insert into insights.jira_report_fields (clientid,projectid,typeid,entrynumber,fieldname,fieldid,columnheading,columntype,columnformat,fromid,fromclientid)
select s.clientid,s.projectid,s.typeid,s.entrynumber,s.fieldname,s.fieldid,s.columnheading,s.columntype,s.columnformat,null,s.fromclientid from ztmpclientmigration.insights_jira_report_fields s;
*/



/* helper script for insights
select format('insert into insights.%s (id,%s,fromid,fromclientid)
select s.id,%s,s.id,s.fromclientid from ztmpclientmigration.insights_%s s
left join insights.%s d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence(''insights.%s'', ''id''), coalesce(max(id),0) + 1, false) FROM insights.%s;
insert into insights.%s (fromid,%s,fromclientid)
select s.id,%s,s.fromclientid from ztmpclientmigration.insights_%s s
inner join insights.%s d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);',
table_name,
string_agg(column_name,','),
string_agg(concat('s.',column_name),','),
table_name,
table_name,
table_name,
table_name,
table_name,
string_agg(column_name,','),
string_agg(concat('s.',column_name),','),
table_name,
table_name
)
from (
    select t.table_name, c.column_name
    from information_schema.tables t 
    inner join information_schema.columns c
      on c.table_name = t.table_name
    where
    t.table_schema = 'insights'
    and t.table_type = 'BASE TABLE'
    and c.table_schema = 'insights'
    and c.column_name not in ('id','fromid','fromclientid')
    ORDER BY t.table_name, c.ordinal_position
) t
inner join unnest('{rapiddashboardtasks,user_banners,
portfolios,portfolio_thresholds,portfolio_unlinked_defects,portfolio_unlinked_defect_projects,
report_lookup_t,report_lookup_updates}'::varchar[]) WITH ORDINALITY torder(name, ord)
on t.table_name = torder.name
WHERE t.table_name not in ('client_colors','defect_severities','defect_severities_detail','defect_statuses','defect_statuses_detail','portfolio_thresholds','schedule_tasks')
GROUP BY table_name, torder.ord
order by torder.ord asc;
*/



insert into insights.rapiddashboardtasks (id,timenextrun,isrunning,clientid,userid,serverurl,requestparams,updateinterval,isgeneratedfile,bookmarkid,fromid,fromclientid)
select s.id,s.timenextrun,s.isrunning,s.clientid,s.userid,s.serverurl,s.requestparams,s.updateinterval,s.isgeneratedfile,s.bookmarkid,s.id,s.fromclientid from ztmpclientmigration.insights_rapiddashboardtasks s
left join insights.rapiddashboardtasks d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.rapiddashboardtasks', 'id'), coalesce(max(id),0) + 1, false) FROM insights.rapiddashboardtasks;
insert into insights.rapiddashboardtasks (fromid,timenextrun,isrunning,clientid,userid,serverurl,requestparams,updateinterval,isgeneratedfile,bookmarkid,fromclientid)
select s.id,s.timenextrun,s.isrunning,s.clientid,s.userid,s.serverurl,s.requestparams,s.updateinterval,s.isgeneratedfile,s.bookmarkid,s.fromclientid from ztmpclientmigration.insights_rapiddashboardtasks s
inner join insights.rapiddashboardtasks d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.user_banners (id,clientid,userid,latestreleaseid,fromid,fromclientid)                                      
select s.id,s.clientid,s.userid,s.latestreleaseid,s.id,s.fromclientid from ztmpclientmigration.insights_user_banners s               
left join insights.user_banners d on s.id = d.id                                                                                
where d.id is null;                                                                                                             
select setval(pg_get_serial_sequence('insights.user_banners', 'id'), coalesce(max(id),0) + 1, false) FROM insights.user_banners;
insert into insights.user_banners (fromid,clientid,userid,latestreleaseid,fromclientid)                                         
select s.id,s.clientid,s.userid,s.latestreleaseid,s.fromclientid from ztmpclientmigration.insights_user_banners s                    
inner join insights.user_banners d on s.id = d.id                                                                               
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.portfolios (id,name,datefieldid,defaultthresholdcolor,clientid,sitefieldid,objecttypeid,fromid,fromclientid)
select s.id,s.name,s.datefieldid,s.defaultthresholdcolor,s.clientid,s.sitefieldid,s.objecttypeid,s.id,s.fromclientid from ztmpclientmigration.insights_portfolios s
left join insights.portfolios d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.portfolios', 'id'), coalesce(max(id),0) + 1, false) FROM insights.portfolios;
insert into insights.portfolios (fromid,name,datefieldid,defaultthresholdcolor,clientid,sitefieldid,objecttypeid,fromclientid)
select s.id,s.name,s.datefieldid,s.defaultthresholdcolor,s.clientid,s.sitefieldid,s.objecttypeid,s.fromclientid from ztmpclientmigration.insights_portfolios s
inner join insights.portfolios d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.portfolio_unlinked_defects (id,defectfieldid,entrynumber,clientid,portfolioid,fromid,fromclientid)
select s.id,s.defectfieldid,s.entrynumber,s.clientid,s.portfolioid,s.id,s.fromclientid from ztmpclientmigration.insights_portfolio_unlinked_defects s
left join insights.portfolio_unlinked_defects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.portfolio_unlinked_defects', 'id'), coalesce(max(id),0) + 1, false) FROM insights.portfolio_unlinked_defects;
insert into insights.portfolio_unlinked_defects (fromid,defectfieldid,entrynumber,clientid,portfolioid,fromclientid)
select s.id,s.defectfieldid,s.entrynumber,s.clientid,s.portfolioid,s.fromclientid from ztmpclientmigration.insights_portfolio_unlinked_defects s
inner join insights.portfolio_unlinked_defects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.portfolio_unlinked_defect_projects (id,projectid,portfoliounlinkeddefectid,fromid,fromclientid)
select s.id,s.projectid,s.portfoliounlinkeddefectid,s.id,s.fromclientid from ztmpclientmigration.insights_portfolio_unlinked_defect_projects s
left join insights.portfolio_unlinked_defect_projects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.portfolio_unlinked_defect_projects', 'id'), coalesce(max(id),0) + 1, false) FROM insights.portfolio_unlinked_defect_projects;
insert into insights.portfolio_unlinked_defect_projects (fromid,projectid,portfoliounlinkeddefectid,fromclientid)
select s.id,s.projectid,s.portfoliounlinkeddefectid,s.fromclientid from ztmpclientmigration.insights_portfolio_unlinked_defect_projects s
inner join insights.portfolio_unlinked_defect_projects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.report_lookup_t (id,clientid,projectid,customfieldid,type,value,color,fromid,fromclientid)
select s.id,s.clientid,s.projectid,s.customfieldid,s.type,s.value,s.color,s.id,s.fromclientid from ztmpclientmigration.insights_report_lookup_t s
left join insights.report_lookup_t d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.report_lookup_t', 'id'), coalesce(max(id),0) + 1, false) FROM insights.report_lookup_t;
insert into insights.report_lookup_t (fromid,clientid,projectid,customfieldid,type,value,color,fromclientid)
select s.id,s.clientid,s.projectid,s.customfieldid,s.type,s.value,s.color,s.fromclientid from ztmpclientmigration.insights_report_lookup_t s
inner join insights.report_lookup_t d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into insights.report_lookup_updates (id,clientid,projectid,customfieldid,type,value,color,updatedat,action,fromid,fromclientid)
select s.id,s.clientid,s.projectid,s.customfieldid,s.type,s.value,s.color,s.updatedat,s.action,s.id,s.fromclientid from ztmpclientmigration.insights_report_lookup_updates s
left join insights.report_lookup_updates d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('insights.report_lookup_updates', 'id'), coalesce(max(id),0) + 1, false) FROM insights.report_lookup_updates;
insert into insights.report_lookup_updates (fromid,clientid,projectid,customfieldid,type,value,color,updatedat,action,fromclientid)
select s.id,s.clientid,s.projectid,s.customfieldid,s.type,s.value,s.color,s.updatedat,s.action,s.fromclientid from ztmpclientmigration.insights_report_lookup_updates s
inner join insights.report_lookup_updates d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);


/* helper script
select format('insert into public.%s (id,%s,fromid,fromclientid)
select s.id,%s,s.id,s.fromclientid from ztmpclientmigration.%s s
left join public.%s d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence(''public.%s'', ''id''), coalesce(max(id),0) + 1, false) FROM public.%s;
insert into public.%s (fromid,%s,fromclientid)
select s.id,%s,s.fromclientid from ztmpclientmigration.%s s
inner join public.%s d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);',
table_name,
string_agg(column_name,','),
string_agg(concat('s.',column_name),','),
table_name,
table_name,
table_name,
table_name,
table_name,
string_agg(column_name,','),
string_agg(concat('s.',column_name),','),
table_name,
table_name
)
from (
    select t.table_name, c.column_name
    from information_schema.tables t 
    inner join information_schema.columns c
      on c.table_name = t.table_name
    where
    t.table_schema = 'public'
    and t.table_type = 'BASE TABLE'
    and t.table_name not like 'ztmp_%'
    and t.table_name not like 'sd_%'
    and t.table_name not like 'removed_%'
    and t.table_name not like 'stats_%'
    and t.table_name not like 'across_report_%'
    and c.table_schema = 'public'
    and c.column_name not in ('id','fromid','fromclientid')
    and t.table_name not in ('client_ext','test_steps_test_cases')
    ORDER BY t.table_name, c.ordinal_position
) t
inner join unnest('{client_licenses,client_ext,external_auth_system_config,client_settings,configuration_sets,configurations,configuration_variables,
client_users,client_user_settings,client_users_ext,external_client_user,security_profiles,groups,group_members,group_authorities,
acl_sid,acl_object_identity,acl_entry,
license_blob_handles,custom_field_templates,projects,project_key_values,project_settings,project_default_permissions,client_user_sec_profiles,project_modules,user_projects,user_criteria,
automation_hosts,automation_agents,automation_status_mapping,automation_upgrade_logs,blob_handles,automation_schedules,automation_cancelled_executions,automation_schedule_execution_maps,automation_execution_results,
automation_parsers,audit_log,revision_info,revision_aware,recycle_actions,object_assignments,queue_event,queue_processing_state,
lookup,test_beds,test_data_sets,
data_queries,data_query_operators,data_query_conditions,
releases,requirements,builds,test_cycles,test_suites,test_cases,requirement_test_cases,test_case_versions,test_case_run,test_steps,test_steps_test_cases,test_case_results,test_step_results,defects,test_case_result_defects,test_step_result_defects,requirement_link_data,
client_jira_connection,defect_tracking_connection,defect_tracking_connection_test,defect_tracking_usage,defect_tracking_project,defect_tracking_type,defect_tracking_field,
integration_identifier_fields,integration_external_defect_issue_data,integration_defect_issue_data,integration_projects,integration_type_maps,integration_requirement_field_maps,integration_release_configuration,integration_issue_release_maps,integration_release_data,integration_external_issues,integration_issue_test_case_maps,integration_issue_requirement_maps,integration_issue_data,integration_external_issues_maps,integration_webhooks,configuration_migration_tracking,integration_sync_requirement_tracker,integration_issue_test_case_run_maps,integration_defect_fields,integration_module_fields,integration_defect_field_maps,
custom_field_data_types,custom_fields,custom_field_validators,custom_field_configurations,custom_field_values,custom_field_template,custom_field_template_field_mapping,
integration_custom_field_data_types,integration_custom_fields,integration_custom_field_configurations,custom_field_integration_values,
test_step_parameters,test_step_parameter_values,
defect_workflow_transition,defect_workflow_transition_profile,defect_workflow_transition_status,
object_links,incidents,scenario_status_mapping,combined_parameter_values,browser_hit_track,request_execution_time,object_comments,app_url_config,user_unique_id,object_subscribers,launch_user_setting,insights_token,data_grid_views,
recycle_related_actions,user_groups,user_group_members,user_group_authorities}'::varchar[]) WITH ORDINALITY torder(name, ord)
on t.table_name = torder.name
GROUP BY table_name, torder.ord
order by torder.ord asc;
*/

/* helper script for _aud
select format('insert into public.%s (id,rev,%s,fromid,fromclientid)
select t.id,s.rev,%s,s.id,s.fromclientid from ztmpclientmigration.%s s
inner join public.%s t on s.id = t.fromid;',
table_name,
string_agg(column_name,','),
string_agg(concat('s.',column_name),','),
table_name,
replace(table_name,'_aud','')
)
from (
    select t.table_name, c.column_name
    from information_schema.tables t 
    inner join information_schema.columns c
      on c.table_name = t.table_name
    where
    t.table_schema = 'public'
    and t.table_type = 'BASE TABLE'
    and t.table_name not like 'ztmp_%'
    and t.table_name not like 'sd_%'
    and t.table_name not like 'removed_%'
    and t.table_name not like 'stats_%'
    and t.table_name not like 'across_report_%'
    and c.table_schema = 'public'
    and c.column_name not in ('id','fromid','fromclientid','rev')
    and t.table_name not in ('test_steps_test_cases_aud')
    ORDER BY t.table_name, c.ordinal_position
) t
inner join unnest('{test_step_parameters_aud,client_licenses_aud,
projects_aud,project_modules_aud,blob_handles_aud,object_assignments_aud,custom_fields_aud,custom_field_configurations_aud,custom_field_values_aud,
integration_custom_field_configurations_aud,integration_custom_fields_aud,custom_field_integration_values_aud,
requirements_aud,builds_aud,releases_aud,test_cycles_aud,test_suites_aud,test_cases_aud,test_case_run_aud,test_case_versions_aud,test_steps_aud,test_steps_test_cases_aud,test_case_results_aud,test_step_results_aud,sdefects_aud,requirement_link_data_aud,
object_comments_aud}'::varchar[]) WITH ORDINALITY torder(name, ord)
on t.table_name = torder.name
GROUP BY table_name, torder.ord
order by torder.ord asc;
*/

-- manual

INSERT INTO public.clients(id, name, sitename, isinactive, maxfailedloginattempt, passwordshelflife, passwordhealthyperiod, minimumuniquepasswordssequencelength, licenseblobid, sessiontimeoutenabled, sessiontimeoutminute, terminateidleenabled, terminateidleminute, dateformat, remembermetimeoutenabled, remembermetimeoutday, mailrecipients, trxid, oldid, searchstatus, searchmigrationduration, isusinges, usecustompasswordpolicy, minimumpasswordlength, passwordcontainscapitalletters, passwordcontainslowercaseletters, passwordcontainsnumericchars, passwordcontainsspecialchars, isusereporting)
SELECT s.id, s.name, s.sitename, s.isinactive, s.maxfailedloginattempt, s.passwordshelflife, s.passwordhealthyperiod, s.minimumuniquepasswordssequencelength, s.licenseblobid, s.sessiontimeoutenabled, s.sessiontimeoutminute, s.terminateidleenabled, s.terminateidleminute, s.dateformat, s.remembermetimeoutenabled, s.remembermetimeoutday, s.mailrecipients, s.trxid, s.oldid, s.searchstatus, s.searchmigrationduration, s.isusinges, s.usecustompasswordpolicy, s.minimumpasswordlength, s.passwordcontainscapitalletters, s.passwordcontainslowercaseletters, s.passwordcontainsnumericchars, s.passwordcontainsspecialchars, s.isusereporting
from ztmpclientmigration.clients s;

INSERT INTO public.client_ext(
id, contactfirstname, contactlastname, contactphone, contactemail, contactaddress1, contactaddress2, contactcity, contactzip, contactstateid, contactstateother, contactcountryid, cardtype, cardnumber, securitycode, expireddatebk, expireddate, registrationdate, productiondate, sameascontact, billingfirstname, billinglastname, billingphone, billingemail, billingaddress1, billingaddress2, billingcity, billingzip, billingstateid, billingstateother, billingcountryid, imageurl, branch, registrationdatebk, productiondatebk, subscriptiontype, opinsighturl, ispulseaccess, insightslimitaccessprojects)
SELECT s.id, s.contactfirstname, s.contactlastname, s.contactphone, s.contactemail, s.contactaddress1, s.contactaddress2, s.contactcity, s.contactzip, s.contactstateid, s.contactstateother, s.contactcountryid, s.cardtype, s.cardnumber, s.securitycode, s.expireddatebk, s.expireddate, s.registrationdate, s.productiondate, s.sameascontact, s.billingfirstname, s.billinglastname, s.billingphone, s.billingemail, s.billingaddress1, s.billingaddress2, s.billingcity, s.billingzip, s.billingstateid, s.billingstateother, s.billingcountryid, s.imageurl, s.branch, s.registrationdatebk, s.productiondatebk, s.subscriptiontype, s.opinsighturl, s.ispulseaccess, s.insightslimitaccessprojects
from ztmpclientmigration.client_ext s;

/* move to begin of aud section
insert into public.clients_aud (id, rev, revtype, name, sitename, isinactive, maxfailedloginattempt, passwordshelflife, passwordhealthyperiod, minimumuniquepasswordssequencelength, licenseblobid, sessiontimeoutenabled, sessiontimeoutminute, terminateidleenabled, terminateidleminute, dateformat, remembermetimeoutenabled, remembermetimeoutday, mailrecipients, isusinges, searchstatus, searchmigrationduration, usecustompasswordpolicy, minimumpasswordlength, passwordcontainscapitalletters, passwordcontainslowercaseletters, passwordcontainsnumericchars, passwordcontainsspecialchars, isusereporting)
select s.id, s.rev, s.revtype, s.name, s.sitename, s.isinactive, s.maxfailedloginattempt, s.passwordshelflife, s.passwordhealthyperiod, s.minimumuniquepasswordssequencelength, s.licenseblobid, s.sessiontimeoutenabled, s.sessiontimeoutminute, s.terminateidleenabled, s.terminateidleminute, s.dateformat, s.remembermetimeoutenabled, s.remembermetimeoutday, s.mailrecipients, s.isusinges, s.searchstatus, s.searchmigrationduration, s.usecustompasswordpolicy, s.minimumpasswordlength, s.passwordcontainscapitalletters, s.passwordcontainslowercaseletters, s.passwordcontainsnumericchars, s.passwordcontainsspecialchars, s.isusereporting
from ztmpclientmigration.clients_aud s;
*/

insert into public.users (id,mappedldapid,issampleuser,username,fromid,fromclientid)
select s.id,s.mappedldapid,s.issampleuser,s.username,s.id,s.fromclientid from ztmpclientmigration.users s
left join public.users d on s.id = d.id
where d.id is null;

-- no seq for users
/* no such case
insert into public.users (id,fromid,mappedldapid,issampleuser,username,fromclientid)
select ?,s.id,s.mappedldapid,s.issampleuser,s.username,s.fromclientid from ztmpclientmigration.users s
inner join public.users d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);*/


insert into public.user_ext (id,firstname,lastname,contactemail,imageurl,latestannouncementid,isnotloggedin,fromid,fromclientid)
select s.id,s.firstname,s.lastname,s.contactemail,s.imageurl,s.latestannouncementid,s.isnotloggedin,s.id,s.fromclientid from ztmpclientmigration.user_ext s
left join public.user_ext d on s.id = d.id
where d.id is null;


-- no seq for user_ext
-- use id from users

insert into public.user_ext (id,firstname,lastname,contactemail,imageurl,latestannouncementid,isnotloggedin,fromid,fromclientid)
select u.id,s.firstname,s.lastname,s.contactemail,s.imageurl,s.latestannouncementid,s.isnotloggedin,s.id,s.fromclientid from ztmpclientmigration.user_ext s
inner join public.user_ext d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id)
inner join public.users u on s.id = u.fromid
and u.fromid is not null;



insert into public.oauth_authentications (id,userid,clientid,appname,scopes,authentication,fromid,fromclientid)
select s.id,s.userid,s.clientid,s.appname,s.scopes,s.authentication,s.id,s.fromclientid from ztmpclientmigration.oauth_authentications s
left join public.oauth_authentications d on s.id = d.id
where d.id is null;



/* -- copy to after public.projects
insert into public.test_parameters (id,projectid,clientid,deleted,active,name,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.deleted,s.active,s.name,s.id,s.fromclientid from ztmpclientmigration.test_parameters s
left join public.test_parameters d on s.id = d.id
where d.id is null;
-- update rows autogenerated by trigger function
update public.pid_increment d
set increment = s.increment, fromid = s.id, fromclientid = s.fromclientid
from ztmpclientmigration.pid_increment s
inner join public.projects p on s.projectid = p.fromid
where p.fromclientid = s.fromclientid
and d.projectid = p.id
and d.fromid is null
and d.fromclientid is null
and d.objecttypeid = s.objecttypeid;
*/


insert into public.ldap_configuration (mappedemail,password,mappedusername,mappedfirstname,connected,mappedlastname,userdn,userobjectclass,basesearch,base,url,clientid,fromclientid)
select s.mappedemail,s.password,s.mappedusername,s.mappedfirstname,s.connected,s.mappedlastname,s.userdn,s.userobjectclass,s.basesearch,s.base,s.url,s.clientid,s.fromclientid from ztmpclientmigration.ldap_configuration s
left join public.ldap_configuration d on s.clientid = d.clientid
where d.clientid is null;

/* -- copy to after public.data_grid_views
insert into public.data_grid_view_fields (id,viewid,fieldid,displayorder,sorttype,sortorder,fromid,fromclientid)
select s.id,s.viewid,s.fieldid,s.displayorder,s.sorttype,s.sortorder,s.id,s.fromclientid from ztmpclientmigration.data_grid_view_fields s
left join public.data_grid_view_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_grid_view_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_grid_view_fields;
insert into public.data_grid_view_fields (fromid,viewid,fieldid,displayorder,sorttype,sortorder,fromclientid)
select s.id,s.viewid,s.fieldid,s.displayorder,s.sorttype,s.sortorder,s.fromclientid from ztmpclientmigration.data_grid_view_fields s
inner join public.data_grid_view_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
*/

-- end manual


insert into public.client_licenses (id,qmap,usersessionquota,maxnumberofsession,licensetype,maxnumberofwritableusers,packagetype,nextbillingdatebk,explorerenddatebk,explorerstartdatebk,explorerstatus,status,maxnumberofuser,licensetypeid,expireddatebk,nextbillingdate,explorerenddate,explorerstartdate,expireddate,activationdate,activationdatebk,helpdeskphone,helpdeskemail,clientid,fromid,fromclientid)
select s.id,s.qmap,s.usersessionquota,s.maxnumberofsession,s.licensetype,s.maxnumberofwritableusers,s.packagetype,s.nextbillingdatebk,s.explorerenddatebk,s.explorerstartdatebk,s.explorerstatus,s.status,s.maxnumberofuser,s.licensetypeid,s.expireddatebk,s.nextbillingdate,s.explorerenddate,s.explorerstartdate,s.expireddate,s.activationdate,s.activationdatebk,s.helpdeskphone,s.helpdeskemail,s.clientid,s.id,s.fromclientid from ztmpclientmigration.client_licenses s
left join public.client_licenses d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.client_licenses', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_licenses;
insert into public.client_licenses (fromid,qmap,usersessionquota,maxnumberofsession,licensetype,maxnumberofwritableusers,packagetype,nextbillingdatebk,explorerenddatebk,explorerstartdatebk,explorerstatus,status,maxnumberofuser,licensetypeid,expireddatebk,nextbillingdate,explorerenddate,explorerstartdate,expireddate,activationdate,activationdatebk,helpdeskphone,helpdeskemail,clientid,fromclientid)
select s.id,s.qmap,s.usersessionquota,s.maxnumberofsession,s.licensetype,s.maxnumberofwritableusers,s.packagetype,s.nextbillingdatebk,s.explorerenddatebk,s.explorerstartdatebk,s.explorerstatus,s.status,s.maxnumberofuser,s.licensetypeid,s.expireddatebk,s.nextbillingdate,s.explorerenddate,s.explorerstartdate,s.expireddate,s.activationdate,s.activationdatebk,s.helpdeskphone,s.helpdeskemail,s.clientid,s.fromclientid from ztmpclientmigration.client_licenses s
inner join public.client_licenses d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.external_auth_system_config (id,isactivated,authconfig,name,authtype,clientid,fromid,fromclientid)
select s.id,s.isactivated,s.authconfig,s.name,s.authtype,s.clientid,s.id,s.fromclientid from ztmpclientmigration.external_auth_system_config s
left join public.external_auth_system_config d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.external_auth_system_config', 'id'), coalesce(max(id),0) + 1, false) FROM public.external_auth_system_config;
insert into public.external_auth_system_config (fromid,isactivated,authconfig,name,authtype,clientid,fromclientid)
select s.id,s.isactivated,s.authconfig,s.name,s.authtype,s.clientid,s.fromclientid from ztmpclientmigration.external_auth_system_config s
inner join public.external_auth_system_config d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.client_settings (id,value,encryptedvalue,name,clientid,fromid,fromclientid)
select s.id,s.value,s.encryptedvalue,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.client_settings s
left join public.client_settings d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.client_settings', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_settings;
insert into public.client_settings (fromid,value,encryptedvalue,name,clientid,fromclientid)
select s.id,s.value,s.encryptedvalue,s.name,s.clientid,s.fromclientid from ztmpclientmigration.client_settings s
inner join public.client_settings d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.configuration_sets (id,oldid,trxid,name,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.configuration_sets s
left join public.configuration_sets d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.configuration_sets', 'id'), coalesce(max(id),0) + 1, false) FROM public.configuration_sets;
insert into public.configuration_sets (fromid,oldid,trxid,name,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.name,s.clientid,s.fromclientid from ztmpclientmigration.configuration_sets s
inner join public.configuration_sets d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.configurations (id,oldid,trxid,active,position,name,setid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.active,s.position,s.name,s.setid,s.id,s.fromclientid from ztmpclientmigration.configurations s
left join public.configurations d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.configurations', 'id'), coalesce(max(id),0) + 1, false) FROM public.configurations;
insert into public.configurations (fromid,oldid,trxid,active,position,name,setid,fromclientid)
select s.id,s.oldid,s.trxid,s.active,s.position,s.name,s.setid,s.fromclientid from ztmpclientmigration.configurations s
inner join public.configurations d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.configuration_variables (id,oldid,trxid,description,name,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.description,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.configuration_variables s
left join public.configuration_variables d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.configuration_variables', 'id'), coalesce(max(id),0) + 1, false) FROM public.configuration_variables;
insert into public.configuration_variables (fromid,oldid,trxid,description,name,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.description,s.name,s.clientid,s.fromclientid from ztmpclientmigration.configuration_variables s
inner join public.configuration_variables d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.client_users (id,tzcountryid,isinsightssu,externalauthconfigid,authtype,authenticatorid,mappedldapid,passwordneedschangingdate,passwordneedschangingdatebk,defaultexectool,isnotifiedtimezone,timezoneid,isshowtutorialprogressbar,isrootuser,lastlogintimebk,passwordexpirationdatebk,isdefaultclient,passwordmodifieddatebk,activateddatebk,lastlogintime,passwordexpirationdate,passwordmodifieddate,activateddate,createddate,createddatebk,activationcode,credentialnonexpired,encryptedpassword,salt,password,failedlogincount,isenteredclient,status,clientid,userid,fromid,fromclientid)
select s.id,s.tzcountryid,s.isinsightssu,s.externalauthconfigid,s.authtype,s.authenticatorid,s.mappedldapid,s.passwordneedschangingdate,s.passwordneedschangingdatebk,s.defaultexectool,s.isnotifiedtimezone,s.timezoneid,s.isshowtutorialprogressbar,s.isrootuser,s.lastlogintimebk,s.passwordexpirationdatebk,s.isdefaultclient,s.passwordmodifieddatebk,s.activateddatebk,s.lastlogintime,s.passwordexpirationdate,s.passwordmodifieddate,s.activateddate,s.createddate,s.createddatebk,s.activationcode,s.credentialnonexpired,s.encryptedpassword,s.salt,s.password,s.failedlogincount,s.isenteredclient,s.status,s.clientid,s.userid,s.id,s.fromclientid from ztmpclientmigration.client_users s
left join public.client_users d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.client_users', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_users;
insert into public.client_users (fromid,tzcountryid,isinsightssu,externalauthconfigid,authtype,authenticatorid,mappedldapid,passwordneedschangingdate,passwordneedschangingdatebk,defaultexectool,isnotifiedtimezone,timezoneid,isshowtutorialprogressbar,isrootuser,lastlogintimebk,passwordexpirationdatebk,isdefaultclient,passwordmodifieddatebk,activateddatebk,lastlogintime,passwordexpirationdate,passwordmodifieddate,activateddate,createddate,createddatebk,activationcode,credentialnonexpired,encryptedpassword,salt,password,failedlogincount,isenteredclient,status,clientid,userid,fromclientid)
select s.id,s.tzcountryid,s.isinsightssu,s.externalauthconfigid,s.authtype,s.authenticatorid,s.mappedldapid,s.passwordneedschangingdate,s.passwordneedschangingdatebk,s.defaultexectool,s.isnotifiedtimezone,s.timezoneid,s.isshowtutorialprogressbar,s.isrootuser,s.lastlogintimebk,s.passwordexpirationdatebk,s.isdefaultclient,s.passwordmodifieddatebk,s.activateddatebk,s.lastlogintime,s.passwordexpirationdate,s.passwordmodifieddate,s.activateddate,s.createddate,s.createddatebk,s.activationcode,s.credentialnonexpired,s.encryptedpassword,s.salt,s.password,s.failedlogincount,s.isenteredclient,s.status,s.clientid,s.userid,s.fromclientid from ztmpclientmigration.client_users s
inner join public.client_users d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.client_user_settings (id,clientid,clientuserid,name,value,fromid,fromclientid)
select s.id,s.clientid,s.clientuserid,s.name,s.value,s.id,s.fromclientid from ztmpclientmigration.client_user_settings s
left join public.client_user_settings d on s.id = d.id                                                             
where d.id is null;                                                                                                
select setval(pg_get_serial_sequence('public.client_user_settings', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_user_settings;
insert into public.client_user_settings (fromid,clientid,clientuserid,name,value,fromclientid)                    
select s.id,s.clientid,s.clientuserid,s.name,s.value,s.fromclientid from ztmpclientmigration.client_user_settings s   
inner join public.client_user_settings d on s.id = d.id                                                                
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.external_client_user (id,username,externalauthsystemconfigid,mapto,clientid,fromid,fromclientid)
select s.id,s.username,s.externalauthsystemconfigid,s.mapto,s.clientid,s.id,s.fromclientid from ztmpclientmigration.external_client_user s
left join public.external_client_user d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.external_client_user', 'id'), coalesce(max(id),0) + 1, false) FROM public.external_client_user;
insert into public.external_client_user (fromid,username,externalauthsystemconfigid,mapto,clientid,fromclientid)
select s.id,s.username,s.externalauthsystemconfigid,s.mapto,s.clientid,s.fromclientid from ztmpclientmigration.external_client_user s
inner join public.external_client_user d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.security_profiles (id,clientid,defaultgroupid,readonly,name,fromid,fromclientid)
select s.id,s.clientid,s.defaultgroupid,s.readonly,s.name,s.id,s.fromclientid from ztmpclientmigration.security_profiles s
left join public.security_profiles d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.security_profiles', 'id'), coalesce(max(id),0) + 1, false) FROM public.security_profiles;
insert into public.security_profiles (fromid,clientid,defaultgroupid,readonly,name,fromclientid)
select s.id,s.clientid,s.defaultgroupid,s.readonly,s.name,s.fromclientid from ztmpclientmigration.security_profiles s
inner join public.security_profiles d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.sso_idp_metadata_file (id,clientid,name,fromid,fromclientid)
select s.id,s.clientid,s.name,s.id,s.fromclientid from ztmpclientmigration.sso_idp_metadata_file s
left join public.sso_idp_metadata_file d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.sso_idp_metadata_file', 'id'), coalesce(max(id),0) + 1, false) FROM public.sso_idp_metadata_file;
insert into public.sso_idp_metadata_file (fromid,clientid,name,fromclientid)
select s.id,s.clientid,s.name,s.fromclientid from ztmpclientmigration.sso_idp_metadata_file s
inner join public.sso_idp_metadata_file d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.groups (id,defaultgroupid,defaultgroup,readonly,name,clientid,fromid,fromclientid)
select s.id,s.defaultgroupid,s.defaultgroup,s.readonly,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.groups s
left join public.groups d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.groups', 'id'), coalesce(max(id),0) + 1, false) FROM public.groups;
insert into public.groups (fromid,defaultgroupid,defaultgroup,readonly,name,clientid,fromclientid)
select s.id,s.defaultgroupid,s.defaultgroup,s.readonly,s.name,s.clientid,s.fromclientid from ztmpclientmigration.groups s
inner join public.groups d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.group_members (id,clientuserid,groupid,clientid,fromid,fromclientid)
select s.id,s.clientuserid,s.groupid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.group_members s
left join public.group_members d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.group_members', 'id'), coalesce(max(id),0) + 1, false) FROM public.group_members;
insert into public.group_members (fromid,clientuserid,groupid,clientid,fromclientid)
select s.id,s.clientuserid,s.groupid,s.clientid,s.fromclientid from ztmpclientmigration.group_members s
inner join public.group_members d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.group_authorities (id,authorityid,clientid,groupid,fromid,fromclientid)
select s.id,s.authorityid,s.clientid,s.groupid,s.id,s.fromclientid from ztmpclientmigration.group_authorities s
left join public.group_authorities d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.group_authorities', 'id'), coalesce(max(id),0) + 1, false) FROM public.group_authorities;
insert into public.group_authorities (fromid,authorityid,clientid,groupid,fromclientid)
select s.id,s.authorityid,s.clientid,s.groupid,s.fromclientid from ztmpclientmigration.group_authorities s
inner join public.group_authorities d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.acl_sid (id,sid,principal,fromid,fromclientid)
select s.id,s.sid,s.principal,s.id,s.fromclientid from ztmpclientmigration.acl_sid s
left join public.acl_sid d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.acl_sid', 'id'), coalesce(max(id),0) + 1, false) FROM public.acl_sid;
insert into public.acl_sid (fromid,sid,principal,fromclientid)
select s.id,s.sid,s.principal,s.fromclientid from ztmpclientmigration.acl_sid s
inner join public.acl_sid d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.acl_object_identity (id,oldid,trxid,entries_inheriting,parent_object,owner_sid,object_id_identity,object_id_class,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.entries_inheriting,s.parent_object,s.owner_sid,s.object_id_identity,s.object_id_class,s.id,s.fromclientid from ztmpclientmigration.acl_object_identity s
left join public.acl_object_identity d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.acl_object_identity', 'id'), coalesce(max(id),0) + 1, false) FROM public.acl_object_identity;
insert into public.acl_object_identity (fromid,oldid,trxid,entries_inheriting,parent_object,owner_sid,object_id_identity,object_id_class,fromclientid)
select s.id,s.oldid,s.trxid,s.entries_inheriting,s.parent_object,s.owner_sid,s.object_id_identity,s.object_id_class,s.fromclientid from ztmpclientmigration.acl_object_identity s
inner join public.acl_object_identity d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.acl_entry (id,audit_failure,audit_success,granting,ace_order,mask,sid,acl_object_identity,fromid,fromclientid)
select s.id,s.audit_failure,s.audit_success,s.granting,s.ace_order,s.mask,s.sid,s.acl_object_identity,s.id,s.fromclientid from ztmpclientmigration.acl_entry s
left join public.acl_entry d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.acl_entry', 'id'), coalesce(max(id),0) + 1, false) FROM public.acl_entry;
insert into public.acl_entry (fromid,audit_failure,audit_success,granting,ace_order,mask,sid,acl_object_identity,fromclientid)
select s.id,s.audit_failure,s.audit_success,s.granting,s.ace_order,s.mask,s.sid,s.acl_object_identity,s.fromclientid from ztmpclientmigration.acl_entry s
inner join public.acl_entry d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.license_blob_handles (id,name,blobsize,clientid,fromid,fromclientid)
select s.id,s.name,s.blobsize,s.clientid,s.id,s.fromclientid from ztmpclientmigration.license_blob_handles s
left join public.license_blob_handles d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.license_blob_handles', 'id'), coalesce(max(id),0) + 1, false) FROM public.license_blob_handles;
insert into public.license_blob_handles (fromid,name,blobsize,clientid,fromclientid)
select s.id,s.name,s.blobsize,s.clientid,s.fromclientid from ztmpclientmigration.license_blob_handles s
inner join public.license_blob_handles d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.custom_field_templates (id,isdefault,name,clientid,fromid,fromclientid)
select s.id,s.isdefault,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.custom_field_templates s
left join public.custom_field_templates d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_templates', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_templates;
insert into public.custom_field_templates (fromid,isdefault,name,clientid,fromclientid)
select s.id,s.isdefault,s.name,s.clientid,s.fromclientid from ztmpclientmigration.custom_field_templates s
inner join public.custom_field_templates d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.projects (id,indexingstatus,sourceprojectid,internally,customfieldtemplateid,defectworkflow,oldid,trxid,patchincidentstatus,clonestatus,automation,ispatchedincidents,issampleproject,projectstatusid,description,enddate,startdate,enddatebk,startdatebk,name,clientid,fromid,fromclientid)
select s.id,s.indexingstatus,s.sourceprojectid,s.internally,s.customfieldtemplateid,s.defectworkflow,s.oldid,s.trxid,s.patchincidentstatus,s.clonestatus,s.automation,s.ispatchedincidents,s.issampleproject,s.projectstatusid,s.description,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.projects s
left join public.projects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.projects', 'id'), coalesce(max(id),0) + 1, false) FROM public.projects;
insert into public.projects (fromid,indexingstatus,sourceprojectid,internally,customfieldtemplateid,defectworkflow,oldid,trxid,patchincidentstatus,clonestatus,automation,ispatchedincidents,issampleproject,projectstatusid,description,enddate,startdate,enddatebk,startdatebk,name,clientid,fromclientid)
select s.id,s.indexingstatus,s.sourceprojectid,s.internally,s.customfieldtemplateid,s.defectworkflow,s.oldid,s.trxid,s.patchincidentstatus,s.clonestatus,s.automation,s.ispatchedincidents,s.issampleproject,s.projectstatusid,s.description,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.name,s.clientid,s.fromclientid from ztmpclientmigration.projects s
inner join public.projects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_parameters (id,projectid,clientid,deleted,active,name,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.deleted,s.active,s.name,s.id,s.fromclientid from ztmpclientmigration.test_parameters s
left join public.test_parameters d on s.id = d.id
where d.id is null;
-- update rows autogenerated by trigger function
update public.pid_increment d
set increment = s.increment, fromid = s.id, fromclientid = s.fromclientid
from ztmpclientmigration.pid_increment s
inner join public.projects p on s.projectid = p.fromid
where p.fromclientid = s.fromclientid
and d.projectid = p.id
and d.fromid is null
and d.fromclientid is null
and d.objecttypeid = s.objecttypeid;
insert into insights.jira_report_fields (clientid,projectid,typeid,entrynumber,fieldname,fieldid,columnheading,columntype,columnformat,fromid,fromclientid)
select s.clientid,s.projectid,s.typeid,s.entrynumber,s.fieldname,s.fieldid,s.columnheading,s.columntype,s.columnformat,null,s.fromclientid from ztmpclientmigration.insights_jira_report_fields s;
insert into public.project_key_values (id,projectid,clientid,value,name,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.value,s.name,s.id,s.fromclientid from ztmpclientmigration.project_key_values s
left join public.project_key_values d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.project_key_values', 'id'), coalesce(max(id),0) + 1, false) FROM public.project_key_values;
insert into public.project_key_values (fromid,projectid,clientid,value,name,fromclientid)
select s.id,s.projectid,s.clientid,s.value,s.name,s.fromclientid from ztmpclientmigration.project_key_values s
inner join public.project_key_values d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.project_settings (id,projectid,clientid,value,name,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.value,s.name,s.id,s.fromclientid from ztmpclientmigration.project_settings s
left join public.project_settings d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.project_settings', 'id'), coalesce(max(id),0) + 1, false) FROM public.project_settings;
insert into public.project_settings (fromid,projectid,clientid,value,name,fromclientid)
select s.id,s.projectid,s.clientid,s.value,s.name,s.fromclientid from ztmpclientmigration.project_settings s
inner join public.project_settings d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.project_default_permissions (id,defaultpermissionid,projectsecurityprofileid,clientid,fromid,fromclientid)
select s.id,s.defaultpermissionid,s.projectsecurityprofileid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.project_default_permissions s
left join public.project_default_permissions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.project_default_permissions', 'id'), coalesce(max(id),0) + 1, false) FROM public.project_default_permissions;
insert into public.project_default_permissions (fromid,defaultpermissionid,projectsecurityprofileid,clientid,fromclientid)
select s.id,s.defaultpermissionid,s.projectsecurityprofileid,s.clientid,s.fromclientid from ztmpclientmigration.project_default_permissions s
inner join public.project_default_permissions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.client_user_sec_profiles (id,clientuserid,securityprofileid,projectid,clientid,fromid,fromclientid)
select s.id,s.clientuserid,s.securityprofileid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.client_user_sec_profiles s
left join public.client_user_sec_profiles d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.client_user_sec_profiles', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_user_sec_profiles;
insert into public.client_user_sec_profiles (fromid,clientuserid,securityprofileid,projectid,clientid,fromclientid)
select s.id,s.clientuserid,s.securityprofileid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.client_user_sec_profiles s
inner join public.client_user_sec_profiles d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.project_modules (id,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,shared,objorder,deleted,description,moduletype,isontestplan,name,parentmoduleid,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.shared,s.objorder,s.deleted,s.description,s.moduletype,s.isontestplan,s.name,s.parentmoduleid,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.project_modules s
left join public.project_modules d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.project_modules', 'id'), coalesce(max(id),0) + 1, false) FROM public.project_modules;
insert into public.project_modules (fromid,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,shared,objorder,deleted,description,moduletype,isontestplan,name,parentmoduleid,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.shared,s.objorder,s.deleted,s.description,s.moduletype,s.isontestplan,s.name,s.parentmoduleid,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.project_modules s
inner join public.project_modules d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.user_projects (id,isfavorite,projectid,clientid,userid,fromid,fromclientid)
select s.id,s.isfavorite,s.projectid,s.clientid,s.userid,s.id,s.fromclientid from ztmpclientmigration.user_projects s
left join public.user_projects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_projects', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_projects;
insert into public.user_projects (fromid,isfavorite,projectid,clientid,userid,fromclientid)
select s.id,s.isfavorite,s.projectid,s.clientid,s.userid,s.fromclientid from ztmpclientmigration.user_projects s
inner join public.user_projects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.user_criteria (id,strcriteria,location,createdby,projectid,clientid,fromid,fromclientid)
select s.id,s.strcriteria,s.location,s.createdby,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.user_criteria s
left join public.user_criteria d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_criteria', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_criteria;
insert into public.user_criteria (fromid,strcriteria,location,createdby,projectid,clientid,fromclientid)
select s.id,s.strcriteria,s.location,s.createdby,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.user_criteria s
inner join public.user_criteria d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_hosts (id,portconfig,hostconfig,version,pollingfrequency,tags,os,hostguid,statusexpiredtime,status,macaddress,ipaddress,hostname,clientid,fromid,fromclientid)
select s.id,s.portconfig,s.hostconfig,s.version,s.pollingfrequency,s.tags,s.os,s.hostguid,s.statusexpiredtime,s.status,s.macaddress,s.ipaddress,s.hostname,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_hosts s
left join public.automation_hosts d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_hosts', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_hosts;
insert into public.automation_hosts (fromid,portconfig,hostconfig,version,pollingfrequency,tags,os,hostguid,statusexpiredtime,status,macaddress,ipaddress,hostname,clientid,fromclientid)
select s.id,s.portconfig,s.hostconfig,s.version,s.pollingfrequency,s.tags,s.os,s.hostguid,s.statusexpiredtime,s.status,s.macaddress,s.ipaddress,s.hostname,s.clientid,s.fromclientid from ztmpclientmigration.automation_hosts s
inner join public.automation_hosts d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_agents (id,configuration,clientagentid,active,frameworkid,framework,name,hostid,projectid,clientid,fromid,fromclientid)
select s.id,s.configuration,s.clientagentid,s.active,s.frameworkid,s.framework,s.name,s.hostid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_agents s
left join public.automation_agents d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_agents', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_agents;
insert into public.automation_agents (fromid,configuration,clientagentid,active,frameworkid,framework,name,hostid,projectid,clientid,fromclientid)
select s.id,s.configuration,s.clientagentid,s.active,s.frameworkid,s.framework,s.name,s.hostid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.automation_agents s
inner join public.automation_agents d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_status_mapping (id,oldid,trxid,qteststatus,automationstatus,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.qteststatus,s.automationstatus,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_status_mapping s
left join public.automation_status_mapping d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_status_mapping', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_status_mapping;
insert into public.automation_status_mapping (fromid,oldid,trxid,qteststatus,automationstatus,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.qteststatus,s.automationstatus,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.automation_status_mapping s
inner join public.automation_status_mapping d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_upgrade_logs (id,clientid,downloadurl,upgradelogblobhandleid,toversion,fromversion,status,updatedon,scheduledon,scheduledby,hostid,fromid,fromclientid)
select s.id,s.clientid,s.downloadurl,s.upgradelogblobhandleid,s.toversion,s.fromversion,s.status,s.updatedon,s.scheduledon,s.scheduledby,s.hostid,s.id,s.fromclientid from ztmpclientmigration.automation_upgrade_logs s
left join public.automation_upgrade_logs d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_upgrade_logs', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_upgrade_logs;
insert into public.automation_upgrade_logs (fromid,clientid,downloadurl,upgradelogblobhandleid,toversion,fromversion,status,updatedon,scheduledon,scheduledby,hostid,fromclientid)
select s.id,s.clientid,s.downloadurl,s.upgradelogblobhandleid,s.toversion,s.fromversion,s.status,s.updatedon,s.scheduledon,s.scheduledby,s.hostid,s.fromclientid from ztmpclientmigration.automation_upgrade_logs s
inner join public.automation_upgrade_logs d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.blob_handles (id,oldid,trxid,createddate,minetypeid,name,blobsize,userid,objectid,objecttypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.createddate,s.minetypeid,s.name,s.blobsize,s.userid,s.objectid,s.objecttypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.blob_handles s
left join public.blob_handles d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.blob_handles', 'id'), coalesce(max(id),0) + 1, false) FROM public.blob_handles;
insert into public.blob_handles (fromid,oldid,trxid,createddate,minetypeid,name,blobsize,userid,objectid,objecttypeid,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.createddate,s.minetypeid,s.name,s.blobsize,s.userid,s.objectid,s.objecttypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.blob_handles s
inner join public.blob_handles d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_schedules (id,name,creatorid,startdate,enddate,repeattype,repeatperiod,agentid,deleted,settings,projectid,clientid,fromid,fromclientid) 
select s.id,s.name,s.creatorid,s.startdate,s.enddate,s.repeattype,s.repeatperiod,s.agentid,s.deleted,s.settings,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_schedules s 
left join public.automation_schedules d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_schedules', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_schedules; 
insert into public.automation_schedules (fromid,name,creatorid,startdate,enddate,repeattype,repeatperiod,agentid,deleted,settings,projectid,clientid,fromclientid) 
select s.id,s.name,s.creatorid,s.startdate,s.enddate,s.repeattype,s.repeatperiod,s.agentid,s.deleted,s.settings,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.automation_schedules s 
inner join public.automation_schedules d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_cancelled_executions (id,scheduleid,agentid,cancelleddate,objecttype,objectid,fromid,fromclientid) 
select s.id,s.scheduleid,s.agentid,s.cancelleddate,s.objecttype,s.objectid,s.id,s.fromclientid from ztmpclientmigration.automation_cancelled_executions s 
left join public.automation_cancelled_executions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_cancelled_executions', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_cancelled_executions; 
insert into public.automation_cancelled_executions (fromid,scheduleid,agentid,cancelleddate,objecttype,objectid,fromclientid)
select s.id,s.scheduleid,s.agentid,s.cancelleddate,s.objecttype,s.objectid,s.fromclientid from ztmpclientmigration.automation_cancelled_executions s 
inner join public.automation_cancelled_executions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_schedule_execution_maps (id,scheduleid,objecttype,objectid,deleted,projectid,clientid,fromid,fromclientid)
select s.id,s.scheduleid,s.objecttype,s.objectid,s.deleted,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_schedule_execution_maps s 
left join public.automation_schedule_execution_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_schedule_execution_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_schedule_execution_maps; 
insert into public.automation_schedule_execution_maps (fromid,scheduleid,objecttype,objectid,deleted,projectid,clientid,fromclientid)
select s.id,s.scheduleid,s.objecttype,s.objectid,s.deleted,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.automation_schedule_execution_maps s 
inner join public.automation_schedule_execution_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_execution_results (id,name,startdate,enddate,status,agentid,scheduleid,testrunids,agentlogblobhandleid,consolelogblobhandleid,executionstartdate,executionenddate,projectid,clientid,fromid,fromclientid) 
select s.id,s.name,s.startdate,s.enddate,s.status,s.agentid,s.scheduleid,s.testrunids,s.agentlogblobhandleid,s.consolelogblobhandleid,s.executionstartdate,s.executionenddate,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.automation_execution_results s
left join public.automation_execution_results d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_execution_results', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_execution_results; 
insert into public.automation_execution_results (fromid,name,startdate,enddate,status,agentid,scheduleid,testrunids,agentlogblobhandleid,consolelogblobhandleid,executionstartdate,executionenddate,projectid,clientid,fromclientid) 
select s.id,s.name,s.startdate,s.enddate,s.status,s.agentid,s.scheduleid,s.testrunids,s.agentlogblobhandleid,s.consolelogblobhandleid,s.executionstartdate,s.executionenddate,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.automation_execution_results s 
inner join public.automation_execution_results d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.automation_parsers (id,isdeleted,modifieddate,createddate,deleteduser,submitteduser,clientid,filename,filepath,parserblobhandleid,url,version,agenttypeid,type,name,fromid,fromclientid)
select s.id,s.isdeleted,s.modifieddate,s.createddate,s.deleteduser,s.submitteduser,s.clientid,s.filename,s.filepath,s.parserblobhandleid,s.url,s.version,s.agenttypeid,s.type,s.name,s.id,s.fromclientid from ztmpclientmigration.automation_parsers s
left join public.automation_parsers d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.automation_parsers', 'id'), coalesce(max(id),0) + 1, false) FROM public.automation_parsers;
insert into public.automation_parsers (fromid,isdeleted,modifieddate,createddate,deleteduser,submitteduser,clientid,filename,filepath,parserblobhandleid,url,version,agenttypeid,type,name,fromclientid)
select s.id,s.isdeleted,s.modifieddate,s.createddate,s.deleteduser,s.submitteduser,s.clientid,s.filename,s.filepath,s.parserblobhandleid,s.url,s.version,s.agenttypeid,s.type,s.name,s.fromclientid from ztmpclientmigration.automation_parsers s
inner join public.automation_parsers d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.audit_log (id,filetype,audittime,detail,filename,objectname,objectpid,objecttype,objectid,projectname,projectid,agent,ip,extauthname,extauthusername,eventtype,username,userid,appname,clientid,fromid,fromclientid)
select s.id,s.filetype,s.audittime,s.detail,s.filename,s.objectname,s.objectpid,s.objecttype,s.objectid,s.projectname,s.projectid,s.agent,s.ip,s.extauthname,s.extauthusername,s.eventtype,s.username,s.userid,s.appname,s.clientid,s.id,s.fromclientid from ztmpclientmigration.audit_log s
left join public.audit_log d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.audit_log', 'id'), coalesce(max(id),0) + 1, false) FROM public.audit_log;
insert into public.audit_log (fromid,filetype,audittime,detail,filename,objectname,objectpid,objecttype,objectid,projectname,projectid,agent,ip,extauthname,extauthusername,eventtype,username,userid,appname,clientid,fromclientid)
select s.id,s.filetype,s.audittime,s.detail,s.filename,s.objectname,s.objectpid,s.objecttype,s.objectid,s.projectname,s.projectid,s.agent,s.ip,s.extauthname,s.extauthusername,s.eventtype,s.username,s.userid,s.appname,s.clientid,s.fromclientid from ztmpclientmigration.audit_log s
inner join public.audit_log d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.revision_info (id,oldid,trxid,userid,timestamp,projectid,clientid,executionid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.userid,s.timestamp,s.projectid,s.clientid,s.executionid,s.id,s.fromclientid from ztmpclientmigration.revision_info s
left join public.revision_info d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.revision_info', 'id'), coalesce(max(id),0) + 1, false) FROM public.revision_info;
insert into public.revision_info (fromid,oldid,trxid,userid,timestamp,projectid,clientid,executionid,fromclientid)
select s.id,s.oldid,s.trxid,s.userid,s.timestamp,s.projectid,s.clientid,s.executionid,s.fromclientid from ztmpclientmigration.revision_info s
inner join public.revision_info d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.revision_aware (id,revid,objectid,objecttypeid,userid,projectid,clientid,fromid,fromclientid)
select s.id,s.revid,s.objectid,s.objecttypeid,s.userid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.revision_aware s
left join public.revision_aware d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.revision_aware', 'id'), coalesce(max(id),0) + 1, false) FROM public.revision_aware;
insert into public.revision_aware (fromid,revid,objectid,objecttypeid,userid,projectid,clientid,fromclientid)
select s.id,s.revid,s.objectid,s.objecttypeid,s.userid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.revision_aware s
inner join public.revision_aware d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.recycle_actions (id,deleted,deleteddate,deleteddatebk,deletedby,objecttypeid,objectid,projectid,clientid,fromid,fromclientid)
select s.id,s.deleted,s.deleteddate,s.deleteddatebk,s.deletedby,s.objecttypeid,s.objectid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.recycle_actions s
left join public.recycle_actions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.recycle_actions', 'id'), coalesce(max(id),0) + 1, false) FROM public.recycle_actions;
insert into public.recycle_actions (fromid,deleted,deleteddate,deleteddatebk,deletedby,objecttypeid,objectid,projectid,clientid,fromclientid)
select s.id,s.deleted,s.deleteddate,s.deleteddatebk,s.deletedby,s.objecttypeid,s.objectid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.recycle_actions s
inner join public.recycle_actions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.object_assignments (id,objecttypeid,projectid,clientid,completedatebk,completedate,targetdate,targetdatebk,userid,objectid,oldid,trxid,priorityid,assignmenttype,fromid,fromclientid)
select s.id,s.objecttypeid,s.projectid,s.clientid,s.completedatebk,s.completedate,s.targetdate,s.targetdatebk,s.userid,s.objectid,s.oldid,s.trxid,s.priorityid,s.assignmenttype,s.id,s.fromclientid from ztmpclientmigration.object_assignments s
left join public.object_assignments d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.object_assignments', 'id'), coalesce(max(id),0) + 1, false) FROM public.object_assignments;
insert into public.object_assignments (fromid,objecttypeid,projectid,clientid,completedatebk,completedate,targetdate,targetdatebk,userid,objectid,oldid,trxid,priorityid,assignmenttype,fromclientid)
select s.id,s.objecttypeid,s.projectid,s.clientid,s.completedatebk,s.completedate,s.targetdate,s.targetdatebk,s.userid,s.objectid,s.oldid,s.trxid,s.priorityid,s.assignmenttype,s.fromclientid from ztmpclientmigration.object_assignments s
inner join public.object_assignments d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.queue_event (id,inprogress,userid,projectid,clientid,endtimestamp,begintimestamp,exception,data,clazz,fromid,fromclientid)
select s.id,s.inprogress,s.userid,s.projectid,s.clientid,s.endtimestamp,s.begintimestamp,s.exception,s.data,s.clazz,s.id,s.fromclientid from ztmpclientmigration.queue_event s
left join public.queue_event d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.queue_event', 'id'), coalesce(max(id),0) + 1, false) FROM public.queue_event;
insert into public.queue_event (fromid,inprogress,userid,projectid,clientid,endtimestamp,begintimestamp,exception,data,clazz,fromclientid)
select s.id,s.inprogress,s.userid,s.projectid,s.clientid,s.endtimestamp,s.begintimestamp,s.exception,s.data,s.clazz,s.fromclientid from ztmpclientmigration.queue_event s
inner join public.queue_event d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.queue_processing_state (id,content,createdby,clientid,contenttype,state,type,createdon,fromid,fromclientid)
select s.id,s.content,s.createdby,s.clientid,s.contenttype,s.state,s.type,s.createdon,s.id,s.fromclientid from ztmpclientmigration.queue_processing_state s
left join public.queue_processing_state d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.queue_processing_state', 'id'), coalesce(max(id),0) + 1, false) FROM public.queue_processing_state;
insert into public.queue_processing_state (fromid,content,createdby,clientid,contenttype,state,type,createdon,fromclientid)
select s.id,s.content,s.createdby,s.clientid,s.contenttype,s.state,s.type,s.createdon,s.fromclientid from ztmpclientmigration.queue_processing_state s
inner join public.queue_processing_state d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.lookup (id,position,systemvalue,projectid,clientid,lookuptypeid,lookupvalue,fromid,fromclientid)
select s.id,s.position,s.systemvalue,s.projectid,s.clientid,s.lookuptypeid,s.lookupvalue,s.id,s.fromclientid from ztmpclientmigration.lookup s
left join public.lookup d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.lookup', 'id'), coalesce(max(id),0) + 1, false) FROM public.lookup;
insert into public.lookup (fromid,position,systemvalue,projectid,clientid,lookuptypeid,lookupvalue,fromclientid)
select s.id,s.position,s.systemvalue,s.projectid,s.clientid,s.lookuptypeid,s.lookupvalue,s.fromclientid from ztmpclientmigration.lookup s
inner join public.lookup d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_beds (id,oldid,trxid,deleted,name,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.deleted,s.name,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_beds s
left join public.test_beds d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_beds', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_beds;
insert into public.test_beds (fromid,oldid,trxid,deleted,name,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.deleted,s.name,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.test_beds s
inner join public.test_beds d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_data_sets (id,oldid,trxid,description,isontestplan,name,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.description,s.isontestplan,s.name,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_data_sets s
left join public.test_data_sets d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_data_sets', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_data_sets;
insert into public.test_data_sets (fromid,oldid,trxid,description,isontestplan,name,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.description,s.isontestplan,s.name,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.test_data_sets s
inner join public.test_data_sets d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.data_queries (id,timezoneid,type,createddate,createddatebk,createduserid,name,objecttypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.timezoneid,s.type,s.createddate,s.createddatebk,s.createduserid,s.name,s.objecttypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.data_queries s
left join public.data_queries d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_queries', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_queries;
insert into public.data_queries (fromid,timezoneid,type,createddate,createddatebk,createduserid,name,objecttypeid,projectid,clientid,fromclientid)
select s.id,s.timezoneid,s.type,s.createddate,s.createddatebk,s.createduserid,s.name,s.objecttypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.data_queries s
inner join public.data_queries d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.data_query_operators (id,settings,type,projectid,clientid,fromid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.data_query_operators s
left join public.data_query_operators d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_query_operators', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_query_operators;
insert into public.data_query_operators (fromid,settings,type,projectid,clientid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.data_query_operators s
inner join public.data_query_operators d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.data_query_conditions (id,settings,type,projectid,clientid,fromid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.data_query_conditions s
left join public.data_query_conditions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_query_conditions', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_query_conditions;
insert into public.data_query_conditions (fromid,settings,type,projectid,clientid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.data_query_conditions s
inner join public.data_query_conditions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.releases (id,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,modifieddate,modifieduserid,deleted,note,releasestatusid,enddate,startdate,enddatebk,startdatebk,releasedescription,releasename,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.modifieddate,s.modifieduserid,s.deleted,s.note,s.releasestatusid,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.releasedescription,s.releasename,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.releases s
left join public.releases d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.releases', 'id'), coalesce(max(id),0) + 1, false) FROM public.releases;
insert into public.releases (fromid,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,modifieddate,modifieduserid,deleted,note,releasestatusid,enddate,startdate,enddatebk,startdatebk,releasedescription,releasename,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.modifieddate,s.modifieduserid,s.deleted,s.note,s.releasestatusid,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.releasedescription,s.releasename,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.releases s
inner join public.releases d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.requirements (id,oldid,trxid,creatorid,createddatebk,indexmodifieddate,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,deleted,statusid,requirementpriorityid,isontestplan,buildid,releaseid,requirementtypeid,projectmoduleid,requirement,name,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.deleted,s.statusid,s.requirementpriorityid,s.isontestplan,s.buildid,s.releaseid,s.requirementtypeid,s.projectmoduleid,s.requirement,s.name,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.requirements s
left join public.requirements d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.requirements', 'id'), coalesce(max(id),0) + 1, false) FROM public.requirements;
insert into public.requirements (fromid,oldid,trxid,creatorid,createddatebk,indexmodifieddate,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,deleted,statusid,requirementpriorityid,isontestplan,buildid,releaseid,requirementtypeid,projectmoduleid,requirement,name,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.deleted,s.statusid,s.requirementpriorityid,s.isontestplan,s.buildid,s.releaseid,s.requirementtypeid,s.projectmoduleid,s.requirement,s.name,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.requirements s
inner join public.requirements d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.builds (id,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,deleted,buildstatusid,note,date,datebk,buildname,releaseid,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.deleted,s.buildstatusid,s.note,s.date,s.datebk,s.buildname,s.releaseid,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.builds s
left join public.builds d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.builds', 'id'), coalesce(max(id),0) + 1, false) FROM public.builds;
insert into public.builds (fromid,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,deleted,buildstatusid,note,date,datebk,buildname,releaseid,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.deleted,s.buildstatusid,s.note,s.date,s.datebk,s.buildname,s.releaseid,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.builds s
inner join public.builds d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_cycles (id,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,deleted,testcycletype,description,name,enddate,startdate,enddatebk,startdatebk,parenttestcycleid,releaseid,buildid,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.deleted,s.testcycletype,s.description,s.name,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.parenttestcycleid,s.releaseid,s.buildid,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.test_cycles s
left join public.test_cycles d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_cycles', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_cycles;
insert into public.test_cycles (fromid,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,deleted,testcycletype,description,name,enddate,startdate,enddatebk,startdatebk,parenttestcycleid,releaseid,buildid,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.deleted,s.testcycletype,s.description,s.name,s.enddate,s.startdate,s.enddatebk,s.startdatebk,s.parenttestcycleid,s.releaseid,s.buildid,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.test_cycles s
inner join public.test_cycles d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_suites (id,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,modifieddate,modifieduserid,testbedid,deleted,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,description,name,userid,buildid,releaseid,projecttesttypeid,testdatasetid,testcycleid,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.modifieddate,s.modifieduserid,s.testbedid,s.deleted,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.description,s.name,s.userid,s.buildid,s.releaseid,s.projecttesttypeid,s.testdatasetid,s.testcycleid,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.test_suites s
left join public.test_suites d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_suites', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_suites;
insert into public.test_suites (fromid,oldid,trxid,lastmodifieduserid,lastmodifieddate,creatorid,createddate,objorder,modifieddate,modifieduserid,testbedid,deleted,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,description,name,userid,buildid,releaseid,projecttesttypeid,testdatasetid,testcycleid,projectid,clientid,pid,fromclientid)
select s.id,s.oldid,s.trxid,s.lastmodifieduserid,s.lastmodifieddate,s.creatorid,s.createddate,s.objorder,s.modifieddate,s.modifieduserid,s.testbedid,s.deleted,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.description,s.name,s.userid,s.buildid,s.releaseid,s.projecttesttypeid,s.testdatasetid,s.testcycleid,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.test_suites s
inner join public.test_suites d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_cases (id,oldid,trxid,priorityid,shared,classidhashcode,classid,automationid,creatorid,createddatebk,indexmodifieddate,indexmodifieddatebk,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,latesttestcaseversionid,deleted,testcasetypeid,name,projectmoduleid,projectid,clientid,pid,latestrunresultid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.priorityid,s.shared,s.classidhashcode,s.classid,s.automationid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.indexmodifieddatebk,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.latesttestcaseversionid,s.deleted,s.testcasetypeid,s.name,s.projectmoduleid,s.projectid,s.clientid,s.pid,s.latestrunresultid,s.id,s.fromclientid from ztmpclientmigration.test_cases s
left join public.test_cases d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_cases', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_cases;
insert into public.test_cases (fromid,oldid,trxid,priorityid,shared,classidhashcode,classid,automationid,creatorid,createddatebk,indexmodifieddate,indexmodifieddatebk,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,latesttestcaseversionid,deleted,testcasetypeid,name,projectmoduleid,projectid,clientid,pid,latestrunresultid,fromclientid)
select s.id,s.oldid,s.trxid,s.priorityid,s.shared,s.classidhashcode,s.classid,s.automationid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.indexmodifieddatebk,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.latesttestcaseversionid,s.deleted,s.testcasetypeid,s.name,s.projectmoduleid,s.projectid,s.clientid,s.pid,s.latestrunresultid,s.fromclientid from ztmpclientmigration.test_cases s
inner join public.test_cases d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.requirement_test_cases (id,oldid,trxid,requirementid,testcaseid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.requirementid,s.testcaseid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.requirement_test_cases s
left join public.requirement_test_cases d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.requirement_test_cases', 'id'), coalesce(max(id),0) + 1, false) FROM public.requirement_test_cases;
insert into public.requirement_test_cases (fromid,oldid,trxid,requirementid,testcaseid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.requirementid,s.testcaseid,s.clientid,s.fromclientid from ztmpclientmigration.requirement_test_cases s
inner join public.requirement_test_cases d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_case_versions (id,oldid,trxid,modifieddate,modifieduserid,version,deleted,precondition,description,increasenumber,baselinenumber,testcaseversionstatusid,testcaseid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.modifieddate,s.modifieduserid,s.version,s.deleted,s.precondition,s.description,s.increasenumber,s.baselinenumber,s.testcaseversionstatusid,s.testcaseid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_case_versions s
left join public.test_case_versions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_case_versions', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_case_versions;
insert into public.test_case_versions (fromid,oldid,trxid,modifieddate,modifieduserid,version,deleted,precondition,description,increasenumber,baselinenumber,testcaseversionstatusid,testcaseid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.modifieddate,s.modifieduserid,s.version,s.deleted,s.precondition,s.description,s.increasenumber,s.baselinenumber,s.testcaseversionstatusid,s.testcaseid,s.clientid,s.fromclientid from ztmpclientmigration.test_case_versions s
inner join public.test_case_versions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.test_case_run (id,oldid,trxid,cisystemtype,buildurl,buildnumber,plannedexecutiontime,priorityid,configurationid,creatorid,createddatebk,indexmodifieddate,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,latesttestcaseresultid,deleted,runorder,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,name,projecttesttypeid,testbedid,userid,buildid,testcaseversionid,testcaseid,testsuiteid,testcycleid,releaseid,projectid,clientid,pid,latesttestexecutionresultid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.cisystemtype,s.buildurl,s.buildnumber,s.plannedexecutiontime,s.priorityid,s.configurationid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.latesttestcaseresultid,s.deleted,s.runorder,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.name,s.projecttesttypeid,s.testbedid,s.userid,s.buildid,s.testcaseversionid,s.testcaseid,s.testsuiteid,s.testcycleid,s.releaseid,s.projectid,s.clientid,s.pid,s.latesttestexecutionresultid,s.id,s.fromclientid from ztmpclientmigration.test_case_run s
left join public.test_case_run d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_case_run', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_case_run;
insert into public.test_case_run (fromid,oldid,trxid,cisystemtype,buildurl,buildnumber,plannedexecutiontime,priorityid,configurationid,creatorid,createddatebk,indexmodifieddate,lastmodifieduserid,createddate,lastmodifieddate,lastmodifieddatebk,objorder,latesttestcaseresultid,deleted,runorder,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,name,projecttesttypeid,testbedid,userid,buildid,testcaseversionid,testcaseid,testsuiteid,testcycleid,releaseid,projectid,clientid,pid,latesttestexecutionresultid,fromclientid)
select s.id,s.oldid,s.trxid,s.cisystemtype,s.buildurl,s.buildnumber,s.plannedexecutiontime,s.priorityid,s.configurationid,s.creatorid,s.createddatebk,s.indexmodifieddate,s.lastmodifieduserid,s.createddate,s.lastmodifieddate,s.lastmodifieddatebk,s.objorder,s.latesttestcaseresultid,s.deleted,s.runorder,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.name,s.projecttesttypeid,s.testbedid,s.userid,s.buildid,s.testcaseversionid,s.testcaseid,s.testsuiteid,s.testcycleid,s.releaseid,s.projectid,s.clientid,s.pid,s.latesttestexecutionresultid,s.fromclientid from ztmpclientmigration.test_case_run s
inner join public.test_case_run d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_steps (id,expectedresultmigrated,descriptionmigrated,oldid,trxid,runtestcaseversionid,steporder,expectedresult,description,testcaseversionid,clientid,fromid,fromclientid)
select s.id,s.expectedresultmigrated,s.descriptionmigrated,s.oldid,s.trxid,s.runtestcaseversionid,s.steporder,s.expectedresult,s.description,s.testcaseversionid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_steps s
left join public.test_steps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_steps', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_steps;
insert into public.test_steps (fromid,expectedresultmigrated,descriptionmigrated,oldid,trxid,runtestcaseversionid,steporder,expectedresult,description,testcaseversionid,clientid,fromclientid)
select s.id,s.expectedresultmigrated,s.descriptionmigrated,s.oldid,s.trxid,s.runtestcaseversionid,s.steporder,s.expectedresult,s.description,s.testcaseversionid,s.clientid,s.fromclientid from ztmpclientmigration.test_steps s
inner join public.test_steps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_case_results (id,edited,submittedby,testcaseid,automation,oldid,trxid,cisystemtype,buildurl,buildnumber,actualexecutiontime,plannedexecutiontime,configurationid,customfieldvalues,assigneduserid,testdatasetid,executionenddate,executionstartdate,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,resultnumber,executionenddatebk,executionstartdatebk,releaseid,buildid,executiontypeid,testexecutionresultid,testcaserunid,testcaseversionid,userid,clientid,fromid,fromclientid)
select s.id,s.edited,s.submittedby,s.testcaseid,s.automation,s.oldid,s.trxid,s.cisystemtype,s.buildurl,s.buildnumber,s.actualexecutiontime,s.plannedexecutiontime,s.configurationid,s.customfieldvalues,s.assigneduserid,s.testdatasetid,s.executionenddate,s.executionstartdate,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.resultnumber,s.executionenddatebk,s.executionstartdatebk,s.releaseid,s.buildid,s.executiontypeid,s.testexecutionresultid,s.testcaserunid,s.testcaseversionid,s.userid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_case_results s
left join public.test_case_results d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_case_results', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_case_results;
insert into public.test_case_results (fromid,edited,submittedby,testcaseid,automation,oldid,trxid,cisystemtype,buildurl,buildnumber,actualexecutiontime,plannedexecutiontime,configurationid,customfieldvalues,assigneduserid,testdatasetid,executionenddate,executionstartdate,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,resultnumber,executionenddatebk,executionstartdatebk,releaseid,buildid,executiontypeid,testexecutionresultid,testcaserunid,testcaseversionid,userid,clientid,fromclientid)
select s.id,s.edited,s.submittedby,s.testcaseid,s.automation,s.oldid,s.trxid,s.cisystemtype,s.buildurl,s.buildnumber,s.actualexecutiontime,s.plannedexecutiontime,s.configurationid,s.customfieldvalues,s.assigneduserid,s.testdatasetid,s.executionenddate,s.executionstartdate,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.resultnumber,s.executionenddatebk,s.executionstartdatebk,s.releaseid,s.buildid,s.executiontypeid,s.testexecutionresultid,s.testcaserunid,s.testcaseversionid,s.userid,s.clientid,s.fromclientid from ztmpclientmigration.test_case_results s
inner join public.test_case_results d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);


insert into public.test_step_results (id,actualresultmigrated,testcaseversionid,testcaserunid,testcaseid,oldid,trxid,calledtestcasename,calledtestcaseid,resultorder,actualresult,date,datebk,userid,testexecutionresultid,teststepid,testcaseresultid,clientid,fromid,fromclientid)
select s.id,s.actualresultmigrated,s.testcaseversionid,s.testcaserunid,s.testcaseid,s.oldid,s.trxid,s.calledtestcasename,s.calledtestcaseid,s.resultorder,s.actualresult,s.date,s.datebk,s.userid,s.testexecutionresultid,s.teststepid,s.testcaseresultid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_step_results s
left join public.test_step_results d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_step_results', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_step_results;
insert into public.test_step_results (fromid,actualresultmigrated,testcaseversionid,testcaserunid,testcaseid,oldid,trxid,calledtestcasename,calledtestcaseid,resultorder,actualresult,date,datebk,userid,testexecutionresultid,teststepid,testcaseresultid,clientid,fromclientid)
select s.id,s.actualresultmigrated,s.testcaseversionid,s.testcaserunid,s.testcaseid,s.oldid,s.trxid,s.calledtestcasename,s.calledtestcaseid,s.resultorder,s.actualresult,s.date,s.datebk,s.userid,s.testexecutionresultid,s.teststepid,s.testcaseresultid,s.clientid,s.fromclientid from ztmpclientmigration.test_step_results s
inner join public.test_step_results d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defects (id,unlinkeddefect,externalissueuniqueid,externalissuetype,url,externalissuestatus,externalissuesummary,externalprojectid,connectionid,externalissueid,oldid,trxid,indexflag,environmentid,indexmodifieddate,modifieddate,sourcedefectid,lastmodifieduserid,lastmodifieddatebk,draft,previousstatusid,envotherid,serverid,browserid,osid,fixedreleaseid,fixedbuildid,targetreleaseid,targetbuildid,affectedreleaseid,affectedbuildid,rootcauseid,categoryid,severityid,priorityid,reasonid,typeid,statusid,projectmoduleid,closeddatebk,targetdatebk,lastmodifieddate,closeddate,targetdate,createddate,createddatebk,description,summary,createduserid,assigneduserid,projectid,clientid,pid,fromid,fromclientid)
select s.id,s.unlinkeddefect,s.externalissueuniqueid,s.externalissuetype,s.url,s.externalissuestatus,s.externalissuesummary,s.externalprojectid,s.connectionid,s.externalissueid,s.oldid,s.trxid,s.indexflag,s.environmentid,s.indexmodifieddate,s.modifieddate,s.sourcedefectid,s.lastmodifieduserid,s.lastmodifieddatebk,s.draft,s.previousstatusid,s.envotherid,s.serverid,s.browserid,s.osid,s.fixedreleaseid,s.fixedbuildid,s.targetreleaseid,s.targetbuildid,s.affectedreleaseid,s.affectedbuildid,s.rootcauseid,s.categoryid,s.severityid,s.priorityid,s.reasonid,s.typeid,s.statusid,s.projectmoduleid,s.closeddatebk,s.targetdatebk,s.lastmodifieddate,s.closeddate,s.targetdate,s.createddate,s.createddatebk,s.description,s.summary,s.createduserid,s.assigneduserid,s.projectid,s.clientid,s.pid,s.id,s.fromclientid from ztmpclientmigration.defects s
left join public.defects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defects', 'id'), coalesce(max(id),0) + 1, false) FROM public.defects;
insert into public.defects (fromid,unlinkeddefect,externalissueuniqueid,externalissuetype,url,externalissuestatus,externalissuesummary,externalprojectid,connectionid,externalissueid,oldid,trxid,indexflag,environmentid,indexmodifieddate,modifieddate,sourcedefectid,lastmodifieduserid,lastmodifieddatebk,draft,previousstatusid,envotherid,serverid,browserid,osid,fixedreleaseid,fixedbuildid,targetreleaseid,targetbuildid,affectedreleaseid,affectedbuildid,rootcauseid,categoryid,severityid,priorityid,reasonid,typeid,statusid,projectmoduleid,closeddatebk,targetdatebk,lastmodifieddate,closeddate,targetdate,createddate,createddatebk,description,summary,createduserid,assigneduserid,projectid,clientid,pid,fromclientid)
select s.id,s.unlinkeddefect,s.externalissueuniqueid,s.externalissuetype,s.url,s.externalissuestatus,s.externalissuesummary,s.externalprojectid,s.connectionid,s.externalissueid,s.oldid,s.trxid,s.indexflag,s.environmentid,s.indexmodifieddate,s.modifieddate,s.sourcedefectid,s.lastmodifieduserid,s.lastmodifieddatebk,s.draft,s.previousstatusid,s.envotherid,s.serverid,s.browserid,s.osid,s.fixedreleaseid,s.fixedbuildid,s.targetreleaseid,s.targetbuildid,s.affectedreleaseid,s.affectedbuildid,s.rootcauseid,s.categoryid,s.severityid,s.priorityid,s.reasonid,s.typeid,s.statusid,s.projectmoduleid,s.closeddatebk,s.targetdatebk,s.lastmodifieddate,s.closeddate,s.targetdate,s.createddate,s.createddatebk,s.description,s.summary,s.createduserid,s.assigneduserid,s.projectid,s.clientid,s.pid,s.fromclientid from ztmpclientmigration.defects s
inner join public.defects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_case_result_defects (id,testcaseversionid,testcaserunid,testcaseid,externalissueuniqueid,oldid,trxid,externalissuetype,externalissueresolution,resulttype,externalprojectid,integrationconnectionid,externalissuestatus,externalissueurl,externalissuesummary,externalissueid,defectid,resultid,projectid,clientid,fromid,fromclientid)
select s.id,s.testcaseversionid,s.testcaserunid,s.testcaseid,s.externalissueuniqueid,s.oldid,s.trxid,s.externalissuetype,s.externalissueresolution,s.resulttype,s.externalprojectid,s.integrationconnectionid,s.externalissuestatus,s.externalissueurl,s.externalissuesummary,s.externalissueid,s.defectid,s.resultid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_case_result_defects s
left join public.test_case_result_defects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_case_result_defects', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_case_result_defects;
insert into public.test_case_result_defects (fromid,testcaseversionid,testcaserunid,testcaseid,externalissueuniqueid,oldid,trxid,externalissuetype,externalissueresolution,resulttype,externalprojectid,integrationconnectionid,externalissuestatus,externalissueurl,externalissuesummary,externalissueid,defectid,resultid,projectid,clientid,fromclientid)
select s.id,s.testcaseversionid,s.testcaserunid,s.testcaseid,s.externalissueuniqueid,s.oldid,s.trxid,s.externalissuetype,s.externalissueresolution,s.resulttype,s.externalprojectid,s.integrationconnectionid,s.externalissuestatus,s.externalissueurl,s.externalissuesummary,s.externalissueid,s.defectid,s.resultid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.test_case_result_defects s
inner join public.test_case_result_defects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_step_result_defects (id,defectprojectid,defecttrackingconnectionid,externaldefectid,defectid,teststepresultid,clientid,fromid,fromclientid)
select s.id,s.defectprojectid,s.defecttrackingconnectionid,s.externaldefectid,s.defectid,s.teststepresultid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.test_step_result_defects s
left join public.test_step_result_defects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_step_result_defects', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_step_result_defects;
insert into public.test_step_result_defects (fromid,defectprojectid,defecttrackingconnectionid,externaldefectid,defectid,teststepresultid,clientid,fromclientid)
select s.id,s.defectprojectid,s.defecttrackingconnectionid,s.externaldefectid,s.defectid,s.teststepresultid,s.clientid,s.fromclientid from ztmpclientmigration.test_step_result_defects s
inner join public.test_step_result_defects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.requirement_link_data (id,buildid,requirementid,releaseid,projectid,clientid,fromid,fromclientid)
select s.id,s.buildid,s.requirementid,s.releaseid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.requirement_link_data s
left join public.requirement_link_data d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.requirement_link_data', 'id'), coalesce(max(id),0) + 1, false) FROM public.requirement_link_data;
insert into public.requirement_link_data (fromid,buildid,requirementid,releaseid,projectid,clientid,fromclientid)
select s.id,s.buildid,s.requirementid,s.releaseid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.requirement_link_data s
inner join public.requirement_link_data d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.client_jira_connection (id,ispolled,systemid,customfieldname,customfieldid,serverurl,name,clientid,fromid,fromclientid)
select s.id,s.ispolled,s.systemid,s.customfieldname,s.customfieldid,s.serverurl,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.client_jira_connection s
left join public.client_jira_connection d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.client_jira_connection', 'id'), coalesce(max(id),0) + 1, false) FROM public.client_jira_connection;
insert into public.client_jira_connection (fromid,ispolled,systemid,customfieldname,customfieldid,serverurl,name,clientid,fromclientid)
select s.id,s.ispolled,s.systemid,s.customfieldname,s.customfieldid,s.serverurl,s.name,s.clientid,s.fromclientid from ztmpclientmigration.client_jira_connection s
inner join public.client_jira_connection d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_connection (id,populateunlinkdefects,releaseenabled,weburl,uniqueid,autoretrievescenarioreq,usescenario,migrate,requirementenabled,enabled,clientjiraconnectionid,configured,defecttrackingsystemid,active,encryptedpassword,password,username,serverurl,name,projectid,clientid,releaseautofilter,fromid,fromclientid)
select s.id,s.populateunlinkdefects,s.releaseenabled,s.weburl,s.uniqueid,s.autoretrievescenarioreq,s.usescenario,s.migrate,s.requirementenabled,s.enabled,s.clientjiraconnectionid,s.configured,s.defecttrackingsystemid,s.active,s.encryptedpassword,s.password,s.username,s.serverurl,s.name,s.projectid,s.clientid,s.releaseautofilter,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_connection s
left join public.defect_tracking_connection d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_connection', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_connection;
insert into public.defect_tracking_connection (fromid,populateunlinkdefects,releaseenabled,weburl,uniqueid,autoretrievescenarioreq,usescenario,migrate,requirementenabled,enabled,clientjiraconnectionid,configured,defecttrackingsystemid,active,encryptedpassword,password,username,serverurl,name,projectid,clientid,releaseautofilter,fromclientid)
select s.id,s.populateunlinkdefects,s.releaseenabled,s.weburl,s.uniqueid,s.autoretrievescenarioreq,s.usescenario,s.migrate,s.requirementenabled,s.enabled,s.clientjiraconnectionid,s.configured,s.defecttrackingsystemid,s.active,s.encryptedpassword,s.password,s.username,s.serverurl,s.name,s.projectid,s.clientid,s.releaseautofilter,s.fromclientid from ztmpclientmigration.defect_tracking_connection s
inner join public.defect_tracking_connection d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_connection_test (id,weburl,password,username,serverurl,name,projectid,clientid,fromid,fromclientid)
select s.id,s.weburl,s.password,s.username,s.serverurl,s.name,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_connection_test s
left join public.defect_tracking_connection_test d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_connection_test', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_connection_test;
insert into public.defect_tracking_connection_test (fromid,weburl,password,username,serverurl,name,projectid,clientid,fromclientid)
select s.id,s.weburl,s.password,s.username,s.serverurl,s.name,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_tracking_connection_test s
inner join public.defect_tracking_connection_test d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_usage (id,usinginternalsystem,projectid,clientid,fromid,fromclientid)
select s.id,s.usinginternalsystem,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_usage s
left join public.defect_tracking_usage d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_usage', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_usage;
insert into public.defect_tracking_usage (fromid,usinginternalsystem,projectid,clientid,fromclientid)
select s.id,s.usinginternalsystem,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_tracking_usage s
inner join public.defect_tracking_usage d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_project (id,active,populated,defecttrackingconnectionid,name,defectprojectid,projectid,clientid,fromid,fromclientid)
select s.id,s.active,s.populated,s.defecttrackingconnectionid,s.name,s.defectprojectid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_project s
left join public.defect_tracking_project d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_project', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_project;
insert into public.defect_tracking_project (fromid,active,populated,defecttrackingconnectionid,name,defectprojectid,projectid,clientid,fromclientid)
select s.id,s.active,s.populated,s.defecttrackingconnectionid,s.name,s.defectprojectid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_tracking_project s
inner join public.defect_tracking_project d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_type (id,lastsync,polled,pollexception,integrationprojectid,defecttrackingconnectionid,label,name,projectid,clientid,fromid,fromclientid)
select s.id,s.lastsync,s.polled,s.pollexception,s.integrationprojectid,s.defecttrackingconnectionid,s.label,s.name,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_type s
left join public.defect_tracking_type d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_type', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_type;
insert into public.defect_tracking_type (fromid,lastsync,polled,pollexception,integrationprojectid,defecttrackingconnectionid,label,name,projectid,clientid,fromclientid)
select s.id,s.lastsync,s.polled,s.pollexception,s.integrationprojectid,s.defecttrackingconnectionid,s.label,s.name,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_tracking_type s
inner join public.defect_tracking_type d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_tracking_field (id,defecttrackingprojectid,defecttrackingtypeid,listautofillfield,listfieldvalue,defaultvalue,displaytype,multivalue,required,active,label,name,displayorder,projectid,clientid,fromid,fromclientid)
select s.id,s.defecttrackingprojectid,s.defecttrackingtypeid,s.listautofillfield,s.listfieldvalue,s.defaultvalue,s.displaytype,s.multivalue,s.required,s.active,s.label,s.name,s.displayorder,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_tracking_field s
left join public.defect_tracking_field d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_tracking_field', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_tracking_field;
insert into public.defect_tracking_field (fromid,defecttrackingprojectid,defecttrackingtypeid,listautofillfield,listfieldvalue,defaultvalue,displaytype,multivalue,required,active,label,name,displayorder,projectid,clientid,fromclientid)
select s.id,s.defecttrackingprojectid,s.defecttrackingtypeid,s.listautofillfield,s.listfieldvalue,s.defaultvalue,s.displaytype,s.multivalue,s.required,s.active,s.label,s.name,s.displayorder,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_tracking_field s
inner join public.defect_tracking_field d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.integration_identifier_fields (id,externalfieldname,externalfieldid,fromid,fromclientid)
select s.id,s.externalfieldname,s.externalfieldid,s.id,s.fromclientid from ztmpclientmigration.integration_identifier_fields s
left join public.integration_identifier_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_identifier_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_identifier_fields;
insert into public.integration_identifier_fields (fromid,externalfieldname,externalfieldid,fromclientid)
select s.id,s.externalfieldname,s.externalfieldid,s.fromclientid from ztmpclientmigration.integration_identifier_fields s
inner join public.integration_identifier_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_external_defect_issue_data (id,projectid,clientid,externalissuefieldvalue,externalissuefieldid,defectid,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.externalissuefieldvalue,s.externalissuefieldid,s.defectid,s.id,s.fromclientid from ztmpclientmigration.integration_external_defect_issue_data s
left join public.integration_external_defect_issue_data d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_external_defect_issue_data', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_external_defect_issue_data;
insert into public.integration_external_defect_issue_data (fromid,projectid,clientid,externalissuefieldvalue,externalissuefieldid,defectid,fromclientid)
select s.id,s.projectid,s.clientid,s.externalissuefieldvalue,s.externalissuefieldid,s.defectid,s.fromclientid from ztmpclientmigration.integration_external_defect_issue_data s
inner join public.integration_external_defect_issue_data d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_defect_issue_data (id,projectid,clientid,externalissuefieldvalue,externalissuefieldid,testcaseresultdefectid,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.externalissuefieldvalue,s.externalissuefieldid,s.testcaseresultdefectid,s.id,s.fromclientid from ztmpclientmigration.integration_defect_issue_data s
left join public.integration_defect_issue_data d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_defect_issue_data', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_defect_issue_data;
insert into public.integration_defect_issue_data (fromid,projectid,clientid,externalissuefieldvalue,externalissuefieldid,testcaseresultdefectid,fromclientid)
select s.id,s.projectid,s.clientid,s.externalissuefieldvalue,s.externalissuefieldid,s.testcaseresultdefectid,s.fromclientid from ztmpclientmigration.integration_defect_issue_data s
inner join public.integration_defect_issue_data d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_projects (id,connectionid,externalprojectname,externalprojectid,isactive,startdate,enddate,fromid,fromclientid)
select s.id,s.connectionid,s.externalprojectname,s.externalprojectid,s.isactive,s.startdate,s.enddate,s.id,s.fromclientid from ztmpclientmigration.integration_projects s
left join public.integration_projects d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_projects', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_projects;
insert into public.integration_projects (fromid,connectionid,externalprojectname,externalprojectid,isactive,startdate,enddate,fromclientid)
select s.id,s.connectionid,s.externalprojectname,s.externalprojectid,s.isactive,s.startdate,s.enddate,s.fromclientid from ztmpclientmigration.integration_projects s
inner join public.integration_projects d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_type_maps (id,polled,includechildprojects,pollexception,lastsync,lastsyncbk,externalfilterid,integrationprojectid,qtesttypeid,externaltypename,externaltypeid,fromid,fromclientid)
select s.id,s.polled,s.includechildprojects,s.pollexception,s.lastsync,s.lastsyncbk,s.externalfilterid,s.integrationprojectid,s.qtesttypeid,s.externaltypename,s.externaltypeid,s.id,s.fromclientid from ztmpclientmigration.integration_type_maps s
left join public.integration_type_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_type_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_type_maps;
insert into public.integration_type_maps (fromid,polled,includechildprojects,pollexception,lastsync,lastsyncbk,externalfilterid,integrationprojectid,qtesttypeid,externaltypename,externaltypeid,fromclientid)
select s.id,s.polled,s.includechildprojects,s.pollexception,s.lastsync,s.lastsyncbk,s.externalfilterid,s.integrationprojectid,s.qtesttypeid,s.externaltypename,s.externaltypeid,s.fromclientid from ztmpclientmigration.integration_type_maps s
inner join public.integration_type_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_requirement_field_maps (id,fixed,integrationtypemapid,active,externalfieldid,qtestfieldname,fromid,fromclientid)
select s.id,s.fixed,s.integrationtypemapid,s.active,s.externalfieldid,s.qtestfieldname,s.id,s.fromclientid from ztmpclientmigration.integration_requirement_field_maps s
left join public.integration_requirement_field_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_requirement_field_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_requirement_field_maps;
insert into public.integration_requirement_field_maps (fromid,fixed,integrationtypemapid,active,externalfieldid,qtestfieldname,fromclientid)
select s.id,s.fixed,s.integrationtypemapid,s.active,s.externalfieldid,s.qtestfieldname,s.fromclientid from ztmpclientmigration.integration_requirement_field_maps s
inner join public.integration_requirement_field_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.integration_release_configuration (id,externalfieldid,autopopulate,mappedtype,integrationtypemapid,values,fromid,fromclientid)
select s.id,s.externalfieldid,s.autopopulate,s.mappedtype,s.integrationtypemapid,s.values,s.id,s.fromclientid from ztmpclientmigration.integration_release_configuration s
left join public.integration_release_configuration d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_release_configuration', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_release_configuration;
insert into public.integration_release_configuration (fromid,externalfieldid,autopopulate,mappedtype,integrationtypemapid,values,fromclientid)
select s.id,s.externalfieldid,s.autopopulate,s.mappedtype,s.integrationtypemapid,s.values,s.fromclientid from ztmpclientmigration.integration_release_configuration s
inner join public.integration_release_configuration d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_issue_release_maps (id,integrationtypemapid,externalissuelink,externalissueid,releaseid,projectid,clientid,fromid,fromclientid)
select s.id,s.integrationtypemapid,s.externalissuelink,s.externalissueid,s.releaseid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_issue_release_maps s
left join public.integration_issue_release_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_issue_release_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_issue_release_maps;
insert into public.integration_issue_release_maps (fromid,integrationtypemapid,externalissuelink,externalissueid,releaseid,projectid,clientid,fromclientid)
select s.id,s.integrationtypemapid,s.externalissuelink,s.externalissueid,s.releaseid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_issue_release_maps s
inner join public.integration_issue_release_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_release_data (id,integrationissuereleasemapid,externalissuefieldvalue,externalissuefieldid,fromid,fromclientid)
select s.id,s.integrationissuereleasemapid,s.externalissuefieldvalue,s.externalissuefieldid,s.id,s.fromclientid from ztmpclientmigration.integration_release_data s
left join public.integration_release_data d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_release_data', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_release_data;
insert into public.integration_release_data (fromid,integrationissuereleasemapid,externalissuefieldvalue,externalissuefieldid,fromclientid)
select s.id,s.integrationissuereleasemapid,s.externalissuefieldvalue,s.externalissuefieldid,s.fromclientid from ztmpclientmigration.integration_release_data s
inner join public.integration_release_data d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_external_issues (id,externalprojectid,externalissueid,connectionid,projectid,clientid,fromid,fromclientid)
select s.id,s.externalprojectid,s.externalissueid,s.connectionid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_external_issues s
left join public.integration_external_issues d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_external_issues', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_external_issues;
insert into public.integration_external_issues (fromid,externalprojectid,externalissueid,connectionid,projectid,clientid,fromclientid)
select s.id,s.externalprojectid,s.externalissueid,s.connectionid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_external_issues s
inner join public.integration_external_issues d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_issue_test_case_maps (id,referencecount,externallinkid,externalissueid,testcaseid,projectid,clientid,fromid,fromclientid)
select s.id,s.referencecount,s.externallinkid,s.externalissueid,s.testcaseid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_issue_test_case_maps s
left join public.integration_issue_test_case_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_issue_test_case_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_issue_test_case_maps;
insert into public.integration_issue_test_case_maps (fromid,referencecount,externallinkid,externalissueid,testcaseid,projectid,clientid,fromclientid)
select s.id,s.referencecount,s.externallinkid,s.externalissueid,s.testcaseid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_issue_test_case_maps s
inner join public.integration_issue_test_case_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_issue_requirement_maps (id,integrationtypemapid,externalissuelink,externalissueid,requirementid,projectid,clientid,externalissueuniqueid,fromid,fromclientid)
select s.id,s.integrationtypemapid,s.externalissuelink,s.externalissueid,s.requirementid,s.projectid,s.clientid,s.externalissueuniqueid,s.id,s.fromclientid from ztmpclientmigration.integration_issue_requirement_maps s
left join public.integration_issue_requirement_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_issue_requirement_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_issue_requirement_maps;
insert into public.integration_issue_requirement_maps (fromid,integrationtypemapid,externalissuelink,externalissueid,requirementid,projectid,clientid,externalissueuniqueid,fromclientid)
select s.id,s.integrationtypemapid,s.externalissuelink,s.externalissueid,s.requirementid,s.projectid,s.clientid,s.externalissueuniqueid,s.fromclientid from ztmpclientmigration.integration_issue_requirement_maps s
inner join public.integration_issue_requirement_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_issue_data (id,integrationissuerequirementmapid,externalissuefieldvalue,externalissuefieldid,customfieldintegrationvalueid,fromid,fromclientid)
select s.id,s.integrationissuerequirementmapid,s.externalissuefieldvalue,s.externalissuefieldid,s.customfieldintegrationvalueid,s.id,s.fromclientid from ztmpclientmigration.integration_issue_data s
left join public.integration_issue_data d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_issue_data', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_issue_data;
insert into public.integration_issue_data (fromid,integrationissuerequirementmapid,externalissuefieldvalue,externalissuefieldid,customfieldintegrationvalueid,fromclientid)
select s.id,s.integrationissuerequirementmapid,s.externalissuefieldvalue,s.externalissuefieldid,s.customfieldintegrationvalueid,s.fromclientid from ztmpclientmigration.integration_issue_data s
inner join public.integration_issue_data d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_external_issues_maps (id,referencecount,externallinkid,toexternalissueid,fromexternalissueid,projectid,clientid,fromid,fromclientid)
select s.id,s.referencecount,s.externallinkid,s.toexternalissueid,s.fromexternalissueid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_external_issues_maps s
left join public.integration_external_issues_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_external_issues_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_external_issues_maps;
insert into public.integration_external_issues_maps (fromid,referencecount,externallinkid,toexternalissueid,fromexternalissueid,projectid,clientid,fromclientid)
select s.id,s.referencecount,s.externallinkid,s.toexternalissueid,s.fromexternalissueid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_external_issues_maps s
inner join public.integration_external_issues_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_webhooks (id,projectid,clientid,webhookid,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.webhookid,s.id,s.fromclientid from ztmpclientmigration.integration_webhooks s
left join public.integration_webhooks d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_webhooks', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_webhooks;
insert into public.integration_webhooks (fromid,projectid,clientid,webhookid,fromclientid)
select s.id,s.projectid,s.clientid,s.webhookid,s.fromclientid from ztmpclientmigration.integration_webhooks s
inner join public.integration_webhooks d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.configuration_migration_tracking (id,migrated,migrationtype,uniqueid,webhookid,projectid,clientid,fromid,fromclientid)
select s.id,s.migrated,s.migrationtype,s.uniqueid,s.webhookid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.configuration_migration_tracking s
left join public.configuration_migration_tracking d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.configuration_migration_tracking', 'id'), coalesce(max(id),0) + 1, false) FROM public.configuration_migration_tracking;
insert into public.configuration_migration_tracking (fromid,migrated,migrationtype,uniqueid,webhookid,projectid,clientid,fromclientid)
select s.id,s.migrated,s.migrationtype,s.uniqueid,s.webhookid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.configuration_migration_tracking s
inner join public.configuration_migration_tracking d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_sync_requirement_tracker (id,createddate,modulelevel,originalname,moduleid,requirementid,parentmoduleid,projectid,clientid,fromid,fromclientid)
select s.id,s.createddate,s.modulelevel,s.originalname,s.moduleid,s.requirementid,s.parentmoduleid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_sync_requirement_tracker s
left join public.integration_sync_requirement_tracker d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_sync_requirement_tracker', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_sync_requirement_tracker;
insert into public.integration_sync_requirement_tracker (fromid,createddate,modulelevel,originalname,moduleid,requirementid,parentmoduleid,projectid,clientid,fromclientid)
select s.id,s.createddate,s.modulelevel,s.originalname,s.moduleid,s.requirementid,s.parentmoduleid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_sync_requirement_tracker s
inner join public.integration_sync_requirement_tracker d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_issue_test_case_run_maps (id,linkid,externalprojectid,externalissueid,testrunid,connectionid,projectid,clientid,fromid,fromclientid)
select s.id,s.linkid,s.externalprojectid,s.externalissueid,s.testrunid,s.connectionid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.integration_issue_test_case_run_maps s
left join public.integration_issue_test_case_run_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_issue_test_case_run_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_issue_test_case_run_maps;
insert into public.integration_issue_test_case_run_maps (fromid,linkid,externalprojectid,externalissueid,testrunid,connectionid,projectid,clientid,fromclientid)
select s.id,s.linkid,s.externalprojectid,s.externalissueid,s.testrunid,s.connectionid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.integration_issue_test_case_run_maps s
inner join public.integration_issue_test_case_run_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_defect_fields (id,integrationtypemapid,newtypemap,externalfieldname,externalfieldid,fromid,fromclientid)
select s.id,s.integrationtypemapid,s.newtypemap,s.externalfieldname,s.externalfieldid,s.id,s.fromclientid from ztmpclientmigration.integration_defect_fields s
left join public.integration_defect_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_defect_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_defect_fields;
insert into public.integration_defect_fields (fromid,integrationtypemapid,newtypemap,externalfieldname,externalfieldid,fromclientid)
select s.id,s.integrationtypemapid,s.newtypemap,s.externalfieldname,s.externalfieldid,s.fromclientid from ztmpclientmigration.integration_defect_fields s
inner join public.integration_defect_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_module_fields (id,integrationtypemapid,fieldorder,label,name,fromid,fromclientid)
select s.id,s.integrationtypemapid,s.fieldorder,s.label,s.name,s.id,s.fromclientid from ztmpclientmigration.integration_module_fields s
left join public.integration_module_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_module_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_module_fields;
insert into public.integration_module_fields (fromid,integrationtypemapid,fieldorder,label,name,fromclientid)
select s.id,s.integrationtypemapid,s.fieldorder,s.label,s.name,s.fromclientid from ztmpclientmigration.integration_module_fields s
inner join public.integration_module_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.integration_defect_field_maps (id,integrationtypemapid,qtestfieldids,externalfieldname,externalfieldid,fromid,fromclientid)
select s.id,s.integrationtypemapid,s.qtestfieldids,s.externalfieldname,s.externalfieldid,s.id,s.fromclientid from ztmpclientmigration.integration_defect_field_maps s
left join public.integration_defect_field_maps d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_defect_field_maps', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_defect_field_maps;
insert into public.integration_defect_field_maps (fromid,integrationtypemapid,qtestfieldids,externalfieldname,externalfieldid,fromclientid)
select s.id,s.integrationtypemapid,s.qtestfieldids,s.externalfieldname,s.externalfieldid,s.fromclientid from ztmpclientmigration.integration_defect_field_maps s
inner join public.integration_defect_field_maps d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.custom_field_data_types (id,settings,type,projectid,clientid,fromid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.custom_field_data_types s
left join public.custom_field_data_types d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_data_types', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_data_types;
insert into public.custom_field_data_types (fromid,settings,type,projectid,clientid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.custom_field_data_types s
inner join public.custom_field_data_types d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.custom_fields (id,integrationdefectfieldid,defecttrackingconnectionid,sitefieldid,searchindex,freetextsearch,searchkey,searchable,systemfield,active,displayorder,name,datatypeid,objecttypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.integrationdefectfieldid,s.defecttrackingconnectionid,s.sitefieldid,s.searchindex,s.freetextsearch,s.searchkey,s.searchable,s.systemfield,s.active,s.displayorder,s.name,s.datatypeid,s.objecttypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.custom_fields s
left join public.custom_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_fields;
insert into public.custom_fields (fromid,integrationdefectfieldid,defecttrackingconnectionid,sitefieldid,searchindex,freetextsearch,searchkey,searchable,systemfield,active,displayorder,name,datatypeid,objecttypeid,projectid,clientid,fromclientid)
select s.id,s.integrationdefectfieldid,s.defecttrackingconnectionid,s.sitefieldid,s.searchindex,s.freetextsearch,s.searchkey,s.searchable,s.systemfield,s.active,s.displayorder,s.name,s.datatypeid,s.objecttypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.custom_fields s
inner join public.custom_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.custom_field_validators (id,settings,type,projectid,clientid,fromid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.custom_field_validators s
left join public.custom_field_validators d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_validators', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_validators;
insert into public.custom_field_validators (fromid,settings,type,projectid,clientid,fromclientid)
select s.id,s.settings,s.type,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.custom_field_validators s
inner join public.custom_field_validators d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.custom_field_configurations (id,sitefieldconfigurationid,valueid,value,attribute,customfieldid,integrationcustomfieldconfigurationid,fromid,fromclientid)
select s.id,s.sitefieldconfigurationid,s.valueid,s.value,s.attribute,s.customfieldid,s.integrationcustomfieldconfigurationid,s.id,s.fromclientid from ztmpclientmigration.custom_field_configurations s
left join public.custom_field_configurations d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_configurations', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_configurations;
insert into public.custom_field_configurations (fromid,sitefieldconfigurationid,valueid,value,attribute,customfieldid,integrationcustomfieldconfigurationid,fromclientid)
select s.id,s.sitefieldconfigurationid,s.valueid,s.value,s.attribute,s.customfieldid,s.integrationcustomfieldconfigurationid,s.fromclientid from ztmpclientmigration.custom_field_configurations s
inner join public.custom_field_configurations d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.custom_field_values (id,value,objectid,customfieldid,fromid,fromclientid)
select s.id,s.value,s.objectid,s.customfieldid,s.id,s.fromclientid from ztmpclientmigration.custom_field_values s
left join public.custom_field_values d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_values', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_values;
insert into public.custom_field_values (fromid,value,objectid,customfieldid,fromclientid)
select s.id,s.value,s.objectid,s.customfieldid,s.fromclientid from ztmpclientmigration.custom_field_values s
inner join public.custom_field_values d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.custom_field_template_field_mapping (id,customfieldid,templateid,clientid,fromid,fromclientid)
select s.id,s.customfieldid,s.templateid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.custom_field_template_field_mapping s
left join public.custom_field_template_field_mapping d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_template_field_mapping', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_template_field_mapping;
insert into public.custom_field_template_field_mapping (fromid,customfieldid,templateid,clientid,fromclientid)
select s.id,s.customfieldid,s.templateid,s.clientid,s.fromclientid from ztmpclientmigration.custom_field_template_field_mapping s
inner join public.custom_field_template_field_mapping d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.integration_custom_field_data_types (id,clientid,type,customtype,customfielddatatypeid,defecttrackingsystemid,haspredefinedvalue,fromid,fromclientid)
select s.id,s.clientid,s.type,s.customtype,s.customfielddatatypeid,s.defecttrackingsystemid,s.haspredefinedvalue,s.id,s.fromclientid from ztmpclientmigration.integration_custom_field_data_types s
left join public.integration_custom_field_data_types d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_custom_field_data_types', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_custom_field_data_types;
insert into public.integration_custom_field_data_types (fromid,clientid,type,customtype,customfielddatatypeid,defecttrackingsystemid,haspredefinedvalue,fromclientid)
select s.id,s.clientid,s.type,s.customtype,s.customfielddatatypeid,s.defecttrackingsystemid,s.haspredefinedvalue,s.fromclientid from ztmpclientmigration.integration_custom_field_data_types s
inner join public.integration_custom_field_data_types d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.integration_custom_fields (id,clientid,projectid,externalfieldid,externalfieldkey,externalfieldname,integrationdatatypeid,connectionid,isdefect,isrequirement,active,fromid,fromclientid)
select s.id,s.clientid,s.projectid,s.externalfieldid,s.externalfieldkey,s.externalfieldname,s.integrationdatatypeid,s.connectionid,s.isdefect,s.isrequirement,s.active,s.id,s.fromclientid from ztmpclientmigration.integration_custom_fields s
left join public.integration_custom_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_custom_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_custom_fields;
insert into public.integration_custom_fields (fromid,clientid,projectid,externalfieldid,externalfieldkey,externalfieldname,integrationdatatypeid,connectionid,isdefect,isrequirement,active,fromclientid)
select s.id,s.clientid,s.projectid,s.externalfieldid,s.externalfieldkey,s.externalfieldname,s.integrationdatatypeid,s.connectionid,s.isdefect,s.isrequirement,s.active,s.fromclientid from ztmpclientmigration.integration_custom_fields s
inner join public.integration_custom_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.integration_custom_field_configurations (id,clientid,"values",valueid,integrationcustomfieldid,status,fromid,fromclientid)
select s.id,s.clientid,s."values",s.valueid,s.integrationcustomfieldid,s.status,s.id,s.fromclientid from ztmpclientmigration.integration_custom_field_configurations s
left join public.integration_custom_field_configurations d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.integration_custom_field_configurations', 'id'), coalesce(max(id),0) + 1, false) FROM public.integration_custom_field_configurations;
insert into public.integration_custom_field_configurations (fromid,clientid,"values",valueid,integrationcustomfieldid,status,fromclientid)
select s.id,s.clientid,s."values",s.valueid,s.integrationcustomfieldid,s.status,s.fromclientid from ztmpclientmigration.integration_custom_field_configurations s
inner join public.integration_custom_field_configurations d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.custom_field_integration_values (id,customfieldid,objectid,value,fromid,fromclientid)
select s.id,s.customfieldid,s.objectid,s.value,s.id,s.fromclientid from ztmpclientmigration.custom_field_integration_values s
left join public.custom_field_integration_values d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.custom_field_integration_values', 'id'), coalesce(max(id),0) + 1, false) FROM public.custom_field_integration_values;
insert into public.custom_field_integration_values (fromid,customfieldid,objectid,value,fromclientid)
select s.id,s.customfieldid,s.objectid,s.value,s.fromclientid from ztmpclientmigration.custom_field_integration_values s
inner join public.custom_field_integration_values d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.test_step_parameters (id,projectid,clientid,endwithoutsuffixindex,startwithoutprefixindex,endindex,startindex,parameterid,teststepid,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.endwithoutsuffixindex,s.startwithoutprefixindex,s.endindex,s.startindex,s.parameterid,s.teststepid,s.id,s.fromclientid from ztmpclientmigration.test_step_parameters s
left join public.test_step_parameters d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_step_parameters', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_step_parameters;
insert into public.test_step_parameters (fromid,projectid,clientid,endwithoutsuffixindex,startwithoutprefixindex,endindex,startindex,parameterid,teststepid,fromclientid)
select s.id,s.projectid,s.clientid,s.endwithoutsuffixindex,s.startwithoutprefixindex,s.endindex,s.startindex,s.parameterid,s.teststepid,s.fromclientid from ztmpclientmigration.test_step_parameters s
inner join public.test_step_parameters d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.test_step_parameter_values (id,projectid,clientid,parametervalueid,parametervaluecontent,testrunid,teststepparameterid,fromid,fromclientid)
select s.id,s.projectid,s.clientid,s.parametervalueid,s.parametervaluecontent,s.testrunid,s.teststepparameterid,s.id,s.fromclientid from ztmpclientmigration.test_step_parameter_values s
left join public.test_step_parameter_values d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.test_step_parameter_values', 'id'), coalesce(max(id),0) + 1, false) FROM public.test_step_parameter_values;
insert into public.test_step_parameter_values (fromid,projectid,clientid,parametervalueid,parametervaluecontent,testrunid,teststepparameterid,fromclientid)
select s.id,s.projectid,s.clientid,s.parametervalueid,s.parametervaluecontent,s.testrunid,s.teststepparameterid,s.fromclientid from ztmpclientmigration.test_step_parameter_values s
inner join public.test_step_parameter_values d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_workflow_transition (id,active,projectid,clientid,fromid,fromclientid)
select s.id,s.active,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_workflow_transition s
left join public.defect_workflow_transition d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_workflow_transition', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_workflow_transition;
insert into public.defect_workflow_transition (fromid,active,projectid,clientid,fromclientid)
select s.id,s.active,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_workflow_transition s
inner join public.defect_workflow_transition d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_workflow_transition_profile (id,userprofileid,transitionid,projectid,clientid,fromid,fromclientid)
select s.id,s.userprofileid,s.transitionid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_workflow_transition_profile s
left join public.defect_workflow_transition_profile d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_workflow_transition_profile', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_workflow_transition_profile;
insert into public.defect_workflow_transition_profile (fromid,userprofileid,transitionid,projectid,clientid,fromclientid)
select s.id,s.userprofileid,s.transitionid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_workflow_transition_profile s
inner join public.defect_workflow_transition_profile d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.defect_workflow_transition_status (id,tostatus,fromstatus,transitionid,projectid,clientid,fromid,fromclientid)
select s.id,s.tostatus,s.fromstatus,s.transitionid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.defect_workflow_transition_status s
left join public.defect_workflow_transition_status d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.defect_workflow_transition_status', 'id'), coalesce(max(id),0) + 1, false) FROM public.defect_workflow_transition_status;
insert into public.defect_workflow_transition_status (fromid,tostatus,fromstatus,transitionid,projectid,clientid,fromclientid)
select s.id,s.tostatus,s.fromstatus,s.transitionid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.defect_workflow_transition_status s
inner join public.defect_workflow_transition_status d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.object_links (id,bid,btypeid,aid,atypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.bid,s.btypeid,s.aid,s.atypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.object_links s
left join public.object_links d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.object_links', 'id'), coalesce(max(id),0) + 1, false) FROM public.object_links;
insert into public.object_links (fromid,bid,btypeid,aid,atypeid,projectid,clientid,fromclientid)
select s.id,s.bid,s.btypeid,s.aid,s.atypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.object_links s
inner join public.object_links d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.incidents (id,systemid,isupdatedincident,type,onapproval,oncreation,active,name,objecttypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.systemid,s.isupdatedincident,s.type,s.onapproval,s.oncreation,s.active,s.name,s.objecttypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.incidents s
left join public.incidents d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.incidents', 'id'), coalesce(max(id),0) + 1, false) FROM public.incidents;
insert into public.incidents (fromid,systemid,isupdatedincident,type,onapproval,oncreation,active,name,objecttypeid,projectid,clientid,fromclientid)
select s.id,s.systemid,s.isupdatedincident,s.type,s.onapproval,s.oncreation,s.active,s.name,s.objecttypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.incidents s
inner join public.incidents d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.scenario_status_mapping (id,oldid,trxid,qteststatus,scenariostatus,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.qteststatus,s.scenariostatus,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.scenario_status_mapping s
left join public.scenario_status_mapping d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.scenario_status_mapping', 'id'), coalesce(max(id),0) + 1, false) FROM public.scenario_status_mapping;
insert into public.scenario_status_mapping (fromid,oldid,trxid,qteststatus,scenariostatus,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.qteststatus,s.scenariostatus,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.scenario_status_mapping s
inner join public.scenario_status_mapping d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.combined_parameter_values (id,locationtypeid,locationid,content,testrunid,testcaseversionid,projectid,clientid,fromid,fromclientid)
select s.id,s.locationtypeid,s.locationid,s.content,s.testrunid,s.testcaseversionid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.combined_parameter_values s
left join public.combined_parameter_values d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.combined_parameter_values', 'id'), coalesce(max(id),0) + 1, false) FROM public.combined_parameter_values;
insert into public.combined_parameter_values (fromid,locationtypeid,locationid,content,testrunid,testcaseversionid,projectid,clientid,fromclientid)
select s.id,s.locationtypeid,s.locationid,s.content,s.testrunid,s.testcaseversionid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.combined_parameter_values s
inner join public.combined_parameter_values d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.browser_hit_track (id,date,version,browser,userid,clientid,fromid,fromclientid)
select s.id,s.date,s.version,s.browser,s.userid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.browser_hit_track s
left join public.browser_hit_track d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.browser_hit_track', 'id'), coalesce(max(id),0) + 1, false) FROM public.browser_hit_track;
insert into public.browser_hit_track (fromid,date,version,browser,userid,clientid,fromclientid)
select s.id,s.date,s.version,s.browser,s.userid,s.clientid,s.fromclientid from ztmpclientmigration.browser_hit_track s
inner join public.browser_hit_track d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.request_execution_time (id,numberofqueries,pattern,projectid,userid,clientid,responsestatus,requesturl,requestmethod,handlermethod,handlerclass,executiontime,endtime,starttime,fromid,fromclientid)
select s.id,s.numberofqueries,s.pattern,s.projectid,s.userid,s.clientid,s.responsestatus,s.requesturl,s.requestmethod,s.handlermethod,s.handlerclass,s.executiontime,s.endtime,s.starttime,s.id,s.fromclientid from ztmpclientmigration.request_execution_time s
left join public.request_execution_time d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.request_execution_time', 'id'), coalesce(max(id),0) + 1, false) FROM public.request_execution_time;
insert into public.request_execution_time (fromid,numberofqueries,pattern,projectid,userid,clientid,responsestatus,requesturl,requestmethod,handlermethod,handlerclass,executiontime,endtime,starttime,fromclientid)
select s.id,s.numberofqueries,s.pattern,s.projectid,s.userid,s.clientid,s.responsestatus,s.requesturl,s.requestmethod,s.handlermethod,s.handlerclass,s.executiontime,s.endtime,s.starttime,s.fromclientid from ztmpclientmigration.request_execution_time s
inner join public.request_execution_time d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.object_comments (id,oldid,trxid,editdatebk,editdate,commentdate,commentdatebk,objectcomment,userid,objecttypeid,objectid,projectid,clientid,fromid,fromclientid)
select s.id,s.oldid,s.trxid,s.editdatebk,s.editdate,s.commentdate,s.commentdatebk,s.objectcomment,s.userid,s.objecttypeid,s.objectid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.object_comments s
left join public.object_comments d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.object_comments', 'id'), coalesce(max(id),0) + 1, false) FROM public.object_comments;
insert into public.object_comments (fromid,oldid,trxid,editdatebk,editdate,commentdate,commentdatebk,objectcomment,userid,objecttypeid,objectid,projectid,clientid,fromclientid)
select s.id,s.oldid,s.trxid,s.editdatebk,s.editdate,s.commentdate,s.commentdatebk,s.objectcomment,s.userid,s.objecttypeid,s.objectid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.object_comments s
inner join public.object_comments d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.app_url_config (id,url,app,clientid,fromid,fromclientid)
select s.id,s.url,s.app,s.clientid,s.id,s.fromclientid from ztmpclientmigration.app_url_config s
left join public.app_url_config d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.app_url_config', 'id'), coalesce(max(id),0) + 1, false) FROM public.app_url_config;
insert into public.app_url_config (fromid,url,app,clientid,fromclientid)
select s.id,s.url,s.app,s.clientid,s.fromclientid from ztmpclientmigration.app_url_config s
inner join public.app_url_config d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.user_unique_id (id,objecttype,tree,userid,projectid,clientid,fromid,fromclientid)
select s.id,s.objecttype,s.tree,s.userid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.user_unique_id s
left join public.user_unique_id d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_unique_id', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_unique_id;
insert into public.user_unique_id (fromid,objecttype,tree,userid,projectid,clientid,fromclientid)
select s.id,s.objecttype,s.tree,s.userid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.user_unique_id s
inner join public.user_unique_id d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.object_subscribers (id,userid,objectid,objecttypeid,projectid,clientid,fromid,fromclientid)
select s.id,s.userid,s.objectid,s.objecttypeid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.object_subscribers s
left join public.object_subscribers d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.object_subscribers', 'id'), coalesce(max(id),0) + 1, false) FROM public.object_subscribers;
insert into public.object_subscribers (fromid,userid,objectid,objecttypeid,projectid,clientid,fromclientid)
select s.id,s.userid,s.objectid,s.objecttypeid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.object_subscribers s
inner join public.object_subscribers d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.launch_user_setting (id,extrainfo,name,clientid,fromid,fromclientid)
select s.id,s.extrainfo,s.name,s.clientid,s.id,s.fromclientid from ztmpclientmigration.launch_user_setting s
left join public.launch_user_setting d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.launch_user_setting', 'id'), coalesce(max(id),0) + 1, false) FROM public.launch_user_setting;
insert into public.launch_user_setting (fromid,extrainfo,name,clientid,fromclientid)
select s.id,s.extrainfo,s.name,s.clientid,s.fromclientid from ztmpclientmigration.launch_user_setting s
inner join public.launch_user_setting d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.insights_token (id,type,expiredate,token,userid,clientid,fromid,fromclientid)
select s.id,s.type,s.expiredate,s.token,s.userid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.insights_token s
left join public.insights_token d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.insights_token', 'id'), coalesce(max(id),0) + 1, false) FROM public.insights_token;
insert into public.insights_token (fromid,type,expiredate,token,userid,clientid,fromclientid)
select s.id,s.type,s.expiredate,s.token,s.userid,s.clientid,s.fromclientid from ztmpclientmigration.insights_token s
inner join public.insights_token d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.data_grid_views (id,objectid,objecttypeid,userid,projectid,clientid,fromid,fromclientid)
select s.id,s.objectid,s.objecttypeid,s.userid,s.projectid,s.clientid,s.id,s.fromclientid from ztmpclientmigration.data_grid_views s
left join public.data_grid_views d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_grid_views', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_grid_views;
insert into public.data_grid_views (fromid,objectid,objecttypeid,userid,projectid,clientid,fromclientid)
select s.id,s.objectid,s.objecttypeid,s.userid,s.projectid,s.clientid,s.fromclientid from ztmpclientmigration.data_grid_views s
inner join public.data_grid_views d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.data_grid_view_fields (id,viewid,fieldid,displayorder,sorttype,sortorder,fromid,fromclientid)
select s.id,s.viewid,s.fieldid,s.displayorder,s.sorttype,s.sortorder,s.id,s.fromclientid from ztmpclientmigration.data_grid_view_fields s
left join public.data_grid_view_fields d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_grid_view_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_grid_view_fields;
insert into public.data_grid_view_fields (fromid,viewid,fieldid,displayorder,sorttype,sortorder,fromclientid)
select s.id,s.viewid,s.fieldid,s.displayorder,s.sorttype,s.sortorder,s.fromclientid from ztmpclientmigration.data_grid_view_fields s
inner join public.data_grid_view_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);


insert into public.recycle_related_actions (id,deleted,objecttypeid,objectid,parentactionid,fromid,fromclientid)
select s.id,s.deleted,s.objecttypeid,s.objectid,s.parentactionid,s.id,s.fromclientid from ztmpclientmigration.recycle_related_actions s
left join public.recycle_related_actions d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.recycle_related_actions', 'id'), coalesce(max(id),0) + 1, false) FROM public.recycle_related_actions;
insert into public.recycle_related_actions (fromid,deleted,objecttypeid,objectid,parentactionid,fromclientid)
select s.id,s.deleted,s.objecttypeid,s.objectid,s.parentactionid,s.fromclientid from ztmpclientmigration.recycle_related_actions s
inner join public.recycle_related_actions d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.user_groups (id,issystem,name,description,clientid,isdefault,fromid,fromclientid)
select s.id,s.issystem,s.name,s.description,s.clientid,s.isdefault,s.id,s.fromclientid from ztmpclientmigration.user_groups s
left join public.user_groups d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_groups', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_groups;
insert into public.user_groups (fromid,issystem,name,description,clientid,isdefault,fromclientid)
select s.id,s.issystem,s.name,s.description,s.clientid,s.isdefault,s.fromclientid from ztmpclientmigration.user_groups s
inner join public.user_groups d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.user_group_members (id,clientid,clientuserid,usergroupid,fromid,fromclientid)
select s.id,s.clientid,s.clientuserid,s.usergroupid,s.id,s.fromclientid from ztmpclientmigration.user_group_members s
left join public.user_group_members d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_group_members', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_group_members;
insert into public.user_group_members (fromid,clientid,clientuserid,usergroupid,fromclientid)
select s.id,s.clientid,s.clientuserid,s.usergroupid,s.fromclientid from ztmpclientmigration.user_group_members s
inner join public.user_group_members d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);
insert into public.user_group_authorities (id,usergroupid,clientid,authorityid,fromid,fromclientid)
select s.id,s.usergroupid,s.clientid,s.authorityid,s.id,s.fromclientid from ztmpclientmigration.user_group_authorities s
left join public.user_group_authorities d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.user_group_authorities', 'id'), coalesce(max(id),0) + 1, false) FROM public.user_group_authorities;
insert into public.user_group_authorities (fromid,usergroupid,clientid,authorityid,fromclientid)
select s.id,s.usergroupid,s.clientid,s.authorityid,s.fromclientid from ztmpclientmigration.user_group_authorities s
inner join public.user_group_authorities d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.clients_aud (id, rev, revtype, name, sitename, isinactive, maxfailedloginattempt, passwordshelflife, passwordhealthyperiod, minimumuniquepasswordssequencelength, licenseblobid, sessiontimeoutenabled, sessiontimeoutminute, terminateidleenabled, terminateidleminute, dateformat, remembermetimeoutenabled, remembermetimeoutday, mailrecipients, isusinges, searchstatus, searchmigrationduration, usecustompasswordpolicy, minimumpasswordlength, passwordcontainscapitalletters, passwordcontainslowercaseletters, passwordcontainsnumericchars, passwordcontainsspecialchars, isusereporting)
select s.id, s.rev, s.revtype, s.name, s.sitename, s.isinactive, s.maxfailedloginattempt, s.passwordshelflife, s.passwordhealthyperiod, s.minimumuniquepasswordssequencelength, s.licenseblobid, s.sessiontimeoutenabled, s.sessiontimeoutminute, s.terminateidleenabled, s.terminateidleminute, s.dateformat, s.remembermetimeoutenabled, s.remembermetimeoutday, s.mailrecipients, s.isusinges, s.searchstatus, s.searchmigrationduration, s.usecustompasswordpolicy, s.minimumpasswordlength, s.passwordcontainscapitalletters, s.passwordcontainslowercaseletters, s.passwordcontainsnumericchars, s.passwordcontainsspecialchars, s.isusereporting
from ztmpclientmigration.clients_aud s;

insert into public.test_step_parameters_aud (id,rev,trxcreateddate,trxcreateduserid,projectid,oldid,trxid,endwithoutsuffixindex,startwithoutprefixindex,endindex,startindex,parameterid,teststepid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.projectid,s.oldid,s.trxid,s.endwithoutsuffixindex,s.startwithoutprefixindex,s.endindex,s.startindex,s.parameterid,s.teststepid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_step_parameters_aud s
inner join public.test_step_parameters t on s.id = t.fromid;
insert into public.client_licenses_aud (id,rev,qmap,usersessionquota,maxnumberofsession,licensetype,maxnumberofwritableusers,packagetype,nextbillingdatebk,explorerenddatebk,explorerstartdatebk,explorerstatus,status,maxnumberofuser,licensetypeid,expireddatebk,nextbillingdate,explorerenddate,explorerstartdate,expireddate,activationdate,activationdatebk,helpdeskphone,helpdeskemail,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.qmap,s.usersessionquota,s.maxnumberofsession,s.licensetype,s.maxnumberofwritableusers,s.packagetype,s.nextbillingdatebk,s.explorerenddatebk,s.explorerstartdatebk,s.explorerstatus,s.status,s.maxnumberofuser,s.licensetypeid,s.expireddatebk,s.nextbillingdate,s.explorerenddate,s.explorerstartdate,s.expireddate,s.activationdate,s.activationdatebk,s.helpdeskphone,s.helpdeskemail,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.client_licenses_aud s
inner join public.client_licenses t on s.id = t.fromid;
insert into public.projects_aud (id,rev,trxcreateddate,trxid,enddate,startdate,trxcreateduserid,internally,customfieldtemplateid,clonestatus,sourceprojectid,defectworkflow,automation,patchincidentstatus,ispatchedincidents,issampleproject,projectstatusid,description,name,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxid,s.enddate,s.startdate,s.trxcreateduserid,s.internally,s.customfieldtemplateid,s.clonestatus,s.sourceprojectid,s.defectworkflow,s.automation,s.patchincidentstatus,s.ispatchedincidents,s.issampleproject,s.projectstatusid,s.description,s.name,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.projects_aud s
inner join public.projects t on s.id = t.fromid;

insert into public.project_modules_aud (id,rev,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,projectid,shared,parentmoduleid,name,moduletype,description,deleted,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.projectid,s.shared,s.parentmoduleid,s.name,s.moduletype,s.description,s.deleted,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.project_modules_aud s
inner join public.project_modules t on s.id = t.fromid;

insert into public.custom_field_configurations_aud (id,rev,trxcreateddate,trxcreateduserid,sitefieldconfigurationid,valueid,value,attribute,customfieldid,integrationcustomfieldconfigurationid,projectid,clientid,createddate,createduserid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.sitefieldconfigurationid,s.valueid,s.value,s.attribute,s.customfieldid,s.integrationcustomfieldconfigurationid,s.projectid,s.clientid,s.createddate,s.createduserid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.custom_field_configurations_aud s
inner join public.custom_field_configurations t on s.id = t.fromid;
insert into public.custom_field_values_aud (id,rev,trxcreateddate,trxcreateduserid,createddate,userid,projectid,clientid,value,objectid,customfieldid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.createddate,s.userid,s.projectid,s.clientid,s.value,s.objectid,s.customfieldid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.custom_field_values_aud s
inner join public.custom_field_values t on s.id = t.fromid;

insert into public.integration_custom_field_configurations_aud (id,rev,revtype,clientid,"values",valueid,integrationcustomfieldid,status,fromid,fromclientid)
select t.id,s.rev,s.revtype,s.clientid,s."values",s.valueid,s.integrationcustomfieldid,s.status,s.id,s.fromclientid from ztmpclientmigration.integration_custom_field_configurations_aud s
inner join public.integration_custom_field_configurations_aud t on s.id = t.fromid;
insert into public.integration_custom_fields_aud (id,rev,revtype,clientid,projectid,externalfieldid,externalfieldkey,externalfieldname,integrationdatatypeid,connectionid,isdefect,isrequirement,active,fromid,fromclientid)
select t.id,s.rev,s.revtype,s.clientid,s.projectid,s.externalfieldid,s.externalfieldkey,s.externalfieldname,s.integrationdatatypeid,s.connectionid,s.isdefect,s.isrequirement,s.active,s.id,s.fromclientid from ztmpclientmigration.integration_custom_fields_aud s
inner join public.integration_custom_fields_aud t on s.id = t.fromid;

insert into public.custom_field_integration_values_aud (id,rev,revtype,customfieldid,objectid,value,fromid,fromclientid)
select t.id,s.rev,s.revtype,s.customfieldid,s.objectid,s.value,s.id,s.fromclientid from ztmpclientmigration.custom_field_integration_values_aud s
inner join public.custom_field_integration_values t on s.id = t.fromid;

-- manually added clientid
create index idx_tmp_blob_handles_fromid_id on blob_handles(fromid, id) where clientid in (10699,25502);

insert into public.blob_handles_aud (id,rev,trxcreateddate,trxcreateduserid,oldid,createddate,minetypeid,name,blobsize,userid,objectid,objecttypeid,projectid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.oldid,s.createddate,s.minetypeid,s.name,s.blobsize,s.userid,s.objectid,s.objecttypeid,s.projectid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.blob_handles_aud s
inner join public.blob_handles t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_blob_handles_fromid_id;
create index idx_tmp_object_assignments_fromid_id on object_assignments(fromid, id) where clientid in (10699,25502);
insert into public.object_assignments_aud (id,rev,priorityid,completedate,targetdate,trxcreateddate,trxcreateduserid,createddate,oldid,trxid,assignmenttype,objecttypeid,projectid,clientid,userid,objectid,revtype,fromid,fromclientid)
select t.id,s.rev,s.priorityid,s.completedate,s.targetdate,s.trxcreateddate,s.trxcreateduserid,s.createddate,s.oldid,s.trxid,s.assignmenttype,s.objecttypeid,s.projectid,s.clientid,s.userid,s.objectid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.object_assignments_aud s
inner join public.object_assignments t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_object_assignments_fromid_id;
create index idx_tmp_custom_fields_fromid_id on custom_fields(fromid, id) where clientid in (10699,25502);
insert into public.custom_fields_aud (id,rev,trxcreateddate,trxcreateduserid,integrationdefectfieldid,defecttrackingconnectionid,sitefieldid,searchindex,freetextsearch,searchkey,searchable,systemfield,active,displayorder,name,datatypeid,objecttypeid,projectid,clientid,createddate,createduserid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.integrationdefectfieldid,s.defecttrackingconnectionid,s.sitefieldid,s.searchindex,s.freetextsearch,s.searchkey,s.searchable,s.systemfield,s.active,s.displayorder,s.name,s.datatypeid,s.objecttypeid,s.projectid,s.clientid,s.createddate,s.createduserid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.custom_fields_aud s
inner join public.custom_fields t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_custom_fields_fromid_id;
create index idx_tmp_requirements_fromid_id on requirements(fromid, id) where clientid in (10699,25502);
insert into public.requirements_aud (id,rev,deleted,projectmoduleid,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,oldid,trxid,buildid,releaseid,requirement,statusid,requirementpriorityid,requirementtypeid,name,projectid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.deleted,s.projectmoduleid,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.oldid,s.trxid,s.buildid,s.releaseid,s.requirement,s.statusid,s.requirementpriorityid,s.requirementtypeid,s.name,s.projectid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.requirements_aud s
inner join public.requirements t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_requirements_fromid_id;
insert into public.builds_aud (id,rev,objorder,pid,deleted,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,releaseid,projectid,note,date,datebk,clientid,buildstatusid,buildname,revtype,fromid,fromclientid)
select t.id,s.rev,s.objorder,s.pid,s.deleted,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.releaseid,s.projectid,s.note,s.date,s.datebk,s.clientid,s.buildstatusid,s.buildname,s.revtype,s.id,s.fromclientid from ztmpclientmigration.builds_aud s
inner join public.builds t on s.id = t.fromid
where t.clientid in (10699,25502);
insert into public.releases_aud (id,rev,objorder,pid,deleted,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,startdatebk,releasestatusid,releasename,releasedescription,projectid,note,modifieduserid,modifieddatebk,modifieddate,enddate,startdate,enddatebk,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.objorder,s.pid,s.deleted,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.startdatebk,s.releasestatusid,s.releasename,s.releasedescription,s.projectid,s.note,s.modifieduserid,s.modifieddatebk,s.modifieddate,s.enddate,s.startdate,s.enddatebk,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.releases_aud s
inner join public.releases t on s.id = t.fromid
where t.clientid in (10699,25502);
insert into public.test_cycles_aud (id,rev,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,testcycletype,startdatebk,parenttestcycleid,releaseid,projectid,name,enddate,startdate,enddatebk,description,deleted,clientid,buildid,revtype,fromid,fromclientid)
select t.id,s.rev,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.testcycletype,s.startdatebk,s.parenttestcycleid,s.releaseid,s.projectid,s.name,s.enddate,s.startdate,s.enddatebk,s.description,s.deleted,s.clientid,s.buildid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_cycles_aud s
inner join public.test_cycles t on s.id = t.fromid
where t.clientid in (10699,25502);
insert into public.test_suites_aud (id,rev,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,deleted,testcycleid,createddate,oldid,trxid,testbedid,buildid,releaseid,description,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,projecttesttypeid,userid,testdatasetid,name,projectid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.deleted,s.testcycleid,s.createddate,s.oldid,s.trxid,s.testbedid,s.buildid,s.releaseid,s.description,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.projecttesttypeid,s.userid,s.testdatasetid,s.name,s.projectid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_suites_aud s
inner join public.test_suites t on s.id = t.fromid
where t.clientid in (10699,25502);
create index idx_tmp_test_cases_fromid_id on test_cases(fromid, id) where clientid in (10699,25502);
insert into public.test_cases_aud (id,rev,classidhashcode,projectmoduleid,latesttestcaseversionid,deleted,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,createddate,userid,projectid,oldid,trxid,priorityid,shared,automationid,classid,testcasetypeid,name,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.classidhashcode,s.projectmoduleid,s.latesttestcaseversionid,s.deleted,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.createddate,s.userid,s.projectid,s.oldid,s.trxid,s.priorityid,s.shared,s.automationid,s.classid,s.testcasetypeid,s.name,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_cases_aud s
inner join public.test_cases t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_cases_fromid_id;
create index idx_tmp_test_case_run_fromid_id on test_case_run(fromid, id) where clientid in (10699,25502);
insert into public.test_case_run_aud (id,rev,testcaseid,objorder,pid,trxcreateddate,trxcreateduserid,lastmodifieddate,lastmodifieduserid,creatorid,testcycleid,createddate,oldid,trxid,cisystemtype,buildurl,buildnumber,plannedexecutiontime,priorityid,configurationid,buildid,releaseid,deleted,latesttestcaseresultid,projecttesttypeid,testsuiteid,runorder,testbedid,plannedenddate,plannedstartdate,plannedenddatebk,plannedstartdatebk,testcaseversionid,userid,name,projectid,clientid,revtype,latesttestexecutionresultid,fromid,fromclientid)
select t.id,s.rev,s.testcaseid,s.objorder,s.pid,s.trxcreateddate,s.trxcreateduserid,s.lastmodifieddate,s.lastmodifieduserid,s.creatorid,s.testcycleid,s.createddate,s.oldid,s.trxid,s.cisystemtype,s.buildurl,s.buildnumber,s.plannedexecutiontime,s.priorityid,s.configurationid,s.buildid,s.releaseid,s.deleted,s.latesttestcaseresultid,s.projecttesttypeid,s.testsuiteid,s.runorder,s.testbedid,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.plannedstartdatebk,s.testcaseversionid,s.userid,s.name,s.projectid,s.clientid,s.revtype,s.latesttestexecutionresultid,s.id,s.fromclientid from ztmpclientmigration.test_case_run_aud s
inner join public.test_case_run t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_case_run_fromid_id;
create index idx_tmp_test_case_versions_fromid_id on test_case_versions(fromid, id) where clientid in (10699,25502);
insert into public.test_case_versions_aud (id,rev,version,deleted,trxcreateddate,trxcreateduserid,createddate,userid,projectid,oldid,trxid,precondition,description,testcaseversionstatusid,increasenumber,baselinenumber,testcaseid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.version,s.deleted,s.trxcreateddate,s.trxcreateduserid,s.createddate,s.userid,s.projectid,s.oldid,s.trxid,s.precondition,s.description,s.testcaseversionstatusid,s.increasenumber,s.baselinenumber,s.testcaseid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_case_versions_aud s
inner join public.test_case_versions t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_case_versions_fromid_id;
create index idx_tmp_test_steps_fromid_id on test_steps(fromid, id) where clientid in (10699,25502);
insert into public.test_steps_aud (id,rev,trxcreateddate,trxcreateduserid,createddate,userid,projectid,oldid,trxid,runtestcaseversionid,testcaseversionid,steporder,expectedresult,description,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.createddate,s.userid,s.projectid,s.oldid,s.trxid,s.runtestcaseversionid,s.testcaseversionid,s.steporder,s.expectedresult,s.description,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_steps_aud s
inner join public.test_steps t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_steps_fromid_id;
create index idx_tmp_test_case_results_fromid_id on test_case_results(fromid, id) where clientid in (10699,25502);
insert into public.test_case_results_aud (id,rev,edited,submittedby,testexecutionresultid,assigneduserid,automation,cisystemtype,buildurl,buildnumber,actualexecutiontime,plannedexecutiontime,configurationid,customfieldvalues,trxcreateddate,trxcreateduserid,testcaseid,createddate,projectid,userid,testdatasetid,testcaseversionid,testcaserunid,resultnumber,releaseid,plannedstartdatebk,executionenddate,executionstartdate,plannedenddate,plannedstartdate,plannedenddatebk,executiontypeid,executionstartdatebk,executionenddatebk,clientid,buildid,revtype,fromid,fromclientid)
select t.id,s.rev,s.edited,s.submittedby,s.testexecutionresultid,s.assigneduserid,s.automation,s.cisystemtype,s.buildurl,s.buildnumber,s.actualexecutiontime,s.plannedexecutiontime,s.configurationid,s.customfieldvalues,s.trxcreateddate,s.trxcreateduserid,s.testcaseid,s.createddate,s.projectid,s.userid,s.testdatasetid,s.testcaseversionid,s.testcaserunid,s.resultnumber,s.releaseid,s.plannedstartdatebk,s.executionenddate,s.executionstartdate,s.plannedenddate,s.plannedstartdate,s.plannedenddatebk,s.executiontypeid,s.executionstartdatebk,s.executionenddatebk,s.clientid,s.buildid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.test_case_results_aud s
inner join public.test_case_results t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_case_results_fromid_id;
create index idx_tmp_test_step_results_fromid_id on test_step_results(fromid, id) where clientid in (10699,25502);
insert into public.test_step_results_aud (id,rev,revtype,clientid,teststepid,testcaseresultid,testexecutionresultid,userid,actualresult,resultorder,date,testcaseversionid,calledtestcaseid,calledtestcasename,testcaseid,testcaserunid,fromid,fromclientid)
select t.id,s.rev,s.revtype,s.clientid,s.teststepid,s.testcaseresultid,s.testexecutionresultid,s.userid,s.actualresult,s.resultorder,s.date,s.testcaseversionid,s.calledtestcaseid,s.calledtestcasename,s.testcaseid,s.testcaserunid,s.id,s.fromclientid from ztmpclientmigration.test_step_results_aud s
inner join public.test_step_results t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_test_step_results_fromid_id;
create index idx_tmp_defects_fromid_id on defects(fromid, id) where clientid in (10699,25502);

insert into public.defects_aud (id,rev,indexflag,pid,trxcreateddate,trxcreateduserid,sourcedefectid,previousstatusid,rootcauseid,draft,externalissuetype,url,externalissuestatus,externalissuesummary,externalprojectid,connectionid,externalissueid,lastmodifieddate,lastmodifieduserid,createduserid,creatorid,createddate,userid,oldid,trxid,environmentid,categoryid,projectmoduleid,reasonid,closeddatebk,closeddate,targetdate,targetdatebk,targetbuildid,targetreleaseid,fixedbuildid,fixedreleaseid,affectedbuildid,affectedreleaseid,serverid,envotherid,browserid,osid,priorityid,severityid,statusid,assigneduserid,typeid,description,summary,projectid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.indexflag,s.pid,s.trxcreateddate,s.trxcreateduserid,s.sourcedefectid,s.previousstatusid,s.rootcauseid,s.draft,s.externalissuetype,s.url,s.externalissuestatus,s.externalissuesummary,s.externalprojectid,s.connectionid,s.externalissueid,s.lastmodifieddate,s.lastmodifieduserid,s.createduserid,s.creatorid,s.createddate,s.userid,s.oldid,s.trxid,s.environmentid,s.categoryid,s.projectmoduleid,s.reasonid,s.closeddatebk,s.closeddate,s.targetdate,s.targetdatebk,s.targetbuildid,s.targetreleaseid,s.fixedbuildid,s.fixedreleaseid,s.affectedbuildid,s.affectedreleaseid,s.serverid,s.envotherid,s.browserid,s.osid,s.priorityid,s.severityid,s.statusid,s.assigneduserid,s.typeid,s.description,s.summary,s.projectid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.defects_aud s
inner join public.defects t on s.id = t.fromid
where t.clientid in (10699,25502);
drop index idx_tmp_defects_fromid_id;
insert into public.requirement_link_data_aud (id,rev,trxcreateddate,trxcreateduserid,buildid,requirementid,releaseid,projectid,clientid,revtype,fromid,fromclientid)
select t.id,s.rev,s.trxcreateddate,s.trxcreateduserid,s.buildid,s.requirementid,s.releaseid,s.projectid,s.clientid,s.revtype,s.id,s.fromclientid from ztmpclientmigration.requirement_link_data_aud s
inner join public.requirement_link_data t on s.id = t.fromid
where t.clientid in (10699,25502);
insert into public.object_comments_aud (id,rev,editdate,trxcreateddate,trxcreateduserid,createddate,userid,projectid,objectid,objectcomment,commentdate,commentdatebk,clientid,revtype,objecttypeid,fromid,fromclientid)
select t.id,s.rev,s.editdate,s.trxcreateddate,s.trxcreateduserid,s.createddate,s.userid,s.projectid,s.objectid,s.objectcomment,s.commentdate,s.commentdatebk,s.clientid,s.revtype,s.objecttypeid,s.id,s.fromclientid from ztmpclientmigration.object_comments_aud s
inner join public.object_comments t on s.id = t.fromid
where t.clientid in (10699,25502);



