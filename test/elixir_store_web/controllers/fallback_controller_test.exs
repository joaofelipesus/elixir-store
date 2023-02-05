defmodule ElixirStoreWeb.FallbackControllerTest do
  alias ElixirStoreWeb.FallbackController
  use ElixirStoreWeb.ConnCase

  describe "call(conn, {:error, %{message: message, status: :not_found}})" do
    test "renders 404.json with message", %{conn: conn} do
      result = FallbackController.call(
        conn,
        {:error, %{message: "Store not found", status: :not_found}}
      )

      assert %Plug.Conn{
        status: 404,
        resp_body: "{\"errors\":\"Store not found\"}"
      } = result
    end
  end
end
