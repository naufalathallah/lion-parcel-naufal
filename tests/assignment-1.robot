*** Settings ***
Library           RequestsLibrary
Library           JSONSchemaLibrary    schema_location=${CURDIR}/../schemas

*** Variables ***
${BASE_URL}       https://reqres.in/api
${SINGLE_USER_ENDPOINT}    ${BASE_URL}/users/2
${JSON_SCHEMA_SINGLE_USER}   single-user.json
${user_id}              ${EMPTY}
${status_code}          ${EMPTY}
${response_json}        ${EMPTY}

*** Test Cases ***
Get Single User
    [Documentation]    This test case is to test the "Get Single User" API.
    Given I have the user ID "2"
    When I send a request to get single user
    Then I should receive a 200 status code
    And the user details should match the schema

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