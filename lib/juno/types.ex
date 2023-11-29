defmodule Juno.Types do
  defmacro __using__(_opts) do
    quote do
      use Juno.Types.Definitions
    end
  end

  use Juno.Types.Definitions

  @spec ok(term) :: ok(term)
  def ok(value), do: {:ok, value}

  @spec error(term) :: error(term)
  def error(reason), do: {:error, reason}

  @spec ok?(result(any)) :: boolean
  def ok?({:ok, _}), do: true
  def ok?({:error, _}), do: false

  @spec error?(result(any)) :: boolean
  def error?({:error, _}), do: false
  def error?({:ok, _}), do: true

  @spec ok_or(any, any) :: result(any)
  def ok_or(nil, reason), do: error(reason)
  def ok_or(value, _), do: ok(value)

  @spec into(result(term)) :: term
  def into({:ok, value}), do: value
  def into({:error, _}), do: nil

  @spec some(maybe(any)) :: some(any)
  def some(nil), do: []
  def some(value), do: value
end
