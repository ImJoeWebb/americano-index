defmodule Storage do
  @moduledoc """
  Documentation for Storage.
  """

  defdelegate add_cafe(cafe_to_be_added), to: Storage.Agent
  defdelegate add_cafe(cafe_to_be_added, storage_name), to: Storage.Agent
end
