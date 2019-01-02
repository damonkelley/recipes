defmodule Recipes.Ecto.RepoTest do
  use ExUnit.Case, async: true

  alias Recipes.Ecto.Repo
  alias Recipes.Recipe

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Recipes.Ecto.Repo)
  end

  test "it will insert a recipe" do
    name = "Chili"
    href = "http://example.com/chili"

    assert {:ok, %Recipe{id: _, name: ^name, href: ^href}} =
             Repo.insert(%Recipe{name: name, href: href})
  end
end
