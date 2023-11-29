defmodule JunoWeb.Resolvers.Accounts do
  alias Juno.Accounts

  def user(_parent, %{username: username}, _info) do
    Accounts.get_user_by(username: username)
  end
end
