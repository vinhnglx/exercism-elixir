defmodule KitoServerTest do
  use ExUnit.Case, async: true # configure this specific test case to able to run in parallel with other test cases

  test "CRUD kito" do
    {:ok, pid} = Kito.Server.start
    Kito.Server.add(pid, %{site: "twitter", username: "johndoe", password: "123456"})
    assert Kito.Server.get(pid, :site, "twitter") == [%{site: "twitter", username: "johndoe", password: "123456", id: 1}]

    Kito.Server.update(pid, 1, :site, "facebook")
    assert Kito.Server.get(pid, :site, "twitter") == []
    assert Kito.Server.get(pid, :site, "facebook") |> length == 1

    Kito.Server.delete(pid, 1)
    assert Kito.Server.get(pid, :site, "facebook") |> length == 0
  end
end
