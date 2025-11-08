*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Open Web Login Page
    #สั่งให้เรียก inconito กัน error แจ้ง change password ของ gg
    [Arguments]    ${url}  #สั่ง robot ให้รับค่า url ที่ใส่ใน test case
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #คำสั่งเรียก method ส่งค่า incognito เข้าไปเพื่อเรียกให้เปิดแบบ inconito
    Call Method    ${options}    add_argument    --incognito
    #เปิด Chrome แบบ incognito ตามที่ใส่ option เข้าไป
    Create WebDriver    Chrome    options=${options}
    Go To    ${url}
    Maximize Browser Window

Input User Credentials success
    Input Text    id=username    tomsmith
    Input Text    id=password    SuperSecretPassword!
    Click Button  css:button[type="submit"]

Input User Credentials failed Password incorrect
    Input Text    id=username    tomsmith
    Input Text    id=password    Password!
    Click Button  css:button[type="submit"]

Input User Credentials failed Username not found
    Input Text    id=username    tomholland
    Input Text    id=password    Password!
    Click Button  css:button[type="submit"]       

Capture Screenshot With Timestamp
    #ดึงเวลาปัจจุบัน
    ${ts}=    Get Time    result_format=%Y-%m-%d_%H-%M-%S
    #เป็นตัวบอกให้ไปใส่ไฟล์รูปที่ไหน เชื่อมกับคำสั่ง robot -d robot-automation/results
    Capture Page Screenshot    ${OUTPUT DIR}/screenshots/${TEST NAME}_PASS_${ts}.png  

Capture Failure Screenshot
    ${ts}=    Get Time    result_format=%Y-%m-%d_%H-%M-%S
    Capture Page Screenshot    ${OUTPUT DIR}/screenshots/${TEST NAME}_FAIL_${ts}.png

Click Logout Button
    Wait Until Element Is Visible    css:a.button.secondary.radius    10s
    Click Element                    css:a.button.secondary.radius            

Verify that users can login successfully
    Wait Until Page Contains   You logged into a secure area!    10s
    Page Should Contain        You logged into a secure area!

Verify that users can logout successfully
    Wait Until Page Contains  You logged out of the secure area!    10s
    Page Should Contain       You logged out of the secure area!

Verify that users can login unsuccessfully when they input a correct username but wrong password
    Wait Until Page Contains  Your password is invalid!    10s
    Page Should Contain       Your password is invalid!

Verify that users can login unsuccessfully when they input a username that did not exist
    Wait Until Page Contains  Your username is invalid!    10s
    Page Should Contain       Your username is invalid!    