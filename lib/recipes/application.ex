defmodule Recipes.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Recipes.Web,
        options: [port: Application.get_env(:recipes, :port)]
      ),
      Recipes.Ecto.Repo
    ]

    opts = [strategy: :one_for_one, name: Recipes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
