import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.multiplication
@pytest.mark.parametrize("a, b, expected", [(6, 2, 12), (7.5, 2, 15.0), (-6, -2, 12)])
def test_multiplication_takes_numbers(calculador, a, b, expected):
    """
    Multiplication with Numeric Inputs

    Tests the multiplication method with numeric inputs (integers and floats) to ensure correct multiplication.
    """
    assert calculador.multiplication(a, b) == expected


@pytest.mark.multiplication
@pytest.mark.parametrize(
    "a, b, expected",
    [
        ("foo", "bar", "Invalid input"),
        (1, "bar", "Invalid input"),
        ("foo", 2, "Invalid input"),
    ],
)
def test_multiplication_handle_strings(calculador, a, b, expected):
    """
    Multiplication with String Inputs

    Tests the multiplication method with string inputs to verify it returns "Invalid input" as expected.
    """
    assert calculador.multiplication(a, b) == expected


@pytest.mark.multiplication
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (None, 2, "Invalid input"),
        (1, None, "Invalid input"),
        (None, None, "Invalid input"),
    ],
)
def test_multiplication_handle_none(calculador, a, b, expected):
    """
    Multiplication with None Inputs

    Tests the multiplication method when one or both inputs are None, expecting "Invalid input" as a response.
    """
    assert calculador.multiplication(a, b) == expected


@pytest.mark.multiplication
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (True, False, "Invalid input"),
        (True, 2, "Invalid input"),
        (1, False, "Invalid input"),
    ],
)
def test_multiplication_handle_boolean(calculador, a, b, expected):
    """
    Multiplication with Boolean Inputs

    Tests the multiplication method with boolean inputs to ensure it returns "Invalid input".
    """
    assert calculador.multiplication(a, b) == expected
