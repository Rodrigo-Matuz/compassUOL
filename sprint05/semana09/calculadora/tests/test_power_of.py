import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.power_of
@pytest.mark.parametrize("a, b, expected", [(2, 3, 8), (5.0, 2, 25.0), (2, -2, 0.25)])
def test_power_of_takes_numbers(calculador, a, b, expected):
    """
    Power Of with Numeric Inputs

    Tests the power_of method with valid numeric inputs.
    """
    assert calculador.power_of(a, b) == expected


@pytest.mark.power_of
@pytest.mark.parametrize(
    "a, b, expected",
    [
        ("foo", 2, "Invalid input"),
        (2, "bar", "Invalid input"),
        (None, 2, "Invalid input"),
        (True, 2, "Invalid input"),
        (2, None, "Invalid input"),
    ],
)
def test_power_of_invalid_inputs(calculador, a, b, expected):
    """
    Power Of with Invalid Inputs

    Tests the power_of method with invalid inputs.
    """
    assert calculador.power_of(a, b) == expected
