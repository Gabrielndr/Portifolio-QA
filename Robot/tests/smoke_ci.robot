*** Settings ***
Documentation    Smoke real para validar execucao headless do Robot Framework no CI.
Resource         ../resources/common.resource
Suite Setup      Abrir Navegador LetCode
Suite Teardown   Fechar Navegadores
Test Tags        robot    ci_smoke    smoke    web


*** Test Cases ***
Abrir Formulario LetCode Em Chrome Headless
    Acessar Página    /forms
    Wait Until Element Is Visible    id=firstname    ${DEFAULT_TIMEOUT}
    Element Should Be Visible        id=email
