# Robot Framework - Testes Web

Esta pasta contem uma suite Robot Framework organizada para testes web com SeleniumLibrary. A estrutura foi separada entre testes e recursos reutilizaveis para facilitar manutencao, execucao local e integracao com GitHub Actions.

## Estrutura

```text
Robot/
|-- Robot_README.md
|-- resources/
|   |-- common.resource
|   |-- dropdowns.resource
|   |-- formulario.resource
|   |-- inputs.resource
|   |-- navegacao.resource
|   `-- radio.resource
`-- tests/
    |-- bdd_formulario.robot
    |-- dropdowns.robot
    |-- formulario.robot
    |-- inputs.robot
    |-- navegacao.robot
    |-- radio_checkbox.robot
    `-- smoke_ci.robot
```

## Cobertura

| Arquivo | Foco | Cenarios |
|---|---|---:|
| `tests/bdd_formulario.robot` | Fluxo BDD do formulario LetCode | 1 |
| `tests/dropdowns.robot` | Dropdown simples, multiplo, linguagem e pais | 4 |
| `tests/formulario.robot` | Formulario valido, obrigatorios e e-mail invalido | 3 |
| `tests/inputs.robot` | Preenchimento, TAB, limpeza, disabled e readonly | 4 |
| `tests/navegacao.robot` | Navegacao, botao desabilitado e propriedades visuais | 3 |
| `tests/radio_checkbox.robot` | Radio buttons, bug conhecido e checkboxes | 5 |
| `tests/smoke_ci.robot` | Smoke real headless usado pelo GitHub Actions | 1 |

**Total: 20 cenarios funcionais + 1 smoke real headless de CI.**

## Padroes Aplicados

- Testes ficam em `Robot/tests`.
- Keywords e locators ficam em `Robot/resources`.
- Dados de teste ficam centralizados em variaveis.
- Nao ha `Sleep`; os testes usam esperas explicitas.
- O navegador e aberto uma vez por suite e fechado no `Suite Teardown`.
- A janela usa tamanho fixo para estabilidade em execucao headless.
- Relatorios gerados nao devem ser versionados.

## Como Executar

Instale as dependencias:

```bash
pip install robotframework robotframework-seleniumlibrary allure-robotframework
```

Validar sintaxe sem abrir navegador:

```bash
robot --dryrun --outputdir Robot/results Robot/tests
```

Executar os testes:

```bash
robot --outputdir Robot/results Robot/tests
```

Executar em Chrome headless:

```bash
robot --variable BROWSER:headlesschrome --outputdir Robot/results Robot/tests
```

Executar somente o smoke real usado no CI:

```bash
robot --include ci_smoke --variable BROWSER:headlesschrome --outputdir Robot/results Robot/tests
```

Executar o smoke gerando resultados para Allure:

```bash
robot --include ci_smoke --variable BROWSER:headlesschrome --listener allure_robotframework:Robot/results/allure-results --outputdir Robot/results Robot/tests
```

Executar por tag:

```bash
robot --include critico --outputdir Robot/results Robot/tests
robot --include formulario --outputdir Robot/results Robot/tests
robot --include navegacao --outputdir Robot/results Robot/tests
robot --include inputs --outputdir Robot/results Robot/tests
robot --include dropdown --outputdir Robot/results Robot/tests
robot --include radio --outputdir Robot/results Robot/tests
```

## GitHub Actions

O workflow `Robot Framework Tests + Allure Report` executa um smoke real em Chrome headless usando a tag `ci_smoke` com o listener `allure_robotframework:Robot/results/allure-results`. Em seguida, roda `robot --dryrun` no restante da suite para validar estrutura, imports e keywords. No CI, o ChromeDriver nao e instalado manualmente; o Selenium Manager resolve o driver compativel com o Chrome disponivel no runner. O relatorio Allure e publicado em GitHub Pages quando o workflow roda na branch `main`.

## Observacao Local

Se a execucao real falhar com erro de versao do ChromeDriver, remova drivers antigos do `PATH` ou atualize o ChromeDriver para a mesma versao do Chrome. Com Selenium 4, o Selenium Manager consegue resolver o driver correto quando nao existe um driver incompatível no `PATH`.
