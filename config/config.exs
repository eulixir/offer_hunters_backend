# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :offer_hunters,
  ecto_repos: [OfferHunters.Repo]

# Configures the endpoint
config :offer_hunters, OfferHuntersWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Z0bUs0C/pF3q8bS65CmgQHzPmWmyioSndw/7oJ6DuCGNmAt5v4QfuzxajKPu4WPl",
  render_errors: [view: OfferHuntersWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: OfferHunters.PubSub,
  live_view: [signing_salt: "cR6id3XR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
