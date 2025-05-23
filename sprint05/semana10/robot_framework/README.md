# RobotFramework-API-Testing

## Sobre este Repositório

Este repositório foi criado como parte do estágio na Compass UOL, com o objetivo
de praticar e aprofundar o conhecimento em automação de testes de APIs
utilizando o **Robot Framework**.

Durante os dias 03, 04 e 05 da Sprint, foi desenvolvido um projeto
do zero com foco em:

- Estruturação de testes utilizando a abordagem Keyword-Driven;
- Consumo de APIs REST utilizando a biblioteca RequestsLibrary do Robot Framework;
- Testes com diferentes verbos HTTP (`GET`, `POST`, `PUT`, `DELETE`);
- Autenticação de usuários via token;
- Organização e execução de testes com tags;
- Análise dos relatórios gerados automaticamente após cada execução.

Este projeto reflete o aprendizado adquirido sobre automação de testes com
Robot Framework, bem como a capacidade de estruturar, autenticar e
validar respostas de uma API REST de maneira eficiente e profissional.

## API Utilizada

Durante os teste, foi escolhida a seguinte API para prática:

- [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html)

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/Rodrigo-Matuz/compassUOL
```

2. Acesse o diretório da calculadora
```bash
# No Linux
cd compassUOL/sprint05/semana10/robot_framework

# No Windows
cd compassUOL\sprint05\semana10\robot_framework
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

## Execução

Para rodar todos os testes:
```bash
robot tests/
```

Execute apenas os testes marcados com uma tag específica:
```bash
robot -i <tag> tests/
```

Exemplo para executar apenas testes smoke:
```bash
robot -i smoke tests/
```

Para excluir uma tag e rodar todos os testes menos os que a possuem:
```bash
robot -e <tag> tests/
```

## Tags

| Tag         | Descrição                                                   |
|-------------|-------------------------------------------------------------|
| auth        | Testes relacionados à autenticação e obtenção de token.     |
| booking     | Testes das operações de reservas (Booking).                 |
| get         | Testes com requisições HTTP GET.                            |
| post        | Testes com requisições HTTP POST.                           |
| put         | Testes com requisições HTTP PUT.                            |
| patch       | Testes com requisições HTTP PATCH.                          |
| delete      | Testes com requisições HTTP DELETE.                         |
| healthcheck | Testes para verificar a saúde/disponibilidade do serviço.   |
| smoke       | Testes rápidos que validam os fluxos principais do sistema. |
