*** Settings ***
Resource    common.resource


*** Variables ***
${INPUTS_PATH}           /edit
${INPUTS_TITLE}          css=h1.title
${FULL_NAME}             id=fullName
${JOIN}                  id=join
${GET_ME}                id=getMe
${CLEAR_ME}              id=clearMe
${NO_EDIT}               id=noEdit
${READ_ONLY}             id=dontwrite
${VALID_FULL_NAME}       Gabriel da Silva Andrade


*** Keywords ***
Acessar Página De Inputs
    Acessar Página    ${INPUTS_PATH}
    Wait Until Element Is Visible    ${INPUTS_TITLE}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${INPUTS_TITLE}    Input

Preencher Nome Completo
    Clear Element Text    ${FULL_NAME}
    Input Text    ${FULL_NAME}    ${VALID_FULL_NAME}

Nome Completo Deve Estar Preenchido
    Textfield Value Should Be    ${FULL_NAME}    ${VALID_FULL_NAME}

Adicionar Texto Ao Campo Join
    Press Keys    ${JOIN}    ${SPACE}Treinando

Campo Join Deve Conter Texto Concatenado
    Textfield Value Should Be    ${JOIN}    I am good Treinando

Avançar Para Próximo Campo Com Tab
    Press Keys    ${JOIN}    TAB

Campo Get Me Deve Estar Focado
    ${active_id}=    Execute Javascript    return document.activeElement.id
    Should Be Equal    ${active_id}    getMe

Campo Get Me Deve Exibir Valor Esperado
    Textfield Value Should Be    ${GET_ME}    ortonikc

Limpar Campo Clear Me
    Textfield Value Should Be    ${CLEAR_ME}    Koushik Chatterjee
    Clear Element Text    ${CLEAR_ME}

Campo Clear Me Deve Ficar Vazio
    Textfield Value Should Be    ${CLEAR_ME}    ${EMPTY}

Campo No Edit Deve Estar Desabilitado
    Element Should Be Disabled    ${NO_EDIT}

Campo Readonly Deve Estar Bloqueado Para Escrita
    Textfield Value Should Be    ${READ_ONLY}    This text is readonly
    ${readonly}=    Execute Javascript    return document.querySelector('#dontwrite').readOnly
    Should Be True    ${readonly}
