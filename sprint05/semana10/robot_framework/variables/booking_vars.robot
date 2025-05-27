*** Settings ***
Documentation     Variáveis globais utilizadas nos testes da API Restful-Booker

*** Variables ***
# API Endpoints
${BASE_URL}            https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}       /auth
${BOOKING_ENDPOINT}    /booking
${PING_ENDPOINT}       /ping

# Credenciais
${USER_USERNAME}    admin
${USER_PASSWORD}    password123

# Dados padrão para testes
${DEFAULT_FIRSTNAME}      Rodrigo
${DEFAULT_LASTNAME}       Santos
${DEFAULT_TOTALPRICE}     150
${DEFAULT_DEPOSITPAID}    ${TRUE}
${DEFAULT_CHECKIN}        2025-11-01
${DEFAULT_CHECKOUT}       2026-01-01
${DEFAULT_NEEDS}          Breakfast