*** Settings ***
Library         RequestsLibrary
Resource        ../resources/variables.robot
Resource        ../resources/common_keywords.robot

*** Keywords ***
Setup
    [Arguments]    ${host}
    Set Test Variable        ${task_id}   api-1
    ${response}=       Send Authorized Request    ${task_id}    POST    ${host}/setup
    Run Keyword If    '${response}' is None    Fail    No response received
    Should Be Equal As Strings    ${response.status_code}    205
    Log    Response is OK: ${response.status_code}

Validate Status
    [Arguments]    ${host}
    Set Test Variable        ${task_id}   api-1
    ${response}=       Send Authorized Request    ${task_id}    GET    ${host}/status
    Run Keyword If    '${response}' is None    Fail    No response received
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response is OK: ${response.status_code}

*** Test Cases ***
Run Setup and Validate Status on Dev Environment
    [Documentation]   Perform API setup and validate with status request.
    [Tags]            setup    dev
    Setup             ${DEV_HOST}
    Validate Status    ${DEV_HOST}

Run Setup and Validate Status on Release Environment
    [Documentation]   Perform API setup and validate with status request.
    [Tags]            setup    release
    Setup             ${RELEASE_HOST}
    Validate Status    ${RELEASE_HOST}
