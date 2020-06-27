# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :aux_api,
  ecto_repos: [AuxApi.Repo]

# Configures the endpoint
config :aux_api, AuxApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e2+tUvzzIxSZ5s6ImQl3QcNINXfqiCwv5EmO4Hc12YAPKHAF8EqoZytags6F5a1Z",
  render_errors: [view: AuxApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuxApi.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "3CVRIDMn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
import_config "secret.exs"
import_config "spotify.exs"
