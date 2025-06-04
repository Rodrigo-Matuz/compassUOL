*** Settings ***
Documentation    Testes para cadastro de usuários na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Library          RequestsLibrary
Suite Setup      Criar e Iniciar Sessão API

*** Test Cases ***
Cadastro De Usuário Válido
    [Documentation]    Valida cadastro de usuário com dados válidos
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário Com Sucesso
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Log To Console    Cadastro realizado com ID: ${response.json()['_id']}

Cadastro De Usuário Com Email Ja Existente
    [Documentation]    Valida tentativa de cadastro com email já existente
    ${email}=    Gerar Email Aleatório Válido

    # Primeiro cadastro - sucesso
    Cadastrar Usuário Com Sucesso
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true

    # Segundo cadastro - falha (email duplicado)
    Cadastrar Usuário Com Email Já Existente
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true

Cadastro Com Senha Muito Curta
    [Documentation]    Valida tentativa de cadastro com senha abaixo do limite permitido
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    1
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400


Cadastro Com Senha Muito Longa
    [Documentation]    Valida tentativa de cadastro com senha acima do limite permitido
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    12345678901234567890
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Email De Dominio Bloqueado Gmail
    [Documentation]    Valida tentativa de cadastro com email do domínio @gmail.com (bloqueado)
    ${email}=    Gerar Email Aleatório Inválido    gmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Email De Dominio Bloqueado Hotmail
    [Documentation]    Valida tentativa de cadastro com email do domínio @hotmail.com (bloqueado)
    ${email}=    Gerar Email Aleatório Inválido    hotmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Campo Obrigatório Faltando
    [Documentation]    Valida tentativa de cadastro com senha vazia (campo obrigatório)
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400
