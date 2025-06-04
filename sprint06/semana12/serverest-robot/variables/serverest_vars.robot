*** Settings ***
Documentation       Variáveis globais utilizadas nos testes da API ServeRest

*** Variables ***
${BASE_URL}         http://18.212.196.190:3000/
${AUTH_ENDPOINT}    /login
${USERS_ENDPOINT}   /usuarios

# Credenciais
${NOME_VALIDO}      Rodrigo
${EMAIL_VALIDO}     rodrigolimacompass01@compasso.com
${SENHA_VALIDA}     senha01
${EMAIL_INVALIDO}   rodrigolimacompass01@gmail.com
${SENHA_INVALIDA}   XXXXXXXXX

${HEADERS}          {"Content-Type": "application/json", "Accept": "application/json"}
${TOKEN}            None