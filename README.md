# QA Hackaton

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Running the Tests](#running-the-tests)
  - [Executing Tests](#executing-tests)
  - [Specifying Environments](#specifying-environments)
- [Test Reports](#test-reports)
  - [Accessing Reports](#accessing-reports)
  - [Report Details](#report-details)
- [Troubleshooting](#troubleshooting)
- [Additional Information](#additional-information)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Welcome to the API Automation Test Suite repository. This suite is developed using [Robot Framework](https://robotframework.org/), a versatile automation framework, to validate various user-related API endpoints across multiple environments, namely `DEV_HOST` and `RELEASE_HOST`. The tests utilize libraries such as `RequestsLibrary` for handling HTTP interactions and `FakerLibrary` for generating realistic test data.

## Prerequisites

Before setting up and executing the tests, ensure the following prerequisites are met:

- **Operating System:** Compatible with Windows, macOS, or Linux.
- **Python:** Version 3.7 or higher is required.
- **Package Manager:** Python's `pip` should be installed and functional.
- **Version Control:** Git is necessary for cloning the repository.

## Installation

To set up the testing environment, follow these steps:

1. **Clone the Repository:**
   Obtain the latest version of the test suite by cloning the repository to your local machine.

2. **Set Up a Virtual Environment (Recommended):**
   Creating a virtual environment helps manage dependencies and maintain a clean workspace.

3. **Upgrade `pip`:**
   Ensure that the Python package manager is up to date to facilitate smooth installation of dependencies.

4. **Install Dependencies:**
   Install all necessary Python packages and libraries required for the test suite to function correctly. These include Robot Framework and its associated libraries.

## Configuration

Proper configuration is essential for the test suite to interact with the correct environments and endpoints.

### Define Variables

Update the `variables.robot` file located in the `tests/resources/` directory with the necessary environment variables such as host URLs, endpoints, authentication tokens, and task identifiers.

### Update Hosts

Ensure that both `DEV_HOST` and `RELEASE_HOST` are accurately defined. If additional environments are required, they can be added to the hosts list within the test suite configuration.

## Running the Tests

Executing the tests involves running the test suite against the defined environments to validate API functionalities.

### Executing Tests

Run the entire test suite to execute all test cases. This will initiate tests across all specified environments, ensuring comprehensive coverage of API endpoints.

### Specifying Environments

The test suite is designed to target both `DEV_HOST` and `RELEASE_HOST`. Ensure that these environments are correctly specified in the configuration files so that each test case runs against both hosts, providing validation across different deployment stages.

## Test Reports

Upon completion of the test execution, detailed reports are generated to provide insights into the test results.

### Accessing Reports

The reports are located in the `reports/` directory and include:

- **log.html**: A detailed log of the test execution, capturing each step and its outcome.
- **report.html**: A summary report highlighting the overall test results, including passed and failed tests.
- **output.xml**: An XML file containing raw test execution data, useful for integrations and further analysis.

### Report Details

- **Pass/Fail Status**: Each test case is marked as passed or failed based on its execution outcome.
- **Execution Time**: The duration taken to execute each test case is recorded.
- **Logs**: Detailed logs provide step-by-step information on the execution flow, aiding in debugging and analysis.
- **Screenshots**: For any failed test cases, screenshots are available to visualize the state at the point of failure.

## Troubleshooting

Encountering issues during test execution is possible. Common problems and their resolutions include:

1. **Missing Robot Framework Module:**
   Ensure that Robot Framework is installed correctly and that the Python environment is properly configured.

2. **Attribute Errors:**
   Verify that all keywords and variables are correctly defined and that responses from API calls are being handled appropriately.

3. **Command Recognition Issues:**
   Check that Python's Scripts directory is included in the system's PATH to allow for proper command execution.

Additional debugging steps include running tests with enhanced logging to gain more insights and isolating failing tests to identify specific issues.

## Additional Information

### Virtual Environments

Using virtual environments is highly recommended to manage dependencies effectively and maintain a clean project setup. This approach ensures that the project dependencies do not interfere with other projects and vice versa.

### Updating Dependencies

Regularly update the project dependencies to benefit from the latest features, security patches, and bug fixes. Keeping libraries up to date ensures compatibility and smooth operation of the test suite.

### Extending the Test Suite

The test suite can be expanded by adding new test cases or custom keywords. New `.robot` files can be created within the `tests/` directory, and reusable keywords can be defined in the `keywords.robot` file for consistent usage across multiple tests.

## Contributing

Contributions to enhance the test suite are welcome. To contribute:

1. **Fork the Repository:**
   Create a personal copy of the repository to propose changes.

2. **Create a Feature Branch:**
   Develop your feature or fix within a separate branch to maintain the stability of the main branch.

3. **Commit Your Changes:**
   Ensure that your commits are descriptive and clearly outline the changes made.

4. **Push to the Branch:**
   Upload your feature branch to your forked repository.

5. **Open a Pull Request:**
   Propose your changes for review and integration into the main repository.

Please adhere to the project's coding standards and include appropriate tests for any new features or fixes.

## License

This project is licensed under the [MIT License](LICENSE). Please refer to the LICENSE file for detailed information on permissions and limitations.