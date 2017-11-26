defmodule Storage.AgentTest do
  use Storage.CleanCase
  doctest Storage.Agent

  test "add_cafe", %{storage_name: storage_name} do
    # First cafe is added to the empty list of cafes
    cafe_to_be_added = %{
      name: "Café Aroma",
      americano_price: 4_00,
    }

    assert Storage.Agent.add_cafe(cafe_to_be_added) == :ok
    assert Agent.get(storage_name, fn state -> state end) == %{cafes: [cafe_to_be_added]}

    # Second cafe is added to the beginning of the list of cafes
    second_cafe_to_be_added = %{
      name: "Café Commissary",
      americano_price: 3_00,
    }

    assert Storage.Agent.add_cafe(second_cafe_to_be_added) == :ok
    assert Agent.get(storage_name, fn state -> state end) == %{cafes: [second_cafe_to_be_added, cafe_to_be_added]}
  end

  test "list_cafes", %{storage_name: storage_name} do
    assert Storage.Agent.list_cafes == []

    Agent.update(storage_name, fn(_state)->
      %{cafes: [%{name: "Café Commissary", americano_price: 3_00}]}
    end)

    assert Storage.Agent.list_cafes == [%{name: "Café Commissary", americano_price: 3_00}]
  end
end
