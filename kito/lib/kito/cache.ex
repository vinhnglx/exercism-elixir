defmodule Kito.Cache do
  use GenServer

  def init(_) do
    # Associates kito-type names with kito-server pids
    {:ok, Map.new}
  end

  def handle_call({:server_process, kito_type_name}, _, kito_servers) do
    case Map.fetch(kito_servers, kito_type_name) do
      {:ok, kito_server} ->
        # server exists
        {:reply, kito_server, kito_servers}

      :error ->
        # server doesn't exist so create new instance
        {:ok, new_kito_server_pid} = Kito.Server.start

        {:reply, new_kito_server_pid, Map.put(kito_servers, kito_type_name, new_kito_server_pid)}
    end
  end

  def start do
    # __MODULE__ is the name of current module.
    GenServer.start(__MODULE__, nil)
  end

  def server_process(pid, kito_type_name) do
    GenServer.call(pid, {:server_process, kito_type_name})
  end
end
