\encoding UTF8

\set ON_ERROR_STOP on

create schema if not exists ztmpclientmigration;

-- Name: acl_entry; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.acl_entry (
    fromclientid bigint,
    id bigint,
    acl_object_identity bigint,
    sid bigint,
    mask bigint,
    ace_order bigint,
    granting boolean,
    audit_success boolean,
    audit_failure boolean
);


--
-- Name: acl_object_identity; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.acl_object_identity (
    fromclientid bigint,
    id bigint,
    object_id_class bigint,
    object_id_identity bigint,
    owner_sid bigint,
    parent_object bigint,
    entries_inheriting boolean,
    trxid bigint,
    oldid bigint
);


--
-- Name: acl_sid; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.acl_sid (
    fromclientid bigint,
    id bigint,
    principal boolean,
    sid character varying(100)
);


--
-- Name: app_url_config; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.app_url_config (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    app character varying(128),
    url character varying(1024)
);


--
-- Name: audit_log; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.audit_log (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    appname character varying(100),
    userid bigint,
    username character varying(80),
    eventtype integer,
    extauthusername character varying(500),
    extauthname character varying(500),
    ip character varying(40),
    agent text,
    projectid bigint,
    projectname character varying(100),
    objectid bigint,
    objecttype bigint,
    objectpid character varying(100),
    objectname text,
    filename text,
    detail text,
    audittime bigint,
    filetype character varying(200)
);


--
-- Name: automation_agents; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_agents (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    hostid bigint,
    name character varying(100),
    framework character varying(100),
    frameworkid character varying(100),
    active boolean,
    clientagentid bigint,
    configuration text
);


--
-- Name: automation_cancelled_executions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_cancelled_executions (
    fromclientid bigint,
    id bigint,
    scheduleid bigint,
    agentid bigint,
    cancelleddate bigint,
    objecttype bigint,
    objectid bigint,
    projectid bigint,
    clientid bigint
);


--
-- Name: automation_execution_results; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_execution_results (
    fromclientid bigint,
    id bigint,
    name character varying(500),
    startdate bigint,
    enddate bigint,
    status character varying(45),
    agentid bigint,
    scheduleid bigint,
    testrunids text,
    agentlogblobhandleid bigint,
    consolelogblobhandleid bigint,
    executionstartdate bigint,
    executionenddate bigint,
    projectid bigint,
    clientid bigint
);


--
-- Name: automation_hosts; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_hosts (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    hostname character varying(100),
    ipaddress character varying(45),
    macaddress character varying(45),
    status boolean,
    statusexpiredtime bigint,
    hostguid character varying(100),
    os character varying(100),
    tags text,
    pollingfrequency bigint,
    version character varying(100),
    hostconfig character varying(100),
    portconfig integer
);


--
-- Name: automation_parsers; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_parsers (
    fromclientid bigint,
    id bigint,
    name character varying(255),
    type character varying(30),
    agenttypeid character varying(30),
    version character varying(100),
    url text,
    parserblobhandleid bigint,
    filepath text,
    filename character varying(500),
    clientid bigint,
    submitteduser character varying(500),
    deleteduser character varying(500),
    createddate timestamp without time zone,
    modifieddate timestamp without time zone,
    isdeleted boolean
);


--
-- Name: automation_schedule_execution_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_schedule_execution_maps (
    fromclientid bigint,
    id bigint,
    scheduleid bigint,
    objecttype bigint,
    objectid bigint,
    deleted boolean,
    projectid bigint,
    clientid bigint
);


--
-- Name: automation_schedules; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_schedules (
    fromclientid bigint,
    id bigint,
    name character varying(500),
    creatorid bigint,
    startdate bigint,
    enddate bigint,
    repeattype character varying(45),
    repeatperiod bigint,
    agentid bigint,
    deleted boolean,
    settings json,
    projectid bigint,
    clientid bigint
);


