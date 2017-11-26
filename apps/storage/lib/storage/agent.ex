defmodule Storage.Agent do
  use Agent

  @spec start_link(list) :: {:ok, pid}
  def start_link(opts) do
    Agent.start_link(fn -> %{cafes: []} end, opts)
  end

  @spec child_spec(list) :: map
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  @spec add_cafe(map) :: :ok
  def add_cafe(cafe_to_be_added) do
    Agent.update(name(), &Map.put(&1, :cafes, [cafe_to_be_added | &1.cafes]))
  end

  @spec list_cafes :: list
  def list_cafes do
    Agent.get(name(), fn state -> state.cafes end)
  end

  @storage_name_type Application.get_env(:storage, :storage_name_type)
  defp name do
    case @storage_name_type do
      :fixed    -> __MODULE__
      :registry -> get_name_in_registry()
    end
  end

  defp get_name_in_registry do
    [{_pid, name}] = Registry.lookup(:storage_names, self())
    name
  end
end
