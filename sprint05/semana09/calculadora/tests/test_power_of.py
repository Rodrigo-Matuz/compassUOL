import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.potencia
@pytest.mark.parametrize("a, b, esperado", [(2, 3, 8), (5.0, 2, 25.0), (2, -2, 0.25)])
def test_potencia_numeros(calculador, a, b, esperado):
    """
    Potência com Entradas Numéricas

    Testa o método de potência com entradas numéricas válidas.
    """
    assert calculador.potencia(a, b) == esperado


@pytest.mark.potencia
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        ("foo", 2, "Entrada inválida"),
        (2, "bar", "Entrada inválida"),
        (None, 2, "Entrada inválida"),
        (True, 2, "Entrada inválida"),
        (2, None, "Entrada inválida"),
    ],
)
def test_potencia_entradas_invalidas(calculador, a, b, esperado):
    """
    Potência com Entradas Inválidas

    Testa o método de potência com entradas inválidas.
    """
    assert calculador.potencia(a, b) == esperado
