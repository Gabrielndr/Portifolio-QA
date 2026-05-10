# language: pt

@bdd @api @produtos
Funcionalidade: Gerenciamento de produtos na ServeRest
  Como administrador da API
  Quero cadastrar, consultar, alterar e remover produtos
  Para manter o catálogo disponível e consistente

  Contexto:
    Dado que a API ServeRest está disponível
    E estou autenticado com Bearer Token de administrador

  @produtos @cadastro @sucesso @critico
  Cenário: Cadastrar produto com dados válidos
    Quando envio uma requisição POST para "/produtos" com o body:
      """
      {
        "nome": "Mouse QA Wireless",
        "preco": 480,
        "descricao": "Produto criado por teste automatizado",
        "quantidade": 120
      }
      """
    Então o status da resposta deve ser 201
    E o body deve conter a mensagem "Cadastro realizado com sucesso"
    E o body deve conter um campo "_id" não vazio

  @produtos @cadastro @falha @validacao
  Esquema do Cenário: Bloquear cadastro de produto com campo obrigatório inválido
    Quando envio uma requisição POST para "/produtos" sem o campo "<campo>"
    Então o status da resposta deve ser 400
    E o body deve informar erro de validação para o campo "<campo>"

    Exemplos:
      | campo      |
      | nome       |
      | preco      |
      | descricao  |
      | quantidade |

  @produtos @listagem @sucesso
  Cenário: Listar produtos cadastrados
    Quando envio uma requisição GET para "/produtos"
    Então o status da resposta deve ser 200
    E o body deve retornar uma lista de produtos
    E cada produto deve conter os campos "nome", "preco", "descricao", "quantidade" e "_id"

  @produtos @edicao @sucesso
  Cenário: Alterar produto existente
    Dado que existe um produto cadastrado para o teste
    Quando envio uma requisição PUT para o produto criado com o body:
      """
      {
        "nome": "Mouse QA Wireless V2",
        "preco": 450,
        "descricao": "Produto alterado por teste automatizado",
        "quantidade": 90
      }
      """
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro alterado com sucesso"
    E uma consulta do produto deve retornar os dados atualizados

  @produtos @exclusao @sucesso
  Cenário: Remover produto existente
    Dado que existe um produto cadastrado para o teste
    Quando envio uma requisição DELETE para o produto criado
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro excluído com sucesso"

  @produtos @exclusao @falha
  Cenário: Bloquear exclusão de produto inexistente
    Quando envio uma requisição DELETE para "/produtos/id_inexistente"
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Nenhum registro excluído"

  @produtos @seguranca
  Cenário: Bloquear cadastro de produto sem autenticação
    Dado que não envio Bearer Token na requisição
    Quando envio uma requisição POST para "/produtos" com dados válidos
    Então o status da resposta deve ser 401
    E o body deve conter mensagem de token ausente, inválido ou expirado
