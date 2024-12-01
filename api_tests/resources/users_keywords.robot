*** Settings ***
Resource        ../resources/variables.robot
Resource        ../resources/common_keywords.robot

*** Keywords ***
Test API-1 Delete User
    [Documentation]                  Deletes a user by ID.
    [Arguments]                      ${CURRENT_HOST}
    Set Test Variable                ${task_id}   api-1
    ${user_details}=                 Create User    ${task_id}
    ${user_id}=                      Get From Dictionary    ${user_details}    uuid
    ${response}=                     Send Authorized Request    ${task_id}    DELETE    ${CURRENT_HOST}/users/${user_id}
    Response Should Be No Content    ${response}
    Log                              User Deleted: ID=${user_id}

Test API-3 Create User
    [Documentation]    Creates a new user and verifies the response.
    [Arguments]        ${CURRENT_HOST}
    Set Test Variable  ${task_id}   api-3
    ${email}=          FakerLibrary.Email
    ${password}=       FakerLibrary.Password
    ${user_details}=   Create User    ${task_id}    ${email}    ${password}
    ${user_id}=        Get From Dictionary    ${user_details}    uuid
    Log                User Created: ID=${user_id}, Email=${email}
    [Teardown]         Delete User    ${task_id}    ${user_id}

Test API-4 Update User
    [Documentation]         Updates a user's details and verifies the response.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable       ${task_id}   api-4
    ${user_details}=        Create User    ${task_id}
    ${user_id}=             Get From Dictionary    ${user_details}    uuid
    ${updated_name}=        FakerLibrary.Name
    ${updated_nickname}=    FakerLibrary.UserName
    ${updated_details}=  Update User             ${task_id}    ${user_id}    ${updated_name}    ${updated_nickname}
    Should Be Equal      ${updated_details}[name]    ${updated_name}
    Should Be Equal      ${updated_details}[nickname]    ${updated_nickname}
    [Teardown]              Delete User    ${task_id}    ${user_id}

Test API-6 List Users
    [Documentation]         Retrieves the list of users and verifies that it is not empty.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-6
    ${user_details}=         Create User    ${task_id}
    ${users}=               List Users    ${task_id}
    Should Not Be Empty     ${users}

Test API-7 Get User by email and password
    [Documentation]         Verifies that a user can log in successfully.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-7
    ${name}=         FakerLibrary.Name
    ${email}=        FakerLibrary.Email
    ${password}=     FakerLibrary.Password
    ${nickname}=     FakerLibrary.UserName
    ${body}=    Create Dictionary    email=${email}    password=${password}    name=${name}    nickname=${nickname}
    ${response}=    Send Authorized Request   ${task_id}    POST     ${CURRENT_HOST}/users    ${body}
    Response Should Be OK   ${response}
    ${user_details}=      Parse JSON Response    ${response}
    ${user_id}=         Get From Dictionary    ${user_details}    uuid
    Log    User Created: ID=${user_id}, Email=${email}, Name=${name}
    [Teardown]         Delete User    ${task_id}    ${user_id}

Test API-21 List Users
    [Documentation]         Verifies that the list of users can be retrieved.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-21
    ${user_details}=         Create User    ${task_id}
    ${users}=               List Users    ${task_id}
    Should Not Be Empty     ${users}

Test API-22 Create User
    [Documentation]         Verifies that a user can be created successfully.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-22
    ${user_details}=         Create User    ${task_id}
    ${user_id}=              Get From Dictionary    ${user_details}    uuid
    Log                      User Created: ID=${user_id}
    [Teardown]               Delete User    ${task_id}    ${user_id}

Test API-23 Get User by ID
    [Documentation]         Verifies that user details can be retrieved by ID.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-23
    ${user_details}=         Create User    ${task_id}
    ${user_id}=              Get From Dictionary    ${user_details}    uuid
    ${user_details}=         Get User by ID    ${task_id}    ${user_id}
    ${uuid}=                 Get From Dictionary    ${user_details}    uuid
    Should Be Equal As Strings    ${uuid}    ${user_id}
    [Teardown]              Delete User    ${task_id}    ${user_id}

