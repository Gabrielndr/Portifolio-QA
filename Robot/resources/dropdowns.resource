*** Settings ***
Resource    common.resource


*** Variables ***
${DROPDOWNS_PATH}        /dropdowns
${DROPDOWNS_TITLE}       css=h1
${FRUITS}                id=fruits
${SUPER_HEROES}          id=superheros
${LANGUAGE}              id=lang
${COUNTRY_SELECT}        id=country


*** Keywords ***
Acessar Página De Dropdowns
    Acessar Página    ${DROPDOWNS_PATH}
    Wait Until Element Is Visible    ${DROPDOWNS_TITLE}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${DROPDOWNS_TITLE}    Dropdown

Selecionar Manga Na Lista De Frutas
    Select From List By Label    ${FRUITS}    Mango

Fruta Selecionada Deve Ser Manga
    ${value}=    Execute Javascript    return document.querySelector('#fruits').value
    ${label}=    Execute Javascript    return document.querySelector('#fruits').selectedOptions[0].textContent.trim()
    Should Be Equal    ${value}    1
    Should Be Equal    ${label}    Mango

Selecionar Super-Heróis
    Select From List By Value    ${SUPER_HEROES}    ta    bt    im

Super-Heróis Devem Ficar Selecionados
    ${labels}=    Execute Javascript    return Array.from(document.querySelector('#superheros').selectedOptions).map(option => option.textContent.trim()).join('|')
    ${total}=     Execute Javascript    return document.querySelector('#superheros').selectedOptions.length
    Should Contain    ${labels}    The Avengers
    Should Contain    ${labels}    Batman
    Should Contain    ${labels}    Iron Man
    Should Be Equal As Integers    ${total}    3

Selecionar Linguagem C Sharp
    Select From List By Value    ${LANGUAGE}    sharp

Linguagem Selecionada Deve Ser C Sharp
    ${value}=    Execute Javascript    return document.querySelector('#lang').value
    ${label}=    Execute Javascript    return document.querySelector('#lang').selectedOptions[0].textContent.trim()
    Should Be Equal    ${value}    sharp
    Should Be Equal    ${label}    C#

Selecionar País India
    Select From List By Value    ${COUNTRY_SELECT}    India

País Selecionado Deve Ser India
    ${value}=    Execute Javascript    return document.querySelector('#country').value
    ${label}=    Execute Javascript    return document.querySelector('#country').selectedOptions[0].textContent.trim()
    Should Be Equal    ${value}    India
    Should Be Equal    ${label}    India
