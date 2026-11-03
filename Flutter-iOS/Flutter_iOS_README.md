# Robot Framework + Appium - Flutter iOS

Projeto de estudo de automação de um app **Flutter** em **iOS** com Robot Framework, AppiumLibrary e o driver **XCUITest**. O app alvo, **QA Tarefas**, fica neste mesmo diretório e foi feito para ser testável: login simples e uma lista de tarefas.

> **Status:** a suíte roda no GitHub Actions, num runner macOS com simulador de iPhone. iOS exige macOS e Xcode, então não é possível executar os testes no Windows.

## Estrutura

```text
Flutter-iOS/
|-- Flutter_iOS_README.md
|-- requirements.txt
|-- app/                   # App Flutter QA Tarefas
|   |-- pubspec.yaml
|   |-- lib/main.dart      # Telas de login e tarefas com identificadores de acessibilidade
|   `-- test/              # Testes de widget (flutter test)
|-- resources/
|   |-- common.resource    # Sessão do Appium e keywords comuns
|   |-- login.resource
|   `-- tarefas.resource
`-- tests/
    |-- login.robot
    `-- tarefas.robot
```

A pasta `app/ios` não é versionada. Ela é gerada com `flutter create` antes do build.

## Cobertura

| Arquivo | Foco | Cenários |
|---|---|---:|
| `tests/login.robot` | Login válido, campos obrigatórios e senha inválida | 4 |
| `tests/tarefas.robot` | Adicionar, concluir, remover, validar título e sair | 5 |
| `app/test/widget_test.dart` | Testes de widget do Flutter (login inválido e ciclo da tarefa) | 2 |

**Total: 9 cenários Robot + 2 testes de widget.**

## Como o Appium Encontra os Widgets Flutter

O Flutter desenha a tela por conta própria, então o Appium só enxerga o que o app expõe na árvore de acessibilidade. No app, os elementos importantes são envolvidos pelo widget `Id`:

```dart
Id('botao_entrar', child: FilledButton(onPressed: _entrar, child: const Text('Entrar')))
```

Ele usa `Semantics(identifier: ...)`, que no iOS vira o `accessibilityIdentifier`. Nos testes, o seletor fica assim:

```robot
${BOTAO_ENTRAR}    accessibility_id=botao_entrar
```

Os campos de texto não têm identificador no Flutter, então são localizados pelo tipo nativo do iOS com class chain:

```robot
${CAMPO_USUARIO}    chain=**/XCUIElementTypeTextField
${CAMPO_SENHA}      chain=**/XCUIElementTypeSecureTextField
```

Essa abordagem usa o driver XCUITest padrão. Não depende do Appium Flutter Driver nem de mudanças no build do app.

## Credenciais do App

| Usuário | Senha |
|---|---|
| `qa@portfolio.dev` | `Senha@123` |

## Como Executar em um Mac

Instale Flutter, Xcode, Node.js 20.19+ e Python 3.9 a 3.13. Depois:

```bash
npm install -g appium
appium driver install xcuitest
pip install -r Flutter-iOS/requirements.txt
```

Gere a pasta iOS, rode os testes de widget e compile o app para o simulador:

```bash
cd Flutter-iOS/app
flutter create --platforms=ios --org dev.portfolio --project-name qa_tarefas .
flutter test
flutter build ios --simulator --debug
cd ../..
```

Abra um simulador de iPhone (Xcode > Open Developer Tool > Simulator). Em um terminal, inicie o Appium:

```bash
appium
```

Em outro terminal, na raiz do repositório:

```bash
robot --outputdir Flutter-iOS/results Flutter-iOS/tests
```

Se houver mais de um simulador ligado, informe qual usar:

```bash
xcrun simctl list devices booted
robot --variable UDID:<udid-do-simulador> --outputdir Flutter-iOS/results Flutter-iOS/tests
```

Validar a sintaxe sem abrir o app (funciona também no Windows):

```bash
robot --dryrun --outputdir Flutter-iOS/results Flutter-iOS/tests
```

## CI/CD

O workflow [`flutter-ios-appium.yml`](../.github/workflows/flutter-ios-appium.yml) roda a cada push ou pull request que altere `Flutter-iOS/**`, e também pode ser disparado manualmente. O workflow:

1. Instala o Flutter, gera a pasta `ios/` e roda `flutter test`.
2. Compila o app para o simulador (`flutter build ios --simulator --debug`).
3. Liga um simulador de iPhone e sobe o Appium com o driver XCUITest.
4. Executa a suíte Robot com o listener do Allure.
5. Em um job Ubuntu separado, gera o relatório Allure e, na `main`, publica no GitHub Pages em `/flutter-ios`.

O relatório fica em outro job porque a action do Allure roda em Docker, que não está disponível nos runners macOS.

## Padrões Aplicados

- Testes ficam em `tests`; keywords e seletores ficam em `resources`.
- Não há `Sleep`; os testes usam esperas explícitas.
- Cada teste abre uma sessão nova, então a lista de tarefas sempre começa vazia.
- Os seletores priorizam `accessibility_id`, definido no próprio app.
- O build do app, a pasta `ios/` e os relatórios não são versionados.

## Roteiro de Estudo

1. Leia o `lib/main.dart` e veja onde cada `Id` foi colocado.
2. Abra o app no Appium Inspector e compare a árvore de elementos com o código.
3. Adicione um identificador novo no app e escreva um teste que o use.
4. Compare esta suíte com a de Android em `Mobile/`: o que muda entre UiAutomator2 e XCUITest?
5. Experimente o [Appium Flutter Integration Driver](https://github.com/AppiumTestDistribution/appium-flutter-integration-driver) e compare com a abordagem por acessibilidade.
