\encoding UTF8

\set ON_ERROR_STOP on

\set clientid 10699,25502,28289

set application_name to dba;

set work_mem='1GB';

\timing on

-- VACUUM (ANALYZE, VERBOSE); -- for better execution plans



-- manual

update public.coverage a
set extsystemid = z.extsystemid
from public.ext_system z
where a.extsystemid = z.fromid
and z.extsystemid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;

/*
    type
-------------
 Defect      https://qteststaging.qtestnet.com/p/62/portal/project#tab=defects&object=17&id=907
 Requirement https://tuiuk.qtestnet.com/p/34406/portal/project#tab=requirements&object=5&id=3365803
 TestCase    https://qteststaging.qtestnet.com/p/88471/portal/project#tab=testdesign&object=1&id=25974632
 TestRun     https://qteststaging.qtestnet.com/p/88471/portal/project#tab=testexecution&object=3&id=60399135
*/



update public.coverage a
set externalurl = replace(a.externalurl,
                            concat('/portal/project#tab=requirements&object=5&id=',z.fromid),
                            concat('/portal/project#tab=requirements&object=5&id=',z.id)
)
from ztmpclientmigration.newid_requirements z
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and a.type = 'Requirement'
and a.externalurl ilike concat('%','/portal/project#tab=requirements&object=5&id=',z.fromid)
;

update public.coverage a
set externalurl = replace(a.externalurl,
                            concat('/portal/project#tab=defects&object=17&id=',z.fromid),
                            concat('/portal/project#tab=defects&object=17&id=',z.id)
)
from ztmpclientmigration.newid_defects z
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and a.type = 'Defect'
and a.externalurl ilike concat('%','/portal/project#tab=defects&object=17&id=',z.fromid)
;

update public.coverage a
set externalurl = replace(a.externalurl,
                            concat('/portal/project#tab=testdesign&object=1&id=',z.fromid),
                            concat('/portal/project#tab=testdesign&object=1&id=',z.id)
)
from ztmpclientmigration.newid_test_cases z
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and a.type = 'TestCase'
and a.externalurl ilike concat('%','/portal/project#tab=testdesign&object=1&id=',z.fromid)
;

update public.coverage a
set externalurl = replace(a.externalurl,
                            concat('/portal/project#tab=testexecution&object=3&id=',z.fromid),
                            concat('/portal/project#tab=testexecution&object=3&id=',z.id)
)
from ztmpclientmigration.newid_test_case_run z
where a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and a.type = 'TestRun'
and a.externalurl ilike concat('%','/portal/project#tab=testexecution&object=3&id=',z.fromid)
;

update public.custom_view a
set extsystemid = z.extsystemid
from public.ext_system z
where a.extsystemid = z.fromid
and z.extsystemid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;

update public.data_query a
set extsystemid = z.extsystemid
from public.ext_system z
where a.extsystemid = z.fromid
and z.extsystemid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;

update public.note a
set settingid = z.settingid
from public.setting z
where a.settingid = z.fromid
and z.settingid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;

/*
  public static final String TEST_CASE_OBJECT_TYPE_ID = "1";
  public static final String REQUIREMENT_OBJECT_TYPE_ID = "2";
  public static final String DEFECT_OBJECT_TYPE_ID = "3";
  public static final String USER_OBJECT_TYPE_ID = "4";
  public static final String CLIENT_OBJECT_TYPE_ID = "5";
  public static final String TEST_STEP_OBJECT_TYPE_ID = "6";
  public static final String BUILD_OBJECT_TYPE_ID = "7";
  public static final String RELEASE_OBJECT_TYPE_ID = "8";
  public static final String MODULE_OBJECT_TYPE_ID = "9";
  public static final String TEST_CASE_RESULT_OBJECT_TYPE_ID = "10";
  public static final String TEST_CASE_IMPORT_TYPE_ID = "11";
  public static final String TEST_SUITE_OBJECT_TYPE_ID = "12";
  public static final String EXTERNAL_DEFECT_OBJECT_TYPE_ID = "13";
  public static final String TEST_CASE_RUN_OBJECT_TYPE_ID = "14";
  public static final String DEFECT_QUERY_OBJECT_TYPE_ID = "15";
  public static final String DATA_QUERY_OBJECT_TYPE_ID = "16";
  public static final String TEST_CYCLE_OBJECT_TYPE_ID = "17";
  public static final String LICENSE_OBJECT_TYPE_ID = "18";
  public static final String REQUIREMENT_IMPORT_TYPE_ID = "19";
  public static final String TEST_STEP_RESULT_OBJECT_TYPE_ID = "20";
  public static final String DEFECT_IMPORT_TYPE_ID = "21";
  public static final String AUTOMATION_EXECUTION_OBJECT_TYPE_ID = "30";
  public static final String SSO_IDP_METADATA_FILE_OBJECT_TYPE_ID = "31";
  public static final String REPORT_OBJECT_TYPE_ID = "69";
  public static final String SITE_CLIENT_BLOB_HANDLE_OBJECT_TYPE_ID = "70";
*/
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_test_cases z
where a.objectid = z.fromid
and a.objecttypeid = 1
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_requirements z
where a.objectid = z.fromid
and a.objecttypeid = 2
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_defects z
where a.objectid = z.fromid
and a.objecttypeid = 3
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_test_steps z
where a.objectid = z.fromid
and a.objecttypeid = 6
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_builds z
where a.objectid = z.fromid
and a.objecttypeid = 7
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_releases z
where a.objectid = z.fromid
and a.objecttypeid = 8
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_test_case_results z
where a.objectid = z.fromid
and a.objecttypeid = 10
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_test_suites z
where a.objectid = z.fromid
and a.objecttypeid = 12
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;
update custom_view a
set objectid = z.id
from ztmpclientmigration.newid_data_queries z
where a.objectid = z.fromid
and a.objecttypeid = 16
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid
and z.id != z.fromid;

