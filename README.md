# 🎯 Portfólio QA — Gabriel da Silva

Bem-vindo ao meu portfólio de QA! Aqui você encontrará uma coleção organizada de testes automatizados, testes de API, testes de performance e cenários BDD, utilizando as principais ferramentas do mercado.

---

## 👨‍💻 Sobre Mim

Olá! Sou **Gabriel da Silva**, QA Engineer com mais de 5 anos de experiência em qualidade de software. Atuei em projetos de grande escala nos setores financeiro e de aviação, garantindo a qualidade de aplicações mobile, web e APIs — com destaque para projetos como **Smiles**, **GOL App** e **Cielo POS/TEF**.

Minha missão é garantir a qualidade do software por meio de estratégias eficazes de testes, automação robusta e uma forte cultura de qualidade.

---

## 📁 Estrutura do Portfólio

```
Portifolio-QA/
├── 📂 BDD/          # Cenários BDD em Gherkin
├── 📂 Cypress/      # Testes E2E automatizados
├── 📂 K6 + Mock/    # Testes de performance e carga
├── 📂 Postman/      # Testes de API REST
└── 📂 Robot/        # Testes com Robot Framework
```

---

## 🧪 Ferramentas & Tecnologias

| Ferramenta | Tipo de Teste | Detalhes |
|---|---|---|
| ![Cypress](https://img.shields.io/badge/Cypress-17D9CE?style=flat&logo=cypress&logoColor=white) | E2E / UI | Cobrindo login, formulários, drag & drop |
| ![Postman](https://img.shields.io/badge/Postman-FF6C37?style=flat&logo=postman&logoColor=white) | API REST | CRUD completo com autenticação JWT |
| ![K6](https://img.shields.io/badge/K6-7D64FF?style=flat&logo=k6&logoColor=white) | Performance | Até 500 VUs com WireMock |
| ![Robot](https://img.shields.io/badge/Robot_Framework-000000?style=flat&logo=robot-framework&logoColor=white) | BDD / UI | SeleniumLibrary com Given/When/Then |
| ![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white) | CI/CD | Pipelines automáticos com Allure Report |

---

## 📋 BDD — Cenários Gherkin

Cenários escritos em português seguindo o padrão **Given / When / Then**, com escopos separados por camada, dados menos frágeis e critérios de aceite preparados para automação futura.

| Arquivo | Funcionalidade | Cenários |
|---|---|---|
| `login.feature` | Login Web Fake Store | 5 |
| `produtos.feature` | API ServeRest - Produtos | 7 |
| `usuarios.feature` | API ServeRest - Usuários | 7 |
| `formulario.feature` | Formulário Web LetCode | 5 |
| `cars_api.feature` | API de Carros + Performance | 7 |

**Total: 31 cenários documentados**

---

## 🌲 Cypress — Testes E2E

Automação de testes End-to-End com **Cypress 14**, cobrindo fluxos web com configuração centralizada, fixtures, interceptação de APIs externas e execução em CI.

| Spec | Descrição |
|---|---|
| `button.cy.js` | Validação de botões, navegação e CSS |
| `auth.cy.js` | Login válido e inválido com `cy.intercept()` |
| `forms.cy.js` | Formulário válido, obrigatórios e email inválido |
| `dropdown.cy.js` | Dropdown simples, múltiplo e seleção por valor |
| `inputs.cy.js` | Campos de texto, foco, readonly e disabled |
| `checkout.cy.js` | Produto, carrinho e checkout com fixture da Fake Store |
| `radio.cy.js` | Radio buttons, bug conhecido e checkboxes |
| `sortable.cy.js` | Drag and Drop |

**Como executar localmente:**

```bash
cd Cypress
npm install
npm run cy:open
npm run cy:run
npm run cy:run:allure
```

📊 [Ver Relatório Allure](https://gabrielndr.github.io/Portifolio-QA/cypress)

---

## 📬 Postman — Testes de API REST

CRUD completo de **Produtos** e **Usuários** na API [ServeRest](https://serverest.dev) com autenticação **JWT Bearer Token**.

| Método | Endpoint | Status |
|---|---|---|
| POST | `/produtos` | ✅ 201 Created |
| GET | `/produtos` | ✅ 200 OK |
| PUT | `/produtos/:id` | ✅ 200 OK |
| DELETE | `/produtos/:id` | ✅ 200 OK |
| POST | `/usuarios` | ✅ 201 Created |
| POST | `/login` | ✅ 200 OK |
| GET | `/usuarios` | ✅ 200 OK |
| DELETE | `/usuarios/:id` | ✅ 200 OK |

---

## ⚡ K6 + WireMock — Testes de Performance

Testes de carga e stress em API mockada com **WireMock**, com geração automática de relatórios HTML.

| Script | Tipo | Configuração |
|---|---|---|
| `consulta.js` | Funcional | 1 VU — GET /api/cars |
| `script.js` | Carga | 10 VUs × 30s — POST erro 500 |
| `testsucess.js` | Stress | Rampa até 500 VUs |

**Mocks configurados:**

- `GET /api/cars` → 200 com lista de 5 carros
- `POST /api/cars` (fusca) → 201 Created
- `POST /api/cars` (up tsi) → 500 Error
- `POST /api/cars` (outros) → 404 Not Found

---

## 🤖 Robot Framework — Testes Web

Automação com **SeleniumLibrary** organizada em `tests/` e `resources/`, com cenários de formulário, navegação e um fluxo BDD em Given/When/Then.

| Arquivo | Cenários |
|---|---:|
| `tests/bdd_formulario.robot` | 1 |
| `tests/formulario.robot` | 3 |
| `tests/navegacao.robot` | 3 |

**Total: 7 cenários Robot.**

📊 [Ver Relatório Allure](https://gabrielndr.github.io/Portifolio-QA/robot)

---

## 🚀 CI/CD — GitHub Actions

Pipelines configurados para rodar automaticamente a cada push na `main`:

```
Push na main
     ↓
GitHub Actions executa os testes
     ↓
Allure gera relatório HTML
     ↓
GitHub Pages publica em:
https://gabrielndr.github.io/Portifolio-QA
```

| Workflow | Descrição |
|---|---|
| `cypress-allure.yml` | Roda Cypress e publica relatório |
| `robot-allure.yml` | Roda Robot Framework e publica relatório |
| `deploy-index.yml` | Publica página inicial do portfólio |

---

## 📊 Relatórios

| Ferramenta | Link |
|---|---|
| 🌲 Cypress | [Ver Relatório](https://gabrielndr.github.io/Portifolio-QA/cypress) |
| 🤖 Robot Framework | [Ver Relatório](https://gabrielndr.github.io/Portifolio-QA/robot) |
| 🏠 Página do Portfólio | [Acessar](https://gabrielndr.github.io/Portifolio-QA) |

---

## 🏆 Experiência Profissional

| Empresa | Cargo | Período | Projetos |
|---|---|---|---|
| Level 4 Consulting | Analista de QA | 07/2021 – 03/2025 | Smiles App, GOL App |
| Grupo HDI | Analista de QA | 03/2020 – 06/2021 | Cielo POS/TEF |

---

## 📬 Contato

**Gabriel da Silva** — QA Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-gabrielsndr-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/gabrielsndr/)
[![GitHub](https://img.shields.io/badge/GitHub-Gabrielndr-181717?style=flat&logo=github)](https://github.com/Gabrielndr)
[![Email](https://img.shields.io/badge/Email-gabrielsandrade.2001.2308@gmail.com-D14836?style=flat&logo=gmail)](mailto:gabrielsandrade.2001.2308@gmail.com)
