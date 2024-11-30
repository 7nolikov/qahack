*** Settings ***
Resource        ../resources/common_keywords.robot
Resource        ../resources/variables.robot
Library    RequestsLibrary
Library    FakerLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
Create User
    ${name}=         FakerLibrary.Name
    ${email}=        FakerLibrary.Email
    ${password}=     FakerLibrary.Password
    ${nickname}=     FakerLibrary.UserName
    ${body}=    Create Dictionary    email=${email}    password=${password}    name=${name}    nickname=${nickname}
    ${response}=    Send Authorized Request    POST     ${USER_ENDPOINT}    ${body}
    Response Should Be OK   ${response}
    ${user_details}=      Parse JSON Response    ${response}
    ${user_id}=         Get From Dictionary    ${user_details}    uuid
    Log    User Created: ID=${user_id}, Email=${email}, Name=${name}
    RETURN    ${user_id}

List Users
    [Documentation]    Retrieves the list of all users.
    ${response}=        Send Authorized Request    GET    ${USER_ENDPOINT}
    Response Should Be OK    ${response}
    Log                   Users: ${response.json()}
    ${users}=    Get From Dictionary    ${response.json()}    users
    RETURN              @{users}

Get User by ID
    [Documentation]    Retrieves user details by user ID.
    [Arguments]         ${user_id}
    ${response}=        Send Authorized Request    GET    ${USER_ENDPOINT}/${user_id}
    Response Should Be OK    ${response}
    Log                     User Details: ${response.json()}
    ${user_details}=    Parse JSON Response    ${response}
    RETURN              ${user_details}

Delete User
    [Documentation]    Deletes a user by user ID.
    [Arguments]         ${user_id}
    ${response}=        Send Authorized Request    DELETE    ${USER_ENDPOINT}/${user_id}
    Response Should Be No Content    ${response}
    Log                           User Deleted: ID=${user_id}

Login User
    [Documentation]    Logs in a user with provided credentials.
    [Arguments]         ${email}    ${password}
    ${body}=            Create Dictionary    email=${email}    password=${password}
    ${response}=        Send Authorized Request    POST    ${USER_LOGIN_ENDPOINT}    ${body}
    Response Should Be OK    ${response}
    Log                     Login Successful: ${response.json()}
    ${user_details}=    Parse JSON Response    ${response}
    RETURN              ${user_details}

Update User
    [Documentation]    Updates a user's details.
    [Arguments]         ${user_id}    ${name}    ${nickname}
    ${body}=            Create Dictionary    name=${name}    nickname=${nickname}
    ${response}=        Send Authorized Request    PATCH    ${USER_ENDPOINT}/${user_id}    ${body}
    Response Should Be OK    ${response}
    Log                     Updated User Details: ${response.json()}
    ${user_details}=    Parse JSON Response    ${response}
    RETURN              ${user_details}

Verify User Updated
    [Documentation]    Verifies that a user's details have been updated.
    [Arguments]         ${user_id}    ${name}    ${nickname}
    ${user_details}=    Get User by ID    ${user_id}
    ${updated_name}=         Get From Dictionary    ${user_details}    name
    ${updated_nickname}=         Get From Dictionary    ${user_details}    nickname
    Should Be Equal As Strings    ${updated_name}    ${name}
    Should Be Equal As Strings    ${updated_nickname}    ${nickname}

Delete all users
    [Documentation]    Deletes all users by retrieving the current user list and deleting each user individually.
    ${users}=           List Users
    FOR    ${user}      IN    @{users}
        ${uuid}=       Get From Dictionary    ${user}    uuid
        Delete User    ${uuid}
    END
    Log                 All users have been deleted successfully.