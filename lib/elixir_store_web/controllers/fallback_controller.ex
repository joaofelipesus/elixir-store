defmodule ElixirStoreWeb.FallbackController do
  use ElixirStoreWeb, :controller

  def call(conn, {:error, %{message: message, status: :not_found}}) do
    conn
    |> put_status(:not_found)
    |>put_view(ElixirStoreWeb.ErrorView)
    |> render("404.json", %{message: message})
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ElixirStoreWeb.ErrorView)
    |> render("400.json", %{result: result})
  end
end
