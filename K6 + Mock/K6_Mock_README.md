# K6 + WireMock - Testes de performance e contrato

Suite de testes de API usando K6 com WireMock como mock server. A ideia aqui e separar smoke/contrato, carga e stress para deixar o projeto mais claro para leitura tecnica e mais seguro para rodar no dia a dia.

## Estrutura

```text
K6 + Mock/
├── __files/
│   └── cars.json
├── mappings/
│   ├── api-cars.json
│   ├── api-cars-404.json
│   ├── post-cars.json
│   └── post-cars-500.json
├── tests/
│   ├── lib/
│   │   └── config.js
│   ├── reports/
│   │   └── .gitkeep
│   ├── smoke_contract.js
│   ├── load_get_cars.js
│   ├── load_post_error.js
│   └── stress_post_success.js
├── run-all.ps1
├── start-wiremock.ps1
└── wiremock-standalone-3.13.2.jar
```

## Cobertura

| Script | Objetivo | Perfil |
|---|---|---|
| `tests/smoke_contract.js` | Valida GET 200, POST 201, POST 500 esperado e fallback 404 | 1 iteracao |
| `tests/load_get_cars.js` | Mede a consulta de carros sob carga leve | `VUS=5`, `DURATION=20s` |
| `tests/load_post_error.js` | Mede a rota de erro esperado sem marcar 500 como falha tecnica | `VUS=10`, `DURATION=30s` |
| `tests/stress_post_success.js` | Stress com rampa ate 500 VUs no cadastro com sucesso | perfil `portfolio` |

## Mocks

| Metodo | Endpoint | Condicao | Status |
|---|---|---|---|
| `GET` | `/api/cars` | lista fixa em `__files/cars.json` | `200` |
| `POST` | `/api/cars` | `model = fusca` e `year = 1965` | `201` |
| `POST` | `/api/cars` | `model = up tsi` e `year = 2020` | `500` |
| `POST` | `/api/cars` | qualquer outro payload | `404` |

Os mappings usam `priority`: respostas especificas ficam com prioridade `1`, e o fallback 404 fica com prioridade `10`. Isso evita conflito entre o mock generico e os cenarios especificos.

## Pre-requisitos

- Java instalado.
- K6 instalado.
- Porta `8080` livre.

Valide as versoes:

```powershell
java -version
k6 version
```

## Como executar

Abra um terminal na pasta `K6 + Mock` e suba o WireMock:

```powershell
.\start-wiremock.ps1
```

Em outro terminal, rode o smoke de contrato:

```powershell
k6 run .\tests\smoke_contract.js
```

Para executar tudo com perfil rapido de stress:

```powershell
.\run-all.ps1 -SmokeProfile
```

Para executar o perfil completo do portfolio:

```powershell
.\run-all.ps1
```

Tambem da para ajustar carga por variavel de ambiente:

```powershell
$env:VUS = '2'
$env:DURATION = '10s'
k6 run .\tests\load_get_cars.js
```

## Relatorios

Os scripts geram HTML e JSON em `tests/reports/`. Esses arquivos sao artefatos de execucao e ficam fora do versionamento pelo `.gitignore`.

## Melhorias aplicadas

- Separacao entre smoke/contrato, carga GET, carga de erro esperado e stress de sucesso.
- Thresholds para checks, duracao e falhas HTTP.
- `http.expectedStatuses()` nos cenarios que validam erro esperado, evitando falsos negativos em 404/500 controlados.
- Configuracao compartilhada de `BASE_URL`, `REPORT_DIR`, headers e parse de JSON.
- Relatorios removidos do versionamento.
- Scripts PowerShell para subir WireMock e rodar a suite.
