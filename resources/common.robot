*** Settings ***
Library    AppiumLibrary


*** Variables ***
${REMOTE_URL}                     http://localhost:4723
${PLATFORM_NAME}                  Android
${PLATFORM_VERSION}               13
${DEVICE_NAME}                    M2101K7BNY
${AUTOMATION_NAME}                UIAutomator2
${APP_PACKAGE}                    com.lionparcel.services.consumer
${APP_ACTIVITY}                   .view.main.MainActivity
${AUTO_GRANT_PERMISSIONS}         true

${BTN_AGREE}                      id=com.lionparcel.services.consumer:id/btnAgree
${TXT_SKIP}                       id=com.lionparcel.services.consumer:id/txtSkip
${IV_CLOSE}                       id=com.lionparcel.services.consumer:id/ivClose
${BTN_BACK}                       accessibility_id=Navigate up
${LOADING_TITLE}                  id=com.lionparcel.services.consumer:id/text_loading_title

*** Keywords ***
Open And Login To App
    Log To Console    Login To App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    autoGrantPermissions=${AUTO_GRANT_PERMISSIONS}
    Click Element                    ${BTN_AGREE}

    Terminate Application            ${APP_PACKAGE}
    Activate Application             ${APP_PACKAGE}

    Wait Until Element Is Visible    ${TXT_SKIP}    10s
    Click Element                    ${TXT_SKIP}

    Wait Until Element Is Visible    ${IV_CLOSE}    5s
    Click Element                    ${IV_CLOSE}

    Sleep    20s    reason=cannot interact with elements
    Click Element                    ${IV_CLOSE}

Back To Home
    ${is_visible}=    Set Variable    True
    WHILE    ${is_visible}
        Click Element     ${BTN_BACK}
        Sleep             1s
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${BTN_BACK}
    END

I get back
    Click Element    ${BTN_BACK}