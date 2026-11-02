*** Settings ***
Documentation    Validações de login do My Demo App em Android com Appium.
Resource         ../resources/login.resource
Test Setup       Abrir App
Test Teardown    Fechar App
Test Tags        robot    mobile    android    login


*** Test Cases ***
Login Com Credenciais Válidas
    [Tags]    critico    sucesso
    Acessar Tela De Login
    Preencher Usuário    ${USUARIO_VALIDO}
    Preencher Senha      ${SENHA_VALIDA}
    Enviar Login
    Usuário Deve Estar Autenticado

Bloquear Login Sem Usuário
    [Tags]    validacao    falha
    Acessar Tela De Login
    Enviar Login
    Texto Do Elemento Deve Ser    ${ERRO_USUARIO}    Username is required

Bloquear Login Sem Senha
    [Tags]    validacao    falha
    Acessar Tela De Login
    Preencher Usuário    ${USUARIO_VALIDO}
    Enviar Login
    Texto Do Elemento Deve Ser    ${ERRO_SENHA}    Enter Password

Bloquear Login De Usuário Bloqueado
    [Tags]    validacao    falha
    Acessar Tela De Login
    Preencher Usuário    ${USUARIO_BLOQUEADO}
    Preencher Senha      ${SENHA_VALIDA}
    Enviar Login
    Texto Do Elemento Deve Ser    ${ERRO_SENHA}    Sorry this user has been locked out.
