*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://reqres.in
${API_KEY}     reqres-free-v1      #ต้องเปลี่ยน key เป็นตัวที่ไม่ฟรี

*** Keywords ***
Create API Session
    [Arguments]    ${base_url}    ${api_key}
    ${headers}=    Create Dictionary    x-api-key=${api_key}
    Create Session    api    ${base_url}    headers=${headers}    verify=${False}    disable_warnings=${True}

Log Full Response
    [Arguments]    ${resp}
    Log    STATUS: ${resp.status_code}
    Log    HEADERS: ${resp.headers}
    Log    BODY: ${resp.text}

Verify get user profile api will return correct data
    [Arguments]    ${data}
    Should Be Equal As Integers    ${data['id']}       12
    Should Be Equal    ${data['email']}                rachel.howell@reqres.in
    Should Be Equal    ${data['first_name']}           Rachel
    Should Be Equal    ${data['last_name']}            Howell
    Should Be Equal    ${data['avatar']}               https://reqres.in/img/faces/12-image.jpg


