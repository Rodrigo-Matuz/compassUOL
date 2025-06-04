*** Settings ***
Documentation    Testes para cadastro de usuários na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Resource         ../resources/login_keywords.robot
Library          RequestsLibrary
Suite Setup      Criar e Iniciar Sessão API

*** Test Cases ***
Login Com Credenciais Válidas
    ${email}=    Gerar Email Aleatório Válido
    Cadastrar Usuário    
    ...    ${NOME_VALIDO}    
    ...    ${email}    
    ...    ${SENHA_VALIDA}    
    ...    administrador=true

    ${response}=    Realizar Login    
    ...    ${EMAIL_VALIDO}  
    ...    ${SENHA_INVALIDA}

    Should Be Equal As Integers    ${response.status_code}    401

Login Com Email Inválido
    ${response}=     Realizar Login    ${EMAIL_INVALIDO}    ${SENHA_VALIDA}
    Should Be Equal As Integers    ${response.status_code}    401

Login Com Senha em Branco
    ${response}=    Realizar Login    
    ...    ${EMAIL_VALIDO}    
    ...    
    Should Be Equal As Integers    ${response.status_code}    400

Login Com Email em Branco
    ${response}=    Realizar Login    
    ...     
    ...    ${SENHA_VALIDA}
    Should Be Equal As Integers    ${response.status_code}    400

Login Com Campos Vazios
    ${response}=    Realizar Login    
    ...      
    ...
    Should Be Equal As Integers    ${response.status_code}    400

Login Com Senha Incorreta
    ${email}=    Gerar Email Aleatório Válido
    Cadastrar Usuário    
    ...    ${NOME_VALIDO}    
    ...    ${email}    
    ...    ${SENHA_VALIDA}    
    ...    administrador=false

    ${response}=    Realizar Login    ${email}    senhaErrada123
    Should Be Equal As Integers    ${response.status_code}    401

Login Usuario Nao Cadastrado
    ${response}=    Realizar Login    naoexistente@teste.com    123456
    Should Be Equal As Integers    ${response.status_code}    401
