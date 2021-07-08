\encoding UTF8

\set ON_ERROR_STOP on

\set clientid 25257

set application_name to dba;

set work_mem='1GB';

\timing on

-- manual 

insert into public.ext_client (sitename,siteurl,systemid,clientid,fromid,fromclientid)
select s.sitename,s.siteurl,s.systemid,s.clientid,s.clientid,s.clientid from ztmpclientmigration.ext_client s;

insert into public.pid_increment (value,clientid,projectid,fromid,fromclientid)
select s.value,s.clientid,s.projectid,s.projectid,s.clientid from ztmpclientmigration.pid_increment s;

-- no sequence
insert into public.session (description,overallsummary,title,testername,createddate,modifieddate,processeddate,owneruser,edituser,otherenvironmentinfo,plannedduration,actualduration,extrainfo,sessionid,executor,assigneduser,systemid,status,type,pid,tags,testcharter,testobjectives,exportpdf,exportdoc,exportimage,clientid,projectid,fromid,fromclientid)
select s.description,s.overallsummary,s.title,s.testername,s.createddate,s.modifieddate,s.processeddate,s.owneruser,s.edituser,s.otherenvironmentinfo,s.plannedduration,s.actualduration,s.extrainfo,s.sessionid,s.executor,s.assigneduser,s.systemid,s.status,s.type,s.pid,s.tags,s.testcharter,s.testobjectives,s.exportpdf,s.exportdoc,s.exportimage,s.clientid,s.projectid,s.sessionid,s.clientid from ztmpclientmigration.session s
left join public.session d on s.sessionid = d.sessionid
where d.sessionid is null;
WITH vars AS (SELECT max(sessionid) AS maxid from public.session)
insert into public.session (sessionid,fromid,description,overallsummary,title,testername,createddate,modifieddate,processeddate,owneruser,edituser,otherenvironmentinfo,plannedduration,actualduration,extrainfo,executor,assigneduser,systemid,status,type,pid,tags,testcharter,testobjectives,exportpdf,exportdoc,exportimage,clientid,projectid,fromclientid)
select vars.maxid + (row_number() over (order by s.sessionid)),s.sessionid,s.description,s.overallsummary,s.title,s.testername,s.createddate,s.modifieddate,s.processeddate,s.owneruser,s.edituser,s.otherenvironmentinfo,s.plannedduration,s.actualduration,s.extrainfo,s.executor,s.assigneduser,s.systemid,s.status,s.type,s.pid,s.tags,s.testcharter,s.testobjectives,s.exportpdf,s.exportdoc,s.exportimage,s.clientid,s.projectid,s.clientid from ztmpclientmigration.session s
inner join public.session d on s.sessionid = d.sessionid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.sessionid)
cross join vars;

-- no sequence
insert into public.application_info (fileversion,filesize,filelastmodified,extrainfo,sessionid,path,name,firstactiontime,applicationinfoid,version,createddate,modifieddate,processeddate,status,clientid,projectid,fromid,fromclientid)
select s.fileversion,s.filesize,s.filelastmodified,s.extrainfo,s.sessionid,s.path,s.name,s.firstactiontime,s.applicationinfoid,s.version,s.createddate,s.modifieddate,s.processeddate,s.status,s.clientid,s.projectid,s.applicationinfoid,s.clientid from ztmpclientmigration.application_info s
left join public.application_info d on s.applicationinfoid = d.applicationinfoid
where d.applicationinfoid is null;
WITH vars AS (SELECT max(applicationinfoid) AS maxid from public.application_info)
insert into public.application_info (applicationinfoid,fromid,fileversion,filesize,filelastmodified,extrainfo,sessionid,path,name,firstactiontime,version,createddate,modifieddate,processeddate,status,clientid,projectid,fromclientid)
select vars.maxid + (row_number() over (order by s.applicationinfoid)),s.applicationinfoid,s.fileversion,s.filesize,s.filelastmodified,s.extrainfo,s.sessionid,s.path,s.name,s.firstactiontime,s.version,s.createddate,s.modifieddate,s.processeddate,s.status,s.clientid,s.projectid,s.clientid from ztmpclientmigration.application_info s
inner join public.application_info d on s.applicationinfoid = d.applicationinfoid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.applicationinfoid)
cross join vars;

