\encoding UTF8

\set ON_ERROR_STOP on

\set clientid 18555

set application_name to dba;

set work_mem='1GB';

\timing on

/* not needed, client url is not changed
update public.coverage a
set externalurl = replace(a.externalurl,'https://tuiuk.qtestnet.com/p/','https://icelandfoods.qtestnet.com/p/')
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.externalurl ilike concat('https://tuiuk.qtestnet.com/p/%');
*/

update public.coverage a
set externalurl = replace(a.externalurl,
                            concat('https://icelandfoods.qtestnet.com/p/',p.fromid,'/portal/project#tab='),
                            concat('https://icelandfoods.qtestnet.com/p/',p.id,'/portal/project#tab=')
)
from ztmpclientmigration.newid_projects p
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = p.clientid
and a.externalurl ilike concat('https://icelandfoods.qtestnet.com/p/',p.fromid,'/portal/project#tab=','%')
;