*** Settings ***
Resource        ../resources/user_keywords.robot
Resource        ../resources/variables.robot
Library    FakerLibrary
Library    Collections
Library    OperatingSystem

Suite Teardown    Delete All Users

*** Test Cases ***

Create User Test
    [Documentation]         Verify that a user can be created successfully.
    ${user_id}=             Create User
    Should Not Be Empty     ${user_id}
    [Teardown]              Delete User    ${user_id}

List Users Test
    [Documentation]         Verify that the list of users can be retrieved.
    ${user_id}=             Create User
    ${users}=               List Users
    Should Not Be Empty     ${users}
    [Teardown]              Delete User    ${user_id}

Delete User Test
    [Documentation]         Verify that a user can be deleted successfully.
    ${user_id}=             Create User
    Delete User             ${user_id}

Get User by ID Test
    [Documentation]         Verify that user details can be retrieved by ID.
    ${user_id}=             Create User
    ${user_details}=        Get User by ID    ${user_id}
    ${uuid}=                Get From Dictionary    ${user_details}    uuid
    Should Be Equal As Strings    ${uuid}    ${user_id}
    [Teardown]              Delete User    ${user_id}

Update User Test
    [Documentation]         Verify that a user's details can be updated.
    ${user_id}=             Create User
    ${updated_name}=        FakerLibrary.Name
    ${updated_nickname}=    FakerLibrary.UserName
    Update User             ${user_id}    ${updated_name}    ${updated_nickname}
    Verify User Updated     ${user_id}    ${updated_name}    ${updated_nickname}
    [Teardown]              Delete User    ${user_id}

Login User Test
    [Documentation]         Verify that a user can log in successfully.
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

    ${user_details}=            Login User    ${email}    ${password}
    ${uuid}=                Get From Dictionary    ${user_details}    uuid
    Should Be Equal As Strings    ${uuid}    ${user_id}
    [Teardown]              Delete User    ${user_id}