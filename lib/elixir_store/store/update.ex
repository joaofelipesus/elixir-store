defmodule ElixirStore.Store.Update do
  alias ElixirStore.{Repo, Store}
  alias Ecto.UUID

  def call(%{id: id, name: _name, segment: _segment} = params) do
    case UUID.cast(id) do
      :error -> {:error, %{message: "Invalid UUID", status: :bad_request}}
      {:ok, uuid} ->
        fetch_store(uuid)
        |> update_store(params)
    end
  end

  defp fetch_store(uuid) do
    case Repo.get(Store, uuid) do
      nil -> {:error, %{message: "Store not found", status: :not_found}}
      store -> {:ok, store}
    end
  end

  defp update_store({:error, _error} = error, _params), do: error

  defp update_store({:ok, store}, params) do
    Store.changeset(store, params)
    |> Repo.update()
  end
end
