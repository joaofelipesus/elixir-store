defmodule ElixirStore.Store.CreateTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store.Create

  describe "call/1" do
    test "creates a new store, when params are valid" do
      {:ok, result} =
        %{name: "games-store", segment: :games}
        |> Create.call()

      assert %ElixirStore.Store{
               id: _id,
               inserted_at: _inserted_at,
               name: "games-store",
               segment: :games,
               updated_at: _updated_at
             } = result
    end

    test "returns an error and a changeset, when params has errors" do
      Create.call(%{name: "games-store", segment: :games})

      {:error, result} =
        %{name: "games-store", segment: :games}
        |> Create.call()

      assert %Ecto.Changeset{
               valid?: false
             } = result

      error_messages = errors_on(result)

      assert error_messages == %{name: ["has already been taken"]}
    end
  end
end