-- no sequence
insert into public.coverage (externalurl,projectid,externalid,type,title,extrainfo,sessionid,coverageid,createddate,modifieddate,processeddate,publishername,submitteddate,status,prefix,pid,extsystemid,clientid,fromid,fromclientid)
select s.externalurl,s.projectid,s.externalid,s.type,s.title,s.extrainfo,s.sessionid,s.coverageid,s.createddate,s.modifieddate,s.processeddate,s.publishername,s.submitteddate,s.status,s.prefix,s.pid,s.extsystemid,s.clientid,s.coverageid,s.clientid from ztmpclientmigration.coverage s
left join public.coverage d on s.coverageid = d.coverageid
where d.coverageid is null;
WITH vars AS (SELECT max(coverageid) AS maxid from public.coverage)
insert into public.coverage (coverageid,fromid,externalurl,projectid,externalid,type,title,extrainfo,sessionid,createddate,modifieddate,processeddate,publishername,submitteddate,status,prefix,pid,extsystemid,clientid,fromclientid)
select vars.maxid + (row_number() over (order by s.coverageid)),s.coverageid,s.externalurl,s.projectid,s.externalid,s.type,s.title,s.extrainfo,s.sessionid,s.createddate,s.modifieddate,s.processeddate,s.publishername,s.submitteddate,s.status,s.prefix,s.pid,s.extsystemid,s.clientid,s.clientid from ztmpclientmigration.coverage s
inner join public.coverage d on s.coverageid = d.coverageid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.coverageid)
cross join vars;

-- no sequence

insert into public.data_query (parentid,extrainfo,status,createddate,modifieddate,clientid,projectid,dataqueryid,extsystemid,username,name,queryclauses,querytype,fromid,fromclientid)
select s.parentid,s.extrainfo,s.status,s.createddate,s.modifieddate,s.clientid,s.projectid,s.dataqueryid,s.extsystemid,s.username,s.name,s.queryclauses,s.querytype,s.dataqueryid,s.clientid from ztmpclientmigration.data_query s
left join public.data_query d on s.dataqueryid = d.dataqueryid
where d.dataqueryid is null;
WITH vars AS (SELECT max(dataqueryid) AS maxid from public.data_query)
insert into public.data_query (dataqueryid,fromid,parentid,extrainfo,status,createddate,modifieddate,clientid,projectid,extsystemid,username,name,queryclauses,querytype,fromclientid)
select vars.maxid + (row_number() over (order by s.dataqueryid)),s.dataqueryid,s.parentid,s.extrainfo,s.status,s.createddate,s.modifieddate,s.clientid,s.projectid,s.extsystemid,s.username,s.name,s.queryclauses,s.querytype,s.clientid from ztmpclientmigration.data_query s
inner join public.data_query d on s.dataqueryid = d.dataqueryid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.dataqueryid)
cross join vars;

-- no sequence

