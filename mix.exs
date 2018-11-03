defmodule PhoenixCrud.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_crud,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixCrud.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0-rc"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0-rc"},
      {:postgrex, ">= 0.0.0-rc"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2-rc", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:distillery, ">= 2.0.0-rc.8"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"],
      compile: ["compile", &compile_assets/1],
      clean: ["clean", &clean_assets/1]
    ]
  end

  defp compile_assets(_args) do
    assets_dir = Path.join([Application.app_dir(:phoenix_crud, "priv"), "..", "assets"])
    static_dir = Path.join(Application.app_dir(:phoenix_crud, "priv"), "static")
    File.mkdir_p!(Path.join(static_dir, "js"))
    File.mkdir_p!(Path.join(static_dir, "css"))
    for item <- ["js", "css", "static"] do
      File.cp_r!(Path.join(assets_dir, item), Path.join(static_dir, item))
    end
  end

  defp clean_assets(_args) do
    static_dir = Path.join(Application.app_dir(:phoenix_crud, "priv"), "static")
    for item <- ["js", "css", "static"] do
      File.rm_rf!(Path.join(static_dir, item))
    end
  end
end
