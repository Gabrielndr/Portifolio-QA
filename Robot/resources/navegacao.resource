*** Settings ***
Resource    common.resource


*** Variables ***
${BUTTON_PATH}           /button
${BUTTON_HOME}           id=home
${BUTTON_COLOR}          id=color
${BUTTON_PROPERTY}       id=property
${BUTTON_DISABLED}       id=isDisabled


*** Keywords ***
Acessar Página De Botões
    Acessar Página    ${BUTTON_PATH}
    Wait Until Element Is Visible    ${BUTTON_HOME}    ${DEFAULT_TIMEOUT}

Acionar Botão Home
    Wait Until Element Is Enabled    ${BUTTON_HOME}    ${DEFAULT_TIMEOUT}
    Click Element    ${BUTTON_HOME}

Botão De Cor Deve Estar Visível
    Wait Until Element Is Visible    ${BUTTON_COLOR}    ${DEFAULT_TIMEOUT}
    Element Should Be Visible    ${BUTTON_COLOR}

Botão Desabilitado Deve Permanecer Sem Interação
    Element Should Be Disabled    ${BUTTON_DISABLED}

Botão De Propriedade Deve Ter Dimensões
    ${width}=     Execute Javascript    return document.querySelector('#property').getBoundingClientRect().width
    ${height}=    Execute Javascript    return document.querySelector('#property').getBoundingClientRect().height
    Should Be True    ${width} > 0
    Should Be True    ${height} > 0
