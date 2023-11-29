defmodule JunoWeb.Absinthe.Types.EctoEnum do
  defmacro ecto_enum(name, module) when is_atom(name) do
    name = Macro.expand(name, __CALLER__)
    module = Macro.expand(module, __CALLER__)
    values = Ecto.Enum.values(module, name)

    quote do
      enum(unquote(name), values: unquote(values))
    end
  end
end
