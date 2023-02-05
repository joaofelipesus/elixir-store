defmodule ElixirStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirStore.Repo,
      # Start the Telemetry supervisor
      ElixirStoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirStore.PubSub},
      # Start the Endpoint (http/https)
      ElixirStoreWeb.Endpoint
      # Start a worker by calling: ElixirStore.Worker.start_link(arg)
      # {ElixirStore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
