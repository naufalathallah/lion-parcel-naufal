*** Settings ***
Library           AppiumLibrary
Resource          ../resources/common.robot

Suite Setup       Open And Login To App
Test Teardown     Back To Home


*** Variables ***
${CEK_TARIF_MENU}                     android=UiSelector().text("Cek Tarif")
${ORIGIN_ADDRESS_FIELD}               id=com.lionparcel.services.consumer:id/edtOriginAddress
${ROUTE_SEARCH_FIELD}                 id=com.lionparcel.services.consumer:id/edtRouteSearch
${DESTINATION_ADDRESS_FIELD}          id=com.lionparcel.services.consumer:id/edtDestinationAddress
${CHECK_TARIFF_BUTTON}                id=com.lionparcel.services.consumer:id/btnCheckTariff
${SCROLL_TO_REQUEST_PICKUP}           android=new UiScrollable(new UiSelector()).scrollIntoView(new UiSelector().text("Request Pick Up"))
${TOTAL_BIAYA_LABEL}                  //android.widget.TextView[@text="Total Biaya :"]/following-sibling::android.widget.TextView
${BTN_ADD_Detail}                     id=com.lionparcel.services.consumer:id/btnAddDetail
${BANNER_PROMO}                       id=com.lionparcel.services.consumer:id/ivBannerPromo
${BACK_BUTTON_ROUND}                  id=com.lionparcel.services.consumer:id/llBackButton
${SCROLL_TO_PENGIRIMAN_OTOMOTIF}      android=new UiScrollable(new UiSelector()).scrollIntoView(new UiSelector().text("Pengiriman Otomotif"))
${PICK_UP_BUTTON}                     id=com.lionparcel.services.consumer:id/btnPickup
${DROP_PACKET_BUTTON}                 id=com.lionparcel.services.consumer:id/btnDropOff

@{EXPECTED_TARIFS}                    Rp7.500    Rp78.000    Rp5.626    Rp5.250    Rp30.000    Rp400.000    Rp535.000


*** Test Cases ***
 As a User, I Can Check The Tarif
    Given I have opened the Cek Tarif menu
    When I input the origin address as "Cibinong, Bogor"
    And I input the destination address as "Pancoran"
    And I submit the request to check the tarif
    Then I should see the total biaya for each instance

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

As a User, I Can Verify Delivery Options for Pengiriman Prioritas
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Prioritas"
    Then I should see "Pick Up" option
    And I should see "Drop Paket" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Paket Jumbo
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Paket Jumbo"
    Then I should see "Drop Paket" option
    And I should not see "Pick Up" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Regular
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Regular"
    Then I should see "Pick Up" option
    And I should see "Drop Paket" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Termurah
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Termurah"
    Then I should see "Pick Up" option
    And I should see "Drop Paket" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Paket Besar
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Paket Besar"
    Then I should see "Pick Up" option
    And I should see "Drop Paket" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Internasional
    Given I have opened the Cek Tarif menu
    And I open the delivery type menu for "Pengiriman Internasional"
    Then I should see "Drop Paket" option
    And I should not see "Pick Up" option
    When I close the popup

As a User, I Can Verify Delivery Options for Pengiriman Otomotif
    Given I have opened the Cek Tarif menu
    When I scroll to the end of the page cek tarif
    And I open the delivery type menu for "Pengiriman Otomotif"
    Then I should not see "Pick Up" option
    And I should not see "Drop Paket" option
    When I close the popup
    

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
    Element Should Be Visible    ${SCROLL_TO_REQUEST_PICKUP}
    FOR    ${index}    IN RANGE    0    7
        Click Element            android=UiSelector().resourceId("com.lionparcel.services.consumer:id/ivTariffBackGround").instance(${index})
        ${total_biaya}=          Get Text            ${TOTAL_BIAYA_LABEL}
        Should Be Equal          ${total_biaya}      ${EXPECTED_TARIFS}[${index}]
        Log                      Total Biaya: ${total_biaya}, Expected: ${EXPECTED_TARIFS}[${index}]
    END

I input the invalid origin address as "${origin}"
    Wait Until Element Is Visible    ${ORIGIN_ADDRESS_FIELD}
    Click Element                    ${ORIGIN_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${origin}

I input the invalid destination address as "${destination}"
    Wait Until Element Is Visible    ${DESTINATION_ADDRESS_FIELD}
    Click Element                    ${DESTINATION_ADDRESS_FIELD}
    Input Text                       ${ROUTE_SEARCH_FIELD}    ${destination}

I should see location not found message
    Text Should Be Visible            Lokasi tidak ditemukan

I open the delivery form from the banner
    Click Element            ${BANNER_PROMO}
    Wait Until Page Does Not Contain Element    ${LOADING_TITLE}
    Wait Until Element Is Visible    ${IV_CLOSE}    10s
    Click Element            ${IV_CLOSE}

I should see the delivery form
    Text Should Be Visible            Dimana Lokasi Pengirim?

I return from the form
    Click Element            ${BACK_BUTTON_ROUND}
    
I should see the check tarif button is disabled
    Wait Until Element Is Visible    ${CHECK_TARIFF_BUTTON}
    Element Should Be Disabled       ${CHECK_TARIFF_BUTTON}

I scroll to the end of the page cek tarif
    Element Should Be Visible    ${SCROLL_TO_PENGIRIMAN_OTOMOTIF}

I open the delivery type menu for "${delivery_type}"
    Wait Until Element Is Visible    android=UiSelector().text("${delivery_type}")
    Click Element                    android=UiSelector().text("${delivery_type}")

I should see "${option}" option
    Wait Until Page Contains        ${option}
    Text Should Be Visible          ${option} 

I should not see "${option}" option
    Sleep    1s
    ${is_visible}=    Run Keyword And Return Status    Text Should Be Visible    ${option}
    Should Not Be True    ${is_visible}