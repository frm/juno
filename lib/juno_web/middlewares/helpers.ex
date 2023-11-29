defmodule JunoWeb.Middlewares.Helpers do
  @moduledoc """
  Helper module for middleware functions
  """

  use Juno.Types.Definitions

  alias Juno.Accounts.User

  @typep args :: map
  @typep resolution :: Absinthe.Resolution.t()
  @typep resource :: some(struct)
  @typep user :: User.t()

  @spec resource(resolution) :: maybe(resource)
  def resource(resolution), do: resolution.context[:resource]

  @spec current_user(resolution) :: maybe(user)
  def current_user(resolution), do: resolution.context[:current_user]

  @spec arguments(resolution) :: maybe(args)
  def arguments(resolution), do: resolution.arguments
end
