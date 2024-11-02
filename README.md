## Assignment 1: API Automation Testing

This Robot Framework script tests the Reqres API for:
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
