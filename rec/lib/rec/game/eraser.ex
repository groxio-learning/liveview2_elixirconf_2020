defmodule Rec.Game.Eraser do
  defstruct ~w[text plan]a

  def new(text, steps) do
    %__MODULE__{text: text, plan: build_plan(text, steps)}
  end

  defp chunk_size(text, steps) do
    text |> String.length |> Kernel./(steps) |> ceil
  end

  defp build_plan(text, steps) do
    chunk_size = chunk_size(text, steps)
    1..String.length(text) |> Enum.shuffle |> Enum.chunk_every(chunk_size)
  end
end
