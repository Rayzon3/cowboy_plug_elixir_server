defmodule Example.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias Example.Plug.VerifyRequest

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug VerifyRequest, fields: ["content", "mimetype"], paths: ["/upload"]
  plug(Plug.Logger)
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello World! \n")
  end

  get "/user" do
    send_resp(conn, 200, "Rayzon \n")
  end

  get "/upload" do
    send_resp(conn, 201, "Uploaded \n")
  end

  match _ do
    send_resp(conn, 404, "Oops! \n")
  end

  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong \n")
  end
end
