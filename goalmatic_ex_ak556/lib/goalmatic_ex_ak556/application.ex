defmodule GoalmaticExAk556.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GoalmaticExAk556Web.Telemetry,
      # Start the Ecto repository
      GoalmaticExAk556.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: GoalmaticExAk556.PubSub},
      # Start Finch
      {Finch, name: GoalmaticExAk556.Finch},
      # Start the Endpoint (http/https)
      GoalmaticExAk556Web.Endpoint
      # Start a worker by calling: GoalmaticExAk556.Worker.start_link(arg)
      # {GoalmaticExAk556.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoalmaticExAk556.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GoalmaticExAk556Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
