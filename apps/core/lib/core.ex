defmodule Core do
  @moduledoc """
  Documentation for Core.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Core.add_cafe(%{name: "Café Aroma", americano_price: 4_00})
      :ok

  """

  defdelegate add_cafe(cafe_to_be_added), to: Storage
end
