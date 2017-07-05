# Entrada

Portal implementation by GenServer

## Getting started

- Run `iex -S mix run`

- Example

```elixir

iex(1)> Entrada.start(:green)
{:ok, #PID<0.138.0>}
iex(2)> Entrada.start(:blue)
{:ok, #PID<0.140.0>}
iex(3)> Entrada.pushing(:blue, [4,2,1,2,4,53])
[:ok, :ok, :ok, :ok, :ok, :ok]
iex(4)> Entrada.transfer(:blue, :green)
:ok
iex(5)> Entrada.get(:blue)
[53, 4, 2, 1, 2]
iex(6)> Entrada.get(:green)
[4]

```
