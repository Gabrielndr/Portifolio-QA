# ⚡ K6 + Mock - Testes de Performance e Carga

Testes de performance e carga utilizando **K6**, integrados com **WireMock** para simulação de API (mock server). Os testes cobrem cenários de consulta, sucesso e erro em uma API REST de carros, com geração de relatórios HTML automáticos.

---

## 📁 Estrutura de Arquivos

```
K6 + Mock/
│
├── 📁 tests/                    # Scripts de teste K6
│   ├── consulta.js              # Teste de consulta GET com validações
│   ├── script.js                # Teste de carga POST com erro 500
│   └── testsucess.js            # Teste de stress POST com sucesso 201
│
├── 📁 wiremock/                 # Configurações do Mock Server
│   ├── mappings/
│   │   ├── api-cars.json        # Mock GET /api/cars → 200
│   │   ├── api-cars-404.json    # Mock POST /api/cars → 404
│   │   ├── post-cars.json       # Mock POST /api/cars (fusca) → 201
│   │   └── post-cars-500.json   # Mock POST /api/cars (up tsi) → 500
│   └── __files/
│       └── cars.json            # Dados fictícios de 5 carros
│
└── 📁 report/                   # Relatórios HTML gerados após execução
    ├── consulta.html
    ├── script.html
    └── test-success.html
```

---

## 🧪 Scripts de Teste

### 🔍 consulta.js — Teste de Consulta GET
Valida a listagem de carros retornada pela API mockada.

**Configuração:** Execução simples (1 VU)

**Validações:**
| Check | Condição |
|---|---|
| `status is 200` | Response status === 200 |
| `contains 5 cars` | Array retornado tem exatamente 5 itens |
| `car 1 is Toyota Corolla` | Primeiro carro é Toyota Corolla |
| `car 5 is BMW M3` | Último carro é BMW M3 |

---

### 💥 script.js — Teste de Carga POST (Erro 500)
Simula carga de 10 usuários simultâneos enviando um modelo não permitido.

**Configuração:**
```javascript
vus: 10        // 10 usuários virtuais simultâneos
duration: '30s' // Duração total de 30 segundos
```

**Payload enviado:**
```json
{
  "brand": "Volkswagen",
  "model": "up tsi",
  "year": 2020
}
```

**Validações:**
| Check | Condição |
|---|---|
| `status is 500` | Response status === 500 |
| `error message is correct` | Mensagem: `"Internal server error: model 'up tsi' is not allowed."` |

---

### ✅ testsucess.js — Teste de Stress POST (Sucesso 201)
Simula um cenário de stress com rampa de subida e descida de usuários.

**Configuração (Stages):**
```javascript
{ duration: '5s',  target: 100 }  // Sobe para 100 VUs em 5s
{ duration: '10s', target: 500 }  // Sobe para 500 VUs em 10s
{ duration: '5s',  target: 100 }  // Desce para 100 VUs em 5s
```

**Payload enviado:**
```json
{
  "brand": "Volkswagen",
  "model": "fusca",
  "year": 1965
}
```

**Validações:**
| Check | Condição |
|---|---|
| `status is 201` | Response status === 201 |
| `message is correct` | Mensagem: `"Car successfully registered!"` |
| `carId is 6` | ID retornado === 6 |

---

## 🎭 Mock Server — WireMock

A API é simulada com **WireMock**, respondendo de forma diferente conforme o modelo do carro enviado:

| Método | Endpoint | Condição | Status | Resposta |
|---|---|---|---|---|
| `GET` | `/api/cars` | — | `200 OK` | Lista com 5 carros |
| `POST` | `/api/cars` | model = `fusca` | `201 Created` | `Car successfully registered!` |
| `POST` | `/api/cars` | model = `up tsi` | `500 Error` | `Internal server error: model 'up tsi' is not allowed.` |
| `POST` | `/api/cars` | qualquer outro | `404 Not Found` | `Car model not found.` |

### 📦 Dados do Mock (cars.json)

```json
[
  { "id": 1, "brand": "Toyota",    "model": "Corolla", "year": 2020 },
  { "id": 2, "brand": "Honda",     "model": "Civic",   "year": 2021 },
  { "id": 3, "brand": "Ford",      "model": "Mustang", "year": 2019 },
  { "id": 4, "brand": "Chevrolet", "model": "Camaro",  "year": 2018 },
  { "id": 5, "brand": "BMW",       "model": "M3",      "year": 2022 }
]
```

---

## ⚙️ Pré-requisitos

- [K6](https://k6.io/docs/getting-started/installation/) instalado
- [WireMock](https://wiremock.org/docs/running-standalone/) standalone (JAR) ou Docker
- Java 11+ (para rodar o WireMock JAR)

---

## 🚀 Como Executar

### 1. Inicie o WireMock (Mock Server)

**Via JAR:**
```bash
java -jar wiremock-standalone.jar --port 8080 --root-dir ./wiremock
```

**Via Docker:**
```bash
docker run -it --rm \
  -p 8080:8080 \
  -v $PWD/wiremock:/home/wiremock \
  wiremock/wiremock:latest \
  --port 8080
```

Verifique se está rodando acessando:
```
http://localhost:8080/api/cars
```

---

### 2. Execute os testes K6

**Teste de consulta GET:**
```bash
k6 run tests/consulta.js
```

**Teste de carga POST (erro 500):**
```bash
k6 run tests/script.js
```

**Teste de stress POST (sucesso 201):**
```bash
k6 run tests/testsucess.js
```

**Executar todos e salvar relatórios:**
```bash
k6 run tests/consulta.js
k6 run tests/script.js
k6 run tests/testsucess.js
```

Os relatórios HTML são gerados automaticamente na pasta `report/`.

---

## 📊 Relatórios

Após cada execução, um relatório HTML é gerado automaticamente via `k6-reporter`:

| Arquivo | Teste |
|---|---|
| `report/consulta.html` | Resultado do teste GET |
| `report/script.html` | Resultado do teste de carga POST 500 |
| `report/test-success.html` | Resultado do teste de stress POST 201 |

Para visualizar:
```bash
start report/consulta.html      # Windows
open report/consulta.html       # Mac
xdg-open report/consulta.html   # Linux
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Finalidade |
|---|---|
| K6 | Framework de testes de performance e carga |
| WireMock | Mock server para simulação de API |
| k6-reporter | Geração de relatórios HTML |
| JSON | Formato dos mocks e payloads |

---

## 📌 Boas Práticas Aplicadas

- ✅ Uso de `check()` para validações explícitas de status e body
- ✅ `sleep(1)` entre requisições para simular comportamento real de usuário
- ✅ Stages configurados para simular rampa de carga (subida e descida)
- ✅ Mock server com respostas condicionais por `matchesJsonPath`
- ✅ Relatórios HTML gerados automaticamente via `handleSummary`
- ✅ Separação clara entre cenários de sucesso, erro 500 e erro 404

---

## 👨‍💻 Autor

**Gabriel da Silva**  
QA Engineer | [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) | [GitHub](https://github.com/Gabrielndr)
