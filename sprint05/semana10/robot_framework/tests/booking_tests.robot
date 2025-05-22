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
