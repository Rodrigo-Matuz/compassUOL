*** Settings ***
Documentation       Variáveis globais utilizadas nos testes da API ServeRest

*** Variables ***
# API Endpoints
${BASE_URL}         https://compassuol.serverest.dev/
${AUTH_ENDPOINT}    /login
${USERS_ENDPOINT}   /usuarios
${PRODUCTS_ENDPOINT}  /produtos
${CARTS_ENDPOINT}   /carrinhos

# Credenciais
${NOME_VALIDO}      Rodrigo
${EMAIL_VALIDO}     rodrigolimacompass01@compasso.com
${SENHA_VALIDA}     senha01
${EMAIL_INVALIDO}   rodrigolimacompass01@gmail.com
${SENHA_INVALIDA}   XXXXXXXXX

# Headers e Autenticação
&{HEADERS}          Content-Type=application/json    Accept=application/json
${TOKEN}            None

# Tags para testes
# Use as tags abaixo para categorizar seus testes:
# HTTP Methods: get, post, put, delete, patch
# Features: usuarios, login, produtos, carrinhos
# Test Types: positive, negative, validation, smoke, regression