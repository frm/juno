defmodule Juno.Errors.DSL do
  alias Juno.Types

  defmacro __using__(_) do
    quote do
      require Juno.Errors.DSL
      import Juno.Errors.DSL
    end
  end

  defmacro deferror(name) do
    quote do
      def unquote(name)(), do: Types.error(unquote(name))
    end
  end
end
