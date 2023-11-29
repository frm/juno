defmodule Juno.Types.Definitions do
  @moduledoc """
  Extended and generic type definitions to be used across the app.
  """

  defmacro __using__(_) do
    quote do
      @type ok() :: {:ok, any}
      @type ok(t) :: {:ok, t}

      @type error() :: {:error, any}
      @type error(t) :: {:error, t}

      @type result() :: ok() | error()
      @type result(t) :: ok(t) | error()
      @type result(t, r) :: ok(t) | error(r)

      @type maybe(t) :: t | nil

      @type some(t) :: t | [t]
    end
  end
end
