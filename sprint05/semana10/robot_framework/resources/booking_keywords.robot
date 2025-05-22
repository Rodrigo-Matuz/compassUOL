*** Settings ***
Library       RequestsLibrary
Resource      ../variables/booking_vars.robot

*** Keywords ***
Obter Token
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${payload}=    
    ...    Create Dictionary    
    ...    username=${USER_USERNAME}    
    ...    password=${USER_PASSWORD}
    ${response}=    
    ...    POST On Session    
    ...    alias=restful-booker    
    ...    url=${AUTH_ENDPOINT}    
    ...    json=${payload}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()['token']}
