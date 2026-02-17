*** Settings ***
Library     SeleniumLibrary



*** Variables ***



*** Keywords ***
Abrir site do google
    Open Browser    https://www.google.com.br  chrome

Fechar navegador
    Close Browser

Abrir site da globo
    Open Browser    https://www.globo.com/  chrome

Fechar navegador
    Close Browser

***Test Cases ***
Cenario 1: Teste de abrir site google
    Abrir site do google    
    Fechar site do google

Cenario 2: Abrir o site da Globo
    Abrir site da globo    
    Fechar site da globo
    


