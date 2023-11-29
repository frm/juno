defmodule Juno.Accounts.Services.CreateUserFromOAuth do
  alias Juno.Accounts
  alias Juno.Accounts.User.Username
  alias Juno.Errors

  def perform(%Ueberauth.Auth{} = auth) do
    parse_auth(auth)
    |> Accounts.create_or_update_user()
  end

  def perform(_), do: Errors.bad_request()

  defp parse_auth(%{uid: uid, info: info, provider: provider}) do
    name = build_name_from_oauth(info)
    username = Username.unique_from(name)

    %{
      oauth_provider: provider,
      oauth_provider_uid: uid,
      email: info.email,
      avatar_url: info.image,
      name: name,
      username: username
    }
  end

  defp build_name_from_oauth(%{first_name: first_name, last_name: last_name}) do
    "#{first_name} #{last_name}"
  end
end
