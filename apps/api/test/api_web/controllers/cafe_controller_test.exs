defmodule ApiWeb.CafeControllerTest do
  use ApiWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cafes", %{conn: conn} do
      conn = get conn, cafe_path(conn, :index)
      assert json_response(conn, 200)["data"] == [%{"americano_price" => 400, "name" => "Café Aroma"}]
    end
  end
end
