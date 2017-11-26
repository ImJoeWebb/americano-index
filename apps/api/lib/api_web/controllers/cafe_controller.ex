defmodule ApiWeb.CafeController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    cafes = Core.list_cafes()
    render(conn, "index.json", cafes: cafes)
  end

  def create(conn, params) do
    with {:ok, params} <- validate_cafe(params) do
      :ok = Core.add_cafe(params)

      conn
      |> put_status(:created)
      |> render("cafe.json", cafe: params)
    end
  end

  @data %{}
  @types %{name: :string, americano_price: :integer}
  @cast_params Map.keys(@types)
  @required_params @cast_params

  def validate_cafe(params) do
    changeset =
      {@data, @types}
      |> Ecto.Changeset.cast(params, @cast_params)
      |> Ecto.Changeset.validate_required(@required_params)

    if changeset.valid? do
      {:ok, Ecto.Changeset.apply_changes(changeset)}
    else
      {:error, changeset}
    end
  end
end
