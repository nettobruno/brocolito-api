# Brocolito API

[![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Ruby on Rails](https://img.shields.io/badge/Rails-D30001?style=for-the-badge&logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![JWT](https://img.shields.io/badge/JWT-000000?style=for-the-badge&logo=jsonwebtokens&logoColor=white)](https://jwt.io/)
[![bcrypt](https://img.shields.io/badge/bcrypt-000000?style=for-the-badge&logo=rubygems&logoColor=white)](https://rubygems.org/gems/bcrypt)
[![RuboCop](https://img.shields.io/badge/RuboCop-000000?style=for-the-badge&logo=ruby&logoColor=white)](https://rubocop.org/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)

API REST em Ruby on Rails para gerenciamento de usuarios, autenticacao via JWT e acompanhamento de medidas corporais.

---

## Stack Utilizada

### Backend

- Ruby 4.0.1
- Ruby on Rails 8.1
- PostgreSQL
- Puma

### Autenticacao

- JWT
- bcrypt
- `has_secure_password`

### Qualidade

- RuboCop Rails Omakase
- GitHub Actions

### Ferramentas Incluidas pelo Template Rails (Estudar)

- Docker: empacotamento da aplicacao em containers.
- Kamal: deploy de aplicacoes Rails usando Docker.
- Solid Queue: processamento de jobs em background usando banco de dados.
- Solid Cache: cache usando banco de dados.
- Solid Cable: Action Cable usando banco de dados.
- Brakeman: analise estatica de seguranca para aplicacoes Rails.
- Bundler Audit: auditoria de vulnerabilidades conhecidas nas gems.

---

## Funcionalidades

- Cadastro de usuarios
- Login com email e senha
- Autenticacao via token JWT
- Perfil do usuario autenticado
- Atualizacao de dados do usuario autenticado
- Atualizacao de senha com validacao da senha atual
- Controle de acesso para administradores
- Registro de medidas corporais
- Listagem das medidas do usuario autenticado
- Comparacao entre primeira e ultima medicao corporal

---

## Rodando Localmente

Clone o projeto:

```bash
git clone https://github.com/nettobruno/brocolito-api.git
```

Entre na pasta:

```bash
cd brocolito-api
```

Instale as dependencias:

```bash
bundle install
```

Prepare o banco de dados:

```bash
bin/rails db:setup
```

Inicie o servidor:

```bash
bin/rails server
```

Acesse:

```bash
http://localhost:3000
```

---

## Seeds

O projeto possui seeds com usuarios e medidas corporais para desenvolvimento.

Para carregar os dados:

```bash
bin/rails db:seed
```

Credenciais disponiveis nos seeds:

```text
admin@exemplo.com / 123123
bruno@exemplo.com / 123123
ana@exemplo.com / 123123
```

---

## Autenticacao

Para acessar rotas protegidas, faca login:

```http
POST /login
```

Payload:

```json
{
  "authentication": {
    "email": "admin@exemplo.com",
    "password": "123123"
  }
}
```

Resposta:

```json
{
  "token": "jwt_token",
  "user": {
    "id": 1,
    "name": "Admin",
    "email": "admin@exemplo.com"
  }
}
```

Use o token retornado no header das proximas requisicoes:

```http
Authorization: Bearer jwt_token
```

---

## Rotas Principais

### Autenticacao

| Metodo | Rota | Descricao |
| --- | --- | --- |
| `POST` | `/login` | Autentica o usuario e retorna um token JWT |

### Usuarios

| Metodo | Rota | Acesso | Descricao |
| --- | --- | --- | --- |
| `POST` | `/users` | Publico | Cria um usuario |
| `GET` | `/users` | Admin | Lista usuarios |
| `GET` | `/users/:id` | Admin | Exibe um usuario |
| `PATCH` | `/users/:id` | Admin | Atualiza um usuario |
| `DELETE` | `/users/:id` | Admin ou dono | Remove um usuario |
| `GET` | `/users/me` | Autenticado | Exibe o usuario autenticado |
| `PATCH` | `/users/me` | Autenticado | Atualiza o usuario autenticado |
| `PATCH` | `/users/me/password` | Autenticado | Atualiza a senha do usuario autenticado |

### Medidas Corporais

| Metodo | Rota | Acesso | Descricao |
| --- | --- | --- | --- |
| `GET` | `/body_measurements` | Autenticado | Lista as medidas do usuario autenticado |
| `POST` | `/body_measurements` | Autenticado | Cria uma medida para o usuario autenticado |
| `GET` | `/body_measurements/:id` | Autenticado | Exibe uma medida do usuario autenticado |
| `PATCH` | `/body_measurements/:id` | Autenticado | Atualiza uma medida do usuario autenticado |
| `DELETE` | `/body_measurements/:id` | Autenticado | Remove uma medida do usuario autenticado |
| `GET` | `/body_measurements/compare` | Autenticado | Compara a primeira e a ultima medida do usuario autenticado |

---

## Exemplos de Requisicao

Criar usuario:

```http
POST /users
```

```json
{
  "user": {
    "name": "Bruno",
    "email": "bruno@exemplo.com",
    "password": "123123"
  }
}
```

Atualizar perfil autenticado:

```http
PATCH /users/me
```

```json
{
  "user": {
    "name": "Bruno Neto",
    "email": "bruno@exemplo.com"
  }
}
```

Atualizar senha:

```http
PATCH /users/me/password
```

```json
{
  "user": {
    "current_password": "123123",
    "password": "nova_senha"
  }
}
```

Criar medida corporal:

```http
POST /body_measurements
```

```json
{
  "body_measurement": {
    "weight_kg": 84.2,
    "height_cm": 178,
    "waist_circumference_cm": 90.0,
    "chest_circumference_cm": 102.0
  }
}
```

---

## Qualidade

Rodar RuboCop:

```bash
bin/rubocop
```

Rodar pipeline local:

```bash
bin/ci
```

Comandos incluidos pelo template Rails para estudar:

Rodar Brakeman:

```bash
bin/brakeman
```

Rodar auditoria de dependencias:

```bash
bin/bundler-audit
```

---

## Commits

Este projeto segue a convencao Conventional Commits.

Exemplos:

- `feat:` nova funcionalidade
- `fix:` correcao de bug
- `refactor:` refatoracao sem mudanca de comportamento
- `style:` ajustes de formatacao
- `chore:` tarefas de manutencao
- `build:` dependencias ou configuracoes de build

---

## Observacoes de Seguranca

- O campo `password_digest` nao deve ser retornado nas respostas da API.
- Rotas protegidas exigem JWT no header `Authorization`.
- Rotas administrativas exigem usuario com `admin: true`.
- A troca de senha exige a senha atual do usuario autenticado.
