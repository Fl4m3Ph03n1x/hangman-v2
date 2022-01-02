defmodule TextClient.Runtime.RemoteHangman do
  @remote_server :hangman@WinDev2108Eval

  def connect, do: :rpc.call(@remote_server, Hangman, :new_game, [])
end
