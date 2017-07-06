defmodule Kito.Type do
  defstruct auto_id: 1, data: %{}

  @moduledoc """
    Documentation for Kito.Type
  """

  @doc """
    Init a Kito. Returns an empty list.

    Example:

      iex > Kito.Type.new
      []
  """
  def new do
    Enum.reduce(
      [],
      %Kito.Type{},
      fn(kito, kito_acc)->
        add(kito_acc, kito)
      end
    )
  end

  @doc """
    Get kitos by key

    Example:

      iex > kitos |> Kito.Type.get(site: "twitter", username: "yeah")
      [%{site: "twitter", password: "238482", username: "yeah"}]
  """
  def get(kitos, key, value) do
    kitos.data
      |> Enum.map(fn({_,v})-> v end)
      |> Enum.filter(fn(x)-> x[key] == value end)
  end

  @doc """
    Adding a single kito

    Example:

      iex > Kito.Type.new |> Kito.Type.add(%{site: "heroku", password: "hehe", username: "joh"})
  """
  def add(%Kito.Type{auto_id: auto_id, data: data} = kitos, kito) do
    kito = Map.put(kito, :id, auto_id)
    new_data = Map.put(data, auto_id, kito)

    %Kito.Type{ kitos |
      data: new_data,
      auto_id: auto_id + 1
    }
  end

  @doc """
    Update a single kito

    Example:

      iex > kitos |> Kito.Type.update(1, %{username: "vincent"})
  """
  def update(kitos, id, key, new_value) do
    data = kitos.data

    case data |> Enum.find(fn({k,_})-> k == id end) do
      nil -> kitos

      {_, kito} ->
        new_kito = Map.put(kito, key, new_value)
        new_data = Map.put(data, new_kito.id, new_kito)
        %Kito.Type{kitos | data: new_data}
    end
  end

  @doc """
    Delete a single kito

    Example
      iex > kitos |> Kito.Type.delete(1)
  """
  def delete(kitos, id) do
    data = kitos.data

    case data |> Enum.find(fn({k,_})-> k == id end) do
      nil -> kitos

      {_, _} ->
        new_kitos = Map.delete(data, id)
        %Kito.Type{kitos | data: new_kitos }
    end
  end
end