insert into public.screen (createddate,modifieddate,processeddate,finishedtimestamp,status,clientid,position,deleted,extrainfo,sessionid,externalscreenid,screenid,projectid,capturemode,screenshotfilename,thumbnailfilename,timestamp,title,browserurl,imageurl,thumbnailurl,timetypename,fromid,fromclientid)
select s.createddate,s.modifieddate,s.processeddate,s.finishedtimestamp,s.status,s.clientid,s.position,s.deleted,s.extrainfo,s.sessionid,s.externalscreenid,s.screenid,s.projectid,s.capturemode,s.screenshotfilename,s.thumbnailfilename,s.timestamp,s.title,s.browserurl,s.imageurl,s.thumbnailurl,s.timetypename,s.screenid,s.clientid from ztmpclientmigration.screen s
left join public.screen d on s.screenid = d.screenid
where d.screenid is null;
WITH vars AS (SELECT max(screenid) AS maxid from public.screen)
insert into public.screen (screenid,fromid,createddate,modifieddate,processeddate,finishedtimestamp,status,clientid,position,deleted,extrainfo,sessionid,externalscreenid,projectid,capturemode,screenshotfilename,thumbnailfilename,timestamp,title,browserurl,imageurl,thumbnailurl,timetypename,fromclientid)
select vars.maxid + (row_number() over (order by s.screenid)),s.screenid,s.createddate,s.modifieddate,s.processeddate,s.finishedtimestamp,s.status,s.clientid,s.position,s.deleted,s.extrainfo,s.sessionid,s.externalscreenid,s.projectid,s.capturemode,s.screenshotfilename,s.thumbnailfilename,s.timestamp,s.title,s.browserurl,s.imageurl,s.thumbnailurl,s.timetypename,s.clientid from ztmpclientmigration.screen s
inner join public.screen d on s.screenid = d.screenid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.screenid)
cross join vars;

-- insert screen_coverage (handle below the case where values of both screenid and coverageid exist)
insert into public.screen_coverage (status,screenid,coverageid,createddate,modifieddate,processeddate,extrainfo,clientid,projectid,fromid,fromclientid)
select s.status,s.screenid,s.coverageid,s.createddate,s.modifieddate,s.processeddate,s.extrainfo,s.clientid,s.projectid,s.screenid,s.clientid from ztmpclientmigration.screen_coverage s
left join public.screen_coverage d on s.screenid = d.screenid and s.coverageid = d.coverageid
where d.screenid is null;

-- no sequence
insert into public.note (name,clientid,settingid,categoryname,extrainfo,status,processeddate,modifieddate,createddate,projectid,icon,text,screenid,noteid,fromid,fromclientid)
select s.name,s.clientid,s.settingid,s.categoryname,s.extrainfo,s.status,s.processeddate,s.modifieddate,s.createddate,s.projectid,s.icon,s.text,s.screenid,s.noteid,s.noteid,s.clientid from ztmpclientmigration.note s
left join public.note d on s.noteid = d.noteid
where d.noteid is null;
WITH vars AS (SELECT max(noteid) AS maxid from public.note)
insert into public.note (noteid,fromid,name,clientid,settingid,categoryname,extrainfo,status,processeddate,modifieddate,createddate,projectid,icon,text,screenid,fromclientid)
select vars.maxid + (row_number() over (order by s.noteid)),s.noteid,s.name,s.clientid,s.settingid,s.categoryname,s.extrainfo,s.status,s.processeddate,s.modifieddate,s.createddate,s.projectid,s.icon,s.text,s.screenid,s.clientid from ztmpclientmigration.note s
inner join public.note d on s.noteid = d.noteid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.noteid)
cross join vars;

-- no sequence
insert into public.system_info (systeminfoid,sessionid,extrainfo,ado,appversion,availableram,cpu,ie,os,ram,resolutions,username,createddate,modifieddate,processeddate,status,clientid,projectid,fromid,fromclientid)
select s.systeminfoid,s.sessionid,s.extrainfo,s.ado,s.appversion,s.availableram,s.cpu,s.ie,s.os,s.ram,s.resolutions,s.username,s.createddate,s.modifieddate,s.processeddate,s.status,s.clientid,s.projectid,s.systeminfoid,s.clientid from ztmpclientmigration.system_info s
left join public.system_info d on s.systeminfoid = d.systeminfoid
where d.systeminfoid is null;
WITH vars AS (SELECT max(systeminfoid) AS maxid from public.system_info)
insert into public.system_info (systeminfoid,fromid,sessionid,extrainfo,ado,appversion,availableram,cpu,ie,os,ram,resolutions,username,createddate,modifieddate,processeddate,status,clientid,projectid,fromclientid)
select vars.maxid + (row_number() over (order by s.systeminfoid)),s.systeminfoid,s.sessionid,s.extrainfo,s.ado,s.appversion,s.availableram,s.cpu,s.ie,s.os,s.ram,s.resolutions,s.username,s.createddate,s.modifieddate,s.processeddate,s.status,s.clientid,s.projectid,s.clientid from ztmpclientmigration.system_info s
inner join public.system_info d on s.systeminfoid = d.systeminfoid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.systeminfoid)
cross join vars;

