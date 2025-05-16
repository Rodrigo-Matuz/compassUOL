class Calculadora:
    def raiz_quadrada(self, a):
        if isinstance(a, bool) or not isinstance(a, (int, float)):
            return "Entrada inválida"
        if a < 0:
            return "Entrada inválida"
        if a == 0:
            return 0
        chute = a / 2.0
        for _ in range(20):
            chute = (chute + a / chute) / 2.0
        return chute

    def potencia(self, a, b):
        validacao = self.validar_entrada(a, b)
        if validacao is True:
            resultado = 1
            for _ in range(abs(int(b))):
                resultado *= a
            if b < 0:
                return 1 / resultado
            return resultado
        return validacao

    def validar_entrada(self, a, b):
        if isinstance(a, bool) or isinstance(b, bool):
            return "Entrada inválida"
        if isinstance(a, (int, float)) and isinstance(b, (int, float)):
            return True
        return "Entrada inválida"

    def adicao(self, a, b):
        validacao = self.validar_entrada(a, b)
        if validacao is True:
            return a + b
        return validacao

    def subtracao(self, a, b):
        validacao = self.validar_entrada(a, b)
        if validacao is True:
            return a - b
        return validacao

    def multiplicacao(self, a, b):
        validacao = self.validar_entrada(a, b)
        if validacao is True:
            return a * b
        return validacao

    def divisao(self, a, b):
        validacao = self.validar_entrada(a, b)
        if validacao is True:
            if b == 0:
                return "Erro: Divisão por zero"
            return a / b
        return validacao
