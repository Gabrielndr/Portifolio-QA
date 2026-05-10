# language: pt

@bdd @api @mock @performance @cars
Funcionalidade: API de carros com WireMock e K6
  Como engenheiro de QA
  Quero validar contratos mockados e comportamento sob carga
  Para garantir previsibilidade funcional e limites mínimos de performance

  Contexto:
    Dado que o WireMock está rodando em "http://localhost:8080"
    E o endpoint base é "/api/cars"

  @cars @consulta @sucesso @contrato
  Cenário: Listar carros mockados
    Quando envio uma requisição GET para "/api/cars"
    Então o status da resposta deve ser 200
    E a lista deve conter exatamente 5 carros
    E cada carro deve possuir os campos "brand", "model" e "year"
    E o primeiro carro deve ser "Toyota Corolla"

  @cars @cadastro @sucesso @contrato
  Cenário: Cadastrar modelo permitido
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

  @cars @cadastro @erro @contrato
  Cenário: Retornar erro controlado para modelo não permitido
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

  @cars @cadastro @erro @contrato
  Cenário: Retornar não encontrado para modelo ausente
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
  Cenário: Executar carga com 10 usuários simultâneos
    Dado que o K6 está configurado com 10 VUs por 30 segundos
    Quando executo o teste de carga no endpoint POST "/api/cars" para o modelo "up tsi"
    Então todos os checks funcionais devem passar
    E a taxa de falha HTTP esperada deve permanecer controlada pelo contrato do mock
    E o tempo de resposta p95 deve permanecer abaixo de 500 ms

  @cars @performance @stress
  Cenário: Executar stress com rampa até 500 usuários
    Dado que o K6 está configurado com os seguintes estágios:
      | duração | usuarios |
      | 5s      | 100      |
      | 10s     | 500      |
      | 5s      | 100      |
    Quando executo o teste de stress no endpoint POST "/api/cars" para o modelo "fusca"
    Então todos os checks funcionais devem passar
    E o sistema deve manter resposta 201 para o contrato de cadastro permitido

  @cars @tabela @contrato
  Esquema do Cenário: Validar respostas por modelo de carro
    Quando envio uma requisição POST para "/api/cars" com marca "<marca>", modelo "<modelo>" e ano <ano>
    Então o status da resposta deve ser <status>
    E a mensagem deve ser "<mensagem>"

    Exemplos:
      | marca      | modelo | ano  | status | mensagem                                              |
      | Volkswagen | fusca  | 1965 | 201    | Car successfully registered!                          |
      | Volkswagen | up tsi | 2020 | 500    | Internal server error: model 'up tsi' is not allowed. |
      | Fiat       | uno    | 2010 | 404    | Car model not found.                                  |
