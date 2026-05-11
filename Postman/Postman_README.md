# Postman - Testes de API REST com Newman

Suite de API para a ServeRest, cobrindo criacao de usuario admin, login, CRUD de produtos, consulta/delecao de usuario e cenarios negativos.

Antes, esta pasta tinha apenas prints e documentacao manual. Agora ela tambem tem uma collection versionada, environment, execucao por Newman e workflow no GitHub Actions.

## Estrutura

```text
Postman/
├── collections/
│   └── serverest.postman_collection.json
├── environments/
│   └── serverest.postman_environment.json
├── scripts/
│   └── ensure-reports-dir.js
├── reports/
├── package.json
└── Postman_README.md
```

Os arquivos `.png` continuam na pasta como evidencia visual das execucoes manuais.

## Cobertura

| Fluxo | Metodo | Endpoint | Validacoes |
|---|---|---|---|
| Cadastrar usuario admin | `POST` | `/usuarios` | status `201`, mensagem e `_id` |
| Login | `POST` | `/login` | status `200`, mensagem e token Bearer |
| Cadastrar produto | `POST` | `/produtos` | status `201`, mensagem e `_id` |
| Listar produtos | `GET` | `/produtos` | contrato basico e produto criado na lista |
| Editar produto | `PUT` | `/produtos/{{productId}}` | status `200` e mensagem |
| Deletar produto | `DELETE` | `/produtos/{{productId}}` | status `200` e mensagem |
| Listar usuarios | `GET` | `/usuarios` | contrato basico e usuario criado na lista |
| Deletar usuario | `DELETE` | `/usuarios/{{userId}}` | status `200` e mensagem |
| Login invalido | `POST` | `/login` | status `401` |
| Produto sem token | `POST` | `/produtos` | status `401` |
| Produto inexistente | `GET` | `/produtos/0000000000000000` | status `400` |

## Variaveis

| Variavel | Origem | Uso |
|---|---|---|
| `baseUrl` | environment | URL da API, por padrao `https://serverest.dev` |
| `userEmail` / `userPassword` | pre-request | credenciais dinamicas do usuario criado |
| `userId` | teste de cadastro | delecao e validacao de lista |
| `token` | teste de login | rotas protegidas de produto |
| `productName` / `productId` | pre-request/teste de produto | CRUD de produto |

## Como importar no Postman

1. Abra o Postman.
2. Importe `collections/serverest.postman_collection.json`.
3. Importe `environments/serverest.postman_environment.json`.
4. Selecione o environment `ServeRest - Public`.
5. Execute a collection pelo Runner.

## Como rodar por linha de comando

Instale as dependencias:

```powershell
cd "C:\Users\gabri.QZIN\Desktop\GIT\Postman"
npm install
```

Rode com relatorio CLI + JSON:

```powershell
npm test
```

Rode com relatorio HTML:

```powershell
npm run test:html
```

Os relatorios ficam em `Postman/reports/` e nao entram no versionamento.

## CI

O workflow `.github/workflows/postman-newman.yml` executa a collection com Newman em push, pull request e manualmente pelo GitHub Actions.

## Boas praticas aplicadas

- Collection exportada e versionada.
- Environment separado da collection.
- Massa dinamica para evitar conflito de email/produto ja existente.
- Token salvo automaticamente apos login.
- Testes positivos e negativos.
- Assertions de status, contrato basico, mensagem e tempo de resposta.
- Execucao local por Newman e execucao automatica em CI.
