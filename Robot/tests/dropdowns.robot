*** Settings ***
Documentation    Validações dos dropdowns do LetCode.
Resource         ../resources/dropdowns.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Setup       Acessar Página De Dropdowns
Test Tags        robot    web    dropdown


*** Test Cases ***
Selecionar Fruta Pelo Texto Visível
    [Tags]    sucesso    smoke
    Selecionar Manga Na Lista De Frutas
    Fruta Selecionada Deve Ser Manga

Selecionar Múltiplos Super-Heróis
    [Tags]    sucesso    multi-select
    Selecionar Super-Heróis
    Super-Heróis Devem Ficar Selecionados

Selecionar Linguagem Pelo Valor
    [Tags]    sucesso    validacao
    Selecionar Linguagem C Sharp
    Linguagem Selecionada Deve Ser C Sharp

Selecionar País Pelo Valor
    [Tags]    sucesso    validacao
    Selecionar País India
    País Selecionado Deve Ser India
