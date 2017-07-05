defmodule KitoTest do
  use ExUnit.Case
  doctest Kito

  test "starts a new kito process" do
    assert is_pid(Kito.start) == true
  end

  test "put a new key value to kito" do
    pid = Kito.start
    assert Kito.put(pid, :first_name, "vincent") == :ok
  end

  test "get a existing value from a key" do
    pid = Kito.start
    Kito.put(pid, :first_name, "vincent")
    assert Kito.get(pid, :first_name) == "vincent"
  end
end
