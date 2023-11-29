defmodule Juno.AccountsTest do
  use Juno.DataCase, async: true

  alias Juno.Accounts

  describe "get_user_by/1" do
    test "returns the user with the given params" do
      user = insert(:user)

      {:ok, found_user} = Accounts.get_user_by(email: user.email)

      assert user.id == found_user.id
    end

    test "returns a :not_found error if no user is found" do
      {:error, :not_found} = Accounts.get_user_by(email: "")
    end
  end

  describe "create_or_update_user/1" do
    test "creates a user if none exists" do
      params = params_for(:user)

      assert {:ok, _} = Accounts.create_or_update_user(params)
    end

    test "updates a user if one with the given email already exists" do
      user = insert(:user)
      params = params_for(:user, email: user.email)

      assert {:ok, updated_user} = Accounts.create_or_update_user(params)

      assert updated_user.id == user.id
      assert updated_user.inserted_at == user.inserted_at
      assert updated_user.email == user.email
      refute updated_user.updated_at == user.updated_at
      assert updated_user.name == params.name
      assert updated_user.username == params.username
      assert updated_user.email == params.email
      assert updated_user.avatar_url == params.avatar_url
      assert updated_user.oauth_provider == params.oauth_provider
      assert updated_user.oauth_provider_uid == params.oauth_provider_uid
    end

    test "when creating a user errors with invalid parameters" do
      params = params_for(:user, name: nil)

      assert {:error, changeset} = Accounts.create_or_update_user(params)

      assert [name: _] = changeset.errors
    end

    test "when updating a user errors with invalid parameters" do
      user = insert(:user)
      params = params_for(:user, email: user.email, name: nil)

      assert {:error, changeset} = Accounts.create_or_update_user(params)

      assert [name: _] = changeset.errors
    end
  end
end
