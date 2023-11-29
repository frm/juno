defmodule Juno.Mock.DSL do
  import Mimic

  def mock_functions(mod, defaults, overrides) do
    Enum.map(defaults, fn {fun_name, fun} ->
      opts = Keyword.merge([function: fun], overrides[fun_name] || [])

      mock_function(mod, fun_name, opts)
    end)
  end

  defp mock_function(mod, fun, opts) do
    function_to_be_called =
      if opts[:response] do
        build_anonymous_function(opts[:function], opts[:response])
      else
        opts[:function]
      end

    cond do
      opts[:expect] -> expect(mod, fun, function_to_be_called)
      opts[:reject] -> reject(mod, fun, opts[:reject])
      true -> stub(mod, fun, function_to_be_called)
    end
  end

  defp build_anonymous_function(fun, response) do
    {:arity, arity} = Function.info(fun, :arity)

    args =
      if arity == 0,
        do: [],
        else: for(_ <- 1..arity, do: Macro.unique_var(:arg, __MODULE__))

    fn_ast =
      quote do
        fn unquote_splicing(args) -> var!(response) end
      end

    {new_fn, _} = Code.eval_quoted(fn_ast, response: response)

    new_fn
  end
end
