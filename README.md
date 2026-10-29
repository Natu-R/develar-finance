# Cobros y Servidores

Panel para llevar las cuotas, comisiones, pagos, deudas y servidores de cada cliente.
Es un sitio estático (un `index.html`) que guarda los datos en Supabase y se publica en Vercel.

```
index.html            la app
api/config.js         entrega la URL y la clave pública de Supabase desde las variables de entorno
vercel.json           configuración de Vercel
supabase/schema.sql   crea la tabla y las reglas de acceso
supabase/datos.sql    tus clientes y servidores actuales (NO está en el repo: va aparte, porque el repo es público)
```

## 1. Supabase (5 minutos)

1. Creá un proyecto en [supabase.com](https://supabase.com) (el plan gratis alcanza).
2. **SQL Editor → New query**: pegá el contenido de `supabase/schema.sql` y tocá **Run**.
3. **Authentication → Users → Add user → Create new user**: poné tu email y una contraseña. Marcá *Auto Confirm User*.
4. **Authentication → Sign In / Providers → Email**: desactivá **Allow new users to sign up**, así nadie más puede crearse una cuenta.
5. Abrí `supabase/datos.sql` (te lo pasaron aparte), cambiá `TU-EMAIL@ejemplo.com` por el email del paso 3, pegalo en el SQL Editor y tocá **Run**. Con eso pasan tus 9 clientes y 18 servidores.
6. **Project Settings → API**: copiá la *Project URL* y la clave *anon public*.
7. En Vercel → **Project → Settings → Environment Variables** cargalas como `SUPABASE_URL` y `SUPABASE_ANON_KEY`, y volvé a desplegar.

## 2. Vercel

Con la terminal, desde esta carpeta:

```bash
npm i -g vercel
vercel          # la primera vez te pide iniciar sesión y crea el proyecto
vercel --prod
```

O sin terminal: subí la carpeta a un repo de GitHub y en Vercel elegí **Add New → Project → Import**.
No hace falta configurar build: *Framework Preset* "Other", sin comando de build.

## 3. Dominio propio

En Vercel: **Project → Settings → Domains → Add**, escribí por ejemplo `admin.tudominio.com`.
Vercel te muestra el registro a crear en tu proveedor de DNS (normalmente un `CNAME` hacia `cname.vercel-dns.com`).
En unos minutos el certificado HTTPS queda listo solo.

## Notas

- Si te olvidás la contraseña, cambiala desde Supabase → Authentication → Users.
- Cada usuario ve solo sus propios datos. Si querés que otra persona vea los mismos datos, hay que cambiar las reglas de `schema.sql`.
- Para hacer un respaldo: Supabase → Table Editor → `registros` → Export to CSV.
