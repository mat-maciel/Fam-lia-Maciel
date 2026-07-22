-- =============================================================================
-- Rateio da Festa · Família Maciel — esquema do Supabase (v2, com papéis)
-- Rode ESTE script inteiro no  SQL Editor  do seu projeto Supabase.
--
-- Modelo de segurança:
--   • LEITURA  é aberta (qualquer um com a chave pública + código lê). A senha
--     do "Visualizador" é só uma trava de tela no app (config.js).
--   • ESCRITA  só acontece pela função festa_save(), que confere a senha do
--     ADMINISTRADOR no servidor. Escrita direta na tabela é bloqueada por RLS.
--     A senha do admin fica na tabela privada app_config (NÃO no código).
-- =============================================================================

-- 1) Tabela das festas (um registro por festa; estado inteiro em JSON).
create table if not exists public.festas (
  code       text primary key,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.festas enable row level security;

-- Leitura aberta; NENHUMA policy de escrita (anon não escreve direto na tabela).
drop policy if exists "festas_select" on public.festas;
create policy "festas_select" on public.festas for select using (true);
drop policy if exists "festas_insert" on public.festas;
drop policy if exists "festas_update" on public.festas;

-- 2) Config privada: guarda a senha do admin. RLS ligada e SEM policies →
--    o papel anon não consegue ler nem escrever aqui. Só as funções
--    security definer (abaixo) enxergam.
create table if not exists public.app_config (
  key   text primary key,
  value text not null
);
alter table public.app_config enable row level security;

-- Cria a linha da senha com um PLACEHOLDER. Depois de rodar este script,
-- rode UMA vez (não comitado em lugar nenhum):
--     update public.app_config set value = 'SUA_SENHA_ADMIN' where key = 'admin_pw';
insert into public.app_config(key, value)
values ('admin_pw', 'DEFINA_A_SENHA_ADMIN')
on conflict (key) do nothing;

-- 3) Escrita protegida: confere a senha do admin no servidor e faz o upsert.
create or replace function public.festa_save(p_code text, p_data jsonb, p_password text)
returns timestamptz
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pw text;
  v_ts timestamptz;
begin
  select value into v_pw from public.app_config where key = 'admin_pw';
  if p_password is null or v_pw is null or p_password <> v_pw then
    raise exception 'senha_invalida';
  end if;
  insert into public.festas (code, data, updated_at)
  values (p_code, p_data, now())
  on conflict (code) do update set data = excluded.data, updated_at = now()
  returning updated_at into v_ts;
  return v_ts;
end;
$$;

-- 4) Checagem da senha do admin (para a tela de login).
create or replace function public.festa_check_admin(p_password text)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (select 1 from public.app_config where key = 'admin_pw' and value = p_password);
$$;

-- Permissões: só as funções são chamáveis pelo cliente (papel anon).
revoke all on function public.festa_save(text, jsonb, text) from public;
revoke all on function public.festa_check_admin(text) from public;
grant execute on function public.festa_save(text, jsonb, text) to anon, authenticated;
grant execute on function public.festa_check_admin(text) to anon, authenticated;

-- 5) Realtime: todos veem as mudanças ao vivo. Idempotente — só adiciona a
--    tabela à publicação se ela ainda não estiver lá (evita o erro 42710).
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'festas'
  ) then
    alter publication supabase_realtime add table public.festas;
  end if;
end $$;

-- =============================================================================
-- DEPOIS de rodar tudo acima, defina a senha do admin (escolha a SUA — e não
-- comite essa senha em nenhum arquivo do repositório):
--     update public.app_config set value = 'SUA_SENHA_ADMIN' where key = 'admin_pw';
-- =============================================================================
