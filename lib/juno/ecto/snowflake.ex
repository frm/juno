defmodule Juno.Ecto.Snowflake do
  use Ecto.Type

  def type, do: :integer

  def cast(value), do: convert(value)

  def load(value), do: convert(value)

  def dump(value), do: convert(value)

  def autogenerate do
    # We want it to crash if snowflake can't generate an ID
    {:ok, id} = Snowflake.next_id()

    id
  end

  defp convert(value) when is_integer(value), do: {:ok, value}

  defp convert(value) when is_binary(value) do
    {:ok, String.to_integer(value)}
  rescue
    _e in ArgumentError ->
      {:error, value}
  end
end
