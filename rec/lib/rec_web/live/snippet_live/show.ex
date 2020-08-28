defmodule RecWeb.SnippetLive.Show do
  use RecWeb, :live_view

  alias Rec.Library

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:snippet, Library.get_snippet!(id))}
  end

  defp page_title(:show), do: "Show Snippet"
  defp page_title(:edit), do: "Edit Snippet"
end
