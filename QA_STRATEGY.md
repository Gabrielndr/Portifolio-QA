# QA Strategy

Este documento resume a estratégia de qualidade aplicada neste portfólio. A intenção é mostrar não apenas ferramentas, mas também critério técnico para decidir o que testar, em qual camada testar e qual risco cada suíte reduz.

## Objetivo

Garantir confiança nos principais fluxos web, APIs, contratos e comportamento sob carga, mantendo uma suíte organizada, executável localmente e integrada ao GitHub Actions.

Os testes foram separados por camada para evitar uma suíte lenta, frágil e difícil de diagnosticar. Cada ferramenta tem uma responsabilidade clara dentro da estratégia.

## Pirâmide de Testes

```text
        UI E2E
   Cypress / Robot

      API / Contrato
   Postman / Newman / K6 smoke

    Performance / Resiliência
       K6 + WireMock

    BDD / Critérios
       Gherkin
```

Neste portfólio, a base de critérios fica nos arquivos BDD. A validação automatizada se concentra em API e fluxos críticos de UI. A camada de performance usa mocks para controlar respostas e tornar a execução previsível.

## Papel de Cada Ferramenta

| Ferramenta | Papel na estratégia | Por que foi usada |
|---|---|---|
| Cypress | Validar fluxos E2E web e comportamento no navegador | Boa velocidade, boa depuração, interceptação de APIs e relatórios Allure |
| Robot Framework | Demonstrar automação web orientada a keywords e BDD | Fácil leitura para times multidisciplinares e forte organização em resources |
| Postman + Newman | Validar API REST e contratos básicos da ServeRest | Collection versionada, environment, massa dinâmica e execução simples em CI |
| K6 + WireMock | Validar smoke, carga, erro esperado e stress em API mockada | Controle de massa/resposta, medição de performance e thresholds objetivos |
| Gherkin | Documentar critérios de aceite | Linguagem comum entre QA, produto e desenvolvimento |
| GitHub Actions | Automatizar feedback | Evidência pública de execução e qualidade contínua |

## Critérios de Risco

| Risco | Exemplo | Cobertura aplicada |
|---|---|---|
| Fluxo crítico de usuário | Login, checkout, formulário | Cypress e Robot |
| Quebra de contrato de API | Campos ausentes, status incorreto, token inválido | Postman/Newman |
| Regressão visual/comportamental | Estados de botão, campos disabled/readonly, dropdowns | Cypress e Robot |
| Falha em erro esperado | 401, 404, 500 controlado | Postman e K6 |
| Performance básica | Latência e comportamento sob carga leve/stress | K6 |
| Instabilidade de ambiente externo | APIs de terceiros e site real | Intercepts, mocks e smoke controlado |

## Tipos de Teste

**Smoke**

Suíte curta para responder rapidamente se o ambiente e o fluxo principal estão saudáveis. No Robot, existe um cenário smoke para validação rápida, mas o CI publica a suíte completa no Allure. No K6, o smoke valida GET, POST de sucesso, erro esperado e fallback.

**Regressão**

Conjunto mais amplo para garantir que funcionalidades existentes continuam funcionando após mudanças. Cypress e Robot cobrem regressão web; Postman cobre regressão de API.

**Contrato**

Validação de status, estrutura mínima e mensagens esperadas das APIs. A intenção é detectar alterações que quebrem consumidores antes que o problema vire falha funcional.

**Performance**

Validação de tempo de resposta, estabilidade sob carga e comportamento em cenários de erro controlado. K6 usa thresholds para transformar desempenho em critério objetivo.

## Critérios de Qualidade no CI

| Suíte | Critério de sucesso |
|---|---|
| Cypress | Specs E2E passam e relatório Allure é gerado |
| Robot | Suíte completa headless passa e gera resultados Allure |
| Postman/Newman | Collection passa com 0 falhas e gera artefatos |
| K6/WireMock | Smoke/carga curta passam com thresholds e artefatos publicados |
| GitHub Pages | Portal e relatórios são publicados |

## Decisões de Manutenção

- Relatórios e resultados de execução ficam fora do versionamento.
- Dados dinâmicos são usados para evitar conflito entre execuções.
- Testes de UI priorizam seletores e validações estáveis.
- Mocks são usados quando o objetivo é previsibilidade.
- Workflows são separados por suíte para facilitar diagnóstico.
- O comando `run-all.ps1` centraliza a execução local sem substituir os comandos específicos de cada ferramenta.

## Melhorias Futuras

- Remover o JAR do WireMock do repositório e baixar por script ou usar Docker.
- Evoluir o Robot para executar mais cenários reais no CI conforme estabilidade do alvo.
- Adicionar matriz de rastreabilidade entre BDD e automações.
- Publicar relatório HTML do Newman no GitHub Pages.
- Adicionar dashboards históricos de performance K6.
