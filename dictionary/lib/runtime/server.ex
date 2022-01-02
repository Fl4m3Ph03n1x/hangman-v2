defmodule Dictionary.Runtime.Server do

  use Agent
  alias Dictionary.Impl.WordList

  @type t :: pid

  @spec start_link([any]) :: {:ok, t}
  def start_link(_arg), do: Agent.start_link(&WordList.word_list/0, name: __MODULE__)

  @spec random_word :: String.t
  def random_word, do: Agent.get(__MODULE__, &WordList.random_word/1)
end
