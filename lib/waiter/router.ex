defmodule Waiter.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world\n")
  end

  post "/post" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    IO.inspect(body)
    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
  end

  # json => msgpack
  post "/to_msgpack" do
    {:ok, body, conn} = read_body(conn)
    bin = body
      |> Poison.decode!()
      |> Msgpax.pack!()
    send_resp(conn, 200, bin)
  end

  # msgpack => json
  post "/to_json" do
    {:ok, body, conn} = read_body(conn)
    json = body
      |> Msgpax.unpack!()
      |> Poison.encode!()
    send_resp(conn, 200, json)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

end
