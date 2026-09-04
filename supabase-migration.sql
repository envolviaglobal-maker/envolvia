-- Panel de Envolvia: chat con Gran Sabio + lista de tareas que Gran Sabio va
-- completando. Correr esto en el SQL Editor del proyecto Supabase NUEVO de
-- Envolvia (creado con envolvia.global@gmail.com) una vez que exista.

create table if not exists public.envolvia_mensajes (
  id bigint generated always as identity primary key,
  role text not null check (role in ('user', 'gransabio')),
  text text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.envolvia_tareas (
  id bigint generated always as identity primary key,
  texto text not null,
  estado text not null default 'pendiente' check (estado in ('pendiente', 'en_progreso', 'hecho')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.envolvia_mensajes enable row level security;
alter table public.envolvia_tareas enable row level security;

drop policy if exists "envolvia_mensajes_all_anon" on public.envolvia_mensajes;
create policy "envolvia_mensajes_all_anon"
  on public.envolvia_mensajes for all
  to anon, authenticated
  using (true) with check (true);

drop policy if exists "envolvia_tareas_all_anon" on public.envolvia_tareas;
create policy "envolvia_tareas_all_anon"
  on public.envolvia_tareas for all
  to anon, authenticated
  using (true) with check (true);
