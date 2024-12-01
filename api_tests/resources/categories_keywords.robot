*** Settings ***
Resource        ../resources/variables.robot
Resource        ../resources/common_keywords.robot

*** Keywords ***
Test API-10 Get Games By Category
    [Documentation]                   Retrieves the list of games for a specific category.
    [Arguments]                       ${CURRENT_HOST}
    Set Test Variable       ${host}   ${CURRENT_HOST}
    Set Test Variable                 ${task_id}   api-10
    ${categories}=                    Get Categories
    ${category}=                      Get From List    ${categories}    0
    ${category_id}=                   Get From Dictionary    ${category}    uuid
    ${games}=                         Get Games By Category    ${task_id}    ${category_id}
    Should Not Be Empty               ${games}
    Log                               Found ${games} games

Get Categories
    [Documentation]                   Retrieves the list of categories.
    ${response}=                      Send Authorized Request    ${task_id}    GET    ${host}/categories
    Response Should Be OK              ${response}
    ${json_response}=                    Parse JSON Response    ${response}
    ${categories}=                     Get From Dictionary    ${json_response}    categories
    Log                                Found ${categories} categories
    RETURN                           ${categories}

Get Games By Category
    [Documentation]                   Retrieves the list of games for a specific category.
    [Arguments]                       ${task_id}   ${category}
    ${response}=                      Send Authorized Request    ${task_id}    GET    ${host}/categories/${category}/games
    Response Should Be OK              ${response}
    ${json_response}=                    Parse JSON Response    ${response}
    ${games}=                          Get From Dictionary    ${json_response}    games
    Log                                Found ${games} games for category: ${category}
    RETURN                           ${games}