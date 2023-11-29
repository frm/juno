defmodule Juno.Uploads.Services.CreatePresignedURLTest do
  use Juno.DataCase, async: true

  import Juno.Config, only: [config!: 2]

  alias Juno.Mock
  alias Juno.Uploads
  alias Juno.Uploads.Services.CreatePresignedURL

  describe "perform/2" do
    test "fails if file surpasses maximum file size" do
      assert {:error, :bad_format} =
               CreatePresignedURL.perform(
                 Faker.File.file_name(),
                 1024 * 1024 * 1024
               )
    end

    test "fails when file mime_type is disallowed" do
      assert {:error, :bad_format} =
               CreatePresignedURL.perform(
                 "a.#{Enum.random(config!(Uploads, :disallowed_extensions))}",
                 1
               )
    end

    test "generates a presigned url" do
      url = Faker.Internet.url()
      file_name = Faker.File.file_name()

      Mock.s3(presigned_url: [expect: true, response: {:ok, url}])

      {:ok, %{upload_url: upload_url}} =
        CreatePresignedURL.perform(file_name, 1)

      assert upload_url == url
    end
  end
end
