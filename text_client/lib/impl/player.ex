defmodule TextClient.Impl.Player do

  alias Hangman

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: {game, tally}

  @spec start :: :ok
  def start do
    game = Hangman.new_game()
    interact({game, Hangman.tally(game)})
  end

  @spec interact(state) :: :ok
  def interact({_game, _tally = %{game_state: :won}}), do: IO.puts("You won! Yeeyy!")

  def interact({_game, _tally = %{game_state: :lost, letters: letters}}), do:
    IO.puts("Game Over ...The word was: #{Enum.join(letters)}")

  def interact({game, tally}) do
    tally
    |> feedback_message()
    |> IO.puts()

    tally
    |> current_word()
    |> IO.puts()


    tally = Hangman.make_move(game, get_guess())
    interact({game, tally})
  end

  @spec feedback_message(tally) :: String.t
  defp feedback_message(%{game_state: :good_guess}), do: "You guessed correctly!"

  defp feedback_message(%{game_state: :bad_guess}), do: "Wrong guess!"

  defp feedback_message(%{game_state: :initializing, letters: letters}), do:
    "Welcome! I am thinking of a word with #{length(letters)} letters!"

  def feedback_for(%{game_state: :already_used}), do: "You already used that letter"

  @spec current_word(tally) :: [String.t]
  defp current_word(%{letters: letters, turns_left: turns, used: used}), do: [
    "Word so far: ",
    Enum.join(letters, " "),
    "\nTurns left: ",
    to_string(turns),
    "\nUsed: ",
    to_string(used)
  ]

  @spec get_guess :: String.t
  defp get_guess, do:
    IO.gets("Guess a letter: ")
    |> String.trim()
    |> String.downcase()
end
