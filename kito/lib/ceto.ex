defmodule Ceto do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init

      loop(callback_module, initial_state)
    end)
  end

  def call(ceto_pid, request) do
    send(ceto_pid, {request, self()})

    receive do
      {:response, response} -> response
    end
  end

  defp loop(callback_module, current_state) do
    receive do
      {request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(callback_module, new_state)
    end
  end
end
