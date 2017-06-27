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
end
