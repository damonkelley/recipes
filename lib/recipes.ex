defmodule Recipes do
  def add(recipe, options \\ []) do
    repo = Keyword.get(options, :repo)

    recipe |> repo.insert()
  end

  def find(recipe, options \\ []) do
    repo = Keyword.get(options, :repo)

    repo.get(recipe)
  end

  def random(options \\ []) do
    repo = Keyword.get(options, :repo)

    with {:ok, recipes} <- repo.all(),
         do: _random(recipes)
  end

  def _random(recipes) do
    try do
      {:ok, Enum.random(recipes)}
    rescue
      Enum.EmptyError -> {:error, "No results"}
    end
  end
end
