  alias Appname.Modulename.Part1Part2
  alias Appname.Modulename.Part1Part2Lib
  @doc """
  Returns the list of part1_part2s.

  ## Examples

      iex> list_part1_part2s()
      [%Location{}, ...]

  """
  @spec list_part1_part2s_by_part1(Integer.t()) :: List.t()
  @spec list_part1_part2s_by_part1(Integer.t(), List.t()) :: List.t()
  def list_part1_part2s_by_part1(part1_id, args \\ []) do
    Part1Part2Lib.get_part1_part2s
    |> Part1Part2Lib.search([part1_id: part1_id])
    |> Part1Part2Lib.search(args[:search])
    |> Part1Part2Lib.preload(args[:joins])
    |> Part1Part2Lib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
    |> Repo.all
  end

  @spec list_part1_part2s_by_part2(Integer.t()) :: List.t()
  @spec list_part1_part2s_by_part2(Integer.t(), List.t()) :: List.t()
  def list_part1_part2s_by_part2(part2_id, args \\ []) do
    Part1Part2Lib.get_part1_part2s
    |> Part1Part2Lib.search([part2_id: part2_id])
    |> Part1Part2Lib.search(args[:search])
    |> Part1Part2Lib.preload(args[:joins])
    |> Part1Part2Lib.order_by(args[:order_by])
    |> QueryHelpers.select(args[:select])
    |> Repo.all
  end

  @doc """
  Gets a single part1_part2.

  Raises `Ecto.NoResultsError` if the Part1Part2 does not exist.

  ## Examples

      iex> get_part1_part2!(123)
      %Part1Part2{}

      iex> get_part1_part2!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_part1_part2(Integer.t(), Integer.t()) :: Part1Part2.t()
  def get_part1_part2!(part1_id, part2_id) do
    Part1Part2Lib.get_part1_part2s
    |> Part1Part2Lib.search(%{part1_id: part1_id, part2_id: part2_id})
    |> Repo.one!
  end

  @doc """
  Creates a part1_part2.

  ## Examples

      iex> create_part1_part2(%{field: value})
      {:ok, %Part1Part2{}}

      iex> create_part1_part2(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec get_part1_part2(Map.t()) :: {:ok, Part1Part2.t()} | {:error, Ecto.Changeset.t()}
  def create_part1_part2(attrs) do
    %Part1Part2{}
    |> Part1Part2.changeset(attrs)
    |> Repo.insert()
  end

  @spec get_part1_part2(Integer.t(), Integer.t()) :: {:ok, Part1Part2.t()} | {:error, Ecto.Changeset.t()}
  def create_part1_part2(part1_id, part2_id) do
    %Part1Part2{}
    |> Part1Part2.changeset(%{
      part1_id: part1_id,
      part2_id: part2_id
    })
    |> Repo.insert()
  end

  @doc """
  Updates a Part1Part2.

  ## Examples

      iex> update_part1_part2(part1_part2, %{field: new_value})
      {:ok, %Part1Part2{}}

      iex> update_part1_part2(part1_part2, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_part1_part2(Part1Part2.t(), Map.t()) :: {:ok, Part1Part2.t()} | {:error, Ecto.Changeset.t()}
  def update_part1_part2(%Part1Part2{} = part1_part2, attrs) do
    part1_part2
    |> Part1Part2.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Part1Part2.

  ## Examples

      iex> delete_part1_part2(part1_part2)
      {:ok, %Part1Part2{}}

      iex> delete_part1_part2(part1_part2)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_part1_part2(Part1Part2.t()) :: {:ok, Part1Part2.t()} | {:error, Ecto.Changeset.t()}
  def delete_part1_part2(%Part1Part2{} = part1_part2) do
    Repo.delete(part1_part2)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking part1_part2 changes.

  ## Examples

      iex> change_part1_part2(part1_part2)
      %Ecto.Changeset{source: %Part1Part2{}}

  """
  @spec change_part1_part2(Part1Part2.t()) :: Ecto.Changeset.t()
  def change_part1_part2(%Part1Part2{} = part1_part2) do
    Part1Part2.changeset(part1_part2, %{})
  end
