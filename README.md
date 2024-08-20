# Teste Backend API Speedio

```markdown
## O que é a API

API Rails integrada com MongoDB para automatizar mensagens no LinkedIn e por email usando a API da Unipile.

## Instruções

### Clonar o Repositório e Instalar Dependências

git clone https://github.com/tierryhahn/desafio_ruby.git
cd seu-repositorio
bundle install
```

### Configurar a API da Unipile

1. Crie uma conta na API da Unipile: [Unipile Signup](https://dashboard.unipile.com/signup)
2. Gere o DSN e o token (API_KEY).
3. Crie um arquivo `.env` na raiz do projeto com os seguintes parâmetros:

```
UNIPILE_API_BASE_URL="https://{seudominio}.unipile.com:{suaporta}/api/v1"
UNIPILE_API_KEY="SUA_SECRET_API_KEY"
```

## Rotas

### Criação de Usuário

- **Método:** POST
- **Endpoint:** `/users`
- **Corpo JSON:**
  ```json
  {
    "user": {
      "name": "Fulano",
      "email": "fulano@mail.com",
      "password": "senha123",
      "password_confirmation": "senha123"
    }
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Usuário criado com sucesso",
    "user": {
      "_id": "66c507b725d6a6425147687a",
      "created_at": "2024-08-20T21:16:39.012Z",
      "email": "fulano@mail.com",
      "name": "Fulano",
      "otp_secret": "koqqcmecmo5stne5",
      "otp_token": "942647",
      "unipile_email_account_id": null,
      "unipile_linkedin_account_id": null,
      "updated_at": "2024-08-20T21:16:39.012Z"
    },
    "otp_secret": "koqqcmecmo5stne5"
  }
  ```

### Autenticação para Login

- **Método:** POST
- **Endpoint:** `/automations/request_link`
- **Corpo JSON:**
  ```json
  {
    "email": "fulano@mail.com",
    "otp_token": "942647", 
    "expiresOn": "2025-12-31T23:59:59.999Z",
    "disabled_features": ["linkedin_recruiter"],
    "api_url": "https://api1.unipile.com:13646",
    "type": "create",
    "providers": "*"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Link de automação solicitado com sucesso",
    "data": {
      "object": "HostedAuthUrl",
      "url": "https://account.unipile.com/linkdeexemplo"
    }
  }
  ```

### Editar Usuário (Inserir Email Account e LinkedIn Account ID)

- **Método:** PATCH
- **Endpoint:** `/users/update_account_ids`
- **Corpo JSON:**
  ```json
  {
    "email": "fulano@mail.com",
    "unipile_email_account_id": "código_no_clipboard_do_dashboard",
    "unipile_linkedin_account_id": "código_no_clipboard_do_dashboard"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "IDs atualizados com sucesso",
    "user": {
      "_id": "66c507b725d6a6425147687a",
      "created_at": "2024-08-20T21:16:39.012Z",
      "email": "fulano@mail.com",
      "name": "Fulano",
      "otp_secret": "koqqcmecmo5stne5",
      "otp_token": null,
      "unipile_email_account_id": "código_no_clipboard_do_dashboard",
      "unipile_linkedin_account_id": "código_no_clipboard_do_dashboard",
      "updated_at": "2024-08-20T21:16:47.637Z"
    }
  }
  ```

### Listar Todos os Chats (LinkedIn)

- **Método:** GET
- **Endpoint:** `/chats`
- **Corpo JSON:**
  ```json
  {
    "account_id": "código_no_clipboard_do_dashboard_do_linkedin"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Lista de chats recuperada com sucesso",
    "data": {
      "object": "ChatList",
      "items": [
        {
          "object": "Chat",
          "name": "Teste Api",
          "type": 1,
          "folder": ["INBOX", "INBOX_LINKEDIN_CLASSIC"],
          "unread": 0,
          "archived": 0,
          "read_only": 0,
          "timestamp": "2024-08-20T21:16:29.000Z",
          "account_id": "exemplo",
          "provider_id": "exemplo",
          "account_type": "LINKEDIN",
          "unread_count": 0,
          "disabledFeatures": [],
          "id": "exemplo",
          "muted_until": null
        }
      ]
    }
  }
  ```

### Listar Chats Existentes (LinkedIn)

- **Método:** GET
- **Endpoint:** `/attendees`
- **Corpo JSON:**
  ```json
  {
    "account_id": "código_no_clipboard_do_dashboard_do_linkedin"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Lista de attendees recuperada com sucesso",
    "data": {
      "object": "ChatAttendeeList",
      "items": [
        {
          "object": "ChatAttendee",
          "account_id": "exemplo",
          "id": "exemplo",
          "is_self": 0,
          "name": "Fulano",
          "hidden": 0,
          "provider_id": "exemplo",
          "picture_url": "url da foto do user",
          "specifics": {
            "provider": "LINKEDIN",
            "member_urn": "urn:li:member:000000",
            "occupation": "descrição perfil",
            "is_company": false
          },
          "profile_url": "exemplo"
        }
      ]
    }
  }
  ```

### Enviar um Email

- **Método:** POST
- **Endpoint:** `/automations/send_email`
- **Corpo JSON:**
  ```json
  {
    "account_id": "código_no_clipboard_do_dashboard_do_email",
    "from": {
      "display_name": "Teste api",
      "identifier": "fulano@mail.com"
    },
    "to": [
      {
        "display_name": "Recipient Name",
        "identifier": "ciclano@mail.com"
      }
    ],
    "subject": "Test Email Subject",
    "body": "Sua mensagem de texto aqui",
    "cc": [],
    "bcc": [],
    "reply_to": "",
    "custom_headers": [],
    "tracking_options": {},
    "attachments": []
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Email enviado com sucesso",
    "data": {
      "object": "EmailSent",
      "tracking_id": "código do email"
    }
  }
  ```

### Começar um Novo Grupo de Chat no LinkedIn

- **Método:** POST
- **Endpoint:** `/automations/send_linkedin_message`
- **Corpo JSON:**
  ```json
  {
    "account_id": "código_no_clipboard_do_dashboard_do_linkedin",
    "text": "Mensagem que deseja enviar",
    "attendees_ids": ["provider_id dos chats existentes", "provider_id2 dos chats existentes"],
    "subject": "Título do chat do grupo"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Mensagem enviada com sucesso",
    "data": {
      "object": "ChatStarted",
      "chat_id": "id do chat criado"
    }
  }
  ```

### Enviar Mensagem a um Chat Existente

- **Método:** POST
- **Endpoint:** `/chats/{chat_id}/messages`
- **Corpo JSON:**
  ```json
  {
    "text": "Sua mensagem para o chat"
  }
  ```
- **Retorno 200:**
  ```json
  {
    "message": "Mensagem enviada com sucesso",
    "data": {
      "object": "MessageSent",
      "message_id": "id da mensagem"
    }
  }
  ```

## Testes

Para rodar os testes, use o comando:

```sh
bundle exec rspec
```

## Rodar a api

Para rodar a api, use o comando:

```sh
rails server
```
