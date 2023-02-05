defmodule ElixirStore.Store.Find do
  alias ElixirStore.{Store, Repo}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, "Invalid UUID"}
      {:ok, uuid} -> get_store(uuid)
    end
  end

  defp get_store(uuid) do
    case Repo.get(Store, uuid) do
      nil -> {:error, "Store not found"}
      store -> {:ok, store}
    end
  end
end
