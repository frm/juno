defmodule Juno.MixProject do
  use Mix.Project

  @env Mix.env()

  def project do
    [
      app: :juno,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      preferred_cli_env: [
        "test.prepare": :test
      ]
    ]
  end

  def application do
    [
      mod: {Juno.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:absinthe, "~> 1.7"},
      {:absinthe_plug, "~> 1.5"},
      {:ecto_sql, "~> 3.10"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:guardian, "~> 2.3"},
      {:guardian_db, "~> 3.0"},
      {:hackney, "~> 1.9"},
      {:jason, "~> 1.2"},
      {:mime, "~> 2.0"},
      {:phoenix, "~> 1.7.7"},
      {:phoenix_ecto, "~> 4.4"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:snowflake, github: "frm/snowflake", tag: "1.1.1"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:ueberauth_google, "~> 0.10"}
      | deps(@env)
    ]
  end

  defp deps(env) when env in ~w(test dev)a do
    [
      {:credo, "~> 1.6", runtime: false},
      {:ex_machina, "~> 2.7.0"},
      {:mimic, "~> 1.7", only: :test},
      {:faker, "~> 0.17"}
    ]
  end

  defp deps(:prod), do: []

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "test.prepare": ["ecto.drop", "ecto.create", "ecto.migrate"]
    ]
  end
end
