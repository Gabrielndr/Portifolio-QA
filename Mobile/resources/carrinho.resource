*** Settings ***
Resource    common.resource


*** Variables ***
${PRODUTO}               Sauce Labs Backpack

# Na lista, só a imagem abre o produto; por isso o XPath parte do título até a imagem do mesmo card.
${IMAGEM_PRODUTO}        xpath=//android.widget.TextView[@text="${PRODUTO}"]/../android.widget.ImageView[@content-desc="Product Image"]
# A lista e a tela do produto usam o mesmo id no título; filtrar pelo texto evita pegar o título da lista que está saindo da tela.
${TITULO_PRODUTO}        xpath=//*[@resource-id="${APP_ID}:id/productTV" and @text="${PRODUTO}"]
${AUMENTAR_QUANTIDADE}   android=new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().resourceId("${APP_ID}:id/plusIV"))
${ADICIONAR_CARRINHO}    android=new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().resourceId("${APP_ID}:id/cartBt"))

${BADGE_CARRINHO}        id=${APP_ID}:id/cartTV
${ABRIR_CARRINHO}        accessibility_id=View cart
${ITEM_NO_CARRINHO}      id=${APP_ID}:id/titleTV
${TOTAL_ITENS}           id=${APP_ID}:id/itemsTV
${TOTAL_PRECO}           id=${APP_ID}:id/totalPriceTV
${REMOVER_ITEM}          id=${APP_ID}:id/removeBt
${CARRINHO_VAZIO}        id=${APP_ID}:id/noItemTitleTV


*** Keywords ***
Abrir Produto
    Aguardar E Clicar              ${IMAGEM_PRODUTO}
    Texto Do Elemento Deve Ser     ${TITULO_PRODUTO}    ${PRODUTO}

Aumentar Quantidade
    Aguardar E Clicar    ${AUMENTAR_QUANTIDADE}

Adicionar Ao Carrinho
    Aguardar E Clicar    ${ADICIONAR_CARRINHO}

Carrinho Deve Ter Quantidade
    [Arguments]    ${quantidade}
    Texto Do Elemento Deve Ser    ${BADGE_CARRINHO}    ${quantidade}

Abrir Carrinho
    Aguardar E Clicar    ${ABRIR_CARRINHO}

Resumo Do Carrinho Deve Ser
    [Arguments]    ${itens}    ${preco}
    Texto Do Elemento Deve Ser    ${ITEM_NO_CARRINHO}    ${PRODUTO}
    Texto Do Elemento Deve Ser    ${TOTAL_ITENS}         ${itens}
    Texto Do Elemento Deve Ser    ${TOTAL_PRECO}         ${preco}

Remover Item Do Carrinho
    Aguardar E Clicar    ${REMOVER_ITEM}

Carrinho Deve Estar Vazio
    Texto Do Elemento Deve Ser    ${CARRINHO_VAZIO}    No Items
