# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_store,
  ecto_repos: [ElixirStore.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :elixir_store, ElixirStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "92yAWbfp1403P5SepD0Ftw+7uDoq91HC7P3QmPi3Z/WFhBlvBBOqdNxaPmhJ1odz",
  render_errors: [view: ElixirStoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ElixirStore.PubSub,
  live_view: [signing_salt: "m9At9dOa"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
