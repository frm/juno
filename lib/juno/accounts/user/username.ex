defmodule Juno.Accounts.User.Username do
  import Ecto.Query

  alias Juno.Accounts.User
  alias Juno.Repo

  # Allowed alphabet is Base64URL
  @alphabet "a-zA-Z0-9\\-_"
  @allowed_format ~r/^[#{@alphabet}]+$/

  def valid?(username) do
    String.match?(username, @allowed_format)
  end

  def unique_from(name) do
    name
    |> convert_name()
    |> ensure_unique_suffix()
  end

  defp convert_name(name) do
    name
    |> String.downcase()
    |> String.replace(~r/[^#{@alphabet}]/, "")
  end

  defp ensure_unique_suffix(username) do
    if Repo.exists?(User, username: username) do
      username
      |> suggest_suffix()
      |> ensure_uniqueness()
    else
      username
    end
  end

  defp suggest_suffix(username) do
    ilike = "#{username}%"

    nr_similar_usernames =
      from(u in User, where: ilike(u.username, ^ilike))
      |> Repo.aggregate(:count)

    "#{username}#{nr_similar_usernames}"
  end

  defp ensure_uniqueness(username) do
    User
    |> Repo.get_by(username: username)
    |> case do
      nil -> username
      _ -> unique_from(username)
    end
  end
end
