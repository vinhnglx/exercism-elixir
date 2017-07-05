defmodule Entrada do
  @moduledoc """
  Documentation for Entrada.
  """

  use GenServer

  @doc """
    Receive the request push value to the state

    Example

      iex > Entrada.start(:pink)
      iex > Entrada.push(:pink, 2)
      :ok
  """
  def handle_cast({:push, value}, state) do
    {:noreply, [value|state]}
  end

  @doc """
    Receive the request pop a value from the state

    Example

      iex > Entrada.start(:blue)
      iex > Entrada.push(:blue, 3)
      iex > Entrada.pop(:blue)
      3
  """
  def handle_call(:pop, _, state) do
    {value, new_state} = List.pop_at(state, -1)
    {:reply, value, new_state}
  end

  @doc """
    Receive the request to return whole the state

    Example

      iex > Entrada.start(:green)
      iex > Entrada.push(:green, 4)
      iex > Entrada.get(:green)
      4
  """
  def handle_call(_, _, state) do
    {:reply, state, state}
  end

  # Interface functions

  @doc """
    Start a server-process Entrada with a name

    Example

      iex > Entrada.start(:red)
  """
  def start(color) do
    GenServer.start_link(Entrada, [], name: color)
  end

  @doc """
    Pop a value from current server process
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @doc """
    Push a value to current server process
  """
  def push(pid, value) do
    GenServer.cast(pid, {:push, value})
  end

  @doc """
    Transfer the data from the left process to the right process
  """
  def transfer(left, right) do
    push(right, pop(left))
  end

  @doc """
    Pushing the data to a server process
  """
  def pushing(pid, data) do
    for item <- data do
      push(pid, item)
    end
  end

  @doc """
    Get the current data of a process
  """
  def get(pid) do
    GenServer.call(pid, nil)
  end
end
