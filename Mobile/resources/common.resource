*** Settings ***
Library    AppiumLibrary


*** Variables ***
${APPIUM_URL}            http://127.0.0.1:4723
${APP_PATH}              ${CURDIR}${/}..${/}apps${/}my-demo-app.apk
${APP_ID}                com.saucelabs.mydemoapp.android
${DEFAULT_TIMEOUT}       20s

${MENU}                  accessibility_id=View menu
${TITULO_CATALOGO}       id=${APP_ID}:id/productTV


*** Keywords ***
Abrir App
    # language e locale fixam o formato de texto e número, mesmo em aparelho pt-BR.
    Open Application    ${APPIUM_URL}
    ...    platformName=Android
    ...    appium:automationName=UiAutomator2
    ...    appium:app=${APP_PATH}
    ...    appium:appWaitActivity=${APP_ID}.view.activities.*
    ...    appium:autoGrantPermissions=${True}
    ...    appium:language=en
    ...    appium:locale=US
    Set Appium Timeout    ${DEFAULT_TIMEOUT}
    Catálogo Deve Estar Visível

Fechar App
    Close All Applications

Catálogo Deve Estar Visível
    Wait Until Element Is Visible    ${TITULO_CATALOGO}    ${DEFAULT_TIMEOUT}
    Element Text Should Be           ${TITULO_CATALOGO}    Products

Abrir Menu
    Wait Until Element Is Visible    ${MENU}    ${DEFAULT_TIMEOUT}
    Click Element                    ${MENU}

Aguardar E Clicar
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Click Element                    ${locator}

Texto Do Elemento Deve Ser
    [Arguments]    ${locator}    ${esperado}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Element Text Should Be           ${locator}    ${esperado}
