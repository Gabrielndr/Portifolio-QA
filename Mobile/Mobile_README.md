# Robot Framework + Appium - Testes Mobile

Projeto de estudo de automação de app Android com Robot Framework, AppiumLibrary e o [My Demo App](https://github.com/saucelabs/my-demo-app-android), app público da Sauce Labs.

> **Status:** os 7 cenários passaram em um emulador Android em 02/11/2026, com Appium 3.9.0, UiAutomator2 8.7.3 e o APK `mda-2.2.0-25.apk`. Se usar outra versão do app, confira no Appium Inspector se algum seletor mudou.

## Estrutura

```text
Mobile/
|-- Mobile_README.md
|-- requirements.txt
|-- apps/                  # APK local, fora do versionamento
|-- resources/
|   |-- common.resource    # Sessão do Appium e keywords comuns
|   |-- login.resource
|   `-- carrinho.resource
`-- tests/
    |-- login.robot
    `-- carrinho.robot
```

## Cobertura

| Arquivo | Foco | Cenários |
|---|---|---:|
| `tests/login.robot` | Login válido, campos obrigatórios e usuário bloqueado | 4 |
| `tests/carrinho.robot` | Adicionar, alterar quantidade e remover produto | 3 |

**Total: 7 cenários.**

## Preparar o Ambiente

Instale:

- Node.js 20.19+, 22.12+ ou 24+
- Python 3.9 a 3.13
- Android Studio, com Android SDK e um emulador
- JDK
- [Appium Inspector](https://github.com/appium/appium-inspector/releases), para consultar os seletores

Configure as variáveis de ambiente `ANDROID_HOME` e `JAVA_HOME`, e inclua `platform-tools` no `PATH`.

Depois, instale o Appium, o driver Android e as dependências do projeto:

```powershell
npm install -g appium
appium driver install uiautomator2
appium driver doctor uiautomator2
pip install -r Mobile/requirements.txt
```

## Baixar o App

1. Baixe o APK mais recente em [My Demo App Releases](https://github.com/saucelabs/my-demo-app-android/releases).
2. Salve o arquivo como `Mobile/apps/my-demo-app.apk`.

## Como Executar

1. Abra um emulador no Device Manager do Android Studio.
2. Confirme que ele aparece com `adb devices`.
3. Em um terminal, inicie o Appium:

```powershell
appium
```

4. Em outro terminal, na raiz do repositório, execute os testes:

```powershell
robot --outputdir Mobile/results Mobile/tests
```

Validar a sintaxe sem abrir o app:

```powershell
robot --dryrun --outputdir Mobile/results Mobile/tests
```

Executar por tag:

```powershell
robot --include critico --outputdir Mobile/results Mobile/tests
robot --include login --outputdir Mobile/results Mobile/tests
robot --include carrinho --outputdir Mobile/results Mobile/tests
```

Gerar resultados para o Allure:

```powershell
robot --listener allure_robotframework:Mobile/results/allure-results --outputdir Mobile/results Mobile/tests
```

## CI/CD

O workflow [`mobile-appium.yml`](../.github/workflows/mobile-appium.yml) roda a suíte no GitHub Actions a cada push ou pull request que altere `Mobile/**`. Ele também pode ser disparado manualmente. O workflow:

1. Instala Appium 3.9.0, o driver UiAutomator2 8.7.3 e as dependências Python.
2. Baixa o APK `mda-2.2.0-25.apk` direto do release da Sauce Labs.
3. Sobe um emulador Android (API 30, x86_64) com `reactivecircus/android-emulator-runner`.
4. Executa os testes com o listener do Allure.
5. Publica o relatório Allure como artefato e, na `main`, no GitHub Pages em `/mobile`.

## Padrões Aplicados

- Testes ficam em `Mobile/tests`; keywords e seletores ficam em `Mobile/resources`.
- Não há `Sleep`; os testes usam esperas explícitas.
- Cada teste abre uma sessão nova, porque o carrinho é mantido na memória do app.
- Os seletores priorizam `id` e `accessibility_id`. O XPath é usado só onde o elemento não tem um identificador único.
- O idioma e a região do app são fixados para que textos e preços não mudem conforme o aparelho.
- O APK e os relatórios não são versionados.

## Roteiro de Estudo

1. Rode a suíte e leia o `log.html` gerado em `Mobile/results`.
2. Abra o app no Appium Inspector e localize os elementos usados nos testes.
3. Automatize o checkout, que vem logo depois do carrinho.
4. Pratique gestos: rolagem da lista, swipe e o desenho da tela Drawing.
5. Teste o bug proposital do app: a Sauce Labs Bolt T-Shirt adiciona 10 unidades em vez da quantidade escolhida.
6. Adapte a suíte para iOS com o driver XCUITest, que exige um Mac.
7. Acompanhe a execução no GitHub Actions e compare o relatório Allure com o `log.html` local.
