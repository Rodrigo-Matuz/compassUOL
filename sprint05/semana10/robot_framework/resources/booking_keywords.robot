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


Buscar Reservas
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${payload}=    
    ...    Create Dictionary    
    ...    firstname=${USER_USERNAME}
    ${response}=    
    ...    GET On Session    
    ...    alias=restful-booker    
    ...    url=${BOOKING_ENDPOINT}    
    ...    json=${payload}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()}


Buscar Reserva Por ID
    [Arguments]    ${booking_id}
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${response}=    
    ...    GET On Session    
    ...    alias=restful-booker    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()}

