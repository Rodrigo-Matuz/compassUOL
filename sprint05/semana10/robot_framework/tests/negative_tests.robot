*** Settings ***
Documentation     Testes negativos para validar o comportamento da API em cenários de erro
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Falhar Ao Buscar Reserva Com ID Inválido
    [Documentation]    Verifica se a API retorna erro ao buscar uma reserva com ID inválido
    [Tags]    booking    get    negative
    Criar Sessão API    ${BASE_URL}
    Run Keyword And Expect Error    *    
    ...    GET On Session    
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/999999999    
    ...    expected_status=200

Deve Falhar Ao Atualizar Reserva Sem Token
    [Documentation]    Verifica se a API rejeita atualização sem token de autenticação
    [Tags]    booking    put    negative
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    ${bookingdates}=    Create Dictionary    checkin=2025-11-01    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Falha
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    Run Keyword And Expect Error    *    
    ...    PUT On Session
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    json=${payload}
    ...    expected_status=200

Deve Falhar Ao Criar Reserva Com Dados Inválidos
    [Documentation]    Verifica se a API rejeita criação de reserva com dados inválidos
    [Tags]    booking    post    negative
    Criar Sessão API    ${BASE_URL}
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Falha
    # Faltando campos obrigatórios como totalprice, depositpaid e bookingdates
    Run Keyword And Expect Error    *    
    ...    POST On Session    
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}    
    ...    json=${payload}
    ...    expected_status=200

Deve Falhar Ao Deletar Reserva Sem Token
    [Documentation]    Verifica se a API rejeita deleção sem token de autenticação
    [Tags]    booking    delete    negative
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    Run Keyword And Expect Error    *    
    ...    DELETE On Session
    ...    alias=api-session
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    expected_status=201

Deve Falhar Ao Atualizar Reserva Com Token Inválido
    [Documentation]    Verifica se a API rejeita atualização com token inválido
    [Tags]    booking    put    negative
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    Criar Sessão API    ${BASE_URL}
    ${headers}=    Create Dictionary    Cookie=token=invalid_token
    ${bookingdates}=    Create Dictionary    checkin=2025-11-01    checkout=2026-01-01
    ${payload}=    Create Dictionary
    ...    firstname=Teste
    ...    lastname=Falha
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