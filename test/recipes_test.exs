defmodule RecipesTest do
  use ExUnit.Case, async: true

  @recipes [
    chili: %{name: "Chili", href: "http://example.com/chili"},
    tomato_basil_soup: %{name: "Tomato Basil Soup", href: "http://example.com/tomato-basil-soup"},
    enchiladas: %{name: "Enchiladas", href: "http://example.com/enchiladas"}
  ]

  setup do
    {:ok, _pid} = TestRepo.start_link(%{})
    []
  end

  test "it will create a recipe" do
    result = Recipes.add(@recipes[:enchiladas], repo: TestRepo)

    assert {:ok, %{id: _id}} = result
  end

  test "it will return an error if the recipe cannot be created" do
    result = Recipes.add(%{foo: "bar"}, repo: TestRepo)

    assert {:error, _} = result
  end

  test "it will add the recipe to the repo" do
    {:ok, recipe} = Recipes.add(@recipes[:enchiladas], repo: TestRepo)

    assert {:ok, recipe} = TestRepo.get(recipe)
  end

  test "it will find a recipe" do
    {:ok, %{id: id} = recipe} = TestRepo.insert(@recipes[:enchiladas])

    result = Recipes.find(%{id: id}, repo: TestRepo)

    assert {:ok, recipe} == result
  end

  test "it will find a random recipe" do
    @recipes
    |> Keyword.values()
    |> Enum.each(&TestRepo.insert/1)

    {:ok, %{name: name, href: href} = _recipe} = Recipes.random(repo: TestRepo)

    assert @recipes |> Keyword.values() |> contains_recipe?(%{name: name, href: href})
  end

  test "it will not find a random recipe when there are no recipes" do
    assert {:error, _} = Recipes.random(repo: TestRepo)
  end

  defp contains_recipe?(recipes, %{name: name, href: href}) do
    Enum.any?(recipes, fn
      %{name: ^name, href: ^href} -> true
      _ -> false
    end)
  end
end
