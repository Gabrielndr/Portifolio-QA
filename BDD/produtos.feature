# language: pt

Funcionalidade: Gerenciamento de Produtos
  Como um administrador da plataforma
  Quero gerenciar o catálogo de produtos
  Para manter o estoque atualizado

  Contexto:
    Dado que estou autenticado como administrador
    E a API está disponível em "{{Base_URL}}"

  @produtos @cadastro @sucesso
  Cenário: Cadastrar um novo produto com sucesso
    Quando envio uma requisição POST para "/produtos" com o body:
      """
      {
        "nome": "Mouse Razer Viper Mini",
        "preco": 480,
        "descricao": "House",
        "quantidade": 120
      }
      """
    Então o status da resposta deve ser 201
    E o body deve conter a mensagem "Cadastro realizado com sucesso"
    E o body deve conter um campo "_id" não vazio

  @produtos @cadastro @falha
  Cenário: Tentar cadastrar produto sem campo obrigatório
    Quando envio uma requisição POST para "/produtos" sem o campo "nome"
    Então o status da resposta deve ser 400
    E o body deve conter uma mensagem de erro de validação

  @produtos @listagem @sucesso
  Cenário: Listar todos os produtos cadastrados
    Quando envio uma requisição GET para "/produtos"
    Então o status da resposta deve ser 200
    E o body deve retornar uma lista de produtos
    E cada produto deve conter os campos "nome", "preco", "descricao", "quantidade" e "_id"

  @produtos @edicao @sucesso
  Cenário: Editar um produto existente
    Dado que existe um produto cadastrado com id "OnpXJdjcWWm357JU"
    Quando envio uma requisição PUT para "/produtos/OnpXJdjcWWm357JU" com o body:
      """
      {
        "nome": "Mouse Razer Viper Mini3",
        "preco": 450,
        "descricao": "House",
        "quantidade": 120
      }
      """
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro alterado com sucesso"

  @produtos @exclusao @sucesso
  Cenário: Deletar um produto existente
    Dado que existe um produto cadastrado com id "OnpXJdjcWWm357JU"
    Quando envio uma requisição DELETE para "/produtos/OnpXJdjcWWm357JU"
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro excluído com sucesso"

  @produtos @exclusao @falha
  Cenário: Tentar deletar produto inexistente
    Quando envio uma requisição DELETE para "/produtos/id_inexistente"
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Nenhum registro excluído"

  @produtos @tabela
  Esquema do Cenário: Cadastrar produtos com diferentes preços
    Quando envio uma requisição POST para "/produtos" com nome "<nome>", preco <preco> e quantidade <quantidade>
    Então o status da resposta deve ser <status>

    Exemplos:
      | nome              | preco | quantidade | status |
      | Teclado Mecânico  | 350   | 50         | 201    |
      | Monitor LG 24"    | 1200  | 10         | 201    |
      | Headset HyperX    | 450   | 30         | 201    |
