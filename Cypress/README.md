# Cypress E2E

Suite E2E do portfolio QA com foco em fluxos web, validacoes de formulario, compra, login, componentes e drag-and-drop.

Os cenarios usam alvos publicos mais estaveis para automacao: Selenium Web Form, The Internet, SauceDemo e CommitQuality. A suite Cypress nao depende mais do LetCode.

## Como rodar

```bash
npm install
npm run cy:open
npm run cy:run
npm run cy:run:chrome
npm run cy:run:allure
npm run cy:run:ci
```

`cy:run:allure` e `cy:run:ci` executam a suite completa em Chrome headless com relatorio Allure. O script `cy:run:ci` e o comando usado pelo GitHub Actions.

## Boas praticas aplicadas

- `baseUrl` centralizado em `cypress.config.js`.
- Scripts npm para execucao local, headless e Chrome.
- Specs com nomes padronizados em minusculo.
- Alvos de teste publicos e desenhados para automacao.
- Bloqueio global de analytics e anuncios para reduzir ruido externo.
- Fluxos criticos cobertos com seletores estaveis.
- CI preparado para rodar a suite completa e publicar relatorio Allure.

## Cobertura

| Spec | Fluxo |
|---|---|
| `button.cy.js` | Botoes dinamicos no The Internet |
| `auth.cy.js` | Login valido e login invalido no The Internet |
| `forms.cy.js` | Formulario completo no Selenium Web Form |
| `dropdown.cy.js` | Select, datalist e multiselect no Selenium Web Form |
| `inputs.cy.js` | Texto, password, textarea, readonly, disabled, data e range |
| `checkout.cy.js` | Carrinho e checkout no SauceDemo |
| `radio.cy.js` | Radio buttons, checkboxes e opcoes desabilitadas |
| `sortable.cy.js` | Drag-and-drop no CommitQuality |
