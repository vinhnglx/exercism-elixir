defmodule Kito.Database do
  use GenServer

  def init(db_path) do
    File.mkdir_p(db_path)
    {:ok, db_path}
  end

  def handle_cast({:store, key, data}, db_path) do
    "#{db_path}/#{key}" |> File.write!(:erlang.term_to_binary(data))

    {:noreply, db_path}
  end

  def handle_call({:get, key}, _, db_path) do
    data = case File.read("#{db_path}/#{key}") do
      {:ok, contents} -> :erlang.binary_to_term(contents)

      _ -> nil
    end

    {:reply, data, db_path}
  end

  def start(db_path) do
    GenServer.start(__MODULE__, db_path, name: :database_server)
  end

  def store(key, data) do
    # use an alias have a downside is that you can only run one instance of database server process
    GenServer.cast(:database_server, {:store, key, data})
  end

  def get(key) do
    GenServer.call(:database_server, {:get, key})
  end
end
