*** Settings ***
Documentation    Validações de carrinho do My Demo App em Android com Appium.
Resource         ../resources/carrinho.resource
Test Setup       Abrir App
Test Teardown    Fechar App
Test Tags        robot    mobile    android    carrinho


*** Test Cases ***
Adicionar Produto Ao Carrinho
    [Tags]    critico    sucesso
    Abrir Produto
    Adicionar Ao Carrinho
    Carrinho Deve Ter Quantidade    1
    Abrir Carrinho
    Resumo Do Carrinho Deve Ser     1 Items    $ 29.99

Adicionar Duas Unidades Do Produto
    [Tags]    sucesso
    Abrir Produto
    Aumentar Quantidade
    Adicionar Ao Carrinho
    Carrinho Deve Ter Quantidade    2
    Abrir Carrinho
    Resumo Do Carrinho Deve Ser     2 Items    $ 59.98

Remover Produto Do Carrinho
    [Tags]    sucesso
    Abrir Produto
    Adicionar Ao Carrinho
    Abrir Carrinho
    Remover Item Do Carrinho
    Carrinho Deve Estar Vazio
