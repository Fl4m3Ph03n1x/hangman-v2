defmodule Hangman.Runtime.Watchdog do

  @type t :: pid

  @spec start(non_neg_integer) :: t
  def start(expiry_time), do: spawn_link(fn -> watcher(expiry_time) end)

  @spec im_alive(t) :: :ok
  def im_alive(watcher), do: send(watcher, :im_alive)

  @spec watcher(non_neg_integer) :: true
  defp watcher(expiry_time) do
    receive do
      :im_alive -> watcher(expiry_time)

    after expiry_time ->
      Process.exit(self(), {:shutdowm, :watchdog_triggered})
    end

  end
end
