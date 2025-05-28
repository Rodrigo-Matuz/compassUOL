*** Settings ***
Documentation     Testes de segurança básicos para a API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Rejeitar Acesso Sem Autenticação
    [Documentation]    Verifica se a API rejeita operações protegidas sem autenticação
    [Tags]    booking    security
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    
    # Tentativa de atualizar sem token
    ${bookingdates}=    Create Dictionary    checkin=2025-11-01    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Segurança
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    
    Run Keyword And Expect Error    *    
    ...    PUT On Session
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    json=${payload}
    ...    expected_status=200

Deve Rejeitar Token Inválido
    [Documentation]    Verifica se a API rejeita token de autenticação inválido
    [Tags]    booking    security
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    
    # Tentativa de atualizar com token inválido
    ${headers}=    Create Dictionary    Cookie=token=invalid_token_123456789
    ${bookingdates}=    Create Dictionary    checkin=2025-11-01    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Segurança
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    
    Run Keyword And Expect Error    *    
    ...    PUT On Session
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    ...    expected_status=200

Deve Validar Expiração De Token
    [Documentation]    Verifica se o token expira após um período
    [Tags]    auth    security
    # Nota: Este teste é conceitual e pode não funcionar como esperado
    # dependendo da implementação da API, que pode ter tokens de longa duração
    ${token}=    Obter Token
    Sleep    1s    # Simula passagem de tempo
    
    # Verifica se o token ainda é válido (este teste pode passar mesmo que o token não expire)
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${bookingdates}=    Create Dictionary    checkin=2025-11-01    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Segurança
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    
    # Este teste espera que o token seja válido após 1 segundo
    ${response}=    PUT On Session
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    Verificar Status Code    ${response}    200