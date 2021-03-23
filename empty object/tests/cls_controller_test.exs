defmodule AppnameWeb.Modulename.ClassnameControllerTest do
  use AppnameWeb.ConnCase

  alias Appname.Modulename
  alias Appname.ModulenameTestLib

  alias Appname.Helpers.GeneralTestLib
  setup do
    GeneralTestLib.conn_setup(~w(horizon.manage))
  end

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all classnames", %{conn: conn} do
      conn = get(conn, Routes.modulename_classname_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Classnames"
    end
  end

  describe "new classname" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.modulename_classname_path(conn, :new))
      assert html_response(conn, 200) =~ "Create"
    end
  end

  describe "create classname" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.modulename_classname_path(conn, :create), classname: @create_attrs)
      assert redirected_to(conn) == Routes.modulename_classname_path(conn, :index)

      new_classname = Modulename.list_classnames(search: [name: @create_attrs.name])
      assert Enum.count(new_classname) == 1
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.modulename_classname_path(conn, :create), classname: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong!"
    end
  end

  describe "show classname" do
    test "renders show page", %{conn: conn} do
      classname = ModulenameTestLib.classname_fixture()
      resp = get(conn, Routes.modulename_classname_path(conn, :show, classname))
      assert html_response(resp, 200) =~ "Edit classname"
    end

    test "renders show nil item", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, Routes.modulename_classname_path(conn, :show, -1))
      end
    end
  end

  describe "edit classname" do
    test "renders form for editing nil", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, Routes.modulename_classname_path(conn, :edit, -1))
      end
    end

    test "renders form for editing chosen classname", %{conn: conn} do
      classname = ModulenameTestLib.classname_fixture()
      conn = get(conn, Routes.modulename_classname_path(conn, :edit, classname))
      assert html_response(conn, 200) =~ "Save changes"
    end
  end

  describe "update classname" do
    test "redirects when data is valid", %{conn: conn} do
      classname = ModulenameTestLib.classname_fixture()
      conn = put(conn, Routes.modulename_classname_path(conn, :update, classname), classname: @update_attrs)
      assert redirected_to(conn) == Routes.modulename_classname_path(conn, :index)

      conn = get(conn, Routes.modulename_classname_path(conn, :show, classname))
      assert html_response(conn, 200) =~ "some updated"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      classname = ModulenameTestLib.classname_fixture()
      conn = put(conn, Routes.modulename_classname_path(conn, :update, classname), classname: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong!"
    end

    test "renders errors when nil object", %{conn: conn} do
      assert_error_sent 404, fn ->
        put(conn, Routes.modulename_classname_path(conn, :update, -1), classname: @invalid_attrs)
      end
    end
  end

  describe "delete classname" do
    test "deletes chosen classname", %{conn: conn} do
      classname = ModulenameTestLib.classname_fixture()
      conn = delete(conn, Routes.modulename_classname_path(conn, :delete, classname))
      assert redirected_to(conn) == Routes.modulename_classname_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.modulename_classname_path(conn, :show, classname))
      end
    end

    test "renders error for deleting nil item", %{conn: conn} do
      assert_error_sent 404, fn ->
        delete(conn, Routes.modulename_classname_path(conn, :delete, -1))
      end
    end
  end
end
