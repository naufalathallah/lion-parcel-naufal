## Assignment 1: API Automation Testing

This Robot Framework script tests the [Reqres API](https://reqres.in/) for:
- **GET SINGLE USER**: Retrieves user with ID 2, checks for status `200`, and validates against `single-user.json`.
- **POST CREATE USER**: Creates a user with name "morpheus" and job "leader", checks for status `201`, and validates against `create-user.json`.

### Structure
- **Test Cases**:
  - `Get Single User`
  - `Create New User`
- **Schemas**: Located in the `schemas` folder.

### Run the Test
```bash
robot tests/assignment-1.robot
```

## Assignment 2: Shopping Cart Checkout Automation

This Robot Framework script automates the user journey on [Sauce Demo](https://www.saucedemo.com/) for a complete checkout process:
- **Login**: Logs in as a standard user.
- **Add Product**: Adds "Sauce Labs Backpack" to the cart.
- **Checkout**: Proceeds through the checkout process, fills in user details, and completes the order.
- **Validation**: Verifies the order confirmation message.

### Structure
- **Test Case**: 
  - `As a User, I Can Successfully Purchase a Product`

### Run the Test
```bash
robot tests/assignment-2.robot
```

### Test Plan & Test Case Documentation
Create Test Plan & Test Case for journey as a buyer:
[Google Sheets Test Plan](https://docs.google.com/spreadsheets/d/11UpwLe6yNgsfwj9JxhTDh7wP8PRnRUei/edit?usp=sharing&ouid=118163462700119744611&rtpof=true&sd=true)

