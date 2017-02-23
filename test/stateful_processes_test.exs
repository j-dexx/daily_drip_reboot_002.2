defmodule StatefulProcessesTest do
  use ExUnit.Case
  doctest StatefulProcesses

  # Hand rolled state with processes
  test "starting the counter" do
    { :ok, pid } = Counter.start(0)
    assert is_pid(pid)
  end

  test "getting the value" do
    { :ok, pid } = Counter.start(0)
    assert { :ok, 0 } = Counter.get_value(pid)
  end

  test "incrementing the value" do
    { :ok, pid } = Counter.start(0)
    :ok = Counter.increment(pid)
    assert { :ok, 1 } = Counter.get_value(pid)
  end

  test "decrementing the value" do
    { :ok, pid } = Counter.start(1)
    :ok = Counter.decrement(pid)
    assert { :ok, 0 } = Counter.get_value(pid)
  end

  # Using agents
  test "starting the agent counter" do
    { :ok, pid } = AgentCounter.start(0)
    assert is_pid(pid)
  end

  test "getting the value from agent counter" do
    { :ok, pid } = AgentCounter.start(0)
    assert { :ok, 0 } = AgentCounter.get_value(pid)
  end

  test "incrementing the value in agent counter" do
    { :ok, pid } = AgentCounter.start(0)
    :ok = AgentCounter.increment(pid)
    assert { :ok, 1 } = AgentCounter.get_value(pid)
  end

  test "decrementing the value in agent counter" do
    { :ok, pid } = AgentCounter.start(1)
    :ok = AgentCounter.decrement(pid)
    assert { :ok, 0 } = AgentCounter.get_value(pid)
  end
end
