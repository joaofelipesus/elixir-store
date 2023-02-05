defmodule ElixirStore.Repo.Migrations.CreateStoreTable do
  use Ecto.Migration

  def change do
    create table(:stores, primary_key: false) do
      add :id, :uuid, primary_key: true
      timestamps()
      add :name, :string
      add :segment, :string
    end

    # create constraint ztktn
    # deve ter name (para que retorne um changeset com erro)
    create unique_index(:stores, [:name], name: :stores_unique_name_index)
  end
end
