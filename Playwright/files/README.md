# 🎭 Playwright — Testes Automatizados

Testes automatizados com **Playwright**, cobrindo E2E, API REST, Acessibilidade e Performance utilizando o [Sauce Demo](https://www.saucedemo.com) e a API [ServeRest](https://serverest.dev).

---

## 📁 Estrutura

```
Playwright/
├── tests/
│   ├── fixtures.ts                        # Page Objects e fixtures compartilhados
│   ├── e2e/
│   │   ├── login.spec.ts                  # Autenticação (6 cenários)
│   │   └── compra.spec.ts                 # Fluxo de compra E2E (6 cenários)
│   ├── api/
│   │   └── api.spec.ts                    # CRUD Produtos e Usuários (8 cenários)
│   ├── acessibilidade/
│   │   └── acessibilidade.spec.ts         # WCAG 2.1 com axe-core (5 cenários)
│   └── performance/
│       └── performance.spec.ts            # Web Vitals e tempos de resposta (6 cenários)
├── playwright.config.ts
└── package.json
```

---

## 🚀 Como executar

```bash
# Instalar dependências
npm install
npx playwright install

# Todos os testes
npm test

# Por tipo
npm run test:e2e
npm run test:api
npm run test:a11y
npm run test:perf

# Com interface visual
npm run test:ui

# Abrir relatório
npm run report
```

---

## 🧪 Cenários BDD (31 total)

| Módulo | Arquivo | Cenários |
|---|---|---|
| E2E — Login | `login.spec.ts` | 6 |
| E2E — Compra | `compra.spec.ts` | 6 |
| API REST | `api.spec.ts` | 8 |
| Acessibilidade | `acessibilidade.spec.ts` | 5 |
| Performance | `performance.spec.ts` | 6 |

---

## 🛠 Tecnologias

| Ferramenta | Uso |
|---|---|
| Playwright 1.44 | Framework principal |
| axe-core | Análise de acessibilidade WCAG 2.1 |
| Performance API | Web Vitals (FCP, LCP, TTI) |
| TypeScript | Tipagem estática |
| Page Object Model | Organização dos testes |
