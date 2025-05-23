*** Settings ***
Resource    ../resources/booking_keywords.robot


*** Test Cases ***
Deve Obter Token
    [Tags]    auth    smoke
    Desabilitar Avisos SSL
    ${token}=    Obter Token
    Log To Console    Token obtido: ${token}


Deve Buscar Todas Reservas
    [Tags]    booking    get    regression
    Desabilitar Avisos SSL
    ${res}=    Buscar Reservas
    Log To Console    ${res}


Deve Buscar Reserva Por ID
    [Tags]    booking    get    regression
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    Log To Console    ${res}


Deve Criar Reserva
    [Tags]    booking    post    smoke
    Desabilitar Avisos SSL
    ${res}=    Criar Reserva
    Log To Console    ${res}


Deve Atualizar Reserva
    [Tags]    booking    put    regression
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Reserva    ${booking_id}    ${token}
    Log To Console      ${res}


Deve Atualizar Parcialmente Reserva
    [Tags]    booking    patch    regression
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Parcial Reserva    ${booking_id}    ${token}
    Log To Console      ${res}


Deve Deletar Reserva
    [Tags]    booking    delete    regression
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    Deletar Reserva     ${booking_id}    ${token}


Deve Validar Healthcheck
    [Tags]    healthcheck    smoke
    Desabilitar Avisos SSL
    Verificar Healthcheck
