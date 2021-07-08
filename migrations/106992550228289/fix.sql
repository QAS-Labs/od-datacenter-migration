\copy (select dq.clientid, dqc.* from data_query_clauses dqc inner join data_queries dq on dqc.dataqueryid = dq.id where dq.clientid in (10699,25502,28289) ) to 'data_query_clauses.dat'
/*
    id bigint NOT NULL DEFAULT nextval('data_query_clauses_id_seq'::regclass),
    dataqueryid bigint NOT NULL,
    dataqueryconditionid bigint NOT NULL,
    dataqueryoperatorid bigint NOT NULL,
    dataqueryclauseid bigint,
    "position" bigint NOT NULL,
    value text COLLATE pg_catalog."default",
    conditionsettings text COLLATE pg_catalog."default",
*/
CREATE TABLE ztmpclientmigration.data_query_clauses
(
    fromclientid bigint,
    id bigint,
    dataqueryid bigint,
    dataqueryconditionid bigint,
    dataqueryoperatorid bigint,
    dataqueryclauseid bigint,
    "position" bigint,
    value text,
    conditionsettings text
);

\copy ztmpclientmigration.data_query_clauses from 'data_query_clauses.dat'

alter table public.data_query_clauses add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;

insert into public.data_query_clauses (id,dataqueryid,dataqueryconditionid,dataqueryoperatorid,dataqueryclauseid,"position",value,conditionsettings,fromid,fromclientid)
select s.id,s.dataqueryid,s.dataqueryconditionid,s.dataqueryoperatorid,s.dataqueryclauseid,s."position",s.value,s.conditionsettings,s.id,s.fromclientid from ztmpclientmigration.data_query_clauses s
left join public.data_query_clauses d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.data_query_clauses', 'id'), coalesce(max(id),0) + 1, false) FROM public.data_query_clauses;
insert into public.data_query_clauses (fromid,dataqueryid,dataqueryconditionid,dataqueryoperatorid,dataqueryclauseid,"position",value,conditionsettings,fromclientid)
select s.id,s.dataqueryid,s.dataqueryconditionid,s.dataqueryoperatorid,s.dataqueryclauseid,s."position",s.value,s.conditionsettings,s.fromclientid from ztmpclientmigration.data_query_clauses s
inner join public.data_query_clauses d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

update data_query_clauses a
set dataqueryid = z.id
from data_queries z
where a.dataqueryid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

update data_query_clauses a
set dataqueryconditionid = z.id
from data_query_conditions z
where a.dataqueryconditionid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

update data_query_clauses a
set dataqueryoperatorid = z.id
from data_query_operators z
where a.dataqueryoperatorid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

update data_query_clauses a
set dataqueryclauseid = z.id
from data_query_clauses z
where a.dataqueryclauseid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.fromclientid
and z.fromclientid in (10699,25502,28289);

select dqc.* from data_query_clauses dqc
left join custom_fields cf on dqc.conditionsettings::bigint = cf.id and cf.clientid in (10699,25502,28289)
where dqc.fromclientid in (10699,25502,28289)
and dqc.conditionsettings is not null
and cf.id is null
-- 67 rows

select dqc.* from data_query_clauses dqc
left join custom_fields cf on dqc.conditionsettings::bigint = cf.id --and cf.clientid in (10699,25502,28289)
where dqc.fromclientid in (10699,25502,28289)
and dqc.conditionsettings is not null
and cf.id is null
-- 0 row

select * from custom_fields where id in (6946095,
6946106,
6946175,
6946108)

create table backup.data_query_clauses_20191231 as
select dqc.*, newcf.id::text as newconditionsettings from data_query_clauses dqc
left join custom_fields cf on dqc.conditionsettings::bigint = cf.id and cf.clientid in (10699,25502,28289)
inner join custom_fields newcf on dqc.conditionsettings::bigint = newcf.fromid and newcf.clientid in (10699,25502,28289)
where dqc.fromclientid in (10699,25502,28289)
and dqc.conditionsettings is not null
and cf.id is null;

begin;
update data_query_clauses a
set conditionsettings = newconditionsettings
from backup.data_query_clauses_20191231 z
where a.id = z.id;
commit;

select dqc.* from data_query_clauses dqc
inner join custom_fields cf on dqc.conditionsettings::bigint = cf.id and cf.clientid in (10699,25502,28289)
left join custom_field_configurations cfc on dqc.value = cfc.valueid::text and cfc.customfieldid = cf.id and cfc.fromclientid in (10699,25502,28289)
inner join custom_field_configurations newcfc on dqc.value = newcfc.valueid::text and cfc.customfieldid = cf.id and cfc.fromclientid in (10699,25502,28289)
where dqc.fromclientid in (10699,25502,28289)
and dqc.conditionsettings is not null
and dqc.value ~ '^[0-9]+$'
and cfc.id is null
and cf.datatypeid in (3, 4, 8, 15, 17, 18, 19)
-- no need

