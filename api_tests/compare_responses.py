import requests
import json
import os
import yaml

def compare_responses(endpoint):
    with open('environment.yaml') as f:
        config = yaml.safe_load(f)

    dev_config = config['dev']
    release_config = config['release']
    headers = {
        "Authorization": f"Bearer {os.environ['QA_TOKEN']}",
        "X-Task-Id": dev_config['headers']['X-Task-Id']
    }

    dev_response = requests.get(f"{dev_config['host']}{endpoint}", headers=headers).json()
    release_response = requests.get(f"{release_config['host']}{endpoint}", headers=headers).json()

    print("DEV Response:", json.dumps(dev_response, indent=4))
    print("RELEASE Response:", json.dumps(release_response, indent=4))

    if dev_response != release_response:
        print("Mismatch found!")
    else:
        print("Responses match.")

if __name__ == "__main__":
    compare_responses("/users")
