defmodule ElixirStore.Store.UpdateTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store.Update
  alias ElixirStore.Store

  describe "call/1" do
    test "returns error message, when uuid is invalid" do
      params = %{id: "1", name: "nerv", segment: :games}
      {:error, %{message: error_message, status: :bad_request}} = Update.call(params)

      assert error_message === "Invalid UUID"
    end

    test "returns error message, when store does not exist" do
      params = %{id: "a9d5a65d-3b77-4622-869f-7a8b5ca9947c", name: "nerv", segment: :games}
      {:error, %{message: error_message, status: :not_found}} = Update.call(params)

      assert "Store not found" == error_message
    end

    test "updates store, when params are valid" do
      {:ok, %Store{id: store_id}} = ElixirStore.create_store(%{name: "nerv", segment: :games})

      params = %{id: store_id, name: "nike store", segment: :sports}
      {:ok, store} = Update.call(params)

      assert %Store{
        id: _id,
        name: "nike store",
        segment: :sports
      } = store
    end
  end
end
