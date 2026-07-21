# Rateio da Festa · Família Maciel — como colocar no ar

App para dividir os custos da festa (multi-dia) entre as subfamílias, com dados
**sincronizados ao vivo** e **dois papéis**: **administrador** (edita) e
**visualizador** (só acompanha). Frontend estático (GitHub Pages) + banco na
nuvem (Supabase). Tudo no plano gratuito.

Você faz isto **uma vez**. Depois é só usar.

---

## 1. Criar o banco no Supabase (~5 min)

1. Crie uma conta grátis em [supabase.com](https://supabase.com) e um **New project**.
2. Aguarde o projeto provisionar.
3. Menu **SQL Editor** → **New query** → cole o conteúdo de
   [`docs/schema.sql`](./schema.sql) → **Run**. Isso cria a tabela `festas`, a
   tabela privada `app_config`, as funções `festa_save`/`festa_check_admin` e as
   regras de acesso (RLS) — escrita só passa pela função que confere a senha do
   admin.
4. **Defina a senha do administrador** (ela fica só no banco, nunca no código).
   Ainda no SQL Editor, rode:

   ```sql
   update public.app_config set value = 'compactador' where key = 'admin_pw';
   ```

5. Menu **Project Settings → API** e copie:
   - **Project URL** (ex.: `https://abcd1234.supabase.co`)
   - a chave **anon/publishable** (`sb_publishable_...` ou `eyJ...`)

## 2. Ligar o app ao banco

Abra [`docs/config.js`](./config.js) e preencha:

```js
window.CAIXA_CONFIG = {
  SUPABASE_URL: "https://abcd1234.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_...",
  VIEWER_PW: "maciel"   // senha do papel Visualizador (trava de tela)
};
```

Faça commit. A chave pública e a `VIEWER_PW` podem ficar no repositório. A senha
do **admin NÃO** vai aqui — ela está no banco (passo 1.4).

## 3. Publicar no GitHub Pages (~2 min)

**Settings → Pages → Build and deployment**:
- **Source:** *Deploy from a branch*
- **Branch:** a branch desejada + pasta **`/docs`** → **Save**

Em ~1 min o site fica em `https://<seu-usuario>.github.io/Fam-lia-Maciel/`.

## 4. Usar

Na tela inicial: **código da festa** + **papel** (Administrador/Visualizador) +
**senha**.
- **Administrador** (senha `compactador`): cria a festa (botão "Criar nova
  festa"), cadastra subfamílias, contagens por dia e despesas. Edita tudo.
- **Visualizador** (senha `maciel`): entra com o código de uma festa existente e
  **só acompanha** — a tela fica sem botões de edição.

Compartilhe **link + código + a senha do papel** com cada pessoa.

---

## Segurança — o que é garantido e o que não é

- **Edição é protegida no servidor.** Toda gravação passa pela função
  `festa_save`, que confere a senha do admin **no banco**; escrita direta na
  tabela é bloqueada por RLS. Um visualizador (ou alguém com a chave pública)
  **não consegue editar** os dados.
- **Leitura é aberta.** Qualquer pessoa com a chave pública + o código consegue
  **ler** os dados direto pela API. A senha do visualizador (`maciel`) é só uma
  trava de tela do app, não protege a leitura. Para uso familiar, tudo bem.
- **Senha do admin fraca é adivinhável.** Como a checagem é uma função pública
  (sem limite de tentativas), uma senha simples pode ser descoberta por força
  bruta. Use uma senha razoável se isso preocupar.

## Trocar as senhas depois

- **Admin:** `update public.app_config set value='NOVA' where key='admin_pw';`
- **Visualizador:** troque `VIEWER_PW` em `docs/config.js` e faça commit.
