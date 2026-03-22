# 🎯 Portfólio QA — Gabriel da Silva

[![Cypress Tests](https://github.com/Gabrielndr/Portifolio-QA/actions/workflows/cypress-allure.yml/badge.svg)](https://github.com/Gabrielndr/Portifolio-QA/actions/workflows/cypress-allure.yml)
[![Robot Framework](https://github.com/Gabrielndr/Portifolio-QA/actions/workflows/robot-allure.yml/badge.svg)](https://github.com/Gabrielndr/Portifolio-QA/actions/workflows/robot-allure.yml)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://gabrielndr.github.io/Portifolio-QA)

Bem-vindo ao meu portfólio de QA! Aqui você encontrará uma coleção organizada de testes automatizados, testes de API, testes de performance e cenários BDD, utilizando as principais ferramentas do mercado.

> 💼 **QA Engineer** com experiência em testes manuais e automação, projetos reais como **Smiles**, **GOL App** e **Cielo POS/TEF**.

---

## 👨‍💻 Sobre Mim

Olá! Sou Gabriel da Silva, QA Engineer com mais de 5 anos de experiência em qualidade de software. Tenho atuado em projetos de grande escala nos setores financeiro e de aviação, garantindo a qualidade de aplicações mobile, web e APIs.

Minha missão é garantir a qualidade do software através de estratégias eficazes de testes, automação robusta e uma forte cultura de qualidade.

🔗 [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) • [GitHub](https://github.com/Gabrielndr)

---

## 📁 Estrutura do Portfólio

```
Portifolio-QA/
├── 📂 BDD/               # Cenários BDD em Gherkin (37 cenários)
├── 📂 Cypress/           # Testes E2E automatizados
├── 📂 K6 + Mock/         # Testes de performance e carga
├── 📂 Postman/           # Testes de API REST
└── 📂 Robot/             # Testes com Robot Framework
```

---

## 🧪 Ferramentas & Tecnologias

| Ferramenta | Tipo de Teste | Detalhes |
|---|---|---|
| ![Cypress](https://img.shields.io/badge/Cypress-17D9CE?style=flat&logo=cypress&logoColor=white) | E2E / UI | 8 specs cobrindo login, formulários, drag & drop |
| ![Postman](https://img.shields.io/badge/Postman-FF6C37?style=flat&logo=postman&logoColor=white) | API REST | CRUD completo com autenticação JWT |
| ![K6](https://img.shields.io/badge/K6-7D64FF?style=flat&logo=k6&logoColor=white) | Performance | Até 500 VUs com WireMock |
| ![Robot](https://img.shields.io/badge/Robot_Framework-000000?style=flat&logo=robot-framework&logoColor=white) | BDD / UI | SeleniumLibrary com Given/When/Then |
| ![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white) | CI/CD | Pipelines automáticos com Allure Report |

---

## 📋 BDD — Cenários Gherkin

Cenários escritos em português seguindo o padrão **Given / When / Then**, cobrindo todas as funcionalidades do portfólio.

| Arquivo | Funcionalidade | Cenários |
|---|---|---|
| `login.feature` | Autenticação e Login | 7 |
| `produtos.feature` | CRUD de Produtos | 8 |
| `usuarios.feature` | CRUD de Usuários | 8 |
| `formulario.feature` | Formulário Web | 7 |
| `cars_api.feature` | API + Performance | 7 |

**Total: 37 cenários documentados**

---

## 🌲 Cypress — Testes E2E

Automação de testes End-to-End com **Cypress 13**, cobrindo os principais tipos de interação com interfaces web.

**Specs:**
- `button.cy.js` — Validação de botões e CSS
- `Login.cy.js` — Fluxo de autenticação
- `forms.cy.js` — Preenchimento de formulários
- `dropdown.cy.js` — Seleção em dropdowns
- `inputs.cy.js` — Validação de campos
- `Compra.cy.js` — Fluxo de compra E2E
- `sortable.cy.js` — Drag and Drop
- `pai.cy.js` — Navegação site Enel SP

📊 [Ver Relatório Allure](https://gabrielndr.github.io/Portifolio-QA/cypress)

---

## 📬 Postman — Testes de API REST

CRUD completo de **Produtos** e **Usuários** na API [ServeRest](https://serverest.dev) com autenticação **JWT Bearer Token**.

**Endpoints testados:**

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

Testes de carga e stress em API mockada com **WireMock**, gerando relatórios HTML automáticos.

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

## 🤖 Robot Framework — Testes BDD

Automação com **SeleniumLibrary** usando estrutura **Given/When/Then**.

| Arquivo | Cenário |
|---|---|
| `bdd.robot` | Busca e execução de vídeo no YouTube |
| `formulario.robot` | Preenchimento completo de formulário |
| `estrutura.robot` | Navegação básica Google e Globo |

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

**Gabriel da Silva**
QA Engineer

[![LinkedIn](https://img.shields.io/badge/LinkedIn-gabrielsndr-0077B5?style=flat&logo=linkedin)](https://www.linkedin.com/in/gabrielsndr/)
[![GitHub](https://img.shields.io/badge/GitHub-Gabrielndr-181717?style=flat&logo=github)](https://github.com/Gabrielndr)
[![Email](https://img.shields.io/badge/Email-gabrielsandrade.2001.2308@gmail.com-D14836?style=flat&logo=gmail)](mailto:gabrielsandrade.2001.2308@gmail.com)
