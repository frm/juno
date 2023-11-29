defmodule Juno.Ecto.EmbeddedSchema do
  defmacro __using__(_) do
    quote location: :keep do
      use Juno.Ecto.Schema, primary_key: false, derive: false

      @primary_key false
      @derive Jason.Encoder
    end
  end
end
