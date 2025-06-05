*** Settings ***
Library        String
Library        RequestsLibrary
Library        FakerLibrary
Resource       ../variables/serverest_vars.robot


*** Keywords ***
Gerar Email Aleatório Válido
    ${numero}=    Generate Random String    4    [NUMBERS]
    ${email}=    Set Variable    rodrigocompass${numero}@compasso.com
    RETURN    ${email}

Gerar Email Aleatório Inválido
    [Arguments]    ${dominio}
    ${numero}=    Generate Random String    4    [NUMBERS]
    ${email}=    Set Variable    rodrigocompass${numero}@${dominio}
    RETURN    ${email}

Criar e Iniciar Sessão API
    [Documentation]    Cria a sessão de API com headers padrão
    Create Session
    ...    api-session
    ...    ${BASE_URL}
    ...    headers=${HEADERS}

Gerar Nome Aleatório Válido
    [Documentation]    Gera um nome aleatório usando FakerLibrary
    ${nome}=    FakerLibrary.Name
    RETURN    ${nome}

Gerar Senha Aleatória Válida
    [Documentation]    Gera uma senha aleatória usando FakerLibrary
    ${senha}=    FakerLibrary.Password    length=8    special_chars=True    digits=True    upper_case=True    lower_case=True
    RETURN    ${senha}