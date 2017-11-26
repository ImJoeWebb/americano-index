defmodule CoreTest do
  use Storage.CleanCase
  doctest Core

  test "add_cafe" do
    assert :ok == Core.add_cafe(%{name: "Café Aroma", americano_price: 4_00})
  end

  test "list_cafes" do
    assert [] == Core.list_cafes
    :ok = Core.add_cafe(%{name: "Café Aroma", americano_price: 4_00})
    assert [%{name: "Café Aroma", americano_price: 4_00}] == Core.list_cafes
  end
end
