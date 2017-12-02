use Mix.Config

# Configure your database
config :scubot, Scubot.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "scubot_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