/*
file -> copy

update data_query a
set parentid = ; constant

update note a
set settingid = ; done

coverage.extsystemid done

custom_view.extsystemid done

custom_view.objectid => from Manager done

custom_view.gridviewfields => constant (select distinct gridviewfields from custom_view;)


data_query.extsystemid done

plugin.category constant

screen.browserurl ( https://qteststaging.qtestnet.com/p/20/portal/project#tab=testexecution&object=3&id=1123)
can capture from url => cannot fix
http://54.238.57.247:8080/secure/CreateIssue.jspa?pid=10400&issuetype=10104
http://banjiadesanmiministry.org/prayer_point/the-sound-of-the-abundance-of-rain-2/
http://bugzilla.qtestdev.com/enter_bug.cgi?product=TestProduct
http://chrome://extensions
http://demos.dojotoolkit.org/demos/themePreviewer/demo.html
http://examples.sencha.com/extjs/5.1.0/examples/kitchensink/#all

screen.timetypename ( {"name":"Setup","color":"#2C3E50","id":"15"} )

session_export.requestdata
-- can skip
{
    "sessionData": {
        "session_id": "6123",
        "title": "Session demo",
        "captured_date": "12/12/2018",
        "app_infos": [
            {
                "name": "Recorded Application 1: chrome.exe",
                "values": [
                    "Application version: 70.0",
                    "File path: C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe",
                    "File version: 70.0.3538.110",
                    "File size: 1.52MB (1589080 Bytes)",
                    "File modified date: 16/11/2018 5:43:04 AM"
                ]
            }
        ],
        "screens": [
            {
                "title": "qTest Explorer | Sessions - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/709-46f0e3de-fa28-446d-acf2-f769def99f31",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://tls12-session.qtestnet.com/6122/review",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 1</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 2</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "Extensions - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/710-053edb72-af66-4e7d-99a5-f941eaf05642",
                "width": 710,
                "height": 380.8854166666667,
                "url": "",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 3</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 4</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "Extensions - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/711-bdf582dc-b837-47a9-87d4-9dcade62f8e5",
                "width": 710,
                "height": 380.8854166666667,
                "url": "",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 5</span>",
                        "value": "<span style=\"color:#000000;\">Type here</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 6</span>",
                        "value": "<span style=\"color:#000000;\">Press Enter</span>"
                    },
                    {
                        "name": "<span style=\"color:#DC143C; font-weight: bold;\">Note</span>",
                        "value": "<span style=\"color:#000000;\">note</span>"
                    }
                ]
            },
            {
                "title": "Software Testing, Test Case Management & QA Tools Built For Agile",
                "image_key": "s3-865/000/000/000/022/712-0733a388-6a21-44a1-83fa-6f6387d376a7",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://tls12-session.qtestnet.com/88469/settings",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 7</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "Modern Software Testing Tools Purpose Built for Agile Teams",
                "image_key": "s3-865/000/000/000/022/713-0fe7bbf4-33c6-4a66-8524-ffa6142f94ee",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://www.qasymphony.com/software-testing-tools/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 8</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Contact' link</span>"
                    }
                ]
            },
            {
                "title": "Contact Us - QASymphony",
                "image_key": "s3-865/000/000/000/022/714-a905a1bc-993b-4cfa-a31d-7edbf033ba19",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://www.qasymphony.com/contact-us/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 9</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "Contact Us - QASymphony",
                "image_key": "s3-865/000/000/000/022/715-9bbcd293-f2b1-413d-a408-c706ccb9e761",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://www.qasymphony.com/contact-us/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 10</span>",
                        "value": "<span style=\"color:#000000;\">Click 'support@qasymphony.com' link</span>"
                    }
                ]
            },
            {
                "title": "Contact Us - QASymphony",
                "image_key": "s3-865/000/000/000/022/716-d21b9f10-059d-4237-83e6-09b2d3734ef1",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://www.qasymphony.com/contact-us/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 11</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Customer Success' link</span>"
                    }
                ]
            },
            {
                "title": "Customer Success is Our Highest Priority - QASymphony",
                "image_key": "s3-865/000/000/000/022/717-4bb1edc8-0dac-4795-8bf2-be7c209ee448",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://www.qasymphony.com/customers/success/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 12</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Free' link</span>"
                    }
                ]
            },
            {
                "title": "Start a Free Trial - QASymphony - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/718-fa23a0c1-d86d-47d6-90b5-c5b0a8f23f16",
                "width": 710,
                "height": 380.8854166666667,
                "url": "",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 13</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "Start a Free Trial - QASymphony - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/719-16044768-b49d-4308-842d-bf3433da4d7f",
                "width": 710,
                "height": 380.8854166666667,
                "url": "",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 14</span>",
                        "value": "<span style=\"color:#000000;\">Type here</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 15</span>",
                        "value": "<span style=\"color:#000000;\">Press Enter</span>"
                    }
                ]
            },
            {
                "title": "QASymphony Help Center - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/720-43c25f01-0485-4027-88a5-a15fc610c723",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 16</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Sign in' button</span>"
                    }
                ]
            },
            {
                "title": "Registration - QASymphony - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/721-d6da3bcf-401c-4357-9e47-5a1629e4476e",
                "width": 710,
                "height": 380.8854166666667,
                "url": "",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 17</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "QASymphony Help Center - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/722-457b64d2-5b6d-4305-bdd3-5dda8510ecd9",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 18</span>",
                        "value": "<span style=\"color:#000000;\">Type in 'Search anything, like JIRA integration or Getting Started…' edit box: 'automation host'</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 19</span>",
                        "value": "<span style=\"color:#000000;\">Press Enter</span>"
                    }
                ]
            },
            {
                "title": "Search results – QASymphony Help Center",
                "image_key": "s3-865/000/000/000/022/723-1414ac83-0e58-4174-bb2c-d429e487ee4c",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us/search?utf8=%E2%9C%93&query=automation+host",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Video</span>",
                        "value": "<span style=\"color:#000000;\">VID_20181212_155127</span>"
                    }
                ]
            },
            {
                "title": "Explorer Download Center – QASymphony Help Center",
                "image_key": "s3-865/000/000/000/022/724-124cff93-4eaf-45c7-bbd8-8794efe8720f",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us/articles/115002958126-Explorer-Download-Center",
                "steps": [
                    {
                        "name": "<span style=\"color:#DC143C; font-weight: bold;\">Note</span>",
                        "value": "<span style=\"color:#000000;\">this is a note</span>"
                    }
                ]
            },
            {
                "title": "Custom region",
                "image_key": "s3-865/000/000/000/022/725-e9ee4e34-b323-427d-b3b5-7c026698c1fe",
                "width": 710,
                "height": 316.56050955414014,
                "url": "",
                "steps": []
            },
            {
                "title": "Explorer Download Center – QASymphony Help Center",
                "image_key": "s3-865/000/000/000/022/726-d7250a9b-de08-4730-b8c9-4c86a827e95d",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us/articles/115002958126-Explorer-Download-Center",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 20</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Release Notes' link</span>"
                    }
                ]
            },
            {
                "title": "Desktop Explorer 7.1.8.1 - December 21, 2017 – QASymphony Help Center - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/727-0156c19f-46c1-41c4-b861-eaca05ec1076",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://support.qasymphony.com/hc/en-us/articles/115005837783-Desktop-Explorer-7-1-8-1-December-21-2017",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 21</span>",
                        "value": "<span style=\"color:#000000;\">Click here</span>"
                    }
                ]
            },
            {
                "title": "qTest Explorer | Sessions - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/728-4dfa7f86-80b8-4609-ae42-e69926b6f01d",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://tls12-session.qtestnet.com/6122/review",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 22</span>",
                        "value": "<span style=\"color:#000000;\">Click 'Close (cmd/ctrl+alt+c)' button</span>"
                    }
                ]
            },
            {
                "title": "qTest Explorer | Sessions - Google Chrome - Person 1",
                "image_key": "s3-865/000/000/000/022/729-bb0d892e-f6bb-4e26-8705-474cd003bce1",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://tls12-session.qtestnet.com/",
                "steps": [
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 23</span>",
                        "value": "<span style=\"color:#000000;\">Click 'SS-3' link</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 24</span>",
                        "value": "<span style=\"color:#000000;\">Click 'SS-3' link</span>"
                    },
                    {
                        "name": "<span style=\"color:#000000; font-weight: bold;\">Step 25</span>",
                        "value": "<span style=\"color:#000000;\">Click 'SS-3' link</span>"
                    }
                ]
            },
            {
                "title": "qTest Explorer | Sessions",
                "image_key": "s3-865/000/000/000/022/730-7c88d52a-6246-41e7-b395-f8a682f8a1f5",
                "width": 710,
                "height": 380.8854166666667,
                "url": "https://tls12-session.qtestnet.com/6123/review",
                "steps": []
            }
        ],
        "sys_info": {
            "name": "System Information",
            "values": [
                "Operating System: Microsoft Windows 10 Pro 64-bit, Version 10.0.17763",
                "Resolutions: 1920x1080",
                "qTest Explorer Version: 7.2.2.1",
                "IE version: 11.55.17763.0",
                "ADO version: 6.3.9600.16384",
                "CPU: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "RAM: 16244.96 MB",
                "Available RAM: 6273.46 MB"
            ]
        },
        "addition_info": "Record Time: 12/12/2018 03:48:57 PM - 12/12/2018 03:58:06 PM"
    },
    "userName": "tructran@qasymphony.com",
    "clientId": "865",
    "projectId": "88151",
    "exportType": "pdf",
    "width": 710,
    "height": 530,
    "processCount": 0
}

setting.categoryid system-defined

timeline.extrainfo

user_setting.extrainfo NOUPDATE
*/

