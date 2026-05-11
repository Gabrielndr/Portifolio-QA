# Portfólio QA - Gabriel da Silva

Bem-vindo ao meu portfólio de Quality Assurance. Este repositório reúne testes automatizados de UI, API, performance, BDD, Robot Framework, Postman/Newman e pipelines de CI/CD.

O objetivo é demonstrar organização de suíte, clareza de cenários, boas práticas de automação, evidência de execução e capacidade de estruturar testes para diferentes camadas de uma aplicação.

---

## Sobre Mim

Sou **Gabriel da Silva**, QA Engineer com mais de 5 anos de experiência em qualidade de software. Atuei em projetos de grande escala nos setores financeiro e de aviação, garantindo qualidade em aplicações mobile, web e APIs, com destaque para projetos como **Smiles**, **GOL App** e **Cielo POS/TEF**.

Minha missão é contribuir para entregas mais confiáveis por meio de estratégia de testes, automação robusta, análise crítica e cultura de qualidade.

---

## Estrutura do Repositório

```text
Portifolio-QA/
|-- BDD/              # Cenários BDD em Gherkin
|-- Cypress/          # Testes E2E automatizados com Cypress
|-- K6 + Mock/        # Testes de performance com K6 e WireMock
|-- Postman/          # Testes de API REST com Postman e Newman
|-- Robot/            # Testes web com Robot Framework e SeleniumLibrary
|-- .github/workflows # Pipelines de CI/CD
`-- README.md
```

---

## Ferramentas e Tecnologias

| Ferramenta | Tipo de teste | Aplicação no projeto |
|---|---|---|
| Cypress | E2E / UI | Login, formulários, inputs, dropdowns, carrinho, botões, radio/checkbox e drag and drop |
| Postman + Newman | API REST | Collection automatizada da ServeRest com fluxo positivo, negativo, token e execução em CI |
| K6 + WireMock | Performance / contrato | Smoke, carga, erro esperado e stress sobre API mockada |
| Robot Framework | UI / BDD | SeleniumLibrary com recursos reutilizáveis e cenários organizados por domínio |
| Gherkin | BDD | Critérios de aceite em português para web, API e performance |
| GitHub Actions | CI/CD | Execução automatizada de Cypress, Robot, Postman/Newman e K6, além da publicação do portal |
| Allure Report | Relatórios | Publicação de relatórios de Cypress e Robot no GitHub Pages |

---

## BDD - Cenários Gherkin

Cenários escritos em português seguindo o padrão **Given / When / Then**, com escopos separados por camada, dados menos frágeis e critérios de aceite preparados para automação futura.

| Arquivo | Funcionalidade | Cenários |
|---|---|---:|
| `BDD/login.feature` | Login Web Fake Store | 5 |
| `BDD/produtos.feature` | API ServeRest - Produtos | 7 |
| `BDD/usuarios.feature` | API ServeRest - Usuários | 7 |
| `BDD/formulario.feature` | Formulário Web LetCode | 5 |
| `BDD/cars_api.feature` | API de carros e performance | 7 |

**Total: 31 cenários documentados.**

Documentação complementar: [BDD/README.md](BDD/README.md)

---

## Cypress - Testes E2E

Automação End-to-End com **Cypress 14**, configuração centralizada, comandos customizados, fixtures, interceptação de APIs externas e geração de relatório Allure.

| Spec | Cobertura |
|---|---|
| `Cypress/e2e/auth.cy.js` | Login válido, inválido e persistência de token com `cy.intercept()` |
| `Cypress/e2e/button.cy.js` | Botões, estados, navegação e validações visuais |
| `Cypress/e2e/forms.cy.js` | Formulário válido, campos obrigatórios e email inválido |
| `Cypress/e2e/dropdown.cy.js` | Dropdown simples, múltiplo e seleção por valor |
| `Cypress/e2e/inputs.cy.js` | Campos de texto, foco, readonly, disabled e limpeza |
| `Cypress/e2e/checkout.cy.js` | Produto, carrinho e checkout com fixture |
| `Cypress/e2e/radio.cy.js` | Radio buttons, checkboxes e bug conhecido documentado |
| `Cypress/e2e/sortable.cy.js` | Drag and drop |

Execução local:

```bash
cd Cypress
npm install
npm run cy:open
npm run cy:run
npm run cy:run:allure
```

Relatório publicado: [Cypress Allure](https://gabrielndr.github.io/Portifolio-QA/cypress)

Documentação complementar: [Cypress/README.md](Cypress/README.md)

---

## Postman - Testes de API REST

Testes de API na [ServeRest](https://serverest.dev), com collection exportada, environment, massa dinâmica, autenticação via token, cenários positivos e negativos, execução Newman e workflow dedicado.

| Fluxo | Método | Endpoint | Status esperado |
|---|---|---|---|
| Cadastrar usuário admin | POST | `/usuarios` | 201 Created |
| Login | POST | `/login` | 200 OK |
| Cadastrar produto | POST | `/produtos` | 201 Created |
| Listar produtos | GET | `/produtos` | 200 OK |
| Editar produto | PUT | `/produtos/:id` | 200 OK |
| Deletar produto | DELETE | `/produtos/:id` | 200 OK |
| Listar usuários | GET | `/usuarios` | 200 OK |
| Deletar usuário | DELETE | `/usuarios/:id` | 200 OK |
| Login inválido | POST | `/login` | 401 Unauthorized |
| Produto sem token | POST | `/produtos` | 401 Unauthorized |
| Produto inexistente | GET | `/produtos/:id` | 400 Bad Request |

Execução local:

```powershell
cd Postman
npm install
npm test
```

Relatório HTML local:

```powershell
npm run test:html
```

Validação realizada: **11 requests, 46 assertions e 0 falhas**.

Documentação complementar: [Postman/Postman_README.md](Postman/Postman_README.md)

---

## K6 + WireMock - Performance e Mock

Testes de performance e contrato com **K6** sobre API mockada com **WireMock**. A estrutura foi separada por intenção de teste e os relatórios gerados ficam fora do versionamento.

| Script | Tipo | Objetivo |
|---|---|---|
| `K6 + Mock/tests/smoke_contract.js` | Smoke / contrato | Valida GET 200, POST 201, POST 500 esperado e fallback 404 |
| `K6 + Mock/tests/load_get_cars.js` | Carga | Mede consulta GET com VUs e duração parametrizáveis |
| `K6 + Mock/tests/load_post_error.js` | Carga negativa | Mede erro 500 esperado sem falso negativo técnico |
| `K6 + Mock/tests/stress_post_success.js` | Stress | Rampa até 500 VUs no POST 201 |

Mocks configurados:

| Método | Endpoint | Condição | Status |
|---|---|---|---|
| GET | `/api/cars` | Lista fixa de carros | 200 OK |
| POST | `/api/cars` | `model = fusca` | 201 Created |
| POST | `/api/cars` | `model = up tsi` | 500 Error |
| POST | `/api/cars` | Qualquer outro payload | 404 Not Found |

Execução local:

```powershell
cd "K6 + Mock"
.\start-wiremock.ps1
```

Em outro terminal:

```powershell
.\run-all.ps1 -SmokeProfile
```

Documentação complementar: [K6 + Mock/K6_Mock_README.md](<K6 + Mock/K6_Mock_README.md>)

---

## Robot Framework - Testes Web

Automação com **Robot Framework** e **SeleniumLibrary**, organizada em `tests/` e `resources/`, cobrindo formulário, inputs, dropdowns, navegação, radio/checkbox e um fluxo BDD.

| Arquivo | Cenários |
|---|---:|
| `Robot/tests/bdd_formulario.robot` | 1 |
| `Robot/tests/dropdowns.robot` | 4 |
| `Robot/tests/formulario.robot` | 3 |
| `Robot/tests/inputs.robot` | 4 |
| `Robot/tests/navegacao.robot` | 3 |
| `Robot/tests/radio_checkbox.robot` | 5 |

**Total: 20 cenários Robot.**

Execução local:

```powershell
python -m robot --variable BROWSER:headlesschrome --outputdir Robot\results Robot\tests
```

Relatório publicado: [Robot Allure](https://gabrielndr.github.io/Portifolio-QA/robot)

Documentação complementar: [Robot/Robot_README.md](Robot/Robot_README.md)

---

## CI/CD - GitHub Actions

Pipelines configurados para execução automatizada e publicação de relatórios:

| Workflow | Objetivo |
|---|---|
| `.github/workflows/cypress-allure.yml` | Executa Cypress e publica relatório Allure |
| `.github/workflows/robot-allure.yml` | Executa Robot Framework e publica relatório Allure |
| `.github/workflows/postman-newman.yml` | Executa a collection Postman com Newman e publica artefatos |
| `.github/workflows/k6-wiremock.yml` | Executa a suíte K6 em perfil de CI com WireMock |
| `.github/workflows/deploy-index.yml` | Publica a página inicial do portfólio no GitHub Pages |

Fluxo geral:

```text
Push ou pull request
  -> GitHub Actions executa a suíte correspondente
  -> Relatórios e artefatos são gerados
  -> GitHub Pages publica o portal e relatórios configurados
