defmodule Juno.Config do
  @otp_app :juno

  @spec os_env(String.t()) :: String.t() | nil
  def os_env(name) do
    System.get_env(name)
  end

  @spec os_env!(String.t()) :: String.t() | no_return
  def os_env!(name) do
    case os_env(name) do
      nil -> raise "os env #{name} not set!"
      value -> value
    end
  end

  @spec config(atom(), atom(), any()) :: any()
  def config(key, param, default \\ nil) do
    Application.get_env(@otp_app, key, [])
    |> Keyword.get(param, default)
    |> parse_config_value()
  end

  @spec config!(atom(), atom()) :: any() | no_return
  def config!(mod, key) do
    Application.get_env(@otp_app, mod)
    |> parse_app_env!(key)
  end

  defp parse_config_value({:system, var}), do: os_env(var)

  defp parse_config_value({:system, var, condition, truthy, falsey}),
    do: if(os_env(var) == condition, do: truthy, else: falsey)

  defp parse_config_value({m, f, a}), do: apply(m, f, a)
  defp parse_config_value(value), do: value

  defp parse_app_env!(nil, key), do: raise("#{key} not set!")

  defp parse_app_env!(args, key) do
    case Keyword.get(args, key) do
      nil ->
        raise "#{key} not set!"

      {:system, var} ->
        os_env!(var)

      {:system, var, condition, truthy, falsey} ->
        if os_env!(var) == condition,
          do: truthy,
          else: falsey

      value ->
        value
    end
  end
end
