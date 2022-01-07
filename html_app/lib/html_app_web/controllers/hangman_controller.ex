defmodule HtmlAppWeb.HangmanController do
  use HtmlAppWeb, :controller

  alias Hangman
  alias Plug.Conn

  @spec index(Conn.t, map) :: Conn.t
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec new(Conn.t, map) :: Conn.t
  def new(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> render("game.html", tally: tally)
  end

  @spec update(Conn.t, map) :: Conn.t
  def update(conn, params = %{"make_move" => %{"guess" => guess}}) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    put_in(conn.params["make_move"]["guess"], "")
    |> render("game.html", tally: tally)
  end
end
