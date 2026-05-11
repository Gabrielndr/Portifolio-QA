*** Settings ***
Documentation    Validações funcionais do formulário LetCode com SeleniumLibrary.
Resource         ../resources/formulario.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Setup       Acessar Formulário LetCode
Test Tags        robot    web    formulario


*** Test Cases ***
Preencher Formulário Com Dados Válidos
    [Tags]    critico    sucesso
    Preencher Dados Obrigatórios Do Formulário
    Aceitar Termos De Uso
    Formulário Deve Estar Válido

Bloquear Formulário Com Campos Obrigatórios Vazios
    [Tags]    validacao    falha
    Formulário Deve Estar Inválido

Bloquear E-mail Em Formato Inválido
    [Tags]    validacao    falha
    Input Text    ${FIRST_NAME}    ${VALID_FIRST_NAME}
    Input Text    ${EMAIL}         email-sem-arroba
    Campo De E-mail Deve Estar Inválido
