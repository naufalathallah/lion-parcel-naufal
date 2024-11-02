*** Settings ***
Library           AppiumLibrary
Resource          ../resources/common.robot

Suite Setup       Given Open And Login To App
Test Teardown     When Back To Home


*** Variables ***
${CEK_TARIF_MENU}               android=UiSelector().text("Cek Tarif")
${ORIGIN_ADDRESS_FIELD}         id=com.lionparcel.services.consumer:id/edtOriginAddress
${ROUTE_SEARCH_FIELD}           id=com.lionparcel.services.consumer:id/edtRouteSearch
${DESTINATION_ADDRESS_FIELD}    id=com.lionparcel.services.consumer:id/edtDestinationAddress
${CHECK_TARIFF_BUTTON}          id=com.lionparcel.services.consumer:id/btnCheckTariff
${REQUEST_PICKUP_TEXT}          android=new UiScrollable(new UiSelector()).scrollIntoView(new UiSelector().text("Request Pick Up"))
${TOTAL_BIAYA_LABEL}            //android.widget.TextView[@text="Total Biaya :"]/following-sibling::android.widget.TextView
${BTN_ADD_Detail}               id=com.lionparcel.services.consumer:id/btnAddDetail
${BANNER_PROMO}                 id=com.lionparcel.services.consumer:id/ivBannerPromo
${BACK_BUTTON_ROUND}            id=com.lionparcel.services.consumer:id/llBackButton

@{EXPECTED_TARIFS}              Rp7.500    Rp78.000    Rp5.626    Rp5.250    Rp30.000    Rp400.000    Rp535.000


*** Test Cases ***
 As a User, I Can Check The Tarif
    Given I have opened the Cek Tarif menu
    When I input the origin address as "Cibinong, Bogor"
    And I input the destination address as "Pancoran"
    And I submit the request to check the tarif
    Then I should see the total biaya for each instance    @{EXPECTED_TARIFS}

As a User, I Can See Location Not Found When Entering an Origin Invalid Address
    Given I have opened the Cek Tarif menu
    When I input the invalid origin address as "@#!@$56🤣"
    Then I should see location not found message

As a User, I Can See Location Not Found When Entering an Destination Invalid Address
    Given I have opened the Cek Tarif menu
    When I input the invalid destination address as "@#!@$56🤣"
    Then I should see location not found message

As a User, I Can Access the Delivery Form from the Banner
    Given I have opened the Cek Tarif menu
    When I open the delivery form from the banner
    Then I should see the delivery form
    And I return from the form

As a User, I Cannot Check the Tarif if the Destination is Empty
    Given I have opened the Cek Tarif menu
    When I input the invalid destination address as ""
    And I get back
    Then I should see the check tarif button is disabled
    

*** Keywords ***
I have opened the Cek Tarif menu
    Click Element    ${CEK_TARIF_MENU}

I input the origin address as "${origin}"
    Click Element                    ${ORIGIN_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${origin}
    Wait Until Element Is Visible    xpath=//android.widget.TextView[contains(@text, '${origin}')]
    Click Element                    xpath=//android.widget.TextView[contains(@text, '${origin}')]

I input the destination address as "${destination}"
    Click Element                    ${DESTINATION_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${destination}
    Wait Until Element Is Visible    xpath=//android.widget.TextView[contains(@text, '${destination}')]/following-sibling::android.widget.TextView[contains(@text, "Jakarta Selatan")]
    Click Element                    xpath=//android.widget.TextView[contains(@text, '${destination}')]/following-sibling::android.widget.TextView[contains(@text, "Jakarta Selatan")]

I submit the request to check the tarif
    Wait Until Element Is Visible            ${CHECK_TARIFF_BUTTON}    5s
    Click Element                            ${CHECK_TARIFF_BUTTON}
    Wait Until Page Contains Element         ${BTN_ADD_Detail} 

I should see the total biaya for each instance
    [Arguments]    @{EXPECTED_TARIFS}
    Element Should Be Visible    ${REQUEST_PICKUP_TEXT}
    FOR    ${index}    IN RANGE    0    7
        Click Element            android=UiSelector().resourceId("com.lionparcel.services.consumer:id/ivTariffBackGround").instance(${index})
        ${total_biaya}=          Get Text            ${TOTAL_BIAYA_LABEL}
        Should Be Equal          ${total_biaya}      ${EXPECTED_TARIFS}[${index}]
        Log                      Total Biaya: ${total_biaya}, Expected: ${EXPECTED_TARIFS}[${index}]
    END

I input the invalid origin address as "${origin}"
    Click Element                    ${ORIGIN_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${origin}

I input the invalid destination address as "${destination}"
    Click Element                    ${DESTINATION_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${destination}

I should see location not found message
    Text Should Be Visible            Lokasi tidak ditemukan

I open the delivery form from the banner
    Click Element            ${BANNER_PROMO}
    Wait Until Page Does Not Contain Element    ${LOADING_TITLE}
    Wait Until Element Is Visible    ${IV_CLOSE}    5s
    Click Element            ${IV_CLOSE}

I should see the delivery form
    Text Should Be Visible            Dimana Lokasi Pengirim?

I return from the form
    Click Element            ${BACK_BUTTON_ROUND}
    
I should see the check tarif button is disabled
    Element Should Be Disabled       ${CHECK_TARIFF_BUTTON}