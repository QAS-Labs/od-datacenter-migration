
-- Parameter us-east-1
"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h session-production.clyko8fo6dqf.us-east-1.rds.amazonaws.com -d parameters -U root
\encoding UTF8

\copy (select * from dataset where client_id in (10699,25502,28289)) to 'dataset.dat'

\copy (select * from dataset_row where client_id in (10699,25502,28289)) to 'dataset_row.dat'

\copy (select * from parameter where client_id in (10699,25502,28289)) to 'parameter.dat'

\copy (select * from parameter_value where client_id in (10699,25502,28289)) to 'parameter_value.dat'

\copy (select * from task where client_id in (10699,25502,28289)) to 'task.dat'

\copy (select * from users where client_id in (10699,25502,28289)) to 'users.dat'

-- Parameter eu-west-1
"c:\Program Files (x86)\pgAdmin 4\v3\runtime\psql.exe" -h session-production.cs2eia7pt6r3.eu-west-1.rds.amazonaws.com -d parameters -U root
\encoding UTF8

create schema if not exists ztmpclientmigration;

CREATE TABLE ztmpclientmigration.dataset
(
    id bigint,
    name text,
    description text,
    created_date bigint,
    last_modified_date bigint,
    last_modified_user_id bigint,
    last_modified_user_name character varying(100),
    status character varying(50),
    project_ids bigint[],
    headers json,
    temp boolean,
    mongo_id character varying(50),
    client_id bigint
);

CREATE TABLE ztmpclientmigration.dataset_row
(
    id bigint,
    dataset_id bigint,
    temp boolean,
    cells json,
    mongo_id character varying(50),
    client_id bigint
);

CREATE TABLE ztmpclientmigration.parameter
(
    id bigint,
    name text,
    description text,
    created_date bigint,
    last_modified_date bigint,
    last_modified_user_id bigint,
    last_modified_user_name character varying(100),
    status character varying(50),
    project_ids bigint[],
    testcases json,
    dataset_ids bigint[],
    mongo_id character varying(50),
    client_id bigint,
    temp_mongo_ds_ids character varying(50)[]
);

CREATE TABLE ztmpclientmigration.parameter_value
(
    id bigint,
    value text,
    display_order bigint,
    parameter_id bigint,
    mongo_id character varying(50),
    client_id bigint
);

CREATE TABLE ztmpclientmigration.task
(
    id bigint,
    name character varying(255),
    status character varying(50),
    type character varying(50),
    created_date bigint,
    last_modified_date bigint,
    input text,
    output text,
    client_id bigint
);


CREATE TABLE ztmpclientmigration.users
(
    user_id bigint,
    user_name character varying(100),
    client_id bigint,
    qtest_url character varying(255),
    parameters_url character varying(255),
    settings json,
    projects json
);


\copy ztmpclientmigration.dataset from 'dataset.dat'
\copy ztmpclientmigration.dataset_row from 'dataset_row.dat'
\copy ztmpclientmigration.parameter from 'parameter.dat'
\copy ztmpclientmigration.parameter_value from 'parameter_value.dat'
\copy ztmpclientmigration.task from 'task.dat'
\copy ztmpclientmigration.users from 'users.dat'

alter table public.dataset add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;
alter table public.dataset_row add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;
alter table public.parameter add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;
alter table public.parameter_value add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;
alter table public.task add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;
alter table public.users add column if not exists fromid bigint null, add column if not exists fromclientid int8 null;


-- Manager db

