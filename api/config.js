// Entrega la configuración pública de Supabase desde las variables de entorno de Vercel.
// La clave anon es pública por diseño; los datos los protegen el login y las reglas de supabase/schema.sql.
module.exports = (req, res) => {
  const cfg = {
    supabaseUrl: process.env.SUPABASE_URL || "",
    supabaseAnonKey: process.env.SUPABASE_ANON_KEY || "",
  };
  res.setHeader("Content-Type", "application/javascript; charset=utf-8");
  res.setHeader("Cache-Control", "no-store");
  res.end(`window.APP_CONFIG = ${JSON.stringify(cfg)};`);
};
