defmodule Recipes.Web do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    body = %{data: %{name: "Recipes"}}

    send_resp(conn, 200, Jason.encode!(body))
  end

  get "/random" do
    body = %{
      data: %{
        name: "Test recipe",
        href: "http://example.com/recipe1"
      }
    }

    result = Recipes.random(repo: Recipes.Repo)

    send_resp(conn, 200, result |> view() |> Jason.encode!())
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
