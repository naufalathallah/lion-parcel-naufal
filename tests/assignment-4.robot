*** Settings ***
Library            AppiumLibrary

Resource           ../resources/common.robot

Suite Setup        Open And Login To App

*** Variables ***



*** Test Cases ***
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