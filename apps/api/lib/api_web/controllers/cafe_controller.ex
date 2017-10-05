defmodule ApiWeb.CafeController do
  use ApiWeb, :controller

  def index(conn, _params) do
    cafes = Core.list_cafes()
    render(conn, "index.json", cafes: cafes)
  end
end
