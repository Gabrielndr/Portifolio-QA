# language: pt

@bdd @api @usuarios
Funcionalidade: Gerenciamento de usuários na ServeRest
  Como administrador da API
  Quero gerenciar usuários e autenticação
  Para controlar acessos e permissões do sistema

  Contexto:
    Dado que a API ServeRest está disponível

  @usuarios @cadastro @sucesso @critico
  Cenário: Criar usuário administrador com sucesso
    Quando envio uma requisição POST para "/usuarios" com o body:
      """
      {
        "nome": "QA Admin",
        "email": "qa.admin+<timestamp>@teste.com",
        "password": "teste",
        "administrador": "true"
      }
      """
    Então o status da resposta deve ser 201
    E o body deve conter a mensagem "Cadastro realizado com sucesso"
    E o body deve conter um campo "_id" não vazio

  @usuarios @cadastro @falha
  Cenário: Bloquear criação de usuário com e-mail duplicado
    Dado que já existe um usuário cadastrado com e-mail "qa.duplicado@teste.com"
    Quando envio uma requisição POST para "/usuarios" com o mesmo e-mail
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Este email já está sendo usado"

  @usuarios @login @sucesso @critico
  Cenário: Autenticar usuário com credenciais válidas
    Dado que existe um usuário cadastrado com e-mail "qa.login@teste.com" e senha "teste"
    Quando envio uma requisição POST para "/login" com o body:
      """
      {
        "email": "qa.login@teste.com",
        "password": "teste"
      }
      """
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Login realizado com sucesso"
    E o body deve conter um campo "authorization" com Bearer Token

  @usuarios @login @falha @seguranca
  Esquema do Cenário: Bloquear login com credenciais inválidas
    Quando envio uma requisição POST para "/login" com email "<email>" e senha "<senha>"
    Então o status da resposta deve ser 401
    E o body deve conter a mensagem "Email e/ou senha inválidos"

    Exemplos:
      | email                 | senha        |
      | qa.login@teste.com    | senha_errada |
      | inexistente@teste.com | teste        |

  @usuarios @listagem @sucesso
  Cenário: Listar usuários cadastrados
    Dado que estou autenticado com Bearer Token válido
    Quando envio uma requisição GET para "/usuarios"
    Então o status da resposta deve ser 200
    E o body deve retornar uma lista de usuários
    E cada usuário deve conter os campos "nome", "email", "administrador" e "_id"

  @usuarios @exclusao @sucesso
  Cenário: Remover usuário sem carrinho ativo
    Dado que existe um usuário cadastrado sem carrinho ativo
    Quando envio uma requisição DELETE para o usuário criado
    Então o status da resposta deve ser 200
    E o body deve conter a mensagem "Registro excluído com sucesso"

  @usuarios @exclusao @falha
  Cenário: Bloquear exclusão de usuário com carrinho ativo
    Dado que existe um usuário com carrinho ativo
    Quando envio uma requisição DELETE para o usuário com carrinho
    Então o status da resposta deve ser 400
    E o body deve conter a mensagem "Não é permitido excluir usuário com carrinho cadastrado"
