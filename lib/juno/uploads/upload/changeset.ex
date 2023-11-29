defmodule Juno.Uploads.Upload.Changeset do
  import Ecto.Changeset

  def infer_name_from_url(changeset, url_field, name_field) do
    case get_change(changeset, url_field) do
      nil ->
        changeset

      url ->
        name = Path.basename(url)
        put_change(changeset, name_field, name)
    end
  end

  def infer_mime_type_from_url(changeset, url_field, mime_type_field) do
    case get_change(changeset, url_field) do
      nil ->
        changeset

      url ->
        mime_type =
          Path.basename(url)
          |> MIME.from_path()

        put_change(changeset, mime_type_field, mime_type)
    end
  end
end
