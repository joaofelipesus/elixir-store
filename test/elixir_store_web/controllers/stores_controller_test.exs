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

  describe "index/2" do
    test "returns a list with stores", %{conn: conn} do
      ElixirStore.create_store(%{name: "rei", segment: :games})
      ElixirStore.create_store(%{name: "asuka", segment: :games})
      ElixirStore.create_store(%{name: "shinji", segment: :games})

      response =
        conn
        |> get(Routes.stores_path(conn, :index))
        |> json_response(:ok)

      assert [
               %{
                 "id" => _,
                 "name" => "asuka",
                 "segment" => "games"
               },
               %{
                 "id" => _,
                 "name" => "rei",
                 "segment" => "games"
               },
               %{
                 "id" => _,
                 "name" => "shinji",
                 "segment" => "games"
               }
             ] = response
    end
  end

  describe "delete/2" do
    test "delete store and return status, when params are valid", %{conn: conn} do
      {:ok, store} = ElixirStore.create_store(%{"name" => "nerv store", "segment" => "games"})

      response =
        conn
        |> delete(Routes.stores_path(conn, :show, store.id))

      assert %Plug.Conn{
               status: 200
             } = response
    end

    test "returns an error, when received id don't belong to a store", %{conn: conn} do
      store_id = "a9d5a65d-3b77-4622-869f-7a8b5ca9947c"

      response =
        conn
        |> delete(Routes.stores_path(conn, :show, store_id))
        |> json_response(:not_found)

      assert %{"errors" => "Store not found"} == response
    end
  end
end