select dqc.* from data_query_clauses dqc
left join custom_field_configurations cfc on dqc.value = cfc.valueid::text and cfc.fromclientid in (10699,25502,28289)
where dqc.fromclientid in (10699,25502,28289)
and dqc.conditionsettings is not null
and dqc.value ~ '^[0-9]+$'
and cfc.id is null

"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h qtest-production-rr.clyko8fo6dqf.us-east-1.rds.amazonaws.com -d qtestprod -U insights
\encoding UTF8
\copy (select i.clientid, t.* from incidents i inner join templates t on t.incidentid = i.id where i.clientid in (10699,25502,28289)) to 'templates.dat'


CREATE TABLE ztmpclientmigration.templates
(
    fromclientid bigint,
    id bigint,
    incidentid bigint,
    subject character varying(1024),
    template text
)

\copy ztmpclientmigration.templates from 'templates.dat'

--select subject,regexp_replace(subject,'\${field [[:digit:]]+}',concat('${field ',z.id::text,'}'))
update ztmpclientmigration.templates t
set subject = regexp_replace(t.subject,'\${field [[:digit:]]+}',concat('${field ',z.id::text,'}'))
from public.custom_fields z
where substring(t.subject,'\${field ([[:digit:]]+)}') = z.fromid::text
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.templates t
set template = regexp_replace(t.template,'\${field [[:digit:]]+}',concat('${field ',z.id::text,'}'))
from public.custom_fields z
where substring(t.template,'\${field ([[:digit:]]+)}') = z.fromid::text
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

alter table public.templates add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;

insert into public.templates (id,incidentid,subject,template,fromid,fromclientid)
select s.id,s.incidentid,s.subject,s.template,s.id,s.fromclientid from ztmpclientmigration.templates s
left join public.templates d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.templates', 'id'), coalesce(max(id),0) + 1, false) FROM public.templates;
insert into public.templates (fromid,incidentid,subject,template,fromclientid)
select s.id,s.incidentid,s.subject,s.template,s.fromclientid from ztmpclientmigration.templates s
inner join public.templates d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

update templates a
set incidentid = z.id
from incidents z
where a.incidentid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

\copy (select i.clientid, f.* from incidents i inner join incident_fields f on f.incidentid = i.id where i.clientid in (10699,25502,28289)) to 'incident_fields.dat'

CREATE TABLE ztmpclientmigration.incident_fields (
    fromclientid bigint,
	id int8 NOT NULL,
	incidentid int8 NOT NULL,
	fieldid int8 NOT NULL,
	watchedvalues varchar(500) NULL DEFAULT NULL::character varying
);

\copy ztmpclientmigration.incident_fields from 'incident_fields.dat'


alter table public.incident_fields add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;

insert into public.incident_fields (id,incidentid,fieldid,watchedvalues,fromid,fromclientid)
select s.id,s.incidentid,s.fieldid,s.watchedvalues,s.id,s.fromclientid from ztmpclientmigration.incident_fields s
left join public.incident_fields d on s.id = d.id
where d.id is null
and exists (select 1 from public.custom_fields where id = s.fieldid);
select setval(pg_get_serial_sequence('public.incident_fields', 'id'), coalesce(max(id),0) + 1, false) FROM public.incident_fields;
insert into public.incident_fields (fromid,incidentid,fieldid,watchedvalues,fromclientid)
select s.id,s.incidentid,s.fieldid,s.watchedvalues,s.fromclientid from ztmpclientmigration.incident_fields s
inner join public.incident_fields d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id)
and exists (select 1 from public.custom_fields where id = s.fieldid);

update incident_fields a
set incidentid = z.id
from incidents z
where a.incidentid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

update incident_fields a
set fieldid = z.id
from custom_fields z
where a.fieldid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);


-- test case sharings
-- test_steps_test_cases
"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h qtest-production-rr.clyko8fo6dqf.us-east-1.rds.amazonaws.com -d qtestprod -U insights
\encoding UTF8
\copy (SELECT p.clientid, t.* FROM public.test_case_sharings t inner join projects p on t.sourceprojectid = p.id where p.clientid in (10699,25502,28289)) to 'test_case_sharings.dat'
\copy (SELECT ts.clientid, t.* FROM public.test_steps_test_cases t inner join test_steps ts on t.teststepid = ts.id where ts.clientid in (10699,25502,28289)) to 'test_steps_test_cases.dat'
\copy (SELECT ts.clientid, t.* FROM public.test_steps_test_cases_aud t inner join test_steps ts on t.teststepid = ts.id where ts.clientid in (10699,25502,28289)) to 'test_steps_test_cases_aud.dat'


CREATE TABLE ztmpclientmigration.test_case_sharings (
    fromclientid bigint,
	sourceprojectid int8 NOT NULL,
	destinationprojectid int8 NOT NULL);

CREATE TABLE ztmpclientmigration.test_steps_test_cases (
    fromclientid bigint,
	teststepid int8 NOT NULL,
	testcaseid int8 NOT NULL,
	calledtestcaseid int8 NOT NULL,
	trxid int8 NULL,
	oldid int8 NULL
);

