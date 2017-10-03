defmodule Core do
  @moduledoc """
  Documentation for Core.
  """

  @doc """
  Add a cafe.

  ## Examples

      iex> Core.add_cafe(%{name: "Café Aroma", americano_price: 4_00})
      :ok

  """

  defdelegate add_cafe(cafe_to_be_added), to: Storage

  @doc """
  List cafes.

  ## Examples

      iex> Core.list_cafes
      []
  """

  defdelegate list_cafes, to: Storage
end
