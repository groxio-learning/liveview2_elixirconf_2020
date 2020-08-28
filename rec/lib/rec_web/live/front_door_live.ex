defmodule RecWeb.FrontDoorLive do
  use RecWeb, :live_view

  alias Rec.Library

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(snippet_id: Library.first().id)
      |> load_snippet()
    }
  end

  def render(assigns) do
    ~L"""
    <div>
      <button phx-click="previous">Previous</button>
      <%= @snippet.title %>
      <button phx-click="next">Next</button>
    </div>
    <pre><%= @snippet.text %></pre>
    <p><button phx-click="memorize">Memorize</button> this in <%= @snippet.steps %> steps</p>
    """
  end

  defp previous(socket) do
    snippet_id = Library.previous(socket.assigns.snippet_id)

    socket
    |> assign(snippet_id: snippet_id)
    |> load_snippet
  end

  defp next(socket) do
    snippet_id = Library.next(socket.assigns.snippet_id)

    socket
    |> assign(snippet_id: snippet_id)
    |> load_snippet
  end

  defp load_snippet(socket) do
    snippet = Library.get_snippet!(socket.assigns.snippet_id)
    assign(socket, snippet: snippet)
  end

  def handle_event("previous", _, socket) do
    {:noreply, previous(socket)}
  end

  def handle_event("next", _, socket) do
    {:noreply, next(socket)}
  end

  def handle_event("memorize", _, socket) do
    {:noreply, push_redirect(socket, to: "/game/#{socket.assigns.snippet_id}")}
  end
end
