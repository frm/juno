defmodule Juno.Mock do
  import Juno.Mock.DSL

  # List of modules that are mocked by our app and used in test_helper.exs
  @deps [
    ExAws.S3
  ]

  def copy do
    for dep <- @deps do
      Mimic.copy(dep)
    end
  end

  def s3(overrides \\ []) do
    defaults = [
      presigned_url: fn _, _, _, _, _ -> {:ok, Faker.Internet.url()} end
    ]

    mock_functions(ExAws.S3, defaults, overrides)
  end
end
