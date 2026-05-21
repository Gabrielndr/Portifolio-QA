# Cypress E2E

Suite E2E do portfolio QA com foco em fluxos web, validacoes de formulario, compra, login, componentes e drag-and-drop.

## Como rodar

```bash
npm install
npm run cy:open
npm run cy:run
npm run cy:run:chrome
npm run cy:run:allure
npm run cy:run:ci
```

`cy:run:allure` executa a regressao completa. `cy:run:ci` executa o smoke usado no GitHub Actions, com specs estaveis e independentes das paginas LetCode mais sensiveis a instabilidade externa.

## Boas praticas aplicadas

- `baseUrl` centralizado em `cypress.config.js`.
- Scripts npm para execucao local, headless e Chrome.
- Specs com nomes padronizados em minusculo.
- `cy.intercept()` para autenticar e controlar dados externos.
- Fixtures para dados da Fake Store.
- Tratamento global apenas para erro conhecido do LetCode.
- CI preparado para rodar smoke confiavel e publicar relatorio Allure.

## Cobertura

| Spec | Fluxo |
|---|---|
| `button.cy.js` | Botoes, navegacao e propriedades visuais |
| `auth.cy.js` | Login valido e login invalido |
| `forms.cy.js` | Formulario valido, obrigatorios e email invalido |
| `dropdown.cy.js` | Dropdown simples, multiplo e selecao por valor |
| `inputs.cy.js` | Campos de texto, foco, readonly e disabled |
| `checkout.cy.js` | Produto, carrinho e checkout |
| `radio.cy.js` | Radio buttons, bug conhecido e checkboxes |
| `sortable.cy.js` | Drag-and-drop |