--
-- Name: automation_status_mapping; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_status_mapping (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    automationstatus character varying(100),
    qteststatus bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: automation_upgrade_logs; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.automation_upgrade_logs (
    fromclientid bigint,
    id bigint,
    hostid bigint,
    scheduledby bigint,
    scheduledon bigint,
    updatedon bigint,
    status character varying(30),
    fromversion character varying(30),
    toversion character varying(30),
    upgradelogblobhandleid bigint,
    downloadurl text,
    clientid bigint
);


--
-- Name: blob_handles; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.blob_handles (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    objectid bigint,
    userid bigint,
    blobsize bigint,
    name text,
    minetypeid bigint,
    createddate bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: blob_handles_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.blob_handles_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    objectid bigint,
    userid bigint,
    blobsize bigint,
    name text,
    minetypeid bigint,
    createddate bigint,
    oldid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: browser_hit_track; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.browser_hit_track (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    browser character varying(100),
    version character varying(100),
    date bigint
);


--
-- Name: builds; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.builds (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    releaseid bigint,
    buildname character varying(500),
    datebk timestamp without time zone,
    date bigint,
    note text,
    buildstatusid bigint,
    deleted boolean,
    objorder bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieddate bigint,
    lastmodifieduserid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: builds_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.builds_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    buildname character varying(500),
    buildstatusid bigint,
    clientid bigint,
    datebk timestamp without time zone,
    date bigint,
    note text,
    projectid bigint,
    releaseid bigint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    deleted boolean,
    pid bigint,
    objorder bigint
);


--
-- Name: client_jira_connection; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_jira_connection (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(100),
    serverurl character varying(200),
    customfieldid character varying(200),
    customfieldname character varying(200),
    systemid bigint,
    ispolled boolean
);


--
-- Name: client_licenses; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_licenses (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    helpdeskemail character varying(100),
    helpdeskphone character varying(45),
    activationdatebk timestamp without time zone,
    activationdate bigint,
    expireddate bigint,
    explorerstartdate bigint,
    explorerenddate bigint,
    nextbillingdate bigint,
    expireddatebk timestamp without time zone,
    licensetypeid bigint,
    maxnumberofuser bigint,
    status character varying(10),
    explorerstatus character varying(10),
    explorerstartdatebk timestamp without time zone,
    explorerenddatebk timestamp without time zone,
    nextbillingdatebk timestamp without time zone,
    packagetype bigint,
    maxnumberofwritableusers bigint,
    licensetype character varying(45),
    maxnumberofsession bigint,
    usersessionquota bigint,
    qmap boolean
);


--
-- Name: client_licenses_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_licenses_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    helpdeskemail character varying(100),
    helpdeskphone character varying(45),
    activationdatebk timestamp without time zone,
    activationdate bigint,
    expireddate bigint,
    explorerstartdate bigint,
    explorerenddate bigint,
    nextbillingdate bigint,
    expireddatebk timestamp without time zone,
    licensetypeid bigint,
    maxnumberofuser bigint,
    status character varying(10),
    explorerstatus character varying(10),
    explorerstartdatebk timestamp without time zone,
    explorerenddatebk timestamp without time zone,
    nextbillingdatebk timestamp without time zone,
    packagetype bigint,
    maxnumberofwritableusers bigint,
    licensetype character varying(45),
    maxnumberofsession bigint,
    usersessionquota bigint,
    qmap boolean
);


--
-- Name: client_settings; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_settings (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(512),
    encryptedvalue text,
    value character varying(1024)
);


--
-- Name: client_user_sec_profiles; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_user_sec_profiles (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    securityprofileid bigint,
    clientuserid bigint
);


--
-- Name: client_user_settings; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_user_settings (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    clientuserid bigint,
    name character varying(245),
    value text
);


--
-- Name: client_users; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.client_users (
    fromclientid bigint,
    id bigint,
    userid bigint,
    clientid bigint,
    status smallint,
    isenteredclient boolean,
    failedlogincount smallint,
    password character varying(100),
    salt character varying(45),
    encryptedpassword boolean,
    credentialnonexpired boolean,
    activationcode character varying(512),
    createddatebk timestamp without time zone,
    createddate bigint,
    activateddate bigint,
    passwordmodifieddate bigint,
    passwordexpirationdate bigint,
    lastlogintime bigint,
    activateddatebk timestamp without time zone,
    passwordmodifieddatebk timestamp without time zone,
    isdefaultclient boolean,
    passwordexpirationdatebk timestamp without time zone,
    lastlogintimebk timestamp without time zone,
    isrootuser boolean,
    isshowtutorialprogressbar boolean,
    timezoneid smallint,
    isnotifiedtimezone boolean,
    defaultexectool character varying(60),
    passwordneedschangingdatebk timestamp without time zone,
    passwordneedschangingdate bigint,
    mappedldapid character varying(80),
    authenticatorid character varying(256),
    authtype character varying(32),
    externalauthconfigid bigint,
    isinsightssu boolean,
    tzcountryid character(2),
    lasttimesentemail bigint,
    sha3password character varying(500)
);


--
-- Name: clients; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.clients (
    fromclientid bigint,
    id bigint,
    name character varying(245),
    sitename character varying(245),
    isinactive boolean,
    maxfailedloginattempt smallint,
    passwordshelflife smallint,
    passwordhealthyperiod smallint,
    minimumuniquepasswordssequencelength smallint,
    licenseblobid bigint,
    sessiontimeoutenabled boolean,
    sessiontimeoutminute smallint,
    terminateidleenabled boolean,
    terminateidleminute bigint,
    dateformat character varying(20),
    remembermetimeoutenabled boolean,
    remembermetimeoutday smallint,
    mailrecipients text,
    trxid bigint,
    oldid bigint,
    searchstatus character varying(50),
    searchmigrationduration bigint,
    isusinges boolean,
    usecustompasswordpolicy boolean,
    minimumpasswordlength integer,
    passwordcontainscapitalletters boolean,
    passwordcontainslowercaseletters boolean,
    passwordcontainsnumericchars boolean,
    passwordcontainsspecialchars boolean,
    isusereporting boolean
);


--
-- Name: clients_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.clients_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    name character varying(245),
    sitename character varying(245),
    isinactive boolean,
    maxfailedloginattempt smallint,
    passwordshelflife smallint,
    passwordhealthyperiod smallint,
    minimumuniquepasswordssequencelength smallint,
    licenseblobid bigint,
    sessiontimeoutenabled boolean,
    sessiontimeoutminute smallint,
    terminateidleenabled boolean,
    terminateidleminute bigint,
    dateformat character varying(20),
    remembermetimeoutenabled boolean,
    remembermetimeoutday smallint,
    mailrecipients text,
    isusinges boolean,
    searchstatus character varying(50),
    searchmigrationduration bigint,
    usecustompasswordpolicy boolean,
    minimumpasswordlength integer,
    passwordcontainscapitalletters boolean,
    passwordcontainslowercaseletters boolean,
    passwordcontainsnumericchars boolean,
    passwordcontainsspecialchars boolean,
    isusereporting boolean
);

CREATE TABLE ztmpclientmigration.client_ext
(
    fromclientid bigint,
    id bigint,
    contactfirstname character varying(100),
    contactlastname character varying(100),
    contactphone character varying(25),
    contactemail character varying(100),
    contactaddress1 character varying(255),
    contactaddress2 character varying(255),
    contactcity character varying(50),
    contactzip character varying(25),
    contactstateid bigint,
    contactstateother character varying(255),
    contactcountryid bigint,
    cardtype smallint,
    cardnumber character varying(30),
    securitycode character varying(10),
    expireddatebk timestamp without time zone,
    expireddate bigint,
    registrationdate bigint,
    productiondate bigint,
    sameascontact boolean,
    billingfirstname character varying(100),
    billinglastname character varying(100),
    billingphone character varying(25),
    billingemail character varying(100),
    billingaddress1 character varying(255),
    billingaddress2 character varying(255),
    billingcity character varying(50),
    billingzip character varying(25),
    billingstateid bigint,
    billingstateother character varying(255),
    billingcountryid bigint,
    imageurl character varying(255),
    branch character varying(255),
    registrationdatebk timestamp without time zone,
    productiondatebk timestamp without time zone,
    subscriptiontype character varying(255),
    opinsighturl character varying(255),
    ispulseaccess boolean,
    insightslimitaccessprojects boolean
);

--
-- Name: combined_parameter_values; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.combined_parameter_values (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    testcaseversionid bigint,
    testrunid bigint,
    content text,
    locationid bigint,
    locationtypeid bigint
);


--
-- Name: configuration_migration_tracking; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.configuration_migration_tracking (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    webhookid character varying(500),
    uniqueid character varying(500),
    migrationtype character varying(500),
    migrated boolean
);


--
-- Name: configuration_sets; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.configuration_sets (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(255),
    trxid bigint,
    oldid bigint
);


--
-- Name: configuration_variables; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.configuration_variables (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(255),
    description text,
    trxid bigint,
    oldid bigint
);


--
-- Name: configurations; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.configurations (
    fromclientid bigint,
    id bigint,
    setid bigint,
    name character varying(255),
    "position" bigint,
    active boolean,
    trxid bigint,
    oldid bigint
);


--
-- Name: custom_field_configurations; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_configurations (
    fromclientid bigint,
    id bigint,
    customfieldid bigint,
    attribute character varying(100),
    value text,
    valueid bigint,
    sitefieldconfigurationid bigint,
    integrationcustomfieldconfigurationid bigint
);


--
-- Name: custom_field_configurations_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_configurations_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    createduserid bigint,
    createddate bigint,
    clientid bigint,
    projectid bigint,
    customfieldid bigint,
    attribute character varying(100),
    value text,
    valueid bigint,
    sitefieldconfigurationid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    integrationcustomfieldconfigurationid bigint
);


--
-- Name: custom_field_data_types; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_data_types (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    type character varying(245),
    settings text
);


--
-- Name: custom_field_template_field_mapping; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_template_field_mapping (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    templateid bigint,
    customfieldid bigint
);


--
-- Name: custom_field_templates; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_templates (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(500),
    isdefault boolean
);


--
-- Name: custom_field_validators; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_validators (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    type character varying(245),
    settings text
);


--
-- Name: custom_field_values; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_values (
    fromclientid bigint,
    id bigint,
    customfieldid bigint,
    objectid bigint,
    value text,
    constraint pk_ztmp_custom_field_values primary key(id)
);