-- no sequence
insert into public.timeline (timelineid,sessionid,extrainfo,totaltime,createddate,modifieddate,processdate,status,categoryname,clientid,projectid,fromid,fromclientid)
select s.timelineid,s.sessionid,s.extrainfo,s.totaltime,s.createddate,s.modifieddate,s.processdate,s.status,s.categoryname,s.clientid,s.projectid,s.timelineid,s.clientid from ztmpclientmigration.timeline s
left join public.timeline d on s.timelineid = d.timelineid
where d.timelineid is null;
WITH vars AS (SELECT max(timelineid) AS maxid from public.timeline)
insert into public.timeline (timelineid,fromid,sessionid,extrainfo,totaltime,createddate,modifieddate,processdate,status,categoryname,clientid,projectid,fromclientid)
select vars.maxid + (row_number() over (order by s.timelineid)),s.timelineid,s.sessionid,s.extrainfo,s.totaltime,s.createddate,s.modifieddate,s.processdate,s.status,s.categoryname,s.clientid,s.projectid,s.clientid from ztmpclientmigration.timeline s
inner join public.timeline d on s.timelineid = d.timelineid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.timelineid)
cross join vars;


/* copy to the end
-- insert screen_coverage where values of both screenid and coverageid exist
insert into public.screen_coverage (fromid,status,screenid,coverageid,createddate,modifieddate,processeddate,extrainfo,clientid,projectid,fromclientid)
select s.screenid,s.status,s1.screenid,s2.coverageid,s.createddate,s.modifieddate,s.processeddate,s.extrainfo,s.clientid,s.projectid,s.clientid from ztmpclientmigration.screen_coverage s
inner join public.screen s1 on s1.fromid = s.screenid
inner join public.coverage s2 on s2.fromid = s.coverageid
where
s1.clientid = :clientid
and s1.fromclientid = :clientid
and s1.id != s1.fromid
and s2.clientid = :clientid
and s2.fromclientid = :clientid
and s2.id != s2.fromid
;
*/

/* helper script -- need to manually change "id" to tableid
select format('insert into public.%s (id,%s,fromid,fromclientid)
select s.id,%s,s.id,s.clientid from ztmpclientmigration.%s s
left join public.%s d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence(''public.%s'', ''id''), coalesce(max(id),0) + 1, false) FROM public.%s;
insert into public.%s (fromid,%s,fromclientid)
select s.id,%s,s.clientid from ztmpclientmigration.%s s
inner join public.%s d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.id);',
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
    and c.table_schema = 'public'
    and c.column_name not in ('id','fromid','fromclientid')
    ORDER BY t.table_name, c.ordinal_position
) t
inner join unnest('{session,
application_info,
comment,
ext_system,
coverage,
custom_view,
data_query,
explorer_token,
ext_client,
pid_increment,
plugin,
resource,
screen,
screen_coverage,
session_export,
session_history,
setting,
note,
system_info,
timeline,
user_setting}'::varchar[]) WITH ORDINALITY torder(name, ord)
on t.table_name = torder.name
WHERE t.table_name not in ('application_info','ext_client','pid_increment','screen_coverage','session','coverage','data_query','screen','note','system_info','timeline')
GROUP BY table_name, torder.ord
order by torder.ord asc;
*/

