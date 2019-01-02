use Mix.Config

config :recipes, Recipes.Ecto.Repo,
  username: "postgres",
  password: "postgres",
  database: "recipes_test",
  hostname: "localhost",
  port: "5433",
  pool: Ecto.Adapters.SQL.Sandbox
