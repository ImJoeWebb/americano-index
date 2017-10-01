defmodule Storage.AgentTest do
  use ExUnit.Case
  doctest Storage.Agent

  setup do
    test_id = :rand.normal |> to_string
    storage_name = "storage_#{test_id}" |> String.to_atom
    Storage.Agent.start_link(name: storage_name)

    %{storage_name: storage_name}
  end

  test "add_cafe", %{storage_name: storage_name} do
    # First cafe is added to the empty list of cafes
    cafe_to_be_added = %{
      name: "Café Aroma",
      americano_price: 4_00,
    }

    assert Storage.Agent.add_cafe(cafe_to_be_added, storage_name) == :ok
    assert :sys.get_state(storage_name) == %{cafes: [cafe_to_be_added]}

    # Second cafe is added to the beginning of the list of cafes
    second_cafe_to_be_added = %{
      name: "Café Commissary",
      americano_price: 3_00,
    }

    assert Storage.Agent.add_cafe(second_cafe_to_be_added, storage_name) == :ok
    assert :sys.get_state(storage_name) == %{cafes: [second_cafe_to_be_added, cafe_to_be_added]}
  end
end