insert into public.comment (commentid,sessionid,extrainfo,author,content,createddate,modifieddate,processeddate,status,authorid,clientid,projectid,fromid,fromclientid)
select s.commentid,s.sessionid,s.extrainfo,s.author,s.content,s.createddate,s.modifieddate,s.processeddate,s.status,s.authorid,s.clientid,s.projectid,s.commentid,s.clientid from ztmpclientmigration.comment s
left join public.comment d on s.commentid = d.commentid
where d.commentid is null;
select setval(pg_get_serial_sequence('public.comment', 'commentid'), coalesce(max(commentid),0) + 1, false) FROM public.comment;
insert into public.comment (fromid,sessionid,extrainfo,author,content,createddate,modifieddate,processeddate,status,authorid,clientid,projectid,fromclientid)
select s.commentid,s.sessionid,s.extrainfo,s.author,s.content,s.createddate,s.modifieddate,s.processeddate,s.status,s.authorid,s.clientid,s.projectid,s.clientid from ztmpclientmigration.comment s
inner join public.comment d on s.commentid = d.commentid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.commentid);
insert into public.ext_system (extrainfo,extsystemid,systemid,createddate,modifieddate,status,clientid,projectid,fromid,fromclientid)
select s.extrainfo,s.extsystemid,s.systemid,s.createddate,s.modifieddate,s.status,s.clientid,s.projectid,s.extsystemid,s.clientid from ztmpclientmigration.ext_system s
left join public.ext_system d on s.extsystemid = d.extsystemid
where d.extsystemid is null;
select setval(pg_get_serial_sequence('public.ext_system', 'extsystemid'), coalesce(max(extsystemid),0) + 1, false) FROM public.ext_system;
insert into public.ext_system (fromid,extrainfo,systemid,createddate,modifieddate,status,clientid,projectid,fromclientid)
select s.extsystemid,s.extrainfo,s.systemid,s.createddate,s.modifieddate,s.status,s.clientid,s.projectid,s.clientid from ztmpclientmigration.ext_system s
inner join public.ext_system d on s.extsystemid = d.extsystemid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.extsystemid);
insert into public.custom_view (extrainfo,objecttypeid,objectid,username,extsystemid,customviewid,projectid,clientid,modifieddate,createddate,status,gridviewfields,fromid,fromclientid)
select s.extrainfo,s.objecttypeid,s.objectid,s.username,s.extsystemid,s.customviewid,s.projectid,s.clientid,s.modifieddate,s.createddate,s.status,s.gridviewfields,s.customviewid,s.clientid from ztmpclientmigration.custom_view s
left join public.custom_view d on s.customviewid = d.customviewid
where d.customviewid is null;
select setval(pg_get_serial_sequence('public.custom_view', 'customviewid'), coalesce(max(customviewid),0) + 1, false) FROM public.custom_view;
insert into public.custom_view (fromid,extrainfo,objecttypeid,objectid,username,extsystemid,projectid,clientid,modifieddate,createddate,status,gridviewfields,fromclientid)
select s.customviewid,s.extrainfo,s.objecttypeid,s.objectid,s.username,s.extsystemid,s.projectid,s.clientid,s.modifieddate,s.createddate,s.status,s.gridviewfields,s.clientid from ztmpclientmigration.custom_view s
inner join public.custom_view d on s.customviewid = d.customviewid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.customviewid);
insert into public.explorer_token (token,evaluationinfo,createddate,expireddate,clientid,userpermissioninfo,explorertokenid,fromid,fromclientid)
select s.token,s.evaluationinfo,s.createddate,s.expireddate,s.clientid,s.userpermissioninfo,s.explorertokenid,s.explorertokenid,s.clientid from ztmpclientmigration.explorer_token s
left join public.explorer_token d on s.explorertokenid = d.explorertokenid
where d.explorertokenid is null;
select setval(pg_get_serial_sequence('public.explorer_token', 'explorertokenid'), coalesce(max(explorertokenid),0) + 1, false) FROM public.explorer_token;
insert into public.explorer_token (fromid,token,evaluationinfo,createddate,expireddate,clientid,userpermissioninfo,fromclientid)
select s.explorertokenid,s.token,s.evaluationinfo,s.createddate,s.expireddate,s.clientid,s.userpermissioninfo,s.clientid from ztmpclientmigration.explorer_token s
inner join public.explorer_token d on s.explorertokenid = d.explorertokenid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.explorertokenid);


