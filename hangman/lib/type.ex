defmodule Hangman.Type do

  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @type tally :: %{
    turns_left: integer,
    game_state: state,
    letters: [String.t],
    used: [String.t]
  }
end
