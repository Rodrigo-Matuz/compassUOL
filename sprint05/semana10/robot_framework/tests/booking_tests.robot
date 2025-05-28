*** Settings ***
Documentation     Testes de integração para a API Restful-Booker
Resource          ../resources/booking_keywords.robot
Resource          ../resources/common.robot
Test Setup        Desabilitar Avisos SSL
Test Timeout      30 seconds

*** Test Cases ***
Deve Buscar Todas Reservas
    [Documentation]    Verifica se é possível buscar todas as reservas
    [Tags]    booking    get    regression
    ${res}=    Buscar Reservas
    Verificar Se É Lista    ${res}
    Log To Console    ${res}

Deve Buscar Reserva Por ID
    [Documentation]    Verifica se é possível buscar uma reserva específica pelo ID
    [Tags]    booking    get    regression
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    Should Not Be Empty    ${res}
    Should Be Equal    ${res['firstname']}    Rodrigo
    Log To Console    ${res}

Deve Criar Reserva
    [Documentation]    Verifica se é possível criar uma nova reserva
    [Tags]    booking    post    smoke
    ${res}=    Criar Reserva
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    Log To Console    ${res}

Deve Criar Reserva Com Dados Personalizados
    [Documentation]    Verifica se é possível criar uma reserva com dados personalizados
    [Tags]    booking    post    regression
    ${res}=    Criar Reserva    firstname=Maria    lastname=Silva    totalprice=300
    Should Not Be Empty    ${res}
    Dictionary Should Contain Key    ${res}    bookingid
    ${booking_id}=    Set Variable    ${res['bookingid']}
    ${reserva}=    Buscar Reserva Por ID    ${booking_id}
    Should Be Equal    ${reserva['firstname']}    Maria
    Should Be Equal    ${reserva['lastname']}    Silva
    Should Be Equal As Numbers    ${reserva['totalprice']}    300

Deve Atualizar Reserva
    [Documentation]    Verifica se é possível atualizar completamente uma reserva
    [Tags]    booking    put    regression
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Reserva    ${booking_id}    ${token}
    Should Not Be Empty    ${res}
    Should Be Equal    ${res['lastname']}    Lima
    Should Be Equal As Numbers    ${res['totalprice']}    200
    Should Be Equal    ${res['depositpaid']}    ${FALSE}
    Log To Console      ${res}

Deve Atualizar Parcialmente Reserva
    [Documentation]    Verifica se é possível atualizar parcialmente uma reserva
    [Tags]    booking    patch    regression
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Parcial Reserva    ${booking_id}    ${token}
    Should Not Be Empty    ${res}
    Should Be Equal    ${res['firstname']}    Updated
    Should Be Equal    ${res['lastname']}    User
    Log To Console      ${res}

Deve Deletar Reserva
    [Documentation]    Verifica se é possível deletar uma reserva
    [Tags]    booking    delete    regression
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    Deletar Reserva     ${booking_id}    ${token}
    Run Keyword And Expect Error    *    Buscar Reserva Por ID    ${booking_id}

Deve Buscar Reservas Com Filtro
    [Documentation]    Verifica se é possível buscar reservas com filtro
    [Tags]    booking    get    regression
    ${nova_reserva}=    Criar Reserva    firstname=Filtro    lastname=Teste
    ${res}=    Buscar Reservas    firstname=Filtro
    Verificar Se É Lista    ${res}
    Log To Console    Reservas encontradas com filtro: ${res}