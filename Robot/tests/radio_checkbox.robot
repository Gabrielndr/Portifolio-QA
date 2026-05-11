*** Settings ***
Documentation    Validações de radio buttons e checkboxes do LetCode.
Resource         ../resources/radio.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Setup       Acessar Página De Radio E Checkbox
Test Tags        robot    web    radio    checkbox


*** Test Cases ***
Selecionar Opção No Primeiro Grupo
    [Tags]    sucesso    smoke
    Selecionar Sim No Primeiro Grupo
    Primeiro Grupo Deve Manter Apenas Sim Selecionado

Permitir Apenas Uma Opção No Grupo One Two
    [Tags]    sucesso    validacao
    Selecionar Opção One
    Selecionar Opção Two
    Grupo One Two Deve Permitir Apenas Uma Opção

Evidenciar Bug De Agrupamento
    [Tags]    bug-conhecido    validacao
    Selecionar Opções Do Bloco Find The Bug
    Bug De Agrupamento Deve Ficar Evidente

Identificar Radio Pré-Selecionado E Opção Desabilitada
    [Tags]    validacao    sucesso
    Radio Pré-Selecionado Deve Ser Identificado
    Última Opção De Radio Deve Estar Desabilitada

Validar Checkboxes
    [Tags]    checkbox    sucesso
    Checkbox Inicial Deve Estar Marcado
    Aceitar Termos No Checkbox
    Checkbox De Termos Deve Estar Marcado
