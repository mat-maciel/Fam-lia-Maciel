# Caixa da Festa · Família Maciel — como colocar no ar

App estilo Splitwise para gerir o **caixa** e o **rateio** da festa, com dados
**sincronizados ao vivo** entre todos que abrem o site. Frontend estático
(GitHub Pages) + banco de dados na nuvem (Supabase). Tudo no plano gratuito.

Você faz isto **uma vez**. Depois é só usar.

---

## 1. Criar o banco no Supabase (~5 min)

1. Crie uma conta grátis em [supabase.com](https://supabase.com) e um **New project**
   (guarde a senha do banco; você não vai precisar dela no app).
2. Aguarde o projeto terminar de provisionar.
3. Menu **SQL Editor** → **New query** → cole o conteúdo de
   [`docs/schema.sql`](./schema.sql) → **Run**.
4. Menu **Project Settings → API** e copie dois valores:
   - **Project URL** (algo como `https://abcd1234.supabase.co`)
   - a chave **anon public** (uma string longa começando com `eyJ...`)

## 2. Ligar o app ao banco

Abra [`docs/config.js`](./config.js) e cole os dois valores:

```js
window.CAIXA_CONFIG = {
  SUPABASE_URL: "https://abcd1234.supabase.co",
  SUPABASE_ANON_KEY: "eyJ...sua-chave-anon..."
};
```

Faça commit. A chave `anon` é pública por definição (roda no navegador), então
pode ficar no repositório. **Nunca** coloque a chave `service_role` aqui.

## 3. Publicar no GitHub Pages (~2 min)

No GitHub: **Settings → Pages → Build and deployment**:

- **Source:** *Deploy from a branch*
- **Branch:** escolha a branch e a pasta **`/docs`** → **Save**

Em ~1 minuto o site fica no ar em algo como
`https://<seu-usuario>.github.io/Fam-lia-Maciel/`.

> Dica: dá pra apontar o Pages direto para a branch `claude/session-4s6c8t`
> `/docs` para testar; ou faça o merge para `main` e aponte para `main` `/docs`.

## 4. Usar

1. Abra o site. Clique em **Criar nova festa** (gera um código tipo
   `maciel-7f3a9c`) ou digite um código existente.
2. Compartilhe **o link + o código** com a família (botão de copiar ao lado do
   código). Todos que entrarem com o mesmo código veem e editam o mesmo caixa,
   **ao vivo**.

---

## Como funciona / decisões

- **Um registro por festa.** O estado inteiro é salvo como JSON na linha da
  festa. As gravações são *debounced* e a sincronização é ao vivo via Realtime.
  Para uma família (poucas pessoas, edições esporádicas) o modelo
  *último-a-salvar-vence* é adequado; edições exatamente simultâneas de duas
  pessoas em segundos podem sobrescrever uma à outra — o app mostra "Atualizado
  por outra pessoa" quando recebe mudanças remotas.
- **Acesso pelo código da festa.** Qualquer pessoa com o código acessa aquela
  festa. É "segredo por obscuridade" — bom o suficiente para um caixa de
  família de baixo risco. Use códigos longos e não os publique.
- **Backup local.** Cada navegador guarda um cache da última festa (funciona
  offline em modo leitura) e há **Backup / Importar** JSON no app.

## Quer mais segurança? (opcional)

Para restringir de verdade quem acessa, troque o modelo de código por
**Supabase Auth** (login por e-mail/link mágico) e ajuste as policies de RLS
para `auth.uid()`. Posso implementar isso quando quiser.
