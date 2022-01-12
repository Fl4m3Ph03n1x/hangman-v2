defmodule TextClient.Runtime.RemoteHangman do
  @moduledoc """
  RemoteHangman contains the full shortname of the remote server this client will connect to.
  Also contains functionality to communicate with said remote Node, namely to start a new game.
  """

  @remote_server :hangman@WinDev2108Eval

  def connect, do: :rpc.call(@remote_server, Hangman, :new_game, [])
end
