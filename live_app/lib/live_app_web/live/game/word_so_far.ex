defmodule LiveAppWeb.Live.Game.WordSoFar do
  use LiveAppWeb, :live_component

  alias Elixir.Phoenix.LiveView.{Rendered, Socket}

  @states %{
    already_used: "You already picked that letter !",
    bad_guess: "Ups, wrong one, try again!",
    good_guess: "That's right !",
    won: "Congratulations, you won!",
    lost: "Game over ...",
    initializing: "Make a guess to start!"
  }

  @spec mount(Socket.t) :: {:ok, Socket.t}
  def mount(socket) do
    {:ok, socket}
  end

  @spec render(map) :: Rendered.t
  def render(assigns) do
    ~H"""
      <div class="word-so-far">
        <div class="game-state"> <%= state_name(@tally.game_state) %> </div>
        <div class="letters">
          <%= for char <- @tally.letters do %>
            <div class={letter_class(char)}> <%= char %> </div>
          <% end %>
        </div>
      </div>
    """
  end

  @spec state_name(atom) :: String.t
  defp state_name(state), do: @states[state] || "Unknown"

  @spec letter_class(String.t) :: String.t
  defp letter_class("_"), do: "one-letter"
  defp letter_class(_letter), do: "one-letter correct"

end
