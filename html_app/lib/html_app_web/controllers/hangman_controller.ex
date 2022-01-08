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

    conn
    |> put_session(:game, game)
    |> redirect(to: Routes.hangman_path(conn, :show))
  end

  @spec update(Conn.t, map) :: Conn.t
  def update(conn, params = %{"make_move" => %{"guess" => guess}}) do
    conn
    |> get_session(:game)
    |> Hangman.make_move(guess)

    put_in(conn.params["make_move"]["guess"], "")
    |> redirect(to: Routes.hangman_path(conn, :show))
  end

  @spec show(Conn.t, map) :: Conn.t
  def show(conn, _params) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.tally()

    render(conn, "game.html", tally: tally)
  end
end
