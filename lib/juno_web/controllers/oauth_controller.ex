defmodule JunoWeb.OAuthController do
  @moduledoc false

  use JunoWeb, :controller
  plug Ueberauth

  alias Juno.Accounts.Services.CreateUserFromOAuth
  alias JunoWeb.Auth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    with {:ok, user} <- CreateUserFromOAuth.perform(auth),
         {:ok, token, _} <- Auth.encode_and_sign(user) do
      json(conn, %{token: token})
    end
  end
end
