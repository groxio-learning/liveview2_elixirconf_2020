defmodule RecWeb.GameLive do
  use RecWeb, :live_view

  alias Rec.Library
  alias Rec.Game

  # Constructor
  def mount(%{"id" => id}, _session, socket) do
    snippet = Library.get_snippet!(id)
    {
      :ok,
      socket
      |> assign(eraser: Game.Eraser.new(snippet.text, snippet.steps))
    }
  end

  # Reducers
  def handle_event("erase", _, socket) do
    {:noreply, erase(socket)}
  end

  # Transformer
  def render(assigns) do
    ~L"""
    <pre><%= @eraser.text %></pre>
    <button phx-click="erase">Erase</button>
    """
  end

  defp erase(socket) do
    assign(socket, eraser: Game.Eraser.erase(socket.assigns.eraser))
  end
end