defmodule PhoenixCrud.Tasks.Migrate do
  @moduledoc false

  def migrate(_args) do
    # Configure
    Mix.Releases.Config.Providers.Elixir.init(["${RELEASE_ROOT_DIR}/etc/config.exs"])
    repo_config = Application.get_env(:phoenix_crud, PhoenixCrud.Repo)
    repo_config = Keyword.put(repo_config, :adapter, Ecto.Adapters.Postgres)
    Application.put_env(:phoenix_crud, PhoenixCrud.Repo, repo_config)

    # Start requisite apps
    IO.puts "==> Starting applications.."
    for app <- [:crypto, :ssl, :postgrex, :ecto] do
      {:ok, res} = Application.ensure_all_started(app)
      IO.puts "==> Started #{app}: #{inspect res}"
    end

    # Start the repo
    IO.puts "==> Starting repo"
    {:ok, _pid} = PhoenixCrud.Repo.start_link(pool_size: 1, log: true, log_sql: true)

    # Run the migrations for the repo
    IO.puts "==> Running migrations"
    priv_dir = Application.app_dir(:phoenix_crud, "priv")
    migrations_dir = Path.join([priv_dir, "repo", "migrations"])

    opts = [all: true]
    pool = PhoenixCrud.Repo.config[:pool]
    if function_exported?(pool, :unboxed_run, 2) do
      pool.unboxed_run(PhoenixCrud.Repo, fn -> Ecto.Migrator.run(PhoenixCrud.Repo, migrations_dir, :up, opts) end)
    else
      Ecto.Migrator.run(PhoenixCrud.Repo, migrations_dir, :up, opts)
    end

    # Shut down
    :init.stop()
  end
end
