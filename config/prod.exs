use Mix.Config

config :phoenix_crud, PhoenixCrudWeb.Endpoint,
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json",
  version: Application.spec(:phoenix_crud, :vsn)

config :phoenix_crud, PhoneixCrud.Repo,
  adapter: Ecto.Adapters.Postgres

# Do not print debug messages in production
config :logger,
  level: :info,
  handle_sasl_reports: true,
  handle_otp_reports: true
