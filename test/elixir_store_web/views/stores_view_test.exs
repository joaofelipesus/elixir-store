defmodule ElixirStoreWeb.StoresViewTest do
  use ElixirStoreWeb, :view
  use ElixirStoreWeb.ConnCase

  describe "render(show.json, %{store:store})" do
    test "returns a hash with id, name and segment" do
      {:ok, store} =
      %{name: "nerv-store", segment: :games}
      |> ElixirStore.create_store()

      result = render(ElixirStoreWeb.StoresView, "show.json", %{store: store})

      assert %{
        id: _id,
        name: "nerv-store",
        segment: :games
      } = result
    end
  end
end
