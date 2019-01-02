defmodule Recipes.Repo.Migrations.AddRecipesTable do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add(:name, :string)
      add(:href, :string)
    end
  end
end
