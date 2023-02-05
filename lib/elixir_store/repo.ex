defmodule ElixirStore.Repo do
  use Ecto.Repo,
    otp_app: :elixir_store,
    adapter: Ecto.Adapters.Postgres
end
