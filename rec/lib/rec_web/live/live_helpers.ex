defmodule RecWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `RecWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, RecWeb.SnippetLive.FormComponent,
        id: @snippet.id || :new,
        action: @live_action,
        snippet: @snippet,
        return_to: Routes.snippet_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, RecWeb.ModalComponent, modal_opts)
  end
end
