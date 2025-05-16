import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.raiz_quadrada
@pytest.mark.parametrize("a, esperado", [(4, 2), (9.0, 3.0), (0, 0)])
def test_raiz_quadrada_numeros(calculador, a, esperado):
    """
    Raiz Quadrada com Entradas Numéricas

    Testa o método raiz_quadrada com entradas numéricas válidas.
    """
    assert calculador.raiz_quadrada(a) == esperado


@pytest.mark.raiz_quadrada
@pytest.mark.parametrize(
    "a, esperado",
    [
        ("foo", "Entrada inválida"),
        (None, "Entrada inválida"),
        (True, "Entrada inválida"),
        (-1, "Entrada inválida"),
    ],
)
def test_raiz_quadrada_entradas_invalidas(calculador, a, esperado):
    """
    Raiz Quadrada com Entradas Inválidas

    Testa o método raiz_quadrada com entradas inválidas.
    """
    assert calculador.raiz_quadrada(a) == esperado
