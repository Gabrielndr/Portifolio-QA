# 🌲 Cypress - Testes E2E

Automação de testes End-to-End utilizando **Cypress**, cobrindo os principais tipos de interação com interfaces web. Todos os cenários foram desenvolvidos e validados na plataforma [LetCode.in](https://letcode.in) e em outros sites reais.

---

## 📁 Estrutura de Arquivos

```
Cypress/
├── cypress.config.js       # Configuração global do Cypress
├── button.cy.js            # Testes de botões e interações de clique
├── Compra.cy.js            # Fluxo de compra end-to-end
├── dropdown.cy.js          # Testes de seleção em dropdowns
├── forms.cy.js             # Preenchimento e submissão de formulários
├── inputs.cy.js            # Validação de campos de entrada
├── Login.cy.js             # Fluxo de autenticação/login
├── pai.cy.js               # Navegação no site da Enel São Paulo
└── sortable.cy.js          # Drag and Drop com cypress-drag-drop
```

---

## 🧪 Cenários Cobertos

### 🔘 button.cy.js — Testes de Botões
- Verificação de navegação ao clicar em botão home
- Validação de cor de fundo via CSS (`background-color`)
- Leitura de dimensões (largura e altura) do elemento
- Simulação de `mousedown` e `mouseup` em botão desabilitado

### 🛒 Compra.cy.js — Fluxo de Compra
- Fluxo completo de seleção e compra de produto
- Navegação entre cards e etapas de checkout
- Interação com botões de confirmação de pedido

### 📋 dropdown.cy.js — Dropdowns
- Seleção por texto visível (`Mango`, `The Avengers`, `Brazil`)
- Log de todas as opções disponíveis em um `<select>`
- Identificação da opção atualmente selecionada
- Validação do valor retornado após seleção

### 📝 forms.cy.js — Formulários
- Preenchimento completo de formulário com dados pessoais
- Seleção de DDI, país e data de nascimento
- Clique em radio button (gênero feminino)
- Marcação de checkbox e submissão do formulário

### ✏️ inputs.cy.js — Campos de Entrada
- Digitação em campos de texto
- Limpeza e redigitação de conteúdo
- Validação de campo somente leitura (`readonly`)
- Verificação de valor padrão preenchido automaticamente

### 🔐 Login.cy.js — Autenticação
- Acesso à tela de login
- Preenchimento de usuário e senha
- Submissão e validação do fluxo de autenticação

### 🌐 pai.cy.js — Navegação no Site Enel SP
- Aceitação de cookies
- Navegação por região (São Paulo)
- Interação com carrossel e módulos da home
- Acesso a documentos via menu de Normas Técnicas

### 🖱️ sortable.cy.js — Drag and Drop
- Simulação de arrastar e soltar elementos
- Utilização do plugin `@4tw/cypress-drag-drop`
- Teste na plataforma [CommitQuality](https://commitquality.com/practice-drag-and-drop)

---

## ⚙️ Pré-requisitos

- [Node.js](https://nodejs.org/) v16 ou superior
- npm ou yarn

---

## 🚀 Como Executar

**1. Clone o repositório**
```bash
git clone https://github.com/Gabrielndr/Portifolio-QA.git
cd Portifolio-QA/Cypress
```

**2. Instale as dependências**
```bash
npm install
npm install @4tw/cypress-drag-drop --save-dev
```

**3. Abrir interface visual do Cypress**
```bash
npx cypress open
```

**4. Rodar todos os testes via terminal (headless)**
```bash
npx cypress run
```

**5. Rodar um teste específico**
```bash
npx cypress run --spec "cypress/e2e/Login.cy.js"
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|---|---|---|
| Cypress | ^13.x | Framework de automação E2E |
| @4tw/cypress-drag-drop | ^2.x | Plugin para Drag and Drop |
| Node.js | v16+ | Ambiente de execução |

---

## 📌 Boas Práticas Aplicadas

- ✅ Viewport padronizado em `1920x1080` para consistência visual
- ✅ Uso de `.should()` para asserções explícitas
- ✅ Uso de `.invoke()` e `.then()` para captura de valores dinâmicos
- ✅ Logs descritivos com `cy.log()` para facilitar debug
- ✅ Simulação de eventos reais (`mousedown`, `mouseup`, drag)

---

## 👨‍💻 Autor

**Gabriel da Silva**  
QA Engineer | [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) | [GitHub](https://github.com/Gabrielndr)
