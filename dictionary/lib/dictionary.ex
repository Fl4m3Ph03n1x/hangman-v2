defmodule Dictionary do
  alias Dictionary.Impl.WordList

  @opaque word_list :: WordList.t

  @spec start :: word_list
  defdelegate start, to: WordList, as: :word_list

  @spec random_word(word_list) :: String.t
  defdelegate random_word(list), to: WordList
end
