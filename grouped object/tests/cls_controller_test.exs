defmodule AppnameWeb.Modulename.ClassnameControllerTest do
  @moduledoc false
  use AppnameWeb.ConnCase

  alias Appname.Modulename
  alias Appname.ModulenameTestLib

  alias Appname.Helpers.GeneralTestLib
  setup do
    GeneralTestLib.conn_setup(~w(horizon.manage))
  end

  @create_attrs %{colour: "some colour", icon: "far fa-home", name: "some name"}
  @update_attrs %{colour: "some updated colour", icon: "fas fa-wrench", name: "some updated name"}
  @invalid_attrs %{colour: nil, icon: nil, name: nil, group_id: nil}

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
    test "redirects to show when data is valid", %{conn: conn, child_group: child_group} do
      conn = post(conn, Routes.modulename_classname_path(conn, :create), classname: Map.put(@create_attrs, :group_id, child_group.id))
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
    test "renders show page", %{conn: conn, main_group: main_group} do
      classname = ModulenameTestLib.classname_fixture(main_group.id)
      resp = get(conn, Routes.modulename_classname_path(conn, :show, classname))
      assert html_response(resp, 200) =~ "Edit classname"
    end

    test "renders show secured classname", %{conn: conn, parent_group: parent_group} do
      classname = ModulenameTestLib.classname_fixture(parent_group.id)
      resp = get conn, Routes.modulename_classname_path(conn, :show, classname)
      assert resp.private[:phoenix_flash]["warning"] == "Unable to access this classname"
      assert redirected_to(resp) == Routes.modulename_classname_path(conn, :index)
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

    test "renders form for editing chosen classname", %{conn: conn, main_group: main_group} do
      classname = ModulenameTestLib.classname_fixture(main_group.id)
      conn = get(conn, Routes.modulename_classname_path(conn, :edit, classname))
      assert html_response(conn, 200) =~ "Save changes"
    end

    test "renders form for editing secured classname", %{conn: conn, parent_group: parent_group} do
      classname = ModulenameTestLib.classname_fixture(parent_group.id)
      resp = get conn, Routes.modulename_classname_path(conn, :edit, classname)
      assert resp.private[:phoenix_flash]["warning"] == "Unable to access this classname"
      assert redirected_to(resp) == Routes.modulename_classname_path(conn, :index)
    end
  end

  describe "update classname" do
    test "redirects when data is valid", %{conn: conn, main_group: main_group} do
      classname = ModulenameTestLib.classname_fixture(main_group.id)
      conn = put(conn, Routes.modulename_classname_path(conn, :update, classname), classname: Map.put(@update_attrs, :group_id, main_group.id))
      assert redirected_to(conn) == Routes.modulename_classname_path(conn, :index)

      conn = get(conn, Routes.modulename_classname_path(conn, :show, classname))
      assert html_response(conn, 200) =~ "some updated colour"
    end

    test "renders when updating secured classname", %{conn: conn, parent_group: parent_group} do
      classname = ModulenameTestLib.classname_fixture(parent_group.id)
      resp = put(conn, Routes.modulename_classname_path(conn, :update, classname), classname: Map.put(@update_attrs, :group_id, parent_group.id))
      assert resp.private[:phoenix_flash]["warning"] == "Unable to access this classname"
      assert redirected_to(resp) == Routes.modulename_classname_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn, main_group: main_group} do
      classname = ModulenameTestLib.classname_fixture(main_group.id)
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
    test "deletes chosen classname", %{conn: conn, main_group: main_group} do
      classname = ModulenameTestLib.classname_fixture(main_group.id)
      conn = delete(conn, Routes.modulename_classname_path(conn, :delete, classname))
      assert redirected_to(conn) == Routes.modulename_classname_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.modulename_classname_path(conn, :show, classname))
      end
    end

    test "renders when deleting secured classname", %{conn: conn, parent_group: parent_group} do
      classname = ModulenameTestLib.classname_fixture(parent_group.id)
      resp = delete conn, Routes.modulename_classname_path(conn, :delete, classname)
      assert resp.private[:phoenix_flash]["warning"] == "Unable to access this classname"
      assert redirected_to(resp) == Routes.modulename_classname_path(conn, :index)
    end

    test "renders error for deleting nil item", %{conn: conn} do
      assert_error_sent 404, fn ->
        delete(conn, Routes.modulename_classname_path(conn, :delete, -1))
      end
    end
  end
end
