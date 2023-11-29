defmodule Juno.Accounts.User do
  use Juno.Ecto.Schema

  @oauth_providers ~w(google)a

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :avatar_url, :string

    field :oauth_provider, Ecto.Enum, values: @oauth_providers
    field :oauth_provider_uid, :string

    field :deleted_at, :utc_datetime_usec
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :username,
      :email,
      :avatar_url,
      :oauth_provider,
      :oauth_provider_uid
    ])
    |> validate_required([
      :name,
      :username,
      :email,
      :oauth_provider,
      :oauth_provider_uid
    ])
    |> update_change(:username, &String.downcase/1)
    |> unique_constraint(:email, downcase: true)
    |> unique_constraint(:username, downcase: true)
    |> unique_constraint([:oauth_provider_uid, :oauth_provider])
  end
end
