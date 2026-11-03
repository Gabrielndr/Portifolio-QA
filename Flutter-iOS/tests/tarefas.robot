*** Settings ***
Documentation    Validações da lista de tarefas do app Flutter QA Tarefas em iOS com Appium.
Resource         ../resources/tarefas.resource
Test Setup       Abrir App E Fazer Login
Test Teardown    Fechar App
Test Tags        robot    mobile    ios    flutter    tarefas


*** Test Cases ***
Adicionar Tarefa
    [Tags]    critico    sucesso
    Lista Deve Estar Vazia
    Adicionar Tarefa       Revisar critérios de aceite
    Tarefa Deve Ser        0    Revisar critérios de aceite
    Pendentes Devem Ser    1

Concluir Tarefa Atualiza Pendentes
    [Tags]    sucesso
    Adicionar Tarefa       Executar regressão
    Adicionar Tarefa       Reportar bug
    Pendentes Devem Ser    2
    Concluir Tarefa        0
    Pendentes Devem Ser    1

Remover Tarefa
    [Tags]    sucesso
    Adicionar Tarefa       Tarefa temporária
    Remover Tarefa         0
    Lista Deve Estar Vazia
    Pendentes Devem Ser    0

Bloquear Tarefa Sem Título
    [Tags]    validacao    falha
    Click Element                ${BOTAO_ADICIONAR}
    Mensagem De Erro Deve Ser    Informe o título da tarefa
    Lista Deve Estar Vazia

Sair Volta Para O Login
    [Tags]    sucesso
    Sair Do App


*** Keywords ***
Abrir App E Fazer Login
    Abrir App
    Fazer Login Válido
