defmodule Recipes.Recipe do
  use Ecto.Schema

  import Ecto.Changeset

  schema "recipes" do
    field(:name)
    field(:href)
  end

  def changeset(%Recipes.Recipe{} = recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :href])
    |> validate_required([:name, :href])
  end
end
