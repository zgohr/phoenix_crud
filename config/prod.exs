use Mix.Config

config :phoenix_crud, PhoenixCrudWeb.Endpoint,
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json",
  version: Application.spec(:phoenix_crud, :vsn)

config :phoenix_crud, PhoneixCrud.Repo,
  adapter: Ecto.Adapters.Postgres

config :logger, level: :info
