*** Settings ***
Resource    ../resources/booking_keywords.robot


*** Test Cases ***
Deve Obter Token
    Desabilitar Avisos SSL
    ${token}=    Obter Token
    Log To Console    Token obtido: ${token}


Deve Buscar Todas Reservas
    Desabilitar Avisos SSL
    ${res}=    Buscar Reservas
    Log To Console    ${res}


Deve Buscar Reserva Por ID
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=    Set Variable    ${nova_reserva['bookingid']}
    ${res}=    Buscar Reserva Por ID    ${booking_id}
    Log To Console    ${res}


Deve Criar Reserva
    Desabilitar Avisos SSL
    ${res}=    Criar Reserva
    Log To Console    ${res}


Deve Atualizar Reserva
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Reserva    ${booking_id}    ${token}
    Log To Console      ${res}


Deve Atualizar Parcialmente Reserva
    Desabilitar Avisos SSL
    ${nova_reserva}=    Criar Reserva
    ${booking_id}=      Set Variable    ${nova_reserva['bookingid']}
    ${token}=           Obter Token
    ${res}=             Atualizar Parcial Reserva    ${booking_id}    ${token}
    Log To Console      ${res}

