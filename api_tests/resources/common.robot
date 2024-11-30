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

Validate Status Code
    [Arguments]    ${response}    ${expected_code}
    Log    Validating Status Code: Expected=${expected_code}, Actual=${response.status_code}
    Should Be Equal As Strings    ${response.status_code}    ${expected_code}

Create User
    [Documentation]    Create a user and return the user ID.
    ${name}=         FakerLibrary.Name
    ${email}=        FakerLibrary.Email
    ${password}=     FakerLibrary.Password
    ${nickname}=     FakerLibrary.UserName
    ${body}=    Create Dictionary    email=${email}    password=${password}    name=${name}    nickname=${nickname}
    ${response}=    Send Authorized Request    POST    ${USER_ENDPOINT}    ${body}
    Validate Status Code    ${response}    200
    ${user_id}=    Get From Dictionary    ${response.json()}    uuid
    Log    User Created: ID=${user_id}, Email=${email}, Name=${name}
    [Return]    ${user_id}

Delete User
    [Arguments]    ${user_id}
    [Documentation]    Delete a user by ID and validate the deletion.
    ${response}=    Send Authorized Request    DELETE    ${USER_ENDPOINT}/${user_id}
    Validate Status Code    ${response}    204
    Log    User Deleted: ID=${user_id}