defmodule RecWeb.FrontDoorLive do
  use RecWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "hello world")}
  end

  def render(assigns) do
    ~L"""
    <H1><%= @message %></H1>
    """
  end
end