defmodule Recipes.RecipeTest do
  use ExUnit.Case, async: true

  alias Recipes.Recipe

  test "it will cast string param keys" do
    params = %{"name" => "Chili", "href" => "http://example.com/chili"}

    changeset = Recipe.changeset(%Recipe{}, params)

    assert %{name: "Chili", href: "http://example.com/chili"} = changeset.changes
  end

  test "it requires the href value" do
    params = %{"name" => "Chili"}

    changeset = Recipe.changeset(%Recipe{}, params)

    refute changeset.valid?
  end

  test "it requires the name value" do
    params = %{"href" => "http://example.com/chili"}

    changeset = Recipe.changeset(%Recipe{}, params)

    refute changeset.valid?
  end
end
