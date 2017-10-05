defmodule ApiWeb.CafeView do
  use ApiWeb, :view
  alias ApiWeb.CafeView

  def render("index.json", %{cafes: cafes}) do
    %{data: render_many(cafes, CafeView, "cafe.json")}
  end


  def render("cafe.json", %{cafe: cafe}) do
    %{name: cafe.name,
      americano_price: cafe.americano_price}
  end
end
