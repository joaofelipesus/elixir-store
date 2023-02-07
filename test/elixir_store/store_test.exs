defmodule ElixirStore.StoreTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store
  alias Ecto.Changeset

  describe "changeset/1" do
    test "return a valid changeset, when params are valid" do
      params = %{name: "games-store", segment: :games}
      result = Store.changeset(params)

      assert %Changeset{
               changes: %{name: "games-store", segment: :games},
               data: %Store{},
               errors: [],
               valid?: true
             } = result
    end

    test "return an invalid changeset, when params are invalid" do
      params = %{segment: :games}
      result = Store.changeset(params)

      assert %Changeset{
               changes: %{segment: :games},
               data: %Store{},
               valid?: false,
               errors: [name: {"can't be blank", [validation: :required]}]
             } = result
    end
  end

  describe "changeset/2" do
    test "return a valid changeset, when params are valid" do
      {:ok, store} = ElixirStore.create_store(%{name: "nerv", segment: :sports})
      params = %{name: "games-store", segment: :games}
      result = Store.changeset(store, params)

      assert %Changeset{
               changes: %{name: "games-store", segment: :games},
               data: %Store{},
               errors: [],
               valid?: true
             } = result
    end

    test "return an invalid changeset, when params are invalid" do
      {:ok, store} = ElixirStore.create_store(%{name: "nerv", segment: :sports})
      params = %{name: nil, segment: :games}
      result = Store.changeset(store, params)

      assert %Changeset{
               changes: %{segment: :games},
               data: %Store{},
               valid?: false,
               errors: [name: {"can't be blank", [validation: :required]}]
             } = result
    end
  end

  describe "name uniqueness" do
    test "creates new store, when received name is unused" do
      result =
        %{name: "games-store", segment: :games}
        |> Store.changeset()
        |> Repo.insert()

      assert {
               :ok,
               %ElixirStore.Store{
                 id: _id,
                 inserted_at: _inserted_at,
                 name: "games-store",
                 segment: :games,
                 updated_at: _updated_at
               }
             } = result
    end

    test "returns error message, when name is already in use" do
      %{name: "games-store", segment: :games}
      |> Store.changeset()
      |> Repo.insert()

      {:error, result} =
        %{name: "games-store", segment: :games}
        |> Store.changeset()
        |> Repo.insert()

      assert %Changeset{
        errors: [
          name:
            {"has already been taken",
             [constraint: :unique, constraint_name: "stores_unique_name_index"]}
        ],
        valid?: false,
        data: %Store{}
      }

      error_messages = errors_on(result)

      assert error_messages == %{name: ["has already been taken"]}
    end
  end
end
