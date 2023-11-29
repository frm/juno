defmodule Juno.Repo.Migrations.EnableCiText do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext", "DROP EXTENSION citext")
  end
end
