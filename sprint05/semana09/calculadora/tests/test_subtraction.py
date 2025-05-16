import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.subtracao
@pytest.mark.parametrize("a, b, esperado", [(6, 2, 4), (7.5, 2, 5.5), (-6, -2, -4)])
def test_subtracao_numeros(calculador, a, b, esperado):
    """
    Subtração com Entradas Numéricas

    Testa o método subtracao com entradas numéricas (inteiros e floats) para garantir a subtração correta.
    """
    assert calculador.subtracao(a, b) == esperado


@pytest.mark.subtracao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        ("foo", "bar", "Entrada inválida"),
        (1, "bar", "Entrada inválida"),
        ("foo", 2, "Entrada inválida"),
    ],
)
def test_subtracao_strings(calculador, a, b, esperado):
    """
    Subtração com Entradas String

    Testa o método subtracao com entradas string para verificar se retorna "Entrada inválida" conforme esperado.
    """
    assert calculador.subtracao(a, b) == esperado


@pytest.mark.subtracao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (None, 2, "Entrada inválida"),
        (1, None, "Entrada inválida"),
        (None, None, "Entrada inválida"),
    ],
)
def test_subtracao_none(calculador, a, b, esperado):
    """
    Subtração com Entradas None

    Testa o método subtracao quando uma ou ambas as entradas são None, esperando "Entrada inválida" como resposta.
    """
    assert calculador.subtracao(a, b) == esperado


@pytest.mark.subtracao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (True, False, "Entrada inválida"),
        (True, 2, "Entrada inválida"),
        (1, False, "Entrada inválida"),
    ],
)
def test_subtracao_booleanos(calculador, a, b, esperado):
    """
    Subtração com Entradas Booleanas

    Testa o método subtracao com entradas booleanas para garantir que retorna "Entrada inválida".
    """
    assert calculador.subtracao(a, b) == esperado
