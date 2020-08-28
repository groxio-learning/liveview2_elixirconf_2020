# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rec,
  ecto_repos: [Rec.Repo]

# Configures the endpoint
config :rec, RecWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+08pPZnlr4V/SUr3oLey7/ESpRdDoN2zDFAihVgy+SiYwVvSV0CLtnj7KZmPYBMB",
  render_errors: [view: RecWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Rec.PubSub,
  live_view: [signing_salt: "MCYF2Wmr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
