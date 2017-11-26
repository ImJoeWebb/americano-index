defmodule Core do
  @moduledoc """
  Documentation for Core.
  """

  @doc """
  Add a cafe.
  """

  defdelegate add_cafe(cafe_to_be_added), to: Storage

  @doc """
  List cafes.
  """

  defdelegate list_cafes, to: Storage
end
