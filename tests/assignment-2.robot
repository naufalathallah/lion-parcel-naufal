*** Settings ***
Library    SeleniumLibrary


*** Keywords ***



*** Test Cases ***
login
    Open Browser    https://www.saucedemo.com/    Chrome
    Input Text    id:user-name    standard_user
    Input Password    id:password    secret_sauce
    Click Element    id:login-button

Verify Products Title Text
    Element Should Be Visible   data:test:title
    ${title_text}=    Get Text    data:test:title
    Should Be Equal As Strings    ${title_text}    Products

Add product to cart
    Click Element    data:test:add-to-cart-sauce-labs-backpack

Open cart
    Click Element    data:test:shopping-cart-link

Proceed checkout
    Click Element    data:test:checkout

Fill your information
    Input Text    data:test:firstName    John
    Input Text    data:test:lastName     Doe
    Input Text    data:test:postalCode   12345

Continue checkout
    Click Element    data:test:continue

Finish checkout
    Click Element    data:test:finish

Succeess checkout
    Element Should Be Visible    data:test:complete-header
    ${header_text}=    Get Text    data:test:complete-header
    Should Be Equal As Strings    ${header_text}    Thank you for your order!

    Element Should Be Visible    data:test:complete-text
    ${complete_text}=    Get Text    data:test:complete-text
    Should Be Equal As Strings    ${complete_text}    Your order has been dispatched, and will arrive just as fast as the pony can get there!

Ini untuk teardown
    Click Element    data:test:back-to-products
    Click Element    class:bm-burger-button
    Wait Until Element Is Visible    data:test:logout-sidebar-link    5s
    Click Element    data:test:logout-sidebar-link
    Element Should Be Visible    id:login-button
    