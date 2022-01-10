defmodule LiveAppWeb.Live.Game do
  use LiveAppWeb, :live_view

  alias Elixir.Phoenix.LiveView.{Rendered, Socket}
  alias Hangman
  alias __MODULE__.{Alphabet, Figure, WordSoFar}

  @spec mount(any, any, Socket.t) :: {:ok, Socket.t}
  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    updated_socket = assign(socket, %{game: game, tally: tally})
    {:ok, updated_socket}
  end

  @spec render(map) :: Rendered.t
  def render(assigns) do
    ~H"""
      <div class="game-holder" phx-window-keyup="make_move">
        <%= live_component(Figure, tally: assigns.tally, id: 1) %>
        <%= live_component(Alphabet, tally: assigns.tally, id: 2) %>
        <%= live_component(WordSoFar, tally: assigns.tally, id: 3) %>
      </div>
    """
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    tally = Hangman.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, :tally, tally)}
  end
end
