defmodule JunoWeb.Middlewares.Resolve do
  @moduledoc """
  This middleware is used to resolve a field with the following functions:
  - 3-arity function: with the args `(resource, args, current_user)`
  - 2-arity function: with the args `(args, current_user)`
  - 1-arity function: with the arg `args`
  - 0-arity function.
  - `:identity`: returns the resource as is.
  """
  @behaviour Absinthe.Middleware

  alias JunoWeb.Middlewares.Helpers

  def call(%{state: :resolved} = resolution, _), do: resolution

  def call(resolution, fun) when is_function(fun, 3) do
    fun.(
      Helpers.resource(resolution),
      Helpers.arguments(resolution),
      Helpers.current_user(resolution)
    )
    |> put_result(resolution)
  end

  def call(resolution, fun) when is_function(fun, 2) do
    fun.(
      Helpers.arguments(resolution),
      Helpers.current_user(resolution)
    )
    |> put_result(resolution)
  end

  def call(resolution, fun) when is_function(fun, 1) do
    fun.(Helpers.arguments(resolution))
    |> put_result(resolution)
  end

  def call(resolution, fun) when is_function(fun, 0) do
    fun.()
    |> put_result(resolution)
  end

  def call(resolution, term) when not is_function(term) do
    call(resolution, :self)
  end

  def call(resolution, :self) do
    Helpers.resource(resolution)
    |> put_result(resolution)
  end

  defp put_result(result, resolution) do
    Absinthe.Resolution.put_result(resolution, result)
  end
end
