## Running sequential

# server_pid = DatabaseServer.start
#
# DatabaseServer.run_async(server_pid, "Query 1")
#
# DatabaseServer.get_result
#
# "Connection 12: Query 1 result"

## Running concurrent

# pool = 1..100 |> Enum.map(fn(_x) -> DatabaseServer.start end)
#
# 1..10 |> Enum.each(fn(query_def)->
#   server-pid = Enum.at(pool, :random.uniform(100) -1)
#   DatabaseServer.run_async(server_pid, query_def)
# end)
#
# 1..10 |> Enum.map(fn(x)-> DatabaseServer.get_result end)
#
# ["8 result", "2 result", "3 result", "5 result", "9 result", "1 result",
# "4 result", "7 result", "6 result", "10 result"]


defmodule DatabaseServer do
  def start do
    # spawn(DatabaseServer, :loop, [])
    spawn(fn ->
      connection = :random.uniform(100)
      loop(connection)
    end)
  end

  def loop(connection) do
    receive do
      {:run_query, caller, query_def} -> send(caller, {:query_result, run_query(connection, query_def)})
    end

    loop(connection)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  defp run_query(connection, query_def) do
    :timer.sleep(2000)
    "Connection #{connection}: #{query_def} result"
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    end
  end
end
