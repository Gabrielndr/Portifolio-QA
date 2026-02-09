*** Settings ***
Library  SeleniumLibrary
Variables  ../variables/common_variables.py

Suite Setup     Open Browser To Login Page
Suite Teardown  Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    id:username

Fill Login Form
    [Arguments]    ${user}    ${pass}
    Input Text    id:username    ${user}
    Input Text    id:password    ${pass}
    Click Button  id:login-button

Verify Login Success
    Wait Until Location Contains    ${DASHBOARD_URL}
    Page Should Contain Element     xpath://h1[contains(., "Dashboard")]
    Log    Login verificado com sucesso!

Navigate To Profile
    Click Link    text:Perfil
    Wait Until Page Contains Element    id:profile-title
    Page Should Contain    Meu Perfil

Update Profile Info
    [Arguments]    ${name}    ${email}
    Input Text    id:name    ${name}
    Input Text    id:email   ${email}
    Click Button   id:update-profile
    Wait Until Page Contains    Perfil atualizado com sucesso

Logout
    Click Link    text:Sair
    Wait Until Page Contains Element    id:login-title