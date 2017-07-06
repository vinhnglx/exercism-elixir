defmodule KitoTypeTest do
  use ExUnit.Case

  test "empty kito" do
    kito = Kito.Type.new
    assert kito.data == %{}
    assert is_map(kito.data) == true
  end

  test "add a new kito" do
    kitos = Kito.Type.new |> Kito.Type.add(%{site: "twitter", password: "238482", username: "yeah"})
    assert Enum.map(kitos.data, fn({_, data})-> data end) == [%{id: 1, password: "238482", site: "twitter", username: "yeah"}]
  end

  test "update a kito" do
    updated_kitos = sample_kito_type() |> Kito.Type.update(1, :username, "vincent")
    assert Enum.map(updated_kitos.data, fn({_, data})-> data end) |> Enum.at(0) == %{id: 1, site: "heroku", password: "abcd1234", username: "vincent"}
  end

  test "list of kitos" do
    assert Enum.map(sample_kito_type().data, fn({_, data})-> data end) |> length == 3
  end

  test "list of kitos by site" do
    kitos = sample_kito_type() |> Kito.Type.get(:site, "facebook.com")
    assert kitos == [%{id: 3, site: "facebook.com", password: "123456", username: "yolo"}]
    assert kitos |> length == 1

    new_kitos = sample_kito_type() |> Kito.Type.add(%{site: "facebook.com", password: "888888", username: "buggy"})
    assert new_kitos |> Kito.Type.get(:site, "facebook.com") |> length == 2
  end

  test "delete a single kito" do
    kitos = sample_kito_type() |> Kito.Type.delete(2)
    assert kitos.data |> Enum.map(fn({_,v})-> v end) |> length == 2
  end

  defp sample_kito_type do
    Kito.Type.new
      |> Kito.Type.add(%{site: "heroku", password: "abcd1234", username: "hello"})
      |> Kito.Type.add(%{site: "google.com", password: "abcd12345", username: "olla"})
      |> Kito.Type.add(%{site: "facebook.com", password: "123456", username: "yolo"})
  end
end
