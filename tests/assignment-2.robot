*** Settings ***
Library    SeleniumLibrary
Suite Teardown    I log out of the application


*** Variables ***
${BASE_URL}       https://www.saucedemo.com/
${BROWSER}        Chrome

${LOGIN_USERNAME_FIELD}         id:user-name
${LOGIN_PASSWORD_FIELD}         id:password
${LOGIN_BUTTON}                 id:login-button
${PRODUCTS_TITLE}               data:test:title
${CART_ICON}                    data:test:shopping-cart-link
${CHECKOUT_BUTTON}              data:test:checkout
${FIRST_NAME_FIELD}             data:test:firstName
${LAST_NAME_FIELD}              data:test:lastName
${POSTAL_CODE_FIELD}            data:test:postalCode
${CONTINUE_BUTTON}              data:test:continue
${FINISH_BUTTON}                data:test:finish
${ORDER_COMPLETE_HEADER}        data:test:complete-header
${ORDER_COMPLETE_TEXT}          data:test:complete-text
${BACK_TO_PRODUCTS_BUTTON}      data:test:back-to-products
${MENU_BUTTON}                  class:bm-burger-button
${LOGOUT_BUTTON}                data:test:logout-sidebar-link


*** Test Cases ***
As a User, I Can Successfully Purchase a Product
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
    Input Text        ${LOGIN_USERNAME_FIELD}    ${username}
    Input Password    ${LOGIN_PASSWORD_FIELD}    ${password}
    Click Element     ${LOGIN_BUTTON}

I should see the Products page
    Element Should Be Visible        ${PRODUCTS_TITLE}
    ${title_text}=    Get Text       ${PRODUCTS_TITLE}
    Should Be Equal As Strings       ${title_text}    Products

I add the product "${product_name}" to the cart
    ${add_to_cart_selector}=    Set Variable    data:test:add-to-cart-${product_name}
    Click Element    ${add_to_cart_selector}

I proceed to checkout
    Click Element    ${CART_ICON} 
    Click Element    ${CHECKOUT_BUTTON}

I fill in my information with "${first_name}", "${last_name}", and "${postal_code}"
    Input Text    ${FIRST_NAME_FIELD}    ${first_name}
    Input Text    ${LAST_NAME_FIELD}     ${last_name}
    Input Text    ${POSTAL_CODE_FIELD}   ${postal_code}

I continue to checkout
    Click Element    ${CONTINUE_BUTTON}

I finish the checkout process
    Click Element    ${FINISH_BUTTON}

I should see a success message for the order
    Element Should Be Visible         ${ORDER_COMPLETE_HEADER}
    ${header_text}=    Get Text       ${ORDER_COMPLETE_HEADER}
    Should Be Equal As Strings        ${header_text}    Thank you for your order!

    Element Should Be Visible         ${ORDER_COMPLETE_TEXT}
    ${complete_text}=    Get Text     ${ORDER_COMPLETE_TEXT}
    Should Be Equal As Strings        ${complete_text}    Your order has been dispatched, and will arrive just as fast as the pony can get there!

I log out of the application
    Click Element                    ${BACK_TO_PRODUCTS_BUTTON}
    Click Element                    ${MENU_BUTTON}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON}    5s
    Click Element                    ${LOGOUT_BUTTON}
    Element Should Be Visible        ${LOGIN_BUTTON}
    Close Browser
