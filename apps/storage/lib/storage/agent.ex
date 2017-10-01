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

  @spec add_cafe(map, atom) :: :ok
  def add_cafe(cafe_to_be_added, name \\ __MODULE__) do
    Agent.update(name, &Map.put(&1, :cafes, [cafe_to_be_added | &1.cafes]))
  end
end
