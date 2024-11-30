*** Settings ***
Resource        ../resources/common.robot
Library    FakerLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${USER_ENDPOINT}    /users
${USER_LOGIN_ENDPOINT}    /users/login

*** Keywords ***
Create User
    [Documentation]    Create a user and return the user details.
    ${name}=         FakerLibrary.Name
    ${email}=        FakerLibrary.Email
    ${password}=     FakerLibrary.Password
    ${nickname}=     FakerLibrary.UserName
    ${body}=    Create Dictionary    email=${email}    password=${password}    name=${name}    nickname=${nickname}
    ${response}=    Send Authorized Request    POST     ${USER_ENDPOINT}    ${body}
    Validate Status Code    ${response}    200
    ${user_id}=    Get From Dictionary    ${response.json()}    uuid
    Log    User Created: ID=${user_id}, Email=${email}, Name=${name}
    RETURN    ${user_id}

Delete User By ID
    [Arguments]    ${user_id}
    [Documentation]    Delete a user by ID and validate the deletion.
    ${response}=    Send Authorized Request    DELETE    ${USER_ENDPOINT}/${user_id}
    Validate Status Code    ${response}    204
    Log    User Deleted: ID=${user_id}

Verify User Not Found
    [Arguments]    ${user_id}
    [Documentation]    Verify that a user does not exist.
    ${response}=    Send Authorized Request    GET    ${USER_ENDPOINT}/${user_id}
    Validate Status Code    ${response}    404
    Log    Verified user ID ${user_id} does not exist.

*** Test Cases ***

Create User Test
    [Documentation]    Test to create a user and validate the response.
    ${user_id}=    Create User

List Users Test
    [Documentation]    Test to retrieve the list of users.
    ${response}=    Send Authorized Request    GET    ${USER_ENDPOINT}?offset=0&limit=10
    Validate Status Code    ${response}    200
    Log    Retrieved User List: ${response.json()}

Delete User Test
    [Documentation]    Test to delete a user and validate the deletion.
    ${user_id}=    Create User
    Delete User By ID    ${user_id}
    Verify User Not Found    ${user_id}

Get User by ID Test
    [Documentation]    Test to retrieve user details by ID.
    ${user_id}=    Create User
    ${response}=    Send Authorized Request    GET    ${USER_ENDPOINT}/${user_id}
    Validate Status Code    ${response}    200
    Log    User Details: ${response.json()}

Update User Test
    [Documentation]    Test to update a user's details.
    ${user_id}=    Create User
    ${body}=    Create Dictionary    name=UpdatedName    nickname=UpdatedNick
    ${response}=    Send Authorized Request    PATCH    ${USER_ENDPOINT}/${user_id}    ${body}
    Validate Status Code    ${response}    200
    Log    Updated User Details: ${response.json()}

Login User Test
    [Documentation]    Test to log in a user with valid credentials.
    ${user_id}=    Create User
    ${body}=    Create Dictionary    email=test@example.com    password=password123
    ${response}=    Send Authorized Request    POST    ${USER_LOGIN_ENDPOINT}    ${body}
    Validate Status Code    ${response}    200
    Log    Login Successful: ${response.json()}

Invalid Email Format Test
    [Documentation]    Test to validate the behavior when an invalid email is provided.
    ${body}=    Create Dictionary    email=invalid_email    password=password123    name=TestUser
    ${response}=    Send Authorized Request    POST    ${USER_ENDPOINT}    ${body}
    Validate Status Code    ${response}    400
    Log    Error Response: ${response.json()}

Missing Required Fields Test
    [Documentation]    Test to validate behavior when required fields are missing.
    ${body}=    Create Dictionary    email=test@example.com
    ${response}=    Send Authorized Request    POST    ${USER_ENDPOINT}    ${body}
    Validate Status Code    ${response}    400
    Log    Error Response: ${response.json()}

Unauthorized Access Test
    [Documentation]    Test to verify unauthorized access behavior.
    Create Session    api-session    ${HOST}    verify=False
    ${response}=    GET On Session    api-session    ${USER_ENDPOINT}
    Validate Status Code    ${response}    401
    Log    Error Response: ${response.json()}

User Not Found Test
    [Documentation]    Test to validate behavior when a user is not found.
    ${response}=    Send Authorized Request    GET    ${USER_ENDPOINT}/non-existing-id
    Validate Status Code    ${response}    404
    Log    Error Response: ${response.json()}
