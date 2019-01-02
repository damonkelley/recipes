ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Recipes.Ecto.Repo, :manual)

defmodule TestRepo do
  use Agent

  alias Recipes.Recipe

  def start_link(initial) do
    Agent.start_link(fn -> initial end, name: __MODULE__)
  end

  def insert(%{} = entity) do
    id = Agent.get(__MODULE__, & &1) |> next_id()
    changeset = Recipes.Recipe.changeset(%Recipe{}, entity)

    if changeset.valid? do
      Agent.update(__MODULE__, fn state -> Map.put(state, id, Map.put(entity, :id, id)) end)
      get(%{id: id})
    else
      {:error, changeset.errors}
    end
  end

  def get(%{id: id}) do
    entity = Agent.get(__MODULE__, &Map.get(&1, id))
    {:ok, entity}
  end

  def all() do
    entities = Agent.get(__MODULE__, &Map.values(&1))

    case Enum.empty?(entities) do
      true -> {:error, "No results"}
      false -> {:ok, entities}
    end
  end

  def next_id(%{}), do: 1

  def next_id(rows) do
    last_id =
      rows
      |> Map.keys()
      |> Enum.sort()
      |> Enum.reverse()
      |> List.first()

    last_id + 1
  end
end
