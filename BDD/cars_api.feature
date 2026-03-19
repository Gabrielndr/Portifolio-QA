# language: pt

Funcionalidade: API de Carros - Mock e Performance
  Como um engenheiro de QA
  Quero validar o comportamento da API de carros
  Para garantir respostas corretas em diferentes cenários

  Contexto:
    Dado que o servidor WireMock está rodando em "http://localhost:8080"
    E o endpoint base é "/api/cars"

  @cars @consulta @sucesso
  Cenário: Listar todos os carros cadastrados
    Quando envio uma requisição GET para "/api/cars"
    Então o status da resposta deve ser 200
    E a lista deve conter exatamente 5 carros
    E o primeiro carro deve ser "Toyota Corolla"
    E o último carro deve ser "BMW M3"

  @cars @cadastro @sucesso
  Cenário: Cadastrar um carro permitido com sucesso
    Quando envio uma requisição POST para "/api/cars" com o body:
      """
      {
        "brand": "Volkswagen",
        "model": "fusca",
        "year": 1965
      }
      """
    Então o status da resposta deve ser 201
    E o body deve conter a mensagem "Car successfully registered!"
    E o body deve conter o campo "carId" com valor 6

  @cars @cadastro @erro
  Cenário: Tentar cadastrar modelo não permitido - erro 500
    Quando envio uma requisição POST para "/api/cars" com o body:
      """
      {
        "brand": "Volkswagen",
        "model": "up tsi",
        "year": 2020
      }
      """
    Então o status da resposta deve ser 500
    E o body deve conter a mensagem "Internal server error: model 'up tsi' is not allowed."

  @cars @cadastro @erro
  Cenário: Tentar cadastrar modelo desconhecido - erro 404
    Quando envio uma requisição POST para "/api/cars" com o body:
      """
      {
        "brand": "Fiat",
        "year": 2023
      }
      """
    Então o status da resposta deve ser 404
    E o body deve conter a mensagem "Car model not found."

  @cars @performance @carga
  Cenário: Teste de carga com 10 usuários simultâneos por 30 segundos
    Dado que o K6 está configurado com 10 VUs e duração de 30 segundos
    Quando executo o teste de carga no endpoint POST "/api/cars"
    Então todos os requests devem retornar status 500 para o modelo "up tsi"
    E a taxa de sucesso dos checks deve ser de 100%

  @cars @performance @stress
  Cenário: Teste de stress com rampa de até 500 usuários
    Dado que o K6 está configurado com os seguintes stages:
      | duração | usuarios |
      | 5s      | 100      |
      | 10s     | 500      |
      | 5s      | 100      |
    Quando executo o teste de stress no endpoint POST "/api/cars"
    Então o sistema deve responder com status 201 para o modelo "fusca"
    E a mensagem de retorno deve ser "Car successfully registered!"

  @cars @tabela
  Esquema do Cenário: Validar respostas para diferentes modelos de carro
    Quando envio POST para "/api/cars" com brand "<marca>", model "<modelo>" e year <ano>
    Então o status da resposta deve ser <status>
    E a mensagem deve ser "<mensagem>"

    Exemplos:
      | marca      | modelo  | ano  | status | mensagem                                              |
      | Volkswagen | fusca   | 1965 | 201    | Car successfully registered!                          |
      | Volkswagen | up tsi  | 2020 | 500    | Internal server error: model 'up tsi' is not allowed. |
      | Fiat       | uno     | 2010 | 404    | Car model not found.                                  |
