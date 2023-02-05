defmodule ElixirStoreWeb.StoresController do
  use ElixirStoreWeb, :controller

  action_fallback ElixirStoreWeb.FallbackController

  def create(conn, %{"name" => name, "segment" => segment}) do
    %{name: name, segment: segment}
    |> ElixirStore.create_store()
    |> handle_response(conn)
  end

  defp handle_response({:ok, store}, conn) do
    conn
    |> put_status(:created)
    |> render("create.json", %{store: store})
  end

  defp handle_response({:error, _error} = error, _conn), do: error
end
