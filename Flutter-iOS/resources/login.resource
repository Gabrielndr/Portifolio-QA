*** Settings ***
Resource    common.resource


*** Variables ***
# Flutter não expõe identificador em TextField, então os campos são localizados pela posição.
# O campo de senha nem sempre aparece como SecureTextField no iOS, por isso o filtro aceita os dois tipos.
${CAMPO_TEXTO}           XCUIElementTypeAny[`type == 'XCUIElementTypeTextField' OR type == 'XCUIElementTypeSecureTextField'`]
# A barra antes do colchete evita que o Robot interprete [1] como acesso a item da variável.
${CAMPO_USUARIO}         chain=**/${CAMPO_TEXTO}\[1]
${CAMPO_SENHA}           chain=**/${CAMPO_TEXTO}\[2]
${BOTAO_ENTRAR}          accessibility_id=botao_entrar
${TITULO_TAREFAS}        accessibility_id=titulo_tarefas
${SAUDACAO}              accessibility_id=saudacao

# Credenciais fixas definidas no próprio app de estudo (Flutter-iOS/app/lib/main.dart).
${USUARIO_VALIDO}        qa@portfolio.dev
${SENHA_VALIDA}          Senha@123


*** Keywords ***
Preencher Usuário
    [Arguments]    ${usuario}
    Wait Until Element Is Visible    ${CAMPO_USUARIO}    ${DEFAULT_TIMEOUT}
    Input Text                       ${CAMPO_USUARIO}    ${usuario}

Preencher Senha
    [Arguments]    ${senha}
    Input Password    ${CAMPO_SENHA}    ${senha}

Enviar Login
    Aguardar E Clicar    ${BOTAO_ENTRAR}

Fazer Login Válido
    Preencher Usuário    ${USUARIO_VALIDO}
    Preencher Senha      ${SENHA_VALIDA}
    Enviar Login
    Usuário Deve Estar Autenticado

Usuário Deve Estar Autenticado
    Wait Until Element Is Visible    ${TITULO_TAREFAS}    ${DEFAULT_TIMEOUT}
    Texto Do Elemento Deve Ser       ${SAUDACAO}    Olá, ${USUARIO_VALIDO}
