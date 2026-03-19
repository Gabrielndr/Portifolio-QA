# 📋 BDD - Behavior Driven Development

Cenários de teste escritos em **Gherkin** seguindo o padrão **BDD (Behavior Driven Development)**. Os arquivos `.feature` documentam o comportamento esperado do sistema de forma legível para toda a equipe — QA, Dev e negócio.

---

## 📁 Estrutura de Arquivos

```
BDD/
├── login.feature       # Cenários de autenticação e login
├── produtos.feature    # CRUD completo de produtos via API
├── usuarios.feature    # CRUD completo de usuários via API
├── formulario.feature  # Preenchimento e validação de formulário web
└── cars_api.feature    # API de carros com mock WireMock + testes de carga K6
```

---

## 🧪 Funcionalidades Cobertas

| Arquivo | Funcionalidade | Cenários | Tags |
|---|---|---|---|
| `login.feature` | Login e Autenticação | 7 | `@login` `@sucesso` `@falha` `@seguranca` |
| `produtos.feature` | Gerenciamento de Produtos | 8 | `@produtos` `@cadastro` `@edicao` `@exclusao` |
| `usuarios.feature` | Gerenciamento de Usuários | 8 | `@usuarios` `@login` `@cadastro` `@exclusao` |
| `formulario.feature` | Formulário Web | 7 | `@formulario` `@validacao` `@dropdown` |
| `cars_api.feature` | API de Carros + Performance | 7 | `@cars` `@performance` `@stress` `@carga` |

**Total: 37 cenários documentados**

---

## 📐 Padrão Gherkin Utilizado

```gherkin
Funcionalidade: Descrição da funcionalidade
  Como um [perfil de usuário]
  Quero [ação desejada]
  Para [benefício/objetivo]

  Contexto:
    Dado [pré-condição comum a todos os cenários]

  @tag
  Cenário: Descrição do cenário
    Dado [pré-condição]
    Quando [ação executada]
    E [ação adicional]
    Então [resultado esperado]

  Esquema do Cenário: Teste com múltiplos dados
    Quando [ação com "<variavel>"]
    Então [resultado "<esperado>"]

    Exemplos:
      | variavel | esperado |
      | valor1   | result1  |
```

---

## 🔖 Sistema de Tags

| Tag | Descrição |
|---|---|
| `@sucesso` | Cenários de caminho feliz (happy path) |
| `@falha` | Cenários de erro esperado |
| `@validacao` | Validações de campos e regras de negócio |
| `@seguranca` | Cenários relacionados à segurança |
| `@performance` | Testes de carga e stress |
| `@carga` | Testes com múltiplos usuários simultâneos |
| `@stress` | Testes com rampa de usuários |
| `@tabela` | Cenários com Esquema do Cenário (data-driven) |

---

## 🚀 Como Integrar com Cypress + Cucumber

**1. Instale o plugin**
```bash
npm install @badeball/cypress-cucumber-preprocessor --save-dev
npm install @bahmutov/cypress-esbuild-preprocessor --save-dev
```

**2. Configure o cypress.config.js**
```javascript
const { defineConfig } = require('cypress');
const createBundler = require('@bahmutov/cypress-esbuild-preprocessor');
const { addCucumberPreprocessorPlugin } = require('@badeball/cypress-cucumber-preprocessor');

module.exports = defineConfig({
  e2e: {
    specPattern: 'BDD/**/*.feature',
    async setupNodeEvents(on, config) {
      await addCucumberPreprocessorPlugin(on, config);
      on('file:preprocessor', createBundler());
      return config;
    },
  },
});
```

**3. Execute os testes**
```bash
npx cypress run --spec "BDD/login.feature"
npx cypress run --spec "BDD/**/*.feature"
```

---

## 🚀 Como Integrar com Robot Framework

Os cenários BDD também são compatíveis com Robot Framework usando a estrutura **Given/When/Then** já presente nos arquivos `.robot` do projeto.

```bash
robot --include sucesso BDD/
robot --include performance BDD/
```

---

## 📌 Boas Práticas Aplicadas

- ✅ Linguagem em português (`# language: pt`)
- ✅ Estrutura Given/When/And/Then clara e objetiva
- ✅ `Contexto` para pré-condições compartilhadas
- ✅ `Esquema do Cenário` para testes orientados a dados (data-driven)
- ✅ Tags organizadas por tipo de teste e resultado esperado
- ✅ Cenários independentes entre si
- ✅ Nomenclatura descritiva e orientada ao comportamento do usuário

---

## 👨‍💻 Autor

**Gabriel da Silva**  
QA Engineer | [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) | [GitHub](https://github.com/Gabrielndr)
