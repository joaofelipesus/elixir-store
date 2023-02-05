defmodule ElixirStore.Store.Delete do
  alias ElixirStore.{Repo, Store}

  def call(id) do
    case Ecto.UUID.cast(id) do
      :error -> {:error, %{message: "Invalid UUID", status: :bad_request}}
      {:ok, uuid} ->
        fetch_store(uuid)
        |> delete_store()
    end
  end

  defp fetch_store(uuid) do
    case Repo.get(Store, uuid) do
      nil -> {:error, %{message: "Store not found", status: :not_found}}
      store -> {:ok, store}
    end
  end


  defp delete_store({:error, _error} = error), do: error
  defp delete_store({:ok, store}), do: Repo.delete(store)
end
