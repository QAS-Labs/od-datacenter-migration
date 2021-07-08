\encoding UTF8

\set ON_ERROR_STOP on

\set AUTOCOMMIT on

create schema if not exists ztmpclientmigration;

-- manual

create table if not exists ztmpclientmigration.newid_projects (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_projects PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_test_cases (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_test_cases PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_requirements (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_requirements PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_defects (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_defects PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_test_steps (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_test_steps PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_builds (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_builds PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_releases (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_releases PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_test_case_results (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_test_case_results PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_test_case_run (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_test_case_run PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_test_suites (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_test_suites PRIMARY KEY (id)
);
create table if not exists ztmpclientmigration.newid_data_queries (
    clientid bigint NOT NULL,
    id bigint NOT NULL,
    fromid bigint NOT NULL,
    constraint pk_newid_data_queries PRIMARY KEY (id)
);



-- generated
/*
select format('create table if not exists ztmpclientmigration.%s as select * from public.%s with no data;',table_name,table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='public'
    and table_type = 'BASE TABLE'
    and exists (    select 1 from information_schema.columns
                    where table_schema='public'
                    and column_name = 'clientid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
create table if not exists ztmpclientmigration.application_info
(
    applicationinfoid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    filelastmodified timestamp with time zone,
    filesize character varying(255) NOT NULL,
    fileversion character varying(255) NOT NULL,
    firstactiontime timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    path character varying(1000) NOT NULL,
    version character varying(50) NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    status integer,
    clientid bigint,
    projectid bigint
);
create table if not exists ztmpclientmigration.comment
(
    commentid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    author character varying(255) NOT NULL,
    content text NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone NOT NULL,
    processeddate timestamp with time zone,
    status integer NOT NULL,
    authorid character varying(255) NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.coverage
(
    coverageid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    title character varying(1000) NOT NULL,
    type character varying(50) NOT NULL,
    externalid character varying(255) NOT NULL,
    externalurl character varying(2000),
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    publishername character varying(255) NOT NULL,
    submitteddate timestamp with time zone NOT NULL,
    status integer,
    prefix text,
    pid text,
    extsystemid bigint NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.custom_view
(
    customviewid bigint NOT NULL,
    extsystemid bigint NOT NULL,
    username character varying(255) NOT NULL,
    objectid bigint NOT NULL,
    objecttypeid integer NOT NULL,
    gridviewfields text NOT NULL,
    extrainfo text NOT NULL,
    status integer NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.data_query
(
    dataqueryid bigint NOT NULL,
    extsystemid bigint NOT NULL,
    username character varying(255) NOT NULL,
    name character varying(500) NOT NULL,
    queryclauses text,
    querytype integer NOT NULL,
    parentid character varying(50),
    extrainfo text,
    status integer,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.explorer_token
(
    explorertokenid bigint NOT NULL,
    token character varying NOT NULL,
    evaluationinfo text NOT NULL,
    createddate timestamp without time zone,
    expireddate timestamp without time zone NOT NULL,
    clientid bigint,
    userpermissioninfo text
);

create table if not exists ztmpclientmigration.ext_client
(
    sitename character varying(100),
    siteurl character varying(500),
    systemid character varying(30) NOT NULL,
    clientid bigint NOT NULL
);

create table if not exists ztmpclientmigration.ext_system
(
    extsystemid smallint NOT NULL,
    extrainfo text,
    systemid character varying(100) NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    status integer,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.note
(
    noteid bigint NOT NULL,
    screenid bigint NOT NULL,
    text text,
    icon character varying(20) NOT NULL,
    name character varying(255),
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    status integer,
    extrainfo text,
    categoryname character varying(100) NOT NULL,
    settingid bigint,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.pid_increment
(
    value bigint,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.plugin
(
    pluginid bigint NOT NULL,
    pluginname character varying(255) NOT NULL,
    description text,
    category smallint NOT NULL,
    mainfilename character varying(500),
    mainfilepath text,
    status smallint,
    pluginversion character varying(50),
    isbuiltin boolean,
    clientid bigint,
    clientsitename character varying(100),
    submitteduser character varying(500),
    createddate timestamp with time zone,
    modifieddate timestamp with time zone
);

create table if not exists ztmpclientmigration.resource
(
    resourceid bigint NOT NULL,
    sessionid bigint NOT NULL,
    name character varying(255) NOT NULL,
    resourcekey character varying(255) NOT NULL,
    mimetype character varying(100) NOT NULL,
    status integer NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.screen
(
    screenid bigint NOT NULL,
    externalscreenid character varying(255) NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    "position" bigint NOT NULL,
    capturemode character varying(50) NOT NULL,
    screenshotfilename character varying(255) NOT NULL,
    thumbnailfilename character varying(255) NOT NULL,
    "timestamp" timestamp with time zone,
    title text NOT NULL,
    browserurl text,
    imageurl text,
    thumbnailurl text,
    timetypename text,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    finishedtimestamp timestamp with time zone,
    status integer,
    clientid bigint,
    projectid bigint,
    deleted boolean
);

create table if not exists ztmpclientmigration.screen_coverage
(
    screenid bigint NOT NULL,
    coverageid bigint NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    status integer,
    extrainfo text,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.session
(
    sessionid bigint NOT NULL,
    extrainfo text,
    actualduration bigint NOT NULL,
    plannedduration bigint NOT NULL,
    otherenvironmentinfo character varying(500),
    description character varying(3000) NOT NULL,
    overallsummary character varying(1000),
    title character varying(1000) NOT NULL,
    testername character varying(500) NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    owneruser character varying(255) NOT NULL,
    edituser character varying(255),
    executor character varying(255),
    assigneduser text NOT NULL,
    systemid character varying(20) NOT NULL,
    status integer,
    type character varying(10) NOT NULL,
    pid bigint,
    tags text,
    testcharter text,
    testobjectives text,
    exportpdf integer,
    exportdoc integer,
    exportimage integer,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.session_export
(
    sessionexportid bigint NOT NULL,
    sessionid bigint,
    username character varying(255),
    resourcekey character varying(255),
    status integer,
    modifieddate timestamp with time zone,
    extrainfo text,
    requestdata text,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.session_history
(
    historyid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    type character varying(255) NOT NULL,
    value text NOT NULL,
    edituser character varying(255) NOT NULL,
    executor character varying(255) NOT NULL,
    trackeddate timestamp with time zone NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.setting
(
    settingid bigint NOT NULL,
    extsystemid bigint NOT NULL,
    extrainfo text NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    status integer NOT NULL,
    type character varying(20) NOT NULL,
    categoryid integer NOT NULL,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.system_info
(
    systeminfoid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    ado character(255) NOT NULL,
    appversion character varying(255) NOT NULL,
    availableram character varying(255) NOT NULL,
    cpu character varying(50) NOT NULL,
    ie character varying(255) NOT NULL,
    os character varying(255) NOT NULL,
    ram character varying(50) NOT NULL,
    resolutions character varying(50) NOT NULL,
    username character varying(255) NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processeddate timestamp with time zone,
    status integer,
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.timeline
(
    timelineid bigint NOT NULL,
    sessionid bigint NOT NULL,
    extrainfo text NOT NULL,
    totaltime bigint NOT NULL,
    createddate timestamp with time zone NOT NULL,
    modifieddate timestamp with time zone,
    processdate timestamp with time zone,
    status integer,
    categoryname character varying(255),
    clientid bigint,
    projectid bigint
);

create table if not exists ztmpclientmigration.user_setting
(
    usersettingid bigint NOT NULL,
    username character varying(255),
    extrainfo text,
    clientid bigint
);