defmodule Rec.LibraryTest do
  use Rec.DataCase

  alias Rec.Library

  describe "snippets" do
    alias Rec.Library.Snippet

    @valid_attrs %{steps: 42, text: "some text", title: "some title"}
    @update_attrs %{steps: 43, text: "some updated text", title: "some updated title"}
    @invalid_attrs %{steps: nil, text: nil, title: nil}

    def snippet_fixture(attrs \\ %{}) do
      {:ok, snippet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_snippet()

      snippet
    end

    test "list_snippets/0 returns all snippets" do
      snippet = snippet_fixture()
      assert Library.list_snippets() == [snippet]
    end

    test "get_snippet!/1 returns the snippet with given id" do
      snippet = snippet_fixture()
      assert Library.get_snippet!(snippet.id) == snippet
    end

    test "create_snippet/1 with valid data creates a snippet" do
      assert {:ok, %Snippet{} = snippet} = Library.create_snippet(@valid_attrs)
      assert snippet.steps == 42
      assert snippet.text == "some text"
      assert snippet.title == "some title"
    end

    test "create_snippet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_snippet(@invalid_attrs)
    end

    test "update_snippet/2 with valid data updates the snippet" do
      snippet = snippet_fixture()
      assert {:ok, %Snippet{} = snippet} = Library.update_snippet(snippet, @update_attrs)
      assert snippet.steps == 43
      assert snippet.text == "some updated text"
      assert snippet.title == "some updated title"
    end

    test "update_snippet/2 with invalid data returns error changeset" do
      snippet = snippet_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_snippet(snippet, @invalid_attrs)
      assert snippet == Library.get_snippet!(snippet.id)
    end

    test "delete_snippet/1 deletes the snippet" do
      snippet = snippet_fixture()
      assert {:ok, %Snippet{}} = Library.delete_snippet(snippet)
      assert_raise Ecto.NoResultsError, fn -> Library.get_snippet!(snippet.id) end
    end

    test "change_snippet/1 returns a snippet changeset" do
      snippet = snippet_fixture()
      assert %Ecto.Changeset{} = Library.change_snippet(snippet)
    end
  end
end
