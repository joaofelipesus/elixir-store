defmodule ElixirStore.Store.ListTest do
  use ElixirStore.DataCase
  alias ElixirStore.Store.List

  describe "call/0" do
    test "returns a list with all stores" do
      ElixirStore.create_store(%{name: "rei", segment: :games})
      ElixirStore.create_store(%{name: "asuka", segment: :games})
      ElixirStore.create_store(%{name: "shinji", segment: :games})

      result = List.call()
      first = Enum.at(result, 0)
      last = Enum.at(result, 2)

      assert first.name == "asuka"
      assert last.name == "shinji"
    end

    test "returns stores order by name" do
      ElixirStore.create_store(%{name: "rei", segment: :games})
      ElixirStore.create_store(%{name: "asuka", segment: :games})
      ElixirStore.create_store(%{name: "shinji", segment: :games})

      result = List.call()

      assert length(result) == 3
    end
  end
end
