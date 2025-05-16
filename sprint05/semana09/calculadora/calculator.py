class Calculadora:
    def square_root(self, a):
        if isinstance(a, bool) or not isinstance(a, (int, float)):
            return "Invalid input"
        if a < 0:
            return "Invalid input"
        if a == 0:
            return 0
        guess = a / 2.0
        for _ in range(20):
            guess = (guess + a / guess) / 2.0
        return guess

    def power_of(self, a, b):
        validation = self.validate_input(a, b)
        if validation is True:
            result = 1
            for _ in range(abs(int(b))):
                result *= a
            if b < 0:
                return 1 / result
            return result
        return validation

    def validate_input(self, a, b):
        if isinstance(a, bool) or isinstance(b, bool):
            return "Invalid input"
        if isinstance(a, (int, float)) and isinstance(b, (int, float)):
            return True
        return "Invalid input"

    def addition(self, a, b):
        validation = self.validate_input(a, b)
        if validation is True:
            return a + b
        return validation

    def subtraction(self, a, b):
        validation = self.validate_input(a, b)
        if validation is True:
            return a - b
        return validation

    def multiplication(self, a, b):
        validation = self.validate_input(a, b)
        if validation is True:
            return a * b
        return validation

    def division(self, a, b):
        validation = self.validate_input(a, b)
        if validation is True:
            if b == 0:
                return "Division by zero error"
            return a / b
        return validation
