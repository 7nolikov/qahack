*** Variables ***
${DEV_HOST}           https://dev-gs.qa-playground.com/api/v1
${RELEASE_HOST}       https://release-gs.qa-playground.com/api/v1
${QA_TOKEN}       default-token
${CURRENT_HOST}       ${EMPTY}
${TASK_ID_HEADER}     ${EMPTY}
@{TEST_HOSTS}         ${DEV_HOST}    ${RELEASE_HOST}