--
-- Name: custom_field_values_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_field_values_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    customfieldid bigint,
    objectid bigint,
    value text,
    clientid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: custom_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_fields (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    datatypeid bigint,
    name character varying(100),
    displayorder bigint,
    active boolean,
    systemfield character varying(255),
    searchable boolean,
    searchkey character varying(100),
    freetextsearch boolean,
    searchindex smallint,
    sitefieldid bigint,
    defecttrackingconnectionid bigint,
    integrationdefectfieldid bigint
);


--
-- Name: custom_fields_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.custom_fields_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    createduserid bigint,
    createddate bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    datatypeid bigint,
    name character varying(100),
    displayorder bigint,
    active boolean,
    systemfield character varying(255),
    searchable boolean,
    searchkey character varying(100),
    freetextsearch boolean,
    searchindex smallint,
    sitefieldid bigint,
    defecttrackingconnectionid bigint,
    integrationdefectfieldid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);

CREATE TABLE ztmpclientmigration.custom_field_integration_values (
    fromclientid bigint,
	id bigint,
	customfieldid bigint,
	objectid bigint,
	value text
);

CREATE TABLE ztmpclientmigration.custom_field_integration_values_aud (
    fromclientid bigint,
	id bigint,
	rev bigint,
	revtype int2,
	customfieldid int8,
	objectid int8,
	value text
);

CREATE TABLE ztmpclientmigration.integration_custom_field_configurations
   (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    "values" text,
    valueid text,
    integrationcustomfieldid bigint,
    status integer
   );

   CREATE TABLE ztmpclientmigration.integration_custom_field_configurations_aud
   (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    "values" text,
    valueid text,
    integrationcustomfieldid bigint,
    status integer
   );
   CREATE TABLE ztmpclientmigration.integration_custom_field_data_types
   (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    type character varying(100),
    customtype character varying(100),
    customfielddatatypeid bigint,
    defecttrackingsystemid bigint,
    haspredefinedvalue boolean
   );
   CREATE TABLE ztmpclientmigration.integration_custom_fields
   (
      fromclientid bigint,
      id bigint,
      clientid bigint,
      projectid bigint,
      externalfieldid character varying(100),
      externalfieldkey character varying(100),
      externalfieldname character varying(300),
      integrationdatatypeid bigint,
      connectionid bigint,
      isdefect boolean,
      isrequirement boolean,
      active boolean
   );
   CREATE TABLE ztmpclientmigration.integration_custom_fields_aud
   (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    externalfieldid character varying(100),
    externalfieldkey character varying(100),
    externalfieldname character varying(300),
    integrationdatatypeid bigint,
    connectionid bigint,
    isdefect boolean,
    isrequirement boolean,
    active boolean
   );

--
-- Name: data_grid_view_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.data_grid_view_fields (
    fromclientid bigint,
    id bigint,
    viewid bigint,
    fieldid bigint,
    displayorder bigint,
    sorttype smallint,
    sortorder bigint
);


--
-- Name: data_grid_views; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.data_grid_views (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    objecttypeid bigint,
    objectid bigint
);


--
-- Name: data_queries; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.data_queries (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    name character varying(255),
    createduserid bigint,
    createddatebk timestamp without time zone,
    createddate bigint,
    type bigint,
    timezoneid smallint
);


--
-- Name: data_query_conditions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.data_query_conditions (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    type character varying(255),
    settings text
);


--
-- Name: data_query_operators; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.data_query_operators (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    type character varying(255),
    settings text
);


--
-- Name: defect_queries; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_queries (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(255),
    createduserid bigint,
    createddate timestamp without time zone,
    querytype smallint
);


--
-- Name: defect_query_clauses; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_query_clauses (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    defectqueryid bigint,
    leftgroup character varying(20),
    rightgroup character varying(20),
    field character varying(128),
    operator character varying(10),
    value character varying(255),
    clauseorder smallint,
    fieldtype smallint
);


--
-- Name: defect_tracking_connection; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_connection (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(100),
    serverurl character varying(200),
    username character varying(100),
    password character varying(100),
    encryptedpassword character varying(500),
    active boolean,
    defecttrackingsystemid bigint,
    configured boolean,
    clientjiraconnectionid bigint,
    enabled boolean,
    requirementenabled boolean,
    migrate boolean,
    usescenario boolean,
    autoretrievescenarioreq boolean,
    uniqueid character varying(255),
    weburl character varying(200),
    releaseenabled boolean,
    populateunlinkdefects boolean,
    releaseautofilter boolean
);


--
-- Name: defect_tracking_connection_test; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_connection_test (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(100),
    serverurl character varying(200),
    username character varying(100),
    password character varying(100),
    weburl character varying(200)
);


--
-- Name: defect_tracking_field; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_field (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    displayorder bigint,
    name character varying(100),
    label character varying(100),
    active boolean,
    required boolean,
    multivalue boolean,
    displaytype character varying(100),
    defaultvalue character varying(100),
    listfieldvalue text,
    listautofillfield character varying(500),
    defecttrackingtypeid bigint,
    defecttrackingprojectid bigint
);


--
-- Name: defect_tracking_project; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_project (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    defectprojectid character varying(100),
    name text,
    defecttrackingconnectionid bigint,
    populated boolean,
    active boolean
);


--
-- Name: defect_tracking_type; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_type (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(100),
    label character varying(100),
    defecttrackingconnectionid bigint,
    integrationprojectid bigint,
    pollexception bigint,
    polled boolean,
    lastsync bigint
);


--
-- Name: defect_tracking_usage; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_tracking_usage (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    usinginternalsystem boolean
);


--
-- Name: defect_workflow_transition; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_workflow_transition (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    active boolean
);


--
-- Name: defect_workflow_transition_profile; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_workflow_transition_profile (
    fromclientid bigint,
    clientid bigint,
    projectid bigint,
    transitionid bigint,
    userprofileid bigint,
    id bigint
);


--
-- Name: defect_workflow_transition_status; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defect_workflow_transition_status (
    fromclientid bigint,
    clientid bigint,
    projectid bigint,
    transitionid bigint,
    fromstatus bigint,
    tostatus bigint,
    id bigint
);


--
-- Name: defects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defects (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    assigneduserid bigint,
    createduserid bigint,
    summary character varying(512),
    description text,
    createddatebk timestamp without time zone,
    createddate bigint,
    targetdate bigint,
    closeddate bigint,
    lastmodifieddate bigint,
    targetdatebk timestamp without time zone,
    closeddatebk timestamp without time zone,
    projectmoduleid bigint,
    statusid bigint,
    typeid bigint,
    reasonid bigint,
    priorityid bigint,
    severityid bigint,
    categoryid bigint,
    rootcauseid bigint,
    affectedbuildid bigint,
    affectedreleaseid bigint,
    targetbuildid bigint,
    targetreleaseid bigint,
    fixedbuildid bigint,
    fixedreleaseid bigint,
    osid bigint,
    browserid bigint,
    serverid bigint,
    envotherid bigint,
    previousstatusid bigint,
    draft boolean,
    lastmodifieddatebk timestamp without time zone,
    lastmodifieduserid bigint,
    sourcedefectid bigint,
    modifieddate timestamp without time zone,
    indexmodifieddate timestamp without time zone,
    environmentid bigint,
    indexflag boolean,
    trxid bigint,
    oldid bigint,
    externalissueid character varying(50),
    connectionid bigint,
    externalprojectid character varying(100),
    externalissuesummary character varying(2000),
    externalissuestatus character varying(500),
    url character varying(100),
    externalissuetype character varying(50),
    externalissueuniqueid character varying(255),
    unlinkeddefect boolean
);


