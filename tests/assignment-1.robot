*** Settings ***
Library           ../resources/api_library.py


*** Variables ***
${JSON_SCHEMA_SINGLE_USER}      ${CURDIR}\\..\\schemas\\single-user.json
${JSON_SCHEMA_CREATE_USER}      ${CURDIR}\\..\\schemas\\create-user.json

${USER_ID}                      ${EMPTY}
${STATUS_CODE}                  ${EMPTY}
${RESPONSE_JSON}                ${EMPTY}
${USER_NAME}                    ${EMPTY}
${USER_JOB}                     ${EMPTY}


*** Test Cases ***
Get Single User
    Given I have the user ID "2"
    When I send a request to get single user
    Then I should receive a "200" status code
    And The user details should match the schema

Create New User
    Given I have the user details "morpheus" and "leader"
    When I send a request to create a new user
    Then I should receive a "201" status code
    And The created user details should match the schema


*** Keywords ***
I have the user ID "${id}"
    Set Test Variable    ${USER_ID}    ${id}

I send a request to get single user
    ${status_code}    ${response_json}=    Get Single User   ${USER_ID}
    Set Test Variable      ${STATUS_CODE}      ${status_code}
    Set Test Variable      ${RESPONSE_JSON}    ${response_json}

I should receive a "${expected_status}" status code
    ${expected_status}=    Convert To Integer       ${expected_status}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${expected_status}

The user details should match the schema
    ${is_valid}    ${error}=    Validate Json Schema    ${RESPONSE_JSON}    ${JSON_SCHEMA_SINGLE_USER}
    Should Be True    ${is_valid}    ${error}

I have the user details "${name}" and "${job}"
    Set Test Variable    ${USER_NAME}    ${name}
    Set Test Variable    ${USER_JOB}     ${job}

I send a request to create a new user
    ${status_code}    ${response_json}=    Create User    ${USER_NAME}    ${USER_JOB}
    Set Test Variable       ${STATUS_CODE}      ${status_code}
    Set Test Variable       ${RESPONSE_JSON}    ${response_json}

The created user details should match the schema
    ${is_valid}    ${error}=    Validate Json Schema    ${RESPONSE_JSON}    ${JSON_SCHEMA_CREATE_USER}
    Should Be True    ${is_valid}    ${error}