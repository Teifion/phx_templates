  alias Appname.Modulename.Classname
  alias Appname.Modulename.ClassnameLib

  @spec classname_query(List.t()) :: Ecto.Query.t()
  def classname_query(args) do
    classname_query(nil, args)
  end

  @spec classname_query(Integer.t(), List.t()) :: Ecto.Query.t()
  def classname_query(id, args) do
    ClassnameLib.query_classnames
    |> ClassnameLib.search(%{id: id})
    |> ClassnameLib.search(args[:search])
    |> ClassnameLib.preload(args[:preload])
    |> ClassnameLib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
  end

  @doc """
  Returns the list of classnames.

  ## Examples

      iex> list_classnames()
      [%Classname{}, ...]

  """
  @spec list_classnames(List.t()) :: List.t()
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
  @spec get_classname!(Integer.t() | List.t()) :: Classname.t()
  @spec get_classname!(Integer.t(), List.t()) :: Classname.t()
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
  @spec create_classname(Map.t()) :: {:ok, Classname.t()} | {:error, Ecto.Changeset.t()}
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
  @spec update_classname(Classname.t(), Map.t()) :: {:ok, Classname.t()} | {:error, Ecto.Changeset.t()}
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
  @spec delete_classname(Classname.t()) :: {:ok, Classname.t()} | {:error, Ecto.Changeset.t()}
  def delete_classname(%Classname{} = classname) do
    Repo.delete(classname)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking classname changes.

  ## Examples

      iex> change_classname(classname)
      %Ecto.Changeset{source: %Classname{}}

  """
  @spec change_classname(Classname.t()) :: Ecto.Changeset.t()
  def change_classname(%Classname{} = classname) do
    Classname.changeset(classname, %{})
  end
