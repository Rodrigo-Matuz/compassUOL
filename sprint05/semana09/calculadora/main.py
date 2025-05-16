from calculator import Calculadora


def main():
    calc = Calculadora()

    print("Choose an operation:")
    print("1. Square Root")
    print("2. Power Of")
    print("3. Addition")
    print("4. Subtraction")
    print("5. Multiplication")
    print("6. Division")
    choice = input("Enter your choice (1-6): ")

    if choice == "1":
        a = input("Enter a number: ")
        try:
            a = float(a)
            print("Result:", calc.square_root(a))
        except ValueError:
            print("Invalid input")

    elif choice in ["2", "3", "4", "5", "6"]:
        a = input("Enter first number: ")
        b = input("Enter second number: ")
        try:
            a = float(a)
            b = float(b)

            if choice == "2":
                print("Result:", calc.power_of(a, b))
            elif choice == "3":
                print("Result:", calc.addition(a, b))
            elif choice == "4":
                print("Result:", calc.subtraction(a, b))
            elif choice == "5":
                print("Result:", calc.multiplication(a, b))
            elif choice == "6":
                print("Result:", calc.division(a, b))
        except ValueError:
            print("Invalid input")

    else:
        print("Invalid choice")


if __name__ == "__main__":
    main()
