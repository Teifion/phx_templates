defmodule Appname.Modulename.Classname do
  use CentralWeb, :schema

  schema "modulename_classnames" do
    field :name, :string
    field :icon, :string
    field :colour, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    params = params
    |> trim_strings([:name])

    struct
    |> cast(params, [:name, :icon, :colour])
    |> validate_required([:name, :icon, :colour])
  end

  def authorize(_, conn, _), do: allow?(conn, "modulename")
end
