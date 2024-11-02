*** Settings ***
Library    AppiumLibrary



*** Variables ***
${REMOTE_URL}         http://localhost:4723
${PLATFORM_NAME}      Android
${PLATFORM_VERSION}   13
${DEVICE_NAME}        M2101K7BNY
${AUTOMATION_NAME}    UIAutomator2
${APP_PACKAGE}        com.lionparcel.services.consumer
${APP_ACTIVITY}       .view.main.MainActivity
${AUTO_GRANT_PERMISSIONS}   true

${SCREEN_WIDTH}    1080  
${SCREEN_HEIGHT}   1920 


*** Test Cases ***
open app
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    autoGrantPermissions=${AUTO_GRANT_PERMISSIONS}
    Click Element    id=com.lionparcel.services.consumer:id/btnAgree
    Terminate Application    ${APP_PACKAGE}
    Activate Application    ${APP_PACKAGE}
    Wait Until Element Is Visible     id=com.lionparcel.services.consumer:id/txtSkip    10s
    Click Element    id=com.lionparcel.services.consumer:id/txtSkip

    Wait Until Element Is Visible    id=com.lionparcel.services.consumer:id/ivClose    5s
    Click Element    id=com.lionparcel.services.consumer:id/ivClose
   
    Sleep    20s    reason=cannot interact with elements
    
    Click Element    id=com.lionparcel.services.consumer:id/ivClose
    
skenarionya
    Click Element    android=UiSelector().text("Cek Tarif")
    Click Element    id=com.lionparcel.services.consumer:id/edtOriginAddress
    Input Text       id=com.lionparcel.services.consumer:id/edtRouteSearch    Cibinong, Bogor
    Wait Until Element Is Visible    //android.widget.TextView[contains(@text, 'Cibinong, Bogor')]
    Click Element    //android.widget.TextView[contains(@text, 'Cibinong, Bogor')]

    Click Element    id=com.lionparcel.services.consumer:id/edtDestinationAddress
    Input Text       id=com.lionparcel.services.consumer:id/edtRouteSearch    Pancoran
    Wait Until Element Is Visible   //android.widget.TextView[@text="Pancoran"]/following-sibling::android.widget.TextView[contains(@text, "Jakarta Selatan")]
    Click Element    //android.widget.TextView[@text="Pancoran"]/following-sibling::android.widget.TextView[contains(@text, "Jakarta Selatan")]
    
    Wait Until Element Is Visible    id=com.lionparcel.services.consumer:id/btnCheckTariff
    Click Element    id=com.lionparcel.services.consumer:id/btnCheckTariff

    Wait Until Page Contains Element    id=com.lionparcel.services.consumer:id/btnAddDetail
    Element Should Be Visible    android=new UiScrollable(new UiSelector()).scrollIntoView(new UiSelector().text("Request Pick Up"))

Click and Log Total Biaya for Each Instance
    FOR    ${index}    IN RANGE    0    7
        ${selector}=    Set Variable    android=UiSelector().resourceId("com.lionparcel.services.consumer:id/ivTariffBackGround").instance(${index})
        Click Element    ${selector}
        ${total_biaya}=    Get Text    //android.widget.TextView[@text="Total Biaya :"]/following-sibling::android.widget.TextView
        Log    Instance ${index} - Total Biaya: ${total_biaya}
    END


*** Keywords ***