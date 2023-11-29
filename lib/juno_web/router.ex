defmodule JunoWeb.Router do
  use JunoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    get "/auth/:provider", JunoWeb.OAuthController, :request
    get "/auth/:provider/callback", JunoWeb.OAuthController, :callback

    get "/healthcheck", JunoWeb.HealthcheckController, :index

    forward "/i", Absinthe.Plug.GraphiQL,
      schema: JunoWeb.Schema,
      interface: :playground

    forward "/", Absinthe.Plug, schema: JunoWeb.Schema
  end
end
