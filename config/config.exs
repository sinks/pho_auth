# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pho_auth,
  ecto_repos: [PhoAuth.Repo]

# Configures the endpoint
config :pho_auth, PhoAuth.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6d9ZPJIYy6PQhJRgVrBfceaLrHmyrdMmPnU+jw+hRGqZYhEEMHNxQsLvGSpSwYT5",
  render_errors: [view: PhoAuth.ErrorView, accepts: ~w(json)],
  pubsub: [name: PhoAuth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
