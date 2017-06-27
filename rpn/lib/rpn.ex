defmodule Rpn do
  @moduledoc """
  Documentation for Rpn.
  """

  @doc """
    Start a Rpn calculation

    ## Example

      iex > Rpn.start
  """
  def start do
    Agent.start(fn -> [] end)
  end

  @doc """
    Push an operand to stack

    ## Example

      iex > {:ok, pid} = Rpn.start
      iex > Rpn.push(pid, 5)
  """
  def push(pid, operand) do
    Agent.update(pid, fn(list)-> [operand|list] end)
  end

  @doc """
    Get the data currently of the calculation

    ## Example

      iex > {:ok, pid} = Rpn.start
      iex > Rpn.push(pid, 5)
      iex > Rpn.peek(pid)
      # [5]
  """
  def peek(pid) do
    Agent.get(pid, fn(list)-> list end)
  end
end
