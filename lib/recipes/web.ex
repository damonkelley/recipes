defmodule Recipes.Web do
  use Plug.Router

  plug(Plug.Logger, log: :info)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  get "/" do
    body = %{data: %{name: "Recipes"}}

    send_resp(conn, 200, Jason.encode!(body))
  end

  get "/random" do
    body =
      Recipes.random(repo: Recipes.Repo)
      |> view()
      |> Jason.encode!()

    send_resp(conn, 200, body)
  end

  post "/recipes" do
    {:ok, recipe} = Recipes.add(conn.params, repo: Recipes.Repo)

    conn
    |> put_resp_header("location", "/recipes/#{recipe.id}")
    |> send_resp(201, "")
  end

  get "/recipes/:id" do
    %{"id" => id} = conn.path_params

    result = Recipes.find(%{id: id}, repo: Recipes.Repo)

    send_resp(conn, 200, Jason.encode!(view(result)))
  end

  def view({:error, errors}) do
    %{
      error: errors
    }
  end

  def view({:ok, recipe}) do
    %{
      data: %{
        name: recipe.name,
        href: recipe.href
      }
    }
  end
end
