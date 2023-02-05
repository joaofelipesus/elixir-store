defmodule ElixirStore.Store.List do
  import Ecto.Query
  alias ElixirStore.{Repo, Store}

  def call do
    Store
    |> order_by(asc: :name)
    |> Repo.all()
  end
end