```

---

## Relatórios e Links

| Área | Link |
|---|---|
| Portal do portfólio | [Acessar GitHub Pages](https://gabrielndr.github.io/Portifolio-QA) |
| Cypress | [Ver relatório Allure](https://gabrielndr.github.io/Portifolio-QA/cypress) |
| Robot Framework | [Ver relatório Allure](https://gabrielndr.github.io/Portifolio-QA/robot) |
| Repositório | [GitHub - Gabrielndr/Portifolio-QA](https://github.com/Gabrielndr/Portifolio-QA) |

---

## Boas Práticas Aplicadas

- Separação dos testes por camada e ferramenta.
- Nomenclatura de arquivos mais clara e orientada ao comportamento.
- Uso de fixtures, comandos customizados e interceptações no Cypress.
- Collection Postman versionada com environment e execução Newman.
- Mocks WireMock com prioridades para evitar conflitos de matching.
- Relatórios gerados fora do versionamento.
- Workflows de CI/CD dedicados por suíte.
- Documentação complementar por módulo.

---

## Experiência Profissional

| Empresa | Cargo | Período | Projetos |
|---|---|---|---|
| Level 4 Consulting | Analista de QA | 07/2021 - 03/2025 | Smiles App, GOL App |
| Grupo HDI | Analista de QA | 03/2020 - 06/2021 | Cielo POS/TEF |

---

## Contato

**Gabriel da Silva** - QA Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-gabrielsndr-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/gabrielsndr/)
[![GitHub](https://img.shields.io/badge/GitHub-Gabrielndr-181717?style=flat&logo=github)](https://github.com/Gabrielndr)
[![Email](https://img.shields.io/badge/Email-gabrielsandrade.2001.2308@gmail.com-D14836?style=flat&logo=gmail)](mailto:gabrielsandrade.2001.2308@gmail.com)
