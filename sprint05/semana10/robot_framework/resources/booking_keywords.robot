*** Settings ***
Documentation     Keywords for interacting with the Restful-Booker API
Library           RequestsLibrary
Resource          ../variables/booking_vars.robot
Resource          common.robot

*** Keywords ***
Obter Token
    [Documentation]    Obtém um token de autenticação para operações que requerem autorização
    Criar Sessão API    ${BASE_URL}
    ${payload}=    Create Dictionary    username=${USER_USERNAME}    password=${USER_PASSWORD}
    ${response}=    POST On Session    
    ...    alias=api-session    
    ...    url=${AUTH_ENDPOINT}    
    ...    json=${payload}
    Verificar Status Code    ${response}    200
    RETURN    ${response.json()['token']}

Buscar Reservas
    [Documentation]    Busca todas as reservas disponíveis
    [Arguments]    ${filtro}=${EMPTY}
    Criar Sessão API    ${BASE_URL}
    ${params}=    Run Keyword If    '${filtro}' != '${EMPTY}'    Create Dictionary    ${filtro}    ELSE    Create Dictionary
    ${response}=    GET On Session    
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}    
    ...    params=${params}
    Verificar Status Code    ${response}    200
    RETURN    ${response.json()}

Buscar Reserva Por ID
    [Documentation]    Busca uma reserva específica pelo ID
    [Arguments]    ${booking_id}
    Criar Sessão API    ${BASE_URL}
    ${response}=    GET On Session    
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    Verificar Status Code    ${response}    200
    RETURN    ${response.json()}

Criar Reserva
    [Documentation]    Cria uma nova reserva com os dados fornecidos
    [Arguments]    ${firstname}=Rodrigo    ${lastname}=Santos    ${totalprice}=150    
    ...    ${depositpaid}=${TRUE}    ${checkin}=2025-11-01    ${checkout}=2026-01-01    
    ...    ${additionalneeds}=Breakfast
    Criar Sessão API    ${BASE_URL}
    ${bookingdates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=${additionalneeds}
    ${response}=    POST On Session    
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}    
    ...    json=${payload}
    Verificar Status Code    ${response}    200
    Log Resposta API    ${response}
    RETURN    ${response.json()}

Atualizar Reserva
    [Documentation]    Atualiza completamente uma reserva existente
    [Arguments]    ${booking_id}    ${token}    ${firstname}=Rodrigo    ${lastname}=Lima    
    ...    ${totalprice}=200    ${depositpaid}=${FALSE}    ${checkin}=2025-11-01    
    ...    ${checkout}=2026-01-01    ${additionalneeds}=Breakfast
    Criar Sessão API    ${BASE_URL}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${bookingdates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=${additionalneeds}
    ${response}=    PUT On Session
    ...    alias=api-session    
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    Verificar Status Code    ${response}    200
    RETURN    ${response.json()}

Atualizar Parcial Reserva
    [Documentation]    Atualiza parcialmente uma reserva existente
    [Arguments]    ${booking_id}    ${token}    ${firstname}=Updated    ${lastname}=User
    Criar Sessão API    ${BASE_URL}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${payload}=    Create Dictionary    firstname=${firstname}    lastname=${lastname}
    ${response}=    PATCH On Session
    ...    alias=api-session
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    ...    json=${payload}
    Verificar Status Code    ${response}    200
    RETURN    ${response.json()}

Deletar Reserva
    [Documentation]    Remove uma reserva existente
    [Arguments]    ${booking_id}    ${token}
    Criar Sessão API    ${BASE_URL}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE On Session
    ...    alias=api-session
    ...    url=${BOOKING_ENDPOINT}/${booking_id}
    ...    headers=${headers}
    Verificar Status Code    ${response}    201

Verificar Healthcheck
    [Documentation]    Verifica se a API está funcionando corretamente
    Criar Sessão API    ${BASE_URL}
    ${response}=    GET On Session    
    ...    alias=api-session    
    ...    url=${PING_ENDPOINT}
    Verificar Status Code    ${response}    201