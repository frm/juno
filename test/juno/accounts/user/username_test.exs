defmodule Juno.Accounts.User.UsernameTest do
  use Juno.DataCase, async: true

  alias Juno.Accounts.User.Username

  describe "unique_from/1" do
    test "includes the name downcased" do
      assert "foo" == Username.unique_from("FOO")
    end

    test "only keeps Base64URL characters" do
      assert "foo-" == Username.unique_from("foo!-")
    end

    test "removes spaces" do
      assert "foobar" == Username.unique_from("foo bar")
    end

    test "appends a suffix if the username is already taken" do
      insert(:user, username: "foo")

      assert "foo1" = Username.unique_from("foo")
    end

    test "attempts to guess the next available suffix" do
      insert(:user, username: "foo")
      insert(:user, username: "foo1")

      assert "foo2" = Username.unique_from("foo")
    end

    test "uses the guess as baseline when it is already taken" do
      # in this scenario, the guess will be foo2, but it is already taken
      # so the next guess should use foo2 as baseline
      insert(:user, username: "foo")
      insert(:user, username: "foo2")

      assert "foo21" = Username.unique_from("foo")
    end
  end

  describe "valid?/1" do
    test "succeeds if all characters are from Base64URL alphabet" do
      assert Username.valid?("1_foo-_123-_")
    end

    test "fails for special characters" do
      refute Username.valid?("foo!")
    end

    test "fails for space character" do
      refute Username.valid?("foo bar")
    end
  end
end
