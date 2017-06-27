defmodule RpnTest do
  use ExUnit.Case
  doctest Rpn

  # Rpn's methods
  test "start a Rpn calculation" do
    {:ok, pid} = Rpn.start
    assert is_pid(pid) == true
  end

end
