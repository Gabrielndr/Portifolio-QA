*** Settings ***
Documentation    Validações de navegação e estado dos botões no LetCode.
Resource         ../resources/navegacao.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Setup       Acessar Página De Botões
Test Tags        robot    web    navegacao


*** Test Cases ***
Botão Home Deve Estar Habilitado Para Navegação
    [Tags]    navegacao    smoke
    Acionar Botão Home
    Acessar Página De Botões
    Caminho Atual Deve Conter    ${BUTTON_PATH}

Botões Devem Exibir Estado Visual Esperado
    [Tags]    interface    sucesso
    Botão De Cor Deve Estar Visível
    Botão De Propriedade Deve Ter Dimensões

Botão Desabilitado Não Deve Permitir Ação
    [Tags]    validacao    sucesso
    Botão Desabilitado Deve Permanecer Sem Interação
