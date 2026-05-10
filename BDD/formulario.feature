# language: pt

@bdd @web @formulario
Funcionalidade: Formulário de cadastro LetCode
  Como usuário do formulário
  Quero preencher e validar meus dados cadastrais
  Para garantir que apenas informações consistentes sejam aceitas

  Contexto:
    Dado que estou na página de formulários do LetCode
    E o formulário está limpo

  @formulario @sucesso @critico
  Cenário: Preencher formulário com dados válidos
    Quando preencho o campo "First Name" com "Gabriel"
    E preencho o campo "Last Name" com "da Silva Andrade"
    E preencho o campo "Email" com "gabriel.qa@example.com"
    E seleciono o código de país "55"
    E preencho o campo "Phone" com "1194258073"
    E preencho o campo "Address Line 1" com "Rua das Flores"
    E preencho o campo "Address Line 2" com "Apto 12"
    E preencho o campo "State" com "Sao Paulo"
    E preencho o campo "Postal Code" com "03554150"
    E seleciono o país "Brazil"
    E preencho a data de nascimento com "2001-08-23"
    E seleciono o gênero "Female"
    E aceito os termos de uso
    Então o formulário deve estar válido para envio

  @formulario @validacao @obrigatorio
  Cenário: Bloquear envio com campos obrigatórios vazios
    Quando tento validar o formulário sem preencher os campos obrigatórios
    Então o formulário deve ser marcado como inválido
    E deve existir pelo menos um campo obrigatório inconsistente

  @formulario @validacao @email
  Cenário: Bloquear e-mail em formato inválido
    Quando preencho o campo "First Name" com "Gabriel"
    E preencho o campo "Email" com "email-sem-arroba"
    Então o campo "Email" deve ser marcado como inválido
    E o navegador deve disponibilizar uma mensagem nativa de validação

  @formulario @validacao @termos
  Cenário: Exigir aceite dos termos de uso
    Dado que todos os campos obrigatórios estão preenchidos com dados válidos
    Mas os termos de uso não foram aceitos
    Quando verifico a validade do formulário
    Então o formulário deve permanecer inválido

  @formulario @tabela @validacao
  Esquema do Cenário: Validar combinações de e-mail no cadastro
    Quando preencho o campo "First Name" com "<nome>"
    E preencho o campo "Email" com "<email>"
    Então a validade do campo "Email" deve ser "<validade>"

    Exemplos:
      | nome    | email                  | validade |
      | Gabriel | gabriel.qa@example.com | válido   |
      | Gabriel | email-sem-arroba       | inválido |
      | Gabriel | email@sem-dominio      | inválido |
