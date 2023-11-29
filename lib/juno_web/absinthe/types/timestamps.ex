defmodule JunoWeb.Absinthe.Types.Timestamps do
  use Absinthe.Schema.Notation

  object :timestamps do
    field :deleted_at, :datetime
    field :inserted_at, non_null(:datetime)
    field :updated_at, non_null(:datetime)
  end
end
