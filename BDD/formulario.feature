# language: pt

Funcionalidade: Preenchimento de Formulário Web
  Como um usuário da plataforma
  Quero preencher o formulário de cadastro
  Para registrar meus dados pessoais no sistema

  Contexto:
    Dado que estou na página "https://letcode.in/forms"
    E o navegador está configurado com resolução 1920x1080

  @formulario @sucesso
  Cenário: Preencher formulário completo com sucesso
    Quando preencho o campo "First Name" com "Gabriel"
    E preencho o campo "Last Name" com "Andrade"
    E preencho o campo "Email" com "teste@gmail.com"
    E seleciono o DDI "55" no campo de código de país
    E preencho o campo "Phone" com "11942528073"
    E preencho o campo "Address Line 1" com "Rua asmania"
    E preencho o campo "Address Line 2" com "Rua lituania"
    E preencho o campo "State" com "São Paulo"
    E preencho o campo "Postal Code" com "03554150"
    E seleciono o país "Brazil"
    E preencho a data de nascimento com "23-08-2001"
    E seleciono o gênero "Masculino"
    E marco o checkbox de termos de uso
    E clico no botão "Submit"
    Então o formulário deve ser enviado com sucesso

  @formulario @validacao
  Cenário: Tentar submeter formulário sem campos obrigatórios
    Quando clico no botão "Submit" sem preencher nenhum campo
    Então devo ver mensagens de validação nos campos obrigatórios

  @formulario @validacao
  Cenário: Tentar submeter formulário com e-mail inválido
    Quando preencho o campo "First Name" com "Gabriel"
    E preencho o campo "Email" com "emailsemarroba"
    E clico no botão "Submit"
    Então devo ver mensagem de erro no campo "Email"

  @formulario @campos
  Cenário: Verificar campo somente leitura
    Então o campo "getMe" deve conter o valor "ortonikc"
    E o campo "dontwrite" deve estar com atributo "readonly"

  @formulario @campos
  Cenário: Limpar e redigitar campo de texto
    Quando limpo o campo "join"
    E preencho o campo "join" com "Treinando"
    Então o campo "join" deve conter o valor "Treinando"

  @formulario @dropdown
  Cenário: Validar seleção em dropdowns
    Quando seleciono "Mango" no dropdown "fruits"
    E seleciono "The Avengers" no dropdown "superheros"
    E seleciono "Python" no dropdown "lang"
    E seleciono "Brazil" no dropdown "country"
    Então todos os dropdowns devem exibir os valores selecionados

  @formulario @tabela
  Esquema do Cenário: Preencher formulário com diferentes dados
    Quando preencho o campo "First Name" com "<nome>"
    E preencho o campo "Email" com "<email>"
    E clico no botão "Submit"
    Então devo ver o resultado "<resultado>"

    Exemplos:
      | nome    | email                    | resultado           |
      | Gabriel | gabriel@gmail.com        | Formulário enviado  |
      | João    | joao@email.com           | Formulário enviado  |
      |         | semnome@email.com        | Erro de validação   |
