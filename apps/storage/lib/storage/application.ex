defmodule Storage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      agent()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Storage.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp agent() do
    case Application.get_env(:storage, :storage_name_type) do
      :fixed -> {Storage.Agent, [name: Storage.Agent]}
      :registry -> {Registry, keys: :unique, name: :storage_names}
    end
  end
end
