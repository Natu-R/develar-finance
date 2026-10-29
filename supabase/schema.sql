-- Cobros y Servidores · esquema de Supabase
-- Correlo una sola vez en Supabase → SQL Editor → New query → Run.

create table if not exists public.registros (
  owner       uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  collection  text        not null check (collection in ('clientes','cargos','pagos','servidores','config')),
  id          text        not null,
  data        jsonb       not null default '{}'::jsonb,
  updated_at  timestamptz not null default now(),
  primary key (owner, collection, id)
);

-- Cada usuario ve y modifica solo sus propios registros.
alter table public.registros enable row level security;

drop policy if exists "leer propios"       on public.registros;
drop policy if exists "crear propios"      on public.registros;
drop policy if exists "modificar propios"  on public.registros;
drop policy if exists "borrar propios"     on public.registros;

create policy "leer propios"      on public.registros for select to authenticated using (owner = auth.uid());
create policy "crear propios"     on public.registros for insert to authenticated with check (owner = auth.uid());
create policy "modificar propios" on public.registros for update to authenticated using (owner = auth.uid()) with check (owner = auth.uid());
create policy "borrar propios"    on public.registros for delete to authenticated using (owner = auth.uid());

-- Nadie sin sesión puede tocar la tabla.
revoke all on public.registros from anon;
grant select, insert, update, delete on public.registros to authenticated;

-- Cambios en vivo (si tenés la app abierta en dos dispositivos, se actualizan solos).
alter table public.registros replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.registros;
exception when duplicate_object then null; end $$;
