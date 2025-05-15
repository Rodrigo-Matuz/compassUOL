import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.addition
@pytest.mark.parametrize("a, b, expected", [(1, 2, 3), (1.0, 2.5, 3.5), (-1, -2, -3)])
def test_addition_takes_numbers(calculador, a, b, expected):
    """
    Addition with Numeric Inputs

    Tests the addition method with numeric inputs (integers and floats) to ensure correct addition.
    """
    assert calculador.addition(a, b) == expected


@pytest.mark.addition
@pytest.mark.parametrize(
    "a, b, expected",
    [
        ("foo", "bar", "Invalid input"),
        (1, "bar", "Invalid input"),
        ("foo", 2, "Invalid input"),
    ],
)
def test_addition_handle_strings(calculador, a, b, expected):
    """
    Addition with String Inputs

    Tests the addition method with string inputs to verify it returns "Invalid input" as expected.
    """
    assert calculador.addition(a, b) == expected


@pytest.mark.addition
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (None, 2, "Invalid input"),
        (1, None, "Invalid input"),
        (None, None, "Invalid input"),
    ],
)
def test_addition_handle_none(calculador, a, b, expected):
    """
    Addition with None Inputs

    Tests the addition method when one or both inputs are None, expecting "Invalid input" as a response.
    """
    assert calculador.addition(a, b) == expected


@pytest.mark.addition
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (True, False, "Invalid input"),
        (True, 2, "Invalid input"),
        (1, False, "Invalid input"),
    ],
)
def test_addition_handle_boolean(calculador, a, b, expected):
    """
    Addition with Boolean Inputs

    Tests the addition method with boolean inputs to ensure it returns "Invalid input".
    """
    assert calculador.addition(a, b) == expected
