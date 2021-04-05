defmodule Appname.Modulename.Classname do
  use CentralWeb, :schema
  alias __MODULE__

  @primary_key false
  schema "modulename_part1_part2s" do
    belongs_to :part1, Part1, primary_key: true
    belongs_to :part2, Part2, primary_key: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(Classname.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:part1_id, :part2_id])
    |> validate_required([:part1_id, :part2_id])
  end

  @spec changeset(Atom.t(), Plug.Conn.t(), Map.t()) :: Boolean.t()
  def authorize(_action, conn, _params), do: allow?(conn, "modulename")
end
