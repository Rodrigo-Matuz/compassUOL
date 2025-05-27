*** Settings ***
Documentation     Common keywords and utilities used across the test suite
Library           RequestsLibrary
Library           Collections

*** Keywords ***
Desabilitar Avisos SSL
    [Documentation]    Desativa os warnings de SSL que surgem quando o certificado não é verificado
    Evaluate    __import__('urllib3').disable_warnings()

Criar Sessão API
    [Documentation]    Cria uma sessão HTTP para a API
    [Arguments]    ${base_url}
    Create Session    alias=api-session    url=${base_url}    verify=False
    
Verificar Status Code
    [Documentation]    Verifica se o status code da resposta é o esperado
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    
Log Resposta API
    [Documentation]    Registra detalhes da resposta da API para depuração
    [Arguments]    ${response}
    Log    Status Code: ${response.status_code}
    Log    Response Headers: ${response.headers}
    Log    Response Body: ${response.text}

Verificar Se É Lista
    [Arguments]    ${valor}
    ${tipo}=    Evaluate    type(${valor}).__name__
    Should Be Equal    ${tipo}    list    O retorno não é uma lista. Tipo encontrado: ${tipo}