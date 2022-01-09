defmodule HtmlAppWeb.HangmanView do
  use HtmlAppWeb, :view

  defdelegate figure_for(turns_left), to: HtmlAppWeb.HangmanView.Helpers.FigureFor

  @status_fields %{
    initializing: {"initializing", "Guess the word, a letter at a time"},
    good_guess: {"good_guess", "Good guess!"},
    bad_guess: {"bad_guess", "Ups, wrong one, try again!"},
    won: {"won", "You won!"},
    lost: {"lost", "Game over..."},
    already_used: {"already_used", "Letter already used, try another one!"},
  }

  def move_status(state) do
    {class, msg} = @status_fields[state]
    "<div class='status #{class}'>#{msg}</div>"
  end

  def continue_or_try_again(conn, status) when status in [:won, :lost] do
    button("New game?", to: Routes.hangman_path(conn, :new))
  end

  def continue_or_try_again(conn, _status) do
    form_for(conn, Routes.hangman_path(conn, :update), [as: "make_move", method: :put], fn form ->
      [text_input(form, :guess),
      " ",
      submit("Make a guess")]
    end)
  end

end
