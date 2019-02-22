defmodule WaiterTest do
  use ExUnit.Case
  doctest Waiter

  test "greets the world" do
    assert Waiter.hello() == :world
  end
end
