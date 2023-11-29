import Config

config :juno,
  namespace: Juno,
  ecto_repos: [Juno.Repo]

config :juno, Juno.Repo,
  migration_timestamps: [type: :utc_datetime_usec]

config :juno, JunoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: JunoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Juno.PubSub,
  live_view: [signing_salt: "QFnk9g7V"]

config :juno, :aws,
  scheme: "https",
  host: "amazonaws.com"

config :juno, :s3,
  bucket: {:system, "AWS_S3_BUCKET"},
  region: "eu-central-1"

config :juno, Juno.Uploads,
  image_extensions: ~w(.jpg .jpeg .png .gif),
  # usually this would be ~w(.mp3 .m4a), but we're not allowing for now
  audio_extensions: [],
  video_extensions: ~w(.mp4 .mov),
  disallowed_extensions: ~w(.bin .exe),
  image_max_size: 50,
  audio_max_size: 50,
  video_max_size: 100,
  default_max_size: 50

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: {System, :get_env, ["GOOGLE_CLIENT_ID"]},
  client_secret: {System, :get_env, ["GOOGLE_CLIENT_SECRET"]}

config :guardian, Guardian.DB,
  repo: Juno.Repo,
  schema_name: "guardian_tokens",
  token_types: ["refresh_token"]

config :guardian, Guardian.DB.Sweeper, interval: 60 * 60 * 1000

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :ex_aws,
  region: {:system, "AWS_REGION"},
  access_key_id: {:system, "AWS_ACCESS_KEY_ID"},
  secret_access_key: {:system, "AWS_SECRET_ACCESS_KEY"}

import_config "#{config_env()}.exs"
