*** Settings ***
Library         RequestsLibrary
Resource        ../config/${ENV_FILE}.robot

*** Variables ***
${SETUP_ENDPOINT}    /setup
${STATUS_ENDPOINT}   /status

*** Test Cases ***
Run Setup and Validate Status
    [Documentation]   Perform API setup and validate with status request.
    Create Session    api-session    ${HOST}    headers={"Authorization": "Bearer ${os.environ['QA_TOKEN']}"}
    ${setup_response}    Post Request    api-session    ${SETUP_ENDPOINT}
    Should Be Equal As Strings           ${setup_response.status_code}    205
    ${status_response}   Get Request     api-session    ${STATUS_ENDPOINT}
    Should Be Equal As Strings           ${status_response.status_code}   200
