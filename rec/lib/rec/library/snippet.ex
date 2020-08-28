defmodule Rec.Library.Snippet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snippets" do
    field :steps, :integer
    field :text, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [:title, :text, :steps])
    |> validate_required([:title, :text, :steps])
  end
end