--
-- Name: defects_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.defects_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    summary character varying(512),
    description text,
    typeid bigint,
    assigneduserid bigint,
    statusid bigint,
    severityid bigint,
    priorityid bigint,
    osid bigint,
    browserid bigint,
    envotherid bigint,
    serverid bigint,
    affectedreleaseid bigint,
    affectedbuildid bigint,
    fixedreleaseid bigint,
    fixedbuildid bigint,
    targetreleaseid bigint,
    targetbuildid bigint,
    targetdatebk timestamp without time zone,
    targetdate bigint,
    closeddate bigint,
    closeddatebk timestamp without time zone,
    reasonid bigint,
    projectmoduleid bigint,
    categoryid bigint,
    environmentid bigint,
    trxid bigint,
    oldid bigint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    createduserid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    externalissueid character varying(50),
    connectionid bigint,
    externalprojectid character varying(100),
    externalissuesummary character varying(2000),
    externalissuestatus character varying(500),
    url character varying(100),
    externalissuetype character varying(50),
    draft boolean,
    rootcauseid bigint,
    previousstatusid bigint,
    sourcedefectid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    indexflag boolean
);


--
-- Name: external_auth_system_config; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.external_auth_system_config (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    authtype character varying(255),
    name character varying(500),
    authconfig text,
    isactivated boolean
);


--
-- Name: external_client_user; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.external_client_user (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    mapto bigint,
    externalauthsystemconfigid bigint,
    username character varying(255)
);


--
-- Name: group_authorities; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.group_authorities (
    fromclientid bigint,
    id bigint,
    groupid bigint,
    clientid bigint,
    authorityid bigint
);


--
-- Name: group_members; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.group_members (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    groupid bigint,
    clientuserid bigint
);


--
-- Name: groups; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.groups (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(100),
    readonly boolean,
    defaultgroup boolean,
    defaultgroupid bigint
);


--
-- Name: incidents; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.incidents (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    name character varying(100),
    active boolean,
    oncreation boolean,
    onapproval boolean,
    type smallint,
    isupdatedincident boolean,
    systemid bigint
);


--
-- Name: insights_client_colors; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_client_colors (
    fromclientid bigint,
    clientid bigint,
    typeid bigint,
    value text,
    color text,
    colors text[],
    projectcts bigint[]
);

CREATE TABLE ztmpclientmigration.insights_client_landing_page
(
    fromclientid bigint,
    id bigint,
    clientid bigint,
    landing_page character varying(100),
    name character varying(100)
);

CREATE TABLE ztmpclientmigration.insights_client_user_landing_page
(
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    landing_page character varying(100),
    name character varying(100)
);

--
-- Name: insights_defect_severities; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_defect_severities (
    fromclientid bigint,
    clientid bigint,
    entrynumber integer,
    fieldname character varying(200),
    projectids bigint[]
);


--
-- Name: insights_defect_severities_detail; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_defect_severities_detail (
    fromclientid bigint,
    clientid bigint,
    entrynumber integer,
    sequencenumber integer,
    severityname character varying(50),
    chartcolor character varying(10),
    severityvalues text[]
);


--
-- Name: insights_defect_statuses; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_defect_statuses (
    fromclientid bigint,
    clientid bigint,
    entrynumber integer,
    projectids bigint[]
);


--
-- Name: insights_defect_statuses_detail; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_defect_statuses_detail (
    fromclientid bigint,
    clientid bigint,
    entrynumber integer,
    sequencenumber integer,
    statusname character varying(50),
    chartcolor character varying(10),
    statusvalues text[]
);


--
-- Name: insights_jira_report_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_jira_report_fields (
    fromclientid bigint,
    clientid bigint,
    projectid bigint,
    typeid bigint,
    entrynumber bigint,
    fieldname character varying(200),
    fieldid character varying(400),
    columnheading character varying(250),
    columntype character varying(50),
    columnformat character varying(50)
);


--
-- Name: insights_portfolio_thresholds; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_portfolio_thresholds (
    fromclientid bigint,
    portfolioid bigint,
    entrynumber integer,
    clientid bigint,
    color character varying(10),
    expression text,
    sqlexpression text,
    fields character varying(60)[]
);


--
-- Name: insights_portfolio_unlinked_defect_projects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_portfolio_unlinked_defect_projects (
    fromclientid bigint,
    id bigint,
    portfoliounlinkeddefectid bigint,
    projectid bigint
);


--
-- Name: insights_portfolio_unlinked_defects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_portfolio_unlinked_defects (
    fromclientid bigint,
    id bigint,
    portfolioid bigint,
    clientid bigint,
    entrynumber integer,
    defectfieldid character varying(20)
);


--
-- Name: insights_portfolios; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_portfolios (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(200),
    objecttypeid bigint,
    sitefieldid bigint,
    datefieldid bigint,
    defaultthresholdcolor character varying(10)
);


--
-- Name: insights_rapiddashboardtasks; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_rapiddashboardtasks (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    serverurl character varying(500),
    requestparams text,
    updateinterval integer,
    isrunning boolean,
    timenextrun bigint,
    bookmarkid character varying(500),
    isgeneratedfile boolean
);


--
-- Name: insights_report_lookup_t; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_report_lookup_t (
    fromclientid bigint,
    clientid bigint,
    projectid bigint,
    customfieldid bigint,
    type character varying(30),
    id bigint,
    value character varying(400),
    color character varying(10)
);


--
-- Name: insights_report_lookup_updates; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_report_lookup_updates (
    fromclientid bigint,
    clientid bigint,
    projectid bigint,
    customfieldid bigint,
    type character varying(30),
    id bigint,
    value character varying(400),
    color character varying(10),
    updatedat bigint,
    action character varying(1)
);


--
-- Name: insights_schedule_tasks; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_schedule_tasks (
    fromclientid bigint,
    taskid bigint,
    clientid bigint,
    receivers character varying(1024),
    insightsserverurl character varying(255),
    bookmarkid character varying(50),
    bookmarkcollection character varying(50),
    isdisable boolean,
    cronexpression character varying(50),
    starttime bigint,
    endtime bigint,
    timezone character varying(50),
    scheduleinfo text,
    title character varying(255),
    scheduledescription character varying(500),
    isrunning boolean,
    taskresult text,
    timecreated bigint,
    timemodified bigint,
    timenextrun bigint,
    timelastrun bigint,
    creatorid bigint,
    updaterid bigint
);


--
-- Name: insights_token; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_token (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    token character varying(255),
    expiredate bigint,
    type smallint
);


--
-- Name: insights_user_banners; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.insights_user_banners (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    latestreleaseid bigint
);


--
-- Name: integration_defect_field_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_defect_field_maps (
    fromclientid bigint,
    id bigint,
    externalfieldid character varying(200),
    externalfieldname character varying(200),
    qtestfieldids character varying(1000),
    integrationtypemapid bigint
);


