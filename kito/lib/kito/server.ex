defmodule Kito.Server do
  use GenServer

  def init(_) do
    {:ok, Kito.Type.new}
  end

  def handle_cast({:add, kito}, state) do
    {:noreply, Kito.Type.add(state, kito)}
  end

  def handle_cast({:update, id, key, new_value}, state) do
    {:noreply, Kito.Type.update(state, id, key, new_value)}
  end

  def handle_cast({:delete, id}, state) do
    {:noreply, Kito.Type.delete(state, id)}
  end

  def handle_call({:get, key, value}, _, state) do
    {:reply, Kito.Type.get(state, key, value), state}
  end

  # Interface functions
  def start do
    GenServer.start(__MODULE__, nil)
  end

  def add(pid, kito) do
    GenServer.cast(pid, {:add, kito})
  end

  def get(pid, key, value) do
    GenServer.call(pid, {:get, key, value})
  end

  def update(pid, id, key, new_value) do
    GenServer.cast(pid, {:update, id, key, new_value})
  end

  def delete(pid, id) do
    GenServer.cast(pid, {:delete, id})
  end
end
