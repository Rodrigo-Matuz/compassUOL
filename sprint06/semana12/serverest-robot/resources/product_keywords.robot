*** Settings ***
Library        RequestsLibrary
Library        String
Library        FakerLibrary
Resource       ../variables/serverest_vars.robot
Resource       ./common.robot
Resource       ./user_keywords.robot

*** Keywords ***
Cadastrar Produto
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}    ${token}=${TOKEN}
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Authorization=${token}
    
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    
    ${response}=    POST On Session
    ...    alias=api-session
    ...    url=${PRODUCTS_ENDPOINT}
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any
    RETURN    ${response}

Cadastrar Produto Com Sucesso
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}    ${token}=${TOKEN}
    ${response}=    Cadastrar Produto    ${nome}    ${preco}    ${descricao}    ${quantidade}    ${token}
    Should Be Equal As Integers    ${response.status_code}    201
    RETURN    ${response}

Gerar Nome Produto Aleatório
    ${numero}=    Generate Random String    4    [NUMBERS]
    ${nome}=    Set Variable    Produto${numero}
    RETURN    ${nome}

Gerar Descrição Produto Aleatória
    ${numero}=    Generate Random String    4    [NUMBERS]
    ${descricao}=    Set Variable    Produto de Teste ${numero}
    RETURN    ${descricao}

Obter Token De Autenticação
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    Cadastrar Usuário
    ...    ${nome}
    ...    ${email}
    ...    ${senha}
    ...    administrador=true
    ${body}=    Create Dictionary
    ...    email=${email}
    ...    password=${senha}
    ${response}=    POST On Session
    ...    alias=api-session
    ...    url=${AUTH_ENDPOINT}
    ...    json=${body}
    ...    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}