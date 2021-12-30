defmodule Dictionary do
  @word_list "assets/words.txt"
    |> File.read!()
    |> String.split("\n", trim: true)


  def random_word, do: Enum.random(@word_list)

end
