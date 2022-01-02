defmodule Dictionary.Impl.WordList do

  @type t :: [String.t]

  @spec word_list :: t
  def word_list, do:
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)


  @spec random_word(t) :: String.t
  def random_word(word_list), do: Enum.random(word_list)
end
