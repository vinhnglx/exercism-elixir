defmodule EntradaTest do
  use ExUnit.Case
  doctest Entrada

  test "start the entrada" do
    {:ok, pid} = Entrada.start(:pink)
    assert is_pid(pid) == true
  end

  test "push value to the entrada" do
    Entrada.start(:pink)
    assert Entrada.push(:pink, 4) == :ok
  end

  test "start pushing data to the left" do
    Entrada.start(:pink)

    Entrada.pushing(:pink, [1,2,3])
    assert Entrada.get(:pink) == [3,2,1]
  end

  test "pop a value from the entrada" do
    Entrada.start(:pink)
    Entrada.pushing(:pink, [1,2,3])

    assert Entrada.pop(:pink) == 1
    assert Entrada.get(:pink) == [3,2]
  end

  test "transfer data from left to right" do
    Entrada.start(:pink)
    Entrada.start(:blue)

    Entrada.pushing(:pink, [1,2,3,4])
    Entrada.transfer(:pink, :blue)

    assert Entrada.get(:pink) == [4,3,2]
    assert Entrada.get(:blue) == [1]
  end
end