insert into public.plugin (pluginid,pluginname,description,category,mainfilename,mainfilepath,status,pluginversion,isbuiltin,clientid,clientsitename,submitteduser,createddate,modifieddate,fromid,fromclientid)
select s.pluginid,s.pluginname,s.description,s.category,s.mainfilename,s.mainfilepath,s.status,s.pluginversion,s.isbuiltin,s.clientid,s.clientsitename,s.submitteduser,s.createddate,s.modifieddate,s.pluginid,s.clientid from ztmpclientmigration.plugin s
left join public.plugin d on s.pluginid = d.pluginid
where d.pluginid is null;
select setval(pg_get_serial_sequence('public.plugin', 'pluginid'), coalesce(max(pluginid),0) + 1, false) FROM public.plugin;
insert into public.plugin (fromid,pluginname,description,category,mainfilename,mainfilepath,status,pluginversion,isbuiltin,clientid,clientsitename,submitteduser,createddate,modifieddate,fromclientid)
select s.pluginid,s.pluginname,s.description,s.category,s.mainfilename,s.mainfilepath,s.status,s.pluginversion,s.isbuiltin,s.clientid,s.clientsitename,s.submitteduser,s.createddate,s.modifieddate,s.clientid from ztmpclientmigration.plugin s
inner join public.plugin d on s.pluginid = d.pluginid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.pluginid);
insert into public.resource (projectid,clientid,modifieddate,createddate,status,mimetype,resourcekey,name,sessionid,resourceid,fromid,fromclientid)
select s.projectid,s.clientid,s.modifieddate,s.createddate,s.status,s.mimetype,s.resourcekey,s.name,s.sessionid,s.resourceid,s.resourceid,s.clientid from ztmpclientmigration.resource s
left join public.resource d on s.resourceid = d.resourceid
where d.resourceid is null;
select setval(pg_get_serial_sequence('public.resource', 'resourceid'), coalesce(max(resourceid),0) + 1, false) FROM public.resource;
insert into public.resource (fromid,projectid,clientid,modifieddate,createddate,status,mimetype,resourcekey,name,sessionid,fromclientid)
select s.resourceid,s.projectid,s.clientid,s.modifieddate,s.createddate,s.status,s.mimetype,s.resourcekey,s.name,s.sessionid,s.clientid from ztmpclientmigration.resource s
inner join public.resource d on s.resourceid = d.resourceid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.resourceid);


