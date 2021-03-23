
  describe "classnames" do
    alias Appname.Modulename.Classname

    @valid_attrs %{"name" => "some name"}
    @update_attrs %{"name" => "some updated name"}
    @invalid_attrs %{"name" => nil}

    test "list_classnames/0 returns classnames" do
      ModulenameTestLib.classname_fixture(1)
      assert Modulename.list_classnames() != []
    end

    test "get_classname!/1 returns the classname with given id" do
      classname = ModulenameTestLib.classname_fixture(1)
      assert Modulename.get_classname!(classname.id) == classname
    end

    test "create_classname/1 with valid data creates a classname" do
      assert {:ok, %Classname{} = classname} = Modulename.create_classname(@valid_attrs)
      assert classname.name == "some name"
    end

    test "create_classname/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Modulename.create_classname(@invalid_attrs)
    end

    test "update_classname/2 with valid data updates the classname" do
      classname = ModulenameTestLib.classname_fixture(1)
      assert {:ok, %Classname{} = classname} = Modulename.update_classname(classname, @update_attrs)
      assert classname.name == "some updated name"
    end

    test "update_classname/2 with invalid data returns error changeset" do
      classname = ModulenameTestLib.classname_fixture(1)
      assert {:error, %Ecto.Changeset{}} = Modulename.update_classname(classname, @invalid_attrs)
      assert classname == Modulename.get_classname!(classname.id)
    end

    test "delete_classname/1 deletes the classname" do
      classname = ModulenameTestLib.classname_fixture(1)
      assert {:ok, %Classname{}} = Modulename.delete_classname(classname)
      assert_raise Ecto.NoResultsError, fn -> Modulename.get_classname!(classname.id) end
    end

    test "change_classname/1 returns a classname changeset" do
      classname = ModulenameTestLib.classname_fixture(1)
      assert %Ecto.Changeset{} = Modulename.change_classname(classname)
    end
  end
