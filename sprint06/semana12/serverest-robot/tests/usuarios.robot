*** Settings ***
Documentation    Testes para operações de usuários na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Resource         ../resources/product_keywords.robot
Library          RequestsLibrary
Library          Collections
Suite Setup      Criar e Iniciar Sessão API

*** Test Cases ***
# POST - Testes de Cadastro
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

# GET - Testes de Consulta
Listar Todos Os Usuários
    [Documentation]    Verifica que é possível listar todos os usuários cadastrados
    [Tags]    get    usuarios    positive
    ${response}=    Listar Usuários
    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()['usuarios']}
    Log To Console    Total de usuários: ${response.json()['quantidade']}

Buscar Usuário Por ID
    [Documentation]    Verifica que é possível buscar um usuário específico por ID
    [Tags]    get    usuarios    positive
    
    # Cadastra um usuário para garantir que existe
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    false
    ${id}=    Set Variable    ${response.json()['_id']}
    
    # Busca o usuário pelo ID
    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()['nome']}    ${nome}
    Should Be Equal    ${response.json()['email']}    ${email}
    Should Be Equal    ${response.json()['_id']}    ${id}

Buscar Usuário Com ID Inexistente
    [Documentation]    Verifica o comportamento ao buscar um usuário com ID inexistente
    [Tags]    get    usuarios    negative
    ${id_inexistente}=    Set Variable    abc123inexistente
    ${response}=    Obter Usuário Por ID    ${id_inexistente}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    não encontrado

Filtrar Usuários Por Query Params
    [Documentation]    Verifica a filtragem de usuários por parâmetros de consulta
    [Tags]    get    usuarios    positive    filtro
    
    # Cadastra um usuário administrador para garantir que existe
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    true
    
    # Filtra usuários administradores
    ${params}=    Create Dictionary    administrador=true
    ${response}=    GET On Session    api-session    ${USERS_ENDPOINT}    params=${params}
    Should Be Equal As Integers    ${response.status_code}    200
    
    # Verifica que todos os usuários retornados são administradores
    ${usuarios}=    Set Variable    ${response.json()['usuarios']}
    FOR    ${usuario}    IN    @{usuarios}
        Should Be Equal    ${usuario['administrador']}    true
    END

# PUT - Testes de Atualização
Atualizar Dados De Usuário Com Sucesso
    [Documentation]    Verifica que é possível atualizar os dados de um usuário existente
    [Tags]    put    usuarios    positive
    
    # Cadastra um usuário para garantir que existe
    ${nome_original}=    Gerar Nome Aleatório Válido
    ${email_original}=    Gerar Email Aleatório Válido
    ${senha_original}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome_original}    ${email_original}    ${senha_original}    false
    ${id}=    Set Variable    ${response.json()['_id']}
    
    # Obtém token de autenticação
    ${token}=    Obter Token De Autenticação
    
    # Atualiza os dados do usuário
    ${novo_nome}=    Gerar Nome Aleatório Válido
    ${novo_email}=    Gerar Email Aleatório Válido
    ${nova_senha}=    Gerar Senha Aleatória Válida
    ${response}=    Atualizar Usuário    ${id}    ${novo_nome}    ${novo_email}    ${nova_senha}    false    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()['message']}    sucesso
    
    # Verifica se os dados foram atualizados
    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal    ${response.json()['nome']}    ${novo_nome}
    Should Be Equal    ${response.json()['email']}    ${novo_email}

Atualizar Usuário Com Email Já Existente
    [Documentation]    Verifica que não é possível atualizar um usuário com email já utilizado por outro
    [Tags]    put    usuarios    negative    duplicado
    
    # Cadastra dois usuários
    ${nome1}=    Gerar Nome Aleatório Válido
    ${email1}=    Gerar Email Aleatório Válido
    ${senha1}=    Gerar Senha Aleatória Válida
    ${response1}=    Cadastrar Usuário Com Sucesso    ${nome1}    ${email1}    ${senha1}    false
    ${id1}=    Set Variable    ${response1.json()['_id']}
    
    ${nome2}=    Gerar Nome Aleatório Válido
    ${email2}=    Gerar Email Aleatório Válido
    ${senha2}=    Gerar Senha Aleatória Válida
    Cadastrar Usuário Com Sucesso    ${nome2}    ${email2}    ${senha2}    false
    
    # Obtém token de autenticação
    ${token}=    Obter Token De Autenticação
    
    # Tenta atualizar o primeiro usuário com o email do segundo
    ${response}=    Atualizar Usuário    ${id1}    ${nome1}    ${email2}    ${senha1}    false    ${token}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    já está sendo usado

Atualizar Usuário Para Administrador
    [Documentation]    Verifica que é possível alterar o status de administrador de um usuário
    [Tags]    put    usuarios    positive    administrador
    
    # Cadastra um usuário não administrador
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    false
    ${id}=    Set Variable    ${response.json()['_id']}
    
    # Obtém token de autenticação
    ${token}=    Obter Token De Autenticação
    
    # Atualiza para administrador
    ${response}=    Atualizar Usuário    ${id}    ${nome}    ${email}    ${senha}    true    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    
    # Verifica se o status foi alterado
    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal    ${response.json()['administrador']}    true

# DELETE - Testes de Exclusão
Excluir Usuário Com Sucesso
    [Documentation]    Verifica que é possível excluir um usuário existente
    [Tags]    delete    usuarios    positive
    
    # Cadastra um usuário para ser excluído
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    false
    ${id}=    Set Variable    ${response.json()['_id']}
    
    # Obtém token de autenticação
    ${token}=    Obter Token De Autenticação
    
    # Exclui o usuário
    ${response}=    Excluir Usuário    ${id}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()['message']}    excluído com sucesso
    
    # Verifica que o usuário não existe mais
    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    não encontrado

Excluir Usuário Inexistente
    [Documentation]    Verifica o comportamento ao tentar excluir um usuário inexistente
    [Tags]    delete    usuarios    negative
    
    # Obtém token de autenticação
    ${token}=    Obter Token De Autenticação
    
    # Tenta excluir um usuário com ID inexistente
    ${id_inexistente}=    Set Variable    abc123inexistente
    ${response}=    Excluir Usuário    ${id_inexistente}    ${token}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    não encontrado

Excluir Usuário Sem Autenticação
    [Documentation]    Verifica que não é possível excluir um usuário sem token de autenticação
    [Tags]    delete    usuarios    negative    autenticacao
    
    # Cadastra um usuário para tentar excluir
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    false
    ${id}=    Set Variable    ${response.json()['_id']}
    
    # Tenta excluir sem token
    ${response}=    Excluir Usuário    ${id}    ${EMPTY}
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain    ${response.json()['message']}    Token