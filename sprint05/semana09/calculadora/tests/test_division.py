import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.division
@pytest.mark.parametrize("a, b, expected", [(6, 2, 3), (7.5, 2.5, 3.0), (-6, -2, 3)])
def test_division_takes_numbers(calculador, a, b, expected):
    """
    Division with Numeric Inputs

    Tests the division method with numeric inputs (integers and floats) to ensure correct division.
    """
    assert calculador.division(a, b) == expected


@pytest.mark.division
@pytest.mark.parametrize(
    "a, b, expected",
    [
        ("foo", "bar", "Invalid input"),
        (1, "bar", "Invalid input"),
        ("foo", 2, "Invalid input"),
    ],
)
def test_division_handle_strings(calculador, a, b, expected):
    """
    Division with String Inputs

    Tests the division method with string inputs to verify it returns "Invalid input" as expected.
    """
    assert calculador.division(a, b) == expected


@pytest.mark.division
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (None, 2, "Invalid input"),
        (1, None, "Invalid input"),
        (None, None, "Invalid input"),
    ],
)
def test_division_handle_none(calculador, a, b, expected):
    """
    Division with None Inputs

    Tests the division method when one or both inputs are None, expecting "Invalid input" as a response.
    """
    assert calculador.division(a, b) == expected


@pytest.mark.division
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (True, False, "Invalid input"),
        (True, 2, "Invalid input"),
        (1, False, "Invalid input"),
    ],
)
def test_division_handle_boolean(calculador, a, b, expected):
    """
    Division with Boolean Inputs

    Tests the division method with boolean inputs to ensure it returns "Invalid input".
    """
    assert calculador.division(a, b) == expected


@pytest.mark.division
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (6, 0, "Division by zero error"),
        (0, 0, "Division by zero error"),
    ],
)
def test_division_by_zero(calculador, a, b, expected):
    """
    Division by Zero

    Tests the division method to handle division by zero, expecting a specific error message.
    """
    assert calculador.division(a, b) == expected
