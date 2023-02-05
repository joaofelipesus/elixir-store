defmodule ElixirStoreWeb.StoresView do
  use ElixirStoreWeb, :view

  def render("index.json", %{stores: stores}) do
    Enum.map(stores, fn store ->
      %{
        id: store.id,
        name: store.name,
        segment: store.segment
      }
    end)
  end

  def render("show.json", %{store: store}) do
    %{
      id: store.id,
      name: store.name,
      segment: store.segment
    }
  end
end
