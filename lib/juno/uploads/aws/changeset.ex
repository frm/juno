defmodule Juno.Uploads.AWS.Changeset do
  import Ecto.Changeset

  alias Juno.Uploads.AWS

  def validate_origin(changeset, field) do
    validate_allowed_origin(
      changeset,
      field,
      s3_uncompiled_regex()
    )
  end

  defp validate_allowed_origin(changeset, field, origin) do
    validate_change(changeset, field, fn
      ^field, nil ->
        changeset

      ^field, url ->
        if valid_origin?(url, origin) do
          []
        else
          [{field, "invalid url"}]
        end
    end)
  end

  defp valid_origin?(url, origin) when is_binary(url) do
    origin
    |> Regex.compile!()
    |> Regex.match?(url)
  end

  defp valid_origin?(urls, origin) when is_list(urls) do
    Enum.all?(urls, &valid_origin?(&1, origin))
  end

  defp valid_origin?(_, _), do: false

  defp s3_uncompiled_regex do
    base_url = AWS.s3_base_url() |> Regex.escape()

    "^#{base_url}/.+"
  end
end
