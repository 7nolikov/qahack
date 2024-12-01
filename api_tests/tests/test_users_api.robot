*** Settings ***
Resource        ../resources/variables.robot
Resource        ../resources/common_keywords.robot
Resource        ../resources/users_keywords.robot
Library    FakerLibrary
Library    Collections
Library    OperatingSystem
Suite Setup       Delete All Users
Suite Teardown    Delete All Users

*** Test Cases ***
API-1 Delete User Test on Dev Environment
    [Documentation]                   Verify that a user can be deleted successfully.
    [Tags]                            user    dev   api-1
    Test API-1 Delete User            ${DEV_HOST}

API-1 Delete User Test on Release Environment
    [Documentation]                   Verify that a user can be deleted successfully.
    [Tags]                            user    release   api-1
    Test API-1 Delete User            ${RELEASE_HOST}

API-3 Create User Test on Dev Environment
    [Documentation]                   Verify that a user can be created successfully.
    [Tags]                            user   dev    api-3
    Test API-3 Create User            ${DEV_HOST}

API-3 Create User Test on Release Environment
    [Documentation]                   Verify that a user can be created successfully.
    [Tags]                            user   release    api-3
    Test API-3 Create User            ${RELEASE_HOST}

API-4 Update User Test on Dev Environment
    [Documentation]                   Verify that a user's details can be updated.
    [Tags]                            user    dev    api-4
    Test API-4 Update User            ${DEV_HOST}

API-4 Update User Test on Release Environment
    [Documentation]                   Verify that a user's details can be updated.
    [Tags]                            user    release    api-4
    Test API-4 Update User            ${RELEASE_HOST}

API-6 List Users Test on Dev Environment
    [Documentation]                   Verify that the list of users can be retrieved.
    [Tags]                            user  dev    api-6
    Test API-6 List Users             ${DEV_HOST}

API-6 List Users Test on Release Environment
    [Documentation]                   Verify that the list of users can be retrieved.
    [Tags]                            user  release    api-6
    Test API-6 List Users             ${RELEASE_HOST}

API-7 Get User by email and password Test on Dev Environment
    [Documentation]                   Verify that a user can log in successfully.
    [Tags]                            user  dev  api-7
    Test API-7 Get User by email and password        ${DEV_HOST}

API-7 Get User by email and password Test on Release Environment
    [Documentation]                   Verify that a user can log in successfully.
    [Tags]                            user  release  api-7
    Test API-7 Get User by email and password        ${RELEASE_HOST}

API-21 List Users Test on Dev Environment
    [Documentation]                   Verify that the list of users can be retrieved.
    [Tags]                            user  dev    api-21
    Test API-21 List Users            ${DEV_HOST}

API-21 List Users Test on Release Environment
    [Documentation]                   Verify that the list of users can be retrieved.
    [Tags]                            user  release    api-21
    Test API-21 List Users            ${RELEASE_HOST}

API-22 Create User Test on Dev Environment
    [Documentation]                   Verify that a user can be created successfully.
    [Tags]                            user  dev    api-22
    Test API-22 Create User           ${DEV_HOST}

API-22 Create User Test on Release Environment
    [Documentation]                   Verify that a user can be created successfully.
    [Tags]                            user  release    api-22
    Test API-22 Create User           ${RELEASE_HOST}

API-23 Get User by ID Test on Dev Environment
    [Documentation]                   Verify that user details can be retrieved by ID.
    [Tags]                            user  dev    api-23
    Test API-23 Get User by ID        ${DEV_HOST}

API-23 Get User by ID Test on Release Environment
    [Documentation]                   Verify that user details can be retrieved by ID.
    [Tags]                            user  release    api-23
    Test API-23 Get User by ID        ${RELEASE_HOST}

API-24 Update User Test on Dev Environment
    [Documentation]                   Verify that a user's details can be updated.
    [Tags]                            user  dev    api-24
    Test API-24 Update User           ${DEV_HOST}

API-24 Update User Test on Release Environment
    [Documentation]                   Verify that a user's details can be updated.
    [Tags]                            user  release    api-24
    Test API-24 Update User           ${RELEASE_HOST}
