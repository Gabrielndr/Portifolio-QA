*** Settings ***
Documentation    Validações de login do app Flutter QA Tarefas em iOS com Appium.
Resource         ../resources/login.resource
Test Setup       Abrir App
Test Teardown    Fechar App
Test Tags        robot    mobile    ios    flutter    login


*** Test Cases ***
Login Com Credenciais Válidas
    [Tags]    critico    sucesso
    Preencher Usuário    ${USUARIO_VALIDO}
    Preencher Senha      ${SENHA_VALIDA}
    Enviar Login
    Usuário Deve Estar Autenticado

Bloquear Login Sem Usuário
    [Tags]    validacao    falha
    Enviar Login
    Mensagem De Erro Deve Ser    Informe o usuário

Bloquear Login Sem Senha
    [Tags]    validacao    falha
    Preencher Usuário    ${USUARIO_VALIDO}
    Enviar Login
    Mensagem De Erro Deve Ser    Informe a senha

Bloquear Login Com Senha Inválida
    [Tags]    validacao    falha
    Preencher Usuário    ${USUARIO_VALIDO}
    Preencher Senha      senha-errada
    Enviar Login
    Mensagem De Erro Deve Ser    Usuário ou senha inválidos
