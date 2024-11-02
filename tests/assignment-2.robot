*** Settings ***
Library    ../resources/saucedemo_keywords.py

Suite Teardown    I log out of the application


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
    Open Browser And Navigate

I log in with "${username}" and "${password}"
    Login    ${username}    ${password}

I should see the Products page
    Verify Products Page

I add the product "${product_name}" to the cart
    Add Product To Cart    ${product_name}

I proceed to checkout
    Proceed To Checkout

I fill in my information with "${first_name}", "${last_name}", and "${postal_code}"
    Fill Information    ${first_name}    ${last_name}    ${postal_code}

I continue to checkout
    Continue Checkout

I finish the checkout process
    Finish Checkout

I should see a success message for the order
    Verify Order Success

I log out of the application
    Log Out
