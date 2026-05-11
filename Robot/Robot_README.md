# Robot Framework - Testes Web

Esta pasta contém uma suíte Robot Framework organizada para testes web com SeleniumLibrary. A estrutura foi separada entre testes e recursos reutilizáveis para facilitar manutenção, execução local e integração com GitHub Actions.

## Estrutura

```text
Robot/
├── Robot_README.md
├── resources/
│   ├── common.resource
│   ├── formulario.resource
│   └── navegacao.resource
└── tests/
    ├── bdd_formulario.robot
    ├── formulario.robot
    └── navegacao.robot
```

## Cobertura

| Arquivo | Foco | Cenários |
|---|---|---:|
| `tests/bdd_formulario.robot` | Fluxo BDD do formulário LetCode | 1 |
| `tests/formulario.robot` | Formulário válido, obrigatórios e e-mail inválido | 3 |
| `tests/navegacao.robot` | Navegação, botão desabilitado e propriedades visuais | 3 |

**Total: 7 cenários Robot.**

## Padrões Aplicados

- Testes ficam em `Robot/tests`.
- Keywords e locators ficam em `Robot/resources`.
- Dados de teste ficam centralizados em variáveis.
- Não há `Sleep`; os testes usam esperas explícitas.
- O navegador é aberto uma vez por suíte e fechado no `Suite Teardown`.
- Relatórios gerados não devem ser versionados.

## Como Executar

Instale as dependências:

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

Executar por tag:

```bash
robot --include critico --outputdir Robot/results Robot/tests
robot --include formulario --outputdir Robot/results Robot/tests
robot --include navegacao --outputdir Robot/results Robot/tests
```

## GitHub Actions

O workflow `Robot Framework Tests + Allure Report` executa `robot --dryrun` para validar estrutura, imports e keywords sem depender de browser no ambiente de CI. O relatório Allure é publicado em GitHub Pages quando o workflow roda na branch `main`.

## Observação Local

Se a execução real falhar com erro de versão do ChromeDriver, remova drivers antigos do `PATH` ou atualize o ChromeDriver para a mesma versão do Chrome. Com Selenium 4, o Selenium Manager consegue resolver o driver correto quando não existe um driver incompatível no `PATH`.
