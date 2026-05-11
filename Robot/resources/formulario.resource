*** Settings ***
Resource    common.resource


*** Variables ***
${FORM_PATH}             /forms
${FIRST_NAME}            id=firstname
${LAST_NAME}             id=lasttname
${EMAIL}                 id=email
${PHONE}                 id=Phno
${COUNTRY_CODE}          xpath=//label[normalize-space(.)="Country code"]/following::select[1]
${ADDRESS_1}             id=Addl1
${ADDRESS_2}             id=Addl2
${STATE}                 id=state
${POSTAL_CODE}           id=postalcode
${COUNTRY}               xpath=//label[normalize-space(.)="Country"]/following::select[1]
${BIRTH_DATE}            id=Date
${GENDER_FEMALE}         id=female
${TERMS}                 css=.checkbox input[type="checkbox"]
${SUBMIT}                css=input[type="submit"]

${VALID_FIRST_NAME}      Gabriel
${VALID_LAST_NAME}       da Silva Andrade
${VALID_EMAIL}           gabriel.qa@example.com
${VALID_PHONE}           1194258073
${VALID_ADDRESS_1}       Rua das Flores
${VALID_ADDRESS_2}       Apto 12
${VALID_STATE}           Sao Paulo
${VALID_POSTAL_CODE}     03554150
${VALID_BIRTH_DATE}      2001-08-23


*** Keywords ***
Acessar Formulário LetCode
    Acessar Página    ${FORM_PATH}
    Wait Until Element Is Visible    css=h1    ${DEFAULT_TIMEOUT}
    Element Text Should Be    css=h1    Form

Preencher Dados Obrigatórios Do Formulário
    Input Text    ${FIRST_NAME}       ${VALID_FIRST_NAME}
    Input Text    ${LAST_NAME}        ${VALID_LAST_NAME}
    Input Text    ${EMAIL}            ${VALID_EMAIL}
    Select From List By Value         ${COUNTRY_CODE}    55
    Input Text    ${PHONE}            ${VALID_PHONE}
    Input Text    ${ADDRESS_1}        ${VALID_ADDRESS_1}
    Input Text    ${ADDRESS_2}        ${VALID_ADDRESS_2}
    Input Text    ${STATE}            ${VALID_STATE}
    Input Text    ${POSTAL_CODE}      ${VALID_POSTAL_CODE}
    Select From List By Value         ${COUNTRY}         Brazil
    Input Text    ${BIRTH_DATE}       ${VALID_BIRTH_DATE}
    Selecionar Gênero Feminino

Aceitar Termos De Uso
    Execute Javascript    document.querySelector('.checkbox input[type="checkbox"]').click()

Selecionar Gênero Feminino
    Execute Javascript    document.querySelector('#female').click()

Enviar Formulário
    Click Element    ${SUBMIT}

Formulário Deve Estar Válido
    ${valid}=    Execute Javascript    return document.querySelector('form').checkValidity()
    Should Be True    ${valid}

Formulário Deve Estar Inválido
    ${valid}=    Execute Javascript    return document.querySelector('form').checkValidity()
    Should Not Be True    ${valid}

Campo De E-mail Deve Estar Inválido
    ${valid}=    Execute Javascript    return document.querySelector('#email').checkValidity()
    ${message}=    Execute Javascript    return document.querySelector('#email').validationMessage
    Should Not Be True    ${valid}
    Should Not Be Empty    ${message}
