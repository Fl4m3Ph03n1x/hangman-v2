defmodule TextClient do

  alias TextClient.Impl.Player

  @spec start :: :ok
  defdelegate start, to: Player
end
