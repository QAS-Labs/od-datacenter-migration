\encoding UTF8

\set ON_ERROR_STOP on

set application_name to dba;

set work_mem='4GB';

-- manual 

-- generated
/*
select
format('\copy (select %s from %s where clientid in (33417)) to ''%s.dat''',
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
*/

/*
Insights 
1. vw_session_coverage: 
2 tables: session coverage.

2. tables:
+ screen
+ screen_coverage   
+ note
+ timeline
*/
 \copy (select applicationinfoid,sessionid,extrainfo,filelastmodified,filesize,fileversion,firstactiontime,name,path,version,createddate,modifieddate,processeddate,status,clientid,projectid from application_info where clientid in (33417)) to 'application_info.dat'
 \copy (select commentid,sessionid,extrainfo,author,content,createddate,modifieddate,processeddate,status,authorid,clientid,projectid from comment where clientid in (33417)) to 'comment.dat'
 \copy (select coverageid,sessionid,extrainfo,title,type,externalid,externalurl,createddate,modifieddate,processeddate,publishername,submitteddate,status,prefix,pid,extsystemid,clientid,projectid from coverage where clientid in (33417)) to 'coverage.dat'
 \copy (select customviewid,extsystemid,username,objectid,objecttypeid,gridviewfields,extrainfo,status,createddate,modifieddate,clientid,projectid from custom_view where clientid in (33417)) to 'custom_view.dat'
 \copy (select dataqueryid,extsystemid,username,name,queryclauses,querytype,parentid,extrainfo,status,createddate,modifieddate,clientid,projectid from data_query where clientid in (33417)) to 'data_query.dat'
 \copy (select explorertokenid,token,evaluationinfo,createddate,expireddate,clientid,userpermissioninfo from explorer_token where clientid in (33417)) to 'explorer_token.dat'
 \copy (select sitename,siteurl,systemid,clientid from ext_client where clientid in (33417)) to 'ext_client.dat'
 \copy (select extsystemid,extrainfo,systemid,createddate,modifieddate,status,clientid,projectid from ext_system where clientid in (33417)) to 'ext_system.dat'
 \copy (select noteid,screenid,text,icon,name,createddate,modifieddate,processeddate,status,extrainfo,categoryname,settingid,clientid,projectid from note where clientid in (33417)) to 'note.dat'
 \copy (select value,clientid,projectid from pid_increment where clientid in (33417)) to 'pid_increment.dat'
 \copy (select pluginid,pluginname,description,category,mainfilename,mainfilepath,status,pluginversion,isbuiltin,clientid,clientsitename,submitteduser,createddate,modifieddate from plugin where clientid in (33417)) to 'plugin.dat'
 \copy (select resourceid,sessionid,name,resourcekey,mimetype,status,createddate,modifieddate,clientid,projectid from resource where clientid in (33417)) to 'resource.dat'
 \copy (select screenid,externalscreenid,sessionid,extrainfo,position,capturemode,screenshotfilename,thumbnailfilename,timestamp,title,browserurl,imageurl,thumbnailurl,timetypename,createddate,modifieddate,processeddate,finishedtimestamp,status,clientid,projectid,deleted from screen where clientid in (33417)) to 'screen.dat'
 \copy (select screenid,coverageid,createddate,modifieddate,processeddate,status,extrainfo,clientid,projectid from screen_coverage where clientid in (33417)) to 'screen_coverage.dat'
 \copy (select sessionid,extrainfo,actualduration,plannedduration,otherenvironmentinfo,description,overallsummary,title,testername,createddate,modifieddate,processeddate,owneruser,edituser,executor,assigneduser,systemid,status,type,pid,tags,testcharter,testobjectives,exportpdf,exportdoc,exportimage,clientid,projectid from session where clientid in (33417)) to 'session.dat'
 \copy (select sessionexportid,sessionid,username,resourcekey,status,modifieddate,extrainfo,requestdata,clientid,projectid from session_export where clientid in (33417)) to 'session_export.dat'
 \copy (select historyid,sessionid,extrainfo,type,value,edituser,executor,trackeddate,clientid,projectid from session_history where clientid in (33417)) to 'session_history.dat'
 \copy (select settingid,extsystemid,extrainfo,createddate,modifieddate,processeddate,status,type,categoryid,clientid,projectid from setting where clientid in (33417)) to 'setting.dat'
 \copy (select systeminfoid,sessionid,extrainfo,ado,appversion,availableram,cpu,ie,os,ram,resolutions,username,createddate,modifieddate,processeddate,status,clientid,projectid from system_info where clientid in (33417)) to 'system_info.dat'
 \copy (select timelineid,sessionid,extrainfo,totaltime,createddate,modifieddate,processdate,status,categoryname,clientid,projectid from timeline where clientid in (33417)) to 'timeline.dat'
 \copy (select usersettingid,username,extrainfo,clientid from user_setting where clientid in (33417)) to 'user_setting.dat'