defmodule Juno.Storage do
  alias Juno.Types

  def standardize(result), do: Types.ok_or(result, :not_found)
end
