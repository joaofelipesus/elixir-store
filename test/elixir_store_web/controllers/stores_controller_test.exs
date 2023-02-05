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

  describe "show/2" do
    test "shows a store and returns it, when params are valid", %{conn: conn} do
      {:ok, store} = ElixirStore.create_store(%{"name" => "nerv store", "segment" => "games"})
      response =
        conn
        |> get(Routes.stores_path(conn, :show, store.id))
        |> json_response(:ok)

      assert %{
        "id" => _id,
        "name" => "nerv store",
        "segment" => "games"
      } = response
    end

    test "returns an error, when received id don't belong to a store", %{conn: conn} do
      store_id = "a9d5a65d-3b77-4622-869f-7a8b5ca9947c"

      response =
        conn
        |> get(Routes.stores_path(conn, :show, store_id))
        |> json_response(:not_found)

      assert %{"errors" => "Store not found"} == response
    end
  end
end
