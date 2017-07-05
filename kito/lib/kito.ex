defmodule Kito do
  def init do
    Map.new
  end

  def handle_call({:put, key, value}, state) do
    # {response, new_state}
    {:ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, state) do
    # {response, new_state}
    {Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  # Interface functions
  def start do
    Ceto.start(Kito)
  end

  def put(pid, key, value) do
    # Ceto.call(pid, {:put, key, value})
    Ceto.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    Ceto.call(pid, {:get, key})
  end
end
