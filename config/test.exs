import Config

config :juno, Juno.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "juno_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :juno, JunoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base:
    "ZjFQF4IbZHObercBQvforALV3L6eeKfrcUiaAB7bu2a1yGnB6F2EkDFxTvyyRxQQ",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :ex_aws,
  region: "eu-west-1",
  access_key_id: "my-ex-aws-access-key-id",
  secret_access_key: "my-ex-aws-secret-access-key"

config :juno, :s3,
  bucket: "juno-test",
  region: "eu-central-1"
