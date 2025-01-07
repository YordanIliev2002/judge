defmodule Judge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JudgeWeb.Telemetry,
      Judge.Repo,
      {Phoenix.PubSub, name: Judge.PubSub},
      {Finch, name: Judge.Finch},
      JudgeWeb.Endpoint,
      Judge.SubmissionEvaluatedListener,
      Judge.Rabbit
      # Start a worker by calling: Judge.Worker.start_link(arg)
      # {Judge.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Judge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    JudgeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
