defmodule Judge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JudgeWeb.Telemetry,
      # Start the Ecto repository
      Judge.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Judge.PubSub},
      # Start Finch
      {Finch, name: Judge.Finch},
      # Start the Endpoint (http/https)
      JudgeWeb.Endpoint
      # Start a worker by calling: Judge.Worker.start_link(arg)
      # {Judge.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Judge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JudgeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
