defmodule Recipes.RepoTest do
  use ExUnit.Case, async: true

  alias Recipes.Repo
  alias Recipes.Recipe

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Recipes.Ecto.Repo)
  end

  test "it will insert a recipe" do
    name = "Chili"
    href = "http://example.com/chili"

    assert {:ok, %{id: _, name: name, href: href}} = Repo.insert(%{name: name, href: href})
  end

  test "it will return an error if the recipe cannot be inserted" do
    assert {:error, [name: _, href: _]} = Repo.insert(%{"invalid_key" => "Delicious Recipe"})
  end

  test "it will get a recipe" do
    {:ok, %{id: id} = inserted_recipe} =
      %{name: "Chili", href: "http://example.com/chili"}
      |> Repo.insert()

    assert {:ok, ^inserted_recipe} = Repo.get(%Recipe{id: id})
  end

  test "it will return an error if it cannot find a recipe" do
    assert {:error, "Recipe not found"} = Repo.get(%Recipe{id: 1})
  end

  test "it will fetch all recipes" do
    chili = %{name: "Chili", href: "http://example.com/chili"}
    tacos = %{name: "Tacos", href: "http://example.com/tacos"}

    [chili, tacos]
    |> Enum.each(&Repo.insert(&1))

    {:ok, recipes} = Repo.all()

    assert Enum.count(recipes) == 2
  end

  test "it will return an error if there are no recipes" do
    assert {:error, "No results"} = Repo.all()
  end
end
