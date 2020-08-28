defmodule Rec.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :title, :string
      add :text, :text
      add :steps, :integer

      timestamps()
    end

  end
end
