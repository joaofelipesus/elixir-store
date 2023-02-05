defmodule ElixirStoreWeb.StoresView do
  use ElixirStoreWeb, :view

  def render("show.json", %{store: store}) do
    %{
      id: store.id,
      name: store.name,
      segment: store.segment
    }
  end
end
