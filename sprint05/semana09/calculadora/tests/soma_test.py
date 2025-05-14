import pytest
from main import Calculadora


def soma(a, b):
    return a + b


@pytest.mark.basico
def test_soma():
    C = Calculadora()
    assert C.soma(1, 5) == 6