\copy (SELECT fromclientid, id, fromid FROM users WHERE fromclientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_users.dat'
-- 0 rows
\copy (SELECT clientid, id, fromid FROM projects WHERE clientid in (10699,25502,28289) and fromid is not null and id != fromid) to 'newid_projects.dat'



-- Parameter
create table if not exists ztmpclientmigration.newid_projects (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_projects PRIMARY KEY (id)
);
\copy ztmpclientmigration.newid_projects from 'newid_projects.dat'

update ztmpclientmigration.dataset a
set project_ids = tmp.project_ids
from (
  select t.id, array_agg(z.id) as project_ids
  from (select id, unnest(project_ids) as project_id
    from ztmpclientmigration.dataset
    where client_id IN (10699,25502,28289)) t
  inner join ztmpclientmigration.newid_projects z on t.project_id = z.fromid
  where z.clientid IN (10699,25502,28289)
  and z.id != z.fromid
  group by t.id) tmp
where a.id = tmp.id
and a.client_id IN (10699,25502,28289);

update ztmpclientmigration.parameter a
set project_ids = tmp.project_ids
from (
  select t.id, array_agg(z.id) as project_ids
  from (select id, unnest(project_ids) as project_id
    from ztmpclientmigration.parameter
    where client_id IN (10699,25502,28289)) t
  inner join ztmpclientmigration.newid_projects z on t.project_id = z.fromid
  where z.clientid IN (10699,25502,28289)
  and z.id != z.fromid
  group by t.id) tmp
where a.id = tmp.id
and a.client_id IN (10699,25502,28289);

begin;

insert into public.dataset (id,name,description,created_date,last_modified_date,last_modified_user_id,last_modified_user_name,status,project_ids,headers,temp,mongo_id,client_id,fromid,fromclientid)
select s.id,s.name,s.description,s.created_date,s.last_modified_date,s.last_modified_user_id,s.last_modified_user_name,s.status,s.project_ids,s.headers,s.temp,s.mongo_id,s.client_id,s.id,s.client_id from ztmpclientmigration.dataset s
left join public.dataset d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.dataset', 'id'), coalesce(max(id),0) + 1, false) FROM public.dataset;
insert into public.dataset (fromid,name,description,created_date,last_modified_date,last_modified_user_id,last_modified_user_name,status,project_ids,headers,temp,mongo_id,client_id,fromclientid)
select s.id,s.name,s.description,s.created_date,s.last_modified_date,s.last_modified_user_id,s.last_modified_user_name,s.status,s.project_ids,s.headers,s.temp,s.mongo_id,s.client_id,s.client_id from ztmpclientmigration.dataset s
inner join public.dataset d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.dataset_row (id,dataset_id,temp,cells,mongo_id,client_id,fromid,fromclientid)
select s.id,s.dataset_id,s.temp,s.cells,s.mongo_id,s.client_id,s.id,s.client_id from ztmpclientmigration.dataset_row s
left join public.dataset_row d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.dataset_row', 'id'), coalesce(max(id),0) + 1, false) FROM public.dataset_row;
insert into public.dataset_row (fromid,dataset_id,temp,cells,mongo_id,client_id,fromclientid)
select s.id,s.dataset_id,s.temp,s.cells,s.mongo_id,s.client_id,s.client_id from ztmpclientmigration.dataset_row s
inner join public.dataset_row d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.parameter (id,name,description,created_date,last_modified_date,last_modified_user_id,last_modified_user_name,status,project_ids,testcases,dataset_ids,mongo_id,client_id,temp_mongo_ds_ids,fromid,fromclientid)
select s.id,s.name,s.description,s.created_date,s.last_modified_date,s.last_modified_user_id,s.last_modified_user_name,s.status,s.project_ids,s.testcases,s.dataset_ids,s.mongo_id,s.client_id,s.temp_mongo_ds_ids,s.id,s.client_id from ztmpclientmigration.parameter s
left join public.parameter d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.parameter', 'id'), coalesce(max(id),0) + 1, false) FROM public.parameter;
insert into public.parameter (fromid,name,description,created_date,last_modified_date,last_modified_user_id,last_modified_user_name,status,project_ids,testcases,dataset_ids,mongo_id,client_id,temp_mongo_ds_ids,fromclientid)
select s.id,s.name,s.description,s.created_date,s.last_modified_date,s.last_modified_user_id,s.last_modified_user_name,s.status,s.project_ids,s.testcases,s.dataset_ids,s.mongo_id,s.client_id,s.temp_mongo_ds_ids,s.client_id from ztmpclientmigration.parameter s
inner join public.parameter d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.parameter_value (id,value,display_order,parameter_id,mongo_id,client_id,fromid,fromclientid)
select s.id,s.value,s.display_order,s.parameter_id,s.mongo_id,s.client_id,s.id,s.client_id from ztmpclientmigration.parameter_value s
left join public.parameter_value d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.parameter_value', 'id'), coalesce(max(id),0) + 1, false) FROM public.parameter_value;
insert into public.parameter_value (fromid,value,display_order,parameter_id,mongo_id,client_id,fromclientid)
select s.id,s.value,s.display_order,s.parameter_id,s.mongo_id,s.client_id,s.client_id from ztmpclientmigration.parameter_value s
inner join public.parameter_value d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

insert into public.task (id,name,status,type,created_date,last_modified_date,input,output,client_id,fromid,fromclientid)
select s.id,s.name,s.status,s.type,s.created_date,s.last_modified_date,s.input,s.output,s.client_id,s.id,s.client_id from ztmpclientmigration.task s
left join public.task d on s.id = d.id
where d.id is null;
select setval(pg_get_serial_sequence('public.task', 'id'), coalesce(max(id),0) + 1, false) FROM public.task;
insert into public.task (fromid,name,status,type,created_date,last_modified_date,input,output,client_id,fromclientid)
select s.id,s.name,s.status,s.type,s.created_date,s.last_modified_date,s.input,s.output,s.client_id,s.client_id from ztmpclientmigration.task s
inner join public.task d on s.id = d.id
and (d.fromid is null or d.fromid is not null and d.fromid != d.id);

commit;

-- no changed user id

select d.projects, s.projects from ztmpclientmigration.users s
inner join public.users d on s.user_id = d.user_id and s.client_id = d.client_id;

select d.projects, s.projects from ztmpclientmigration.users s
inner join public.users d on s.user_id = d.user_id and s.client_id = d.client_id
where s.projects is not null;
-- 0 row => only insert if not exists

insert into public.users (user_id,user_name,client_id,qtest_url,parameters_url,settings,projects,fromid,fromclientid)
select s.user_id,s.user_name,s.client_id,s.qtest_url,s.parameters_url,s.settings,s.projects,s.user_id,s.client_id from ztmpclientmigration.users s
left join public.users d on s.user_id = d.user_id and s.client_id = d.client_id
where d.user_id is null;

-- update

update public.dataset_row a
set dataset_id = z.id
from public.dataset z
where z.client_id IN (10699,25502,28289)
and a.client_id IN (10699,25502,28289)
and a.client_id = z.client_id
and a.dataset_id = z.fromid
and z.id != z.fromid;

update public.parameter a
set dataset_ids = tmp.dataset_ids
from (
  select t.id, array_agg(z.id) as dataset_ids
  from (select id, unnest(dataset_ids) as dataset_id
    from public.parameter
    where client_id IN (10699,25502,28289)) t
  inner join public.dataset z on t.dataset_id = z.fromid
  where z.client_id IN (10699,25502,28289)
  and z.id != z.fromid
  group by t.id) tmp
where a.id = tmp.id
and a.client_id IN (10699,25502,28289);

update public.parameter_value a
set parameter_id = z.id
from public.parameter z
where z.client_id IN (10699,25502,28289)
and a.client_id IN (10699,25502,28289)
and a.client_id = z.client_id
and a.parameter_id = z.fromid
and z.id != z.fromid;

update users
set parameters_url = 'https://parameters-6.qtestnet.com'
where client_id in (10699,25502,28289) and parameters_url is not null and parameters_url not like 'https://parameter-6%';


-- TODO parameter.testcases

