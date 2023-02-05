defmodule ElixirStoreWeb.StoresControllerTest do
  use ElixirStoreWeb.ConnCase

  describe "create/2" do
    test "creates a store and returns it, when params are valid", %{conn: conn} do
      params = %{"name" => "nerv store", "segment" => "games"}
      response =
        conn
        |> post(Routes.stores_path(conn, :create, params))
        |> json_response(:created)

      assert %{
        "id" => _id,
        "name" => "nerv store",
        "segment" => "games"
      } = response
    end

    test "returns error message, when params are invalid", %{conn: conn} do
      params = %{"name" => nil, "segment" => "games"}
      response =
        conn
        |> post(Routes.stores_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"errors" => %{"name" => ["can't be blank"]}} == response
    end
  end
end
