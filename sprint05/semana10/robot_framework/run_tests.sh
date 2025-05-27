#!/bin/bash

# Script para executar os testes do Robot Framework

# Ativa o ambiente virtual
source env/bin/activate

# Cria diretório de resultados se não existir
mkdir -p results

# Função para executar testes
run_tests() {
    echo "Executando testes: $1"
    robot -d results $2 $1
    echo "-------------------------------------"
}

# Verifica argumentos
if [ "$1" == "smoke" ]; then
    run_tests "tests/" "-i smoke"
elif [ "$1" == "regression" ]; then
    run_tests "tests/" "-i regression"
elif [ "$1" == "auth" ]; then
    run_tests "tests/auth_tests.robot" ""
elif [ "$1" == "booking" ]; then
    run_tests "tests/booking_tests.robot" ""
elif [ "$1" == "healthcheck" ]; then
    run_tests "tests/healthcheck_tests.robot" ""
elif [ "$1" == "all" ] || [ -z "$1" ]; then
    run_tests "tests/" ""
else
    echo "Uso: ./run_tests.sh [smoke|regression|auth|booking|healthcheck|all]"
    exit 1
fi

# Desativa o ambiente virtual
deactivate