--
-- Name: integration_defect_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_defect_fields (
    fromclientid bigint,
    id bigint,
    externalfieldid character varying(200),
    externalfieldname character varying(200),
    newtypemap boolean,
    integrationtypemapid bigint
);


--
-- Name: integration_defect_issue_data; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_defect_issue_data (
    fromclientid bigint,
    id bigint,
    testcaseresultdefectid bigint,
    externalissuefieldid character(255),
    externalissuefieldvalue text,
    clientid bigint,
    projectid bigint
);


--
-- Name: integration_external_defect_issue_data; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_external_defect_issue_data (
    fromclientid bigint,
    id bigint,
    defectid bigint,
    externalissuefieldid character(255),
    externalissuefieldvalue text,
    clientid bigint,
    projectid bigint
);


--
-- Name: integration_external_issues; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_external_issues (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    connectionid bigint,
    externalissueid character varying(200),
    externalprojectid character varying(200)
);


--
-- Name: integration_external_issues_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_external_issues_maps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    fromexternalissueid bigint,
    toexternalissueid bigint,
    externallinkid character varying(300),
    referencecount bigint
);


--
-- Name: integration_identifier_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_identifier_fields (
    fromclientid bigint,
    id bigint,
    externalfieldid character varying(200),
    externalfieldname character varying(200)
);


--
-- Name: integration_issue_data; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_issue_data (
    fromclientid bigint,
    id bigint,
    externalissuefieldid character varying(200),
    externalissuefieldvalue text,
    integrationissuerequirementmapid bigint,
    customfieldintegrationvalueid bigint
);


--
-- Name: integration_issue_release_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_issue_release_maps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    releaseid bigint,
    externalissueid character varying(200),
    externalissuelink character varying(1000),
    integrationtypemapid bigint
);


--
-- Name: integration_issue_requirement_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_issue_requirement_maps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    requirementid bigint,
    externalissueid character varying(200),
    externalissuelink character varying(1000),
    integrationtypemapid bigint,
    externalissueuniqueid character varying(255)
);


--
-- Name: integration_issue_test_case_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_issue_test_case_maps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    testcaseid bigint,
    externalissueid bigint,
    externallinkid character varying(300),
    referencecount bigint
);


--
-- Name: integration_issue_test_case_run_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_issue_test_case_run_maps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    connectionid bigint,
    testrunid bigint,
    externalissueid character varying(45),
    externalprojectid character varying(255),
    linkid character varying(300)
);


--
-- Name: integration_module_fields; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_module_fields (
    fromclientid bigint,
    id bigint,
    name character varying(500),
    label character varying(500),
    fieldorder bigint,
    integrationtypemapid bigint
);


--
-- Name: integration_projects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_projects (
    fromclientid bigint,
    id bigint,
    isactive boolean,
    externalprojectid character varying(200),
    externalprojectname text,
    connectionid bigint,
    startdate bigint,
    enddate bigint
);


--
-- Name: integration_release_configuration; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_release_configuration (
    fromclientid bigint,
    id bigint,
    "values" character varying(200),
    integrationtypemapid bigint,
    mappedtype integer,
    autopopulate boolean,
    externalfieldid character varying(200)
);


--
-- Name: integration_release_data; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_release_data (
    fromclientid bigint,
    id bigint,
    externalissuefieldid character varying(200),
    externalissuefieldvalue text,
    integrationissuereleasemapid bigint
);


--
-- Name: integration_requirement_field_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_requirement_field_maps (
    fromclientid bigint,
    id bigint,
    qtestfieldname character varying(200),
    externalfieldid character varying(200),
    active boolean,
    integrationtypemapid bigint,
    fixed boolean
);


--
-- Name: integration_sync_requirement_tracker; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_sync_requirement_tracker (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    parentmoduleid bigint,
    requirementid bigint,
    moduleid bigint,
    originalname character varying(255),
    modulelevel bigint,
    createddate bigint
);


--
-- Name: integration_type_maps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_type_maps (
    fromclientid bigint,
    id bigint,
    externaltypeid character varying(200),
    externaltypename character varying(200),
    qtesttypeid bigint,
    integrationprojectid bigint,
    externalfilterid character varying(4000),
    lastsyncbk timestamp without time zone,
    lastsync bigint,
    pollexception bigint,
    includechildprojects boolean,
    polled boolean
);


--
-- Name: integration_webhooks; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.integration_webhooks (
    fromclientid bigint,
    id bigint,
    webhookid character varying(500),
    clientid bigint,
    projectid bigint
);


--
-- Name: launch_user_setting; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.launch_user_setting (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(255),
    extrainfo text
);


--
-- Name: ldap_configuration; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.ldap_configuration (
    fromclientid bigint,
    clientid bigint,
    url character varying(500),
    base character varying(500),
    basesearch character varying(500),
    userobjectclass character varying(500),
    userdn character varying(500),
    password character varying(500),
    mappedusername character varying(50),
    mappedfirstname character varying(50),
    mappedlastname character varying(50),
    mappedemail character varying(50),
    connected boolean
);


--
-- Name: license_blob_handles; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.license_blob_handles (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    blobsize bigint,
    name character varying(255)
);


--
-- Name: lookup; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.lookup (
    fromclientid bigint,
    id bigint,
    lookupvalue character varying(100),
    lookuptypeid bigint,
    clientid bigint,
    projectid bigint,
    systemvalue boolean,
    "position" bigint
);


--
-- Name: lookup_types; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.lookup_types (
    fromclientid bigint,
    id bigint,
    name character varying(100),
    clientid bigint,
    projectid bigint,
    systemtype boolean,
    "position" bigint
);


--
-- Name: newid_session; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.newid_session (
    fromclientid bigint,
    sessionid bigint NOT NULL,
    fromid bigint NOT NULL
);


--
-- Name: oauth_authentications; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.oauth_authentications (
    fromclientid bigint,
    id character(32),
    authentication bytea,
    scopes character varying(100),
    appname character varying(45),
    clientid bigint,
    userid bigint
);


--
-- Name: object_assignments; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_assignments (
    fromclientid bigint,
    id bigint,
    objectid bigint,
    userid bigint,
    targetdatebk timestamp without time zone,
    targetdate bigint,
    completedate bigint,
    completedatebk timestamp without time zone,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    assignmenttype smallint,
    priorityid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: object_assignments_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_assignments_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    objectid bigint,
    userid bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    assignmenttype smallint,
    trxid bigint,
    oldid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    targetdate bigint,
    completedate bigint,
    priorityid bigint
);


--
-- Name: object_comments; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_comments (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objectid bigint,
    objecttypeid bigint,
    userid bigint,
    objectcomment text,
    commentdatebk timestamp without time zone,
    commentdate bigint,
    editdate bigint,
    editdatebk timestamp without time zone,
    trxid bigint,
    oldid bigint
);


--
-- Name: object_comments_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_comments_aud (
    fromclientid bigint,
    objecttypeid character varying(31),
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    commentdatebk timestamp without time zone,
    commentdate bigint,
    objectcomment text,
    objectid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    editdate bigint
);


--
-- Name: object_links; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_links (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    atypeid bigint,
    aid bigint,
    btypeid bigint,
    bid bigint
);


--
-- Name: object_subscribers; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_subscribers (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objecttypeid bigint,
    objectid bigint,
    userid bigint
);


