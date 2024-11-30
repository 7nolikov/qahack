import os
import subprocess
import sys

sys.path.append(os.path.abspath(os.path.dirname(__file__)))
from config.config_variables import configurations

def run_tests(env):
    env_config = configurations[env]
    host = env_config["HOST"]
    x_task_id = env_config["X_TASK_ID"]
    qa_token = os.getenv("QA_TOKEN")
    if not qa_token:
        raise EnvironmentError("QA_TOKEN environment variable is not set!")

    subprocess.run([
        sys.executable, "-m", "robot",
        f"--variable=HOST:{host}",
        f"--variable=X_TASK_ID:{x_task_id}",
        f"--variable=QA_TOKEN:{qa_token}",
        "--outputdir", f"results/{env}",
        "api_tests/tests/"
    ], check=True)

if __name__ == "__main__":
    for environment in ["release", "dev"]:
        print(f"Running tests for {environment} environment...")
        try:
            run_tests(environment)
        except subprocess.CalledProcessError as e:
            print(
                f"Error while running tests for {environment} environment: {e}")
            sys.exit(1)
