defmodule Counter do
  def start(initial_value) do
    { :ok, spawn(Counter, :loop, [initial_value]) }
  end

  def loop(value) do
    receive do
      # In our loop we'll expect to be told who a message is from, a ref that is
      # unique to their request, and a term that tells us what to do - in this
      # case, get the value of the counter.
      #
      # We'll send the value back with the ref so they know it's the appropriate
      # response, and then we'll tail-call with the existing value
      { from, ref, :get_value } ->
        send(from, {:ok, ref, value})
        loop(value)
      :increment ->
        loop(value + 1)
      :decrement ->
        loop(value - 1)
    end
  end

  # Then we just make the nice function to interact with our process loop
  def get_value(pid) do
    ref = make_ref()
    send(pid, { self(), ref, :get_value })
    receive do
      { :ok, ^ref, val } -> { :ok, val }
    end
  end

  def increment(pid) do
    send(pid, :increment)
    :ok
  end

  def decrement(pid) do
    send(pid, :decrement)
    :ok
  end
end
