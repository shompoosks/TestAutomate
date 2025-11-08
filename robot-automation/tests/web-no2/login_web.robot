*** Settings ***
Library    SeleniumLibrary  timeout=10    implicit_wait=5    run_on_failure=Capture Failure Screenshot    screenshot_root_directory=${OUTPUT DIR}/screenshots
Test Teardown  Capture Screenshot With Timestamp
Library    OperatingSystem
Resource   ../../resources/web_keywords.robot


*** Test Cases ***
Login success
    Open Web Login Page  https://the-internet.herokuapp.com/login
    Input User Credentials success
    Verify that users can login successfully
    Capture Screenshot With Timestamp
    Click Logout Button
    Verify that users can logout successfully
    Capture Screenshot With Timestamp

Login failed Password incorrect     
    Input User Credentials failed Password incorrect
    Verify that users can login unsuccessfully when they input a correct username but wrong password
    Capture Screenshot With Timestamp

Login failed Username not found
    Input User Credentials failed Username not found
    Verify that users can login unsuccessfully when they input a username that did not exist
    Capture Screenshot With Timestamp