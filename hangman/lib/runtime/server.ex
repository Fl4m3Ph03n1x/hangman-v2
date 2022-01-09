defmodule Hangman.Runtime.Server do
  use GenServer

  alias Hangman.Impl.Game
  alias Hangman.Runtime.Watchdog

  @type t :: pid

  @idle_timeout 1 * 60 * 60 * 1000 # 1 hour

  # PUBLIC API
  @spec start_link(nil) :: :ignore | {:error, any} | {:ok, t}
  def start_link(_args), do: GenServer.start_link(__MODULE__, nil)

  # Callbacks
  @spec init(nil) :: {:ok, {Game.t, Watchdog.t}}
  def init(nil) do
    watcher = Watchdog.start(@idle_timeout)
    {:ok, {Game.new_game(), watcher}}
  end

  def handle_call({:make_move, guess}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, {updated_game, watcher}}
  end

  def handle_call({:tally}, _from, {game, watcher}) do
    Watchdog.im_alive(watcher)
    {:reply, Game.tally(game), {game, watcher}}
  end
end
