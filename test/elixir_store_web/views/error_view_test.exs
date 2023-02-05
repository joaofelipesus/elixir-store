defmodule ElixirStoreWeb.ErrorViewTest do
  use ElixirStoreWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ElixirStoreWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ElixirStoreWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end

  test "renders 400.json" do
    {:error, changeset} = ElixirStore.create_store(%{name: "some-cool-store"})
    result = render(ElixirStoreWeb.ErrorView, "400.json", result: changeset)

    assert %{errors: %{segment: ["can't be blank"]}} == result
  end
end
