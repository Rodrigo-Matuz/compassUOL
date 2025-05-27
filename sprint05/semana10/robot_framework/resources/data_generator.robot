*** Settings ***
Documentation     Keywords for generating test data using Faker library
Library           FakerLibrary
Library           DateTime
Library           String
Library           Collections

*** Keywords ***
Gerar Nome
    [Documentation]    Gera um nome aleatório usando Faker
    ${nome}=    FakerLibrary.First Name
    RETURN    ${nome}

Gerar Sobrenome
    [Documentation]    Gera um sobrenome aleatório usando Faker
    ${sobrenome}=    FakerLibrary.Last Name
    RETURN    ${sobrenome}

Gerar Preço
    [Documentation]    Gera um valor de preço aleatório
    [Arguments]    ${min}=50    ${max}=1000
    ${preco}=    FakerLibrary.Random Int    min=${min}    max=${max}
    RETURN    ${preco}

Gerar Data Futura
    [Documentation]    Gera uma data futura para check-in
    [Arguments]    ${dias_minimo}=30    ${dias_maximo}=365
    ${dias}=    FakerLibrary.Random Int    min=${dias_minimo}    max=${dias_maximo}
    ${data}=    Get Current Date    result_format=%Y-%m-%d    increment=${dias} days
    RETURN    ${data}

Gerar Data Checkout
    [Documentation]    Gera uma data de checkout após a data de check-in
    [Arguments]    ${checkin_date}    ${estadia_minima}=1    ${estadia_maxima}=30
    ${dias_estadia}=    FakerLibrary.Random Int    min=${estadia_minima}    max=${estadia_maxima}
    ${checkout_date}=    Add Time To Date    ${checkin_date}    ${dias_estadia} days    result_format=%Y-%m-%d
    RETURN    ${checkout_date}

Gerar Necessidades Adicionais
    [Documentation]    Gera uma necessidade adicional aleatória
    ${opcoes}=    Create List    Breakfast    Airport Transfer    Extra Bed    Late Check-out    Early Check-in    Spa Access    Room Service
    ${indice}=    FakerLibrary.Random Int    min=0    max=6
    ${necessidade}=    Get From List    ${opcoes}    ${indice}
    RETURN    ${necessidade}

Gerar Dados Completos Reserva
    [Documentation]    Gera todos os dados necessários para uma reserva
    ${firstname}=    Gerar Nome
    ${lastname}=    Gerar Sobrenome
    ${totalprice}=    Gerar Preço
    ${depositpaid}=    FakerLibrary.Boolean
    ${checkin}=    Gerar Data Futura
    ${checkout}=    Gerar Data Checkout    ${checkin}
    ${additionalneeds}=    Gerar Necessidades Adicionais
    
    ${dados}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    checkin=${checkin}
    ...    checkout=${checkout}
    ...    additionalneeds=${additionalneeds}
    
    RETURN    ${dados}

Gerar Email
    [Documentation]    Gera um email aleatório
    ${email}=    FakerLibrary.Email
    RETURN    ${email}

Gerar Telefone
    [Documentation]    Gera um número de telefone aleatório
    ${telefone}=    FakerLibrary.Phone Number
    RETURN    ${telefone}

Gerar Endereço
    [Documentation]    Gera um endereço aleatório
    ${rua}=    FakerLibrary.Street Address
    ${cidade}=    FakerLibrary.City
    ${estado}=    FakerLibrary.State
    ${cep}=    FakerLibrary.Postcode
    ${pais}=    FakerLibrary.Country
    
    ${endereco}=    Create Dictionary
    ...    street=${rua}
    ...    city=${cidade}
    ...    state=${estado}
    ...    zipcode=${cep}
    ...    country=${pais}
    
    RETURN    ${endereco}