insert into public.session_export (username,sessionid,sessionexportid,projectid,clientid,requestdata,extrainfo,modifieddate,status,resourcekey,fromid,fromclientid)
select s.username,s.sessionid,s.sessionexportid,s.projectid,s.clientid,s.requestdata,s.extrainfo,s.modifieddate,s.status,s.resourcekey,s.sessionexportid,s.clientid from ztmpclientmigration.session_export s
left join public.session_export d on s.sessionexportid = d.sessionexportid
where d.sessionexportid is null;
select setval(pg_get_serial_sequence('public.session_export', 'sessionexportid'), coalesce(max(sessionexportid),0) + 1, false) FROM public.session_export;
insert into public.session_export (fromid,username,sessionid,projectid,clientid,requestdata,extrainfo,modifieddate,status,resourcekey,fromclientid)
select s.sessionexportid,s.username,s.sessionid,s.projectid,s.clientid,s.requestdata,s.extrainfo,s.modifieddate,s.status,s.resourcekey,s.clientid from ztmpclientmigration.session_export s
inner join public.session_export d on s.sessionexportid = d.sessionexportid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.sessionexportid);
insert into public.session_history (executor,clientid,projectid,historyid,sessionid,extrainfo,type,value,edituser,trackeddate,fromid,fromclientid)
select s.executor,s.clientid,s.projectid,s.historyid,s.sessionid,s.extrainfo,s.type,s.value,s.edituser,s.trackeddate,s.historyid,s.clientid from ztmpclientmigration.session_history s
left join public.session_history d on s.historyid = d.historyid
where d.historyid is null;
select setval(pg_get_serial_sequence('public.session_history', 'historyid'), coalesce(max(historyid),0) + 1, false) FROM public.session_history;
insert into public.session_history (fromid,executor,clientid,projectid,sessionid,extrainfo,type,value,edituser,trackeddate,fromclientid)
select s.historyid,s.executor,s.clientid,s.projectid,s.sessionid,s.extrainfo,s.type,s.value,s.edituser,s.trackeddate,s.clientid from ztmpclientmigration.session_history s
inner join public.session_history d on s.historyid = d.historyid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.historyid);
insert into public.setting (createddate,extrainfo,extsystemid,settingid,projectid,clientid,categoryid,type,status,processeddate,modifieddate,fromid,fromclientid)
select s.createddate,s.extrainfo,s.extsystemid,s.settingid,s.projectid,s.clientid,s.categoryid,s.type,s.status,s.processeddate,s.modifieddate,s.settingid,s.clientid from ztmpclientmigration.setting s
left join public.setting d on s.settingid = d.settingid
where d.settingid is null;
select setval(pg_get_serial_sequence('public.setting', 'settingid'), coalesce(max(settingid),0) + 1, false) FROM public.setting;
insert into public.setting (fromid,createddate,extrainfo,extsystemid,projectid,clientid,categoryid,type,status,processeddate,modifieddate,fromclientid)
select s.settingid,s.createddate,s.extrainfo,s.extsystemid,s.projectid,s.clientid,s.categoryid,s.type,s.status,s.processeddate,s.modifieddate,s.clientid from ztmpclientmigration.setting s
inner join public.setting d on s.settingid = d.settingid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.settingid);
insert into public.user_setting (usersettingid,username,extrainfo,clientid,fromid,fromclientid)
select s.usersettingid,s.username,s.extrainfo,s.clientid,s.usersettingid,s.clientid from ztmpclientmigration.user_setting s
left join public.user_setting d on s.usersettingid = d.usersettingid
where d.usersettingid is null;
select setval(pg_get_serial_sequence('public.user_setting', 'usersettingid'), coalesce(max(usersettingid),0) + 1, false) FROM public.user_setting;
insert into public.user_setting (fromid,username,extrainfo,clientid,fromclientid)
select s.usersettingid,s.username,s.extrainfo,s.clientid,s.clientid from ztmpclientmigration.user_setting s
inner join public.user_setting d on s.usersettingid = d.usersettingid
and (d.fromid is null or d.fromid is not null and d.fromclientid is not null and d.fromclientid NOT IN (:clientid) or d.fromclientid is not null and d.fromclientid IN (:clientid) and d.fromid != d.usersettingid);

-- insert screen_coverage where values of both screenid and coverageid exist
insert into public.screen_coverage (fromid,status,screenid,coverageid,createddate,modifieddate,processeddate,extrainfo,clientid,projectid,fromclientid)
select s.screenid,s.status,s1.screenid,s2.coverageid,s.createddate,s.modifieddate,s.processeddate,s.extrainfo,s.clientid,s.projectid,s.clientid from ztmpclientmigration.screen_coverage s
inner join public.screen s1 on s1.fromid = s.screenid
inner join public.coverage s2 on s2.fromid = s.coverageid
where
s1.clientid IN (:clientid)
and s1.fromclientid IN (:clientid)
and s1.screenid != s1.fromid
and s2.clientid IN (:clientid)
and s2.fromclientid IN (:clientid)
and s2.coverageid != s2.fromid
;