--
-- Name: object_tags; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.object_tags (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objectid bigint,
    objecttypeid bigint,
    tag character varying(128)
);


--
-- Name: pid_increment; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.pid_increment (
    fromclientid bigint,
    id bigint,
    projectid bigint,
    objecttypeid bigint,
    increment bigint
);


--
-- Name: project_default_permissions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.project_default_permissions (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectsecurityprofileid bigint,
    defaultpermissionid bigint
);


--
-- Name: project_key_values; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.project_key_values (
    fromclientid bigint,
    id bigint,
    name character varying(245),
    value text,
    clientid bigint,
    projectid bigint
);


--
-- Name: project_modules; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.project_modules (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    parentmoduleid bigint,
    name character varying(500),
    isontestplan boolean,
    moduletype smallint,
    description text,
    deleted boolean,
    objorder bigint,
    shared boolean,
    createddate bigint,
    creatorid bigint,
    lastmodifieddate bigint,
    lastmodifieduserid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: project_modules_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.project_modules_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    deleted boolean,
    description text,
    moduletype smallint,
    name character varying(500),
    parentmoduleid bigint,
    shared boolean,
    projectid bigint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint
);


--
-- Name: project_settings; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.project_settings (
    fromclientid bigint,
    id bigint,
    name character varying(245),
    value character varying(5000),
    clientid bigint,
    projectid bigint
);


--
-- Name: projects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.projects (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(100),
    startdatebk timestamp without time zone,
    enddatebk timestamp without time zone,
    startdate bigint,
    enddate bigint,
    description text,
    projectstatusid bigint,
    issampleproject boolean,
    ispatchedincidents boolean,
    automation boolean,
    clonestatus smallint,
    patchincidentstatus bigint,
    trxid bigint,
    oldid bigint,
    defectworkflow boolean,
    customfieldtemplateid bigint,
    internally boolean,
    sourceprojectid bigint,
    indexingstatus boolean
);


--
-- Name: projects_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.projects_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    name character varying(500),
    description text,
    projectstatusid bigint,
    issampleproject boolean,
    ispatchedincidents boolean,
    patchincidentstatus smallint,
    automation boolean,
    defectworkflow boolean,
    sourceprojectid bigint,
    clonestatus smallint,
    customfieldtemplateid bigint,
    internally boolean,
    trxcreateduserid bigint,
    startdate bigint,
    enddate bigint,
    trxid bigint,
    trxcreateddate bigint
);


--
-- Name: queue_event; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.queue_event (
    fromclientid bigint,
    id bigint,
    clazz character varying(1000),
    data text,
    exception text,
    begintimestamp bigint,
    endtimestamp bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    inprogress boolean
);


--
-- Name: queue_processing_state; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.queue_processing_state (
    fromclientid bigint,
    id bigint,
    createdon bigint,
    type character varying(50),
    state character varying(50),
    contenttype character varying(50),
    clientid bigint,
    createdby bigint,
    content text
);


--
-- Name: recipient_types; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.recipient_types (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    type character varying(255),
    settings text
);


--
-- Name: recycle_actions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.recycle_actions (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    objectid bigint,
    objecttypeid bigint,
    deletedby bigint,
    deleteddatebk timestamp without time zone,
    deleteddate bigint,
    deleted boolean
);


--
-- Name: recycle_related_actions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.recycle_related_actions (
    fromclientid bigint,
    id bigint,
    parentactionid bigint,
    objectid bigint,
    objecttypeid bigint,
    deleted boolean
);


--
-- Name: releases; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.releases (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    releasename character varying(500),
    releasedescription text,
    startdatebk timestamp without time zone,
    enddatebk timestamp without time zone,
    startdate bigint,
    enddate bigint,
    releasestatusid bigint,
    note text,
    deleted boolean,
    modifieduserid bigint,
    modifieddate timestamp without time zone,
    objorder bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieddate bigint,
    lastmodifieduserid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: releases_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.releases_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    enddatebk timestamp without time zone,
    startdate bigint,
    enddate bigint,
    modifieddate bigint,
    modifieddatebk timestamp without time zone,
    modifieduserid bigint,
    note text,
    projectid bigint,
    releasedescription text,
    releasename character varying(500),
    releasestatusid bigint,
    startdatebk timestamp without time zone,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    deleted boolean,
    pid bigint,
    objorder bigint
);


--
-- Name: report_settings; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.report_settings (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    reportid bigint,
    groupid bigint,
    userid bigint,
    name character varying(255),
    data text,
    createddate bigint,
    updateddate bigint
);


--
-- Name: reports; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.reports (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    reporttypeid bigint,
    name character varying(100),
    description character varying(255),
    forinternaldefectonly boolean,
    fortimetracking boolean
);


--
-- Name: request_execution_time; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.request_execution_time (
    fromclientid bigint,
    id bigint,
    starttime bigint,
    endtime bigint,
    executiontime bigint,
    handlerclass character varying(255),
    handlermethod character varying(255),
    requestmethod character varying(10),
    requesturl character varying(5000),
    responsestatus integer,
    clientid bigint,
    userid bigint,
    projectid bigint,
    pattern character varying(255),
    numberofqueries integer
);


--
-- Name: requirement_link_data; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.requirement_link_data (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    releaseid bigint,
    requirementid bigint,
    buildid bigint
);


