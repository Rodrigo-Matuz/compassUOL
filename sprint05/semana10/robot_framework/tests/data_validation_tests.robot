*** Settings ***
Documentation     Testes para validação de dados retornados pela API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Validar Esquema De Resposta Da Reserva
    [Documentation]    Verifica se a resposta da API segue o esquema esperado
    [Tags]    booking    get    schema
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    
    # Validação do esquema
    Dictionary Should Contain Key    ${res}    firstname
    Dictionary Should Contain Key    ${res}    lastname
    Dictionary Should Contain Key    ${res}    totalprice
    Dictionary Should Contain Key    ${res}    depositpaid
    Dictionary Should Contain Key    ${res}    bookingdates
    Dictionary Should Contain Key    ${res['bookingdates']}    checkin
    Dictionary Should Contain Key    ${res['bookingdates']}    checkout
    Dictionary Should Contain Key    ${res}    additionalneeds

*** Keywords ***
# Helper
Should Be Boolean
    [Arguments]    ${value}    ${msg}=O valor não é booleano
    ${is_boolean}=    Evaluate    isinstance(${value}, bool)
    Should Be True    ${is_boolean}    ${msg}


Deve Validar Tipos De Dados Da Reserva
    [Documentation]    Verifica se os tipos de dados retornados estão corretos
    [Tags]    booking    get    schema
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    
    # Validação dos tipos de dados
    Should Be String    ${res['firstname']}
    Should Be String    ${res['lastname']}
    ${is_number}=    Evaluate    isinstance(${res['totalprice']}, int) or isinstance(${res['totalprice']}, float)
    Should Be True    ${is_number}
    Should Be Boolean    ${res['depositpaid']}
    Should Be String    ${res['bookingdates']['checkin']}
    Should Be String    ${res['bookingdates']['checkout']}
    Should Be String    ${res['additionalneeds']}

Deve Validar Formato De Data
    [Documentation]    Verifica se as datas estão no formato correto (YYYY-MM-DD)
    [Tags]    booking    get    schema
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    
    # Validação do formato de data
    ${checkin_match}=    Evaluate    re.match(r'^\\d{4}-\\d{2}-\\d{2}$', '${res['bookingdates']['checkin']}') is not None    re
    Should Be True    ${checkin_match}    Formato de data de check-in inválido: ${res['bookingdates']['checkin']}
    
    ${checkout_match}=    Evaluate    re.match(r'^\\d{4}-\\d{2}-\\d{2}$', '${res['bookingdates']['checkout']}') is not None    re
    Should Be True    ${checkout_match}    Formato de data de check-out inválido: ${res['bookingdates']['checkout']}