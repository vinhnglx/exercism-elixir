defmodule KitoTest do
  use ExUnit.Case
  doctest Kito

  test "starts a new kito process" do
    {:ok, pid} = Kito.start
    assert is_pid(pid) == true
  end

  test "put a new key value to kito" do
    {:ok, pid} = Kito.start
    assert Kito.put(pid, :first_name, "vincent") == :ok
  end

  test "get a existing value from a key" do
    {:ok, pid} = Kito.start
    Kito.put(pid, :first_name, "vincent")
    assert Kito.get(pid, :first_name) == "vincent"
  end
end
