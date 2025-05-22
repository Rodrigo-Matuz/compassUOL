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


Criar Reserva
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${bookingdates}=    
    ...    Create Dictionary    
    ...    checkin=2025-11-01    
    ...    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Rodrigo
    ...    lastname=Santos
    ...    totalprice=150
    ...    depositpaid=True
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Breakfast
    ${response}=    
    ...    POST On Session    
    ...    alias=restful-booker    
    ...    url=${BOOKING_ENDPOINT}    
    ...    json=${payload}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()}


Atualizar Reserva
    [Arguments]    ${booking_id}    ${token}
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${headers}=    
    ...    Create Dictionary    
    ...    Cookie=token=${token}
    ${bookingdates}=    
    ...    Create Dictionary    
    ...    checkin=2025-11-01    
    ...    checkout=2026-01-01
    ${payload}=    
    ...    Create Dictionary
    ...    firstname=Rodrigo
    ...    lastname=Lima
    ...    totalprice=200
    ...    depositpaid=False
    ...    bookingdates=${bookingdates}
    ${response}=    
    ...    PUT On Session
    ...    alias=restful-booker    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()}


Atualizar Parcial Reserva
    [Arguments]    ${booking_id}    ${token}
    Create Session    
    ...    alias=restful-booker    
    ...    url=${BASE_URL}
    ${headers}=    
    ...    Create Dictionary    
    ...    Cookie=token=${token}
    ${payload}=    
    ...    Create Dictionary    
    ...    firstname=Updated    
    ...    lastname=User
    ${response}=    
    ...    PATCH On Session
    ...    alias=restful-booker
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    Should Be Equal As Integers    
    ...    ${response.status_code}    200
    RETURN    ${response.json()}

