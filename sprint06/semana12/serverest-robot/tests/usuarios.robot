*** Settings ***
Documentation    Testes para cadastro de usuários na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Library          RequestsLibrary
Suite Setup      Criar e Iniciar Sessão API

*** Test Cases ***
Cadastro De Usuário Válido
    [Documentation]    Verifica que é possível cadastrar um novo usuário com dados válidos
    [Tags]    post    usuarios    cadastro    positive
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário Com Sucesso
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Log To Console    Cadastro realizado com ID: ${response.json()['_id']}

Cadastro De Usuário Com Email Ja Existente
    [Documentation]    Verifica que não é possível cadastrar usuário com email duplicado
    [Tags]    post    usuarios    cadastro    negative    duplicado
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
    [Documentation]    Verifica validação de tamanho mínimo para senha
    [Tags]    post    usuarios    cadastro    validation    senha
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    1
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Senha Muito Longa
    [Documentation]    Verifica validação de tamanho máximo para senha
    [Tags]    post    usuarios    cadastro    validation    senha
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    12345678901234567890
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Email De Dominio Bloqueado Gmail
    [Documentation]    Verifica rejeição de cadastro com domínio @gmail.com
    [Tags]    post    usuarios    cadastro    validation    email
    ${email}=    Gerar Email Aleatório Inválido    gmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Email De Dominio Bloqueado Hotmail
    [Documentation]    Verifica rejeição de cadastro com domínio @hotmail.com
    [Tags]    post    usuarios    cadastro    validation    email
    ${email}=    Gerar Email Aleatório Inválido    hotmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro Com Campo Obrigatório Faltando
    [Documentation]    Verifica validação quando campo obrigatório (senha) é omitido
    [Tags]    post    usuarios    cadastro    validation    obrigatorio
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400
