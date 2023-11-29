defmodule Juno.Uploads.Services.CreatePresignedURL do
  use Juno.Types

  import Juno.Config, only: [config!: 2]

  alias Juno.Errors
  alias Juno.Uploads
  alias Juno.Uploads.AWS

  @http_method :put

  @image_extensions config!(Uploads, :image_extensions)
  @audio_extensions config!(Uploads, :audio_extensions)
  @video_extensions config!(Uploads, :video_extensions)
  @disallowed_extensions config!(Uploads, :disallowed_extensions)

  # Config is in MiB, API call is in Bytes
  @image_max_size config!(Uploads, :image_max_size) * 1024 * 1024
  @audio_max_size config!(Uploads, :audio_max_size) * 1024 * 1024
  @video_max_size config!(Uploads, :video_max_size) * 1024 * 1024
  @default_max_size config!(Uploads, :default_max_size) * 1024 * 1024

  @spec perform(binary, binary) :: result(map, any)
  def perform(file_name, file_size) do
    with true <- valid_size?(file_name, file_size),
         {:ok, file_name} <- prefix_file_name(file_name),
         {:ok, mime_type} <- infer_mime_type(file_name),
         {:ok, presigned_url} <-
           AWS.generate_presigned_url(file_name, file_size, mime_type) do
      build_upload(presigned_url, file_name, file_size, mime_type)
    else
      false -> Errors.bad_format()
      error -> error
    end
  end

  defp valid_size?(file_name, file_size) do
    case infer_file_type(file_name) do
      {:ok, type} ->
        %{
          image: @image_max_size,
          audio: @audio_max_size,
          video: @video_max_size,
          default: @default_max_size
        }[type] >= file_size

      _error ->
        false
    end
  end

  defp infer_file_type(file_name) do
    ext = Path.extname(file_name)

    cond do
      ext in @disallowed_extensions -> Errors.bad_format()
      ext in @image_extensions -> {:ok, :image}
      ext in @audio_extensions -> {:ok, :audio}
      ext in @video_extensions -> {:ok, :video}
      true -> {:ok, :default}
    end
  end

  defp infer_mime_type(file_name) do
    if Path.extname(file_name) in @disallowed_extensions do
      Errors.bad_format()
    else
      {:ok, MIME.from_path(file_name)}
    end
  end

  defp prefix_file_name(file_name) do
    case Snowflake.next_id() do
      {:ok, snowflake} -> {:ok, "#{snowflake}-#{file_name}"}
      _ -> Errors.bad_format()
    end
  end

  defp build_upload(presigned_url, file_name, file_size, mime_type) do
    upload = %{
      upload_url: presigned_url,
      name: file_name,
      file_url: AWS.s3_url(file_name),
      size: file_size,
      http_method: Atom.to_string(@http_method),
      mime_type: mime_type
    }

    {:ok, upload}
  end
end
