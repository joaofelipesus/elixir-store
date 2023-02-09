defmodule ElixirStore do
  @moduledoc """
  ElixirStore keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate create_store(params), to: ElixirStore.Store.Create, as: :call
  defdelegate find_store(params), to: ElixirStore.Store.Find, as: :call
  defdelegate list_store(), to: ElixirStore.Store.List, as: :call
  defdelegate delete_store(params), to: ElixirStore.Store.Delete, as: :call
  defdelegate update_store(params), to: ElixirStore.Store.Update, as: :call
end
