  alias Appname.Modulename.Classname
  alias Appname.Modulename.ClassnameLib
  
  defp classname_query(args) do
    classname_query(nil, args)
  end

  defp classname_query(id, args) do
    ClassnameLib.get_classnames
    |> ClassnameLib.search(%{id: id})
    |> ClassnameLib.search(args[:search])
    |> ClassnameLib.preload(args[:joins])
    |> ClassnameLib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
  end
  
  @doc """
  Returns the list of classnames.

  ## Examples

      iex> list_classnames()
      [%Classname{}, ...]

  """
  def list_classnames(args \\ []) do
    classname_query(args)
    |> QueryHelpers.limit_query(args[:limit] || 50)
    |> Repo.all
  end

  @doc """
  Gets a single classname.

  Raises `Ecto.NoResultsError` if the Classname does not exist.

  ## Examples

      iex> get_classname!(123)
      %Classname{}

      iex> get_classname!(456)
      ** (Ecto.NoResultsError)

  """
  def get_classname!(id) when not is_list(id) do
    classname_query(id, [])
    |> Repo.one!
  end
  def get_classname!(args) do
    classname_query(nil, args)
    |> Repo.one!
  end
  def get_classname!(id, args) do
    classname_query(id, args)
    |> Repo.one!
  end

  # Uncomment this if needed, default files do not need this function
  # @doc """
  # Gets a single classname.

  # Returns `nil` if the Classname does not exist.

  # ## Examples

  #     iex> get_classname(123)
  #     %Classname{}

  #     iex> get_classname(456)
  #     nil

  # """
  # def get_classname(id, args \\ []) when not is_list(id) do
  #   classname_query(id, args)
  #   |> Repo.one
  # end

  @doc """
  Creates a classname.

  ## Examples

      iex> create_classname(%{field: value})
      {:ok, %Classname{}}

      iex> create_classname(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_classname(attrs \\ %{}) do
    %Classname{}
    |> Classname.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a classname.

  ## Examples

      iex> update_classname(classname, %{field: new_value})
      {:ok, %Classname{}}

      iex> update_classname(classname, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_classname(%Classname{} = classname, attrs) do
    classname
    |> Classname.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Classname.

  ## Examples

      iex> delete_classname(classname)
      {:ok, %Classname{}}

      iex> delete_classname(classname)
      {:error, %Ecto.Changeset{}}

  """
  def delete_classname(%Classname{} = classname) do
    Repo.delete(classname)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking classname changes.

  ## Examples

      iex> change_classname(classname)
      %Ecto.Changeset{source: %Classname{}}

  """
  def change_classname(%Classname{} = classname) do
    Classname.changeset(classname, %{})
  end