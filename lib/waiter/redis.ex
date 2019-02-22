defmodule Waiter.Redis do

  def rpush(conn, key, values) do
    Redix.command!(conn, ["RPUSH", key] ++ values)
  end

  def lpop(conn, key) do
    Redix.command!(conn, ["LPOP", key])
  end

  def lrange(conn, key, first \\ 0, last \\ -1) do
    Redix.command!(conn, ["LRANGE", key, first, last])
  end

  def del(conn, keys) do
    Redix.command!(conn, ["DEL", keys])
  end

end
