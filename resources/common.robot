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

${BTN_AGREE}                      id=com.lionparcel.services.consumer:id/btnAgree
${TXT_SKIP}                       id=com.lionparcel.services.consumer:id/txtSkip
${IV_CLOSE}                       id=com.lionparcel.services.consumer:id/ivClose
${BTN_BACK}                       accessibility_id=Navigate up
${LOADING_TITLE}                  id=com.lionparcel.services.consumer:id/text_loading_title

*** Keywords ***
Setup
    Log To Console    Opening App...
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    autoGrantPermissions=true    noReset=true

    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${IV_CLOSE}
    Run Keyword If    ${is_visible}    Click Element    ${IV_CLOSE}

Back To Home
    ${is_visible}=    Set Variable    True
    WHILE    ${is_visible}
        Click Element     ${BTN_BACK}
        Sleep             1s
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${BTN_BACK}
    END

I get back
    Click Element    ${BTN_BACK}

I close the popup
    Click Element    ${IV_CLOSE}
    