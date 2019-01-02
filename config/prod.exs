use Mix.Config

config :recipes, Recipes.Ecto.Repo,
  database: "recipes",
  url: System.get_env("DATABASE_URL")
