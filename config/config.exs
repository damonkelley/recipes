# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :recipes,
  ecto_repos: [Recipes.Ecto.Repo],
  port: (System.get_env("PORT") || "4000") |> String.to_integer()

import_config "#{Mix.env()}.exs"
