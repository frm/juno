defmodule Juno.Ecto.Schema do
  defmacro __using__(_opts) do
    quote location: :keep do
      use Ecto.Schema

      import Ecto.Changeset

      alias __MODULE__

      @primary_key {:id, Juno.Ecto.Snowflake, autogenerate: true}
      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
