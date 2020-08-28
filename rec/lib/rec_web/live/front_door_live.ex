defmodule RecWeb.FrontDoorLive do
  use RecWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(snippet_id: :it)
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
    <p>Memorize this in <%= @snippet.steps %> steps</p>
    """
  end

  defp previous_id(:it), do: :grail
  defp previous_id(:grail), do: :it

  defp next_id(:it), do: :grail
  defp next_id(:grail), do: :it

  defp previous(socket) do
    snippet_id = previous_id(socket.assigns.snippet_id)
    socket
    |> assign(snippet_id: snippet_id)
    |> load_snippet
  end

  defp next(socket) do
    snippet_id = next_id(socket.assigns.snippet_id)
    socket
    |> assign(snippet_id: snippet_id)
    |> load_snippet
  end

  defp load_snippet(socket) do
    snippet = snippet(socket.assigns.snippet_id)
    assign(socket, snippet: snippet)
  end

  defp snippet(:it) do
    %{title: "IT Crowd", text: "Did you try turning it off and on again?", steps: 3}
  end

  defp snippet(:grail) do
    %{title: "The Holy Grail", text: "I got better", steps: 4}
  end

  def handle_event("previous", _, socket) do
    {:noreply, previous(socket)}
  end

  def handle_event("next", _, socket) do
    {:noreply, next(socket)}
  end
end
