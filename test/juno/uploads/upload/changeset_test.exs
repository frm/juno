defmodule Juno.Uploads.Upload.ChangesetTest do
  use ExUnit.Case, async: true

  alias Juno.Uploads.Upload

  @jpeg_url "https://juno-test.s3.eu-central-1.amazonaws.com/valid_url.jpeg"

  describe "infer_name_from_url/3" do
    test "bypasses the changeset if there is no url" do
      changeset =
        Ecto.Changeset.change(%Upload{}, %{url: nil})

      assert changeset ==
               Upload.Changeset.infer_name_from_url(changeset, :url, :name)
    end

    test "infers the name from the url" do
      changeset = Ecto.Changeset.change(%Upload{}, %{url: @jpeg_url})

      updated_changeset =
        Upload.Changeset.infer_name_from_url(changeset, :url, :name)

      assert %{name: "valid_url.jpeg"} = updated_changeset.changes
    end
  end

  describe "infer_mime_type_from_url/3" do
    test "bypasses the changeset if there is no url" do
      changeset =
        Ecto.Changeset.change(%Upload{}, %{url: nil})

      assert changeset ==
               Upload.Changeset.infer_mime_type_from_url(
                 changeset,
                 :url,
                 :mime_type
               )
    end

    test "infers the MIME type from the url" do
      changeset = Ecto.Changeset.change(%Upload{}, %{url: @jpeg_url})

      updated_changeset =
        Upload.Changeset.infer_mime_type_from_url(changeset, :url, :mime_type)

      assert %{mime_type: "image/jpeg"} = updated_changeset.changes
    end
  end
end
