# 🤖 Robot Framework - Testes Automatizados

Automação de testes utilizando **Robot Framework** com **SeleniumLibrary**, cobrindo testes de interface web com estrutura BDD (Given/When/Then), preenchimento de formulários e navegação entre sites.

---

## 📁 Estrutura de Arquivos

```
Robot/
├── bdd.robot          # Teste BDD de busca e execução de vídeo no YouTube
├── estrutura.robot    # Estrutura básica de abertura e fechamento de navegador
├── formulario.robot   # Preenchimento completo de formulário web
├── log.html           # Log detalhado da última execução
├── output.xml         # Resultado da execução em formato XML
└── report.html        # Relatório visual da última execução
```

---

## 🧪 Cenários Cobertos

### 🎬 bdd.robot — Busca no YouTube (BDD)
Teste escrito no padrão **Given / When / And / Then**, simulando um usuário buscando e assistindo um vídeo.

| Passo | Keyword | Ação |
|---|---|---|
| Given | Que eu acesso o site do youtube | Abre o browser e acessa o YouTube |
| When | Digito o nome da música | Digita "Natiruts Quero ser feliz" no campo de busca |
| And | Clico no botão buscar | Clica no botão de pesquisa |
| And | Clico na primeira opção da lista | Seleciona o segundo resultado da busca |
| Then | O video é executado | Valida que o título do vídeo contém "Quero Ser Feliz" |

**Cenário:**
```
Cenario 1: Executar video do site do youtube
    Given Que eu acesso o site do youtube
    When Digito o nome da música
    And Clico no botão buscar
    And Clico na primeira opção da lista
    Then O video é executado
```

---

### 🌐 estrutura.robot — Navegação Básica
Demonstração da estrutura base do Robot Framework com abertura e fechamento de navegador.

| Cenário | Site | Ação |
|---|---|---|
| Cenario 1 | google.com.br | Abre e fecha o Google |
| Cenario 2 | globo.com | Abre e fecha o site da Globo |

---

### 📝 formulario.robot — Preenchimento de Formulário
Teste completo de formulário na plataforma [LetCode.in/forms](https://letcode.in/forms), cobrindo todos os tipos de campos.

| Campo | Tipo | Valor Usado |
|---|---|---|
| First Name | Input text | Gabriel |
| Last Name | Input text | Andrade |
| Email | Input text | teste@gmail.com |
| DDI | Select (by value) | 55 (Brasil) |
| Phone | Input text | 11942528073 |
| Address Line 1 | Input text | Rua asmania |
| Address Line 2 | Input text | Rua lituania |
| State | Input text | São Paulo |
| Postal Code | Input text | 03554150 |
| Country | Select (by value) | Brazil |
| Date | Input text | 23-08-2001 |
| Gender | Radio button | Male |
| Terms | Checkbox | Marcado |
| Submit | Button click | Enviado |

**Cenário:**
```
Cenario 1: Preencher formulário
    Abrir navegador e Acessar site
    Preencher campos
    Clicar em submit
    Fechar navegador
```

---

## ⚙️ Pré-requisitos

- Python 3.8+
- Google Chrome instalado
- ChromeDriver compatível com a versão do Chrome

---

## 🚀 Como Instalar e Executar

**1. Clone o repositório**
```bash
git clone https://github.com/Gabrielndr/Portifolio-QA.git
cd Portifolio-QA/Robot
```

**2. Instale o Robot Framework e SeleniumLibrary**
```bash
pip install robotframework
pip install robotframework-seleniumlibrary
```

**3. Instale o WebDriver Manager (opcional, facilita o setup)**
```bash
pip install webdrivermanager
webdrivermanager chrome
```

**4. Execute um teste específico**
```bash
robot bdd.robot
robot formulario.robot
robot estrutura.robot
```

**5. Execute todos os testes da pasta**
```bash
robot .
```

**6. Gerar relatório em pasta específica**
```bash
robot --outputdir results/ .
```

---

## 📊 Relatórios

Após a execução, o Robot Framework gera automaticamente 3 arquivos:

| Arquivo | Descrição |
|---|---|
| `report.html` | Relatório visual com resumo dos testes (abrir no browser) |
| `log.html` | Log detalhado de cada step executado |
| `output.xml` | Resultado bruto em XML para integrações CI/CD |

Para visualizar:
```bash
# Abrir relatório no navegador
start report.html       # Windows
open report.html        # Mac
xdg-open report.html    # Linux
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|---|---|---|
| Robot Framework | 6.x+ | Framework de automação |
| SeleniumLibrary | 6.x+ | Automação de browser |
| Python | 3.8+ | Linguagem base |
| ChromeDriver | Compatível com Chrome | Driver do navegador |

---

## 📌 Boas Práticas Aplicadas

- ✅ Estrutura BDD (Given/When/And/Then) para legibilidade
- ✅ Keywords reutilizáveis e com nomes descritivos em português
- ✅ Variáveis centralizadas na seção `*** Variables ***`
- ✅ Uso de locators por `id`, `xpath` e `css` de forma organizada
- ✅ `Set Selenium Speed` para estabilidade da execução
- ✅ Relatórios HTML gerados automaticamente

---

## 👨‍💻 Autor

**Gabriel da Silva**  
QA Engineer | [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) | [GitHub](https://github.com/Gabrielndr)
