*** Settings ***
Library    SeleniumLibrary
Suite Teardown    I log out of the application


*** Variables ***
${BASE_URL}       https://www.saucedemo.com/
${BROWSER}        Chrome

${LOGIN_USERNAME_SELECTOR}      id:user-name
${LOGIN_PASSWORD_SELECTOR}      id:password
${LOGIN_BUTTON_SELECTOR}        id:login-button
${PRODUCTS_TITLE_SELECTOR}      data:test:title
${CART_ICON_SELECTOR}           data:test:shopping-cart-link
${CHECKOUT_BUTTON_SELECTOR}     data:test:checkout
${FIRST_NAME_SELECTOR}          data:test:firstName
${LAST_NAME_SELECTOR}           data:test:lastName
${POSTAL_CODE_SELECTOR}         data:test:postalCode
${CONTINUE_BUTTON_SELECTOR}     data:test:continue
${FINISH_BUTTON_SELECTOR}       data:test:finish
${ORDER_COMPLETE_HEADER}        data:test:complete-header
${ORDER_COMPLETE_TEXT}          data:test:complete-text
${BACK_TO_PRODUCTS_BUTTON}      data:test:back-to-products
${MENU_BUTTON_SELECTOR}         class:bm-burger-button
${LOGOUT_BUTTON_SELECTOR}       data:test:logout-sidebar-link


*** Test Cases ***
User Can Successfully Purchase a Product
    Given I am on the login page
    When I log in with "standard_user" and "secret_sauce"
    Then I should see the Products page
    When I add the product "sauce-labs-backpack" to the cart
    And I proceed to checkout
    And I fill in my information with "Naufal", "Iwel", and "12345"
    And I continue to checkout
    And I finish the checkout process
    Then I should see a success message for the order


*** Keywords ***
I am on the login page
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

I log in with "${username}" and "${password}"
    Input Text        ${LOGIN_USERNAME_SELECTOR}    ${username}
    Input Password    ${LOGIN_PASSWORD_SELECTOR}    ${password}
    Click Element     ${LOGIN_BUTTON_SELECTOR}

I should see the Products page
    Element Should Be Visible        ${PRODUCTS_TITLE_SELECTOR}
    ${title_text}=    Get Text       ${PRODUCTS_TITLE_SELECTOR}
    Should Be Equal As Strings       ${title_text}    Products

I add the product "${product_name}" to the cart
    ${ADD_TO_CART_SELECTOR}=    Set Variable    data:test:add-to-cart-${product_name}
    Click Element    ${ADD_TO_CART_SELECTOR}

I proceed to checkout
    Click Element    ${CART_ICON_SELECTOR} 
    Click Element    ${CHECKOUT_BUTTON_SELECTOR}

I fill in my information with "${first_name}", "${last_name}", and "${postal_code}"
    Input Text    ${FIRST_NAME_SELECTOR}    ${first_name}
    Input Text    ${LAST_NAME_SELECTOR}     ${last_name}
    Input Text    ${POSTAL_CODE_SELECTOR}   ${postal_code}

I continue to checkout
    Click Element    ${CONTINUE_BUTTON_SELECTOR}

I finish the checkout process
    Click Element    ${FINISH_BUTTON_SELECTOR}

I should see a success message for the order
    Element Should Be Visible         ${ORDER_COMPLETE_HEADER}
    ${header_text}=    Get Text       ${ORDER_COMPLETE_HEADER}
    Should Be Equal As Strings        ${header_text}    Thank you for your order!

    Element Should Be Visible         ${ORDER_COMPLETE_TEXT}
    ${complete_text}=    Get Text     ${ORDER_COMPLETE_TEXT}
    Should Be Equal As Strings        ${complete_text}    Your order has been dispatched, and will arrive just as fast as the pony can get there!

I log out of the application
    Click Element                    ${BACK_TO_PRODUCTS_BUTTON}
    Click Element                    ${MENU_BUTTON_SELECTOR}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_SELECTOR}    5s
    Click Element                    ${LOGOUT_BUTTON_SELECTOR}
    Element Should Be Visible        ${LOGIN_BUTTON_SELECTOR}
    Close Browser
