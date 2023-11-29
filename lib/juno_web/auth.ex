defmodule JunoWeb.Auth do
  use Guardian, otp_app: :juno

  alias Juno.Accounts
  alias Juno.Accounts.User
  alias Juno.Errors

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <-
           Guardian.DB.after_encode_and_sign(
             resource,
             claims["typ"],
             claims,
             token
           ) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end

  def subject_for_token(nil, _claims) do
    nil
  end

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user_id = claims["sub"]

    case Accounts.get_user(user_id) do
      {:ok, %User{deleted_at: nil} = user} -> {:ok, user}
      _error -> Errors.not_found()
    end
  end
end