--
-- Name: requirement_link_data_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.requirement_link_data_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    releaseid bigint,
    requirementid bigint,
    buildid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: requirement_test_cases; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.requirement_test_cases (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    testcaseid bigint,
    requirementid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: requirements; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.requirements (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    name character varying(500),
    requirement text,
    projectmoduleid bigint,
    requirementtypeid bigint,
    releaseid bigint,
    buildid bigint,
    isontestplan boolean,
    requirementpriorityid bigint,
    statusid bigint,
    deleted boolean,
    objorder bigint,
    lastmodifieddatebk timestamp without time zone,
    lastmodifieddate bigint,
    createddate bigint,
    lastmodifieduserid bigint,
    indexmodifieddate timestamp without time zone,
    createddatebk timestamp without time zone,
    creatorid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: requirements_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.requirements_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    name character varying(500),
    requirementtypeid bigint,
    requirementpriorityid bigint,
    statusid bigint,
    requirement text,
    releaseid bigint,
    buildid bigint,
    trxid bigint,
    oldid bigint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint,
    projectmoduleid bigint,
    deleted boolean
);


--
-- Name: revision_aware; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.revision_aware (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    objecttypeid bigint,
    objectid bigint,
    revid bigint
);


--
-- Name: revision_info; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.revision_info (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    "timestamp" bigint,
    userid bigint,
    trxid bigint,
    oldid bigint,
    executionid character varying(32)
);


--
-- Name: scenario_status_mapping; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.scenario_status_mapping (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    scenariostatus character varying(100),
    qteststatus bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: security_profiles; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.security_profiles (
    fromclientid bigint,
    id bigint,
    name character varying(100),
    readonly boolean,
    defaultgroupid bigint,
    clientid bigint
);


--
-- Name: sso_idp_metadata_file; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.sso_idp_metadata_file (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    name character varying(255)
);


--
-- Name: task_execution_time; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.task_execution_time (
    fromclientid bigint,
    id bigint,
    starttime bigint,
    endtime bigint,
    executiontime bigint,
    taskname character varying(255),
    clientid bigint,
    userid bigint,
    projectid bigint
);


--
-- Name: test_beds; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_beds (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(210),
    deleted boolean,
    trxid bigint,
    oldid bigint
);


--
-- Name: test_case_agents; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_agents (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    agentid bigint,
    testcaseid bigint
);


--
-- Name: test_case_result_defects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_result_defects (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    resultid bigint,
    defectid bigint,
    externalissueid character varying(50),
    externalissuesummary character varying(2000),
    externalissueurl character varying(2000),
    externalissuestatus character varying(500),
    integrationconnectionid bigint,
    externalprojectid character varying(100),
    resulttype bigint,
    externalissueresolution character varying(500),
    externalissuetype character varying(500),
    trxid bigint,
    oldid bigint,
    externalissueuniqueid character varying(500),
    testcaseid bigint,
    testcaserunid bigint,
    testcaseversionid bigint
);


--
-- Name: test_case_results; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_results (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    testcaseversionid bigint,
    testcaserunid bigint,
    testexecutionresultid bigint,
    executiontypeid bigint,
    buildid bigint,
    releaseid bigint,
    executionstartdatebk timestamp without time zone,
    executionenddatebk timestamp without time zone,
    resultnumber bigint,
    plannedstartdatebk timestamp without time zone,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    executionstartdate bigint,
    executionenddate bigint,
    testdatasetid bigint,
    assigneduserid bigint,
    customfieldvalues text,
    configurationid bigint,
    plannedexecutiontime bigint,
    actualexecutiontime bigint,
    buildnumber character varying(50),
    buildurl character varying(255),
    cisystemtype bigint,
    trxid bigint,
    oldid bigint,
    automation boolean,
    testcaseid bigint,
    edited boolean,
    submittedby character varying(20)
);


--
-- Name: test_case_results_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_results_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    buildid bigint,
    clientid bigint,
    executionenddatebk timestamp without time zone,
    executionstartdatebk timestamp without time zone,
    executiontypeid bigint,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    executionstartdate bigint,
    executionenddate bigint,
    plannedstartdatebk timestamp without time zone,
    releaseid bigint,
    resultnumber bigint,
    testcaserunid bigint,
    testcaseversionid bigint,
    testdatasetid bigint,
    userid bigint,
    projectid bigint,
    createddate bigint,
    testcaseid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    customfieldvalues text,
    configurationid bigint,
    plannedexecutiontime bigint,
    actualexecutiontime bigint,
    buildnumber text,
    buildurl text,
    cisystemtype bigint,
    automation boolean,
    assigneduserid bigint,
    testexecutionresultid bigint,
    edited boolean,
    submittedby character varying(20)
);


--
-- Name: test_case_run; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_run (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    releaseid bigint,
    testcycleid bigint,
    testsuiteid bigint,
    testcaseid bigint,
    testcaseversionid bigint,
    buildid bigint,
    userid bigint,
    testbedid bigint,
    projecttesttypeid bigint,
    name text,
    plannedstartdatebk timestamp without time zone,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    runorder bigint,
    deleted boolean,
    latesttestcaseresultid bigint,
    objorder bigint,
    lastmodifieddatebk timestamp without time zone,
    lastmodifieddate bigint,
    createddate bigint,
    lastmodifieduserid bigint,
    indexmodifieddate timestamp without time zone,
    createddatebk timestamp without time zone,
    creatorid bigint,
    configurationid bigint,
    priorityid bigint,
    plannedexecutiontime bigint,
    buildnumber character varying(50),
    buildurl character varying(255),
    cisystemtype bigint,
    trxid bigint,
    oldid bigint,
    latesttestexecutionresultid bigint,
    veraapprovalstatusid bigint,
    verasignatures text,
    verapendingtasks text,
    locked boolean,
    veraid character varying(500)
);


--
-- Name: test_case_run_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_run_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    name text,
    userid bigint,
    testcaseversionid bigint,
    plannedstartdatebk timestamp without time zone,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    testbedid bigint,
    runorder bigint,
    testsuiteid bigint,
    projecttesttypeid bigint,
    latesttestcaseresultid bigint,
    deleted boolean,
    releaseid bigint,
    buildid bigint,
    configurationid bigint,
    priorityid bigint,
    plannedexecutiontime bigint,
    buildnumber character varying(50),
    buildurl character varying(255),
    cisystemtype bigint,
    trxid bigint,
    oldid bigint,
    createddate bigint,
    testcycleid bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint,
    testcaseid bigint,
    latesttestexecutionresultid bigint,
    veraapprovalstatusid bigint,
    verasignatures text,
    verapendingtasks text,
    locked boolean,
    veraid character varying(500)
);


--
-- Name: test_case_versions; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_versions (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    testcaseid bigint,
    testcaseversionstatusid bigint,
    baselinenumber bigint,
    increasenumber bigint,
    description text,
    precondition text,
    deleted boolean,
    version bigint,
    modifieduserid bigint,
    modifieddate timestamp without time zone,
    trxid bigint,
    oldid bigint
);


--
-- Name: test_case_versions_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_case_versions_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    testcaseid bigint,
    baselinenumber bigint,
    increasenumber bigint,
    testcaseversionstatusid bigint,
    description text,
    precondition text,
    trxid bigint,
    oldid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    deleted boolean,
    version integer
);


--
-- Name: test_cases; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_cases (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    projectmoduleid bigint,
    name text,
    testcasetypeid bigint,
    deleted boolean,
    latesttestcaseversionid bigint,
    objorder bigint,
    lastmodifieddatebk timestamp without time zone,
    lastmodifieddate bigint,
    createddate bigint,
    lastmodifieduserid bigint,
    indexmodifieddatebk timestamp without time zone,
    indexmodifieddate bigint,
    createddatebk timestamp without time zone,
    creatorid bigint,
    automationid bigint,
    classid text,
    classidhashcode character varying(100),
    shared boolean,
    priorityid bigint,
    trxid bigint,
    oldid bigint,
    latestrunresultid bigint
);


--
-- Name: test_cases_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_cases_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    name text,
    testcasetypeid bigint,
    classid text,
    automationid bigint,
    shared boolean,
    priorityid bigint,
    trxid bigint,
    oldid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint,
    deleted boolean,
    latesttestcaseversionid bigint,
    projectmoduleid bigint,
    classidhashcode text
);


--
-- Name: test_cycles; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_cycles (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    buildid bigint,
    releaseid bigint,
    parenttestcycleid bigint,
    startdatebk timestamp without time zone,
    enddatebk timestamp without time zone,
    startdate bigint,
    enddate bigint,
    name character varying(500),
    description text,
    testcycletype smallint,
    deleted boolean,
    objorder bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieddate bigint,
    lastmodifieduserid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: test_cycles_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_cycles_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    buildid bigint,
    clientid bigint,
    deleted boolean,
    description text,
    enddatebk timestamp without time zone,
    startdate bigint,
    enddate bigint,
    name character varying(500),
    projectid bigint,
    releaseid bigint,
    parenttestcycleid bigint,
    startdatebk timestamp without time zone,
    testcycletype smallint,
    userid bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint
);


