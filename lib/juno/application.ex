defmodule Juno.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JunoWeb.Telemetry,
      Juno.Repo,
      {Phoenix.PubSub, name: Juno.PubSub},
      JunoWeb.Endpoint,
      {Guardian.DB.Sweeper, guardian_db_sweeper_config()}
    ]

    opts = [strategy: :one_for_one, name: Juno.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    JunoWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp guardian_db_sweeper_config do
    Application.get_env(:guardian, Guardian.DB.Sweeper)
  end
end
