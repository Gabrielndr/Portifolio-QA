# language: pt

@bdd @web @auth
Funcionalidade: Login no Fake Store
  Como cliente do Fake Store
  Quero autenticar minha conta
  Para acessar a loja com uma sessão válida

  Contexto:
    Dado que estou na página de login do Fake Store
    E não existe sessão ativa no navegador

  @login @sucesso @critico
  Cenário: Autenticar com credenciais válidas
    Quando informo o usuário "mor_2314"
    E informo a senha "83r5^_"
    E solicito o login
    Então devo ser redirecionado para a página inicial da loja
    E o token de autenticação deve ser salvo na sessão local
    E os dados do usuário autenticado devem ser persistidos

  @login @falha @seguranca
  Cenário: Bloquear autenticação com senha inválida
    Quando informo o usuário "mor_2314"
    E informo a senha "senha_invalida"
    E solicito o login
    Então devo permanecer na página de login
    E nenhum token de autenticação deve ser salvo

  @login @falha @validacao
  Esquema do Cenário: Validar tentativas de login inválidas
    Quando informo o usuário "<usuario>"
    E informo a senha "<senha>"
    E solicito o login
    Então devo permanecer na página de login
    E nenhum token de autenticação deve ser salvo

    Exemplos:
      | usuario            | senha          |
      | usuario_invalido   | 83r5^_         |
      | mor_2314           | senha_errada   |
      | usuario_invalido   | senha_errada   |

  @login @seguranca
  Cenário: Exibir senha de forma mascarada
    Quando informo a senha "83r5^_"
    Então o campo de senha deve manter o tipo "password"
    E o valor digitado não deve ser exibido como texto claro

  @login @sessao
  Cenário: Limpar sessão antes de iniciar novo login
    Dado que existe um token salvo no navegador
    Quando acesso novamente a página de login
    Então a sessão anterior deve ser removida
    E devo visualizar o formulário de autenticação
