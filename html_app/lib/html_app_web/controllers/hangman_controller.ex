defmodule HtmlAppWeb.HangmanController do
  use HtmlAppWeb, :controller

  alias Hangman
  alias Plug.Conn

  @spec index(Conn.t, any) :: Conn.t
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec new(Conn.t, any) :: Conn.t
  def new(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    put_session(conn, :game, game)
    render(conn, "game.html", tally: tally)
  end
end
