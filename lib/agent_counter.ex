defmodule AgentCounter do
  def start(initial_value) do
    # Starting an agent just requires giving it a function that returns the
    # agent's initial value.
    Agent.start(fn -> initial_value end)
  end

  def get_value(pid) do
    # To get the value, we pass a function that receives the agent's state and
    # returns whatever we want - in our case, we want to wrap the value in an
    # `:ok` 2-tuple.
    Agent.get(pid, fn(x) -> {:ok, x} end)
  end

  def increment(pid) do
    # To increment, we send a function that tells the agent what to do with its
    # state.
    Agent.update(pid, fn(x) -> x + 1 end)
  end

  def decrement(pid) do
    # To decrement, we send a function that tells the agent what to do with its
    # state.
    Agent.update(pid, fn(x) -> x - 1 end)
  end
end
