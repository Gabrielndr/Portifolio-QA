*** Settings ***
Library     SeleniumLibrary



*** Variables ***
${input_name}           id:firstname
${input_lasttname}      id:lasttname
${input_email}          id:email
${input_Phno}           id:Phno
${select_code}          css:select
${input_Addl1}          id:Addl1
${input_Addl2}          id:Addl2
${input_state}          id:state
${input_postalcode}     id:postalcode  
${select_country}       xpath=//label[normalize-space(.)="Country"]/following::select[1]
${input_date}           id:Date
${input_male}           id:male
${input_check}          css:input[type="checkbox"]
${input_submit}         css:.button.is-primary


*** Keywords ***
Abrir navegador e Acessar site
    Open Browser    https://letcode.in/forms    chrome  
    Set Selenium Speed    0.5s


Preencher campos
    Input text                   ${input_name}           Gabriel
    Input text                   ${input_lasttname}      Andrade
    Input text                   ${input_email}          teste@gmail.com
    Select From List By Value    ${select_code}          55
    Input text                   ${input_Phno}           11942528073 
    Input text                   ${input_Addl1}          Rua asmania
    Input text                   ${input_Addl2}          Rua lituania
    Input text                   ${input_state}          São Paulo
    Input text                   ${input_postalcode}     03554150
    Select From List By Value    ${select_country}       Brazil
    Input Text                   ${input_date}           23-08-2001
    Click Element                ${input_male}
    Click Element                ${input_check}
    
    
Clicar em submit
    Click Element    ${input_submit}


Fechar navegador
    close browser


***Test Cases ***
Cenario 1: Preencher formulario 
    Abrir navegador e Acessar site 
    Preencher campos
    Clicar em submit
    Fechar navegador
 
    