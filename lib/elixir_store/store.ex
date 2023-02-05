defmodule ElixirStore.Store do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "stores" do
    field :name, :string
    # exemplo de Enum
    field :segment, Ecto.Enum, values: [:games, :sports]
    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:name, :segment])
    |> validate_required([:name, :segment])
    # usar name ztktn
    |> unique_constraint(:name, name: :stores_unique_name_index)
  end
end
