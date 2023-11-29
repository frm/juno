defmodule Juno.Uploads.Upload do
  @moduledoc """
  File uploads

  This schema is supposed to be embedded by others.

  `mime_type`: Type of the upload
  `name`: Name of attached upload
  `url`: Source url of the upload
  """
  use Juno.Ecto.EmbeddedSchema

  import Juno.Uploads.AWS.Changeset
  import Juno.Uploads.Upload.Changeset
  import Ecto.Changeset

  @max_url_length 150

  embedded_schema do
    field :mime_type, :string
    field :name, :string
    field :url, :string
  end

  @doc false
  def changeset(upload, attrs \\ %{}) do
    upload
    |> cast(attrs, [:url])
    |> infer_name_from_url(:name, :url)
    |> infer_mime_type_from_url(:mime_type, :url)
    |> validate_required([:mime_type, :name, :url])
    |> validate_origin(:url)
    |> validate_length(:url, max: @max_url_length)
  end
end
