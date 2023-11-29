defmodule JunoWeb.Queries.Accounts do
  use Absinthe.Schema.Notation

  alias JunoWeb.Middlewares.Resolve
  alias JunoWeb.Resolvers.Accounts

  object :accounts_queries do
    field :user, non_null(:user) do
      arg :username, non_null(:string)

      middleware Resolve, &Accounts.user/3
    end
  end
end
