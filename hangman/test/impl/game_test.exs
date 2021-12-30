defmodule Hangman.Impl.GameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.state == :initializing
    refute Enum.empty?(game.letters)
  end

  test "game returns correct word" do
    game = Game.new_game("wombat")

    assert game.turns_left == 7
    assert game.state == :initializing
    assert game.letters == ["w", "o", "m", "b", "a", "t"]
  end

  test "game returns word in lowercase" do
    game = Game.new_game()
    assert Enum.all?(game.letters, fn char -> char == String.downcase(char) end)
  end

  test "game state does not change when game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :state, state)
      {new_game, _tally} = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "a duplicated letter is reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end

  test "we recognize a letter in the word" do
    game = Game.new_game("wombat")
    {_game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter that is NOT in the word" do
    game = Game.new_game("wombat")
    {_game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 6
  end

  test "can handle a sequence of moves" do
    [
      #guess  state         turns letters                     used
      ["a",   :bad_guess,     6,    ["_", "_", "_", "_", "_"],  ["a"]],
      ["a",   :already_used,  6,    ["_", "_", "_", "_", "_"],  ["a"]],
      ["e",   :good_guess,    6,    ["_", "e", "_", "_", "_"],  ["a", "e"]],
      ["x",   :bad_guess,     5,    ["_", "e", "_", "_", "_"],  ["a", "e", "x"]],
    ]
    |> test_sequence_of_moves("hello")
  end

  test "can handle a wining game" do
    [
      #guess  state         turns letters                     used
      ["a",   :bad_guess,     6,    ["_", "_", "_", "_", "_"],  ["a"]],
      ["a",   :already_used,  6,    ["_", "_", "_", "_", "_"],  ["a"]],
      ["e",   :good_guess,    6,    ["_", "e", "_", "_", "_"],  ["a", "e"]],
      ["x",   :bad_guess,     5,    ["_", "e", "_", "_", "_"],  ["a", "e", "x"]],
      ["h",   :good_guess,    5,    ["h", "e", "_", "_", "_"],  ["a", "e", "h", "x"]],
      ["l",   :good_guess,    5,    ["h", "e", "l", "l", "_"],  ["a", "e", "h", "l", "x"]],
      ["o",   :won,           5,    ["h", "e", "l", "l", "o"],  ["a", "e", "h", "l", "o", "x"]],
    ]
    |> test_sequence_of_moves("hello")

  end

  test "can handle a loosing game" do
    [
      #guess  state         turns letters                     used
      ["a",   :bad_guess,     6,    ["_", "_", "_", "_", "_"],  ["a"]],
      ["b",   :bad_guess,     5,    ["_", "_", "_", "_", "_"],  ["a", "b"]],
      ["c",   :bad_guess,     4,    ["_", "_", "_", "_", "_"],  ["a", "b", "c"]],
      ["d",   :bad_guess,     3,    ["_", "_", "_", "_", "_"],  ["a", "b", "c", "d"]],
      ["f",   :bad_guess,     2,    ["_", "_", "_", "_", "_"],  ["a", "b", "c", "d", "f"]],
      ["g",   :bad_guess,     1,    ["_", "_", "_", "_", "_"],  ["a", "b", "c", "d", "f", "g"]],
      ["i",   :lost,          0,    ["h", "e", "l", "l", "o"],  ["a", "b", "c", "d", "f", "g", "i"]],
    ]
    |> test_sequence_of_moves("hello")

  end

  defp test_sequence_of_moves(script, word) do
    game = Game.new_game(word)
    Enum.reduce(script, game, &check_move/2)
  end

  defp check_move([guess, state, turns_left, letters, used], game) do
    {new_game, tally} = Game.make_move(game, guess)

    assert tally.game_state == state
    assert tally.letters == letters
    assert tally.turns_left == turns_left
    assert tally.used == used

    new_game
  end
end
