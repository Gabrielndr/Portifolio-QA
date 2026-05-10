# BDD - Behavior Driven Development

Esta pasta documenta regras de negócio e critérios de aceite em Gherkin. O objetivo é servir como ponte entre QA, desenvolvimento e negócio, mantendo os cenários claros o suficiente para revisão manual e estruturados o suficiente para automação futura com Cucumber, Cypress ou Robot Framework.

## Estrutura

```text
BDD/
├── login.feature       # Login web no Fake Store
├── formulario.feature  # Formulário web LetCode
├── produtos.feature    # API ServeRest - produtos
├── usuarios.feature    # API ServeRest - usuários
└── cars_api.feature    # API mockada com WireMock + performance K6
```

## Cobertura

| Arquivo | Área | Foco |
|---|---|---|
| `login.feature` | Web | Autenticação, sessão e senha mascarada |
| `formulario.feature` | Web | Cadastro, obrigatórios, e-mail e termos |
| `produtos.feature` | API | CRUD, validação e autenticação |
| `usuarios.feature` | API | Cadastro, login, listagem e exclusão |
| `cars_api.feature` | API/Performance | Contratos mockados, carga e stress |

## Tags

| Tag | Uso |
|---|---|
| `@web` | Cenários de interface |
| `@api` | Cenários de API |
| `@mock` | Cenários dependentes de WireMock |
| `@performance` | Cenários de K6, carga ou stress |
| `@critico` | Fluxos essenciais para regressão |
| `@sucesso` | Caminho feliz |
| `@falha` ou `@erro` | Erro esperado |
| `@validacao` | Validação de campo ou regra |
| `@seguranca` | Token, senha, sessão ou permissão |
| `@tabela` | Cenários data-driven |

## Convenções

- Escreva cenários no idioma do negócio, sem detalhes de seletor CSS ou implementação.
- Use `Contexto` apenas para pré-condições realmente comuns.
- Evite ids fixos de massa. Prefira dados criados no próprio cenário ou placeholders como `<timestamp>`.
- Separe escopos: formulário não deve conter cenários de dropdowns ou inputs de outra tela.
- Use tags por camada, objetivo e criticidade.
- Mantenha cada cenário independente, com pré-condição e resultado verificável.

## Exemplo de padrão

```gherkin
# language: pt

@bdd @api @critico
Funcionalidade: Exemplo
  Como usuário do sistema
  Quero executar uma ação relevante
  Para obter um benefício mensurável

  Contexto:
    Dado que a aplicação está disponível

  @sucesso
  Cenário: Executar ação com dados válidos
    Quando envio dados válidos
    Então devo receber uma resposta de sucesso
```

## Automação futura

Para automatizar com Cypress + Cucumber, instale um pré-processador de Gherkin e aponte o `specPattern` para os arquivos `.feature`. A automação deve implementar steps reutilizáveis por domínio, por exemplo:

- `Dado que a API ServeRest está disponível`
- `Quando envio uma requisição POST para "/produtos" com o body:`
- `Então o status da resposta deve ser 201`

Para Robot Framework, os cenários podem orientar keywords Given/When/Then equivalentes nos arquivos `.robot`.
