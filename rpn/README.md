# Reverse Polish Notation Calculator

Reverse Polish Notation is a mathematical notation in which every operator follows all of its operands,
in contrast to Polish notation (PN), which puts the operator before its operands.

## Getting Started

```elixir
iex> {:ok, pid} = Rpn.start
iex> Rpn.push(pid, 5)
iex> Rpn.push(pid, 5)
iex> Rpn.push(pid, :+)
iex> Rpn.peek(pid)
# [10]
```
