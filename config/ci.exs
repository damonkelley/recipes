use Mix.Config

config :recipes, Recipes.Ecto.Repo,
  username: "postgres",
  database: "recipes_ci",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox
