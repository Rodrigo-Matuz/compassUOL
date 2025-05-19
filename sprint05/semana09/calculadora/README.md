# Calculadora.py

## Sobre este Repositório

Este repositório faz parte do estágio da Compass UOL e é dedicado exclusivamente ao desenvolvimento da **calculadora** criada durante a Semana 09.

O foco principal deste projeto foi a aplicação das boas práticas de desenvolvimento utilizando **Git** para versionamento, além da metodologia **TDD (Test Driven Development)** para garantir a qualidade do código por meio de testes automatizados com **Pytest**.

Nesta calculadora, foram implementadas as quatro operações básicas (adição, subtração, multiplicação e divisão), além de funcionalidades extras, todas desenvolvidas com métodos robustos e claros, sem o uso da biblioteca `math`.

Este repositório reflete a prática e o aprendizado obtidos durante a semana, demonstrando organização, qualidade no código e eficiência nos testes.

## Instalação

1. Clone o repositório
```bash
git clone https://github.com/Rodrigo-Matuz/compassUOL
```

2. Acesse o diretório da calculadora
    ```bash
    # No Linux
    cd compassUOL/sprint05/semana09/calculadora

    # No Windows
    cd compassUOL\sprint05\semana09\calculadora
    ```

3. Crie o ambiente virtual
```bash
python -m venv env
```

4. Ative o ambiente virtual
    ```bash
    # No Linux
    source env/bin/activate
    
    # No Windows (PowerShell)
    .\env\Scripts\Activate.ps1
    ```

5. Instale as dependências
```bash
pip install -r requirements.txt
```

6. Executar os testes
```bash
pytest
```

7. Ou execute o programa
```bash
python main.py
```
