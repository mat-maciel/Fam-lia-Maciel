# Fam-lia-Maciel

**Caixa da Festa · Família Maciel** — um app estilo Splitwise para gerir o
**caixa (vaquinha)** e o **rateio** da festa da família, com dados
**sincronizados ao vivo** entre todos que abrem o site.

- 🧾 Registre **contribuições** (quem colocou quanto na vaquinha) e **despesas**
  (valor, categoria, quem pagou — o caixa ou uma pessoa — e entre quem dividir).
- 💰 Veja o **saldo do caixa**, progresso até a **meta** e totais.
- ⚖️ **Acerto de contas**: o saldo de cada um e a sugestão de acertos com o
  menor número de transferências (o próprio caixa entra na conta, então sobra
  da vaquinha volta para quem contribuiu além da sua parte).
- 🔄 Tudo compartilhado via **Supabase**; hospedado grátis no **GitHub Pages**.

## Rodar / publicar

O app é um site estático em [`docs/`](./docs). Para colocar no ar (fazer uma vez):

**👉 Siga o passo a passo em [`docs/SETUP.md`](./docs/SETUP.md).**

Resumo: crie um projeto grátis no Supabase e rode
[`docs/schema.sql`](./docs/schema.sql); cole a URL + chave `anon` em
[`docs/config.js`](./docs/config.js); ative o GitHub Pages apontando para a
pasta `/docs`.

## Estrutura

| Arquivo | O quê |
|---|---|
| `docs/index.html` | O app inteiro (HTML + CSS + JS, sem build). |
| `docs/config.js` | Onde vão a URL e a chave pública do seu Supabase. |
| `docs/schema.sql` | Tabela + regras de acesso (RLS) + realtime. |
| `docs/SETUP.md` | Passo a passo de publicação. |
