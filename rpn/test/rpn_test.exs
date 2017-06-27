defmodule RpnTest do
  use ExUnit.Case
  doctest Rpn

  # Rpn's methods

  test "start a Rpn calculation" do
    {:ok, pid} = Rpn.start
    assert is_pid(pid) == true
    assert Rpn.peek(pid) == []
  end

  test "push an operand to stack" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    assert Rpn.peek(pid) == [5]
    Rpn.push(pid, 10)
    assert Rpn.peek(pid) == [10, 5]
  end

  test "adding" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 10)

    Rpn.push(pid, :+)
    assert Rpn.peek(pid) == [15]
  end

  test "subtracting" do
    {:ok, pid} = Rpn.start
    Rpn.push(pid, 5)
    Rpn.push(pid, 10)

    Rpn.push(pid, :-)
    assert Rpn.peek(pid) == [-5]
  end
end
