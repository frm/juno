defmodule JunoWeb.Schemas.Accounts do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:string)
    field :name, non_null(:string)
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :avatar_url, :string

    import_fields :timestamps
  end
end
