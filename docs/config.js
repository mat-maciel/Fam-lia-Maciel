// -----------------------------------------------------------------------------
// Configuração do Supabase para o Rateio da Festa.
//
// Estes vêm de:  Project Settings -> API  (Project URL e a chave de cliente,
// a "publishable key" / antiga "anon public").
//
// Essa chave é PÚBLICA por definição (roda no navegador de todos), então pode
// ficar aqui no repositório com segurança. Quem protege a EDIÇÃO dos dados é o
// RLS + a função festa_save (que confere a senha do admin no servidor — veja
// docs/schema.sql e docs/SETUP.md). Nunca coloque aqui a "secret key".
//
// VIEWER_PW é só a trava de tela do papel "Visualizador" (leitura). A senha do
// ADMINISTRADOR NÃO fica aqui — ela mora no banco (tabela app_config).
// -----------------------------------------------------------------------------
window.CAIXA_CONFIG = {
  SUPABASE_URL: "https://ckwbggslmqhozidahroe.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_rKkOeexP5m72NFqnBmxnlw_lUagnchu",
  VIEWER_PW: "maciel"
};
