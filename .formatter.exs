[
  import_deps: [:ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}", "priv/*/seeds.exs"],
  line_length: 80,
  locals_without_parens: [
    # elixir
    defmodule: :*,
    defstruct: :*,
    send: :*,
    spawn: :*,

    # ecto
    add: :*,
    belongs_to: :*,
    create: :*,
    drop: :*,
    embeds_many: :*,
    embeds_one: :*,
    execute: :*,
    field: :*,
    has_many: :*,
    has_one: :*,
    many_to_many: :*,
    remove: :*,
    rename: :*,
    schema: :*,
    polymorphic_embeds_one: :*,

    # phoenix/plug
    action_fallback: :*,
    adapter: :*,
    delete: :*,
    forward: :*,
    get: :*,
    patch: :*,
    pipe_through: :*,
    pipeline: :*,
    plug: :*,
    post: :*,
    put: :*,
    resources: :*,
    scope: :*,
    socket: :*,
    live_dashboard: :*,

    # graphql
    arg: :*,
    config: :*,
    enum: :*,
    import_fields: :*,
    import_types: :*,
    meta: :*,
    middleware: :*,
    resolve: :*,
    resolve_type: :*,
    resolve_with: :*,
    trigger: :*,
    types: :*,
    value: :*,
    deprecate: :*,

    # custom DSL
    deferror: :*
  ]
]
