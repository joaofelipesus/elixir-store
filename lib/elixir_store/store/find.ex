defmodule ElixirStore.Store.Find do
  alias ElixirStore.{Store, Repo}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, %{message: "Invalid UUID", status: :bad_request}}
      {:ok, uuid} -> get_store(uuid)
    end
  end

  defp get_store(uuid) do
    case Repo.get(Store, uuid) do
      nil -> {:error, %{message: "Store not found", status: :not_found}}
      store -> {:ok, store}
    end
  end
end
