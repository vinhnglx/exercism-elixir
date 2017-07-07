defmodule KitoDatabaseTest do
  use ExUnit.Case

  setup do
    Kito.Database.start("./test_data")
    on_exit(fn ->
      File.rm_rf("./test_data")
      send(:database_server, :stop)
    end)
  end

  test "get and store" do
    assert Kito.Database.get(1) == nil

    Kito.Database.store(1, %{site: "somesite"})
    Kito.Database.store(2, %{name: "something"})

    assert Kito.Database.get(1) == %{site: "somesite"}
    assert Kito.Database.get(2) == %{name: "something"}
  end
end
