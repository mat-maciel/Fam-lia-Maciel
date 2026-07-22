# Fam-lia-Maciel

**Rateio da Festa · Família Maciel** — app para dividir de forma justa os custos
da festa (multi-dia) entre as **subfamílias**, com dados **sincronizados ao vivo**
entre todos que abrem o site.

Como funciona o rateio:

- 👨‍👩‍👧‍👦 Cada **subfamília** tem um responsável financeiro e informa quantos
  **adultos**, **crianças** e **bebedores de chopp** vão em **cada dia**
  (sexta / sábado / domingo).
- 📐 O custo vira **unidades de consumo**: adulto = 1; criança = um % configurável
  de um adulto (ex.: 50%); cada bebedor de chopp = 1 unidade na conta do chopp.
- 📅 Cada **despesa** é alocada por % nos dias em que foi consumida e marcada como
  **geral** ou **chopp** (o chopp é uma conta à parte).
- 🧮 O custo de cada dia é dividido pelas unidades de consumo **presentes naquele
  dia** → define quanto cada responsável **deve**.
- 💰 As **contribuições/pagamentos** ao caixa abatem o que cada um deve; o app
  mostra um único **"falta pagar / a receber"** por responsável e o **saldo do
  caixa**. (Invariante: a soma dos saldos = saldo do caixa.)
- 🔐 **Dois papéis com senha**: **administrador** (edita — senha no servidor) e
  **visualizador** (só acompanha). A edição é bloqueada no banco (RLS + função
  `festa_save`); só o admin grava.
- 🔄 Tudo compartilhado via **Supabase**; hospedado grátis no **GitHub Pages**.

## Rodar / publicar

O app é um site estático em [`docs/`](./docs). Para colocar no ar (fazer uma vez):

**👉 Siga o passo a passo em [`docs/SETUP.md`](./docs/SETUP.md).**

Resumo: crie um projeto grátis no Supabase e rode
[`docs/schema.sql`](./docs/schema.sql); cole a URL + a chave pública em
[`docs/config.js`](./docs/config.js); ative o GitHub Pages apontando para a
pasta `/docs`.

## Estrutura

| Arquivo | O quê |
|---|---|
| `docs/index.html` | O app inteiro (HTML + CSS + JS, sem build). |
| `docs/config.js` | URL + chave pública do Supabase e a senha do visualizador. |
| `docs/schema.sql` | Tabela + RLS + realtime + funções de escrita/login (senha do admin fica no banco). O estado é um JSON versionado na tabela. |
| `docs/SETUP.md` | Passo a passo de publicação. |
