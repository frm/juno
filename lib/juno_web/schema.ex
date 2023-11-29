defmodule JunoWeb.Schema do
  use Absinthe.Schema

  alias JunoWeb.Absinthe.Types
  alias JunoWeb.Queries
  alias JunoWeb.Schemas

  #
  # Custom Macros
  #

  require Types.EctoEnum

  #
  # Custom Types
  #

  import_types Absinthe.Type.Custom
  import_types Types.Timestamps

  #
  # Schemas
  #

  import_types Schemas.Accounts

  #
  # Queries
  #

  import_types Queries.Accounts

  query do
    import_fields :accounts_queries
  end
end
