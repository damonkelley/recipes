defmodule Recipes.WebTest do
  use ExUnit.Case
  use Plug.Test

  alias Recipes.Web

  @opts Web.init([])

  @recipes [
    %{name: "Nashville Fried Chicken", href: "http://example.com/nashille-fried-chicken"},
    %{name: "Carnitas", href: "http://example.com/carinitas"}
  ]

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Recipes.Ecto.Repo)
  end

  test "greets the world" do
    json =
      conn(:get, "/")
      |> Web.call(@opts)
      |> json_response(200)

    assert %{
             "data" => %{
               "name" => "Recipes"
             }
           } = json
  end

  test "can return a random recipe" do
    conn(:post, "/recipes", List.first(@recipes))
    |> Web.call(@opts)

    json =
      conn(:get, "/random")
      |> Web.call(@opts)
      |> json_response(200)

    assert %{
             "data" => %{
               "name" => _,
               "href" => _
             }
           } = json
  end

  for %{name: name, href: href} <- @recipes do
    test "a recipe for #{name} can be added " do
      conn =
        conn(:post, "/recipes", %{name: unquote(name), href: unquote(href)})
        |> put_req_header("content-type", "application/json")
        |> Web.call(@opts)

      assert conn.resp_body == ""
      assert conn.status == 201

      [location | _] = get_resp_header(conn, "location")

      json =
        conn(:get, location)
        |> Web.call(@opts)
        |> json_response(200)

      assert %{
               "data" => %{
                 "name" => unquote(name),
                 "href" => unquote(href)
               }
             } = json
    end
  end

  def json_response(conn, status) do
    assert conn.status == status
    Jason.decode!(conn.resp_body)
  end
end
