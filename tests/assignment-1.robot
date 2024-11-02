*** Settings ***
Library           RequestsLibrary
Library           JSONSchemaLibrary    schema_location=${CURDIR}/../schemas


*** Variables ***
${BASE_URL}                     https://reqres.in/api
${SINGLE_USER_ENDPOINT}         ${BASE_URL}/users/2
${CREATE_USER_ENDPOINT}         ${BASE_URL}/users

${JSON_SCHEMA_SINGLE_USER}      single-user.json
${JSON_SCHEMA_CREATE_USER}      create-user.json

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
    And the user details should match the schema

Create New User
    Given I have the user details "morpheus" and "leader"
    When I send a request to create a new user
    Then I should receive a "201" status code
    And the created user details should match the schema


*** Keywords ***
I have the user ID "${id}"
    Log    I have the user ID "${id}"
    Set Test Variable    ${USER_ID}    ${id}

I send a request to get single user
    Log    Sending request to get user with ID "${USER_ID}"
    ${response}=    GET    ${BASE_URL}/users/${USER_ID}
    Set Test Variable    ${STATUS_CODE}    ${response.status_code}
    Set Test Variable    ${RESPONSE_JSON}    ${response.json()}

I should receive a "${expected_status}" status code
    Log    Verifying status code is ${expected_status}
    ${expected_status}=    Convert To Integer    ${expected_status}
    Should Be Equal As Numbers    ${STATUS_CODE}    ${expected_status}

The user details should match the schema
    Log    ${JSON_SCHEMA_SINGLE_USER}
    Log    ${RESPONSE_JSON}
    Validate Json    ${JSON_SCHEMA_SINGLE_USER}    ${RESPONSE_JSON}

I have the user details "${name}" and "${job}"
    Log    Setting user details with name "${name}" and job "${job}"
    Set Test Variable    ${USER_NAME}    ${name}
    Set Test Variable    ${USER_JOB}     ${job}

I send a request to create a new user
    Log    Sending request to create user with name "${USER_NAME}" and job "${USER_JOB}"
    ${data}=    Create Dictionary    name=${USER_NAME}    job=${USER_JOB}
    ${response}=    POST    ${CREATE_USER_ENDPOINT}    json=${data}
    Set Test Variable    ${STATUS_CODE}    ${response.status_code}
    Set Test Variable    ${RESPONSE_JSON}    ${response.json()}

The created user details should match the schema
    Log    ${JSON_SCHEMA_CREATE_USER}
    Log    ${RESPONSE_JSON}
    Validate Json    ${JSON_SCHEMA_CREATE_USER}    ${RESPONSE_JSON}