*** Settings ***
Library        RequestsLibrary
Resource       ../variables/serverest_vars.robot

*** Keywords ***
Cadastrar Usuário
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=${administrador}
    
    ${response}=    POST On Session
    ...    alias=api-session
    ...    url=${USERS_ENDPOINT}
    ...    json=${body}
    ...    expected_status=any
    RETURN    ${response}

Cadastrar Usuário Com Sucesso
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    ${response}=    Cadastrar Usuário    ${nome}    ${email}    ${password}    ${administrador}
    Should Be Equal As Integers    ${response.status_code}    201
    RETURN    ${response}

Cadastrar Usuário Com Email Já Existente
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    ${response}=    Cadastrar Usuário    ${nome}    ${email}    ${password}    ${administrador}
    Should Be Equal As Integers    ${response.status_code}    400
    RETURN    ${response}
