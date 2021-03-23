defmodule Appname.Modulename.Classname do
  use CentralWeb, :schema

  schema "modulename_classnames" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    params = params
    |> trim_strings([:name])

    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def authorize(_, conn, _), do: allow?(conn, "modulename")
end
