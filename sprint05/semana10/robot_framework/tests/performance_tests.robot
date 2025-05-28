*** Settings ***
Documentation     Testes de performance básicos para a API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      60 seconds
Library           DateTime

*** Test Cases ***
Deve Verificar Tempo De Resposta Para Buscar Reservas
    [Documentation]    Verifica se o tempo de resposta para buscar reservas está dentro do limite aceitável
    [Tags]    booking    get    performance
    ${start_time}=    Get Current Date
    ${res}=    Buscar Reservas
    ${end_time}=    Get Current Date
    ${response_time}=    Subtract Date From Date    ${end_time}    ${start_time}
    Should Be True    ${response_time} < 2.0
    Log To Console    Tempo de resposta para buscar reservas: ${response_time} segundos

Deve Verificar Tempo De Resposta Para Criar Reserva
    [Documentation]    Verifica se o tempo de resposta para criar uma reserva está dentro do limite aceitável
    [Tags]    booking    post    performance
    ${start_time}=    Get Current Date
    ${res}=    Criar Reserva
    ${end_time}=    Get Current Date
    ${response_time}=    Subtract Date From Date    ${end_time}    ${start_time}
    Should Be True    ${response_time} < 3.0
    Log To Console    Tempo de resposta para criar reserva: ${response_time} segundos

Deve Verificar Tempo De Resposta Para Autenticação
    [Documentation]    Verifica se o tempo de resposta para autenticação está dentro do limite aceitável
    [Tags]    auth    performance
    ${start_time}=    Get Current Date
    ${token}=    Obter Token
    ${end_time}=    Get Current Date
    ${response_time}=    Subtract Date From Date    ${end_time}    ${start_time}
    Should Be True    ${response_time} < 2.0
    Log To Console    Tempo de resposta para autenticação: ${response_time} segundos