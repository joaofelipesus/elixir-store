defmodule ElixirStoreWeb.StoresController do
  use ElixirStoreWeb, :controller

  action_fallback ElixirStoreWeb.FallbackController

  def index(conn, _params) do
    stores = ElixirStore.list_store()
    conn
    |> put_status(:ok)
    |> render("index.json", %{stores: stores})
  end

  def create(conn, %{"name" => name, "segment" => segment}) do
    %{name: name, segment: segment}
    |> ElixirStore.create_store()
    |> handle_response(conn, :created, "show.json")
  end

  def show(conn, %{"id" => id}) do
    ElixirStore.find_store(id)
    |> handle_response(conn, :ok, "show.json")
  end

  defp handle_response({:error, _error} = error, _conn, _status, _view), do: error

  defp handle_response({:ok, store}, conn, status, view) do
    conn
    |> put_status(status)
    |> render(view, %{store: store})
  end
end
