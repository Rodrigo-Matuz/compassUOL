import pytest
from main import Calculadora


@pytest.fixture()
def calculador():
    return Calculadora()


@pytest.mark.subtraction
@pytest.mark.parametrize("a, b, expected", [(6, 2, 4), (7.5, 2, 5.5), (-6, -2, -4)])
def test_subtraction_takes_numbers(calculador, a, b, expected):
    """
    Subtraction with Numeric Inputs

    Tests the subtraction method with numeric inputs (integers and floats) to ensure correct subtraction.
    """
    assert calculador.subtraction(a, b) == expected


@pytest.mark.subtraction
@pytest.mark.parametrize(
    "a, b, expected",
    [
        ("foo", "bar", "Invalid input"),
        (1, "bar", "Invalid input"),
        ("foo", 2, "Invalid input"),
    ],
)
def test_subtraction_handle_strings(calculador, a, b, expected):
    """
    Subtraction with String Inputs

    Tests the subtraction method with string inputs to verify it returns "Invalid input" as expected.
    """
    assert calculador.subtraction(a, b) == expected


@pytest.mark.subtraction
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (None, 2, "Invalid input"),
        (1, None, "Invalid input"),
        (None, None, "Invalid input"),
    ],
)
def test_subtraction_handle_none(calculador, a, b, expected):
    """
    Subtraction with None Inputs

    Tests the subtraction method when one or both inputs are None, expecting "Invalid input" as a response.
    """
    assert calculador.subtraction(a, b) == expected


@pytest.mark.subtraction
@pytest.mark.parametrize(
    "a, b, expected",
    [
        (True, False, "Invalid input"),
        (True, 2, "Invalid input"),
        (1, False, "Invalid input"),
    ],
)
def test_subtraction_handle_boolean(calculador, a, b, expected):
    """
    Subtraction with Boolean Inputs

    Tests the subtraction method with boolean inputs to ensure it returns "Invalid input".
    """
    assert calculador.subtraction(a, b) == expected
