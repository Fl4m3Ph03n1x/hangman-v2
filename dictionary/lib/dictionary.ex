defmodule Dictionary do
  alias Dictionary.Runtime.Server

  @opaque t :: Server.t

  @spec start_link :: {:ok, t}
  defdelegate start_link, to: Server

  @spec random_word(t) :: String.t
  defdelegate random_word(list), to: Server
end
