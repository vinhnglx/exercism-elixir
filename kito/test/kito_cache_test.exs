defmodule KitoCacheTest do
  use ExUnit.Case

  test "start a new process" do
    {:ok, cache_pid} = Kito.Cache.start

    working = Kito.Cache.server_process(cache_pid, "Working")
    assert is_pid(working) == true

    Kito.Server.add(working, %{site: "heroku", username: "johndoe", password: "abcd1234"})
    assert Kito.Server.get(working, :site, "heroku") |> length == 1

    socials = Kito.Cache.server_process(cache_pid, "Socials")

    assert Kito.Server.get(socials, :site, "facebook") |> length == 0
  end
end