CREATE TABLE ztmpclientmigration.test_steps_test_cases_aud (
    fromclientid bigint,
	teststepid int8 NOT NULL,
	rev int8 NOT NULL,
	revtype int2 NULL,
	testcaseid int8 NOT NULL,
	calledtestcaseid int8 NOT NULL,
	clientid int8 NULL,
	projectid int8 NULL,
	userid int8 NULL,
	createddate int8 NULL,
	trxcreateduserid int8 NULL,
	trxcreateddate int8 NULL
);

\copy ztmpclientmigration.test_case_sharings from 'test_case_sharings.dat'
\copy ztmpclientmigration.test_steps_test_cases from 'test_steps_test_cases.dat'
\copy ztmpclientmigration.test_steps_test_cases_aud from 'test_steps_test_cases_aud.dat'

alter table public.test_case_sharings add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;
alter table public.test_steps_test_cases add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;
alter table public.test_steps_test_cases_aud add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;

update ztmpclientmigration.test_case_sharings t
set sourceprojectid = z.id
from public.projects z
where t.sourceprojectid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_case_sharings t
set destinationprojectid = z.id
from public.projects z
where t.destinationprojectid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases t
set teststepid = z.id
from public.test_steps z
where t.teststepid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases t
set testcaseid = z.id
from public.test_cases z
where t.testcaseid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases t
set calledtestcaseid = z.id
from public.test_cases z
where t.calledtestcaseid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases_aud t
set testcaseid = z.id
from public.test_cases z
where t.testcaseid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases_aud t
set calledtestcaseid = z.id
from public.test_cases z
where t.calledtestcaseid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases_aud t
set projectid = z.id
from public.projects z
where t.projectid = z.fromid
and z.id != z.fromid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases_aud t
set rev = z.id
from public.revision_info z
where t.rev = z.fromid
and z.id != z.fromid
and z.fromclientid in (10699,25502,28289);

update ztmpclientmigration.test_steps_test_cases_aud t
set userid = z.id
from public.users z
where t.userid = z.fromid
and z.id != z.fromid
and z.fromclientid in (10699,25502,28289);

insert into public.test_case_sharings (sourceprojectid,destinationprojectid,fromid,fromclientid)
select s.sourceprojectid,s.destinationprojectid,null,s.fromclientid from ztmpclientmigration.test_case_sharings s;

insert into public.test_steps_test_cases (teststepid,testcaseid,calledtestcaseid,fromid,fromclientid)
select s.teststepid,s.testcaseid,s.calledtestcaseid,s.teststepid,s.fromclientid from ztmpclientmigration.test_steps_test_cases s
left join public.test_steps_test_cases d
on s.teststepid = d.teststepid
where d.teststepid is null
and exists (select 1 from public.test_steps
where s.teststepid = id);

insert into public.test_steps_test_cases_aud (teststepid,rev,revtype,testcaseid,calledtestcaseid,
clientid,projectid,userid,createddate,trxcreateduserid,trxcreateddate,fromid,fromclientid)
select s.teststepid,s.rev,s.revtype,s.testcaseid,s.calledtestcaseid,
s.clientid,s.projectid,s.userid,s.createddate,s.trxcreateduserid,s.trxcreateddate,s.teststepid,s.fromclientid
from ztmpclientmigration.test_steps_test_cases_aud s;

-- recipients 
"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h qtest-production-rr.clyko8fo6dqf.us-east-1.rds.amazonaws.com -d qtestprod -U insights
\encoding UTF8
\copy (select i.clientid, r.* from incidents i inner join recipients r on r.incidentid = i.id where i.clientid in (10699,25502,28289)) to 'recipients.dat'

"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h qtest-production.cs2eia7pt6r3.eu-west-1.rds.amazonaws.com -d qtestprod -U postgres 

CREATE TABLE ztmpclientmigration.recipients (
    fromclientid int8,
	id int8,
	incidentid int8,
	recipienttypeid int8,
	settings text NULL
);

\copy ztmpclientmigration.recipients from 'recipients.dat'

alter table public.recipients add column if not exists fromid bigint null, add column if not exists fromclientid bigint null;

update ztmpclientmigration.recipients a
set incidentid = z.id
from public.incidents z
where a.incidentid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

update ztmpclientmigration.recipients a
set recipienttypeid = z.id
from public.recipient_types z
where a.recipienttypeid = z.fromid
and z.id != z.fromid
and a.fromclientid IN (10699,25502,28289)
and a.fromclientid = z.clientid
and z.clientid in (10699,25502,28289);

insert into public.recipients (id,incidentid,recipienttypeid,settings,fromid,fromclientid)
select s.id,s.incidentid,s.recipienttypeid,s.settings,s.id,s.fromclientid from ztmpclientmigration.recipients s
left join public.recipients d on s.id = d.id
where d.id is null
;
select setval(pg_get_serial_sequence('public.recipients', 'id'), coalesce(max(id),0) + 1, false) FROM public.recipients;
insert into public.recipients (fromid,incidentid,recipienttypeid,settings,fromclientid)
select s.id,s.incidentid,s.recipienttypeid,s.settings,s.fromclientid from ztmpclientmigration.recipients s
inner join public.recipients d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);