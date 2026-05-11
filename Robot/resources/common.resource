*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BASE_URL}              https://letcode.in
${BROWSER}               chrome
${DEFAULT_TIMEOUT}       15s
${SELENIUM_SPEED}        0s


*** Keywords ***
Abrir Navegador LetCode
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${SELENIUM_SPEED}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Fechar Navegadores
    Close All Browsers

Acessar Página
    [Arguments]    ${path}
    Go To    ${BASE_URL}${path}
    Wait Until Location Contains    ${path}    ${DEFAULT_TIMEOUT}

Caminho Atual Deve Conter
    [Arguments]    ${path}
    Location Should Contain    ${path}

Caminho Atual Não Deve Conter
    [Arguments]    ${path}
    ${location}=    Get Location
    Should Not Contain    ${location}    ${path}
