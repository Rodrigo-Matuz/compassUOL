import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.square_root
@pytest.mark.parametrize("a, expected", [(4, 2), (9.0, 3.0), (0, 0)])
def test_square_root_takes_numbers(calculador, a, expected):
    """
    Square Root with Numeric Inputs

    Tests the square_root method with valid numeric inputs.
    """
    assert calculador.square_root(a) == expected


@pytest.mark.square_root
@pytest.mark.parametrize(
    "a, expected",
    [
        ("foo", "Invalid input"),
        (None, "Invalid input"),
        (True, "Invalid input"),
        (-1, "Invalid input"),
    ],
)
def test_square_root_invalid_inputs(calculador, a, expected):
    """
    Square Root with Invalid Inputs

    Tests the square_root method with invalid inputs.
    """
    assert calculador.square_root(a) == expected
