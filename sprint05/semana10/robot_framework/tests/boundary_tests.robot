*** Settings ***
Documentation     Testes de valores limite para a API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Criar Reserva Com Preço Mínimo
    [Documentation]    Verifica se é possível criar uma reserva com preço mínimo (0)
    [Tags]    booking    post    boundary
    ${res}=    Criar Reserva    totalprice=0
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    ${booking_id}=    Set Variable    ${res['bookingid']}
    ${reserva}=    Buscar Reserva Por ID    ${booking_id}
    Should Be Equal As Numbers    ${reserva['totalprice']}    0

Deve Criar Reserva Com Preço Muito Alto
    [Documentation]    Verifica se é possível criar uma reserva com preço muito alto
    [Tags]    booking    post    boundary
    ${res}=    Criar Reserva    totalprice=999999
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    ${booking_id}=    Set Variable    ${res['bookingid']}
    ${reserva}=    Buscar Reserva Por ID    ${booking_id}
    Should Be Equal As Numbers    ${reserva['totalprice']}    999999

Deve Criar Reserva Com Nome Muito Longo
    [Documentation]    Verifica se é possível criar uma reserva com nome muito longo
    [Tags]    booking    post    boundary
    ${nome_longo}=    Gerar String Aleatória    100
    ${res}=    Criar Reserva    firstname=${nome_longo}
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    ${booking_id}=    Set Variable    ${res['bookingid']}
    ${reserva}=    Buscar Reserva Por ID    ${booking_id}
    Should Be Equal    ${reserva['firstname']}    ${nome_longo}

Deve Criar Reserva Com Data Muito Distante
    [Documentation]    Verifica se é possível criar uma reserva com data muito distante no futuro
    [Tags]    booking    post    boundary
    ${res}=    Criar Reserva    checkin=2050-01-01    checkout=2050-12-31
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    ${booking_id}=    Set Variable    ${res['bookingid']}
    ${reserva}=    Buscar Reserva Por ID    ${booking_id}
    Should Be Equal    ${reserva['bookingdates']['checkin']}    2050-01-01
    Should Be Equal    ${reserva['bookingdates']['checkout']}    2050-12-31