defmodule RecWeb.SnippetLiveTest do
  use RecWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Rec.Library

  @create_attrs %{steps: 42, text: "some text", title: "some title"}
  @update_attrs %{steps: 43, text: "some updated text", title: "some updated title"}
  @invalid_attrs %{steps: nil, text: nil, title: nil}

  defp fixture(:snippet) do
    {:ok, snippet} = Library.create_snippet(@create_attrs)
    snippet
  end

  defp create_snippet(_) do
    snippet = fixture(:snippet)
    %{snippet: snippet}
  end

  describe "Index" do
    setup [:create_snippet]

    test "lists all snippets", %{conn: conn, snippet: snippet} do
      {:ok, _index_live, html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Listing Snippets"
      assert html =~ snippet.text
    end

    test "saves new snippet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("a", "New Snippet") |> render_click() =~
               "New Snippet"

      assert_patch(index_live, Routes.snippet_index_path(conn, :new))

      assert index_live
             |> form("#snippet-form", snippet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#snippet-form", snippet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Snippet created successfully"
      assert html =~ "some text"
    end

    test "updates snippet in listing", %{conn: conn, snippet: snippet} do
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("#snippet-#{snippet.id} a", "Edit") |> render_click() =~
               "Edit Snippet"

      assert_patch(index_live, Routes.snippet_index_path(conn, :edit, snippet))

      assert index_live
             |> form("#snippet-form", snippet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#snippet-form", snippet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Snippet updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes snippet in listing", %{conn: conn, snippet: snippet} do
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("#snippet-#{snippet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#snippet-#{snippet.id}")
    end
  end

  describe "Show" do
    setup [:create_snippet]

    test "displays snippet", %{conn: conn, snippet: snippet} do
      {:ok, _show_live, html} = live(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert html =~ "Show Snippet"
      assert html =~ snippet.text
    end

    test "updates snippet within modal", %{conn: conn, snippet: snippet} do
      {:ok, show_live, _html} = live(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Snippet"

      assert_patch(show_live, Routes.snippet_show_path(conn, :edit, snippet))

      assert show_live
             |> form("#snippet-form", snippet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#snippet-form", snippet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert html =~ "Snippet updated successfully"
      assert html =~ "some updated text"
    end
  end
end
