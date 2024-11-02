*** Settings ***
Library           RequestsLibrary
Library           JSONSchemaLibrary    schema_location=${CURDIR}/../schemas


*** Variables ***
${BASE_URL}       https://reqres.in/api
${SINGLE_USER_ENDPOINT}    ${BASE_URL}/users/2
${CREATE_USER_ENDPOINT}   ${BASE_URL}/users
${JSON_SCHEMA_SINGLE_USER}   single-user.json
${JSON_SCHEMA_CREATE_USER}    create-user.json
${user_id}              ${EMPTY}
${status_code}          ${EMPTY}
${response_json}        ${EMPTY}
${user_name}            ${EMPTY}
${user_job}             ${EMPTY}


*** Test Cases ***
Get Single User
    [Documentation]    This test case is to test the "Get Single User" API.
    Given I have the user ID "2"
    When I send a request to get single user
    Then I should receive a 200 status code
    And the user details should match the schema

Create New User
    [Documentation]    This test case is to test the "Create User" API.
    Given I have the user details "morpheus" and "leader"
    When I send a request to create a new user
    Then I should receive a 201 status code
    And the created user details should match the schema


*** Keywords ***
I have the user ID "${id}"
    Log    I have the user ID "${id}"
    Set Test Variable    ${user_id}    ${id}

I send a request to get single user
    Log    Sending request to get user with ID "${user_id}"
    ${response}=    GET    ${BASE_URL}/users/${user_id}
    Set Test Variable    ${status_code}    ${response.status_code}
    Set Test Variable    ${response_json}    ${response.json()}

I should receive a 200 status code
    Log    Verifying status code is 200
    Should Be Equal As Numbers    ${status_code}    200

The user details should match the schema
    Log    ${JSON_SCHEMA_SINGLE_USER}
    Log    ${response_json}
    Validate Json    ${JSON_SCHEMA_SINGLE_USER}    ${response_json}

I have the user details "${name}" and "${job}"
    Log    Setting user details with name "${name}" and job "${job}"
    Set Test Variable    ${user_name}    ${name}
    Set Test Variable    ${user_job}     ${job}

I send a request to create a new user
    Log    Sending request to create user with name "${user_name}" and job "${user_job}"
    ${data}=    Create Dictionary    name=${user_name}    job=${user_job}
    ${response}=    POST    ${CREATE_USER_ENDPOINT}    json=${data}
    Set Test Variable    ${status_code}    ${response.status_code}
    Set Test Variable    ${response_json}    ${response.json()}

I should receive a 201 status code
    Log    Verifying status code is 201
    Should Be Equal As Numbers    ${status_code}    201

The created user details should match the schema
    Log    ${JSON_SCHEMA_CREATE_USER}
    Log    ${response_json}
    Validate Json    ${JSON_SCHEMA_CREATE_USER}    ${response_json}