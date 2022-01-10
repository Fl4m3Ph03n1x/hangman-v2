defmodule LiveAppWeb.Live.Game.Figure do
  use LiveAppWeb, :live_component

  alias Elixir.Phoenix.LiveView.{Rendered, Socket}

  @spec mount(Socket.t) :: {:ok, Socket.t}
  def mount(socket) do
    {:ok, socket}
  end

  @spec render(map) :: Rendered.t
  def render(assigns) do
    ~H"""
      <p>In figure</p>
    """
  end
end
