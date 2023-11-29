defmodule Juno.Uploads do
  use Juno.Types

  alias Juno.Uploads.Services.CreatePresignedURL

  @spec create_presigned_url(binary, binary) :: result(map, any)
  defdelegate create_presigned_url(file_name, file_size),
    to: CreatePresignedURL,
    as: :perform
end
