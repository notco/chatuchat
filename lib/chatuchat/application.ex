defmodule Chatuchat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatuchatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chatuchat.PubSub},
      # Start the Endpoint (http/https)
      ChatuchatWeb.Endpoint
      # Start a worker by calling: Chatuchat.Worker.start_link(arg)
      # {Chatuchat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chatuchat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatuchatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
