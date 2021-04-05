defmodule Appname.Modulename.Classname do
  use CentralWeb, :schema
  alias __MODULE__

  schema "modulename_classnames" do
    field :name, :string
    field :icon, :string
    field :colour, :string

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
    |> cast(params, [:name, :icon, :colour])
    |> validate_required([:name, :icon, :colour])
  end

  @spec changeset(Atom.t(), Plug.Conn.t(), Map.t()) :: Boolean.t()
  def authorize(_action, conn, _params), do: allow?(conn, "modulename")
end
