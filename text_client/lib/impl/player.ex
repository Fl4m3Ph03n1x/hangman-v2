defmodule TextClient.Impl.Player do
  @moduledoc """
  Has the code for the player interaction with the terminal.
  It prints messages and manages the feedback loop.
  """

  alias Hangman

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: {game, tally}

  @doc """
  Starts the player feedback loop. Takes a game as a parameter (which is the pid of the remote server)
  and starts the process.
  """
  @spec start(game) :: :ok
  def start(game), do: interact({game, Hangman.tally(game)})

  @doc """
  The feedback loop. Will keep asking the player for input in an infinite loop until the player
  either wins or loses the game.
  """
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
