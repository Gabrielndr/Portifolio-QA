# 📮 Postman - Testes de API REST

Testes de API REST utilizando **Postman**, cobrindo o CRUD completo de uma aplicação com autenticação JWT. A collection cobre dois módulos principais: **Produtos** e **Usuários**, com validação de status codes e respostas JSON.

---

## 📁 Estrutura da Collection

```
Serverst Teste/
├── 📂 Produtos
│   ├── POST   Adicionar produto
│   ├── GET    Listar produtos
│   ├── PUT    Editar produto
│   └── DEL    Deletar produto
│
└── 📂 Usuarios
    ├── POST   Criar usuario
    ├── POST   Login
    ├── GET    Listar usuarios
    └── DEL    Deletar usuario
```

---

## 🔐 Autenticação

A API utiliza **JWT (Bearer Token)**. O token é retornado no endpoint de Login e deve ser incluído no header `Authorization` das requisições protegidas.

```
Authorization: Bearer <token>
```

**Variável de ambiente utilizada:**
```
{{Base_URL}} → URL base da API
```

---

## 📋 Endpoints Documentados

### 📦 Produtos

#### ➕ Adicionar Produto
| Campo | Valor |
|---|---|
| Método | `POST` |
| Endpoint | `{{Base_URL}}/produtos` |
| Status esperado | `201 Created` |

**Body (JSON):**
```json
{
  "nome": "Mouse Razer Viper Mini",
  "preco": 480,
  "descricao": "House",
  "quantidade": 120
}
```

**Resposta:**
```json
{
  "message": "Cadastro realizado com sucesso",
  "_id": "pyk0JKg86ceb00T9"
}
```

---

#### 📋 Listar Produtos
| Campo | Valor |
|---|---|
| Método | `GET` |
| Endpoint | `{{Base_URL}}/produtos` |
| Status esperado | `200 OK` |

**Resposta:** Array com todos os produtos cadastrados (nome, preço, descrição, quantidade, _id)

---

#### ✏️ Editar Produto
| Campo | Valor |
|---|---|
| Método | `PUT` |
| Endpoint | `{{Base_URL}}/produtos/{id}` |
| Status esperado | `200 OK` |

**Body (JSON):**
```json
{
  "nome": "Mouse Razer Viper Mini3",
  "preco": 450,
  "descricao": "House",
  "quantidade": 120
}
```

**Resposta:**
```json
{
  "message": "Registro alterado com sucesso"
}
```

---

#### 🗑️ Deletar Produto
| Campo | Valor |
|---|---|
| Método | `DELETE` |
| Endpoint | `{{Base_URL}}/produtos/{id}` |
| Status esperado | `200 OK` |

**Resposta:**
```json
{
  "message": "Registro excluído com sucesso"
}
```

---

### 👤 Usuários

#### ➕ Criar Usuário
| Campo | Valor |
|---|---|
| Método | `POST` |
| Endpoint | `{{Base_URL}}/usuarios` |
| Status esperado | `201 Created` |

**Body (JSON):**
```json
{
  "nome": "Qzin andrade",
  "email": "qzin@qa.com.br",
  "password": "teste",
  "administrador": "true"
}
```

**Resposta:**
```json
{
  "message": "Cadastro realizado com sucesso",
  "_id": "PNeX31c09hgNBReJ"
}
```

---

#### 🔐 Login
| Campo | Valor |
|---|---|
| Método | `POST` |
| Endpoint | `{{Base_URL}}/login` |
| Status esperado | `200 OK` |

**Body (JSON):**
```json
{
  "email": "qzin@qa.com.br",
  "password": "teste"
}
```

**Resposta:**
```json
{
  "message": "Login realizado com sucesso",
  "authorization": "Bearer eyJhbGci..."
}
```

---

#### 📋 Listar Usuários
| Campo | Valor |
|---|---|
| Método | `GET` |
| Endpoint | `{{Base_URL}}/usuarios` |
| Status esperado | `200 OK` |

**Resposta:** Array com todos os usuários (nome, email, password, administrador, _id)

---

#### 🗑️ Deletar Usuário
| Campo | Valor |
|---|---|
| Método | `DELETE` |
| Endpoint | `{{Base_URL}}/usuarios/{id}` |
| Status esperado | `200 OK` |

**Resposta:**
```json
{
  "message": "Registro excluído com sucesso"
}
```

---

## ⚙️ Como Importar e Executar

**1. Instale o Postman**

Baixe em: https://www.postman.com/downloads/

**2. Importe a collection**

- Abra o Postman
- Clique em **Import**
- Selecione o arquivo `.json` da collection

**3. Configure o Environment**

- Clique em **Environments → Add**
- Crie uma variável:

| Variável | Valor |
|---|---|
| `Base_URL` | URL da API (ex: `https://serverest.dev`) |

**4. Execute os testes**

- Manualmente: clique em **Send** em cada requisição
- Em lote: clique em **Runner** → selecione a collection → **Run**

---

## 📊 Resultados Observados

| Endpoint | Método | Status Obtido | Tempo |
|---|---|---|---|
| /produtos | POST | 201 Created | 168ms |
| /produtos | GET | 200 OK | 731ms |
| /produtos/{id} | PUT | 200 OK | 177ms |
| /produtos/{id} | DELETE | 200 OK | 172ms |
| /usuarios | POST | 201 Created | 186ms |
| /login | POST | 200 OK | 341ms |
| /usuarios | GET | 200 OK | 529ms |
| /usuarios/{id} | DELETE | 200 OK | 393ms |

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Finalidade |
|---|---|
| Postman | Client de testes de API |
| JWT | Autenticação via Bearer Token |
| JSON | Formato de envio e resposta |
| ServeRest | API REST de teste utilizada |

---

## 📌 Boas Práticas Aplicadas

- ✅ Uso de variável de ambiente `{{Base_URL}}` para facilitar troca de ambiente
- ✅ Autenticação JWT aplicada nas rotas protegidas
- ✅ Validação de status codes (200, 201)
- ✅ Organização em pastas por módulo (Produtos / Usuários)
- ✅ Testes cobrindo CRUD completo

---

## 👨‍💻 Autor

**Gabriel da Silva**  
QA Engineer | [LinkedIn](https://www.linkedin.com/in/gabrielsndr/) | [GitHub](https://github.com/Gabrielndr)
