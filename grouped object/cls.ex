defmodule Appname.Modulename.Classname do
  use CentralWeb, :schema

  schema "modulename_classnames" do
    field :name, :string
    field :icon, :string
    field :colour, :string
    belongs_to :group, Central.Account.Group

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(Classname.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    params = params
    |> trim_strings([:name])

    struct
    |> cast(params, [:name, :icon, :colour, :group_id])
    |> validate_required([:name, :icon, :colour, :group_id])
  end

  @spec changeset(Atom.t(), Plug.Conn.t(), Map.t()) :: Boolean.t()
  def authorize(_, conn, _), do: allow?(conn, "modulename")
end
