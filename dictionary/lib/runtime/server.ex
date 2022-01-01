defmodule Dictionary.Runtime.Server do

  @type t :: pid

  alias Dictionary.Impl.WordList

  @spec start_link :: {:ok, t}
  def start_link, do: Agent.start_link(&WordList.word_list/0)

  @spec random_word(t) :: String.t
  def random_word(pid), do: Agent.get(pid, &WordList.random_word/1)
end
