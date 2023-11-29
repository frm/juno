defmodule Juno.Errors do
  use Juno.Errors.DSL

  deferror :bad_format
  deferror :bad_request
  deferror :not_found
end
