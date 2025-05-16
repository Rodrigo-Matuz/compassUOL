from calculadora import Calculadora


def main():
    calc = Calculadora()

    print("Escolha uma operação:")
    print("1. Raiz Quadrada")
    print("2. Potência")
    print("3. Adição")
    print("4. Subtração")
    print("5. Multiplicação")
    print("6. Divisão")
    escolha = input("Digite sua escolha (1-6): ")

    if escolha == "1":
        a = input("Digite um número: ")
        try:
            a = float(a)
            print("Resultado:", calc.raiz_quadrada(a))
        except ValueError:
            print("Entrada inválida")

    elif escolha in ["2", "3", "4", "5", "6"]:
        a = input("Digite o primeiro número: ")
        b = input("Digite o segundo número: ")
        try:
            a = float(a)
            b = float(b)

            if escolha == "2":
                print("Resultado:", calc.potencia(a, b))
            elif escolha == "3":
                print("Resultado:", calc.adicao(a, b))
            elif escolha == "4":
                print("Resultado:", calc.subtracao(a, b))
            elif escolha == "5":
                print("Resultado:", calc.multiplicacao(a, b))
            elif escolha == "6":
                print("Resultado:", calc.divisao(a, b))
        except ValueError:
            print("Entrada inválida")

    else:
        print("Escolha inválida")


if __name__ == "__main__":
    main()
