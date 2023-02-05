defmodule ElixirStore.Store.FindTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store.Find

  describe "call/1" do
    test "returns an error message when received UUID is invalid" do
      {:error, %{message: error_message, status: :bad_request}} = Find.call("1")

      assert error_message === "Invalid UUID"
    end

    test "returns not found message, when received id don't belong to any store" do
      fake_uuid = "a9d5a65d-3b77-4622-869f-7a8b5ca9947c"
      {:error, %{message: error_message, status: :not_found}} = Find.call(fake_uuid)

      assert "Store not found" == error_message
    end

    test "returns store when received an store uuid" do
      params = %{name: "nerv", segment: :games}
      {:ok, store} = ElixirStore.create_store(params)

      {:ok, result} = Find.call(store.id)

      assert %ElixirStore.Store{
        id: _id,
        inserted_at: _inserted_at,
        name: "nerv",
        segment: :games,
        updated_at: _updated_at
      } = result
    end
  end
end
