defmodule Appname.Modulename.ClassnameLib do
  use CentralWeb, :library
  alias Appname.Modulename.Classname

  # Functions
  @spec icon :: String.t()
  def icon, do: "far fa-???"
  @spec colours :: {String.t(), String.t(), String.t()}
  def colours, do: Central.Helpers.StylingHelper.colours(:default)

  @spec make_favourite :: Map.t()
  def make_favourite(classname) do
    %{
      type_colour: colours() |> elem(0),
      type_icon: icon(),

      item_id: classname.id,
      item_type: "appname_modulename_classname",
      item_colour: classname.colour,
      item_icon: classname.icon,
      item_label: "#{classname.name}",

      url: "/modulename/classnames/#{classname.id}"
    }
  end

  # Queries
  @spec query_classnames() :: Ecto.Query.t
  def query_classnames do
    from classnames in Classname
  end

  @spec search(Ecto.Query.t, Map.t | nil) :: Ecto.Query.t
  def search(query, nil), do: query
  def search(query, params) do
    params
    |> Enum.reduce(query, fn ({key, value}, query_acc) ->
      _search(query_acc, key, value)
    end)
  end

  @spec _search(Ecto.Query.t, Atom.t(), any()) :: Ecto.Query.t
  def _search(query, _, ""), do: query
  def _search(query, _, nil), do: query

  def _search(query, :id, id) do
    from classnames in query,
      where: classnames.id == ^id
  end

  def _search(query, :name, name) do
    from classnames in query,
      where: classnames.name == ^name
  end

  def _search(query, :id_list, id_list) do
    from classnames in query,
      where: classnames.id in ^id_list
  end

  def _search(query, :simple_search, ref) do
    ref_like = "%" <> String.replace(ref, "*", "%") <> "%"

    from classnames in query,
      where: (
            ilike(classnames.name, ^ref_like)
        )
  end

  @spec order_by(Ecto.Query.t, String.t | nil) :: Ecto.Query.t
  def order_by(query, nil), do: query
  def order_by(query, "Name (A-Z)") do
    from classnames in query,
      order_by: [asc: classnames.name]
  end

  def order_by(query, "Name (Z-A)") do
    from classnames in query,
      order_by: [desc: classnames.name]
  end

  def order_by(query, "Newest first") do
    from classnames in query,
      order_by: [desc: classnames.inserted_at]
  end

  def order_by(query, "Oldest first") do
    from classnames in query,
      order_by: [asc: classnames.inserted_at]
  end

  @spec preload(Ecto.Query.t, List.t | nil) :: Ecto.Query.t
  def preload(query, nil), do: query
  def preload(query, _preloads) do
    # query = if :things in preloads, do: _preload_things(query), else: query
    query
  end

  # def _preload_things(query) do
  #   from classnames in query,
  #     left_join: things in assoc(classnames, :things),
  #     preload: [things: things]
  # end
end
