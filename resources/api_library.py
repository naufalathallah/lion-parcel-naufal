import requests
import json
from jsonschema import validate, ValidationError

BASE_URL = "https://reqres.in/api"

def get_single_user(user_id):
    response = requests.get(f"{BASE_URL}/users/{user_id}")
    return response.status_code, response.json()

def create_user(name, job):
    data = {"name": name, "job": job}
    response = requests.post(f"{BASE_URL}/users", json=data)
    return response.status_code, response.json()

def validate_json_schema(json_data, schema_path):
    with open(schema_path, 'r') as schema_file:
        schema = json.load(schema_file)
    try:
        validate(instance=json_data, schema=schema)
        return True, None
    except ValidationError as e:
        return False, str(e)