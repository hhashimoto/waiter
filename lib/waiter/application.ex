defmodule Waiter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Waiter.Router, options: [port: 8080])
      # Starts a worker by calling: Waiter.Worker.start_link(arg)
      # {Waiter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Waiter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
