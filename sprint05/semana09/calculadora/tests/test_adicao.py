import pytest
from calculadora import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.adicao
@pytest.mark.parametrize("a, b, esperado", [(1, 2, 3), (1.0, 2.5, 3.5), (-1, -2, -3)])
def test_adicao_numeros(calculador, a, b, esperado):
    """
    Adição com Entradas Numéricas

    Testa o método de adição com entradas numéricas (inteiros e floats) para garantir a soma correta.
    """
    assert calculador.adicao(a, b) == esperado


@pytest.mark.adicao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        ("foo", "bar", "Entrada inválida"),
        (1, "bar", "Entrada inválida"),
        ("foo", 2, "Entrada inválida"),
    ],
)
def test_adicao_strings(calculador, a, b, esperado):
    """
    Adição com Entradas de String

    Testa o método de adição com entradas de string para verificar se retorna "Entrada inválida" conforme esperado.
    """
    assert calculador.adicao(a, b) == esperado


@pytest.mark.adicao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (None, 2, "Entrada inválida"),
        (1, None, "Entrada inválida"),
        (None, None, "Entrada inválida"),
    ],
)
def test_adicao_none(calculador, a, b, esperado):
    """
    Adição com Entradas None

    Testa o método de adição quando um ou ambos os inputs são None, esperando "Entrada inválida" como resposta.
    """
    assert calculador.adicao(a, b) == esperado


@pytest.mark.adicao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (True, False, "Entrada inválida"),
        (True, 2, "Entrada inválida"),
        (1, False, "Entrada inválida"),
    ],
)
def test_adicao_booleanos(calculador, a, b, esperado):
    """
    Adição com Entradas Booleanas

    Testa o método de adição com entradas booleanas para garantir que retorna "Entrada inválida".
    """
    assert calculador.adicao(a, b) == esperado
