# Mainô Blog

aplicação web que permite aos usuários criar, compartilhar e interagir com postagens sobre diversos tópicos. Com funcionalidades de cadastro de usuário, login seguro, recuperação de senha e gerenciamento de perfil, os usuários podem criar e personalizar sua experiência na aplicação. Eles podem criar postagens, comentar em postagens de outros usuários e filtrar postagens por tags, tornando o processo de descoberta e compartilhamento de conteúdo mais fácil e intuitivo. Com autenticação JWT para garantir a segurança dos usuários e integração com o PostgreSQL como banco de dados.

## Funcionalidades

1. **Cadastro de Usuário:**
   - Endpoint: `POST /api/v1/customers`
   - Descrição: Permite que novos usuários se cadastrem no aplicativo.
2. **Login de Usuário:**
   - Endpoint: `POST /api/v1/session/login`
   - Descrição: Permite que os usuários façam login no aplicativo.
3. **Logout de Usuário:**
   - Endpoint: `POST /api/v1/session/logout`
   - Descrição: Permite que os usuários façam logout do aplicativo.
4. **Recuperação de Senha:**
   - Reset de Senha:
     - Endpoint: `POST /api/v1/password/reset`
     - Descrição: Permite que os usuários solicitem a redefinição da senha.
   - Edição de Senha:
     - Endpoint: `PATCH /api/v1/password/reset/edit`
     - Descrição: Permite que os usuários redefinam a senha após receberem o link de redefinição por e-mail.
   - Atualização de Senha:
     - Endpoint: `PATCH /api/v1/password/update`
     - Descrição: Permite que os usuários atualizem suas senhas.
5. **Perfil do Usuário:**
   - Endpoint: `GET /api/v1/profile`
   - Descrição: Permite que os usuários visualizem e atualizem suas informações de perfil.
6. **Gerenciamento de Posts:**
   - Criação de Posts:
     - Endpoint: `POST /api/v1/posts`
     - Descrição: Permite que os usuários criem novos posts.
   - Listagem de Posts:
     - Endpoint: `GET /api/v1/posts`
     - Descrição: Permite que os usuários visualizem todos os posts.
   - Detalhes do Post:
     - Endpoint: `GET /api/v1/posts/:id`
     - Descrição: Permite que os usuários visualizem os detalhes de um post específico.
   - Atualização de Posts:
     - Endpoint: `PUT /api/v1/posts/:id`
     - Descrição: Permite que os usuários atualizem seus próprios posts.
   - Remoção de Posts:
     - Endpoint: `DELETE /api/v1/posts/:id`
     - Descrição: Permite que os usuários removam seus próprios posts.
   - Filtragem de Posts por Tags:
     - Endpoint: [Endpoint a ser definido]
7. **Comentários em Posts:**
   - Criação de Comentários:
     - Endpoint: `POST /api/v1/comments/:id`
     - Descrição: Permite que os usuários adicionem comentários a um post específico.

## Autenticação JWT

Este aplicativo utiliza JSON Web Tokens (JWT) para autenticação de usuários. O token JWT é enviado no cabeçalho da solicitação HTTP. Para que a autenticação funcione corretamente, é necessário habilitar o envio de credenciais tanto no frontend quanto no backend.

