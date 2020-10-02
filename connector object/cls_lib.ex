defmodule Appname.Modulename.Part1Part2Lib do
  use CentralWeb, :library
  alias Appname.Modulename.Part1Part2

  # Queries  
  @spec get_part1_part2s() :: Ecto.Query.t
  def get_part1_part2s do
    from part1_part2s in Part1Part2
  end

  @spec search(Ecto.Query.t, Map.t | nil) :: Ecto.Query.t
  def search(query, nil), do: query
  def search(query, params) do
    params
    |> Enum.reduce(query, fn ({key, value}, query_acc) ->
      _search(query_acc, key, value)
    end)
  end

  def _search(query, _, ""), do: query
  def _search(query, _, nil), do: query

  def _search(query, :part1_id, part1_id) do
    from part1_part2s in query,
      where: part1_part2s.part1_id == ^part1_id
  end

  def _search(query, :part2_id, part2_id) do
    from part1_part2s in query,
      where: part1_part2s.part2_id == ^part2_id
  end
end
