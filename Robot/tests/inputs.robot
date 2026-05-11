*** Settings ***
Documentation    Validações dos campos de input do LetCode.
Resource         ../resources/inputs.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Setup       Acessar Página De Inputs
Test Tags        robot    web    inputs


*** Test Cases ***
Preencher Nome Completo
    [Tags]    sucesso    smoke
    Preencher Nome Completo
    Nome Completo Deve Estar Preenchido

Adicionar Texto E Navegar Com Tab
    [Tags]    navegacao    sucesso
    Adicionar Texto Ao Campo Join
    Campo Join Deve Conter Texto Concatenado
    Avançar Para Próximo Campo Com Tab
    Campo Get Me Deve Estar Focado

Validar Valor Pre-Carregado
    [Tags]    validacao    sucesso
    Campo Get Me Deve Exibir Valor Esperado

Limpar Campo E Validar Bloqueios
    [Tags]    validacao    sucesso
    Limpar Campo Clear Me
    Campo Clear Me Deve Ficar Vazio
    Campo No Edit Deve Estar Desabilitado
    Campo Readonly Deve Estar Bloqueado Para Escrita
