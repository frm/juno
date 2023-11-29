defmodule Juno.Uploads.AWS.ChangesetTest do
  use ExUnit.Case, async: true

  alias Juno.Uploads.AWS
  alias Juno.Uploads.Upload

  @valid_url "https://juno-test.s3.eu-central-1.amazonaws.com/valid_url"

  describe "validate_origin/2" do
    test "bypasses the changeset for valid urls" do
      changeset =
        Ecto.Changeset.change(%Upload{}, %{url: @valid_url})

      assert changeset == AWS.Changeset.validate_origin(changeset, :url)
    end

    test "errors for unknown urls" do
      url = Faker.Internet.url()
      changeset = Ecto.Changeset.change(%Upload{}, %{url: url})

      changeset_with_errors = AWS.Changeset.validate_origin(changeset, :url)

      assert [url: _] = changeset_with_errors.errors
    end

    test "errors for non-urls" do
      not_a_url = "c'est ci n'est pas une url"
      changeset = Ecto.Changeset.change(%Upload{}, %{url: not_a_url})

      changeset_with_errors = AWS.Changeset.validate_origin(changeset, :url)

      assert [url: _] = changeset_with_errors.errors
    end
  end
end
