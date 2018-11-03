use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_crud, PhoenixCrudWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_crud, PhoenixCrud.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_crud_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
