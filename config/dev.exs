use Mix.Config

config :recipes, Recipes.Ecto.Repo,
  database: "recipes",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5433"
