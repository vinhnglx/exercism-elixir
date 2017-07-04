defmodule Calculator do
  def start(initial_state) do
    # initial_state is 0 if start a process for add/sub
    # initial_state is 1 if start a process for mul
    spawn(fn -> loop(initial_state) end)
  end

  def value(server_pid) do
    send(server_pid, {:value, self()})
    receive do
      {:response, value} -> value
    end
  end

  def add(server_pid, value), do: send(server_pid, {:add, value})
  def sub(server_pid, value), do: send(server_pid, {:sub, value})
  def mul(server_pid, value), do: send(server_pid, {:mul, value})
  def div(server_pid, value), do: send(server_pid, {:div, value})

  defp loop(current_value) do
    new_value = receive do
      message -> process_message(current_value, message)
      # {:add, value} -> current_value + value
      # {:sub, value} -> current_value - value
      # {:mul, value} -> current_value * value
      # {:div, value} -> current_value / value
      # {:value, caller} ->
      #   send(caller, {:response, current_value})
      #   current_value

      # invalid_request ->
      #   IO.puts "invalid request #{inspect invalid_request}"
      #   current_value
    end

    loop(new_value)
  end

  defp process_message(current_value, {:add, value}), do: current_value + value
  defp process_message(current_value, {:sub, value}), do: current_value - value
  defp process_message(current_value, {:mul, value}), do: current_value * value
  defp process_message(current_value, {:div, value}), do: current_value / value
  defp process_message(current_value, {:value, caller}) do
    send(caller, {:response, current_value})
    current_value
  end
  defp process_message(current_value, invalid_request) do
    IO.puts "invalid request #{inspect invalid_request}"
    current_value
  end
end
