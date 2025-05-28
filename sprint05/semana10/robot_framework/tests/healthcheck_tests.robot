*** Settings ***
Documentation     Testes específicos para verificação de saúde da API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Validar Healthcheck
    [Documentation]    Verifica se o serviço de healthcheck está funcionando
    [Tags]    healthcheck    smoke
    Verificar Healthcheck
    
Deve Verificar Disponibilidade Da API
    [Documentation]    Verifica se a API está respondendo corretamente
    [Tags]    healthcheck    smoke
    Criar Sessão API    ${BASE_URL}
    ${response}=    GET On Session    
    ...    alias=api-session    
    ...    url=/
    ...    expected_status=any
    Should Be True    ${response.status_code} < 500
    Log To Console    API está respondendo com status: ${response.status_code}