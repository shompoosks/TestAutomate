*** Settings ***
Resource   ../../resources/api_keywords.robot


*** Test Cases ***
Get user profile success
    Create API Session     https://reqres.in  reqres-free-v1
    ${resp}=    GET On Session    api    /api/users/1
    Log Full Response    ${resp}
    Should Be Equal As Integers    ${resp.status_code}    200

    ${json}=    Evaluate    $resp.json()
    ${data}=    Get From Dictionary    ${json}    data
    Log To Console    \nSTATUS: ${resp.status_code}\nBODY: ${data}
    Verify get user profile api will return correct data    ${data}

Get user profile but user not found
    Create API Session     https://reqres.in  reqres-free-v1
    ${resp}=    GET On Session    api    /api/users/1234    expected_status=404
    Log Full Response    ${resp}
    Log To Console    \nSTATUS: ${resp.status_code}\nBODY: ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    404
    Should Be Equal    ${resp.text}      {}