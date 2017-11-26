defmodule ApiWeb.CafeControllerTest do
  use ApiWeb.ConnCase
  use Storage.CleanCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup do
      :ok = Core.add_cafe(%{americano_price: 400, name: "Café Aroma"})
      :ok = Core.add_cafe(%{name: "Andante", americano_price: 350})
    end

    test "lists all cafes", %{conn: conn} do
      conn = get conn, cafe_path(conn, :index)
      assert json_response(conn, 200)["data"] == [
        %{"americano_price" => 350, "name" => "Andante"},
        %{"americano_price" => 400, "name" => "Café Aroma"}
      ]
    end
  end

  describe "create" do
    test "adds a cafe with valid params", %{conn: conn} do
      params = %{name: "Andante", americano_price: 350}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 201)
    end

    test "adds a cafe with invalid params", %{conn: conn} do
      # empty object
      params = %{}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"americano_price" => ["can't be blank"], "name" => ["can't be blank"]}}

      # all params nil
      params = %{name: nil, americano_price: nil}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"americano_price" => ["can't be blank"], "name" => ["can't be blank"]}}

      # nil name
      params = %{name: nil, americano_price: 350}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"name" => ["can't be blank"]}}

      # nil americano price
      params = %{name: "Andante", americano_price: nil}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"americano_price" => ["can't be blank"]}}

      # wrong type americano price
      params = %{name: "Andante", americano_price: "Andante"}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"americano_price" => ["is invalid"]}}

      # wrong type name
      params = %{name: ["Andante"], americano_price: 400}
      conn = post conn, cafe_path(conn, :create, params)
      assert json_response(conn, 422) == %{"errors" => %{"name" => ["is invalid"]}}
    end
  end
end
