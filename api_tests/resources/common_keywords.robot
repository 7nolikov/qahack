*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${HOST}           https://default-host.com
${QA_TOKEN}       default-token
${X_TASK_ID}      default-task-id
${USER_ENDPOINT}    /users

*** Keywords ***
Send Authorized Request
    [Documentation]    Sends an HTTP request with authorization and returns the parsed JSON response.
    [Arguments]    ${method}    ${endpoint}    ${body}=${None}
    Log    \n=== Request Details ===\nMethod: ${method}\nEndpoint: ${HOST}${endpoint}\nHeaders: {"Authorization": "Bearer ${QA_TOKEN}", "X-Task-Id": "${X_TASK_ID}"}\nBody: ${body}\n
    Create Session    api-session    ${HOST}    headers={"Authorization": "Bearer ${QA_TOKEN}", "X-Task-Id": "${X_TASK_ID}"}    verify=False

    ${response}=    Run Keyword If    '${method}' == 'GET'      GET On Session    api-session    ${endpoint}
    ...    ELSE IF    '${method}' == 'POST'     POST On Session    api-session    ${endpoint}    json=${body}
    ...    ELSE IF    '${method}' == 'PATCH'    PATCH On Session    api-session    ${endpoint}    json=${body}
    ...    ELSE IF    '${method}' == 'DELETE'   DELETE On Session    api-session    ${endpoint}
    ...    ELSE                                  Fail    Unsupported HTTP method: ${method}

    Log    \n=== Response Details ===\nStatus Code: ${response.status_code}\nHeaders: ${response.headers}\nBody: ${response.text}\n
    RETURN    ${response}

Parse JSON Response
    [Documentation]    Parses the JSON content of a response and returns it as a dictionary.
    [Arguments]         ${response}
    ${content_type}=    Get From Dictionary    ${response.headers}    Content-Type
    ${parsed}=          Run Keyword If     '${content_type}' == 'application/json'   Convert To Dictionary    ${response.json()}
    ...                 ELSE    Fail    Response content is not in JSON format.
    RETURN            ${parsed}


Response Should Be OK
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response is OK: ${response.status_code}

Response Should Be Created
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    Response is Created: ${response.status_code}

Response Should Be No Content
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    204
    Log    Response is No Content: ${response.status_code}

Response Should Be Not Found
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    404
    Log    Response is Not Found: ${response.status_code}