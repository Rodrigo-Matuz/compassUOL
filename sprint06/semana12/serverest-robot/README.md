# ServeRest - Robot Framework API Testing

## Sobre este Repositório

Este repositório foi criado como parte do estágio na Compass UOL, com o objetivo
de praticar e aprofundar o conhecimento em automação de testes de APIs
utilizando o **Robot Framework**.

O projeto foi desenvolvido com foco em:

- Estruturação de testes utilizando a abordagem Keyword-Driven;
- Consumo de APIs REST utilizando a biblioteca RequestsLibrary do Robot Framework;
- Testes com diferentes verbos HTTP (`GET`, `POST`, `PUT`, `DELETE`);
- Autenticação de usuários via token;
- Geração de dados de teste dinâmicos com FakerLibrary;
- Organização e execução de testes com tags;
- Análise dos relatórios gerados automaticamente após cada execução.

## API Utilizada

Para este projeto, foi utilizada a API ServeRest:

- [ServeRest](https://serverest.dev/) - API REST para testes com endpoints para cadastro de usuários, produtos e carrinhos de compra.

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/Rodrigo-Matuz/compassUOL
```

2. Acesse o diretório do projeto:
```bash
cd sprint06/semana12/serverest-robot
```

3. Crie o ambiente virtual:
```bash
python -m venv env
```

4. Ative o ambiente virtual:
```bash
# No Linux
source env/bin/activate

# No Windows (PowerShell)
.\env\Scripts\Activate.ps1
```

5. Instale as dependências:
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

Exemplo para executar apenas testes de usuários:
```bash
robot -i usuarios tests/
```

Para excluir uma tag e rodar todos os testes menos os que a possuem:
```bash
robot -e <tag> tests/
```

Para gerar relatórios em um diretório específico:
```bash
robot -d results tests/
```

## Tags

| Tag         | Descrição                                                   |
|-------------|-------------------------------------------------------------|
| usuarios    | Testes relacionados ao cadastro e gerenciamento de usuários |
| produtos    | Testes relacionados ao cadastro e gerenciamento de produtos |
| carrinhos   | Testes relacionados às operações de carrinho de compras     |
| login       | Testes relacionados à autenticação e obtenção de token      |
| get         | Testes com requisições HTTP GET                             |
| post        | Testes com requisições HTTP POST                            |
| put         | Testes com requisições HTTP PUT                             |
| delete      | Testes com requisições HTTP DELETE                          |
| positive    | Testes de cenários positivos (fluxo feliz)                  |
| negative    | Testes que verificam o comportamento em cenários de erro    |
| validation  | Testes que validam regras de negócio específicas            |
| cadastro    | Testes específicos de operações de cadastro                 |

## Boas Práticas Implementadas

1. **Organização em Camadas**: Separação clara entre testes, keywords e variáveis
2. **Documentação**: Todos os arquivos e keywords possuem documentação
3. **Reutilização**: Keywords comuns extraídas para um arquivo compartilhado
4. **Parametrização**: Keywords flexíveis com argumentos padrão
5. **Geração de Dados**: Uso de FakerLibrary para gerar dados de teste dinâmicos
6. **Validações**: Asserções específicas para cada tipo de teste
7. **Abstração de API**: Encapsulamento das chamadas de API em keywords de alto nível