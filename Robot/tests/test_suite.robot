*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${URL}             https://practicetestautomation.com/practice-test-login/
${VALID_USER}      student
${VALID_PASS}      Password123
${INVALID_USER}    wronguser
${INVALID_PASS}    wrongpass

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    id:username

*** Test Cases ***

Login com credenciais válidas
    [Documentation]    Faz login com dados corretos e verifica mensagem de sucesso
    Input Text    id:username    ${VALID_USER}
    Input Text    id:password    ${VALID_PASS}
    Click Button    id:submit
    Wait Until Page Contains             Logged In Successfully
    Page Should Contain                  Logged In Successfully

Login com credenciais inválidas
    [Documentation]    Testa login errado e verifica mensagem de erro
    Input Text    id:username    ${INVALID_USER}
    Input Text    id:password    ${INVALID_PASS}
    Click Button    id:submit
    Wait Until Page Contains             Your username is invalid!
    Page Should Contain                  Your username is invalid!