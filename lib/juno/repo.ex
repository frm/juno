defmodule Juno.Repo do
  use Ecto.Repo,
    otp_app: :juno,
    adapter: Ecto.Adapters.Postgres
end
