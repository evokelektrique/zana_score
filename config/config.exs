# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zana_score,
  ecto_repos: [ZanaScore.Repo]

# Configures the endpoint
config :zana_score, ZanaScoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gpKFRc+1WgDCd9DtncU1+7fBiUrAiX2+rjqAdjsnyZgZyzU5szJo9i9C0ZZ8TeYE",
  render_errors: [view: ZanaScoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ZanaScore.PubSub,
  live_view: [signing_salt: "H4DCkcwB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
