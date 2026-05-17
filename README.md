# Brocolito API

[![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)
[![Ruby on Rails](https://img.shields.io/badge/Rails-D30001?style=for-the-badge&logo=rubyonrails&logoColor=white)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![JWT](https://img.shields.io/badge/JWT-000000?style=for-the-badge&logo=jsonwebtokens&logoColor=white)](https://jwt.io/)
[![bcrypt](https://img.shields.io/badge/bcrypt-000000?style=for-the-badge&logo=rubygems&logoColor=white)](https://rubygems.org/gems/bcrypt)
[![RuboCop](https://img.shields.io/badge/RuboCop-000000?style=for-the-badge&logo=ruby&logoColor=white)](https://rubocop.org/)

API REST em Ruby on Rails para autenticação, perfil de usuário e acompanhamento de medidas corporais do Brocolito.

<img width="2172" height="724" alt="ChatGPT Image 9 de mai  de 2026, 01_22_39" src="https://github.com/user-attachments/assets/c1a93dc1-1a9a-4ac4-ab10-00b5056a2496" />

---

## Stack

- Ruby 4.0.1
- Rails 8.1
- PostgreSQL
- Puma
- JWT
- bcrypt
- rack-cors
- RuboCop Rails Omakase

### Ferramentas incluídas pelo template Rails para estudo

- Docker: empacotamento da aplicação em containers.
- Kamal: deploy de aplicações Rails usando Docker.
- Solid Queue: processamento de jobs em background usando banco de dados.
- Solid Cache: cache usando banco de dados.
- Solid Cable: Action Cable usando banco de dados.
- Brakeman: análise estática de segurança para aplicações Rails.
- Bundler Audit: auditoria de vulnerabilidades conhecidas nas gems.

---

## Funcionalidades

- Cadastro e login de usuários
- Autenticação via JWT
- Perfil do usuário autenticado
- Objetivo do usuário: perder peso ou ganhar peso
- Atualização de senha com validação da senha atual
- Controle de acesso para administradores
- CRUD de medidas corporais
- Comparativo entre medições do usuário autenticado

---

## Pré-requisitos

- Ruby 4.0.1
- Bundler
- PostgreSQL rodando localmente

O banco de desenvolvimento usa a configuração padrão do PostgreSQL local:

```text
database: brocolito_api_development
```

Se o seu PostgreSQL exigir usuário, senha, host ou porta, ajuste `config/database.yml` ou use variáveis compatíveis com Rails/PostgreSQL no seu ambiente.

---

## Rodando localmente

Instale as dependências:

```bash
bundle install
```

Crie e prepare o banco:

```bash
bin/rails db:setup
```

Se o banco já existir e você só precisa aplicar novas migrations:

```bash
bin/rails db:migrate
```

Inicie a API:

```bash
bin/rails server
```

URL local:

```text
http://localhost:3000
```

Health check:

```http
GET /up
```

---

## Seeds

O projeto possui seeds com usuários e medições para desenvolvimento:

```bash
bin/rails db:seed
```

Credenciais disponíveis:

```text
admin@exemplo.com / 123123
bruno@exemplo.com / 123123
julia@exemplo.com / 123123
```

---

## Autenticação

Faça login:

```http
POST /login
```

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
    "email": "admin@exemplo.com",
    "weight_goal": "lose_weight"
  }
}
```

Use o token nas rotas protegidas:

```http
Authorization: Bearer jwt_token
```

---

## Valores de `weight_goal`

| Valor | Descrição |
| --- | --- |
| `lose_weight` | Usuário quer perder peso |
| `gain_weight` | Usuário quer ganhar peso |

---

## Rotas

### Sistema

| Método | Rota | Acesso | Descrição |
| --- | --- | --- | --- |
| `GET` | `/up` | Público | Health check da aplicação |

### Autenticação

| Método | Rota | Acesso | Descrição |
| --- | --- | --- | --- |
| `POST` | `/login` | Público | Autentica usuário e retorna JWT |

### Usuários

| Método | Rota | Acesso | Descrição |
| --- | --- | --- | --- |
| `POST` | `/users` | Público | Cria usuário |
| `GET` | `/users` | Admin | Lista usuários |
| `GET` | `/users/:id` | Admin | Exibe usuário |
| `PATCH` | `/users/:id` | Admin | Atualiza usuário |
| `DELETE` | `/users/:id` | Admin ou dono | Remove usuário |
| `GET` | `/users/me` | Autenticado | Exibe usuário autenticado |
| `PATCH` | `/users/me` | Autenticado | Atualiza perfil e objetivo |
| `PATCH` | `/users/me/password` | Autenticado | Atualiza senha |

### Medidas corporais

| Método | Rota | Acesso | Descrição |
| --- | --- | --- | --- |
| `GET` | `/body_measurements` | Autenticado | Lista medições do usuário |
| `POST` | `/body_measurements` | Autenticado | Cria medição |
| `GET` | `/body_measurements/:id` | Autenticado | Exibe medição do usuário |
| `PATCH` | `/body_measurements/:id` | Autenticado | Atualiza medição |
| `DELETE` | `/body_measurements/:id` | Autenticado | Remove medição |
| `GET` | `/body_measurements/compare` | Autenticado | Compara primeira e última medição com valor disponível por campo |

---

## Exemplos

### Criar usuário

```http
POST /users
```

```json
{
  "user": {
    "name": "Bruno",
    "email": "bruno@exemplo.com",
    "password": "123123",
    "weight_goal": "lose_weight"
  }
}
```

### Atualizar perfil

```http
PATCH /users/me
Authorization: Bearer jwt_token
```

```json
{
  "user": {
    "name": "Bruno Netto",
    "email": "bruno@exemplo.com",
    "weight_goal": "gain_weight"
  }
}
```

### Atualizar senha

```http
PATCH /users/me/password
Authorization: Bearer jwt_token
```

```json
{
  "user": {
    "current_password": "123123",
    "password": "nova_senha"
  }
}
```

### Criar medição corporal

```http
POST /body_measurements
Authorization: Bearer jwt_token
```

```json
{
  "body_measurement": {
    "weight_kg": 84.2,
    "height_cm": 178,
    "waist_circumference_cm": 90,
    "abdomen_circumference_cm": 92,
    "chest_circumference_cm": 102
  }
}
```

Campos aceitos em `body_measurement`:

```text
weight_kg
height_cm
neck_circumference_cm
chest_circumference_cm
shoulder_circumference_cm
waist_circumference_cm
hip_circumference_cm
abdomen_circumference_cm
relaxed_arm_circumference_cm
flexed_arm_circumference_cm
forearm_circumference_cm
thigh_circumference_cm
calf_circumference_cm
```

`weight_kg` e `height_cm` são obrigatórios. As demais medidas são opcionais.

### Comparar medições

```http
GET /body_measurements/compare
Authorization: Bearer jwt_token
```

Resposta:

```json
{
  "weight_change_kg": -3.5,
  "neck_circumference_change_cm": null,
  "chest_circumference_change_cm": 1.0,
  "shoulder_circumference_change_cm": null,
  "waist_circumference_change_cm": -4.0,
  "hip_circumference_change_cm": null,
  "abdomen_circumference_change_cm": -5.0,
  "relaxed_arm_circumference_change_cm": null,
  "flexed_arm_circumference_change_cm": null,
  "forearm_circumference_change_cm": null,
  "thigh_circumference_change_cm": null,
  "calf_circumference_change_cm": null
}
```

Cada campo compara a primeira e a última medição que possuem valor para aquele campo.

---

## Qualidade

RuboCop:

```bash
bin/rubocop
```

Testes:

```bash
bin/rails test
```

Pipeline local, quando disponível:

```bash
bin/ci
```

Ferramentas auxiliares:

```bash
bin/brakeman
bin/bundler-audit
```

---

## Deploy

Em produção, configure:

```text
DATABASE_URL
RAILS_MASTER_KEY
```

O projeto inclui arquivos de Docker/Kamal gerados pelo template Rails.

---

## Segurança

- `password_digest` não deve ser retornado nas respostas.
- Rotas protegidas exigem JWT no header `Authorization`.
- Rotas administrativas exigem usuário com `admin: true`.
- A troca de senha exige a senha atual.
