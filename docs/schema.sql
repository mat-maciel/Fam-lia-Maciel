-- =============================================================================
-- Caixa da Festa · Família Maciel — esquema do Supabase
-- Rode este script uma vez no  SQL Editor  do seu projeto Supabase.
-- =============================================================================

-- 1) Tabela: uma linha por festa. O estado inteiro (nome, meta, participantes,
--    lançamentos) fica num campo JSON. Simples e suficiente para uso familiar.
create table if not exists public.festas (
  code       text primary key,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2) Row Level Security: liga a proteção e define quem pode ler/escrever.
--    Modelo de acesso: "quem tem o código da festa, entra". A chave anon é
--    pública, então o segredo é o próprio código (use códigos longos, ex.
--    "maciel-7f3a9c"). É suficiente para um caixa de família de baixo risco;
--    para privacidade forte, troque por Supabase Auth (veja docs/SETUP.md).
alter table public.festas enable row level security;

drop policy if exists "festas_select" on public.festas;
create policy "festas_select" on public.festas
  for select using (true);

drop policy if exists "festas_insert" on public.festas;
create policy "festas_insert" on public.festas
  for insert with check (true);

drop policy if exists "festas_update" on public.festas;
create policy "festas_update" on public.festas
  for update using (true) with check (true);

-- (Sem policy de DELETE: ninguém apaga festas pelo app. "Limpar" apenas zera o
--  conteúdo via UPDATE.)

-- 3) Realtime: para todos verem as mudanças ao vivo, publique a tabela.
--    (Se der erro dizendo que já está na publicação, pode ignorar.)
alter publication supabase_realtime add table public.festas;
