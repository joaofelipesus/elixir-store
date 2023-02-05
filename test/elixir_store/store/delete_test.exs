defmodule ElixirStore.Store.DeleteTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store.Delete
  alias ElixirStore.{Store, Repo}

  describe "call/1" do
    test "returns an error message when received UUID is invalid" do
      {:error, %{message: error_message, status: :bad_request}} = Delete.call("1")

      assert error_message === "Invalid UUID"
    end

    test "returns not found message, when received id don't belong to any store" do
      fake_uuid = "a9d5a65d-3b77-4622-869f-7a8b5ca9947c"
      {:error, %{message: error_message, status: :not_found}} = Delete.call(fake_uuid)

      assert "Store not found" == error_message
    end

    test "deletes store when received an store uuid" do
      params = %{name: "nerv", segment: :games}
      {:ok, store} = ElixirStore.create_store(params)

      before_count = Repo.aggregate(Store, :count)

      {:ok, _store} = Delete.call(store.id)

      after_count = Repo.aggregate(Store, :count)

      assert before_count > after_count
    end
  end
end
