defmodule TextClient do

  alias TextClient.Runtime.RemoteHangman
  alias TextClient.Impl.Player

  @spec start :: :ok
  def start, do: RemoteHangman.connect() |> Player.start()
end