--
-- Name: test_data_sets; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_data_sets (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    name character varying(100),
    isontestplan boolean,
    description character varying(500),
    trxid bigint,
    oldid bigint
);


--
-- Name: test_parameters; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_parameters (
    fromclientid bigint,
    id character varying(25),
    name character varying(512),
    active boolean,
    deleted boolean,
    clientid bigint,
    projectid bigint
);


--
-- Name: test_step_parameter_values; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_parameter_values (
    fromclientid bigint,
    id bigint,
    teststepparameterid bigint,
    testrunid bigint,
    parametervaluecontent text,
    parametervalueid character varying(25),
    clientid bigint,
    projectid bigint
);


--
-- Name: test_step_parameters; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_parameters (
    fromclientid bigint,
    id bigint,
    teststepid bigint,
    parameterid character varying(25),
    startindex bigint,
    endindex bigint,
    startwithoutprefixindex bigint,
    endwithoutsuffixindex bigint,
    clientid bigint,
    projectid bigint
);


--
-- Name: test_step_parameters_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_parameters_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype bigint,
    clientid bigint,
    teststepid bigint,
    parameterid character varying(25),
    startindex bigint,
    endindex bigint,
    startwithoutprefixindex bigint,
    endwithoutsuffixindex bigint,
    trxid bigint,
    oldid bigint,
    projectid bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: test_step_result_defects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_result_defects (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    teststepresultid bigint,
    defectid bigint,
    externaldefectid character varying(50),
    defecttrackingconnectionid bigint,
    defectprojectid character varying(100)
);


--
-- Name: test_step_results; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_results (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    testcaseresultid bigint,
    teststepid bigint,
    testexecutionresultid bigint,
    userid bigint,
    datebk timestamp without time zone,
    date bigint,
    actualresult text,
    resultorder bigint,
    calledtestcaseid bigint,
    calledtestcasename character varying(500),
    trxid bigint,
    oldid bigint,
    testcaseid bigint,
    testcaserunid bigint,
    testcaseversionid bigint,
    actualresultmigrated boolean,
    constraint pk_ztmp_test_step_results primary key(id)
);


--
-- Name: test_step_results_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_step_results_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype integer,
    clientid bigint,
    teststepid bigint,
    testcaseresultid bigint,
    testexecutionresultid bigint,
    userid bigint,
    actualresult text,
    resultorder integer,
    date bigint,
    testcaseversionid bigint,
    calledtestcaseid bigint,
    calledtestcasename character varying(500),
    testcaseid bigint,
    testcaserunid bigint
);


--
-- Name: test_steps; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_steps (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    testcaseversionid bigint,
    description text,
    expectedresult text,
    steporder bigint,
    runtestcaseversionid bigint,
    trxid bigint,
    oldid bigint,
    descriptionmigrated boolean,
    expectedresultmigrated boolean,
    constraint pk_ztmp_test_steps primary key(id)
);


--
-- Name: test_steps_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_steps_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    description text,
    expectedresult text,
    steporder bigint,
    testcaseversionid bigint,
    runtestcaseversionid bigint,
    trxid bigint,
    oldid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: test_steps_test_cases_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_steps_test_cases_aud (
    fromclientid bigint,
    teststepid bigint,
    rev bigint,
    revtype smallint,
    testcaseid bigint,
    calledtestcaseid bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    createddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint
);


--
-- Name: test_suites; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_suites (
    fromclientid bigint,
    id bigint,
    pid bigint,
    clientid bigint,
    projectid bigint,
    testcycleid bigint,
    testdatasetid bigint,
    projecttesttypeid bigint,
    releaseid bigint,
    buildid bigint,
    userid bigint,
    name character varying(500),
    description text,
    plannedstartdatebk timestamp without time zone,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    deleted boolean,
    testbedid bigint,
    modifieduserid bigint,
    modifieddate timestamp without time zone,
    objorder bigint,
    createddate bigint,
    creatorid bigint,
    lastmodifieddate bigint,
    lastmodifieduserid bigint,
    trxid bigint,
    oldid bigint
);


--
-- Name: test_suites_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.test_suites_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientid bigint,
    projectid bigint,
    name character varying(500),
    testdatasetid bigint,
    userid bigint,
    projecttesttypeid bigint,
    plannedstartdatebk timestamp without time zone,
    plannedenddatebk timestamp without time zone,
    plannedstartdate bigint,
    plannedenddate bigint,
    description text,
    releaseid bigint,
    buildid bigint,
    testbedid bigint,
    trxid bigint,
    oldid bigint,
    createddate bigint,
    testcycleid bigint,
    deleted boolean,
    creatorid bigint,
    lastmodifieduserid bigint,
    lastmodifieddate bigint,
    trxcreateduserid bigint,
    trxcreateddate bigint,
    pid bigint,
    objorder bigint
);


--
-- Name: tutorial_task_users; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.tutorial_task_users (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    userid bigint,
    taskid bigint,
    status bigint,
    numberofdonesubtask bigint
);


--
-- Name: user_criteria; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_criteria (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    createdby bigint,
    location character varying(50),
    strcriteria text
);


--
-- Name: user_ext; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_ext (
    fromclientid bigint,
    id bigint,
    firstname character varying(100),
    lastname character varying(100),
    contactemail character varying(100),
    imageurl character varying(245),
    latestannouncementid bigint,
    isnotloggedin boolean
);


--
-- Name: user_group_authorities; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_group_authorities (
    fromclientid bigint,
    id bigint,
    usergroupid bigint,
    authorityid bigint,
    clientid bigint
);


--
-- Name: user_group_authorities_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_group_authorities_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    usergroupid bigint,
    authorityid bigint,
    clientid bigint
);


--
-- Name: user_group_members; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_group_members (
    fromclientid bigint,
    id bigint,
    clientuserid bigint,
    usergroupid bigint,
    clientid bigint
);


--
-- Name: user_group_members_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_group_members_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    clientuserid bigint,
    usergroupid bigint,
    clientid bigint
);


--
-- Name: user_groups; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_groups (
    fromclientid bigint,
    id bigint,
    name character varying(500),
    description text,
    issystem boolean,
    isdefault boolean,
    clientid bigint
);


--
-- Name: user_groups_aud; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_groups_aud (
    fromclientid bigint,
    id bigint,
    rev bigint,
    revtype smallint,
    name character varying(500),
    description text,
    issystem boolean,
    isdefault boolean,
    clientid bigint
);


--
-- Name: user_projects; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_projects (
    fromclientid bigint,
    id bigint,
    userid bigint,
    clientid bigint,
    projectid bigint,
    isfavorite boolean
);


--
-- Name: user_unique_id; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.user_unique_id (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    userid bigint,
    tree character varying(20),
    objecttype bigint
);


--
-- Name: users; Type: TABLE; Schema: ztmpclientmigration; Owner: -
--

CREATE TABLE ztmpclientmigration.users (
    fromclientid bigint,
    id bigint,
    username character varying(80),
    issampleuser boolean,
    mappedldapid character varying(80)
);




CREATE TABLE ztmpclientmigration.null_revision_info (
    fromclientid bigint,
    id bigint,
    clientid bigint,
    projectid bigint,
    "timestamp" bigint,
    userid bigint,
    trxid bigint,
    oldid bigint,
    executionid character varying(32)
);