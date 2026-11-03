*** Settings ***
Library    AppiumLibrary
Library    Collections


*** Variables ***
${APPIUM_URL}            http://127.0.0.1:4723
${APP_PATH}              ${CURDIR}${/}..${/}app${/}build${/}ios${/}iphonesimulator${/}Runner.app
# Informe o UDID do simulador com --variable UDID:<id>. Vazio deixa o Appium escolher.
${UDID}                  ${EMPTY}
${DEFAULT_TIMEOUT}       20s

${TITULO_LOGIN}          accessibility_id=titulo_login
${MENSAGEM_ERRO}         accessibility_id=mensagem_erro


*** Keywords ***
Abrir App
    # O primeiro teste compila o WebDriverAgent no simulador, por isso o timeout longo.
    &{capacidades}    Create Dictionary
    ...    platformName=iOS
    ...    appium:automationName=XCUITest
    ...    appium:app=${APP_PATH}
    ...    appium:wdaLaunchTimeout=${240000}
    ...    appium:newCommandTimeout=${120}
    IF    $UDID    Set To Dictionary    ${capacidades}    appium:udid=${UDID}
    Open Application    ${APPIUM_URL}    &{capacidades}
    Set Appium Timeout    ${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${TITULO_LOGIN}    ${DEFAULT_TIMEOUT}

Fechar App
    Close All Applications

Aguardar E Clicar
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Click Element                    ${locator}

Texto Do Elemento Deve Ser
    [Arguments]    ${locator}    ${esperado}
    Wait Until Element Is Visible    ${locator}    ${DEFAULT_TIMEOUT}
    Element Text Should Be           ${locator}    ${esperado}

Mensagem De Erro Deve Ser
    [Arguments]    ${esperado}
    Texto Do Elemento Deve Ser    ${MENSAGEM_ERRO}    ${esperado}
