defmodule Hangman.Impl.Game do
  alias Dictionary
  alias Hangman.Type

  @type t :: %__MODULE__{
    turns_left: integer,
    state: Type.state,
    letters: [String.t],
    used: MapSet.t(String.t)
  }

  defstruct(
    turns_left: 7,
    state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  @spec new_game :: t
  def new_game, do: new_game(Dictionary.random_word())

  @spec new_game(String.t) :: t
  def new_game(word), do:
    %__MODULE__{
      letters: String.codepoints(word)
    }

  @spec make_move(t, String.t) :: {t, Type.tally}
  def make_move(game = %{state: the_state}, _guess) when the_state in [:won, :lost], do: return_with_tally(game)

  def make_move(game, guess) do
    game
    |>accept_guess(guess, MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  @spec accept_guess(t, String.t, bool) :: t
  defp accept_guess(game, _guess, _used? = true), do: %{game | state: :already_used}

  defp accept_guess(game, guess, _used?) do
    %{game | used: MapSet.put(game.used, guess)}
    |> score_guess(Enum.member?(game.letters, guess))
  end

  @spec score_guess(t, bool) :: t
  defp score_guess(game, _good_guess? = true) do
    new_state = maybe_won(MapSet.subset?(MapSet.new(game.letters), game.used))
    %{game | state: new_state}
  end

  defp score_guess(game = %{turns_left: 1}, _bad_guess), do: %{game | state: :lost, turns_left: 0}

  defp score_guess(game, _bad_guess), do:
    %{game | state: :bad_guess, turns_left: game.turns_left - 1}

  @spec maybe_won(bool) :: atom
  defp maybe_won(_all_words? = true), do: :won
  defp maybe_won(_), do: :good_guess

  @spec tally(t) :: Type.tally
  defp tally(game), do:
    %{
      turns_left: game.turns_left,
      game_state: game.state,
      letters: reveal_guessed_letters(game),
      used: game.used |> MapSet.to_list() |> Enum.sort()
    }

  @spec reveal_guessed_letters(t) :: [String.t]
  defp reveal_guessed_letters(game) do
    game.letters
    |> Enum.map(fn l ->
      game.used
      |> MapSet.member?(l)
      |> maybe_reveal_letter(l)
    end)
  end

  @spec maybe_reveal_letter(bool, String.t) :: String.t
  defp maybe_reveal_letter(_reveal? = true, letter), do: letter
  defp maybe_reveal_letter(_reveal?, _letter), do: "_"

  @spec return_with_tally(t) :: {t, Type.tally}
  defp return_with_tally(game), do: {game, tally(game)}

end
