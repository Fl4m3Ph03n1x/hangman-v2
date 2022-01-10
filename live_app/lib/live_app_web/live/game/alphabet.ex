defmodule LiveAppWeb.Live.Game.Alphabet do
  use LiveAppWeb, :live_component

  alias Elixir.Phoenix.LiveView.{Rendered, Socket}

  @spec mount(Socket.t) :: {:ok, Socket.t}
  def mount(socket) do
    letters = Enum.map((?a .. ?z), &<< &1 :: utf8 >>)
    {:ok, assign(socket, letters: letters)}
  end

  @spec render(map) :: Rendered.t
  def render(assigns) do
    ~H"""
      <div class="alphabet">
        <%= for letter <- assigns.letters do %>
          <div phx-click="make_move" phx-value-key={letter} class={letter_class(letter, assigns.tally)}>
            <%= letter %>
          </div>
        <% end %>
      </div>
    """
  end

  @spec letter_class(String.t, map) :: String.t
  defp letter_class(letter, tally) do
    cond do
      Enum.member?(tally.letters, letter) -> "one-letter correct"
      Enum.member?(tally.used, letter) -> "one-letter wrong"
      true -> "one-letter"
    end
  end
end
