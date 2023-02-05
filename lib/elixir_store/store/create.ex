defmodule ElixirStore.Store.Create do
  alias ElixirStore.{Repo, Store}

  def call(params) do
    params
    |> Store.changeset()
    |> Repo.insert()
  end
end
