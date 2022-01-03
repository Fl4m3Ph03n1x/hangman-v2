defmodule HtlmAppWeb.PageController do
  use HtlmAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
