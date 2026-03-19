# language: pt

Funcionalidade: Gerenciamento de Usuários
  Como um administrador da plataforma
  Quero gerenciar os usuários do sistema
  Para controlar os acessos e permissões

  Contexto:
    Dado que a API está disponível em "{{Base_URL}}"

  @usuarios @cadastro @sucesso
  Cenário: Criar um novo usuário administrador com sucesso
    Quando envio uma requisição POST para "/usuarios" com o body:
      """
      {
        "nome": "Qzin Andrade",
        "email": "qzin@qa.com.br",
        "password": "teste",
        "administrador": "true"
      }
      """
    Então o status da resposta deve ser 201
    E o body deve conter a mensagem "Cadastro realizado com sucesso"
    E o body deve conter um campo "_id" não vazio

  @usuarios @cadastro @falha
  Cenário: Tentar criar usuário com e-mail já cadastrado
    Dado que já existe um usuário com e-mail "qzin@qa.com.br"
    Quando envio uma requisição POST para "/usuarios" com o mesmo e-mail
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Este email já está sendo usado"

  @usuarios @login @sucesso
  Cenário: Realizar login com credenciais válidas
    Dado que existe um usuário cadastrado com e-mail "qzin@qa.com.br" e senha "teste"
    Quando envio uma requisição POST para "/login" com o body:
      """
      {
        "email": "qzin@qa.com.br",
        "password": "teste"
      }
      """
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Login realizado com sucesso"
    E o body deve conter um campo "authorization" com Bearer Token

  @usuarios @login @falha
  Cenário: Tentar login com senha incorreta
    Quando envio uma requisição POST para "/login" com o body:
      """
      {
        "email": "qzin@qa.com.br",
        "password": "senha_errada"
      }
      """
    Então o status da resposta deve ser 401
    E o body deve conter a mensagem "Email e/ou senha inválidos"

  @usuarios @listagem @sucesso
  Cenário: Listar todos os usuários cadastrados
    Dado que estou autenticado com Bearer Token válido
    Quando envio uma requisição GET para "/usuarios"
    Então o status da resposta deve ser 200
    E o body deve retornar uma lista de usuários
    E cada usuário deve conter os campos "nome", "email", "administrador" e "_id"

  @usuarios @exclusao @sucesso
  Cenário: Deletar um usuário existente
    Dado que existe um usuário cadastrado com id "PNeX31c09hgN8ReJ"
    Quando envio uma requisição DELETE para "/usuarios/PNeX31c09hgN8ReJ"
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro excluído com sucesso"

  @usuarios @exclusao @falha
  Cenário: Tentar deletar usuário com carrinho ativo
    Dado que o usuário com id "PNeX31c09hgN8ReJ" possui um carrinho ativo
    Quando envio uma requisição DELETE para "/usuarios/PNeX31c09hgN8ReJ"
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Não é permitido excluir usuário com carrinho cadastrado"

  @usuarios @tabela
  Esquema do Cenário: Criar usuários com diferentes perfis
    Quando envio uma requisição POST para "/usuarios" com nome "<nome>", email "<email>" e administrador "<admin>"
    Então o status da resposta deve ser <status>

    Exemplos:
      | nome         | email               | admin | status |
      | QA Tester    | qa@teste.com        | false | 201    |
      | Admin User   | admin@teste.com     | true  | 201    |
      | QA Tester    | qa@teste.com        | false | 400    |
