*** Settings ***
Resource    login.resource


*** Variables ***
${CAMPO_TAREFA}          chain=**/XCUIElementTypeTextField
${BOTAO_ADICIONAR}       accessibility_id=botao_adicionar
${BOTAO_SAIR}            accessibility_id=botao_sair
${CONTADOR}              accessibility_id=contador_pendentes
${LISTA_VAZIA}           accessibility_id=lista_vazia


*** Keywords ***
Adicionar Tarefa
    [Arguments]    ${titulo}
    Wait Until Element Is Visible    ${CAMPO_TAREFA}    ${DEFAULT_TIMEOUT}
    Input Text                       ${CAMPO_TAREFA}    ${titulo}
    Click Element                    ${BOTAO_ADICIONAR}

Concluir Tarefa
    [Arguments]    ${indice}
    Aguardar E Clicar    accessibility_id=concluir_${indice}

Remover Tarefa
    [Arguments]    ${indice}
    Aguardar E Clicar    accessibility_id=remover_${indice}

Tarefa Deve Ser
    [Arguments]    ${indice}    ${titulo}
    Texto Do Elemento Deve Ser    accessibility_id=tarefa_${indice}    ${titulo}

Pendentes Devem Ser
    [Arguments]    ${quantidade}
    Texto Do Elemento Deve Ser    ${CONTADOR}    Pendentes: ${quantidade}

Lista Deve Estar Vazia
    Texto Do Elemento Deve Ser    ${LISTA_VAZIA}    Nenhuma tarefa cadastrada

Sair Do App
    Aguardar E Clicar                ${BOTAO_SAIR}
    Wait Until Element Is Visible    ${TITULO_LOGIN}    ${DEFAULT_TIMEOUT}
