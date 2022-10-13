defmodule AppnameWeb.Modulename.ClassnameController do
  @moduledoc false
  use AppnameWeb, :controller

  alias Appname.Modulename
  alias Appname.Modulename.{Classname, ClassnameLib}

  plug Bodyguard.Plug.Authorize,
    policy: Appname.Modulename.Classname,
    action: {Phoenix.Controller, :action_name},
    user: {Appname.Account.AuthLib, :current_user}

  plug(AssignPlug,
    site_menu_active: "modulename",
    sub_menu_active: "classname"
  )

  plug :add_breadcrumb, name: 'Modulename', url: '/appname'
  plug :add_breadcrumb, name: 'Classnames', url: '/appname/classnames'

  @spec index(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def index(conn, params) do
    classnames = Modulename.list_classnames(
      search: [
        basic_search: Map.get(params, "s", "") |> String.trim,
      ],
      order_by: "Name (A-Z)"
    )

    conn
    |> assign(:classnames, classnames)
    |> render("index.html")
  end

  @spec show(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id, [
      joins: [],
    ])

    classname
    |> ClassnameLib.make_favourite
    |> insert_recently(conn)

    conn
    |> assign(:classname, classname)
    |> add_breadcrumb(name: "Show: #{classname.name}", url: conn.request_path)
    |> render("show.html")
  end

  @spec new(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Modulename.change_classname(%Classname{})

    conn
    |> assign(:changeset, changeset)
    |> add_breadcrumb(name: "New classname", url: conn.request_path)
    |> render("new.html")
  end

  @spec create(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def create(conn, %{"classname" => classname_params}) do
    case Modulename.create_classname(classname_params) do
      {:ok, _classname} ->
        conn
        |> put_flash(:info, "Classname created successfully.")
        |> redirect(to: Routes.appname_classname_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  @spec edit(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id)

    changeset = Modulename.change_classname(classname)

    conn
    |> assign(:classname, classname)
    |> assign(:changeset, changeset)
    |> add_breadcrumb(name: "Edit: #{classname.name}", url: conn.request_path)
    |> render("edit.html")
  end

  @spec update(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "classname" => classname_params}) do
    classname = Modulename.get_classname!(id)

    case Modulename.update_classname(classname, classname_params) do
      {:ok, _classname} ->
        conn
        |> put_flash(:info, "Classname updated successfully.")
        |> redirect(to: Routes.appname_classname_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign(:classname, classname)
        |> assign(:changeset, changeset)
        |> render("edit.html")
    end
  end

  @spec delete(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id)

    classname
    |> ClassnameLib.make_favourite
    |> remove_recently(conn)

    {:ok, _classname} = Modulename.delete_classname(classname)

    conn
    |> put_flash(:info, "Classname deleted successfully.")
    |> redirect(to: Routes.appname_classname_path(conn, :index))
  end
end
