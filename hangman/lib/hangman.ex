defmodule Hangman do

  alias Hangman.Runtime.{Application, Server}
  alias Hangman.Type

  @opaque game :: Server.t


  @spec new_game :: game
  def new_game do
    {:ok, pid} = Application.start_game()
    pid
  end

  @spec make_move(game, String.t) :: Type.tally
  def make_move(game, guess), do: GenServer.call(game, {:make_move, guess})

  @spec tally(game) :: Type.tally
  def tally(game), do: GenServer.call(game, {:tally})
end
