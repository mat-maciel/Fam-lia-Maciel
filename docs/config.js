// -----------------------------------------------------------------------------
// Configuração do Supabase para o Caixa da Festa.
//
// Preencha os dois valores abaixo com os dados do SEU projeto Supabase:
//   Project Settings  ->  API  ->  "Project URL" e a chave "anon public".
//
// A chave "anon" é PÚBLICA por definição (roda no navegador de todos), então
// pode ficar aqui no repositório com segurança. Quem protege os dados é o
// RLS + o código da festa (veja docs/schema.sql e docs/SETUP.md).
// Nunca coloque aqui a chave "service_role".
// -----------------------------------------------------------------------------
window.CAIXA_CONFIG = {
  SUPABASE_URL: "https://ckwbggslmqhozidahroe.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_rKkOeexP5m72NFqnBmxnlw_lUagnchu"
};
