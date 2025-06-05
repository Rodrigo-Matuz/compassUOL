*** Settings ***
Documentation    Testes para cadastro e gerenciamento de produtos na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Resource         ../resources/login_keywords.robot
Resource         ../resources/product_keywords.robot
Library          RequestsLibrary
Library          String
Suite Setup      Configurar Teste

*** Keywords ***
Configurar Teste
    Criar e Iniciar Sessão API
    ${token}=    Obter Token De Autenticação
    Set Suite Variable    ${TOKEN}    ${token}

*** Test Cases ***
Cadastro De Produto Válido
    [Documentation]    Verifica que é possível cadastrar um novo produto com dados válidos
    [Tags]    post    produtos    cadastro    positive
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto Com Sucesso
    ...    ${nome}
    ...    100
    ...    ${descricao}
    ...    100
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201
    Log To Console    Produto cadastrado com ID: ${response.json()['_id']}

Cadastro De Produto Sem Token
    [Documentation]    Verifica que não é possível cadastrar produto sem autenticação
    [Tags]    post    produtos    cadastro    negative    autenticacao
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto
    ...    ${nome}
    ...    100
    ...    ${descricao}
    ...    100
    ...    ${EMPTY}
    Should Be Equal As Integers    ${response.status_code}    401

Cadastro De Produto Com Nome Já Existente
    [Documentation]    Verifica que não é possível cadastrar produto com nome duplicado
    [Tags]    post    produtos    cadastro    negative    duplicado
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    
    # Primeiro cadastro - sucesso
    Cadastrar Produto Com Sucesso
    ...    ${nome}
    ...    100
    ...    ${descricao}
    ...    100
    ...    ${TOKEN}
    
    # Segundo cadastro - falha (nome duplicado)
    ${response}=    Cadastrar Produto
    ...    ${nome}
    ...    200
    ...    Nova descrição
    ...    50
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro De Produto Com Quantidade Mínima
    [Documentation]    Verifica que é possível cadastrar produto com quantidade mínima (1)
    [Tags]    post    produtos    cadastro    positive    quantidade
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto Com Sucesso
    ...    ${nome}
    ...    100
    ...    ${descricao}
    ...    1
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    201

Cadastro De Produto Com Quantidade Zero
    [Documentation]    Verifica validação quando quantidade é zero
    [Tags]    post    produtos    cadastro    validation    quantidade
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto
    ...    ${nome}
    ...    100
    ...    ${descricao}
    ...    0
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro De Produto Com Preço Inválido
    [Documentation]    Verifica validação quando preço não é numérico
    [Tags]    post    produtos    cadastro    validation    preco
    ${nome}=    Gerar Nome Produto Aleatório
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto
    ...    ${nome}
    ...    abc
    ...    ${descricao}
    ...    10
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    400

Cadastro De Produto Com Campo Obrigatório Faltando
    [Documentation]    Verifica validação quando campo obrigatório (nome) é omitido
    [Tags]    post    produtos    cadastro    validation    obrigatorio
    ${descricao}=    Gerar Descrição Produto Aleatória
    ${response}=    Cadastrar Produto
    ...    ${EMPTY}
    ...    100
    ...    ${descricao}
    ...    10
    ...    ${TOKEN}
    Should Be Equal As Integers    ${response.status_code}    400