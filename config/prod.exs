use Mix.Config

config :recipes, Recipes.Ecto.Repo, url: System.get_env("DATABASE_URL")
