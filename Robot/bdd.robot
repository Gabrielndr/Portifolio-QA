*** Settings ***
Library     SeleniumLibrary


*** Variables ***
#Dado do teste
${Nome_Musica}  Natiruts Quero ser feliz

#Varaiveis de configuração
${URL}  https://www.youtube.com/
${Browser}  chrome

#Elementos
${Input_pesquisa}      xpath=//input[@name="search_query"]
${button_pesquisa}     xpath=//button[@title="Pesquisar"]
${Segundo}             xpath=(//ytd-video-renderer//a[@id="video-title"])[2]
${Prova}               xpath=//h1//yt-formatted-string


*** Keywords ***
Given Que eu acesso o site do youtube
    Open Browser                        ${URL}  ${Browser}
    Set Selenium Speed                  0.5s


When Digito o nome da muisca 
    Input text                          ${Input_pesquisa}  ${Nome_Musica}


And CLico no botão buscar
    Click Element                       ${button_pesquisa}


And Clico na primeira opção da lista
    Click Element                       ${Segundo}    
    

Then O video é executado
    Wait Until Element Is Visible       ${Prova}    10s
    Element Should Contain              ${Prova}    Quero Ser Feliz
    Close Browser


***Test Cases ***
Cenario 1: Executar video do site do youtube
    Given Que eu acesso o site do youtube
    When Digito o nome da muisca
    And CLico no botão buscar
    And Clico na primeira opção da lista 
    Then O video é executado