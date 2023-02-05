defmodule ElixirStoreWeb.FallbackController do
  use ElixirStoreWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ElixirStoreWeb.ErrorView)
    |> render("400.json", %{result: result})
  end
end
