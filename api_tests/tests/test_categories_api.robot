*** Settings ***
Resource        ../resources/variables.robot
Resource        ../resources/common_keywords.robot
Resource        ../resources/categories_keywords.robot
Library    FakerLibrary
Library    Collections
Library    OperatingSystem

*** Test Cases ***
API-10 Get Games By Category Test on Dev Environment
    [Documentation]                         Verify that a user can be deleted successfully.
    [Tags]                                  category    dev   api-10
    Test API-10 Get Games By Category       ${DEV_HOST}

API-10 Get Games By Category Test on Release Environment
    [Documentation]                         Verify that a user can be deleted successfully.
    [Tags]                                  category    release   api-10
    Test API-10 Get Games By Category       ${RELEASE_HOST}