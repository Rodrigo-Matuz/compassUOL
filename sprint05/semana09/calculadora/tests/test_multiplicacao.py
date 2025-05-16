import pytest
from calculadora import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.divisao
@pytest.mark.parametrize("a, b, esperado", [(6, 2, 3), (7.5, 2.5, 3.0), (-6, -2, 3)])
def test_divisao_numeros(calculador, a, b, esperado):
    """
    Divisão com Entradas Numéricas

    Testa o método de divisão com entradas numéricas (inteiros e floats) para garantir a divisão correta.
    """
    assert calculador.divisao(a, b) == esperado


@pytest.mark.divisao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        ("foo", "bar", "Entrada inválida"),
        (1, "bar", "Entrada inválida"),
        ("foo", 2, "Entrada inválida"),
    ],
)
def test_divisao_strings(calculador, a, b, esperado):
    """
    Divisão com Entradas de String

    Testa o método de divisão com entradas de string para verificar se retorna "Entrada inválida" conforme esperado.
    """
    assert calculador.divisao(a, b) == esperado


@pytest.mark.divisao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (None, 2, "Entrada inválida"),
        (1, None, "Entrada inválida"),
        (None, None, "Entrada inválida"),
    ],
)
def test_divisao_none(calculador, a, b, esperado):
    """
    Divisão com Entradas None

    Testa o método de divisão quando um ou ambos os inputs são None, esperando "Entrada inválida" como resposta.
    """
    assert calculador.divisao(a, b) == esperado


@pytest.mark.divisao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (True, False, "Entrada inválida"),
        (True, 2, "Entrada inválida"),
        (1, False, "Entrada inválida"),
    ],
)
def test_divisao_booleanos(calculador, a, b, esperado):
    """
    Divisão com Entradas Booleanas

    Testa o método de divisão com entradas booleanas para garantir que retorna "Entrada inválida".
    """
    assert calculador.divisao(a, b) == esperado


@pytest.mark.divisao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (6, 0, "Erro: Divisão por zero"),
        (0, 0, "Erro: Divisão por zero"),
    ],
)
def test_divisao_por_zero(calculador, a, b, esperado):
    """
    Divisão por Zero

    Testa o método de divisão para lidar com a divisão por zero, esperando uma mensagem de erro específica.
    """
    assert calculador.divisao(a, b) == esperado


@pytest.mark.multiplicacao
@pytest.mark.parametrize("a, b, esperado", [(6, 2, 12), (7.5, 2, 15.0), (-6, -2, 12)])
def test_multiplicacao_numeros(calculador, a, b, esperado):
    """
    Multiplicação com Entradas Numéricas

    Testa o método de multiplicação com entradas numéricas (inteiros e floats) para garantir a multiplicação correta.
    """
    assert calculador.multiplicacao(a, b) == esperado


@pytest.mark.multiplicacao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        ("foo", "bar", "Entrada inválida"),
        (1, "bar", "Entrada inválida"),
        ("foo", 2, "Entrada inválida"),
    ],
)
def test_multiplicacao_strings(calculador, a, b, esperado):
    """
    Multiplicação com Entradas de String

    Testa o método de multiplicação com entradas de string para verificar se retorna "Entrada inválida" conforme esperado.
    """
    assert calculador.multiplicacao(a, b) == esperado


@pytest.mark.multiplicacao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (None, 2, "Entrada inválida"),
        (1, None, "Entrada inválida"),
        (None, None, "Entrada inválida"),
    ],
)
def test_multiplicacao_none(calculador, a, b, esperado):
    """
    Multiplicação com Entradas None

    Testa o método de multiplicação quando um ou ambos os inputs são None, esperando "Entrada inválida" como resposta.
    """
    assert calculador.multiplicacao(a, b) == esperado


@pytest.mark.multiplicacao
@pytest.mark.parametrize(
    "a, b, esperado",
    [
        (True, False, "Entrada inválida"),
        (True, 2, "Entrada inválida"),
        (1, False, "Entrada inválida"),
    ],
)
def test_multiplicacao_booleanos(calculador, a, b, esperado):
    """
    Multiplicação com Entradas Booleanas

    Testa o método de multiplicação com entradas booleanas para garantir que retorna "Entrada inválida".
    """
    assert calculador.multiplicacao(a, b) == esperado
