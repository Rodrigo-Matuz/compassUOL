*** Settings ***
Documentation     Testes específicos para autenticação na API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Obter Token Com Credenciais Válidas
    [Documentation]    Verifica se é possível obter um token com credenciais válidas
    [Tags]    auth    smoke
    ${token}=    Obter Token
    Should Not Be Empty    ${token}
    Log To Console    Token obtido: ${token}

Deve Falhar Ao Obter Token Com Credenciais Inválidas
    [Documentation]    Verifica se a API rejeita credenciais inválidas
    [Tags]    auth    negative
    Criar Sessão API    ${BASE_URL}
    ${payload}=    Create Dictionary    username=invalid    password=invalid
    Run Keyword And Expect Error    *    
    ...    POST On Session    
    ...    alias=api-session    
    ...    url=${AUTH_ENDPOINT}    
    ...    json=${payload}
    ...    expected_status=200