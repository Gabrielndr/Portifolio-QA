# language: pt

Funcionalidade: Login e Autenticação
  Como um usuário da plataforma
  Quero realizar login com minhas credenciais
  Para acessar as funcionalidades do sistema

  Contexto:
    Dado que estou na página de login

  @login @sucesso
  Cenário: Login com credenciais válidas
    Quando preencho o campo "usuário" com "mor_2314"
    E preencho o campo "senha" com "83r5^_"
    E clico no botão "Entrar"
    Então devo ser redirecionado para a página inicial
    E devo ver a mensagem de boas-vindas

  @login @falha
  Cenário: Login com senha incorreta
    Quando preencho o campo "usuário" com "mor_2314"
    E preencho o campo "senha" com "senhaerrada"
    E clico no botão "Entrar"
    Então devo ver a mensagem de erro "Usuário e/ou senha inválidos"
    E devo permanecer na página de login

  @login @falha
  Cenário: Login com campos em branco
    Quando deixo o campo "usuário" em branco
    E deixo o campo "senha" em branco
    E clico no botão "Entrar"
    Então devo ver a mensagem de erro "Usuário e/ou senha inválidos"

  @login @falha
  Cenário: Login com usuário inexistente
    Quando preencho o campo "usuário" com "usuario_inexistente"
    E preencho o campo "senha" com "qualquersenha"
    E clico no botão "Entrar"
    Então devo ver a mensagem de erro "Usuário e/ou senha inválidos"

  @login @seguranca
  Cenário: Verificar se a senha está mascarada
    Quando preencho o campo "senha" com "83r5^_"
    Então o campo de senha deve exibir caracteres mascarados

  @login @esqueci-senha
  Cenário: Recuperação de senha
    Quando clico no link "Esqueceu a senha?"
    Então devo ser redirecionado para a página de recuperação de senha
    E devo ver o campo para inserir o e-mail

  @login @tabela
  Esquema do Cenário: Login com múltiplas credenciais
    Quando preencho o campo "usuário" com "<usuario>"
    E preencho o campo "senha" com "<senha>"
    E clico no botão "Entrar"
    Então devo ver o resultado "<resultado>"

    Exemplos:
      | usuario           | senha      | resultado                        |
      | mor_2314          | 83r5^_     | Redirecionado para home          |
      | usuario_invalido  | 83r5^_     | Usuário e/ou senha inválidos     |
      | mor_2314          | senha_errada | Usuário e/ou senha inválidos   |