Test API-24 Update User
    [Documentation]         Verifies that a user's details can be updated.
    [Arguments]             ${CURRENT_HOST}
    Set Test Variable       ${host}   ${CURRENT_HOST}
    Set Test Variable        ${task_id}   api-24
    ${user_details}=         Create User    ${task_id}
    ${user_id}=              Get From Dictionary    ${user_details}    uuid
    ${updated_name}=        FakerLibrary.Name
    ${updated_nickname}=    FakerLibrary.UserName
    ${updated_details}=     Update User    ${task_id}    ${user_id}    ${updated_name}    ${updated_nickname}
    Should Be Equal         ${updated_details}[name]    ${updated_name}
    Should Be Equal         ${updated_details}[nickname]    ${updated_nickname}
    [Teardown]              Delete User    ${task_id}    ${user_id}

Create User
    [Documentation]    Creates a new user and returns the user ID.
    [Arguments]        ${task_id}   ${email_par}=${None}    ${password_par}=${None}
    ${name}=           FakerLibrary.Name
    ${nickname}=       FakerLibrary.UserName
    ${new_email}=      FakerLibrary.Email
    ${new_password}=   FakerLibrary.Password
    ${email}=           Set Variable If    '${email_par}' == '${None}'  ${new_email}  ${email_par}
    ${password}=        Set Variable If    '${password_par}' == '${None}'    ${new_password}  ${password_par}
    ${body}=           Create Dictionary    email=${email}    password=${password}    name=${name}    nickname=${nickname}
    ${response}=       Send Authorized Request    ${task_id}    POST    ${host}/users    ${body}
    Response Should Be OK    ${response}
    ${user_details}=   Parse JSON Response    ${response}
    Log                User Created: ${user_details}
    RETURN           ${user_details}

Delete User
    [Documentation]    Deletes a user by ID.
    [Arguments]        ${task_id}   ${user_id}
    ${response}=       Send Authorized Request    ${task_id}    DELETE    ${host}/users/${user_id}
    Response Should Be No Content    ${response}
    Log                User Deleted: ID=${user_id}

Update User
    [Documentation]    Updates a user's details.
    [Arguments]        ${task_id}   ${user_id}   ${name}   ${nickname}
    ${body}=           Create Dictionary    name=${name}    nickname=${nickname}
    ${response}=       Send Authorized Request    ${task_id}    PATCH    ${host}/users/${user_id}    ${body}
    Response Should Be OK    ${response}
    ${user_details}=   Parse JSON Response    ${response}
    Log                User Updated: ${user_details}
    RETURN             ${user_details}

List Users
    [Documentation]    Retrieves the list of users and returns it.
    [Arguments]        ${task_id}
    ${response}=       Send Authorized Request    ${task_id}    GET    ${host}/users
    Response Should Be OK    ${response}
    ${json_response}=          Parse JSON Response    ${response}
    ${users}=           Get From Dictionary    ${json_response}    users
    Log                Users: ${users}
    RETURN             ${users}

Get User by ID
    [Documentation]    Retrieves a user's details by ID.
    [Arguments]        ${task_id}   ${user_id}
    ${response}=       Send Authorized Request    ${task_id}    GET    ${host}/users/${user_id}
    Response Should Be OK    ${response}
    ${user_details}=   Parse JSON Response    ${response}
    Log                User Details: ${user_details}
    RETURN             ${user_details}

Delete All Users
    [Documentation]    Deletes all users.
    ${users}=    List Users    api-6
    FOR    ${user}    IN    @{users}
        ${user_id}=    Get From Dictionary    ${user}    uuid
        Delete User    api-6    ${user_id}
    END