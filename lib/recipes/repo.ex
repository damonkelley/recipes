defmodule Recipes.Repo do
  alias Ecto.Changeset
  alias Recipes.Ecto
  alias Recipes.Recipe

  def insert(recipe) do
    case _insert(recipe) do
      {:error, %Changeset{} = changeset} -> {:error, changeset.errors}
      result -> result
    end
  end

  def _insert(recipe) do
    %Recipe{}
    |> Recipe.changeset(recipe)
    |> Ecto.Repo.insert()
  end

  def get(%{id: id} = _recipe) do
    case Ecto.Repo.get(Recipe, id) do
      nil -> {:error, "Recipe not found"}
      recipe -> {:ok, recipe}
    end
  end

  def all() do
    case Ecto.Repo.all(Recipe) do
      [] -> {:error, "No results"}
      results -> {:ok, results}
    end
  end
end
