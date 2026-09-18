-- Mon Équipe Handball — Supabase
create extension if not exists pgcrypto;

create table if not exists public.players (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  positions text[] not null default '{}',
  laterality text not null default '',
  jersey_number text not null default '',
  public_note text not null default '',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.players enable row level security;

revoke all on table public.players from anon, authenticated;
grant select on table public.players to anon, authenticated;
grant insert, update, delete on table public.players to authenticated;

drop policy if exists "public can read players" on public.players;
create policy "public can read players"
on public.players for select
to anon, authenticated
using (true);

drop policy if exists "authenticated can insert players" on public.players;
create policy "authenticated can insert players"
on public.players for insert
to authenticated
with check (true);

drop policy if exists "authenticated can update players" on public.players;
create policy "authenticated can update players"
on public.players for update
to authenticated
using (true)
with check (true);

drop policy if exists "authenticated can delete players" on public.players;
create policy "authenticated can delete players"
on public.players for delete
to authenticated
using (true);

insert into public.players (name, positions, laterality, jersey_number, public_note, active)
values
  ('Hugo J.', array[]::text[], '', '', '', true),
  ('Landry R.', array[]::text[], '', '', '', true),
  ('Kevin B.', array[]::text[], '', '', '', true),
  ('Arthur C.', array[]::text[], '', '', '', true),
  ('PAD', array[]::text[], '', '', '', true),
  ('Cedric P.', array[]::text[], '', '', '', true),
  ('Ovic', array[]::text[], '', '', '', true),
  ('Antho C.', array[]::text[], '', '', '', true),
  ('Eddy C.', array[]::text[], '', '', '', true),
  ('Erwan N.', array[]::text[], '', '', '', true),
  ('Nico C.', array[]::text[], '', '', '', true),
  ('Adrien J.', array[]::text[], '', '', '', true),
  ('Micka G.', array[]::text[], '', '', '', true),
  ('Arnaud V.', array[]::text[], '', '', '', true),
  ('Joffrey B.', array[]::text[], '', '', '', true),
  ('Christo G.', array[]::text[], '', '', '', true),
  ('Arthur M.', array[]::text[], '', '', '', true),
  ('Peter D.', array[]::text[], '', '', '', true),
  ('Loup G.', array[]::text[], '', '', '', true)
on conflict (name) do nothing;
