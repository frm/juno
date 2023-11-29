defmodule Juno.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :username, :citext, null: false
      add :email, :string, null: false
      add :avatar_url, :text
      add :oauth_provider, :string
      add :oauth_provider_uid, :string

      add :deleted_at, :utc_datetime_usec

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
    create unique_index(:users, [:oauth_provider_uid, :oauth_provider])
  end
end
