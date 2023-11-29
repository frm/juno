defmodule Juno.Accounts.Services.CreateUserFromOauthTest do
  use Juno.DataCase, async: true

  alias Juno.Accounts.Services.CreateUserFromOAuth

  describe "perform/1" do
    test "correctly builds the user name" do
      info = build(:ueberauth_auth_info, first_name: "John", last_name: "Doe")
      auth = build(:ueberauth_auth, info: info)

      {:ok, user} = CreateUserFromOAuth.perform(auth)

      assert user.name == "John Doe"
    end

    test "correctly builds the username" do
      info = build(:ueberauth_auth_info, first_name: "John", last_name: "Doe")
      auth = build(:ueberauth_auth, info: info)

      {:ok, user} = CreateUserFromOAuth.perform(auth)

      assert user.username == "johndoe"
    end

    test "saves the correct info" do
      auth = build(:ueberauth_auth)

      {:ok, user} = CreateUserFromOAuth.perform(auth)

      assert user.oauth_provider == :google
      assert user.oauth_provider_uid == auth.uid
      assert user.email == auth.info.email
      assert user.avatar_url == auth.info.image
      assert user.username
    end
  end
end
