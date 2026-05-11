*** Settings ***
Documentation    Cenário BDD para preenchimento válido do formulário LetCode.
Resource         ../resources/formulario.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Tags        robot    web    bdd    formulario    critico


*** Test Cases ***
Cenário: Preencher Formulário Com Dados Válidos
    Given Que Acesso O Formulário Do LetCode
    When Preencho Os Dados Obrigatórios
    And Aceito Os Termos De Uso
    Then O Formulário Deve Ficar Válido


*** Keywords ***
Que Acesso O Formulário Do LetCode
    Acessar Formulário LetCode

Preencho Os Dados Obrigatórios
    Preencher Dados Obrigatórios Do Formulário

Aceito Os Termos De Uso
    Aceitar Termos De Uso

O Formulário Deve Ficar Válido
    Formulário Deve Estar Válido
