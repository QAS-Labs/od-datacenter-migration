\encoding UTF8

\set ON_ERROR_STOP on

set work_mem='4GB';

\timing on

-- manual for insights
\copy (select pud.clientid, pudp.* from insights.portfolio_unlinked_defect_projects pudp inner join insights.portfolio_unlinked_defects pud on pudp.portfoliounlinkeddefectid=pud.id where pud.clientid in (10699,25502,28289)) to 'insights.portfolio_unlinked_defect_projects.dat'


-- generated  for insights
/*
select format('\copy (select * from insights.%s where clientid in (10699,25502,28289)) to ''insights.%dat''',table_name,table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='insights'
    and table_type = 'BASE TABLE'
    and table_name not like 'project_module%'
    and table_name not in ('client_user_info',preferences','saved_report')
    and table_name not like 'test_cycle%'
    and exists (    select 1 from information_schema.columns
                    where table_schema='insights'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
\copy (select clientid,* from insights.client_colors where clientid in (10699,25502,28289)) to 'insights.client_colors.dat'
\copy (select clientid,* from insights.client_landing_page where clientid in (10699,25502,28289)) to 'insights.client_landing_page.dat'
\copy (select clientid,* from insights.client_user_landing_page where clientid in (10699,25502,28289)) to 'insights.client_user_landing_page.dat'
\copy (select clientid,* from insights.defect_severities where clientid in (10699,25502,28289)) to 'insights.defect_severities.dat'
\copy (select clientid,* from insights.defect_severities_detail where clientid in (10699,25502,28289)) to 'insights.defect_severities_detail.dat'
\copy (select clientid,* from insights.defect_statuses where clientid in (10699,25502,28289)) to 'insights.defect_statuses.dat'
\copy (select clientid,* from insights.defect_statuses_detail where clientid in (10699,25502,28289)) to 'insights.defect_statuses_detail.dat'
\copy (select clientid,* from insights.jira_report_fields where clientid in (10699,25502,28289)) to 'insights.jira_report_fields.dat'
\copy (select clientid,* from insights.portfolios where clientid in (10699,25502,28289)) to 'insights.portfolios.dat'
\copy (select clientid,* from insights.portfolio_thresholds where clientid in (10699,25502,28289)) to 'insights.portfolio_thresholds.dat'
\copy (select clientid,* from insights.portfolio_unlinked_defects where clientid in (10699,25502,28289)) to 'insights.portfolio_unlinked_defects.dat'
\copy (select clientid,* from insights.rapiddashboardtasks where clientid in (10699,25502,28289)) to 'insights.rapiddashboardtasks.dat'
\copy (select clientid,* from insights.report_lookup_t where clientid in (10699,25502,28289)) to 'insights.report_lookup_t.dat'
\copy (select clientid,* from insights.report_lookup_updates where clientid in (10699,25502,28289)) to 'insights.report_lookup_updates.dat'
\copy (select clientid,* from insights.schedule_tasks where clientid in (10699,25502,28289)) to 'insights.schedule_tasks.dat'
\copy (select clientid,* from insights.user_banners where clientid in (10699,25502,28289)) to 'insights.user_banners.dat'


-- manual
\copy (select id,* from clients where id in (10699,25502,28289)) to 'clients.dat'
\copy (select id,* from clients_aud where id in (10699,25502,28289)) to 'clients_aud.dat'
\copy (select id,* from client_ext where id in (10699,25502,28289)) to 'client_ext.dat'
\copy (select distinct cu.clientid,u.* from users u inner join client_users cu on cu.userid = u.id where cu.clientid in (10699,25502,28289) and u.issampleuser is null) to 'users.dat'
\copy (select distinct cf.clientid,cfv.* from custom_field_values cfv inner join custom_fields cf on cfv.customfieldid = cf.id where cf.clientid in (10699,25502,28289)) to 'custom_field_values.dat';
\copy (select distinct cf.clientid,cfv.* from custom_field_integration_values cfv inner join custom_fields cf on cfv.customfieldid = cf.id where cf.clientid in (10699,25502,28289)) to 'custom_field_integration_values.dat';
\copy (select clientid,* from integration_custom_field_configurations icfc where icfc.clientid in (10699,25502,28289)) to 'integration_custom_field_configurations.dat'
\copy (select clientid,* from integration_custom_field_configurations_aud icfc where icfc.clientid in (10699,25502,28289)) to 'integration_custom_field_configurations_aud.dat'
\copy (select clientid,* from integration_custom_field_data_types icfdt where icfdt.clientid in (10699,25502,28289)) to 'integration_custom_field_data_types.dat'
\copy (select clientid,* from integration_custom_fields icf where icf.clientid in (10699,25502,28289)) to 'integration_custom_fields.dat'
\copy (select clientid,* from integration_custom_fields_aud icfa where icfa.clientid in (10699,25502,28289)) to 'integration_custom_fields_aud.dat'
\copy (select distinct cf.clientid,cfc.* from custom_field_configurations cfc inner join custom_fields cf on cfc.customfieldid = cf.id where cf.clientid in (10699,25502,28289)) to 'custom_field_configurations.dat';
\copy (select distinct cs.clientid,c.* from configurations c inner join configuration_sets cs on cs.id = setid where cs.clientid in (10699,25502,28289)) to 'configurations.dat';
\copy (select distinct dtc.clientid,ip.* from integration_projects ip inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_projects.dat';
\copy (select dtc.clientid,iif.* from integration_identifier_fields iif inner join defect_tracking_connection dtc on dtc.id = iif.id where dtc.clientid in (10699,25502,28289)) to 'integration_identifier_fields.dat';
\copy (select distinct dtc.clientid,itm.* from integration_type_maps itm inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_type_maps.dat';
\copy (select dtc.clientid,imf.* from integration_module_fields imf inner join integration_type_maps itm on imf.integrationtypemapid = itm.id inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_module_fields.dat';
\copy (select distinct dtc.clientid,irc.* from integration_release_configuration irc inner join integration_type_maps itm on irc.integrationtypemapid = itm.id inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_release_configuration.dat';
\copy (select dtc.clientid,irfm.* from integration_requirement_field_maps irfm inner join integration_type_maps itm on irfm.integrationtypemapid = itm.id inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_requirement_field_maps.dat';
\copy (select dtc.clientid,idf.* from integration_defect_fields idf inner join integration_type_maps itm on idf.integrationtypemapid = itm.id inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where idf.newtypemap = true and dtc.clientid in (10699,25502,28289) union select dtc.clientid,idf.* from defect_tracking_connection dtc  inner join defect_tracking_type dtt on dtt.defecttrackingconnectionid = dtc.id inner join integration_defect_fields idf on idf.integrationtypemapid = dtt.id where idf.newtypemap = false and dtc.clientid in (10699,25502,28289) union select cf.clientid,idf.* from integration_defect_fields idf inner join custom_fields cf on cf.integrationdefectfieldid=idf.id where cf.clientid in (10699,25502,28289)) to 'integration_defect_fields.dat';
\copy (select distinct dtc.clientid,idfm.* from integration_defect_field_maps idfm inner join integration_type_maps itm on idfm.integrationtypemapid = itm.id inner join integration_projects ip on itm.integrationprojectid = ip.id inner join defect_tracking_connection dtc on dtc.id = ip.connectionid where dtc.clientid in (10699,25502,28289)) to 'integration_defect_field_maps.dat';
\copy (select iirm.clientid,iid.* from integration_issue_data iid inner join integration_issue_requirement_maps iirm on iirm.id = iid.integrationissuerequirementmapid where iirm.clientid in (10699,25502,28289)) to 'integration_issue_data.dat';
\copy (select iirm.clientid,ird.* from integration_release_data ird inner join integration_issue_release_maps iirm on iirm.id = ird.integrationissuereleasemapid where iirm.clientid in (10699,25502,28289)) to 'integration_release_data.dat';
\copy (select distinct cu.clientid,ue.* from user_ext ue inner join users u on ue.id = u.id inner join client_users cu on cu.userid = u.id where cu.clientid in (10699,25502,28289) and u.issampleuser is null) to 'user_ext.dat'
\copy (select distinct cu.clientid,a.* from acl_sid a inner join users u on a.sid = u.username inner join client_users cu on cu.userid = u.id where cu.clientid in (10699,25502,28289) and a.sid not in ('johnsampleuser@qasymphony.com','jeansampleuser@qasymphony.com','fredsampleuser@qasymphony.com','juliesampleuser@qasymphony.com')) to 'acl_sid.dat'
\copy (select p.clientid,aoi.* from acl_object_identity aoi inner join projects p on p.id = aoi.object_id_identity where p.clientid in (10699,25502,28289)) to 'acl_object_identity.dat'
--\copy (select distinct p.clientid,ae.* from acl_entry ae inner join acl_sid a on ae.sid = a.id inner join users u on a.sid = u.username inner join client_users cu on cu.userid = u.id inner join acl_object_identity aoi on ae.acl_object_identity = aoi.id inner join projects p on p.id = aoi.object_id_identity where cu.clientid in (10699,25502,28289) and p.clientid in (10699,25502,28289)) to 'acl_entry.dat'
\copy (select clientid,id,clientid,projectid,objecttypeid,objectid,userid,blobsize,name,minetypeid,createddate,trxid,oldid from blob_handles where clientid in (10699,25502,28289)) to 'blob_handles.dat'
--\copy (select clientid,id, clientid, testcaseversionid, description, expectedresult, steporder, runtestcaseversionid, trxid, oldid, descriptionmigrated, expectedresultmigrated from test_steps where clientid in (10699,25502,28289)) to 'test_steps.dat'
--\copy (select clientid,id, rev, revtype, clientid, description, expectedresult, steporder, testcaseversionid, runtestcaseversionid, trxid, oldid, projectid, userid, createddate, trxcreateduserid, trxcreateddate from test_steps_aud where clientid in (10699,25502,28289)) to 'test_steps_aud.dat'
\copy (SELECT p.clientid,pi.* FROM pid_increment pi inner join projects p on pi.projectid = p.id where p.clientid in (10699,25502,28289)) to 'pid_increment.dat'
\copy (select ra.clientid,rra.* from recycle_related_actions rra inner join recycle_actions ra on rra.parentactionid = ra.id where ra.clientid in (10699,25502,28289)) to 'recycle_related_actions.dat'
\copy (select aa.clientid,ace.* from automation_cancelled_executions ace inner join automation_agents aa on ace.agentid = aa.id where aa.clientid in (10699,25502,28289)) to 'automation_cancelled_executions.dat'
-- 385/133764 rows have null agentid, so null agentid is bad data
\copy (select aa.clientid,asch.* from automation_schedules asch inner join automation_agents aa on asch.agentid = aa.id where aa.clientid in (10699,25502,28289)) to 'automation_schedules.dat'
\copy (select aa.clientid,aer.* from automation_execution_results aer inner join automation_schedules asch on aer.scheduleid = asch.id inner join automation_agents aa on asch.agentid = aa.id where aa.clientid in (10699,25502,28289)) to 'automation_execution_results.dat'
\copy (select aa.clientid,asem.* from automation_schedule_execution_maps asem inner join automation_schedules asch on asem.scheduleid = asch.id inner join automation_agents aa on asch.agentid = aa.id where aa.clientid in (10699,25502,28289)) to 'automation_schedule_execution_maps.dat'
\copy (select dgv.clientid,dgvf.* from data_grid_view_fields dgvf inner join data_grid_views dgv on dgvf.viewid = dgv.id where dgv.clientid in (10699,25502,28289)) to 'data_grid_view_fields.dat'









-- generated
/*
select
format('\copy (select %s from %s where clientid in (10699,25502,28289)) to ''%s.dat''',
string_agg(column_name,','),
table_name,
table_name)
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
    and t.table_name not like 'backup%'
    and c.table_schema = 'public'
    and t.table_name not in ('')
    and c.column_name not in ('fromid','fromclientid')
    and exists (select 1 from information_schema.columns
                where table_schema='public'
                and column_name = 'clientid'
                and table_name = t.table_name)
    ORDER BY t.table_name, c.ordinal_position
) t
GROUP BY table_name;
\copy (select format('\copy (select %s from %s where clientid in (10699,25502,28289)) to ''%s.dat''', string_agg(column_name,','), table_name, table_name) from (     select t.table_name, c.column_name     from information_schema.tables t      inner join information_schema.columns c       on c.table_name = t.table_name     where     t.table_schema = 'public'     and t.table_type = 'BASE TABLE'     and t.table_name not like 'ztmp_%'     and t.table_name not like 'sd_%'     and t.table_name not like 'removed_%'     and t.table_name not like 'stats_%'     and t.table_name not like 'across_report_%'     and t.table_name not like 'backup%'     and c.table_schema = 'public'     and t.table_name not in ('')     and c.column_name not in ('fromid','fromclientid')     and exists (select 1 from information_schema.columns                 where table_schema='public'                 and column_name = 'clientid'                 and table_name = t.table_name)     ORDER BY t.table_name, c.ordinal_position ) t GROUP BY table_name) to 'export.txt'
*/

 \copy (select clientid,id,clientid,app,url from app_url_config where clientid in (10699,25502,28289)) to 'app_url_config.dat'
 \copy (select clientid,id,clientid,appname,userid,username,eventtype,extauthusername,extauthname,ip,agent,projectid,projectname,objectid,objecttype,objectpid,objectname,filename,detail,audittime,filetype from audit_log where clientid in (10699,25502,28289)) to 'audit_log.dat'
 \copy (select clientid,id,clientid,projectid,hostid,name,framework,frameworkid,active,clientagentid,configuration from automation_agents where clientid in (10699,25502,28289)) to 'automation_agents.dat'
 \copy (select clientid,id,clientid,hostname,ipaddress,macaddress,status,statusexpiredtime,hostguid,os,tags,pollingfrequency,version,hostconfig,portconfig from automation_hosts where clientid in (10699,25502,28289)) to 'automation_hosts.dat'
 \copy (select clientid,id,name,type,agenttypeid,version,url,parserblobhandleid,filepath,filename,clientid,submitteduser,deleteduser,createddate,modifieddate,isdeleted from automation_parsers where clientid in (10699,25502,28289)) to 'automation_parsers.dat'
 \copy (select clientid,id,clientid,projectid,automationstatus,qteststatus,trxid,oldid from automation_status_mapping where clientid in (10699,25502,28289)) to 'automation_status_mapping.dat'
 \copy (select clientid,id,hostid,scheduledby,scheduledon,updatedon,status,fromversion,toversion,upgradelogblobhandleid,downloadurl,clientid from automation_upgrade_logs where clientid in (10699,25502,28289)) to 'automation_upgrade_logs.dat'
 
 \copy (select clientid,id,rev,revtype,clientid,projectid,objecttypeid,objectid,userid,blobsize,name,minetypeid,createddate,oldid,trxcreateduserid,trxcreateddate from blob_handles_aud where clientid in (10699,25502,28289)) to 'blob_handles_aud.dat'
 \copy (select clientid,id,clientid,userid,browser,version,date from browser_hit_track where clientid in (10699,25502,28289)) to 'browser_hit_track.dat'
 \copy (select clientid,id,pid,clientid,projectid,releaseid,buildname,datebk,date,note,buildstatusid,deleted,objorder,createddate,creatorid,lastmodifieddate,lastmodifieduserid,trxid,oldid from builds where clientid in (10699,25502,28289)) to 'builds.dat'
 \copy (select clientid,id,rev,revtype,buildname,buildstatusid,clientid,datebk,date,note,projectid,releaseid,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,deleted,pid,objorder from builds_aud where clientid in (10699,25502,28289)) to 'builds_aud.dat'
 \copy (select clientid,id,clientid,name,serverurl,customfieldid,customfieldname,systemid,ispolled from client_jira_connection where clientid in (10699,25502,28289)) to 'client_jira_connection.dat'
 \copy (select clientid,id,clientid,helpdeskemail,helpdeskphone,activationdatebk,activationdate,expireddate,explorerstartdate,explorerenddate,nextbillingdate,expireddatebk,licensetypeid,maxnumberofuser,status,explorerstatus,explorerstartdatebk,explorerenddatebk,nextbillingdatebk,packagetype,maxnumberofwritableusers,licensetype,maxnumberofsession,usersessionquota,qmap from client_licenses where clientid in (10699,25502,28289)) to 'client_licenses.dat'
 \copy (select clientid,id,rev,revtype,clientid,helpdeskemail,helpdeskphone,activationdatebk,activationdate,expireddate,explorerstartdate,explorerenddate,nextbillingdate,expireddatebk,licensetypeid,maxnumberofuser,status,explorerstatus,explorerstartdatebk,explorerenddatebk,nextbillingdatebk,packagetype,maxnumberofwritableusers,licensetype,maxnumberofsession,usersessionquota,qmap from client_licenses_aud where clientid in (10699,25502,28289)) to 'client_licenses_aud.dat'
 \copy (select clientid,id,clientid,name,encryptedvalue,value from client_settings where clientid in (10699,25502,28289)) to 'client_settings.dat'
 \copy (select clientid,id,userid,clientid,status,isenteredclient,failedlogincount,password,salt,encryptedpassword,credentialnonexpired,activationcode,createddatebk,createddate,activateddate,passwordmodifieddate,passwordexpirationdate,lastlogintime,activateddatebk,passwordmodifieddatebk,isdefaultclient,passwordexpirationdatebk,lastlogintimebk,isrootuser,isshowtutorialprogressbar,timezoneid,isnotifiedtimezone,defaultexectool,passwordneedschangingdatebk,passwordneedschangingdate,mappedldapid,authenticatorid,authtype,externalauthconfigid,isinsightssu,tzcountryid,lasttimesentemail,sha3password from client_users where clientid in (10699,25502,28289)) to 'client_users.dat'
 \copy (select clientid,id,clientid,projectid,securityprofileid,clientuserid from client_user_sec_profiles where clientid in (10699,25502,28289)) to 'client_user_sec_profiles.dat'
 \copy (select clientid,id,clientid,clientuserid,name,value from client_user_settings where clientid in (10699,25502,28289)) to 'client_user_settings.dat'
 \copy (select clientid,id,clientid,projectid,testcaseversionid,testrunid,content,locationid,locationtypeid from combined_parameter_values where clientid in (10699,25502,28289)) to 'combined_parameter_values.dat'
 \copy (select clientid,id,clientid,projectid,webhookid,uniqueid,migrationtype,migrated from configuration_migration_tracking where clientid in (10699,25502,28289)) to 'configuration_migration_tracking.dat'
 \copy (select clientid,id,clientid,name,trxid,oldid from configuration_sets where clientid in (10699,25502,28289)) to 'configuration_sets.dat'
 \copy (select clientid,id,clientid,name,description,trxid,oldid from configuration_variables where clientid in (10699,25502,28289)) to 'configuration_variables.dat'
 \copy (select clientid,id,rev,revtype,createduserid,createddate,clientid,projectid,customfieldid,attribute,value,valueid,sitefieldconfigurationid,trxcreateduserid,trxcreateddate from custom_field_configurations_aud where clientid in (10699,25502,28289)) to 'custom_field_configurations_aud.dat'
 \copy (select clientid,id,clientid,projectid,type,settings from custom_field_data_types where clientid in (10699,25502,28289)) to 'custom_field_data_types.dat'
 \copy (select clientid,id,clientid,projectid,objecttypeid,datatypeid,name,displayorder,active,systemfield,searchable,searchkey,freetextsearch,searchindex,sitefieldid,defecttrackingconnectionid,integrationdefectfieldid from custom_fields where clientid in (10699,25502,28289)) to 'custom_fields.dat'
 \copy (select clientid,id,rev,revtype,createduserid,createddate,clientid,projectid,objecttypeid,datatypeid,name,displayorder,active,systemfield,searchable,searchkey,freetextsearch,searchindex,sitefieldid,defecttrackingconnectionid,integrationdefectfieldid,trxcreateduserid,trxcreateddate from custom_fields_aud where clientid in (10699,25502,28289)) to 'custom_fields_aud.dat'
 \copy (select clientid,id,clientid,templateid,customfieldid from custom_field_template_field_mapping where clientid in (10699,25502,28289)) to 'custom_field_template_field_mapping.dat'
 \copy (select clientid,id,clientid,name,isdefault from custom_field_templates where clientid in (10699,25502,28289)) to 'custom_field_templates.dat'
 \copy (select clientid,id,clientid,projectid,type,settings from custom_field_validators where clientid in (10699,25502,28289)) to 'custom_field_validators.dat'
 \copy (select clientid,id,rev,revtype,customfieldid,objectid,value,clientid,projectid,userid,createddate,trxcreateduserid,trxcreateddate from custom_field_values_aud where clientid in (10699,25502,28289)) to 'custom_field_values_aud.dat'
 \copy (select distinct cf.clientid,cfv.* from custom_field_integration_values_aud cfv inner join custom_fields cf on cfv.customfieldid = cf.id where cf.clientid in (10699,25502,28289)) to 'custom_field_integration_values_aud.dat';
 \copy (select clientid,id,clientid,customfieldtemplateid,projectid,customfieldid,customfieldvalueid from custom_field_values_exclude_projects where clientid in (10699,25502,28289)) to 'custom_field_values_exclude_projects.dat'
 \copy (select clientid,id,rev,revtype,clientid,customfieldtemplateid,projectid,customfieldid,customfieldvalueid from custom_field_values_exclude_projects_aud where clientid in (10699,25502,28289)) to 'custom_field_values_exclude_projects_aud.dat'
 \copy (select clientid,id,clientid,projectid,viewid,fieldname,displayorder,sorttype,sortorder from data_grid_view_custom_fields where clientid in (10699,25502,28289)) to 'data_grid_view_custom_fields.dat'
 \copy (select clientid,id,clientid,projectid,userid,objectid from data_grid_view_customs where clientid in (10699,25502,28289)) to 'data_grid_view_customs.dat'
 \copy (select clientid,id,clientid,projectid,userid,objecttypeid,objectid from data_grid_views where clientid in (10699,25502,28289)) to 'data_grid_views.dat'
 \copy (select clientid,id,clientid,projectid,objecttypeid,name,createduserid,createddatebk,createddate,type,timezoneid from data_queries where clientid in (10699,25502,28289)) to 'data_queries.dat'
 \copy (select clientid,id,clientid,projectid,type,settings from data_query_conditions where clientid in (10699,25502,28289)) to 'data_query_conditions.dat'
 \copy (select clientid,id,clientid,projectid,type,settings from data_query_operators where clientid in (10699,25502,28289)) to 'data_query_operators.dat'
 \copy (select clientid,id,clientid,projectid,name,createduserid,createddate,querytype from defect_queries where clientid in (10699,25502,28289)) to 'defect_queries.dat'
 \copy (select clientid,id,clientid,projectid,defectqueryid,leftgroup,rightgroup,field,operator,value,clauseorder,fieldtype from defect_query_clauses where clientid in (10699,25502,28289)) to 'defect_query_clauses.dat'
 \copy (select clientid,id,pid,clientid,projectid,assigneduserid,createduserid,summary,description,createddatebk,createddate,targetdate,closeddate,lastmodifieddate,targetdatebk,closeddatebk,projectmoduleid,statusid,typeid,reasonid,priorityid,severityid,categoryid,rootcauseid,affectedbuildid,affectedreleaseid,targetbuildid,targetreleaseid,fixedbuildid,fixedreleaseid,osid,browserid,serverid,envotherid,previousstatusid,draft,lastmodifieddatebk,lastmodifieduserid,sourcedefectid,modifieddate,indexmodifieddate,environmentid,indexflag,trxid,oldid,externalissueid,connectionid,externalprojectid,externalissuesummary,externalissuestatus,url,externalissuetype,externalissueuniqueid,unlinkeddefect from defects where clientid in (10699,25502,28289)) to 'defects.dat'
 \copy (select clientid,id,rev,revtype,clientid,projectid,summary,description,typeid,assigneduserid,statusid,severityid,priorityid,osid,browserid,envotherid,serverid,affectedreleaseid,affectedbuildid,fixedreleaseid,fixedbuildid,targetreleaseid,targetbuildid,targetdatebk,targetdate,closeddate,closeddatebk,reasonid,projectmoduleid,categoryid,environmentid,trxid,oldid,userid,createddate,creatorid,createduserid,lastmodifieduserid,lastmodifieddate,externalissueid,connectionid,externalprojectid,externalissuesummary,externalissuestatus,url,externalissuetype,draft,rootcauseid,previousstatusid,sourcedefectid,trxcreateduserid,trxcreateddate,pid,indexflag from defects_aud where clientid in (10699,25502,28289)) to 'defects_aud.dat'
 \copy (select clientid,id,clientid,projectid,name,serverurl,username,password,encryptedpassword,active,defecttrackingsystemid,configured,clientjiraconnectionid,enabled,requirementenabled,migrate,usescenario,autoretrievescenarioreq,uniqueid,weburl,releaseenabled,populateunlinkdefects,releaseautofilter from defect_tracking_connection where clientid in (10699,25502,28289)) to 'defect_tracking_connection.dat'
 \copy (select clientid,id,clientid,projectid,name,serverurl,username,password,weburl from defect_tracking_connection_test where clientid in (10699,25502,28289)) to 'defect_tracking_connection_test.dat'
 \copy (select clientid,id,clientid,projectid,displayorder,name,label,active,required,multivalue,displaytype,defaultvalue,listfieldvalue,listautofillfield,defecttrackingtypeid,defecttrackingprojectid from defect_tracking_field where clientid in (10699,25502,28289)) to 'defect_tracking_field.dat'
 \copy (select clientid,id,clientid,projectid,defectprojectid,name,defecttrackingconnectionid,populated,active from defect_tracking_project where clientid in (10699,25502,28289)) to 'defect_tracking_project.dat'
 \copy (select clientid,id,clientid,projectid,name,label,defecttrackingconnectionid,integrationprojectid,pollexception,polled,lastsync from defect_tracking_type where clientid in (10699,25502,28289)) to 'defect_tracking_type.dat'
 \copy (select clientid,id,clientid,projectid,usinginternalsystem from defect_tracking_usage where clientid in (10699,25502,28289)) to 'defect_tracking_usage.dat'
 \copy (select clientid,id,clientid,projectid,active from defect_workflow_transition where clientid in (10699,25502,28289)) to 'defect_workflow_transition.dat'
 \copy (select clientid,clientid,projectid,transitionid,userprofileid,id from defect_workflow_transition_profile where clientid in (10699,25502,28289)) to 'defect_workflow_transition_profile.dat'
 \copy (select clientid,clientid,projectid,transitionid,fromstatus,tostatus,id from defect_workflow_transition_status where clientid in (10699,25502,28289)) to 'defect_workflow_transition_status.dat'
 \copy (select clientid,id,clientid,authtype,name,authconfig,isactivated from external_auth_system_config where clientid in (10699,25502,28289)) to 'external_auth_system_config.dat'
 \copy (select clientid,id,clientid,mapto,externalauthsystemconfigid,username from external_client_user where clientid in (10699,25502,28289)) to 'external_client_user.dat'
 \copy (select clientid,id,groupid,clientid,authorityid from group_authorities where clientid in (10699,25502,28289)) to 'group_authorities.dat'
 \copy (select clientid,id,clientid,groupid,clientuserid from group_members where clientid in (10699,25502,28289)) to 'group_members.dat'
 \copy (select clientid,id,clientid,name,readonly,defaultgroup,defaultgroupid from groups where clientid in (10699,25502,28289)) to 'groups.dat'
 \copy (select clientid,id,clientid,projectid,objecttypeid,name,active,oncreation,onapproval,type,isupdatedincident,systemid from incidents where clientid in (10699,25502,28289)) to 'incidents.dat'
 \copy (select clientid,id,clientid,userid,token,expiredate,type from insights_token where clientid in (10699,25502,28289)) to 'insights_token.dat'
 \copy (select clientid,id,testcaseresultdefectid,externalissuefieldid,externalissuefieldvalue,clientid,projectid from integration_defect_issue_data where clientid in (10699,25502,28289)) to 'integration_defect_issue_data.dat'
 \copy (select clientid,id,defectid,externalissuefieldid,externalissuefieldvalue,clientid,projectid from integration_external_defect_issue_data where clientid in (10699,25502,28289)) to 'integration_external_defect_issue_data.dat'
 \copy (select clientid,id,clientid,projectid,connectionid,externalissueid,externalprojectid from integration_external_issues where clientid in (10699,25502,28289)) to 'integration_external_issues.dat'
 \copy (select clientid,id,clientid,projectid,fromexternalissueid,toexternalissueid,externallinkid,referencecount from integration_external_issues_maps where clientid in (10699,25502,28289)) to 'integration_external_issues_maps.dat'
 \copy (select clientid,id,clientid,projectid,releaseid,externalissueid,externalissuelink,integrationtypemapid from integration_issue_release_maps where clientid in (10699,25502,28289)) to 'integration_issue_release_maps.dat'
 \copy (select clientid,id,clientid,projectid,requirementid,externalissueid,externalissuelink,integrationtypemapid,externalissueuniqueid from integration_issue_requirement_maps where clientid in (10699,25502,28289)) to 'integration_issue_requirement_maps.dat'
 \copy (select clientid,id,clientid,projectid,testcaseid,externalissueid,externallinkid,referencecount from integration_issue_test_case_maps where clientid in (10699,25502,28289)) to 'integration_issue_test_case_maps.dat'
 \copy (select clientid,id,clientid,projectid,connectionid,testrunid,externalissueid,externalprojectid,linkid from integration_issue_test_case_run_maps where clientid in (10699,25502,28289)) to 'integration_issue_test_case_run_maps.dat'
 \copy (select clientid,id,clientid,projectid,parentmoduleid,requirementid,moduleid,originalname,modulelevel,createddate from integration_sync_requirement_tracker where clientid in (10699,25502,28289)) to 'integration_sync_requirement_tracker.dat'
 \copy (select clientid,id,webhookid,clientid,projectid from integration_webhooks where clientid in (10699,25502,28289)) to 'integration_webhooks.dat'
 \copy (select clientid,id,clientid,name,extrainfo from launch_user_setting where clientid in (10699,25502,28289)) to 'launch_user_setting.dat'
 \copy (select clientid,clientid,url,base,basesearch,userobjectclass,userdn,password,mappedusername,mappedfirstname,mappedlastname,mappedemail,connected from ldap_configuration where clientid in (10699,25502,28289)) to 'ldap_configuration.dat'
 \copy (select clientid,id,clientid,blobsize,name from license_blob_handles where clientid in (10699,25502,28289)) to 'license_blob_handles.dat'
 \copy (select clientid,id,lookupvalue,lookuptypeid,clientid,projectid,systemvalue,position from lookup where clientid in (10699,25502,28289)) to 'lookup.dat'
 \copy (select clientid,id,name,clientid,projectid,systemtype,position from lookup_types where clientid in (10699,25502,28289)) to 'lookup_types.dat'
 \copy (select clientid,id,authentication,scopes,appname,clientid,userid from oauth_authentications where clientid in (10699,25502,28289)) to 'oauth_authentications.dat'
 \copy (select clientid,id,objectid,userid,targetdatebk,targetdate,completedate,completedatebk,clientid,projectid,objecttypeid,assignmenttype,priorityid,trxid,oldid from object_assignments where clientid in (10699,25502,28289)) to 'object_assignments.dat'
 \copy (select clientid,id,rev,revtype,objectid,userid,clientid,projectid,objecttypeid,assignmenttype,trxid,oldid,createddate,trxcreateduserid,trxcreateddate,targetdate,completedate,priorityid from object_assignments_aud where clientid in (10699,25502,28289)) to 'object_assignments_aud.dat'
 \copy (select clientid,id,clientid,projectid,objectid,objecttypeid,userid,objectcomment,commentdatebk,commentdate,editdate,editdatebk,trxid,oldid from object_comments where clientid in (10699,25502,28289)) to 'object_comments.dat'
 \copy (select clientid,objecttypeid,id,rev,revtype,clientid,commentdatebk,commentdate,objectcomment,objectid,projectid,userid,createddate,trxcreateduserid,trxcreateddate,editdate from object_comments_aud where clientid in (10699,25502,28289)) to 'object_comments_aud.dat'
 \copy (select clientid,id,clientid,projectid,atypeid,aid,btypeid,bid from object_links where clientid in (10699,25502,28289)) to 'object_links.dat'
 \copy (select clientid,id,clientid,projectid,objecttypeid,objectid,userid from object_subscribers where clientid in (10699,25502,28289)) to 'object_subscribers.dat'
 \copy (select clientid,id,clientid,projectid,objectid,objecttypeid,tag from object_tags where clientid in (10699,25502,28289)) to 'object_tags.dat'
 \copy (select clientid,id,clientid,projectsecurityprofileid,defaultpermissionid from project_default_permissions where clientid in (10699,25502,28289)) to 'project_default_permissions.dat'
 \copy (select clientid,id,name,value,clientid,projectid from project_key_values where clientid in (10699,25502,28289)) to 'project_key_values.dat'
 \copy (select clientid,id,pid,clientid,projectid,parentmoduleid,name,isontestplan,moduletype,description,deleted,objorder,shared,createddate,creatorid,lastmodifieddate,lastmodifieduserid,trxid,oldid from project_modules where clientid in (10699,25502,28289)) to 'project_modules.dat'
 \copy (select clientid,id,rev,revtype,clientid,deleted,description,moduletype,name,parentmoduleid,shared,projectid,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder from project_modules_aud where clientid in (10699,25502,28289)) to 'project_modules_aud.dat'
 \copy (select clientid,id,clientid,name,startdatebk,enddatebk,startdate,enddate,description,projectstatusid,issampleproject,ispatchedincidents,automation,clonestatus,patchincidentstatus,trxid,oldid,defectworkflow,customfieldtemplateid,internally,sourceprojectid,indexingstatus from projects where clientid in (10699,25502,28289)) to 'projects.dat'
 \copy (select clientid,id,rev,revtype,clientid,name,description,projectstatusid,issampleproject,ispatchedincidents,patchincidentstatus,automation,defectworkflow,sourceprojectid,clonestatus,customfieldtemplateid,internally,trxcreateduserid,startdate,enddate,trxid,trxcreateddate from projects_aud where clientid in (10699,25502,28289)) to 'projects_aud.dat'
 \copy (select clientid,id,name,value,clientid,projectid from project_settings where clientid in (10699,25502,28289)) to 'project_settings.dat'
 \copy (select clientid,id,clazz,data,exception,begintimestamp,endtimestamp,clientid,projectid,userid,inprogress from queue_event where clientid in (10699,25502,28289)) to 'queue_event.dat'
 \copy (select clientid,id,createdon,type,state,contenttype,clientid,createdby,content from queue_processing_state where clientid in (10699,25502,28289)) to 'queue_processing_state.dat'
 \copy (select clientid,id,clientid,projectid,type,settings from recipient_types where clientid in (10699,25502,28289)) to 'recipient_types.dat'
 \copy (select clientid,id,clientid,projectid,objectid,objecttypeid,deletedby,deleteddatebk,deleteddate,deleted from recycle_actions where clientid in (10699,25502,28289)) to 'recycle_actions.dat'
 \copy (select clientid,id,pid,clientid,projectid,releasename,releasedescription,startdatebk,enddatebk,startdate,enddate,releasestatusid,note,deleted,modifieduserid,modifieddate,objorder,createddate,creatorid,lastmodifieddate,lastmodifieduserid,trxid,oldid from releases where clientid in (10699,25502,28289)) to 'releases.dat'
 \copy (select clientid,id,rev,revtype,clientid,enddatebk,startdate,enddate,modifieddate,modifieddatebk,modifieduserid,note,projectid,releasedescription,releasename,releasestatusid,startdatebk,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,deleted,pid,objorder from releases_aud where clientid in (10699,25502,28289)) to 'releases_aud.dat'
 \copy (select clientid,id,clientid,projectid,userid,reporttypeid,name,description,forinternaldefectonly,fortimetracking from reports where clientid in (10699,25502,28289)) to 'reports.dat'
 \copy (select clientid,id,clientid,projectid,reportid,groupid,userid,name,data,createddate,updateddate from report_settings where clientid in (10699,25502,28289)) to 'report_settings.dat'
 \copy (select clientid,id,starttime,endtime,executiontime,handlerclass,handlermethod,requestmethod,requesturl,responsestatus,clientid,userid,projectid,pattern,numberofqueries from request_execution_time where clientid in (10699,25502,28289)) to 'request_execution_time.dat'
 \copy (select clientid,id,clientid,projectid,releaseid,requirementid,buildid from requirement_link_data where clientid in (10699,25502,28289)) to 'requirement_link_data.dat'
 \copy (select clientid,id,rev,revtype,clientid,projectid,releaseid,requirementid,buildid,trxcreateduserid,trxcreateddate from requirement_link_data_aud where clientid in (10699,25502,28289)) to 'requirement_link_data_aud.dat'
 \copy (select clientid,id,pid,clientid,projectid,name,requirement,projectmoduleid,requirementtypeid,releaseid,buildid,isontestplan,requirementpriorityid,statusid,deleted,objorder,lastmodifieddatebk,lastmodifieddate,createddate,lastmodifieduserid,indexmodifieddate,createddatebk,creatorid,trxid,oldid from requirements where clientid in (10699,25502,28289)) to 'requirements.dat'
 \copy (select clientid,id,rev,revtype,clientid,projectid,name,requirementtypeid,requirementpriorityid,statusid,requirement,releaseid,buildid,trxid,oldid,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder,projectmoduleid,deleted from requirements_aud where clientid in (10699,25502,28289)) to 'requirements_aud.dat'
 \copy (select clientid,id,clientid,testcaseid,requirementid,trxid,oldid from requirement_test_cases where clientid in (10699,25502,28289)) to 'requirement_test_cases.dat'
 \copy (select clientid,id,clientid,projectid,userid,objecttypeid,objectid,revid from revision_aware where clientid in (10699,25502,28289)) to 'revision_aware.dat'
 \copy (select clientid,id,clientid,projectid,timestamp,userid,trxid,oldid,executionid from revision_info where clientid in (10699,25502,28289)) to 'revision_info.dat'
 \copy (select clientid,id,clientid,projectid,scenariostatus,qteststatus,trxid,oldid from scenario_status_mapping where clientid in (10699,25502,28289)) to 'scenario_status_mapping.dat'
 \copy (select clientid,id,clientid,projectid,objectid,objecttypeid,customfieldid,action,tasktype,timestamp from search_tasks where clientid in (10699,25502,28289)) to 'search_tasks.dat'
 \copy (select clientid,id,name,readonly,defaultgroupid,clientid from security_profiles where clientid in (10699,25502,28289)) to 'security_profiles.dat'
 \copy (select clientid,id,clientid,name from sso_idp_metadata_file where clientid in (10699,25502,28289)) to 'sso_idp_metadata_file.dat'
 \copy (select clientid,id,starttime,endtime,executiontime,taskname,clientid,userid,projectid from task_execution_time where clientid in (10699,25502,28289)) to 'task_execution_time.dat'
 \copy (select clientid,id,clientid,projectid,name,deleted,trxid,oldid from test_beds where clientid in (10699,25502,28289)) to 'test_beds.dat'
 \copy (select clientid,id,clientid,projectid,agentid,testcaseid from test_case_agents where clientid in (10699,25502,28289)) to 'test_case_agents.dat'
 \copy (select clientid,id,clientid,projectid,resultid,defectid,externalissueid,externalissuesummary,externalissueurl,externalissuestatus,integrationconnectionid,externalprojectid,resulttype,externalissueresolution,externalissuetype,trxid,oldid,externalissueuniqueid,testcaseid,testcaserunid,testcaseversionid from test_case_result_defects where clientid in (10699,25502,28289)) to 'test_case_result_defects.dat'
 \copy (select clientid,id,clientid,userid,testcaseversionid,testcaserunid,testexecutionresultid,executiontypeid,buildid,releaseid,executionstartdatebk,executionenddatebk,resultnumber,plannedstartdatebk,plannedenddatebk,plannedstartdate,plannedenddate,executionstartdate,executionenddate,testdatasetid,assigneduserid,customfieldvalues,configurationid,plannedexecutiontime,actualexecutiontime,buildnumber,buildurl,cisystemtype,trxid,oldid,automation,testcaseid,edited,submittedby from test_case_results where clientid in (10699,25502,28289)) to 'test_case_results.dat'
 \copy (select clientid,id,rev,revtype,buildid,clientid,executionenddatebk,executionstartdatebk,executiontypeid,plannedenddatebk,plannedstartdate,plannedenddate,executionstartdate,executionenddate,plannedstartdatebk,releaseid,resultnumber,testcaserunid,testcaseversionid,testdatasetid,userid,projectid,createddate,testcaseid,trxcreateduserid,trxcreateddate,customfieldvalues,configurationid,plannedexecutiontime,actualexecutiontime,buildnumber,buildurl,cisystemtype,automation,assigneduserid,testexecutionresultid,edited,submittedby from test_case_results_aud where clientid in (10699,25502,28289)) to 'test_case_results_aud.dat'
 \copy (select clientid,id,pid,clientid,projectid,releaseid,testcycleid,testsuiteid,testcaseid,testcaseversionid,buildid,userid,testbedid,projecttesttypeid,name,plannedstartdatebk,plannedenddatebk,plannedstartdate,plannedenddate,runorder,deleted,latesttestcaseresultid,objorder,lastmodifieddatebk,lastmodifieddate,createddate,lastmodifieduserid,indexmodifieddate,createddatebk,creatorid,configurationid,priorityid,plannedexecutiontime,buildnumber,buildurl,cisystemtype,trxid,oldid,latesttestexecutionresultid,veraapprovalstatusid,verasignatures,verapendingtasks,locked,veraid from test_case_run where clientid in (10699,25502,28289)) to 'test_case_run.dat'
 \copy (select clientid,id,rev,revtype,clientid,projectid,name,userid,testcaseversionid,plannedstartdatebk,plannedenddatebk,plannedstartdate,plannedenddate,testbedid,runorder,testsuiteid,projecttesttypeid,latesttestcaseresultid,deleted,releaseid,buildid,configurationid,priorityid,plannedexecutiontime,buildnumber,buildurl,cisystemtype,trxid,oldid,createddate,testcycleid,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder,testcaseid,latesttestexecutionresultid,veraapprovalstatusid,verasignatures,verapendingtasks,locked,veraid from test_case_run_aud where clientid in (10699,25502,28289)) to 'test_case_run_aud.dat'
 \copy (select clientid,id,pid,clientid,projectid,projectmoduleid,name,testcasetypeid,deleted,latesttestcaseversionid,objorder,lastmodifieddatebk,lastmodifieddate,createddate,lastmodifieduserid,indexmodifieddatebk,indexmodifieddate,createddatebk,creatorid,automationid,classid,classidhashcode,shared,priorityid,trxid,oldid,latestrunresultid from test_cases where clientid in (10699,25502,28289)) to 'test_cases.dat'
 \copy (select clientid,id,rev,revtype,clientid,name,testcasetypeid,classid,automationid,shared,priorityid,trxid,oldid,projectid,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder,deleted,latesttestcaseversionid,projectmoduleid,classidhashcode from test_cases_aud where clientid in (10699,25502,28289)) to 'test_cases_aud.dat'
 \copy (select clientid,id,clientid,testcaseid,testcaseversionstatusid,baselinenumber,increasenumber,description,precondition,deleted,version,modifieduserid,modifieddate,trxid,oldid from test_case_versions where clientid in (10699,25502,28289)) to 'test_case_versions.dat'
 \copy (select clientid,id,rev,revtype,clientid,testcaseid,baselinenumber,increasenumber,testcaseversionstatusid,description,precondition,trxid,oldid,projectid,userid,createddate,trxcreateduserid,trxcreateddate,deleted,version from test_case_versions_aud where clientid in (10699,25502,28289)) to 'test_case_versions_aud.dat'
 \copy (select clientid,id,pid,clientid,projectid,buildid,releaseid,parenttestcycleid,startdatebk,enddatebk,startdate,enddate,name,description,testcycletype,deleted,objorder,createddate,creatorid,lastmodifieddate,lastmodifieduserid,trxid,oldid from test_cycles where clientid in (10699,25502,28289)) to 'test_cycles.dat'
 \copy (select clientid,id,rev,revtype,buildid,clientid,deleted,description,enddatebk,startdate,enddate,name,projectid,releaseid,parenttestcycleid,startdatebk,testcycletype,userid,createddate,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder from test_cycles_aud where clientid in (10699,25502,28289)) to 'test_cycles_aud.dat'
 \copy (select clientid,id,clientid,projectid,name,isontestplan,description,trxid,oldid from test_data_sets where clientid in (10699,25502,28289)) to 'test_data_sets.dat'
 \copy (select clientid,id,name,active,deleted,clientid,projectid from test_parameters where clientid in (10699,25502,28289)) to 'test_parameters.dat'
 \copy (select clientid,id,teststepid,parameterid,startindex,endindex,startwithoutprefixindex,endwithoutsuffixindex,clientid,projectid from test_step_parameters where clientid in (10699,25502,28289)) to 'test_step_parameters.dat'
 \copy (select clientid,id,rev,revtype,clientid,teststepid,parameterid,startindex,endindex,startwithoutprefixindex,endwithoutsuffixindex,trxid,oldid,projectid,trxcreateduserid,trxcreateddate from test_step_parameters_aud where clientid in (10699,25502,28289)) to 'test_step_parameters_aud.dat'
 \copy (select clientid,id,teststepparameterid,testrunid,parametervaluecontent,parametervalueid,clientid,projectid from test_step_parameter_values where clientid in (10699,25502,28289)) to 'test_step_parameter_values.dat'
 \copy (select clientid,id,clientid,teststepresultid,defectid,externaldefectid,defecttrackingconnectionid,defectprojectid from test_step_result_defects where clientid in (10699,25502,28289)) to 'test_step_result_defects.dat'
 \copy (select clientid,id,clientid,testcaseresultid,teststepid,testexecutionresultid,userid,datebk,date,actualresult,resultorder,calledtestcaseid,calledtestcasename,trxid,oldid,testcaseid,testcaserunid,testcaseversionid,actualresultmigrated from test_step_results where clientid in (10699,25502,28289)) to 'test_step_results.dat'
 \copy (select clientid,id,rev,revtype,clientid,teststepid,testcaseresultid,testexecutionresultid,userid,actualresult,resultorder,date,testcaseversionid,calledtestcaseid,calledtestcasename,testcaseid,testcaserunid from test_step_results_aud where clientid in (10699,25502,28289)) to 'test_step_results_aud.dat'
 \copy (select clientid,teststepid,rev,revtype,testcaseid,calledtestcaseid,clientid,projectid,userid,createddate,trxcreateduserid,trxcreateddate from test_steps_test_cases_aud where clientid in (10699,25502,28289)) to 'test_steps_test_cases_aud.dat'
 \copy (select clientid,id,pid,clientid,projectid,testcycleid,testdatasetid,projecttesttypeid,releaseid,buildid,userid,name,description,plannedstartdatebk,plannedenddatebk,plannedstartdate,plannedenddate,deleted,testbedid,modifieduserid,modifieddate,objorder,createddate,creatorid,lastmodifieddate,lastmodifieduserid,trxid,oldid from test_suites where clientid in (10699,25502,28289)) to 'test_suites.dat'
 \copy (select clientid,id,rev,revtype,clientid,projectid,name,testdatasetid,userid,projecttesttypeid,plannedstartdatebk,plannedenddatebk,plannedstartdate,plannedenddate,description,releaseid,buildid,testbedid,trxid,oldid,createddate,testcycleid,deleted,creatorid,lastmodifieduserid,lastmodifieddate,trxcreateduserid,trxcreateddate,pid,objorder from test_suites_aud where clientid in (10699,25502,28289)) to 'test_suites_aud.dat'
 \copy (select clientid,id,clientid,userid,taskid,status,numberofdonesubtask from tutorial_task_users where clientid in (10699,25502,28289)) to 'tutorial_task_users.dat'
 \copy (select clientid,id,clientid,projectid,createdby,location,strcriteria from user_criteria where clientid in (10699,25502,28289)) to 'user_criteria.dat'
 \copy (select clientid,id,usergroupid,authorityid,clientid from user_group_authorities where clientid in (10699,25502,28289)) to 'user_group_authorities.dat'
 \copy (select clientid,id,rev,revtype,usergroupid,authorityid,clientid from user_group_authorities_aud where clientid in (10699,25502,28289)) to 'user_group_authorities_aud.dat'
 \copy (select clientid,id,clientuserid,usergroupid,clientid from user_group_members where clientid in (10699,25502,28289)) to 'user_group_members.dat'
 \copy (select clientid,id,rev,revtype,clientuserid,usergroupid,clientid from user_group_members_aud where clientid in (10699,25502,28289)) to 'user_group_members_aud.dat'
 \copy (select clientid,id,name,description,issystem,isdefault,clientid from user_groups where clientid in (10699,25502,28289)) to 'user_groups.dat'
 \copy (select clientid,id,rev,revtype,name,description,issystem,isdefault,clientid from user_groups_aud where clientid in (10699,25502,28289)) to 'user_groups_aud.dat'
 \copy (select clientid,id,userid,clientid,projectid,isfavorite from user_projects where clientid in (10699,25502,28289)) to 'user_projects.dat'
 \copy (select clientid,id,clientid,projectid,userid,tree,objecttype from user_unique_id where clientid in (10699,25502,28289)) to 'user_unique_id.dat'
 \copy (select clientid,id,clientid,projectid,timestamp,userid,trxid,oldid,executionid from revision_info where clientid is null) to 'null_revision_info.dat'
 \copy (select * from lookup where clientid is null) to 'null_lookup.dat'