--session_history.value NOUPDATE
/*

select distinct (json_array_elements(value::json))->>'field' from session_history where value != '';
    ?column?
------------------
 actual_duration
 assigned_user
 desc
 other_env_info
 overall_summary
 planned_duration
 status
 tags
 test_charter
 tester_name
 test_objectives
 title
(12 rows)
*/

-- extrainfo Phu will need more time to check

/* helper script for projectid
select format('update public.%s a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid);',
table_name)
from (
    select table_name from information_schema.tables t where
    table_schema='public'
    and table_type = 'BASE TABLE'
    and exists (    select 1 from information_schema.columns
                    where table_schema='public'
                    and column_name = 'projectid'
                    and table_name = t.table_name)) t
order by table_name asc;
*/
update public.application_info a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.comment a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.coverage a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.custom_view a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.data_query a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.ext_system a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.note a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.pid_increment a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.resource a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.screen a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.screen_coverage a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.session a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.session_export a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.session_history a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.setting a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.system_info a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update public.timeline a
set projectid = z.id
from ztmpclientmigration.newid_projects z
where a.projectid = z.fromid
and z.id != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;


-- generated 
/*
select format('update %s a
set %s = z.%s
from %s z
where a.%s = z.fromid
and z.%s != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid);',
tc.table_name,
kcu.column_name,
kcu.column_name,
ccu.table_name,
kcu.column_name,
kcu.column_name
)
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
where
constraint_type = 'FOREIGN KEY'
and tc.table_schema='public'
and ccu.constraint_schema='public'
and ccu.table_schema='public'
and kcu.table_schema='public'
and kcu.column_name!='clientid'
and exists (select 1 from information_schema.columns where table_schema='public' and column_name='fromid' and table_name=ccu.table_name)
;
*/

update comment a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update screen_coverage a
set coverageid = z.coverageid
from coverage z
where a.coverageid = z.fromid
and z.coverageid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update screen_coverage a
set screenid = z.screenid
from screen z
where a.screenid = z.fromid
and z.screenid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update note a
set screenid = z.screenid
from screen z
where a.screenid = z.fromid
and z.screenid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update application_info a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update coverage a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update screen a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update system_info a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update timeline a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update resource a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;
update session_history a
set sessionid = z.sessionid
from session z
where a.sessionid = z.fromid
and z.sessionid != z.fromid
and a.clientid IN (:clientid)
and a.fromclientid IN (:clientid)
and a.clientid = z.clientid;


