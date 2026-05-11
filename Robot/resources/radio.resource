*** Settings ***
Resource    common.resource


*** Variables ***
${RADIO_PATH}            /radio
${RADIO_TITLE}           css=h1.title
${YES}                   id=yes
${NO}                    id=no
${ONE}                   id=one
${TWO}                   id=two
${NO_BUG}                id=nobug
${BUG}                   id=bug
${FOO}                   id=foo
${NOT_FOO}               id=notfoo
${GOING}                 id=going
${NOT_GOING}             id=notG
${MAYBE}                 id=maybe


*** Keywords ***
Acessar Página De Radio E Checkbox
    Acessar Página    ${RADIO_PATH}
    Wait Until Element Is Visible    ${RADIO_TITLE}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${RADIO_TITLE}    Radio & Checkbox

Selecionar Sim No Primeiro Grupo
    Execute Javascript    document.querySelector('#yes').click()

Primeiro Grupo Deve Manter Apenas Sim Selecionado
    Campo Marcado Deve Ser    yes    ${True}
    Campo Marcado Deve Ser    no     ${False}

Selecionar Opção One
    Execute Javascript    document.querySelector('#one').click()

Selecionar Opção Two
    Execute Javascript    document.querySelector('#two').click()

Grupo One Two Deve Permitir Apenas Uma Opção
    Campo Marcado Deve Ser    two    ${True}
    Campo Marcado Deve Ser    one    ${False}

Selecionar Opções Do Bloco Find The Bug
    Execute Javascript    document.querySelector('#nobug').click()
    Execute Javascript    document.querySelector('#bug').click()

Bug De Agrupamento Deve Ficar Evidente
    Campo Marcado Deve Ser    nobug    ${True}
    Campo Marcado Deve Ser    bug      ${True}

Radio Pré-Selecionado Deve Ser Identificado
    Campo Marcado Deve Ser    foo       ${False}
    Campo Marcado Deve Ser    notfoo    ${True}

Última Opção De Radio Deve Estar Desabilitada
    Element Should Be Enabled     ${GOING}
    Element Should Be Enabled     ${NOT_GOING}
    Element Should Be Disabled    ${MAYBE}

Checkbox Inicial Deve Estar Marcado
    ${checked}=    Execute Javascript    return Array.from(document.querySelectorAll('.field')).find(field => field.innerText.includes('Find if the checkbox is selected?')).querySelector('input[type="checkbox"]').checked
    Should Be True    ${checked}

Aceitar Termos No Checkbox
    Execute Javascript    Array.from(document.querySelectorAll('.field')).find(field => field.innerText.includes('Accept the T&C')).querySelector('input[type="checkbox"]').click()

Checkbox De Termos Deve Estar Marcado
    ${checked}=    Execute Javascript    return Array.from(document.querySelectorAll('.field')).find(field => field.innerText.includes('Accept the T&C')).querySelector('input[type="checkbox"]').checked
    Should Be True    ${checked}

Campo Marcado Deve Ser
    [Arguments]    ${element_id}    ${expected}
    ${checked}=    Execute Javascript    return document.querySelector('#${element_id}').checked
    Should Be Equal    ${checked}    ${expected}
