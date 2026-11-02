*** Settings ***
Resource    common.resource


*** Variables ***
${MENU_LISTA}            new UiScrollable(new UiSelector().resourceId("${APP_ID}:id/menuRV"))
${MENU_LOGIN}            android=${MENU_LISTA}.scrollIntoView(new UiSelector().description("Login Menu Item"))
${MENU_LOGOUT}           android=${MENU_LISTA}.scrollIntoView(new UiSelector().description("Logout Menu Item"))

${TITULO_LOGIN}          id=${APP_ID}:id/loginTV
${CAMPO_USUARIO}         id=${APP_ID}:id/nameET
${CAMPO_SENHA}           id=${APP_ID}:id/passwordET
${BOTAO_LOGIN}           id=${APP_ID}:id/loginBtn
${ERRO_USUARIO}          id=${APP_ID}:id/nameErrorTV
${ERRO_SENHA}            id=${APP_ID}:id/passwordErrorTV

# Credenciais públicas exibidas na própria tela de login do app de demonstração.
${USUARIO_VALIDO}        bod@example.com
${USUARIO_BLOQUEADO}     alice@example.com
${SENHA_VALIDA}          10203040


*** Keywords ***
Acessar Tela De Login
    Abrir Menu
    Aguardar E Clicar                ${MENU_LOGIN}
    Wait Until Element Is Visible    ${TITULO_LOGIN}    ${DEFAULT_TIMEOUT}

Preencher Usuário
    [Arguments]    ${usuario}
    Input Text    ${CAMPO_USUARIO}    ${usuario}

Preencher Senha
    [Arguments]    ${senha}
    Input Password    ${CAMPO_SENHA}    ${senha}

Enviar Login
    Click Element    ${BOTAO_LOGIN}

Usuário Deve Estar Autenticado
    Catálogo Deve Estar Visível
    Abrir Menu
    Wait Until Element Is Visible    ${MENU_LOGOUT}    ${DEFAULT_TIMEOUT}
