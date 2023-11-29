defmodule Juno.Accounts do
  alias Juno.Accounts.User
  alias Juno.Repo

  import Juno.Storage

  def get_user(id) do
    get_user_by(id: id)
  end

  def get_user_by(params \\ []) do
    User
    |> Repo.get_by(params)
    |> standardize()
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_or_update_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert(
      on_conflict: {:replace_all_except, [:id, :inserted_at]},
      conflict_target: [:email],
      returning: true
    )
  end
end
